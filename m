Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56D73D503
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 00:14:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXyb-0004pZ-1p; Sun, 25 Jun 2023 18:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qDXyS-0004pA-Sn
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 18:12:48 -0400
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qDXyQ-00070J-NF
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 18:12:48 -0400
Received: by mail-ed1-x54a.google.com with SMTP id
 4fb4d7f45d1cf-51d988d6039so485870a12.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1687731164; x=1690323164;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iWSiio4Y2TEs1Gg1imEn5VhyL8VSeQustFCeWD+fNI8=;
 b=3SQBxDR1u+9MWfLyA/IoyDGxRTXnTarDImSEU+bEuGXg3zD2Zb/l01WImV3KgsDEWS
 9l6TzE+Vc2fdraTvjwZ4O/wImIBZaBQNF3yJmvERIyLK71+FkVd9+pdlSZOMFzIr6WLV
 na4Zq4QQGbQuNVL/vthoxxgShLkUfO8gsuX4QrVzU53wCM6P/s1HFJvkFjD7WEKfbSYD
 KXmThrHqg/l3AZX12d+MS1Ua379OEevdIp/HIL34V/HnSLc/8RqALp9BJMEqQM4C8Fes
 YIk2QJySgd3npm1vEzUvK7FJ3zB5xsptoPQezJikOffGfamlo+eJISq4jpUNNzaDF++H
 kd0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687731164; x=1690323164;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iWSiio4Y2TEs1Gg1imEn5VhyL8VSeQustFCeWD+fNI8=;
 b=Hdc7ZG0Z8Sw2xaSPCDMkuVkfvGAhF8hx2zmypWceAoa297L5joQiLm2ruwUuyHe5mW
 hYkzyRMbYBKEmcd0TryRGZWXcUy4HQ7uhID8UhmEs/qg0tjejqNw2oYqI3ncAmy1VISe
 oljpjil2RPQARmQ6wmS9BIeS4nabV8B4VGOFgRrt4wZgPtaH/JofEiV1imehbf9Pcxsc
 lpMlw6JR2QJPiOBpjfP8noPpx02h2evEgPokvSfaMbhytgZcQnlClXy5HcFm5qkYhKAR
 /oPhNKrOuzzSDRo7ssEYPb60WCfco183pvqIahup5LwoUJIdPv7vQPLBFIEVqfen0xIZ
 MiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687731164; x=1690323164;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iWSiio4Y2TEs1Gg1imEn5VhyL8VSeQustFCeWD+fNI8=;
 b=jDXkhJ6bEMFUAwjjaa/1k8hXAu801Ztw3EqgQEcZhiRfOQJnYm58wnm8b+nL165QTu
 PJqaecfXtjCrNHd+fkmFe08FQ4g4X7Pw9QMR2Cy0xZJN7p8pQwPiy83rZUlIkhLUyF6k
 QReJXspOZFREdOMpozssQcHV6RQHaaGB1l2fueEaRejdwZ2yiawd2jpExlfnh0j7mvAv
 sNf5KkDtbWCfIPUB02ws2jJtkCQJ0p/jXBeALlq4ZnZG2KS63PdovGc3lvdCujHK7OZU
 uO7eXydRzHM+Cja9TyEIvFpKU3eCuP6Ed6+bRrRiqfFUb7M0htY3yS7stLaja2buH8Zw
 aQGQ==
X-Gm-Message-State: AC+VfDxNtF/oy5cVh1TYCSvz2n8JiNTYnCKI/gIpV0FPTFsqaoMFKaXk
 HcRoOwCbWj5+sV107LlUNBpHuRotKT8b26X67rsX
X-Google-Smtp-Source: ACHHUZ6T7SDPUwh2heFFl8vX2UOawUQeI0NU5cwbRwM8zm4wnul4zSPm5B7nENZIyyj3e6cGEnGHgchUOkNDjjSnFY0O
MIME-Version: 1.0
X-Received: by 2002:aa7:c14e:0:b0:51c:3395:4907 with SMTP id
 r14-20020aa7c14e000000b0051c33954907mr4623184edp.4.1687731164375; Sun, 25 Jun
 2023 15:12:44 -0700 (PDT)
Message-ID: <calendar-965dcf00-e9ba-44df-99a1-53e15066b1b1@google.com>
Date: Sun, 25 Jun 2023 22:12:44 +0000
Subject: QEMU developers call for 2023-06-27
From: juan.quintela@gmail.com
To: afaerber@suse.de, ale@rev.ng, anjo@rev.ng, bazulay@redhat.com, 
 bbauman@redhat.com, chao.p.peng@linux.intel.com, cjia@nvidia.com, cw@f00f.org, 
 david.edmondson@oracle.com, dustin.kirkland@canonical.com, eblake@redhat.com, 
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, eric.auger@redhat.com, 
 f4bug@amsat.org, Felipe Franciosi <felipe.franciosi@nutanix.com>, 
 "iggy@theiggy.com" <iggy@kws1.com>, Warner Losh <wlosh@bsdimp.com>,
 jan.kiszka@web.de, jgg@nvidia.com, 
 jidong.xiao@gmail.com, jjherne@linux.vnet.ibm.com, joao.m.martins@oracle.com, 
 konrad.wilk@oracle.com, mburton@qti.qualcomm.com, mdean@redhat.com, 
 mimu@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 quintela@redhat.com, richard.henderson@linaro.org, 
 shameerali.kolothum.thodi@huawei.com, stefanha@gmail.com, 
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com, 
 juan.quintela@gmail.com
Content-Type: multipart/alternative; boundary="00000000000087706c05fefb8809"
Received-SPF: pass client-ip=2a00:1450:4864:20::54a;
 envelope-from=juan.quintela@gmail.com; helo=mail-ed1-x54a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: juan.quintela@gmail.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--00000000000087706c05fefb8809
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgUmVtZW1iZXIgdGhhdCB0aGlzIHdlZWsgd2UgaGF2ZSB0aGUgY2FsbCB0aGF0IHdlIHBvc3Rw
b25lZCBmb3IgS1ZNICANCkZvcnVtLiBJbiBpdCBPcmFjbGUgd2FudHMgdG8gZGlzY3VzcyBob3cg
dG8gbW92ZSB0byBpbnRlZ3JhdGUgdGhlaXIgTGl2ZSAgDQpVcGRhdGUgc2VyaWVzLiBQbGVhc2Us
IHJlbWVtYmVyIHRvIGpvaW4uIExhdGVyLCBKdWFuLg0KDQpRRU1VIGRldmVsb3BlcnMgZm9ydG5p
Z2h0bHkgY29uZmVyZW5jZSBjYWxsDQpUdWVzZGF5IDIwMjMtMDYtMjcg4ouFIDE1OjAwIOKAkyAx
NjowMA0KQ2VudHJhbCBFdXJvcGVhbiBUaW1lIC0gTWFkcmlkDQoNCkxvY2F0aW9uDQpodHRwczov
L21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nCQ0KaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS91cmw/
cT1odHRwcyUzQSUyRiUyRm1lZXQuaml0LnNpJTJGa3ZtY2FsbG1lZXRpbmcmc2E9RCZ1c3Q9MTY4
ODE2MzEyMDAwMDAwMCZ1c2c9QU92VmF3MjVaX0RLV3Y1dGtLZF9ueC1zUEFMaQ0KDQoNCg0KSWYg
eW91IG5lZWQgY2FsbCBkZXRhaWxzLCBwbGVhc2UgY29udGFjdCBtZTogcXVpbnRlbGFAcmVkaGF0
LmNvbQ0KDQpHdWVzdHMNClBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQpKb2FvIE1hcnRpbnMNCnF1
aW50ZWxhQHJlZGhhdC5jb20NCk1laXJhdiBEZWFuDQpGZWxpcGUgRnJhbmNpb3NpDQphZmFlcmJl
ckBzdXNlLmRlDQpiYXp1bGF5QHJlZGhhdC5jb20NCmJiYXVtYW5AcmVkaGF0LmNvbQ0KY3dAZjAw
Zi5vcmcNCmR1c3Rpbi5raXJrbGFuZEBjYW5vbmljYWwuY29tDQplYmxha2VAcmVkaGF0LmNvbQ0K
ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tDQplcmljLmF1Z2VyQHJlZGhhdC5jb20NCmlnZ3lAdGhl
aWdneS5jb20NCmphbi5raXN6a2FAd2ViLmRlDQpqaWRvbmcueGlhb0BnbWFpbC5jb20NCmpqaGVy
bmVAbGludXgudm5ldC5pYm0uY29tDQptaW11QGxpbnV4LnZuZXQuaWJtLmNvbQ0KUGV0ZXIgTWF5
ZGVsbA0KcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZw0Kc3RlZmFuaGFAZ21haWwuY29tDQpX
YXJuZXIgTG9zaA0Kei5odW9AMTM5LmNvbQ0Kend1Lmtlcm5lbEBnbWFpbC5jb20NCkphc29uIEd1
bnRob3JwZQ0KTmVvIEppYQ0KRGF2aWQgRWRtb25kc29uDQpFbGVuYSBVZmltdHNldmENCktvbnJh
ZCBXaWxrDQphbGVAcmV2Lm5nDQphbmpvQHJldi5uZw0KU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9k
aQ0KV2FuZywgV2VpIFcNCkNoYW8gUGVuZw0KcWVtdS1kZXZlbEBub25nbnUub3JnDQptYnVydG9u
QHF0aS5xdWFsY29tbS5jb20NCg0KDQo=
--00000000000087706c05fefb8809
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!doctype html><html xmlns=3D"http://www.w3.org/1999/xhtml" xmlns:v=3D"urn:=
schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-microsoft-com:office:offi=
ce"><head><title></title><!--[if !mso]><meta http-equiv=3D"X-UA-Compatible"=
 content=3D"IE=3Dedge"><![endif]--><meta http-equiv=3D"Content-Type" conten=
t=3D"text/html; charset=3DUTF-8"><meta name=3D"viewport" content=3D"width=
=3Ddevice-width,initial-scale=3D1"><meta name=3D"color-scheme" content=3D"l=
ight dark"><meta name=3D"supported-color-schemes" content=3D"light dark">
    <style>
      body, html {
        font-family: Roboto, Helvetica, Arial, sans-serif;
      }

      body {
        margin: 0;
        padding: 0;
        -webkit-font-smoothing: antialiased;
        -webkit-text-size-adjust: 100%;
        -ms-text-size-adjust: 100%;
      }

      #outlook a {
        padding: 0;
      }

      .ReadMsgBody {
        width: 100%;
      }

      .ExternalClass {
        width: 100%;
      }

      .ExternalClass * {
        line-height: 100%;
      }

      table,
      td {
        mso-table-lspace: 0pt;
        mso-table-rspace: 0pt;
      }

      img {
        border: 0;
        height: auto;
        line-height: 100%;
        outline: none;
        text-decoration: none;
        -ms-interpolation-mode: bicubic;
      }

      p {
        display: block;
        margin: 13px 0;
      }
    </style>
    <!--[if !mso]><!-->
    <style>
      @media only screen and (max-width:580px) {
        @-ms-viewport {
          width: 320px;
        }

        @viewport {
          width: 320px;
        }
      }
    </style>
    <!--<![endif]-->
    <!--[if mso]>
          <xml>
          <o:OfficeDocumentSettings>
            <o:AllowPNG/>
            <o:PixelsPerInch>96</o:PixelsPerInch>
          </o:OfficeDocumentSettings>
          </xml>
          <![endif]-->
    <!--[if lte mso 11]>
          <style>
            .outlook-group-fix { width:100% !important; }
          </style>
    <![endif]-->

    <!--[if !mso]><!-- -->
  <style>body, html {font-family:Roboto,Helvetica,Arial,sans-serif;}@font-f=
ace {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOmCnqEu92Fr1Mu4mxP.ttf) forma=
t('truetype');
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOlCnqEu92Fr1MmEU9fBBc9.ttf) f=
ormat('truetype');
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOlCnqEu92Fr1MmWUlfBBc9.ttf) f=
ormat('truetype');
}
@font-face {
  font-family: 'Material Icons Extended';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/materialiconsextended/v149/kJEjBvgX7BgnkSr=
UwT8UnLVc38YydejYY-oE_LvM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialicons/v137/Gw6kwdfw6UnXLJCcm=
afZyFRXb3BL9rvi0QZG3g.otf) format('opentype');
}

.google-material-icons {
  font-family: 'Google Material Icons';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
}
@font-face {
  font-family: 'Google Material Icons Filled';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialiconsfilled/v113/WWXFlimHYg6=
HKI3TavMkbKdhBmDvgach8TVpeGsuueSZJH4.otf) format('opentype');
}

.google-material-icons-filled {
  font-family: 'Google Material Icons Filled';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UaGrENHsxJlGDuGo1OIlL3Owps=
.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 500;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UabrENHsxJlGDuGo1OIlLU94Yt=
zCwM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 700;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UabrENHsxJlGDuGo1OIlLV154t=
zCwM.ttf) format('truetype');
}
</style><!--<![endif]-->
      <style>
        .body-container {
          padding-left: 16px;
          padding-right: 16px;
        }
      </style>
 =20
      <style>
        u+.body .body-container,
        body[data-outlook-cycle] .body-container,
        #MessageViewBody .body-container {
          padding-left: 0;
          padding-right: 0;
        }
      </style>
 =20
    <style>
      @media only screen and (min-width:580px) {
        .column-per-37 {
          width: 37% !important;
          max-width: 37%;
        }

        .column-per-63 {
          width: 63% !important;
          max-width: 63%;
        }
      }
    </style>
 =20
    <style>
      .appointment-buttons th {
        display: block;
        clear: both;
        float: left;
        margin-top: 12px;
      }

      .appointment-buttons th a {
        float: left;
      }

      #MessageViewBody .appointment-buttons th {
       margin-top: 24px;
      }
    </style>
 =20
    <style>
      @media only screen and (max-width:580px) {
        table.full-width-mobile {
          width: 100% !important;
        }

        td.full-width-mobile {
          width: auto !important;
        }
      }
    </style>
    <style>
      .main-container-inner,
      .info-bar-inner {
        padding: 12px 16px !important;
      }

      .main-column-table-ltr {
        padding-right: 0 !important;
      }

      .main-column-table-rtl {
        padding-left: 0 !important;
      }

      @media only screen and (min-width:580px) {
        .main-container-inner {
          padding: 24px 32px !important;
        }

        .info-bar-inner {
          padding: 12px 32px !important;
        }

        .main-column-table-ltr {
          padding-right: 32px !important;
        }

        .main-column-table-rtl {
          padding-left: 32px !important;
        }

        .appointment-buttons th {
          display: table-cell;
          clear: none;
        }
      }

      .primary-text {
        color: #3c4043 !important;
      }

      .secondary-text,
      .phone-number a {
        color: #70757a !important;
      }

      .accent-text {
        color: #1a73e8 !important;
      }

      .accent-text-dark {
        color: #185abc !important;
      }

      .grey-button-text,
      .attachment-chip a {
        color: #5f6368 !important;
      }

      .primary-button {
        background-color: #1a73e8 !important;
      }

      .primary-button-text {
        color: #fff !important;
      }

      .underline-on-hover:hover {
        text-decoration: underline !important;
      }

      .grey-infobar-text {
        color: #202124 !important;
      }

      @media (prefers-color-scheme: dark) {
        .primary-text:not([class^=3D"x_"]) {
          color: #e8eaed !important;
        }

        .secondary-text:not([class^=3D"x_"]),
        .phone-number:not([class^=3D"x_"]) a {
          color: #9aa0a6 !important;
        }

        .grey-button-text:not([class^=3D"x_"]),
        .attachment-chip:not([class^=3D"x_"]) a {
          color: #bdc1c6 !important;
        }

        .accent-text:not([class^=3D"x_"]),
        .hairline-button-text:not([class^=3D"x_"]) {
          color: #8ab4f8 !important;
        }

        .primary-button:not([class^=3D"x_"]) {
          background-color: #8ab4f8 !important;
        }

        .primary-button-text:not([class^=3D"x_"]) {
          color: #202124 !important;
        }
      }
    </style>
    <style>
      @media (prefers-color-scheme: dark) {
        .cse-banner:not([class^=3D"x_"]) {
          background-color: #3c4043 !important; /* Google Grey 800 */
        }

        .encryption-icon:not([class^=3D"x_"]) {
          /* WARNING: This causes the whole style tag to get stripped in Gm=
ail. */
          background-image: url('https://fonts.gstatic.com/s/i/googlemateri=
aliconsfilled/encrypted/v3/gm_grey200-24dp/2x/gm_filled_encrypted_gm_grey20=
0_24dp.png') !important;
        }
      }
    </style>
    <!--[if !mso]><!-->
    <style>
      .prevent-link a {
        color: inherit !important;
        text-decoration: none !important;
        font-size: inherit !important;
        font-family: inherit !important;
        font-weight: inherit !important;
        line-height: inherit !important;
      }
    </style>
    <!--<![endif]-->

    <!--[if mso | IE]>
      <style>
        .main-container-inner {
          padding: 24px 32px !important;
        }

        .info-bar-inner {
          padding: 12px 32px !important;
        }

        .cse-banner .encryption-icon {
          /* We use the IE workaround instead. */
          background-image: none !important;
        }

        .cse-banner .encryption-icon .ms-fallback {
          display: block !important;
        }

        /* NB: Some MS clients ignore dark-scheme styling and apply their o=
wn, so there's nothing we can do to help there. */
        @media (prefers-color-scheme: dark) {
          .cse-banner:not([class^=3D"x_"]) .encryption-icon .ms-fallback {
            display: none !important;
          }

          .cse-banner:not([class^=3D"x_"]) .encryption-icon .ms-fallback-da=
rk {
            display: block !important;
          }
        }
      </style>
    <![endif]-->
  </head><body class=3D"body"><span itemscope itemtype=3D"http://schema.org=
/InformAction"><span style=3D"display:none" itemprop=3D"about" itemscope it=
emtype=3D"http://schema.org/EmailMessage"><meta itemprop=3D"description" co=
ntent=3D"juan.quintela@gmail.com: Hi Remember that this week we have the ca=
ll that we postponed for KVM Forum. In it Oracle wants to discuss how to mo=
ve to integrate their Live Update series. Please, remember to join. Later, =
Juan."/></span><span itemprop=3D"object" itemscope itemtype=3D"http://schem=
a.org/Event"><meta itemprop=3D"eventStatus" content=3D"http://schema.org/Ev=
entScheduled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://sc=
hema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar"/=
></span><meta itemprop=3D"eventId/googleCalendar" content=3D"5dt5ji87j5qrc0=
0o63ktq7ghou_20230627T130000Z"/><span style=3D"display: none; font-size: 1p=
x; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-w=
idth: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU developers f=
ortnightly conference call</span><span aria-hidden=3D"true"><time itemprop=
=3D"startDate" datetime=3D"20230627T130000Z"></time><time itemprop=3D"endDa=
te" datetime=3D"20230627T140000Z"></time></span><table border=3D"0" cellpad=
ding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=
=3D"width:100%;" class=3D"body-container"><tbody><tr><td style=3D"" class=
=3D"" align=3D"left"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0=
" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D"16" style=3D"he=
ight:16px;"><![endif]--><div style=3D"height:16px;" aria-hidden=3D"true"> &=
nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"c=
enter" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"" class=3D"=
" align=3D"left"><span itemscope itemtype=3D"http://schema.org/EmailMessage=
"><p itemprop=3D"description">Hi<br>Remember that this week we have the cal=
l that we postponed for KVM Forum.<br>In it Oracle wants to discuss how to =
move to integrate their Live Update series.<p>Please, remember to join.<p>L=
ater, Juan.</p></span></td></tr></tbody></table><table border=3D"0" cellpad=
ding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=
=3D"width:100%;" class=3D""><tbody><tr><td style=3D"border: solid 1px #dadc=
e0; border-radius: 8px; direction: rtl; font-size: 0; padding: 24px 32px; t=
ext-align: left; vertical-align: top;" class=3D"main-container-inner"><!--[=
if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation"><tr><![endif]--><div class=3D"" style=3D"font-size: 13px;=
 text-align: left; direction: ltr; display: inline-block; vertical-align: t=
op; width: 100%;overflow: hidden; word-wrap: break-word;"><table border=3D"=
0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%"=
 class=3D"main-column-table-ltr" style=3D"padding-right: 32px; padding-left=
: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main-column-td" style=3D=
"padding:0; vertical-align:top;"><table border=3D"0" cellpadding=3D"0" cell=
spacing=3D"0" role=3D"presentation" width=3D"100%" style=3D"table-layout: f=
ixed;"><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-br=
eak: break-word;;padding-bottom:2px;"><div style=3D"font-family: &#39;Googl=
e Sans&#39;, Roboto, sans-serif;font-weight: 400; font-size: 22px; line-hei=
ght: 28px;color: #3c4043; text-decoration: none;" class=3D"primary-text" ro=
le=3D"presentation"><span itemprop=3D"name">QEMU developers fortnightly con=
ference call</span></div></td></tr><tr><td style=3D"font-size: 0; padding: =
0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div sty=
le=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400;=
 font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; =
text-decoration: none;" class=3D"primary-text" role=3D"presentation"><span =
aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20230627T1300=
00Z"></time><time itemprop=3D"endDate" datetime=3D"20230627T140000Z"></time=
></span><span>Tuesday 2023-06-27 =E2=8B=85 15:00 =E2=80=93 16:00 (Central E=
uropean Time - Madrid)</span></div></td></tr><tr><td style=3D"font-size: 0;=
 padding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;=
"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-we=
ight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color:=
 #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presentati=
on"><span>If you need call details, please contact me: <a href=3D"mailto:qu=
intela@redhat.com" target=3D"_blank">quintela@redhat.com</a></span><meta it=
emprop=3D"description" content=3D"If you need call details, please contact =
me: quintela@redhat.com"/></div></td></tr><tr><td style=3D"font-size: 0; pa=
dding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;"><=
div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weigh=
t: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3=
c4043; text-decoration: none;" class=3D"primary-text" role=3D"presentation"=
><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentati=
on" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=
=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;=
-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Location</h2></=
td></tr></table><span itemprop=3D"location" itemscope itemtype=3D"http://sc=
hema.org/Place"><span itemprop=3D"name" class=3D"primary-text notranslate" =
style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 4=
00; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c404=
3; text-decoration: none;">https://meet.jit.si/kvmcallmeeting</span><br/><a=
 href=3D"https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcall=
meeting&amp;sa=3DD&amp;ust=3D1688163120000000&amp;usg=3DAOvVaw25Z_DKWv5tkKd=
_nx-sPALi" class=3D"accent-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #1a73e8; text-decoration: none;font-weight: 700;" target=3D=
"_blank" itemprop=3D"map">View map</a></span></div></td></tr><tr><td style=
=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;pad=
ding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style=
: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spac=
ing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text" r=
ole=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0=
" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D=
"primary-text" style=3D"font-size: 14px;color: #3c4043; text-decoration: no=
ne;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding:=
 0;">Guests</h2></td></tr></table><div style=3D"padding-bottom: 4px; text-a=
lign: left;;color: #3c4042;"><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:f4bug@amsat.=
org">Philippe Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" content=
=3D"f4bug@amsat.org"/></span><span class=3D"secondary-text" style=3D"color:=
 #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atten=
dee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name=
" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:joao.m.martins@oracle.com">Joao Martins</a></span><meta itemprop=3D"=
email" content=3D"joao.m.martins@oracle.com"/></span><span class=3D"seconda=
ry-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div=
><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person=
"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text un=
derline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-deco=
ration: none;" href=3D"mailto:quintela@redhat.com">quintela@redhat.com</a><=
/span><meta itemprop=3D"email" content=3D"quintela@redhat.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:mdean@redhat.com">Meirav D=
ean</a></span><meta itemprop=3D"email" content=3D"mdean@redhat.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:felipe@nutanix.com">Fe=
lipe Franciosi</a></span><meta itemprop=3D"email" content=3D"felipe@nutanix=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:afaerber@=
suse.de">afaerber@suse.de</a></span><meta itemprop=3D"email" content=3D"afa=
erber@suse.de"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
bazulay@redhat.com">bazulay@redhat.com</a></span><meta itemprop=3D"email" c=
ontent=3D"bazulay@redhat.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:bbauman@redhat.com">bbauman@redhat.com</a></span><meta item=
prop=3D"email" content=3D"bbauman@redhat.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:cw@f00f.org">cw@f00f.org</a></span><meta ite=
mprop=3D"email" content=3D"cw@f00f.org"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:dustin.kirkland@canonical.com">dustin.kirkland@can=
onical.com</a></span><meta itemprop=3D"email" content=3D"dustin.kirkland@ca=
nonical.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:e=
blake@redhat.com">eblake@redhat.com</a></span><meta itemprop=3D"email" cont=
ent=3D"eblake@redhat.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</a></span><me=
ta itemprop=3D"email" content=3D"edgar.iglesias@gmail.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:eric.auger@redhat.com">eric.aug=
er@redhat.com</a></span><meta itemprop=3D"email" content=3D"eric.auger@redh=
at.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:iggy@th=
eiggy.com">iggy@theiggy.com</a></span><meta itemprop=3D"email" content=3D"i=
ggy@theiggy.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D"email" c=
ontent=3D"jan.kiszka@web.de"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com</a></span><met=
a itemprop=3D"email" content=3D"jidong.xiao@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:jjherne@linux.vnet.ibm.com">jjhern=
e@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" content=3D"jjherne@=
linux.vnet.ibm.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.com</a></span><meta ite=
mprop=3D"email" content=3D"mimu@linux.vnet.ibm.com"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:peter.maydell@linaro.org">Peter Maydel=
l</a></span><meta itemprop=3D"email" content=3D"peter.maydell@linaro.org"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:richard.henderso=
n@linaro.org">richard.henderson@linaro.org</a></span><meta itemprop=3D"emai=
l" content=3D"richard.henderson@linaro.org"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a></sp=
an><meta itemprop=3D"email" content=3D"stefanha@gmail.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:imp@bsdimp.com">Warner Losh</a>=
</span><meta itemprop=3D"email" content=3D"imp@bsdimp.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a=
></span><meta itemprop=3D"email" content=3D"z.huo@139.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kerne=
l@gmail.com</a></span><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jgg@nvidia=
.com">Jason Gunthorpe</a></span><meta itemprop=3D"email" content=3D"jgg@nvi=
dia.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; te=
xt-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsco=
pe itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"n=
otranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: =
inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cjia@n=
vidia.com">Neo Jia</a></span><meta itemprop=3D"email" content=3D"cjia@nvidi=
a.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:david.ed=
mondson@oracle.com">David Edmondson</a></span><meta itemprop=3D"email" cont=
ent=3D"david.edmondson@oracle.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></span><=
meta itemprop=3D"email" content=3D"elena.ufimtseva@oracle.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:konrad.wilk@oracle.com">Ko=
nrad Wilk</a></span><meta itemprop=3D"email" content=3D"konrad.wilk@oracle.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:ale@rev.ng=
">ale@rev.ng</a></span><meta itemprop=3D"email" content=3D"ale@rev.ng"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:anjo@rev.ng">anjo=
@rev.ng</a></span><meta itemprop=3D"email" content=3D"anjo@rev.ng"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:shameerali.kolothum.tho=
di@huawei.com">Shameerali Kolothum Thodi</a></span><meta itemprop=3D"email"=
 content=3D"shameerali.kolothum.thodi@huawei.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:wei.w.wang@intel.com">Wang, Wei W</a></s=
pan><meta itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:chao.p.peng@linux.intel.co=
m">Chao Peng</a></span><meta itemprop=3D"email" content=3D"chao.p.peng@linu=
x.intel.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:q=
emu-devel@nongnu.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"ema=
il" content=3D"qemu-devel@nongnu.org"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</=
a></span><meta itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div></div></div></td></tr></table></td></tr></tbody></tab=
le></div><!--[if mso | IE]></tr></table><![endif]--></td></tr></tbody></tab=
le></td></tr></tbody></table></span></span></body></html>
--00000000000087706c05fefb8809--

