<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="會議室預約系統" />
        <meta name="author" content="" />
        <title>會議室預約系統</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>
    <body id="page-top" class="reservationTable">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="#page-top"><img src="/program/assets/img/navbar-logo.svg" alt="..." /></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    清單
                    <i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link" href="#myRoomReservation">我的會議室預定</a></li>
                        <li class="nav-item"><a class="nav-link" href="#myEquipReservation">我的設備預定</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <header class="masthead">
            <div class="container">
                <!-- <div class="masthead-subheading">歡迎來到會議室預約系統</div>
                <a class="btn btn-primary btn-xl text-uppercase" href="#services">更多</a> -->
            </div>
        </header>
        <!-- My reservation-->
        <section class="page-section" id="myRoomReservation">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">我的預定-會議室</h2>
                </div>
                <table class="table text-center">
                    <thead>
                        <tr>
                            <th scope="col" class="col-0">#</th>
                            <th scope="col">日期</th>
                            <th scope="col">開始時間</th>
                            <th scope="col">結束時間</th>
                            <th scope="col" class="col-3">會議室</th>
                            <th scope="col">狀態</th>
                            <th scope="col">取消預約</th>
                        </tr>
                    </thead>
                    <tbody id="myReservationTable-room">
                        <!-- <tr>
                            <td>1</td>
                            <td>2024/10/10</td>
                            <td>10:00</td>
                            <td>18:00</td>
                            <td>臺南市中西區友愛街3號1樓-102房</td>
                            <td>尚未結束</td>
                            <td><button class="btn btn-secondary btn-l" onclick="deleteRow(this)">取消</button></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>2024/10/10</td>
                            <td>10:00</td>
                            <td>18:00</td>
                            <td>臺南市中西區-102房</td>
                            <td>尚未結束</td>
                            <td><button class="btn btn-secondary btn-l" onclick="deleteRow(this)">取消</button></td>
                        </tr> -->
                    </tbody>
                </table>
                <div id="pagination" class="text-center  mb-6"></div>
        </section>
        <section class="page-section" id="myEquipReservation">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">我的預定-設備</h2>
                </div>
                <table class="table text-center">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">日期</th>
                            <th scope="col">開始時間</th>
                            <th scope="col">結束時間</th>
                            <th scope="col" class="col-3">設備</th>
                            <th scope="col">狀態</th>
                            <th scope="col">取消預約</th>
                        </tr>
                    </thead>
                    <tbody id="myReservationTable-equip">
                        <tr>
                            <!-- <td>1</td>
                            <td>2024/10/10</td>
                            <td>10:00</td>
                            <td>18:00</td>
                            <td>麥克風</td>
                            <td>尚未歸還</td>
                            <td><button class="btn btn-secondary btn-l" onclick="deleteRow(this)">取消</button></td> -->
                        </tr>
                    </tbody>
                </table>
                <div id="pagination-equip" class="text-center"></div>
            </div>
        </div>
        </section>
        <!-- Footer-->
        <footer class="footer py-4">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-4 text-lg-start">版權所有 © 會議室預約系統 2024</div>
                    <div class="col-lg-4 my-3 my-lg-0">
                        <a class="btn btn-dark btn-social mx-2" href="#!" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                        <a class="btn btn-dark btn-social mx-2" href="#!" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-dark btn-social mx-2" href="#!" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                    <div class="col-lg-4 text-lg-end">
                        <a class="link-dark text-decoration-none me-3" href="#!">隱私政策</a>
                        <a class="link-dark text-decoration-none" href="#!">服務條款</a>
                    </div>
                </div>
            </div>
        </footer>
        <!-- login -->
        <div class="portfolio-modal modal fade" id="login_page" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase">登入</h2> <br><br>
                                    <form id="loginForm"> <!-- action="php/reCaptcha.php" method="post"-->
                                        <input type="hidden" id="isLoggedIn" name="isLoggedIn" value="true">
                                        <div class="form-group">
                                            <input class="form-control" id="logInEmail" type="email" placeholder="電子信箱 *" required="required">
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control" id="logInPassword" type="password" placeholder="密碼 *" required="required">
                                        </div>
                                        <!-- <div class="form-group">
                                            <img src="captcha.png" alt="Captcha Image">
                                            <input class="form-control" id="captcha" name="captcha" type="text" placeholder="輸入圖形中的字元 *" required="required">
                                        </div> -->
                                        <a data-bs-toggle="modal" href="#signUpPage">註冊</a> <a data-bs-toggle="modal" href="#forgetPassword">忘記密碼</a>
                                        <div class="text-center">
                                            <button class="btn btn-primary btn-xl text-uppercase mb-4" id="logInButton" type="submit">登入</button>
                                        </div>
                                        <div id="alertContainer-enterEmail"></div>
                                        <div id="alertContainer-enterPassword"></div>
                                        <div id="alertContainer-wrongLogIn"></div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="portfolio-modal modal fade" id="signUpPage" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <h2 class="text-uppercase">註冊</h2> <br><br>
                                    <form id="signUpForm">
                                        <div class="form-group">
                                            <input class="form-control" id="signUpEmail" type="email" placeholder="帳號(電子信箱) *" required="required">
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control" id="signUpPassword" type="password" placeholder="密碼 *" required="required">
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control" id="signUpRePassword" type="password" placeholder="再次輸入密碼 *" required="required">
                                        </div>
                                        <div id="alertContainer-signUp-diffPassword"></div>
                                        <div class="form-group">
                                            <input class="form-control" id="signUpName" type="text" placeholder="姓名 *" required="required">
                                        </div>
                                        <p class="text-center alert alert-primary mb-4">請輸入電子信箱<br>請輸入長度至少6碼的密碼<br></p>
                                        <div class="text-center">
                                            <button class="btn btn-primary btn-xl mb-4" id="signUpButton" type="submit">註冊</button>
                                        </div>
                                        <div class="text-center">
                                            <button class="btn btn-secondary btn-l" id="backButton" type="button" data-bs-toggle="modal" href="#login_page"><i class="fas fa-xmark me-1"></i>返回</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="portfolio-modal modal fade" id="forgetPassword" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <div id="alertContainer-wrongEmail"></div>
                                    <h2 class="text-uppercase">重設密碼</h2> <br><br>
                                    <form id="sendEmailForm">
                                        <div class="form-group mb-4">
                                            <input class="form-control" id="emailInput" type="email" placeholder="電子信箱">
                                        </div>
                                        <div class="text-center">
                                            <button class="btn btn-primary btn-xl mb-4" id="sendEmailButton">發送重設信件</button>
                                        </div>
                                        <div class="text-center">
                                            <button class="btn btn-secondary btn-l" id="backButton" type="button" data-bs-toggle="modal" href="#login_page"><i class="fas fa-xmark me-1"></i>返回</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="portfolio-modal modal fade" id="resetPasswordPage" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <div id="alertContainer-sendSuccess"></div>
                                    <h2 class="text-uppercase">重設密碼</h2> <br><br>
                                    <form id="resetPasswordForm">
                                        <div class="form-group">
                                            <input class="form-control" id="verification-code" type="text" placeholder="驗證碼 *" required="required">
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control" id="new-password" type="password" placeholder="新密碼 *" required="required">
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control" id="new-repassword" type="password" placeholder="再次輸入新密碼 *" required="required">
                                        </div>
                                        <div class="text-center">
                                            <button class="btn btn-primary btn-xl text-uppercase" id="signUpButton" type="submit">重設</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio Modals-->
        <!-- Portfolio item 1 modal popup-->
        <div class="portfolio-modal modal fade" id="reservation-room-forStatus" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <form id="reservate-roomForm-forStatus">
                                        <div id="reservate-roomContainer-forStatus"></div>
                                    </form>
                                    <div id="alertContainer-reservateRoom-success-forStatus"></div>
                                    <div class="row align-items-center mb-4">
                                        <button class="btn btn-primary btn-xl custom-button-width mx-auto" id="reservateRoom-success-forStatus">
                                            確認
                                        </button>
                                    </div>
                                    <button class="btn btn-secondary btn-xl" type="button" data-bs-dismiss="modal">
                                        <i class="fas fa-xmark me-1"></i>
                                        返回
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="portfolio-modal modal fade" id="reservation-equip-forStatus" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <form id="reservate-equipForm-forStatus">
                                        <div id="reservate-equipContainer-forStatus"></div>
                                        <div class="row align-items-center mb-4">
                                            <button class="btn btn-primary btn-xl custom-button-width mx-auto" type="submit" id="reservateEquip-success-forStatus">
                                                確認
                                            </button>
                                        </div>
                                    </form>
                                    <div id="alertContainer-reservateEquip-success-forStatus"></div>
                                    <button class="btn btn-secondary btn-xl" type="button" data-bs-dismiss="modal">
                                        <i class="fas fa-xmark me-1"></i>
                                        返回
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="portfolio-modal modal fade" id="reservation-room" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-toggle="modal" href="#portfolio-search"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <div id="reservate-roomContainer"></div>
                                    <div class="row align-items-center mb-4">
                                        <button class="btn btn-primary btn-xl custom-button-width mx-auto" type="button" id="reservateRoom-success">
                                            確認
                                        </button>
                                    </div>
                                    <div id="alertContainer-reservateRoom-success"></div>
                                    <button class="btn btn-secondary btn-xl" type="button" data-bs-toggle="modal" href="#portfolio-search">
                                        <i class="fas fa-xmark me-1"></i>
                                        返回
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="portfolio-modal modal fade" id="reservation-equip" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-toggle="modal" href="#portfolio-equip-search"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <div id="reservate-equipContainer"></div>
                                    <div class="row align-items-center mb-4">
                                        <button class="btn btn-primary btn-xl custom-button-width mx-auto" type="button" id="reservateEquip-success">
                                            確認
                                        </button>
                                    </div>
                                    <div id="alertContainer-reservateEquip-success"></div>
                                    <button class="btn btn-secondary btn-xl" type="button" data-bs-toggle="modal" href="#portfolio-equip-search">
                                        <i class="fas fa-xmark me-1"></i>
                                        返回
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.1/nouislider.min.js"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>