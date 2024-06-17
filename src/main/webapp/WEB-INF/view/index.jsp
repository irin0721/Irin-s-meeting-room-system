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
        <link href="/program/css/styles.css" rel="stylesheet" />
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>
    <body id="page-top" class="index">
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
                        <li class="nav-item"><a class="nav-link" href="#services">打卡專區</a></li>
                        <li class="nav-item"><a class="nav-link" href="#portfolio">目前使用情形</a></li>
                        <li class="nav-item"><a class="nav-link needLogin" href="reservationPage.html" target="_blank">預約</a></li>
                        <li class="nav-item"><a class="nav-link needLogin" href="reservationTable.html" target="_blank">我的預定</a></li>
                        <li class="nav-item me-0"><a class="nav-link" id="navbar-logout" onclick="logout()" hidden>登出</a></li>
                        <li class="nav-item me-0"><a class="nav-link" data-bs-toggle="modal" href="#login_page" id="navbar-login">登入</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="userMenu" role="button" data-bs-toggle="dropdown" aria-expanded="false" hidden>
                                選擇角色
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="userMenu">
                                <li><a class="dropdown-item" href="#index.html">使用者</a></li>
                                <li><a class="dropdown-item" href="manage_interface.html" target="_blank">管理員</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Masthead-->
        <header class="masthead">
            <div class="container">
                <div class="masthead-subheading">歡迎來到會議室預約系統</div>
                <a class="btn btn-primary btn-xl text-uppercase" href="#services">更多</a>
            </div>
        </header>
        <!-- Services-->
        <section class="page-section" id="services">
            <div class="container">
                <h2 class="text-center">打卡專區</h2>
                <div class="text-lg-start" id="loggedInSection" hidden>
                    <div class="reservation-block">
                        <div class="reservation-details" id="next-reservation"></div>
                        <div class="reservation-status">
                            <button class="btn btn-primary btn-l" id="checkInBtn" hidden>簽到</button>
                            <button class="btn btn-primary btn-l" id="checkOutBtn" hidden>簽退</button>
                            <button disabled class="btn btn-primary btn-l" id="notOpenBtn" hidden>未開放</button>
                        </div>
                    </div>
                </div>
                <div class="text-lg-start" id="loggedOutSection" hidden>
                    <div class="reservation-block">
                        <div class="reservation-details">
                            <p class="text-black">下一個預約:</p>
                            <p class="no-reservation text-black text">請先登入</p>
                        </div>
                        <div class="reservation-status">
                            <button disabled class="btn btn-primary btn-l">未開放</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Meeting Room Using and Equipment Using status-->
        <section class="page-section bg-light" id="portfolio">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">目前使用情形</h2>
                    <h3 class="section-subheading text-muted">查看目前會議室和設備的使用情況</h3>
                </div>
                <div class="row">
                    <h4 class="text-center">會議室使用情形</h4>
                </div>
                <div id="roomContainer" class="row"></div>
                <div class="text-center mb-4">
                    <a class="btn btn-primary btn-xl text-uppercase" data-bs-toggle="modal" href="#more-room">更多</a>
                </div>
                <div class="row">
                    <h4 class="text-center">設備使用情形</h4>
                </div>
                <div id="equipContainer" class="row"></div>
                <div class="text-center mb-4">
                    <a class="btn btn-primary btn-xl text-uppercase" data-bs-toggle="modal" href="#more-equip">更多</a>
                </div>
            </div>
        </section>
        <div class="modal modal-lg fade" id="time" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <div class="row align-items-center mb-3">
                                        <div class="col-md-4 label-column">
                                            <label for="date">日期:</label>
                                        </div>
                                        <div class="col-md-8">
                                            <input type="date" list="dates" class="form-control text-center" id="select-date">
                                            <datalist id="dates"></datalist>
                                        </div>
                                    </div>
                                    <div class="row align-items-center mb-3">
                                        <div class="col-md-4 label-column">
                                            <label for="startTime">開始時間:</label>
                                        </div>
                                        <div class="col-md-8">
                                            <select class="custom-form-select text-center flatpickr" id="startTime"></select>
                                        </div>
                                    </div>
                                    <div class="row align-items-center mb-4">
                                        <div class="col-md-4 label-column">
                                            <label for="endTime">結束時間:</label>
                                        </div>
                                        <div class="col-md-8">
                                            <select class="custom-form-select text-center flatpickr" id="endTime"></select>
                                        </div>
                                    </div>
                                    <div class="text-center mb-3">
                                        <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" id="time-confirm">確認</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal modal-lg fade" id="time-equipment" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project details-->
                                    <div class="row align-items-center mb-3">
                                        <div class="col-md-4 label-column">
                                            <label for="date-equipment">日期:</label>
                                        </div>
                                        <div class="col-md-8">
                                            <input type="date" list="dates" class="form-control text-center" id="select-date-equipment">
                                            <datalist id="dates-equipment"></datalist>
                                        </div>
                                    </div>
                                    <div class="row align-items-center mb-3">
                                        <div class="col-md-4 label-column">
                                            <label for="startTime-equipment">開始時間:</label>
                                        </div>
                                        <div class="col-md-8">
                                            <select class="custom-form-select text-center flatpickr" id="startTime-equipment"></select>
                                        </div>
                                    </div>
                                    <div class="row align-items-center mb-4">
                                        <div class="col-md-4 label-column">
                                            <label for="endTime-equipment">結束時間:</label>
                                        </div>
                                        <div class="col-md-8">
                                            <select class="custom-form-select text-center flatpickr" id="endTime-equipment"></select>
                                        </div>
                                    </div>
                                    <div class="text-center mb-3">
                                        <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" id="time-confirm-equipment">確認</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="more-room" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <h5 class="modal-title text-center">會議室</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Project details-->
                        <div id="more-roomContainer" class="row"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="more-equip" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <h5 class="modal-title text-center">設備</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Project details-->
                        <div id="more-equipContainer" class="row"></div>
                    </div>
                </div>
            </div>
        </div>
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
        <div class="portfolio-modal modal fade" id="reservation-more-room-forStatus" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <form id="reservate-moreRoomForm-forStatus">
                                        <div id="reservate-moreRoomContainer-forStatus"></div>
                                        <div id="alertContainer-reservateRoom-success-moreRoom-forStatus"></div>
                                        <div class="row align-items-center mb-4">
                                            <button class="btn btn-primary btn-xl custom-button-width mx-auto" id="reservate-success-moreRoomforStatus">
                                                確認
                                            </button>
                                        </div>
                                    </form>
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
        <div class="portfolio-modal modal fade" id="reservation-more-equip-forStatus" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-bs-dismiss="modal"><img src="/program/assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <form id="reservate-moreEquipForm-forStatus">
                                        <div id="reservate-moreEquipContainer-forStatus"></div>
                                        <div class="row align-items-center mb-4">
                                            <button class="btn btn-primary btn-xl custom-button-width mx-auto" id="reservate-success-moreEquipforStatus">
                                                確認
                                            </button>
                                        </div>
                                        <div id="alertContainer-reservateRoom-success-moreEquip-forStatus"></div>
                                    </form>
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

    