Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E6A7B5547
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:35:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnJzw-0001td-4p; Mon, 02 Oct 2023 10:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qnJzt-0001tA-8m
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:34:09 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qnJzm-0008Cp-J4
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:34:09 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so148537175e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696257239; x=1696862039; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GmLVzUsDfqMtsOsjBMLT7kx87B4GhjxWNL5MNBNJddQ=;
 b=Y4jKN/APaU9lY/MWyfYibML3Ryjtz4E9d7xWiMqXnn7CUOadJDu808/a5aBqizdQhW
 QDRDcQv3I0N2WO9gr+oj98ddvIP5ArGAwBVrs2Bx+PgaZT1HJFMVFJImZpXjPf/q2JNo
 mjEq1BrlHHpgVFiuiyrT4wNVLYPGOY5yQan7acuGMSHt8X7LermKud0Rw9m+B9N2qGMc
 2op1PJsM2YbqpVS2Lgt2L7OO8LXnOmaiP7cgBFsrLVIjPe5CzJodyymB3bGz2EMAhPlC
 0efNQcfhc2M/iAaaoTG98F6opkOVWK94kVcDSBCXwhP7PhxQ8hYY+RUddpE2ZEbYoN1z
 rqmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696257239; x=1696862039; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GmLVzUsDfqMtsOsjBMLT7kx87B4GhjxWNL5MNBNJddQ=;
 b=FmhhEyq/i3dvLoHhJsCY6b6y61sQR2M85qqbNTNs8ySTinxa2YQR1Lbi9K71HsJBTh
 xJMj32oITPwD5LweUI60YENg7enxFgY2uA06FSfI+fdcDvFngnj4uYYbkcmJG/nXIqEA
 xxoADlnl4BEtIlpzrO15T9ikgzxn5+ainEJxZYAFhUiyzJeobZYou4+vcL9t9WxFGprO
 vihqOgwE7vxp4a2VRMfTCQBZM3O/6aOGZhT3KDmfAW4qfr+kOM755aaITVKcNxOtOj3s
 Dfi7x83AiUR4g7JGnoosuq3smSnYcusNcYlyCTOkpzb0Qadb3doFn0czcJ/mt5mesJO6
 ynHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257239; x=1696862039;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GmLVzUsDfqMtsOsjBMLT7kx87B4GhjxWNL5MNBNJddQ=;
 b=ZEkSI1PeBoPqbS8yiZzVlbIAKN2VDZQeoWLO5afCOk4CTXXostSP7dOWk1/DkyyL0m
 orMDLLJdecPeMXaleSNtVFfxE+jAp3FnwF+aD6dfK4k5CyltdyvBP6UVS530nW0CRGGt
 7ncBob/6188grtJUlrCkHj1sdZ8Eqz4xOWNAaA83p1RYXacG4mT/7Na5nswZeysoYM64
 7aLwt0nKwnPJzpcQOpH6K5y3+qAhPYCryMV9+oR9Yun+6Za61umIO7h0i2JSEGGSuFpv
 iOlJM6BWUUiRpg1M9Yr1c6UtK+bktwuqhhBjrN5yWhvhBz7AAV89xktMgx1a7990a6Q9
 k6FQ==
X-Gm-Message-State: AOJu0Yw6/0pLOoTsbnU1FtIYmW7Vmk88gav2hTBGS3tDiFJBc6wIvlqW
 D3QCpAbIoI/R37rTqaFfwR5V8Fwd4e30sZmD8sp5
X-Google-Smtp-Source: AGHT+IHwky6FB4m1QxBCf+oTc2CEyO2OdzyAn9cddat9rg85e+B3ANWyrww/ahyFz7uGWaxoPcckVlRkXQPrpVSsAXNG
MIME-Version: 1.0
X-Received: by 2002:a05:600c:20d4:b0:405:40ec:415d with SMTP id
 y20-20020a05600c20d400b0040540ec415dmr10498185wmm.39.1696257239170; Mon, 02
 Oct 2023 07:33:59 -0700 (PDT)
Message-ID: <calendar-0e96c26a-faa8-4ba1-9c52-9d2b5f23f21a@google.com>
Date: Mon, 02 Oct 2023 14:33:59 +0000
Subject: QEMU developers agenda for 2023-10-03
From: Juan Quintela <juan.quintela@gmail.com>
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
Content-Type: multipart/alternative; boundary="0000000000003045c30606bcaa19"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=juan.quintela@gmail.com; helo=mail-wm1-x349.google.com
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

--0000000000003045c30606bcaa19
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgVGhpcyB3ZWVrIHdlIGhhdmUgYWdlbmRhOiAqIFdoZXJlIGFyZSB3ZSB3aXRoIHRoZSDigJxT
aW5nbGUgQmluYXJ54oCdIHdvcmsuICANCi0gc3RpbGwgb3V0c3RhbmRpbmcgcXVlc3Rpb25zIG9u
IHRoZSB3aG9sZSDigJxzdGFydHVw4oCdIHN1YmplY3QgKHJlbGF0ZWQsIGJ1dCAgDQpub3QgdGhl
IHNhbWUpICogdGhlIHBsdWdpbi1BUEkgdG8gY292ZXIg4oCYaWNvdW504oCZIHVzZSBjYXNlcyAt
IHRoYXQgc2VlbXMgdG8gIA0KYmUgbnVkZ2luZyBvcGVuIGEgcGFuZG9yYeKAmXMgYm94ICogTWln
cmF0aW9uIGlzc3VlcyAtIGNvbW11bml0eSB0aG91Z2h0cyBvbiAgDQp0aGUgbGl2ZSBtaWdyYXRp
b24gc2VyaWVzIHJldmlldy9wdWxsIHByb2dyZXNzIChhdG9taWNzLCB6ZXJvIHBhZ2UgbXVsdGlm
ZCAgDQpldGMuLiApPyBMYXRlciwgSnVhbi4NCg0KUUVNVSBkZXZlbG9wZXJzIGZvcnRuaWdodGx5
IGNvbmZlcmVuY2UgY2FsbA0KVHVlc2RheSAyMDIzLTEwLTAzIOKLhSAxNTowMCDigJMgMTY6MDAN
CkNlbnRyYWwgRXVyb3BlYW4gVGltZSAtIE1hZHJpZA0KDQpMb2NhdGlvbg0KaHR0cHM6Ly9tZWV0
LmppdC5zaS9rdm1jYWxsbWVldGluZwkNCmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vdXJsP3E9aHR0
cHMlM0ElMkYlMkZtZWV0LmppdC5zaSUyRmt2bWNhbGxtZWV0aW5nJnNhPUQmdXN0PTE2OTY2ODkx
ODAwMDAwMDAmdXNnPUFPdlZhdzFidTd2TThpdU1fMmR2UnVkYVl0ZngNCg0KDQoNCklmIHlvdSBu
ZWVkIGNhbGwgZGV0YWlscywgcGxlYXNlIGNvbnRhY3QgbWU6IHF1aW50ZWxhQHJlZGhhdC5jb20N
Cg0KR3Vlc3RzDQpxdWludGVsYUByZWRoYXQuY29tDQpNZWlyYXYgRGVhbg0KRmVsaXBlIEZyYW5j
aW9zaQ0KY3dAZjAwZi5vcmcNCmVibGFrZUByZWRoYXQuY29tDQplZGdhci5pZ2xlc2lhc0BnbWFp
bC5jb20NCmlnZ3lAdGhlaWdneS5jb20NCmppZG9uZy54aWFvQGdtYWlsLmNvbQ0KUGV0ZXIgTWF5
ZGVsbA0KcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZw0Kc3RlZmFuaGFAZ21haWwuY29tDQpX
YXJuZXIgTG9zaA0Kend1Lmtlcm5lbEBnbWFpbC5jb20NCkphc29uIEd1bnRob3JwZQ0KTmVvIEpp
YQ0KRGF2aWQgRWRtb25kc29uDQpLb25yYWQgV2lsaw0KYWxlQHJldi5uZw0KV2FuZywgV2VpIFcN
Cm1idXJ0b25AcXRpLnF1YWxjb21tLmNvbQ0KUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCkpvYW8g
TWFydGlucw0KYWZhZXJiZXJAc3VzZS5kZQ0KYmF6dWxheUByZWRoYXQuY29tDQpiYmF1bWFuQHJl
ZGhhdC5jb20NCmR1c3Rpbi5raXJrbGFuZEBjYW5vbmljYWwuY29tDQplcmljLmF1Z2VyQHJlZGhh
dC5jb20NCmphbi5raXN6a2FAd2ViLmRlDQpqamhlcm5lQGxpbnV4LnZuZXQuaWJtLmNvbQ0KbWlt
dUBsaW51eC52bmV0LmlibS5jb20NCnouaHVvQDEzOS5jb20NCkVsZW5hIFVmaW10c2V2YQ0KYW5q
b0ByZXYubmcNClNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCkNoYW8gUGVuZw0KcWVtdS1kZXZl
bEBub25nbnUub3JnDQoNCg0K
--0000000000003045c30606bcaa19
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
ntent=3D"Juan Quintela: Hi This week we have agenda: * Where are we with th=
e =E2=80=9CSingle Binary=E2=80=9D work. - still outstanding questions on th=
e whole =E2=80=9Cstartup=E2=80=9D subject (related, but not the same) * the=
 plugin-API to cover =E2=80=98icount=E2=80=99 use cases - that seems to be =
nudging open a pandora=E2=80=99s box * Migration issues - community thought=
s on the live migration series review/pull progress (atomics, zero page mul=
tifd etc.. )? Later, Juan."/></span><span itemprop=3D"object" itemscope ite=
mtype=3D"http://schema.org/Event"><meta itemprop=3D"eventStatus" content=3D=
"http://schema.org/EventScheduled"/><span itemprop=3D"publisher" itemscope =
itemtype=3D"http://schema.org/Organization"><meta itemprop=3D"name" content=
=3D"Google Calendar"/></span><meta itemprop=3D"eventId/googleCalendar" cont=
ent=3D"5dt5ji87j5qrc00o63ktq7ghou_20231003T130000Z"/><span style=3D"display=
: none; font-size: 1px; color: #fff; line-height: 1px; height: 0; max-heigh=
t: 0; width: 0; max-width: 0; opacity: 0; overflow: hidden;" itemprop=3D"na=
me">QEMU developers fortnightly conference call</span><span aria-hidden=3D"=
true"><time itemprop=3D"startDate" datetime=3D"20231003T130000Z"></time><ti=
me itemprop=3D"endDate" datetime=3D"20231003T140000Z"></time></span><table =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" alig=
n=3D"center" style=3D"width:100%;" class=3D"body-container"><tbody><tr><td =
style=3D"" class=3D"" align=3D"left"><!--[if mso | IE]><table border=3D"0" =
cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D=
"16" style=3D"height:16px;"><![endif]--><div style=3D"height:16px;" aria-hi=
dden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--=
><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentati=
on" align=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td style=
=3D"" class=3D"" align=3D"left"><span itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><p itemprop=3D"description">Hi<p>This week we have agenda:=
<br>*  Where are we with the =E2=80=9CSingle Binary=E2=80=9D work.<br>  - s=
till outstanding questions on the whole =E2=80=9Cstartup=E2=80=9D subject (=
related, but not the same)<br>* the plugin-API to cover =E2=80=98icount=E2=
=80=99 use cases<br>   - that seems to be nudging open a pandora=E2=80=99s =
box<br>* Migration issues<br>- community thoughts on the live migration ser=
ies review/pull progress (atomics, zero page multifd etc.. )?<p>Later, Juan=
.<p></p></span></td></tr></tbody></table><table border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width=
:100%;" class=3D""><tbody><tr><td style=3D"border: solid 1px #dadce0; borde=
r-radius: 8px; direction: rtl; font-size: 0; padding: 24px 32px; text-align=
: left; vertical-align: top;" class=3D"main-container-inner"><!--[if mso | =
IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"present=
ation"><tr><![endif]--><div class=3D"" style=3D"font-size: 13px; text-align=
: left; direction: ltr; display: inline-block; vertical-align: top; width: =
100%;overflow: hidden; word-wrap: break-word;"><table border=3D"0" cellpadd=
ing=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%" class=3D"m=
ain-column-table-ltr" style=3D"padding-right: 32px; padding-left: 0;;table-=
layout: fixed;"><tbody><tr><td class=3D"main-column-td" style=3D"padding:0;=
 vertical-align:top;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"=
0" role=3D"presentation" width=3D"100%" style=3D"table-layout: fixed;"><tr>=
<td style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-=
word;;padding-bottom:2px;"><div style=3D"font-family: &#39;Google Sans&#39;=
, Roboto, sans-serif;font-weight: 400; font-size: 22px; line-height: 28px;c=
olor: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"prese=
ntation"><span itemprop=3D"name">QEMU developers fortnightly conference cal=
l</span></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-ali=
gn: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-=
family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size:=
 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decora=
tion: none;" class=3D"primary-text" role=3D"presentation"><span aria-hidden=
=3D"true"><time itemprop=3D"startDate" datetime=3D"20231003T130000Z"></time=
><time itemprop=3D"endDate" datetime=3D"20231003T140000Z"></time></span><sp=
an>Tuesday 2023-10-03 =E2=8B=85 15:00 =E2=80=93 16:00 (Central European Tim=
e - Madrid)</span></div></td></tr><tr><td style=3D"font-size: 0; padding: 0=
; text-align: left; word-break: break-word;;padding-bottom:24px;"><div styl=
e=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; =
font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; t=
ext-decoration: none;" class=3D"primary-text" role=3D"presentation"><span>I=
f you need call details, please contact me: <a href=3D"mailto:quintela@redh=
at.com" target=3D"_blank">quintela@redhat.com</a></span><meta itemprop=3D"d=
escription" content=3D"If you need call details, please contact me: quintel=
a@redhat.com"/></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; t=
ext-align: left; word-break: break-word;;padding-bottom:24px;"><div style=
=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; f=
ont-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; te=
xt-decoration: none;" class=3D"primary-text" role=3D"presentation"><table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=
=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-=
size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-f=
ont-smoothing: antialiased;margin: 0; padding: 0;">Location</h2></td></tr><=
/table><span itemprop=3D"location" itemscope itemtype=3D"http://schema.org/=
Place"><span itemprop=3D"name" class=3D"primary-text notranslate" style=3D"=
font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-=
size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-d=
ecoration: none;">https://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"=
https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&a=
mp;sa=3DD&amp;ust=3D1696689180000000&amp;usg=3DAOvVaw1bu7vM8iuM_2dvRudaYtfx=
" class=3D"accent-text underline-on-hover" style=3D"display: inline-block;;=
color: #1a73e8; text-decoration: none;font-weight: 700;" target=3D"_blank" =
itemprop=3D"map">View map</a></span></div></td></tr><tr><td style=3D"font-s=
ize: 0; padding: 0; text-align: left; word-break: break-word;;padding-botto=
m:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; =
font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px=
;color: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"pre=
sentation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"=
presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-t=
ext" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-we=
ight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Guest=
s</h2></td></tr></table><div style=3D"padding-bottom: 4px; text-align: left=
;;color: #3c4042;"><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:quintela@redhat.com">q=
uintela@redhat.com</a></span><meta itemprop=3D"email" content=3D"quintela@r=
edhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:mdea=
n@redhat.com">Meirav Dean</a></span><meta itemprop=3D"email" content=3D"mde=
an@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
felipe@nutanix.com">Felipe Franciosi</a></span><meta itemprop=3D"email" con=
tent=3D"felipe@nutanix.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:cw@f00f.org">cw@f00f.org</a></span><meta itemprop=3D"email" =
content=3D"cw@f00f.org"/></span><span class=3D"secondary-text" style=3D"col=
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
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:iggy@theiggy.com"=
>iggy@theiggy.com</a></span><meta itemprop=3D"email" content=3D"iggy@theigg=
y.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jidong.x=
iao@gmail.com">jidong.xiao@gmail.com</a></span><meta itemprop=3D"email" con=
tent=3D"jidong.xiao@gmail.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:peter.maydell@linaro.org">Peter Maydell</a></span><meta ite=
mprop=3D"email" content=3D"peter.maydell@linaro.org"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:richard.henderson@linaro.org">richard=
.henderson@linaro.org</a></span><meta itemprop=3D"email" content=3D"richard=
.henderson@linaro.org"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:stefanha@gmail.com">stefanha@gmail.com</a></span><meta itemprop=3D"=
email" content=3D"stefanha@gmail.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:imp@bsdimp.com">Warner Losh</a></span><meta itemprop=
=3D"email" content=3D"imp@bsdimp.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmail.com</a></span=
><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:jgg@nvidia.com">Jason Gunthorpe=
</a></span><meta itemprop=3D"email" content=3D"jgg@nvidia.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:cjia@nvidia.com">Neo Jia</=
a></span><meta itemprop=3D"email" content=3D"cjia@nvidia.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:david.edmondson@oracle.com=
">David Edmondson</a></span><meta itemprop=3D"email" content=3D"david.edmon=
dson@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:konrad.wilk@oracle.com">Konrad Wilk</a></span><meta itemprop=3D"email" co=
ntent=3D"konrad.wilk@oracle.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div><div><span itemp=
rop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span item=
prop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-h=
over" style=3D"display: inline-block;;color: #3c4043; text-decoration: none=
;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></span><meta itemprop=3D"email"=
 content=3D"ale@rev.ng"/></span><span class=3D"secondary-text" style=3D"col=
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
 none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</=
a></span><meta itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:f4bug@amsat.org">=
Philippe Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" content=3D"f=
4bug@amsat.org"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:joao.m.martins@oracle.com">Joao Martins</a></span><meta itemprop=3D"email"=
 content=3D"joao.m.martins@oracle.com"/></span><span class=3D"secondary-tex=
t" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span=
 itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><spa=
n itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underlin=
e-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration=
: none;" href=3D"mailto:afaerber@suse.de">afaerber@suse.de</a></span><meta =
itemprop=3D"email" content=3D"afaerber@suse.de"/></span><span class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><=
div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Per=
son"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text=
 underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-d=
ecoration: none;" href=3D"mailto:bazulay@redhat.com">bazulay@redhat.com</a>=
</span><meta itemprop=3D"email" content=3D"bazulay@redhat.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:bbauman@redhat.com">bbauma=
n@redhat.com</a></span><meta itemprop=3D"email" content=3D"bbauman@redhat.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:dustin.kirk=
land@canonical.com">dustin.kirkland@canonical.com</a></span><meta itemprop=
=3D"email" content=3D"dustin.kirkland@canonical.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:eric.auger@redhat.com">eric.auger@red=
hat.com</a></span><meta itemprop=3D"email" content=3D"eric.auger@redhat.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jan.kiszka@we=
b.de">jan.kiszka@web.de</a></span><meta itemprop=3D"email" content=3D"jan.k=
iszka@web.de"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:j=
jherne@linux.vnet.ibm.com">jjherne@linux.vnet.ibm.com</a></span><meta itemp=
rop=3D"email" content=3D"jjherne@linux.vnet.ibm.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.v=
net.ibm.com</a></span><meta itemprop=3D"email" content=3D"mimu@linux.vnet.i=
bm.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:z.huo@1=
39.com">z.huo@139.com</a></span><meta itemprop=3D"email" content=3D"z.huo@1=
39.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:elena.u=
fimtseva@oracle.com">Elena Ufimtseva</a></span><meta itemprop=3D"email" con=
tent=3D"elena.ufimtseva@oracle.com"/></span><span class=3D"secondary-text" =
style=3D"color: #70757a; text-decoration: none;"></span></div><div><span it=
emprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span i=
temprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-o=
n-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: n=
one;" href=3D"mailto:anjo@rev.ng">anjo@rev.ng</a></span><meta itemprop=3D"e=
mail" content=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:shameerali.kolothum.thodi@huawei.com">Shameerali Kolothum T=
hodi</a></span><meta itemprop=3D"email" content=3D"shameerali.kolothum.thod=
i@huawei.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:c=
hao.p.peng@linux.intel.com">Chao Peng</a></span><meta itemprop=3D"email" co=
ntent=3D"chao.p.peng@linux.intel.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a></sp=
an><meta itemprop=3D"email" content=3D"qemu-devel@nongnu.org"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div></div></div></td></tr></table></td></tr></tbody></table></div>=
<!--[if mso | IE]></tr></table><![endif]--></td></tr></tbody></table></td><=
/tr></tbody></table></span></span></body></html>
--0000000000003045c30606bcaa19--

