Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D24B805666
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 14:49:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAVmK-0008Nu-Jo; Tue, 05 Dec 2023 08:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1rAVmG-0008L3-VY
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 08:47:57 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1rAVmE-000078-6N
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 08:47:56 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-40b4096abc8so43209305e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 05:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701784072; x=1702388872; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ryWt3v0qt2fSt9rePtGHmNkYEZVoKkOy50FkABPoSok=;
 b=Ju6R4d+fMkEJCKvxyP8J36wvAXT9OpgZsOM0AGDhSBkiyPw5CXT8/f+UT4Wfx1x4v+
 98nB5r41xIansS5yJ/TDb7VHDhKmNOj9jEWDciIvv+NBzp+VeRKp4as1ov2df2Df9Duo
 pbZiF7fEMlWLCJm1Xf6jC4yYIk1gTUZqjoz/dzj1K2MUs8FFfw1oyphc6mCMqGRLiUWM
 l0uEgLY9Pt+DO/1iiDWh20bnvhVnFCzTgVIMFJQ37MZaY/evRZpcQ96DBWspyMPO/xdE
 L+DW0l8CjumhUQt6MHbqcRqNEUld3YScMIq7nWJz7mHo9kSLGdXJZ6+ZGC7qIdEY3TxH
 nFGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701784072; x=1702388872; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ryWt3v0qt2fSt9rePtGHmNkYEZVoKkOy50FkABPoSok=;
 b=LBGKFjkwn/Y7x84HW7lQRtcUBAPeHK6JuDWH08X53/ybE3W2ez9ppRmexI0+NHlRap
 fKp1mzuwnaiWvRJ+YeudSEx3l3V0hU242uwmYDiJkCB1GADMzWpsGsCsKgiiyaUPig7c
 r2eUhfXrPph1dZwW3NdMPclv1QwqB6XVoExOCA1PwYt4U4gwQf+QDVy2lxy4CR/vRR1k
 JRxL0c0BCEtmfnYKevkaBJrCi4JHQZaUAJYFDH4k/Pym8qutVKJGkFQ67L4waO1kQHZs
 Mudzt2ojRALQeibcTiA4IF00uA4W1rOSxoFXgIgSMQDR1NzKkYARLqk/E2fupqYCxPhs
 Q5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701784072; x=1702388872;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ryWt3v0qt2fSt9rePtGHmNkYEZVoKkOy50FkABPoSok=;
 b=vSzWUx4vkIp3NsNXnC0X86fzOrctsexJXPmN9rl8NRQC7gU82EdWZ9v6DICwuI4uTE
 Jg2r2TagMkD1t4gSjhxgp7Ha93GPSHLQp7JW2xX/c0HGS6HAGhfUGY3OYjWO3Uvoa6lK
 stHgOH+C9aiB6IfvTpniw5RUXMD2F/DBjHjX9Hq4LzebmSFpaRQ49Qj+Feej/Y+SI5ky
 z0QE0dEj6cuHJYN9XjkrJ516XI9pamXUSYB9hPRXQ0zAW0AD+QcBFJ1CQGLUocZm39CG
 /lDW3odV55Y1koczNA5ElIiPUsA1B6XU0LnMqlI8Si8xKWm/krVQ5t1rzGI4TaPLcqS4
 I8Mg==
X-Gm-Message-State: AOJu0Yx4h5IGeqRzKtgeqT2tUhBGufMChQ9DvJUJGLQ/iDNy7C7wNUhU
 kkuXxDqioKq1HPhxS2dbtxhgolCdwm6OPF2r6HX5
X-Google-Smtp-Source: AGHT+IFMsTZleRIIssGhHWGUXMjC8cvnc7PXLolnp2yzKuJsQrUj2XPHYF10gDHncFrpMcNaNBEcJqr7b1fKkvkfl11y
MIME-Version: 1.0
X-Received: by 2002:a05:600c:2203:b0:40c:8ab:7992 with SMTP id
 z3-20020a05600c220300b0040c08ab7992mr349794wml.242.1701784072117; Tue, 05 Dec
 2023 05:47:52 -0800 (PST)
Message-ID: <calendar-98548e19-3517-40fa-a2ae-1c384aa3f98f@google.com>
Date: Tue, 05 Dec 2023 13:47:52 +0000
Subject: QEMU developers fortnightly conference call for agenda for 2023-12-12
From: Juan Quintela <juan.quintela@gmail.com>
To: afaerber@suse.de, ale@rev.ng, anjo@rev.ng, bbauman@redhat.com, 
 chao.p.peng@linux.intel.com, cjia@nvidia.com, cw@f00f.org, eblake@redhat.com, 
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, eric.auger@redhat.com, 
 f4bug@amsat.org, "felipe@nutanix.com" <felipe.franciosi@nutanix.com>, 
 "iggy@theiggy.com" <iggy@kws1.com>, "imp@bsdimp.com" <wlosh@bsdimp.com>,
 jan.kiszka@web.de, jgg@nvidia.com, 
 jidong.xiao@gmail.com, jjherne@linux.vnet.ibm.com, joao.m.martins@oracle.com, 
 konrad.wilk@oracle.com, mburton@qti.qualcomm.com, mdean@redhat.com, 
 mimu@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 quintela@redhat.com, richard.henderson@linaro.org, 
 shameerali.kolothum.thodi@huawei.com, stefanha@gmail.com, 
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com, 
 Juan Quintela <juan.quintela@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001a64f0060bc37b74"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=juan.quintela@gmail.com; helo=mail-wm1-x34a.google.com
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
Reply-To: Juan Quintela <juan.quintela@gmail.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--0000000000001a64f0060bc37b74
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgSWYgeW91IGhhdmUgYW55IHRvcGljcyBmb3IgdGhlIGxhc3QgcWVtdSBjb25mZXJlbmNlIGNh
bGwgb2YgdGhlIHllYXIsICANCmZlZWwgZnJlZSB0byBhbnN3ZXIgdG8gdGhpcyBlbWFpbC4gTGF0
ZXIsIEp1YW4uDQoNClFFTVUgZGV2ZWxvcGVycyBmb3J0bmlnaHRseSBjb25mZXJlbmNlIGNhbGwN
ClR1ZXNkYXkgMjAyMy0xMi0xMiDii4UgMTU6MDAg4oCTIDE2OjAwDQpDZW50cmFsIEV1cm9wZWFu
IFRpbWUgLSBNYWRyaWQNCg0KTG9jYXRpb24NCmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1l
ZXRpbmcJDQpodHRwczovL3d3dy5nb29nbGUuY29tL3VybD9xPWh0dHBzJTNBJTJGJTJGbWVldC5q
aXQuc2klMkZrdm1jYWxsbWVldGluZyZzYT1EJnVzdD0xNzAyMjE2MDIwMDAwMDAwJnVzZz1BT3ZW
YXcxeHJwUFNtTVJ1OW5peTF0cnFDS3JBDQoNCg0KDQpJZiB5b3UgbmVlZCBjYWxsIGRldGFpbHMs
IHBsZWFzZSBjb250YWN0IG1lOiBxdWludGVsYUByZWRoYXQuY29tDQoNCkd1ZXN0cw0KUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kNCkpvYW8gTWFydGlucw0KcXVpbnRlbGFAcmVkaGF0LmNvbQ0KbWRl
YW5AcmVkaGF0LmNvbQ0KZmVsaXBlQG51dGFuaXguY29tDQphZmFlcmJlckBzdXNlLmRlDQpiYmF1
bWFuQHJlZGhhdC5jb20NCmN3QGYwMGYub3JnDQplYmxha2VAcmVkaGF0LmNvbQ0KZWRnYXIuaWds
ZXNpYXNAZ21haWwuY29tDQplcmljLmF1Z2VyQHJlZGhhdC5jb20NCmlnZ3lAdGhlaWdneS5jb20N
Cmphbi5raXN6a2FAd2ViLmRlDQpqaWRvbmcueGlhb0BnbWFpbC5jb20NCmpqaGVybmVAbGludXgu
dm5ldC5pYm0uY29tDQptaW11QGxpbnV4LnZuZXQuaWJtLmNvbQ0KcGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnDQpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnDQpzdGVmYW5oYUBnbWFpbC5jb20N
CmltcEBic2RpbXAuY29tDQp6Lmh1b0AxMzkuY29tDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0Kamdn
QG52aWRpYS5jb20NCmNqaWFAbnZpZGlhLmNvbQ0KRWxlbmEgVWZpbXRzZXZhDQprb25yYWQud2ls
a0BvcmFjbGUuY29tDQphbGVAcmV2Lm5nDQphbmpvQHJldi5uZw0KU2hhbWVlcmFsaSBLb2xvdGh1
bSBUaG9kaQ0Kd2VpLncud2FuZ0BpbnRlbC5jb20NCkNoYW8gUGVuZw0KcWVtdS1kZXZlbEBub25n
bnUub3JnDQptYnVydG9uQHF0aS5xdWFsY29tbS5jb20NCg0KDQo=
--0000000000001a64f0060bc37b74
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
ntent=3D"Juan Quintela: Hi If you have any topics for the last qemu confere=
nce call of the year, feel free to answer to this email. Later, Juan."/></s=
pan><span itemprop=3D"object" itemscope itemtype=3D"http://schema.org/Event=
"><meta itemprop=3D"eventStatus" content=3D"http://schema.org/EventSchedule=
d"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://schema.org/Or=
ganization"><meta itemprop=3D"name" content=3D"Google Calendar"/></span><me=
ta itemprop=3D"eventId/googleCalendar" content=3D"5dt5ji87j5qrc00o63ktq7gho=
u_20231212T140000Z"/><span style=3D"display: none; font-size: 1px; color: #=
fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; op=
acity: 0; overflow: hidden;" itemprop=3D"name">QEMU developers fortnightly =
conference call</span><span aria-hidden=3D"true"><time itemprop=3D"startDat=
e" datetime=3D"20231212T140000Z"></time><time itemprop=3D"endDate" datetime=
=3D"20231212T150000Z"></time></span><table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%=
;" class=3D"body-container"><tbody><tr><td style=3D"" class=3D"" align=3D"l=
eft"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D=
"0" role=3D"presentation"><tr><td height=3D"16" style=3D"height:16px;"><![e=
ndif]--><div style=3D"height:16px;" aria-hidden=3D"true"> &nbsp; </div><!--=
[if mso | IE]></td></tr></table><![endif]--><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"wi=
dth:100%;" class=3D""><tbody><tr><td style=3D"" class=3D"" align=3D"left"><=
span itemscope itemtype=3D"http://schema.org/EmailMessage"><p itemprop=3D"d=
escription">Hi<br>If you have any topics for the last qemu conference call =
of the year, feel free to answer to this email.<p>Later, Juan.</p></span></=
td></tr></tbody></table><table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" class=
=3D""><tbody><tr><td style=3D"border: solid 1px #dadce0; border-radius: 8px=
; direction: rtl; font-size: 0; padding: 24px 32px; text-align: left; verti=
cal-align: top;" class=3D"main-container-inner"><!--[if mso | IE]><table bo=
rder=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><!=
[endif]--><div class=3D"" style=3D"font-size: 13px; text-align: left; direc=
tion: ltr; display: inline-block; vertical-align: top; width: 100%;overflow=
: hidden; word-wrap: break-word;"><table border=3D"0" cellpadding=3D"0" cel=
lspacing=3D"0" role=3D"presentation" width=3D"100%" class=3D"main-column-ta=
ble-ltr" style=3D"padding-right: 32px; padding-left: 0;;table-layout: fixed=
;"><tbody><tr><td class=3D"main-column-td" style=3D"padding:0; vertical-ali=
gn:top;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pr=
esentation" width=3D"100%" style=3D"table-layout: fixed;"><tr><td style=3D"=
font-size: 0; padding: 0; text-align: left; word-break: break-word;;padding=
-bottom:2px;"><div style=3D"font-family: &#39;Google Sans&#39;, Roboto, san=
s-serif;font-weight: 400; font-size: 22px; line-height: 28px;color: #3c4043=
; text-decoration: none;" class=3D"primary-text" role=3D"presentation"><spa=
n itemprop=3D"name">QEMU developers fortnightly conference call</span></div=
></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; wor=
d-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Robot=
o, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-h=
eight: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" =
class=3D"primary-text" role=3D"presentation"><span aria-hidden=3D"true"><ti=
me itemprop=3D"startDate" datetime=3D"20231212T140000Z"></time><time itempr=
op=3D"endDate" datetime=3D"20231212T150000Z"></time></span><span>Tuesday 20=
23-12-12 =E2=8B=85 15:00 =E2=80=93 16:00 (Central European Time - Madrid)</=
span></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align:=
 left; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-fam=
ily: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14=
px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoratio=
n: none;" class=3D"primary-text" role=3D"presentation"><span>If you need ca=
ll details, please contact me: <a href=3D"mailto:quintela@redhat.com" targe=
t=3D"_blank">quintela@redhat.com</a></span><meta itemprop=3D"description" c=
ontent=3D"If you need call details, please contact me: quintela@redhat.com"=
/></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: le=
ft; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-family=
: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px;=
 line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: =
none;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" cel=
lpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bot=
tom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;colo=
r: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: =
antialiased;margin: 0; padding: 0;">Location</h2></td></tr></table><span it=
emprop=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span it=
emprop=3D"name" class=3D"primary-text notranslate" style=3D"font-family: Ro=
boto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; lin=
e-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none=
;">https://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.goo=
gle.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;u=
st=3D1702216020000000&amp;usg=3DAOvVaw1xrpPSmMRu9niy1trqCKrA" class=3D"acce=
nt-text underline-on-hover" style=3D"display: inline-block;;color: #1a73e8;=
 text-decoration: none;font-weight: 700;" target=3D"_blank" itemprop=3D"map=
">View map</a></span></div></td></tr><tr><td style=3D"font-size: 0; padding=
: 0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div s=
tyle=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 40=
0; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043=
; text-decoration: none;" class=3D"primary-text" role=3D"presentation"><tab=
le border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" s=
tyle=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"f=
ont-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webk=
it-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2></td></tr=
></table><div style=3D"padding-bottom: 4px; text-align: left;;color: #3c404=
2;"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:f4bug@amsat.org">Philippe Mathieu-Dau=
d=C3=A9</a></span><meta itemprop=3D"email" content=3D"f4bug@amsat.org"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:joao.m.martins@or=
acle.com">Joao Martins</a></span><meta itemprop=3D"email" content=3D"joao.m=
.martins@oracle.com"/></span><span class=3D"secondary-text" style=3D"color:=
 #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atten=
dee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name=
" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:quintela@redhat.com">quintela@redhat.com</a></span><meta itemprop=3D=
"email" content=3D"quintela@redhat.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:mdean@redhat.com">mdean@redhat.com</a></span><meta=
 itemprop=3D"email" content=3D"mdean@redhat.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:felipe@nutanix.com">felipe@nutanix.com</a=
></span><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:afaerber@suse.de">afaerber=
@suse.de</a></span><meta itemprop=3D"email" content=3D"afaerber@suse.de"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:bbauman@redhat.co=
m">bbauman@redhat.com</a></span><meta itemprop=3D"email" content=3D"bbauman=
@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:c=
w@f00f.org">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f0=
0f.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@=
redhat.com">eblake@redhat.com</a></span><meta itemprop=3D"email" content=3D=
"eblake@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</a></span><meta i=
temprop=3D"email" content=3D"edgar.iglesias@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:eric.auger@redhat.com">eric.auger@=
redhat.com</a></span><meta itemprop=3D"email" content=3D"eric.auger@redhat.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:iggy@theig=
gy.com">iggy@theiggy.com</a></span><meta itemprop=3D"email" content=3D"iggy=
@theiggy.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:j=
an.kiszka@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D"email" cont=
ent=3D"jan.kiszka@web.de"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com</a></span><meta ite=
mprop=3D"email" content=3D"jidong.xiao@gmail.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:jjherne@linux.vnet.ibm.com">jjherne@linu=
x.vnet.ibm.com</a></span><meta itemprop=3D"email" content=3D"jjherne@linux.=
vnet.ibm.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:m=
imu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.com</a></span><meta itemprop=3D=
"email" content=3D"mimu@linux.vnet.ibm.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro=
.org</a></span><meta itemprop=3D"email" content=3D"peter.maydell@linaro.org=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:richard.hende=
rson@linaro.org">richard.henderson@linaro.org</a></span><meta itemprop=3D"e=
mail" content=3D"richard.henderson@linaro.org"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a><=
/span><meta itemprop=3D"email" content=3D"stefanha@gmail.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:imp@bsdimp.com">imp@bsdimp=
.com</a></span><meta itemprop=3D"email" content=3D"imp@bsdimp.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:z.huo@139.com">z.huo@13=
9.com</a></span><meta itemprop=3D"email" content=3D"z.huo@139.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:zwu.kernel@gmail.com">z=
wu.kernel@gmail.com</a></span><meta itemprop=3D"email" content=3D"zwu.kerne=
l@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:j=
gg@nvidia.com">jgg@nvidia.com</a></span><meta itemprop=3D"email" content=3D=
"jgg@nvidia.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:cjia@nvidia.com">cjia@nvidia.com</a></span><meta itemprop=3D"email" conte=
nt=3D"cjia@nvidia.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></span><meta itempro=
p=3D"email" content=3D"elena.ufimtseva@oracle.com"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:konrad.wilk@oracle.com">konrad.wilk@ora=
cle.com</a></span><meta itemprop=3D"email" content=3D"konrad.wilk@oracle.co=
m"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:ale@rev.ng">=
ale@rev.ng</a></span><meta itemprop=3D"email" content=3D"ale@rev.ng"/></spa=
n><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: =
none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"=
http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;c=
olor: #3c4043; text-decoration: none;" href=3D"mailto:anjo@rev.ng">anjo@rev=
.ng</a></span><meta itemprop=3D"email" content=3D"anjo@rev.ng"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:shameerali.kolothum.thodi@=
huawei.com">Shameerali Kolothum Thodi</a></span><meta itemprop=3D"email" co=
ntent=3D"shameerali.kolothum.thodi@huawei.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com<=
/a></span><meta itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:chao.p.peng@linux.inte=
l.com">Chao Peng</a></span><meta itemprop=3D"email" content=3D"chao.p.peng@=
linux.intel.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"=
email" content=3D"qemu-devel@nongnu.org"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.co=
m</a></span><meta itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div></div></div></td></tr></table></td></tr></tbody></=
table></div><!--[if mso | IE]></tr></table><![endif]--></td></tr></tbody></=
table></td></tr></tbody></table></span></span></body></html>
--0000000000001a64f0060bc37b74--

