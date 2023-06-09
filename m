Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D597290CA
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:19:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7WOE-0003ZI-Jj; Fri, 09 Jun 2023 03:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PNKCZA0JChc6HxA.DH5AG18x39x58.zB9D19H-01I18ABA3AH.BE3@calendar-server.bounces.google.com>)
 id 1q7WO9-0003Z3-Iy
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:18:25 -0400
Received: from mail-lj1-x24a.google.com ([2a00:1450:4864:20::24a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PNKCZA0JChc6HxA.DH5AG18x39x58.zB9D19H-01I18ABA3AH.BE3@calendar-server.bounces.google.com>)
 id 1q7WO7-0000tf-4e
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:18:25 -0400
Received: by mail-lj1-x24a.google.com with SMTP id
 38308e7fff4ca-2b20220c67bso11460631fa.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 00:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686295100; x=1688887100;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xcaiY7rrFQk4luzN7eJZzhe/4UoXpqKW0dFeMp16Poc=;
 b=rPZPjYvDjHq7BkRYeHVFP8irZXD2wyAvZeL9vvgcVZF+Zgdz6XYp5A2GWNOlxrUBg7
 rD96nP06/7uUHKRBnMe/K2UnzJGdkl4XaDRYUTTCWii61LYEbzFtUW6Hy2mwq1iHY6b6
 4tpLNcNa7PJCeyg5TE16dy3vxo5x0XHxq9VLtBD6xU+AGoTx412BNY3DHAw4bkwRA1Lf
 pY5fBKgx8ZQplhBPVSrBPD01oL0z0aM3uIsLVtC5WJ6HVki/cPpYWqAfw7osL+Jni7+j
 YXYnHCHkp/OXNQeguCVMAo8yNHpB7mgEQjgMdXuFSYSHscU1SKbtJMquuPnr9zISS6M1
 vCyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686295100; x=1688887100;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xcaiY7rrFQk4luzN7eJZzhe/4UoXpqKW0dFeMp16Poc=;
 b=Nnz1MYLkf5mYBx7EEWIRHVVBAvVxVL+Vtqnl6xc5QLYqjD3XnrHmLI6Sx19fJTh2Ht
 Yb32nkfYQ2//ERxnMOHH1I+ZhiJkVh+ZShtnkkEFbnzW2HuszrGGnIlcoMbVZubAkeTE
 NO7vAZZT51TkeRnmCCEJkHU4IVLHAfn61BoTH189wLvV6n+0o2/yjDd1w+5A0BGBomEC
 PvWVKvcnIXsTStZdiHxpkcXRiQvb1pECxgr1XbxQYzkjzKJZ+Qz/JZQ/SiZB4dB3258o
 XsMj0T+AyBIN4FKFj/vcfO79TrAuJgBYrwiBavF2J8DH/hPs7yRTb+2msxRJysyRw0Vp
 2VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686295100; x=1688887100;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xcaiY7rrFQk4luzN7eJZzhe/4UoXpqKW0dFeMp16Poc=;
 b=itE3viBz7LbvW5sMeGij5DGXBKa22qRSxkVjj1z6P4dSWLPATw1Wd7LGWfKfjpm4YK
 RfmjsrWRUj9b27+u0ob7v8YEvAPVa2ZuwR4yGZt10wxJnIRehgNsfDZKCoAd0ESx3q2M
 ZzhZir4BE7nwObbVx0e5lR/Nz7fz7EZS3c7g6Xv0Yj43Yy5ITpUDKltEqLYlrdUMgDu5
 o0Ch2+GR59vuoCaMIuRfCrPdU56hU+o3ge4BzhYv+gNeOHGvodzLBNxIg1ZgptZ7SYiy
 dOtjWn8KpOq3MXwrzya4T+Z8R9OuuWFUYvYQepgYh2vXaQKw+aO+mQyi5s3wWV16CK12
 E+Kg==
X-Gm-Message-State: AC+VfDw8dacdd0ixPwY/0SHI2J0mVExr3ZMAg5b+NzyN++SQMseJ79pb
 fol6NCrzJrUDI4KWVVbNo9gqHkaKrb8H1p1Zl+7DzrY=
X-Google-Smtp-Source: ACHHUZ6lEAv6WQ5TDWA0K8K0n/8krfLfuKbLC3U4WhxH7lcUXD7d/r9NUSH/VxjyvVDGgnKtIHNdmopVnrtLQP94Mzj3
MIME-Version: 1.0
X-Received: by 2002:a2e:2c14:0:b0:2a5:ff82:1795 with SMTP id
 s20-20020a2e2c14000000b002a5ff821795mr293455ljs.2.1686295100488; Fri, 09 Jun
 2023 00:18:20 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-f776b43b-c47b-422c-ad03-45ac19b158bc@google.com>
Date: Fri, 09 Jun 2023 07:18:20 +0000
Subject: Canceled event: QEMU developers fortnightly conference call @ Tue
 2023-06-13 15:00 - 16:00 (CEST) (qemu-devel@nongnu.org)
From: juan.quintela@gmail.com
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="00000000000073844805fdad2c79"
Received-SPF: pass client-ip=2a00:1450:4864:20::24a;
 envelope-from=3PNKCZA0JChc6HxA.DH5AG18x39x58.zB9D19H-01I18ABA3AH.BE3@calendar-server.bounces.google.com;
 helo=mail-lj1-x24a.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--00000000000073844805fdad2c79
Content-Type: multipart/alternative; boundary="00000000000073844605fdad2c77"

--00000000000073844605fdad2c77
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiBjYW5jZWxlZC4NCg0KUUVNVSBkZXZlbG9wZXJzIGZvcnRuaWdo
dGx5IGNvbmZlcmVuY2UgY2FsbA0KVHVlc2RheSAyMDIzLTA2LTEzIOKLhSAxNTowMCDigJMgMTY6
MDANCkNlbnRyYWwgRXVyb3BlYW4gVGltZSAtIE1hZHJpZA0KDQpMb2NhdGlvbg0KaHR0cHM6Ly9t
ZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZwkNCmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vdXJsP3E9
aHR0cHMlM0ElMkYlMkZtZWV0LmppdC5zaSUyRmt2bWNhbGxtZWV0aW5nJnNhPUQmdXN0PTE2ODY3
MjcwODAwMDAwMDAmdXNnPUFPdlZhdzNkMXNiajVwTm9JeUo2c0xCSXFPWUENCg0KDQoNCklmIHlv
dSBuZWVkIGNhbGwgZGV0YWlscywgcGxlYXNlIGNvbnRhY3QgbWU6IHF1aW50ZWxhQHJlZGhhdC5j
b20NCg0KR3Vlc3RzDQpxdWludGVsYUByZWRoYXQuY29tDQpNZWlyYXYgRGVhbg0KRmVsaXBlIEZy
YW5jaW9zaQ0KY3dAZjAwZi5vcmcNCmVibGFrZUByZWRoYXQuY29tDQplZGdhci5pZ2xlc2lhc0Bn
bWFpbC5jb20NCmlnZ3lAdGhlaWdneS5jb20NCmppZG9uZy54aWFvQGdtYWlsLmNvbQ0KUGV0ZXIg
TWF5ZGVsbA0KcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZw0Kc3RlZmFuaGFAZ21haWwuY29t
DQpXYXJuZXIgTG9zaA0Kend1Lmtlcm5lbEBnbWFpbC5jb20NCkphc29uIEd1bnRob3JwZQ0KTmVv
IEppYQ0KS29ucmFkIFdpbGsNCmFsZUByZXYubmcNCldhbmcsIFdlaSBXDQprdm0tZGV2ZWwNCm1i
dXJ0b25AcXRpLnF1YWxjb21tLmNvbQ0KUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCkpvYW8gTWFy
dGlucw0KYWZhZXJiZXJAc3VzZS5kZQ0KYmF6dWxheUByZWRoYXQuY29tDQpiYmF1bWFuQHJlZGhh
dC5jb20NCmR1c3Rpbi5raXJrbGFuZEBjYW5vbmljYWwuY29tDQplcmljLmF1Z2VyQHJlZGhhdC5j
b20NCmphbi5raXN6a2FAd2ViLmRlDQpqamhlcm5lQGxpbnV4LnZuZXQuaWJtLmNvbQ0KbWltdUBs
aW51eC52bmV0LmlibS5jb20NCnouaHVvQDEzOS5jb20NCkRhdmlkIEVkbW9uZHNvbg0KRWxlbmEg
VWZpbXRzZXZhDQphbmpvQHJldi5uZw0KU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KQ2hhbyBQ
ZW5nDQpxZW11LWRldmVsQG5vbmdudS5vcmcNCg0KDQp+fi8vfn4NCkludml0YXRpb24gZnJvbSBH
b29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci8NCg0K
WW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0ZW5kZWUg
b24gdGhlIGV2ZW50LiBUbyAgDQpzdG9wIHJlY2VpdmluZyBmdXR1cmUgdXBkYXRlcyBmb3IgdGhp
cyBldmVudCwgZGVjbGluZSB0aGlzIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlv
biBjb3VsZCBhbGxvdyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUg
b3JnYW5pemVyLCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdh
cmRsZXNzIG9mICANCnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIg
UlNWUC4NCg0KTGVhcm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9h
bnN3ZXIvMzcxMzUjZm9yd2FyZGluZw0K
--00000000000073844605fdad2c77
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
/InformAction"><span itemprop=3D"object" itemscope itemtype=3D"http://schem=
a.org/Event"><meta itemprop=3D"eventStatus" content=3D"http://schema.org/Ev=
entCancelled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://sc=
hema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar"/=
></span><meta itemprop=3D"eventId/googleCalendar" content=3D"5dt5ji87j5qrc0=
0o63ktq7ghou_20230613T130000Z"/><span style=3D"display: none; font-size: 1p=
x; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-w=
idth: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU developers f=
ortnightly conference call</span><span aria-hidden=3D"true"><time itemprop=
=3D"startDate" datetime=3D"20230613T130000Z"></time><time itemprop=3D"endDa=
te" datetime=3D"20230613T140000Z"></time></span><table border=3D"0" cellpad=
ding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=
=3D"width:100%;" class=3D"body-container"><tbody><tr><td style=3D"" class=
=3D"" align=3D"left"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0=
" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D"16" style=3D"he=
ight:16px;"><![endif]--><div style=3D"height:16px;" aria-hidden=3D"true"> &=
nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"c=
enter" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"background-=
color: #fce8e6;color: #2d0c0c;padding: 12px 32px; border-radius: 8px;font-f=
amily: Roboto, sans-serif;font-size: 14px; line-height: 20px;text-align: le=
ft;" class=3D"info-bar-inner"><span style=3D"font-weight: 700;">This event =
has been canceled.</span></td></tr></tbody></table><!--[if mso | IE]><table=
 border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr=
><td height=3D"12" style=3D"height:12px;"><![endif]--><div style=3D"height:=
12px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></tab=
le><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><tbody>=
<tr><td style=3D"border: solid 1px #dadce0; border-radius: 8px; direction: =
rtl; font-size: 0; padding: 24px 32px; text-align: left; vertical-align: to=
p;" class=3D"main-container-inner"><!--[if mso | IE]><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><![endif]--><di=
v class=3D"" style=3D"font-size: 13px; text-align: left; direction: ltr; di=
splay: inline-block; vertical-align: top; width: 100%;overflow: hidden; wor=
d-wrap: break-word;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0=
" role=3D"presentation" width=3D"100%" class=3D"main-column-table-ltr" styl=
e=3D"padding-right: 32px; padding-left: 0;;table-layout: fixed;"><tbody><tr=
><td class=3D"main-column-td" style=3D"padding:0; vertical-align:top;"><tab=
le border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" w=
idth=3D"100%" style=3D"table-layout: fixed;"><tr><td style=3D"font-size: 0;=
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
><span aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"202306=
13T130000Z"></time><time itemprop=3D"endDate" datetime=3D"20230613T140000Z"=
></time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"prima=
ry-text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;fon=
t-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">W=
hen</h2></td></tr></table><span>Tuesday 2023-06-13 =E2=8B=85 15:00 =E2=80=
=93 16:00 (Central European Time - Madrid)</span></div></td></tr><tr><td st=
yle=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;=
padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-st=
yle: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-s=
pacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text=
" role=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 cla=
ss=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text-decoratio=
n: none;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; pad=
ding: 0;">Location</h2></td></tr></table><span itemprop=3D"location" itemsc=
ope itemtype=3D"http://schema.org/Place"><span itemprop=3D"name" class=3D"p=
rimary-text notranslate" style=3D"font-family: Roboto, sans-serif;font-styl=
e: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spa=
cing: 0.2px;color: #3c4043; text-decoration: none;">https://meet.jit.si/kvm=
callmeeting</span><br/><a href=3D"https://www.google.com/url?q=3Dhttps%3A%2=
F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D1686727080000000&amp;=
usg=3DAOvVaw3d1sbj5pNoIyJ6sLBIqOYA" class=3D"accent-text underline-on-hover=
" style=3D"display: inline-block;;color: #1a73e8; text-decoration: none;fon=
t-weight: 700;" target=3D"_blank" itemprop=3D"map">View map</a></span></div=
></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; wor=
d-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Robot=
o, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-h=
eight: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" =
class=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpaddin=
g=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4p=
x;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4=
043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: antiali=
ased;margin: 0; padding: 0;">Guests</h2></td></tr></table><div style=3D"pad=
ding-bottom: 4px; text-align: left;;color: #3c4042;"><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:quintela@redhat.com">quintela@redhat.com</a></span><meta item=
prop=3D"email" content=3D"quintela@redhat.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:mdean@redhat.com">Meirav Dean</a></span><me=
ta itemprop=3D"email" content=3D"mdean@redhat.com"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:felipe@nutanix.com">Felipe Franciosi</a=
></span><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:cw@f00f.org">cw@f00f.org</=
a></span><meta itemprop=3D"email" content=3D"cw@f00f.org"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:eblake@redhat.com">eblake@redhat=
.com</a></span><meta itemprop=3D"email" content=3D"eblake@redhat.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:edgar.iglesias@gmail=
.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"email" content=
=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:iggy@theiggy.com">iggy@theiggy.com</a></span><meta itemprop=
=3D"email" content=3D"iggy@theiggy.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com</a></=
span><meta itemprop=3D"email" content=3D"jidong.xiao@gmail.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:peter.maydell@linaro.org">=
Peter Maydell</a></span><meta itemprop=3D"email" content=3D"peter.maydell@l=
inaro.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:rich=
ard.henderson@linaro.org">richard.henderson@linaro.org</a></span><meta item=
prop=3D"email" content=3D"richard.henderson@linaro.org"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:stefanha@gmail.com">stefanha@gmail=
.com</a></span><meta itemprop=3D"email" content=3D"stefanha@gmail.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:imp@bsdimp.com">W=
arner Losh</a></span><meta itemprop=3D"email" content=3D"imp@bsdimp.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:zwu.kernel@gmail.=
com">zwu.kernel@gmail.com</a></span><meta itemprop=3D"email" content=3D"zwu=
.kernel@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:jgg@nvidia.com">Jason Gunthorpe</a></span><meta itemprop=3D"email" cont=
ent=3D"jgg@nvidia.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:cjia@nvidia.com">Neo Jia</a></span><meta itemprop=3D"email" content=
=3D"cjia@nvidia.com"/></span><span class=3D"secondary-text" style=3D"color:=
 #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atten=
dee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name=
" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:konrad.wilk@oracle.com">Konrad Wilk</a></span><meta itemprop=3D"emai=
l" content=3D"konrad.wilk@oracle.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></span><meta itemprop=3D"e=
mail" content=3D"ale@rev.ng"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:wei.w.wang@intel.com">Wang, Wei W</a></span><meta itemprop=
=3D"email" content=3D"wei.w.wang@intel.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:kvm@vger.kernel.org">kvm-devel</a></span><meta=
 itemprop=3D"email" content=3D"kvm@vger.kernel.org"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.=
qualcomm.com</a></span><meta itemprop=3D"email" content=3D"mburton@qti.qual=
comm.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:f4bug=
@amsat.org">Philippe Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" =
content=3D"f4bug@amsat.org"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:joao.m.martins@oracle.com">Joao Martins</a></span><meta item=
prop=3D"email" content=3D"joao.m.martins@oracle.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:afaerber@suse.de">afaerber@suse.de</a=
></span><meta itemprop=3D"email" content=3D"afaerber@suse.de"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:bazulay@redhat.com">bazula=
y@redhat.com</a></span><meta itemprop=3D"email" content=3D"bazulay@redhat.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:bbauman@red=
hat.com">bbauman@redhat.com</a></span><meta itemprop=3D"email" content=3D"b=
bauman@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:dustin.kirkland@canonical.com">dustin.kirkland@canonical.com</a></span>=
<meta itemprop=3D"email" content=3D"dustin.kirkland@canonical.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:eric.auger@redhat.com">=
eric.auger@redhat.com</a></span><meta itemprop=3D"email" content=3D"eric.au=
ger@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D"email" co=
ntent=3D"jan.kiszka@web.de"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:jjherne@linux.vnet.ibm.com">jjherne@linux.vnet.ibm.com</a></=
span><meta itemprop=3D"email" content=3D"jjherne@linux.vnet.ibm.com"/></spa=
n><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: =
none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"=
http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;c=
olor: #3c4043; text-decoration: none;" href=3D"mailto:mimu@linux.vnet.ibm.c=
om">mimu@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" content=3D"m=
imu@linux.vnet.ibm.com"/></span><span class=3D"secondary-text" style=3D"col=
or: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"at=
tendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"n=
ame" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" sty=
le=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><meta itemprop=3D"email" =
content=3D"z.huo@139.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:david.edmondson@oracle.com">David Edmondson</a></span><meta item=
prop=3D"email" content=3D"david.edmondson@oracle.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena =
Ufimtseva</a></span><meta itemprop=3D"email" content=3D"elena.ufimtseva@ora=
cle.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; te=
xt-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsco=
pe itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"n=
otranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: =
inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:anjo@r=
ev.ng">anjo@rev.ng</a></span><meta itemprop=3D"email" content=3D"anjo@rev.n=
g"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:shameerali.k=
olothum.thodi@huawei.com">Shameerali Kolothum Thodi</a></span><meta itempro=
p=3D"email" content=3D"shameerali.kolothum.thodi@huawei.com"/></span><span =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"><=
/span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://s=
chema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D=
"primary-text underline-on-hover" style=3D"display: inline-block;;color: #3=
c4043; text-decoration: none;" href=3D"mailto:chao.p.peng@linux.intel.com">=
Chao Peng</a></span><meta itemprop=3D"email" content=3D"chao.p.peng@linux.i=
ntel.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:qemu-=
devel@nongnu.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"email" =
content=3D"qemu-devel@nongnu.org"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div></div></div></t=
d></tr></table></td></tr></tbody></table></div><!--[if mso | IE]></tr></tab=
le><![endif]--></td></tr></tbody></table><table border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width=
:100%;" class=3D""><tbody><tr><td style=3D"font-size: 0; padding: 0; text-a=
lign: left; word-break: break-word;;padding:4px 12px;" class=3D"" align=3D"=
left"><div class=3D"secondary-text" style=3D"color: #70757a; text-decoratio=
n: none;font-family: Roboto, sans-serif;font-size: 12px; line-height: 16px;=
 mso-line-height-rule: exactly; text-align: left;"><p>Invitation from <a hr=
ef=3D"https://calendar.google.com/calendar/" class=3D"accent-text underline=
-on-hover" style=3D"font-family: Roboto, sans-serif;font-size: 12px; line-h=
eight: 16px; mso-line-height-rule: exactly;;color: #1a73e8; text-decoration=
: none;" target=3D"_blank">Google Calendar</a></p><p>You are receiving this=
 email because you are an attendee on the event. To stop receiving future u=
pdates for this event, decline this event.</p><p>Forwarding this invitation=
 could allow any recipient to send a response to the organizer, be added to=
 the guest list, invite others regardless of their own invitation status, o=
r modify your RSVP. <a class=3D"accent-text underline-on-hover" style=3D"fo=
nt-family: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-=
height-rule: exactly;;color: #1a73e8; text-decoration: none;" href=3D"https=
://support.google.com/calendar/answer/37135#forwarding">Learn more</a></p><=
/div></td></tr></tbody></table></td></tr></tbody></table></span></span></bo=
dy></html>
--00000000000073844605fdad2c77
Content-Type: text/calendar; charset="UTF-8"; method=CANCEL
Content-Transfer-Encoding: 7bit

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:CANCEL
BEGIN:VTIMEZONE
TZID:America/New_York
X-LIC-LOCATION:America/New_York
BEGIN:DAYLIGHT
TZOFFSETFROM:-0500
TZOFFSETTO:-0400
TZNAME:EDT
DTSTART:19700308T020000
RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=2SU
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:-0400
TZOFFSETTO:-0500
TZNAME:EST
DTSTART:19701101T020000
RRULE:FREQ=YEARLY;BYMONTH=11;BYDAY=1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTSTART;TZID=America/New_York:20230613T090000
DTEND;TZID=America/New_York:20230613T100000
DTSTAMP:20230609T071820Z
ORGANIZER;CN=KVM call for qemu developers:mailto:eged7cki05lmu1tngvkl3thids
 @group.calendar.google.com
UID:5dt5ji87j5qrc00o63ktq7ghou@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=qu
 intela@redhat.com;X-NUM-GUESTS=0:mailto:quintela@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Me
 irav Dean;X-NUM-GUESTS=0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Fe
 lipe Franciosi;X-NUM-GUESTS=0:mailto:felipe@nutanix.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=cw
 @f00f.org;X-NUM-GUESTS=0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=eb
 lake@redhat.com;X-NUM-GUESTS=0:mailto:eblake@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=ed
 gar.iglesias@gmail.com;X-NUM-GUESTS=0:mailto:edgar.iglesias@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=ig
 gy@theiggy.com;X-NUM-GUESTS=0:mailto:iggy@theiggy.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=ji
 dong.xiao@gmail.com;X-NUM-GUESTS=0:mailto:jidong.xiao@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Pe
 ter Maydell;X-NUM-GUESTS=0:mailto:peter.maydell@linaro.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=ri
 chard.henderson@linaro.org;X-NUM-GUESTS=0:mailto:richard.henderson@linaro.o
 rg
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=st
 efanha@gmail.com;X-NUM-GUESTS=0:mailto:stefanha@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Wa
 rner Losh;X-NUM-GUESTS=0:mailto:imp@bsdimp.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=zw
 u.kernel@gmail.com;X-NUM-GUESTS=0:mailto:zwu.kernel@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Ja
 son Gunthorpe;X-NUM-GUESTS=0:mailto:jgg@nvidia.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Ne
 o Jia;X-NUM-GUESTS=0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Ko
 nrad Wilk;X-NUM-GUESTS=0:mailto:konrad.wilk@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=al
 e@rev.ng;X-NUM-GUESTS=0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN="W
 ang, Wei W";X-NUM-GUESTS=0:mailto:wei.w.wang@intel.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=kv
 m-devel;X-NUM-GUESTS=0:mailto:kvm@vger.kernel.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=mb
 urton@qti.qualcomm.com;X-NUM-GUESTS=0:mailto:mburton@qti.qualcomm.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;X-NUM
 -GUESTS=0:mailto:f4bug@amsat.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Jo
 ao Martins;X-NUM-GUESTS=0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=af
 aerber@suse.de;X-NUM-GUESTS=0:mailto:afaerber@suse.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=ba
 zulay@redhat.com;X-NUM-GUESTS=0:mailto:bazulay@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=bb
 auman@redhat.com;X-NUM-GUESTS=0:mailto:bbauman@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=du
 stin.kirkland@canonical.com;X-NUM-GUESTS=0:mailto:dustin.kirkland@canonical
 .com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=er
 ic.auger@redhat.com;X-NUM-GUESTS=0:mailto:eric.auger@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=ja
 n.kiszka@web.de;X-NUM-GUESTS=0:mailto:jan.kiszka@web.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=jj
 herne@linux.vnet.ibm.com;X-NUM-GUESTS=0:mailto:jjherne@linux.vnet.ibm.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=mi
 mu@linux.vnet.ibm.com;X-NUM-GUESTS=0:mailto:mimu@linux.vnet.ibm.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=z.
 huo@139.com;X-NUM-GUESTS=0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Da
 vid Edmondson;X-NUM-GUESTS=0:mailto:david.edmondson@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=El
 ena Ufimtseva;X-NUM-GUESTS=0:mailto:elena.ufimtseva@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=an
 jo@rev.ng;X-NUM-GUESTS=0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Sh
 ameerali Kolothum Thodi;X-NUM-GUESTS=0:mailto:shameerali.kolothum.thodi@hua
 wei.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=Ch
 ao Peng;X-NUM-GUESTS=0:mailto:chao.p.peng@linux.intel.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;CN=qe
 mu-devel@nongnu.org;X-NUM-GUESTS=0:mailto:qemu-devel@nongnu.org
RECURRENCE-ID;TZID=America/New_York:20230613T090000
CLASS:PUBLIC
CREATED:20220823T150022Z
DESCRIPTION:If you need call details\, please contact me: quintela@redhat.c
 om
LAST-MODIFIED:20230609T071818Z
LOCATION:https://meet.jit.si/kvmcallmeeting
SEQUENCE:2
STATUS:CANCELLED
SUMMARY:QEMU developers fortnightly conference call
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR

--00000000000073844605fdad2c77--

--00000000000073844805fdad2c79
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6Q0FOQ0VM
DQpCRUdJTjpWVElNRVpPTkUNClRaSUQ6QW1lcmljYS9OZXdfWW9yaw0KWC1MSUMtTE9DQVRJT046
QW1lcmljYS9OZXdfWW9yaw0KQkVHSU46REFZTElHSFQNClRaT0ZGU0VURlJPTTotMDUwMA0KVFpP
RkZTRVRUTzotMDQwMA0KVFpOQU1FOkVEVA0KRFRTVEFSVDoxOTcwMDMwOFQwMjAwMDANClJSVUxF
OkZSRVE9WUVBUkxZO0JZTU9OVEg9MztCWURBWT0yU1UNCkVORDpEQVlMSUdIVA0KQkVHSU46U1RB
TkRBUkQNClRaT0ZGU0VURlJPTTotMDQwMA0KVFpPRkZTRVRUTzotMDUwMA0KVFpOQU1FOkVTVA0K
RFRTVEFSVDoxOTcwMTEwMVQwMjAwMDANClJSVUxFOkZSRVE9WUVBUkxZO0JZTU9OVEg9MTE7QllE
QVk9MVNVDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvTmV3X1lvcms6MjAyMzA2MTNUMDkwMDAwDQpEVEVORDtUWklEPUFtZXJp
Y2EvTmV3X1lvcms6MjAyMzA2MTNUMTAwMDAwDQpEVFNUQU1QOjIwMjMwNjA5VDA3MTgyMFoNCk9S
R0FOSVpFUjtDTj1LVk0gY2FsbCBmb3IgcWVtdSBkZXZlbG9wZXJzOm1haWx0bzplZ2VkN2NraTA1
bG11MXRuZ3ZrbDN0aGlkcw0KIEBncm91cC5jYWxlbmRhci5nb29nbGUuY29tDQpVSUQ6NWR0NWpp
ODdqNXFyYzAwbzYza3RxN2dob3VAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPXF1DQogaW50
ZWxhQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnF1aW50ZWxhQHJlZGhhdC5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtDTj1NZQ0KIGlyYXYgRGVhbjtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWRl
YW5AcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPUZlDQogbGlwZSBGcmFuY2lvc2k7WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmZlbGlwZUBudXRhbml4LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWN3DQog
QGYwMGYub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjd0BmMDBmLm9yZw0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O0NOPWViDQogbGFrZUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxha2VAcmVk
aGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWVkDQogZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
Q049aWcNCiBneUB0aGVpZ2d5LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86aWdneUB0aGVpZ2d5
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWppDQogZG9uZy54aWFvQGdtYWlsLmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86amlkb25nLnhpYW9AZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049UGUNCiB0
ZXIgTWF5ZGVsbDtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047Q049cmkNCiBjaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZztYLU5VTS1H
VUVTVFM9MDptYWlsdG86cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm8NCiByZw0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO0NOPXN0DQogZWZhbmhhQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86c3RlZmFu
aGFAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049V2ENCiBybmVyIExvc2g7WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmltcEBic2RpbXAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049encNCiB1Lmtlcm5lbEBn
bWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnp3dS5rZXJuZWxAZ21haWwuY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047Q049SmENCiBzb24gR3VudGhvcnBlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqZ2dA
bnZpZGlhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPU5lDQogbyBKaWE7WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOmNqaWFAbnZpZGlhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPUtvDQogbnJhZCBXaWxrO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzprb25yYWQud2lsa0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049
YWwNCiBlQHJldi5uZztYLU5VTS1HVUVTVFM9MDptYWlsdG86YWxlQHJldi5uZw0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO0NOPSJXDQogYW5nLCBXZWkgVyI7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOndlaS53LndhbmdA
aW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049a3YNCiBtLWRldmVsO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzprdm1Admdlci5rZXJuZWwub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049bWINCiB1cnRvbkBxdGku
cXVhbGNvbW0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYnVydG9uQHF0aS5xdWFsY29tbS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtYLU5VTQ0KIC1HVUVTVFM9MDptYWlsdG86ZjRidWdAYW1zYXQub3Jn
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047Q049Sm8NCiBhbyBNYXJ0aW5zO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpq
b2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049YWYNCiBhZXJiZXJAc3Vz
ZS5kZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YWZhZXJiZXJAc3VzZS5kZQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O0NOPWJhDQogenVsYXlAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YmF6dWxheUBy
ZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049YmINCiBhdW1hbkByZWRoYXQuY29tO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzpiYmF1bWFuQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1kdQ0KIHN0
aW4ua2lya2xhbmRAY2Fub25pY2FsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZHVzdGluLmtp
cmtsYW5kQGNhbm9uaWNhbA0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1lcg0KIGljLmF1Z2VyQHJl
ZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO0NOPWphDQogbi5raXN6a2FAd2ViLmRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpq
YW4ua2lzemthQHdlYi5kZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWpqDQogaGVybmVAbGludXgudm5ldC5p
Ym0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqamhlcm5lQGxpbnV4LnZuZXQuaWJtLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO0NOPW1pDQogbXVAbGludXgudm5ldC5pYm0uY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzptaW11QGxpbnV4LnZuZXQuaWJtLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPXouDQogaHVv
QDEzOS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnouaHVvQDEzOS5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtDTj1EYQ0KIHZpZCBFZG1vbmRzb247WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmRhdmlkLmVkbW9u
ZHNvbkBvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049RWwNCiBlbmEgVWZpbXRzZXZhO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O0NOPWFuDQogam9AcmV2Lm5nO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbmpvQHJldi5uZw0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO0NOPVNoDQogYW1lZXJhbGkgS29sb3RodW0gVGhvZGk7WC1OVU0tR1VFU1RTPTA6
bWFpbHRvOnNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhDQogd2VpLmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO0NOPUNoDQogYW8gUGVuZztYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2hhby5wLnBlbmdAbGlu
dXguaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049cWUNCiBtdS1kZXZlbEBub25nbnUub3JnO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmcNClJFQ1VSUkVOQ0UtSUQ7
VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjMwNjEzVDA5MDAwMA0KQ0xBU1M6UFVCTElDDQpDUkVB
VEVEOjIwMjIwODIzVDE1MDAyMloNCkRFU0NSSVBUSU9OOklmIHlvdSBuZWVkIGNhbGwgZGV0YWls
c1wsIHBsZWFzZSBjb250YWN0IG1lOiBxdWludGVsYUByZWRoYXQuYw0KIG9tDQpMQVNULU1PRElG
SUVEOjIwMjMwNjA5VDA3MTgxOFoNCkxPQ0FUSU9OOmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2Fs
bG1lZXRpbmcNClNFUVVFTkNFOjINClNUQVRVUzpDQU5DRUxMRUQNClNVTU1BUlk6UUVNVSBkZXZl
bG9wZXJzIGZvcnRuaWdodGx5IGNvbmZlcmVuY2UgY2FsbA0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZF
VkVOVA0KRU5EOlZDQUxFTkRBUg0K
--00000000000073844805fdad2c79--

