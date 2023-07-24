Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6675EC61
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 09:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNpt0-0006GV-2F; Mon, 24 Jul 2023 03:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qNpss-0006G1-O0
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 03:21:34 -0400
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qNpsq-0004tE-O5
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 03:21:34 -0400
Received: by mail-ed1-x54a.google.com with SMTP id
 4fb4d7f45d1cf-5223bdb71e5so1532a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 00:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1690183290; x=1690788090;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9fmDMKBzPc0XU6OoSuFm76BnvcwEQPTNGtWNJfwvvq4=;
 b=MdlfmmW3UnuUApU2E1IsI6dKLuH1baEVo0TRXLXBH4k4N6tOQZCQFPpW9NXtBuY1KI
 p3CcbSsUA6oKYSHs6BbrKLovAam/IHqq/V6EeE8DFn7jYJOf6FvzAsbf2TiND99C/dxh
 J3HFQAXpep69+RTJp8kSsL8O1wokMcxm1BBm15M6GYwlAst7B4m41/bTy9IhTiyj+YQ2
 p65lT5TImSPfbFO1WDrrE6KRQLJhXOlWNpTVn/U/yOITX1Fgj9Tc4LgLYBwllr22oNea
 al0ZVwIlk456hX3KHZMZZgiHcg8jQpJuk6NgBD3jnUYg9ljf3kLDLVIM6OBqulzbL7as
 mohw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690183290; x=1690788090;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9fmDMKBzPc0XU6OoSuFm76BnvcwEQPTNGtWNJfwvvq4=;
 b=YUOwIlktNO5SXf39ieirf/kp9W2672gvO/M5qYTXnWx8oX/sRAgsqHeJJpCSUvkmte
 QoPlcY/gxlekZY3nLdb+HbAAeXukR3BdR40aJS44ewMYRwMXTXp6d7SosfpVIi2m9Qen
 6xpkcVHyXbT9Qg+ouQCvOWpuPzAeLfluKlKnpXQB2zrv52z7x/VGNo0lb2S2GBqJf/vJ
 G4Yn5otZgHotL5zENbHxinHvll62IG1w8gc2wUt+OHld2thhdUJj3sz2drUbuv+2yipM
 I0Vz5ee/QJh1JnGgb2df2zgkgo7e1dCINRhoPglhm2nmtvgwueCNQbuOPw0+jeSKavAS
 dyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690183290; x=1690788090;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9fmDMKBzPc0XU6OoSuFm76BnvcwEQPTNGtWNJfwvvq4=;
 b=TgwgjtETG7oKkgIfEVyGmtkcT7/BAo2DyM4yBXDyNr98gTt2MOe2E/A/P/Qhq4oYsI
 FtfNMt8Gil99Ds0iLtXhQ92lgPltEmHCpPTj3my97I+Qk+FYpiiI+8HwcQvdFwTyUHcY
 cqsXHitHCGy8vDRrvN5QQLE/X7zvUkLnJrFzq88DVrVX1MHH+troDns8+rd8gF+1OIHp
 ZBtYpTwYlcgZyAuosSd4R9pA9vVaqmVE+1799eVQTYuaHwFb6cIDBWSztZ7m0Ngegw57
 8mXMV1KQMCx2qNYE6UIBwvHptLHA2Mmxdzb3dHLZP5OOXuKCytXuGtQOszQlxDHItmKv
 k9kw==
X-Gm-Message-State: ABy/qLbWMDIxe18H+m724DANSYmxTvFIBzJTb6Fy+6MUXSgwvrLmEcP4
 7fcWGiq1gHNhRFuVv6JVcLQgBgiJvv9WkZLCPhiH
X-Google-Smtp-Source: APBJJlF+QEEOyTS5/oSW2/xbj24SFHSCM4KQTwpUrb1BPb6haXDbiZ+JE9JW5efrb3RcIlYugTBgzA8ygfUzGlwj0CQy
MIME-Version: 1.0
X-Received: by 2002:a50:ed94:0:b0:522:1e50:1e3e with SMTP id
 h20-20020a50ed94000000b005221e501e3emr3939510edr.12.1690183290570; Mon, 24
 Jul 2023 00:21:30 -0700 (PDT)
Message-ID: <calendar-cfc70c5d-07f1-400a-bd54-324ef46c4936@google.com>
Date: Mon, 24 Jul 2023 07:21:30 +0000
Subject: 2023-07-25 QEMU developers fortnightly conference call for agenda
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
Content-Type: multipart/alternative; boundary="000000000000a3e2cb060136766f"
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

--000000000000a3e2cb060136766f
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgSWYgeW91IGhhdmUgdG9waWNzIGZvciB0aGlzIHdlZWsgY2FsbCwgcGxlYXNlIGxldCdzIHVz
IG5vdy4gTGF0ZXIsIEp1YW4uDQoNClFFTVUgZGV2ZWxvcGVycyBmb3J0bmlnaHRseSBjb25mZXJl
bmNlIGNhbGwNClR1ZXNkYXkgMjAyMy0wNy0yNSDii4UgMTU6MDAg4oCTIDE2OjAwDQpDZW50cmFs
IEV1cm9wZWFuIFRpbWUgLSBNYWRyaWQNCg0KTG9jYXRpb24NCmh0dHBzOi8vbWVldC5qaXQuc2kv
a3ZtY2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5nb29nbGUuY29tL3VybD9xPWh0dHBzJTNBJTJG
JTJGbWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGluZyZzYT1EJnVzdD0xNjkwNjE1MjYwMDAwMDAw
JnVzZz1BT3ZWYXcyT1RYLUhIVF96TzVWc1JlY0pCbmVqDQoNCg0KDQpJZiB5b3UgbmVlZCBjYWxs
IGRldGFpbHMsIHBsZWFzZSBjb250YWN0IG1lOiBxdWludGVsYUByZWRoYXQuY29tDQoNCkd1ZXN0
cw0KUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCkpvYW8gTWFydGlucw0KcXVpbnRlbGFAcmVkaGF0
LmNvbQ0KTWVpcmF2IERlYW4NCkZlbGlwZSBGcmFuY2lvc2kNCmFmYWVyYmVyQHN1c2UuZGUNCmJh
enVsYXlAcmVkaGF0LmNvbQ0KYmJhdW1hbkByZWRoYXQuY29tDQpjd0BmMDBmLm9yZw0KZHVzdGlu
LmtpcmtsYW5kQGNhbm9uaWNhbC5jb20NCmVibGFrZUByZWRoYXQuY29tDQplZGdhci5pZ2xlc2lh
c0BnbWFpbC5jb20NCmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KaWdneUB0aGVpZ2d5LmNvbQ0KamFu
Lmtpc3prYUB3ZWIuZGUNCmppZG9uZy54aWFvQGdtYWlsLmNvbQ0KampoZXJuZUBsaW51eC52bmV0
LmlibS5jb20NCm1pbXVAbGludXgudm5ldC5pYm0uY29tDQpQZXRlciBNYXlkZWxsDQpyaWNoYXJk
LmhlbmRlcnNvbkBsaW5hcm8ub3JnDQpzdGVmYW5oYUBnbWFpbC5jb20NCldhcm5lciBMb3NoDQp6
Lmh1b0AxMzkuY29tDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KSmFzb24gR3VudGhvcnBlDQpOZW8g
SmlhDQpEYXZpZCBFZG1vbmRzb24NCkVsZW5hIFVmaW10c2V2YQ0KS29ucmFkIFdpbGsNCmFsZUBy
ZXYubmcNCmFuam9AcmV2Lm5nDQpTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQpXYW5nLCBXZWkg
Vw0KQ2hhbyBQZW5nDQpxZW11LWRldmVsQG5vbmdudS5vcmcNCm1idXJ0b25AcXRpLnF1YWxjb21t
LmNvbQ0KDQoNCg==
--000000000000a3e2cb060136766f
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
ntent=3D"juan.quintela@gmail.com: Hi If you have topics for this week call,=
 please let&#39;s us now. Later, Juan."/></span><span itemprop=3D"object" i=
temscope itemtype=3D"http://schema.org/Event"><meta itemprop=3D"eventStatus=
" content=3D"http://schema.org/EventScheduled"/><span itemprop=3D"publisher=
" itemscope itemtype=3D"http://schema.org/Organization"><meta itemprop=3D"n=
ame" content=3D"Google Calendar"/></span><meta itemprop=3D"eventId/googleCa=
lendar" content=3D"5dt5ji87j5qrc00o63ktq7ghou_20230725T130000Z"/><span styl=
e=3D"display: none; font-size: 1px; color: #fff; line-height: 1px; height: =
0; max-height: 0; width: 0; max-width: 0; opacity: 0; overflow: hidden;" it=
emprop=3D"name">QEMU developers fortnightly conference call</span><span ari=
a-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20230725T130000Z=
"></time><time itemprop=3D"endDate" datetime=3D"20230725T140000Z"></time></=
span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presen=
tation" align=3D"center" style=3D"width:100%;" class=3D"body-container"><tb=
ody><tr><td style=3D"" class=3D"" align=3D"left"><!--[if mso | IE]><table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><=
td height=3D"16" style=3D"height:16px;"><![endif]--><div style=3D"height:16=
px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></table=
><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><tbody>=
<tr><td style=3D"" class=3D"" align=3D"left"><span itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><p itemprop=3D"description">Hi<p>If you have =
topics for this week call, please let&#39;s us now.<p>Later, Juan.</p></spa=
n></td></tr></tbody></table><table border=3D"0" cellpadding=3D"0" cellspaci=
ng=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" class=
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
me itemprop=3D"startDate" datetime=3D"20230725T130000Z"></time><time itempr=
op=3D"endDate" datetime=3D"20230725T140000Z"></time></span><span>Tuesday 20=
23-07-25 =E2=8B=85 15:00 =E2=80=93 16:00 (Central European Time - Madrid)</=
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
st=3D1690615260000000&amp;usg=3DAOvVaw2OTX-HHT_zO5VsRecJBnej" class=3D"acce=
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
n: none;" href=3D"mailto:mdean@redhat.com">Meirav Dean</a></span><meta item=
prop=3D"email" content=3D"mdean@redhat.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:felipe@nutanix.com">Felipe Franciosi</a></span=
><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/></span><span clas=
s=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></spa=
n></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schem=
a.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pri=
mary-text underline-on-hover" style=3D"display: inline-block;;color: #3c404=
3; text-decoration: none;" href=3D"mailto:afaerber@suse.de">afaerber@suse.d=
e</a></span><meta itemprop=3D"email" content=3D"afaerber@suse.de"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:bazulay@redhat.com">bazu=
lay@redhat.com</a></span><meta itemprop=3D"email" content=3D"bazulay@redhat=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:bbauman@r=
edhat.com">bbauman@redhat.com</a></span><meta itemprop=3D"email" content=3D=
"bbauman@redhat.com"/></span><span class=3D"secondary-text" style=3D"color:=
 #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atten=
dee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name=
" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:cw@f00f.org">cw@f00f.org</a></span><meta itemprop=3D"email" content=
=3D"cw@f00f.org"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:dustin.kirkland@canonical.com">dustin.kirkland@canonical.com</a></span><m=
eta itemprop=3D"email" content=3D"dustin.kirkland@canonical.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:eblake@redhat.com">eblake=
@redhat.com</a></span><meta itemprop=3D"email" content=3D"eblake@redhat.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:edgar.iglesia=
s@gmail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"email" co=
ntent=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a></span>=
<meta itemprop=3D"email" content=3D"eric.auger@redhat.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:iggy@theiggy.com">iggy@theiggy.=
com</a></span><meta itemprop=3D"email" content=3D"iggy@theiggy.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:jan.kiszka@web.de">jan=
.kiszka@web.de</a></span><meta itemprop=3D"email" content=3D"jan.kiszka@web=
.de"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jidong.xia=
o@gmail.com">jidong.xiao@gmail.com</a></span><meta itemprop=3D"email" conte=
nt=3D"jidong.xiao@gmail.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:jjherne@linux.vnet.ibm.com">jjherne@linux.vnet.ibm.com</a><=
/span><meta itemprop=3D"email" content=3D"jjherne@linux.vnet.ibm.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:mimu@linux.vnet.ibm.=
com">mimu@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" content=3D"=
mimu@linux.vnet.ibm.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:peter.maydell@linaro.org">Peter Maydell</a></span><meta itemprop=
=3D"email" content=3D"peter.maydell@linaro.org"/></span><span class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><=
div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Per=
son"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text=
 underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-d=
ecoration: none;" href=3D"mailto:richard.henderson@linaro.org">richard.hend=
erson@linaro.org</a></span><meta itemprop=3D"email" content=3D"richard.hend=
erson@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee=
" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" c=
lass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"=
display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mail=
to:stefanha@gmail.com">stefanha@gmail.com</a></span><meta itemprop=3D"email=
" content=3D"stefanha@gmail.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div><div><span itemp=
rop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span item=
prop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-h=
over" style=3D"display: inline-block;;color: #3c4043; text-decoration: none=
;" href=3D"mailto:imp@bsdimp.com">Warner Losh</a></span><meta itemprop=3D"e=
mail" content=3D"imp@bsdimp.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div><div><span itemp=
rop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span item=
prop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-h=
over" style=3D"display: inline-block;;color: #3c4043; text-decoration: none=
;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><meta itemprop=3D"=
email" content=3D"z.huo@139.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div><div><span itemp=
rop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span item=
prop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-h=
over" style=3D"display: inline-block;;color: #3c4043; text-decoration: none=
;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmail.com</a></span><met=
a itemprop=3D"email" content=3D"zwu.kernel@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:jgg@nvidia.com">Jason Gunthorpe</a=
></span><meta itemprop=3D"email" content=3D"jgg@nvidia.com"/></span><span c=
lass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></=
span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sc=
hema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"=
primary-text underline-on-hover" style=3D"display: inline-block;;color: #3c=
4043; text-decoration: none;" href=3D"mailto:cjia@nvidia.com">Neo Jia</a></=
span><meta itemprop=3D"email" content=3D"cjia@nvidia.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:david.edmondson@oracle.com">Davi=
d Edmondson</a></span><meta itemprop=3D"email" content=3D"david.edmondson@o=
racle.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:elen=
a.ufimtseva@oracle.com">Elena Ufimtseva</a></span><meta itemprop=3D"email" =
content=3D"elena.ufimtseva@oracle.com"/></span><span class=3D"secondary-tex=
t" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span=
 itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><spa=
n itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underlin=
e-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration=
: none;" href=3D"mailto:konrad.wilk@oracle.com">Konrad Wilk</a></span><meta=
 itemprop=3D"email" content=3D"konrad.wilk@oracle.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></span><=
meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:anjo@rev.ng">anjo@rev.ng</a></span><meta it=
emprop=3D"email" content=3D"anjo@rev.ng"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:shameerali.kolothum.thodi@huawei.com">Shameerali =
Kolothum Thodi</a></span><meta itemprop=3D"email" content=3D"shameerali.kol=
othum.thodi@huawei.com"/></span><span class=3D"secondary-text" style=3D"col=
or: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"at=
tendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"n=
ame" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" sty=
le=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:wei.w.wang@intel.com">Wang, Wei W</a></span><meta itemprop=3D"em=
ail" content=3D"wei.w.wang@intel.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:chao.p.peng@linux.intel.com">Chao Peng</a></span><me=
ta itemprop=3D"email" content=3D"chao.p.peng@linux.intel.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qem=
u-devel@nongnu.org</a></span><meta itemprop=3D"email" content=3D"qemu-devel=
@nongnu.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:m=
burton@qti.qualcomm.com">mburton@qti.qualcomm.com</a></span><meta itemprop=
=3D"email" content=3D"mburton@qti.qualcomm.com"/></span><span class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><=
/div></div></td></tr></table></td></tr></tbody></table></div><!--[if mso | =
IE]></tr></table><![endif]--></td></tr></tbody></table></td></tr></tbody></=
table></span></span></body></html>
--000000000000a3e2cb060136766f--

