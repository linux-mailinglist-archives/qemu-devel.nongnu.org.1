Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF1A7DB8AF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:05:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQ4J-00052H-1S; Mon, 30 Oct 2023 07:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qxQ4H-000525-Ec
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:04:25 -0400
Received: from mail-lj1-x24a.google.com ([2a00:1450:4864:20::24a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qxQ4F-0006dC-5R
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:04:25 -0400
Received: by mail-lj1-x24a.google.com with SMTP id
 38308e7fff4ca-2c131ddfcfaso44368421fa.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698663861; x=1699268661; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yQAvIRyDM09XbTFdsp2L8rcJNrzQVrzjTqTIgxoPhCQ=;
 b=Tpl6Bswb8V489W/Lj5IBL4FzIX5gICb352C894anDW74+KjVOP1h5rCrXPu2n3ix1Y
 iMpL1mwqYF4pqfk5UC3zG0CB+IiwtlqPcR3WNU7rjKl0F0f1gA0j6QbXQpfBkrzhrvz/
 94cqlC7v4C5ROtWCE+gG3ujLJD5lpVyM+qCSMSZQUMX66H04qPs07orFUquwZuaYWnXC
 BFv628L+5LwF5wi8k1+FIv8WzvPmGKnZgqN4VSvA56M0kdCZubmJRDeYkCo7nuQN2qOa
 aMTdqRB68PnQWAY2H8B5UoKuFZ3h7sqJxV+KePC6hHZoxFcgtop4mmL2sEAAcpstIQ20
 CpOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698663861; x=1699268661; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yQAvIRyDM09XbTFdsp2L8rcJNrzQVrzjTqTIgxoPhCQ=;
 b=kzYachh9G9ePT59qrzqyritICXRKHqomVN1x4Id1tM33rxxKkj6/RD7d+mrGGs8XY5
 ktw9ELZzwbaN4UbcZmq+k4uRDDjVXggrmbWNZh15yOW7bV4SacAs6VmI2IkqkzNU0Eo7
 zaI+CEFT2zhsSXeIwtQxSQVZqRGUAjJf8/2/tAt/PaKjYH7OFUHb3hByhmgby5A4xFGW
 WEKnXEKQuwmCiVeHQ6ChrwlGWS21lyw0XlbBOyQGVppYwUgjQyEFfSx4it37s5EoA54f
 dLUUrFXle1k+diKTiFNdX/jxKj9hoCBO5RrABds0W8cyEtvCdED1nCQE56c6m8nn7dzZ
 21nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698663861; x=1699268661;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yQAvIRyDM09XbTFdsp2L8rcJNrzQVrzjTqTIgxoPhCQ=;
 b=oESXLnQvgxYJ6YJI94hOAgeKR2HFgzibm6oqudHK8wm2p8Ek3KnOCVSh4V64SabjTI
 Otojf6ntDc6Imf4y1EiSdw6FjhXQ+mZAUBE/45sFG/mIe1eDD9wBe5tR8hYGPuNpSTA0
 oEzwdTKapUY25crFEaiPka3226hldrIwFp9W46nXL7DnrRS/m36g7iHJT12jrPI9Kx0Q
 DgXsEfW2iCc9MXcJClky7GSy8zvbMwxVtrZrdSCKEfqqpLtprK9iewtUeRGCbr+pIvBt
 JUHeXhUzYxFP86lyI33VHHSM7O72b09pfSuEC5y9NLpdIfNWgYsRsp0oNPFsIiuUAgMj
 PMKg==
X-Gm-Message-State: AOJu0YwjKHDQygeBzQr9/W3+Q0HdW7oWvhva4T3+xPR1Fs4fJaPmuW1X
 wyf2rIN1D3PV/hpM4oiewPAsRb9LCW2bdAn5x7Hu
X-Google-Smtp-Source: AGHT+IE2IdCnBzn1nhbhmimhw41ymJ0uGlkUW6YI6mPc1QM4g5n3KVrg+w8TV381gbV+96Kx3zoyTMSzC7aunM9a3uot
MIME-Version: 1.0
X-Received: by 2002:a05:6512:10c3:b0:4f3:9136:9cd0 with SMTP id
 k3-20020a05651210c300b004f391369cd0mr7099716lfg.44.1698663860778; Mon, 30 Oct
 2023 04:04:20 -0700 (PDT)
Message-ID: <calendar-1ad16449-09cc-40fb-ab4a-24eafcc62d2a@google.com>
Date: Mon, 30 Oct 2023 11:04:20 +0000
Subject: QEMU developers fortnightly conference call for 2023-10-31
From: Juan Quintela <juan.quintela@gmail.com>
To: afaerber@suse.de, ale@rev.ng, anjo@rev.ng, bazulay@redhat.com, 
 bbauman@redhat.com, chao.p.peng@linux.intel.com, cjia@nvidia.com, cw@f00f.org, 
 david.edmondson@oracle.com, dustin.kirkland@canonical.com, eblake@redhat.com, 
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
Content-Type: multipart/alternative; boundary="00000000000003c2d70608ed00c7"
Received-SPF: pass client-ip=2a00:1450:4864:20::24a;
 envelope-from=juan.quintela@gmail.com; helo=mail-lj1-x24a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000003c2d70608ed00c7
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgSWYgeW91IGhhdmUgYW55IHRvcGljcyBmb3IgdGhpcyB3ZWVrIENvbmZlcmVuY2UgY2FsbCwg
cGxlYXNlIGFuc3dlciB0byAgDQp0aGlzIGVtYWlsLiBUaGFua3MsIEp1YW4uDQoNClFFTVUgZGV2
ZWxvcGVycyBmb3J0bmlnaHRseSBjb25mZXJlbmNlIGNhbGwNClR1ZXNkYXkgMjAyMy0xMC0zMSDi
i4UgMTQ6MDAg4oCTIDE1OjAwDQpDZW50cmFsIEV1cm9wZWFuIFRpbWUgLSBNYWRyaWQNCg0KTG9j
YXRpb24NCmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5n
b29nbGUuY29tL3VybD9xPWh0dHBzJTNBJTJGJTJGbWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGlu
ZyZzYT1EJnVzdD0xNjk5MDk1ODQwMDAwMDAwJnVzZz1BT3ZWYXcyTWZMbmpOMjB5RnEwM3l1czIy
el9qDQoNCg0KDQpJZiB5b3UgbmVlZCBjYWxsIGRldGFpbHMsIHBsZWFzZSBjb250YWN0IG1lOiBx
dWludGVsYUByZWRoYXQuY29tDQoNCkd1ZXN0cw0KUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCkpv
YW8gTWFydGlucw0KcXVpbnRlbGFAcmVkaGF0LmNvbQ0KbWRlYW5AcmVkaGF0LmNvbQ0KZmVsaXBl
QG51dGFuaXguY29tDQphZmFlcmJlckBzdXNlLmRlDQpiYXp1bGF5QHJlZGhhdC5jb20NCmJiYXVt
YW5AcmVkaGF0LmNvbQ0KY3dAZjAwZi5vcmcNCmR1c3Rpbi5raXJrbGFuZEBjYW5vbmljYWwuY29t
DQplYmxha2VAcmVkaGF0LmNvbQ0KZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tDQplcmljLmF1Z2Vy
QHJlZGhhdC5jb20NCmlnZ3lAdGhlaWdneS5jb20NCmphbi5raXN6a2FAd2ViLmRlDQpqaWRvbmcu
eGlhb0BnbWFpbC5jb20NCmpqaGVybmVAbGludXgudm5ldC5pYm0uY29tDQptaW11QGxpbnV4LnZu
ZXQuaWJtLmNvbQ0KcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnDQpyaWNoYXJkLmhlbmRlcnNvbkBs
aW5hcm8ub3JnDQpzdGVmYW5oYUBnbWFpbC5jb20NCmltcEBic2RpbXAuY29tDQp6Lmh1b0AxMzku
Y29tDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KamdnQG52aWRpYS5jb20NCmNqaWFAbnZpZGlhLmNv
bQ0KZGF2aWQuZWRtb25kc29uQG9yYWNsZS5jb20NCkVsZW5hIFVmaW10c2V2YQ0Ka29ucmFkLndp
bGtAb3JhY2xlLmNvbQ0KYWxlQHJldi5uZw0KYW5qb0ByZXYubmcNClNoYW1lZXJhbGkgS29sb3Ro
dW0gVGhvZGkNCndlaS53LndhbmdAaW50ZWwuY29tDQpDaGFvIFBlbmcNCnFlbXUtZGV2ZWxAbm9u
Z251Lm9yZw0KbWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tDQoNCg0K
--00000000000003c2d70608ed00c7
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
ntent=3D"Juan Quintela: Hi If you have any topics for this week Conference =
call, please answer to this email. Thanks, Juan."/></span><span itemprop=3D=
"object" itemscope itemtype=3D"http://schema.org/Event"><meta itemprop=3D"e=
ventStatus" content=3D"http://schema.org/EventScheduled"/><span itemprop=3D=
"publisher" itemscope itemtype=3D"http://schema.org/Organization"><meta ite=
mprop=3D"name" content=3D"Google Calendar"/></span><meta itemprop=3D"eventI=
d/googleCalendar" content=3D"5dt5ji87j5qrc00o63ktq7ghou_20231031T130000Z"/>=
<span style=3D"display: none; font-size: 1px; color: #fff; line-height: 1px=
; height: 0; max-height: 0; width: 0; max-width: 0; opacity: 0; overflow: h=
idden;" itemprop=3D"name">QEMU developers fortnightly conference call</span=
><span aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"202310=
31T130000Z"></time><time itemprop=3D"endDate" datetime=3D"20231031T140000Z"=
></time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D"body-cont=
ainer"><tbody><tr><td style=3D"" class=3D"" align=3D"left"><!--[if mso | IE=
]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentat=
ion"><tr><td height=3D"16" style=3D"height:16px;"><![endif]--><div style=3D=
"height:16px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></=
tr></table><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D=
"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""=
><tbody><tr><td style=3D"" class=3D"" align=3D"left"><span itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><p itemprop=3D"description">Hi<p>If y=
ou have any topics for this week Conference call, please answer to this ema=
il.<p>Thanks, Juan.</p></span></td></tr></tbody></table><table border=3D"0"=
 cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center"=
 style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"border: solid 1px=
 #dadce0; border-radius: 8px; direction: rtl; font-size: 0; padding: 24px 3=
2px; text-align: left; vertical-align: top;" class=3D"main-container-inner"=
><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" =
role=3D"presentation"><tr><![endif]--><div class=3D"" style=3D"font-size: 1=
3px; text-align: left; direction: ltr; display: inline-block; vertical-alig=
n: top; width: 100%;overflow: hidden; word-wrap: break-word;"><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"1=
00%" class=3D"main-column-table-ltr" style=3D"padding-right: 32px; padding-=
left: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main-column-td" styl=
e=3D"padding:0; vertical-align:top;"><table border=3D"0" cellpadding=3D"0" =
cellspacing=3D"0" role=3D"presentation" width=3D"100%" style=3D"table-layou=
t: fixed;"><tr><td style=3D"font-size: 0; padding: 0; text-align: left; wor=
d-break: break-word;;padding-bottom:2px;"><div style=3D"font-family: &#39;G=
oogle Sans&#39;, Roboto, sans-serif;font-weight: 400; font-size: 22px; line=
-height: 28px;color: #3c4043; text-decoration: none;" class=3D"primary-text=
" role=3D"presentation"><span itemprop=3D"name">QEMU developers fortnightly=
 conference call</span></div></td></tr><tr><td style=3D"font-size: 0; paddi=
ng: 0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div=
 style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: =
400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c40=
43; text-decoration: none;" class=3D"primary-text" role=3D"presentation"><s=
pan aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20231031T=
130000Z"></time><time itemprop=3D"endDate" datetime=3D"20231031T140000Z"></=
time></span><span>Tuesday 2023-10-31 =E2=8B=85 14:00 =E2=80=93 15:00 (Centr=
al European Time - Madrid)</span></div></td></tr><tr><td style=3D"font-size=
: 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:2=
4px;"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; fon=
t-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;co=
lor: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presen=
tation"><span>If you need call details, please contact me: <a href=3D"mailt=
o:quintela@redhat.com" target=3D"_blank">quintela@redhat.com</a></span><met=
a itemprop=3D"description" content=3D"If you need call details, please cont=
act me: quintela@redhat.com"/></div></td></tr><tr><td style=3D"font-size: 0=
; padding: 0; text-align: left; word-break: break-word;;padding-bottom:24px=
;"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-w=
eight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color=
: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presentat=
ion"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presen=
tation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" s=
tyle=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight: =
700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Location</h=
2></td></tr></table><span itemprop=3D"location" itemscope itemtype=3D"http:=
//schema.org/Place"><span itemprop=3D"name" class=3D"primary-text notransla=
te" style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weigh=
t: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3=
c4043; text-decoration: none;">https://meet.jit.si/kvmcallmeeting</span><br=
/><a href=3D"https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvm=
callmeeting&amp;sa=3DD&amp;ust=3D1699095840000000&amp;usg=3DAOvVaw2MfLnjN20=
yFq03yus22z_j" class=3D"accent-text underline-on-hover" style=3D"display: i=
nline-block;;color: #1a73e8; text-decoration: none;font-weight: 700;" targe=
t=3D"_blank" itemprop=3D"map">View map</a></span></div></td></tr><tr><td st=
yle=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;=
padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-st=
yle: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-s=
pacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text=
" role=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 cla=
ss=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text-decoratio=
n: none;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; pad=
ding: 0;">Guests</h2></td></tr></table><div style=3D"padding-bottom: 4px; t=
ext-align: left;;color: #3c4042;"><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:f4bug@a=
msat.org">Philippe Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" co=
ntent=3D"f4bug@amsat.org"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:joao.m.martins@oracle.com">Joao Martins</a></span><meta itemprop=
=3D"email" content=3D"joao.m.martins@oracle.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:quintela@redhat.com">quintela@redhat.com<=
/a></span><meta itemprop=3D"email" content=3D"quintela@redhat.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:mdean@redhat.com">mdean=
@redhat.com</a></span><meta itemprop=3D"email" content=3D"mdean@redhat.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:felipe@nutanix=
.com">felipe@nutanix.com</a></span><meta itemprop=3D"email" content=3D"feli=
pe@nutanix.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:afaerber@suse.de">afaerber@suse.de</a></span><meta itemprop=3D"email" cont=
ent=3D"afaerber@suse.de"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:bazulay@redhat.com">bazulay@redhat.com</a></span><meta itemprop=
=3D"email" content=3D"bazulay@redhat.com"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:bbauman@redhat.com">bbauman@redhat.com</a></span=
><meta itemprop=3D"email" content=3D"bbauman@redhat.com"/></span><span clas=
s=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></spa=
n></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schem=
a.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pri=
mary-text underline-on-hover" style=3D"display: inline-block;;color: #3c404=
3; text-decoration: none;" href=3D"mailto:cw@f00f.org">cw@f00f.org</a></spa=
n><meta itemprop=3D"email" content=3D"cw@f00f.org"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:dustin.kirkland@canonical.com">dustin.k=
irkland@canonical.com</a></span><meta itemprop=3D"email" content=3D"dustin.=
kirkland@canonical.com"/></span><span class=3D"secondary-text" style=3D"col=
or: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"at=
tendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"n=
ame" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" sty=
le=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:eblake@redhat.com">eblake@redhat.com</a></span><meta itemprop=3D=
"email" content=3D"eblake@redhat.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</=
a></span><meta itemprop=3D"email" content=3D"edgar.iglesias@gmail.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:eric.auger@redhat=
.com">eric.auger@redhat.com</a></span><meta itemprop=3D"email" content=3D"e=
ric.auger@redhat.com"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:iggy@theiggy.com">iggy@theiggy.com</a></span><meta itemprop=3D"email=
" content=3D"iggy@theiggy.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta itempr=
op=3D"email" content=3D"jan.kiszka@web.de"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com</a=
></span><meta itemprop=3D"email" content=3D"jidong.xiao@gmail.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:jjherne@linux.vnet.ibm.=
com">jjherne@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" content=
=3D"jjherne@linux.vnet.ibm.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.com</a></span=
><meta itemprop=3D"email" content=3D"mimu@linux.vnet.ibm.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:peter.maydell@linaro.org">=
peter.maydell@linaro.org</a></span><meta itemprop=3D"email" content=3D"pete=
r.maydell@linaro.org"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a></span=
><meta itemprop=3D"email" content=3D"richard.henderson@linaro.org"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:stefanha@gmail.com">ste=
fanha@gmail.com</a></span><meta itemprop=3D"email" content=3D"stefanha@gmai=
l.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:imp@bsdi=
mp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=3D"imp@bs=
dimp.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:z.huo=
@139.com">z.huo@139.com</a></span><meta itemprop=3D"email" content=3D"z.huo=
@139.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:zwu.k=
ernel@gmail.com">zwu.kernel@gmail.com</a></span><meta itemprop=3D"email" co=
ntent=3D"zwu.kernel@gmail.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a></span><meta itemprop=3D"=
email" content=3D"jgg@nvidia.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:cjia@nvidia.com">cjia@nvidia.com</a></span><meta itempro=
p=3D"email" content=3D"cjia@nvidia.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:david.edmondson@oracle.com">david.edmondson@oracle=
.com</a></span><meta itemprop=3D"email" content=3D"david.edmondson@oracle.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:elena.ufimt=
seva@oracle.com">Elena Ufimtseva</a></span><meta itemprop=3D"email" content=
=3D"elena.ufimtseva@oracle.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:konrad.wilk@oracle.com">konrad.wilk@oracle.com</a></span><=
meta itemprop=3D"email" content=3D"konrad.wilk@oracle.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></spa=
n><meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:anjo@rev.ng">anjo@rev.ng</a></span><meta=
 itemprop=3D"email" content=3D"anjo@rev.ng"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:shameerali.kolothum.thodi@huawei.com">Shameera=
li Kolothum Thodi</a></span><meta itemprop=3D"email" content=3D"shameerali.=
kolothum.thodi@huawei.com"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a></span><meta it=
emprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:chao.p.peng@linux.intel.com">Chao Peng</=
a></span><meta itemprop=3D"email" content=3D"chao.p.peng@linux.intel.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:qemu-devel@nongn=
u.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"email" content=3D"=
qemu-devel@nongnu.org"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</a></span><meta =
itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div></div></div></td></tr></table></td></tr></tbody></table></div><!--[i=
f mso | IE]></tr></table><![endif]--></td></tr></tbody></table></td></tr></=
tbody></table></span></span></body></html>
--00000000000003c2d70608ed00c7--

