const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path');
const cors = require('cors');
const nodemailer = require('nodemailer');
const http = require('http');
const WebSocket = require('ws');

const app = express();
const PORT = 3000;
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

function notifyClients() {
    wss.clients.forEach(client => {
        if (client.readyState === WebSocket.OPEN) {
            client.send('update');
        }
    });
}

app.post('/update-json', (req, res) => {
    const newData = req.body;
    const filePath = path.join(__dirname, '/json/users.json');
    console.log(filePath)

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        let jsonData;
        try {
            jsonData = JSON.parse(data);
        } catch (parseError) {
            console.error('Error parsing JSON:', parseError);
            return res.status(500).send('Error parsing JSON');
        }

        jsonData.push(newData);

        fs.writeFile(filePath, JSON.stringify(jsonData, null, 2), 'utf8', (writeErr) => {
            if (writeErr) {
                console.error('Error writing file:', writeErr);
                return res.status(500).send('Error writing file');
            }

            console.log('JSON data updated successfully');
            notifyClients();
            res.send('JSON data updated successfully');
        });
    });
});

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'a0937430721@gmail.com',
        pass: '123'
    }
});

let email;

app.post('/send-email', (req, res) => {
    email = req.body.email;
    const randomCode = generateRandomCode(6);

    const mailOptions = {
        from: 'a0937430721@gmail.com',
        to: email,
        subject: '會議室預約系統 一次性驗證碼通知',
        text: `您的驗證碼為: ${randomCode}`
    };

    /*transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            console.error('Error sending email:', error);
            return res.status(500).send('Error sending email');
        } else {
            console.log('Email sent:', info.response);

            filePath = path.join(__dirname, '/json/users.json');

            fs.readFile(filePath, 'utf8', (err, data) => {
                if (err) {
                    console.error('Error reading file:', err);
                    return res.status(500).send('Error reading file');
                }

                let users;
                try {
                    users = JSON.parse(data);
                } catch (parseError) {
                    console.error('Error parsing JSON:', parseError);
                    return res.status(500).send('Error parsing JSON');
                }

                let user = users.find(user => user.email === email);
                if (user) {
                    user.verificationCode = randomCode;
                } else {
                    users.push({ email: email, verificationCode: randomCode });
                }


                fs.writeFile(filePath, JSON.stringify(users, null, 2), 'utf8', (writeErr) => {
                    if (writeErr) {
                        console.error('Error writing file:', writeErr);
                        return res.status(500).send('Error writing file');
                    }

                    console.log('Verification code saved successfully');
                    return res.json({ code: randomCode });
                });
            });
        }
    });*/
});

function generateRandomCode(length) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    let randomCode = '';

    for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * charset.length);
        randomCode += charset[randomIndex];
    }

    return randomCode;
}

app.post('/reset-password', (req, res) => {
    const { code, newPassword } = req.body;

    // Path to the JSON file
    const filePath = path.join(__dirname, 'json', 'users.json');

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        let users;
        try {
            users = JSON.parse(data);
        } catch (parseError) {
            console.error('Error parsing JSON:', parseError);
            return res.status(500).send('Error parsing JSON');
        }

        const userWithEmail = users.find(user => user.verificationCode === code);
        const email = userWithEmail ? userWithEmail.email : undefined;

        if (!email) {
            return res.status(400).send('Invalid verification code');
        }

        const user = users.find(user => user.email === email);
        if (user) {
            user.password = newPassword;
            user.verificationCode = '';
        } else {
            return res.status(400).send('User not found');
        }

        fs.writeFile(filePath, JSON.stringify(users, null, 2), 'utf8', (writeErr) => {
            if (writeErr) {
                console.error('Error writing file:', writeErr);
                return res.status(500).send('Error writing file');
            }

            console.log('Password updated successfully');
            return res.send('Password updated successfully');
        });
    });
});

app.post('/update-room-reservation-status', (req, res) => {
    const { room, date, startTime, endTime, status } = req.body;
    const filePath = path.join(__dirname, 'json/room_reservation.json');

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        let reservations = JSON.parse(data);


        reservations.forEach(reservation => {
            if (reservation.room === room && reservation.date === date && reservation.startTime === startTime && reservation.endTime === endTime) {
                reservation.status = status;
            }
        })

        fs.writeFile(filePath, JSON.stringify(reservations, null, 2), (err) => {
            if (err) {
                console.error('Error writing file:', err);
                return res.status(500).send('Error writing file');
            }

            notifyClients();
            res.json({ message: 'Status updated successfully' });
        });
    });
});

app.post('/delete-room-reservation', (req, res) => {
    const { user, date, startTime, endTime, name, address, status } = req.body;
    const filePath = path.join(__dirname, 'json/room_reservation.json');

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        let reservations = JSON.parse(data);

        fs.writeFile(filePath, JSON.stringify(reservations, null, 2), (err) => {
            if (err) {
                console.error('Error writing file:', err);
                return res.status(500).send('Error writing file');
            }

            notifyClients();
            res.json({ message: 'Status updated successfully' });
        });
    });
});

app.post('/delete-equip-reservation', (req, res) => {
    const { user, date, startTime, endTime, equipment, status } = req.body;
    const filePath = path.join(__dirname, 'json/equip_reservation.json');
    console.log(user, date, startTime, endTime, equipment, status);

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        let reservations = JSON.parse(data);

        fs.writeFile(filePath, JSON.stringify(reservations, null, 2), (err) => {
            if (err) {
                console.error('Error writing file:', err);
                return res.status(500).send('Error writing file');
            }

            notifyClients();
            res.json({ message: 'Status updated successfully' });
        });
    });
});

app.post('/delete-user', (req, res) => {
    const { name, email, password, permission } = req.body;
    const filePath = path.join(__dirname, 'json/users.json');

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        let users = JSON.parse(data);

        fs.writeFile(filePath, JSON.stringify(users, null, 2), (err) => {
            if (err) {
                console.error('Error writing file:', err);
                return res.status(500).send('Error writing file');
            }

            notifyClients();
            res.json({ message: 'Status updated successfully' });
        });
    });
});

app.post('/add-user', (req, res) => {
    const { name, email, password, permission } = req.body;
    const filePath = path.join(__dirname, 'json/users.json');
    console.log(name, email, password, permission);

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        let users = JSON.parse(data);

        fs.writeFile(filePath, JSON.stringify(users, null, 2), (err) => {
            if (err) {
                console.error('Error writing file:', err);
                return res.status(500).send('Error writing file');
            }

            notifyClients();
            res.json({ message: 'Status updated successfully' });
        });
    });
});

app.post('/modify-user', (req, res) => {
    const { name, email, password, permission } = req.body;
    const filePath = path.join(__dirname, 'json/users.json');

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        let users = JSON.parse(data);

        fs.writeFile(filePath, JSON.stringify(users, null, 2), (err) => {
            if (err) {
                console.error('Error writing file:', err);
                return res.status(500).send('Error writing file');
            }

            notifyClients();
            res.json({ message: 'Status updated successfully' });
        });
    });
});

app.post('/modify-room-reservation', (req, res) => {
    const { user, date, startTime, endTime, name, address, status } = req.body;
    const filePath = path.join(__dirname, 'json/room_reservation.json');

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        let reservations = JSON.parse(data);


        fs.writeFile(filePath, JSON.stringify(reservations, null, 2), (err) => {
            if (err) {
                console.error('Error writing file:', err);
                return res.status(500).send('Error writing file');
            }

            notifyClients();
            res.json({ message: 'Status updated successfully' });
        });
    });
});

app.post('/modify-equip-reservation', (req, res) => {
    const { user, date, startTime, endTime, equipment, status } = req.body;
    const filePath = path.join(__dirname, 'json/room_reservation.json');

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        let reservations = JSON.parse(data);


        fs.writeFile(filePath, JSON.stringify(reservations, null, 2), (err) => {
            if (err) {
                console.error('Error writing file:', err);
                return res.status(500).send('Error writing file');
            }

            notifyClients();
            res.json({ message: 'Status updated successfully' });
        });
    });
});

app.get('/room-reservation', (req, res) => {
    const filePath = path.join(__dirname, 'json', 'room_reservation.json');
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        try {
            const reservations = JSON.parse(data);
            res.json(reservations);
        } catch (parseError) {
            console.error('Error parsing JSON:', parseError);
            return res.status(500).send('Error parsing JSON');
        }
    });
});

app.get('/equip-reservation', (req, res) => {
    const filePath = path.join(__dirname, 'json', 'equip_reservation.json');
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        try {
            const reservations = JSON.parse(data);
            res.json(reservations);
        } catch (parseError) {
            console.error('Error parsing JSON:', parseError);
            return res.status(500).send('Error parsing JSON');
        }
    });
});

app.get('/user', (req, res) => {
    const filePath = path.join(__dirname, 'json', 'users.json');
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        try {
            const userData = JSON.parse(data);
            res.json(userData);
        } catch (parseError) {
            console.error('Error parsing JSON:', parseError);
            return res.status(500).send('Error parsing JSON');
        }
    });
});

// 要做修改，改成符合搜尋條件的會議室
app.post('/search-meeting-room', (req, res) => {
    const { city, date, startTime, endTime, min, max } = req.body;
    const reservationfilePath = path.join(__dirname, 'json', 'meeting_room.json');
    const meetingRoomfilePath = path.join(__dirname, 'json', 'room_reservation.json');

    fs.readFile(reservationfilePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        try {
            const reservations = JSON.parse(data);
            res.json(reservations);
        } catch (parseError) {
            console.error('Error parsing reservation JSON:', parseError);
            return res.status(500).send('Error parsing reservation JSON');
        }
    });
});

// 要做修改，改成符合搜尋條件的設備
app.post('/search-equipment', (req, res) => {
    const { name, date, startTime, endTime } = req.body;
    const reservationfilePath = path.join(__dirname, 'json', 'equipment.json');
    const meetingRoomfilePath = path.join(__dirname, 'json', 'equip_reservation.json');

    fs.readFile(reservationfilePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        try {
            const reservations = JSON.parse(data);
            res.json(reservations);
        } catch (parseError) {
            console.error('Error parsing reservation JSON:', parseError);
            return res.status(500).send('Error parsing reservation JSON');
        }
    });
});

app.get('/meeting-room', (req, res) => {
    const filePath = path.join(__dirname, 'json', 'meeting_room.json');
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        try {
            const reservations = JSON.parse(data);
            res.json(reservations);
        } catch (parseError) {
            console.error('Error parsing JSON:', parseError);
            return res.status(500).send('Error parsing JSON');
        }
    });
});

app.get('/equipment', (req, res) => {
    const filePath = path.join(__dirname, 'json', 'equipment.json');
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        try {
            const reservations = JSON.parse(data);
            res.json(reservations);
        } catch (parseError) {
            console.error('Error parsing JSON:', parseError);
            return res.status(500).send('Error parsing JSON');
        }
    });
});

// 只將預約的日期、時間傳過來
app.post('/add-new-room-reservation', (req, res) => {
    const {reservationInfo, date, startTime, endTime} = req.body;

    console.log(reservationInfo, date, startTime, endTime);

    const meetingRoomfilePath = path.join(__dirname, 'json', 'meeting_room.json');
    const reservationfilePath = path.join(__dirname, 'json', 'room_reservation.json');

    fs.readFile(meetingRoomfilePath, 'utf8', (err, meetingRoomData) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        const rooms = JSON.parse(meetingRoomData);
        const room = rooms.find(room => room.name === reservationInfo);
        if(room) {
            const newReservation = {
                date: date,
                startTime: startTime,
                endTime: endTime,
                name: room.name,
                address: room.address,
                status: '已結束'
            };

            fs.readFile(reservationfilePath, 'utf8', (err, reservationData) => {
                const data = JSON.parse(reservationData);
                data.push(newReservation);
                console.log(data);
                // fs.writeFile(meetingRoomfilePath, JSON.stringify(rooms, null, 2), 'utf8', (writeErr) => {
                //     if (writeErr) {
                //         console.error('Error writing file:', writeErr);
                //         return res.status(500).send('Error writing file');
                //     }
                //     console.log('Room updated successfully');
                //     return res.send('Room updated successfully');
                // });
            });
        }
    });
});

app.post('/add-new-equip-reservation', (req, res) => {
    const {reservationInfo, date, startTime, endTime} = req.body;

    console.log(reservationInfo, date, startTime, endTime);

    const equipfilePath = path.join(__dirname, 'json', 'equipment.json');
    const reservationfilePath = path.join(__dirname, 'json', 'equip_reservation.json');

    fs.readFile(equipfilePath, 'utf8', (err, equipData) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Error reading file');
        }

        const rooms = JSON.parse(equipData);
        const equip = rooms.find(equip => equip.name === reservationInfo);
        if(equip) {
            const newReservation = {
                date: date,
                startTime: startTime,
                endTime: endTime,
                name: equip.name,
                status: '已歸還'
            };

            fs.readFile(reservationfilePath, 'utf8', (err, reservationData) => {
                const data = JSON.parse(reservationData);
                data.push(newReservation);
                console.log(data);
                // fs.writeFile(meetingRoomfilePath, JSON.stringify(rooms, null, 2), 'utf8', (writeErr) => {
                //     if (writeErr) {
                //         console.error('Error writing file:', writeErr);
                //         return res.status(500).send('Error writing file');
                //     }
                //     console.log('Room updated successfully');
                //     return res.send('Room updated successfully');
                // });
            });
        }
    });
});

wss.on('connection', ws => {
    console.log('Client connected');
    ws.on('close', () => console.log('Client disconnected'));
});

server.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});

// app.listen(PORT, () => {
//     console.log(`Server is running on http://localhost:${PORT}`);
// });
