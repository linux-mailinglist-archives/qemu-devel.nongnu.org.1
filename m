Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA2A831E3F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 18:16:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQVzZ-0005tb-6d; Thu, 18 Jan 2024 12:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3u1ypZQ0JCk4zAq3.6Ay39u1qw2qy1.s426u2A-tuBu1343w3A.47w@calendar-server.bounces.google.com>)
 id 1rQVzW-0005oT-8h
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 12:15:46 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3u1ypZQ0JCk4zAq3.6Ay39u1qw2qy1.s426u2A-tuBu1343w3A.47w@calendar-server.bounces.google.com>)
 id 1rQVzT-0002sK-KZ
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 12:15:46 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-40e47b2f6b8so82418115e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 09:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705598139; x=1706202939; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fF+Em5Sf3Tv6gjnb3ghDjmukMIc1TLv5A8Nqzu1JM4U=;
 b=0M6T3FJfBjbRTWygK3YO5GGNQbalW5QjDtPZrGrlm5v6WjP689sV76JHPQ+34T/D2a
 wfM9PHYLMLvRbuZdmUo680GJAF89rq1bPow+tAli1wPraoOuw4zSYeTUVr/W0OCshh/0
 KE5UMYJOUBZS0cLEmxJkk9SIjUMLhS8WK7Y1Nag8P0biD0gizeZdIYS/O7IJ+bORoubJ
 sTks9KPaD9fLjs/hf4yt75KGuEG+eptw5w9p6kd9QQaG/IiS0b9G5wSlc6baj0tdhMta
 RdXS4+BhatEse8wRTXazqrT3a4vC2BrkfrubNC6X3puu78dPnMV+Y7NwqYjAZT1VTNRj
 NNeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705598139; x=1706202939; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fF+Em5Sf3Tv6gjnb3ghDjmukMIc1TLv5A8Nqzu1JM4U=;
 b=KI+DSSjVzDgm3PTRJYcjlYArAeQb5xzjKZJ/OtJ/e2C6J29sYTiZ4UYQWrXLJugE5g
 EBJU/NWahRwxRGbhUqb4CgAwENn8Y0u1u0vVcl8bJdHLwjD0ALiB5/6lsnljr6Swh+z5
 hf3lRbCTgdvluE24+c2e5RUx4YRTfCng347elwt2yUoKF43IT20fwUYwjuHjtsIfz6B9
 2ybJC/7Yldi1vN3Po8fm6VMmMxRfMBU5CHwZi/dCRyoTa3QTHySVO3DQbZdMEmD15YwT
 JpJhPWTaRxnp/Fdk1XZzoW2zYKB9Vw4Dk03OXrdtJRRPN9wD4urKe8quJSEpN1vT3Qcp
 riwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705598139; x=1706202939;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fF+Em5Sf3Tv6gjnb3ghDjmukMIc1TLv5A8Nqzu1JM4U=;
 b=QaqAE2faBAnqQYu8RiOB1PeZy0lVkluKLQdysM64wpJw84DZDY4Bqki4fHh43kQURT
 /pRd6sTozW3dTx0+HXrfidg7i4z+i5sAvTZmdTYxUK7wsfj2Iz6aA3H6ZUtBi+vJwuvV
 fydHMS+Zo7rHq8pCYshxg9SrHzVNqkjGJj+1ounslt2kB5XHvs2TD6EfCfGihRL5yxK1
 yyteTC+YOSMHkIr8QJhv1E6YQnXgVvICDUAEezuku6PUBlD9CfjzdIH1JY3wLsDhuWfq
 m4fTeLB6Mi3oQ1azn4PJmpDC+QbwsIA7vDZkjtGAGk2TQkwDH5GhmPrECVxmS/S5AsPM
 ZTEg==
X-Gm-Message-State: AOJu0YxKCntOEYlcBd1qhGwpuSD0t0ECpnxBPQCXOFlc2/bPoPjJ0LGR
 7e4sble1TKSeXpt43HvNuJXmBzXEdcs7PdKz1pRhldSLFXqSwAc4HaFuPuljUaFb9CSZWQwa5t3
 K6P8813EB5ukWWS/jXkl/Oe5j/5SE0ZZtEg==
X-Google-Smtp-Source: AGHT+IFhmA1pOKipKb+G7mvUbYLYzR/o5s+yzW0RvvG8B/2qXqG04CnFpwKT/k7IWyiKsxe55yYIAyXnNHihieOvZRQx
MIME-Version: 1.0
X-Received: by 2002:a05:600c:5494:b0:40e:768d:b267 with SMTP id
 iv20-20020a05600c549400b0040e768db267mr762622wmb.41.1705598139344; Thu, 18
 Jan 2024 09:15:39 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-251cd315-fb16-4bad-a8c2-2d0504e18fda@google.com>
Date: Thu, 18 Jan 2024 17:15:39 +0000
Subject: Updated invitation: QEMU developers fortnightly conference call @
 Every 2 weeks from 15:00 to 16:00 on Tuesday from Tue 2024-01-09 to Tue
 2024-01-23 (GMT+1) (qemu-devel@nongnu.org)
From: Juan Quintela <juan.quintela@gmail.com>
To: qemu-devel@nongnu.org, mdean@redhat.com, felipe@nutanix.com, cw@f00f.org, 
 eblake@redhat.com, edgar.iglesias@gmail.com, iggy@theiggy.com, 
 jidong.xiao@gmail.com, peter.maydell@linaro.org, richard.henderson@linaro.org, 
 stefanha@gmail.com, imp@bsdimp.com, zwu.kernel@gmail.com, jgg@nvidia.com, 
 cjia@nvidia.com, konrad.wilk@oracle.com, ale@rev.ng, wei.w.wang@intel.com, 
 mburton@qti.qualcomm.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 Joao Martins <joao.m.martins@oracle.com>, afaerber@suse.de, bbauman@redhat.com,
 eric.auger@redhat.com, jan.kiszka@web.de, jjherne@linux.vnet.ibm.com, 
 mimu@linux.vnet.ibm.com, z.huo@139.com, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, anjo@rev.ng, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, 
 Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: multipart/mixed; boundary="00000000000039adb4060f3b8386"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3u1ypZQ0JCk4zAq3.6Ay39u1qw2qy1.s426u2A-tuBu1343w3A.47w@calendar-server.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_FONT_LOW_CONTRAST=0.001,
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
Reply-To: Juan Quintela <juan.quintela@gmail.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--00000000000039adb4060f3b8386
Content-Type: multipart/alternative; boundary="00000000000039adb2060f3b8384"

--00000000000039adb2060f3b8384
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiB1cGRhdGVkDQpDaGFuZ2VkOiB0aW1lDQoNCg0KUUVNVSBkZXZl
bG9wZXJzIGZvcnRuaWdodGx5IGNvbmZlcmVuY2UgY2FsbA0KRXZlcnkgMiB3ZWVrcyBmcm9tIDE1
OjAwIHRvIDE2OjAwIG9uIFR1ZXNkYXkgZnJvbSBUdWVzZGF5IDIwMjQtMDEtMDkgdG8gIA0KVHVl
c2RheSAyMDI0LTAxLTIzDQpDZW50cmFsIEV1cm9wZWFuIFRpbWUgLSBNYWRyaWQNCg0KTG9jYXRp
b24NCmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5nb29n
bGUuY29tL3VybD9xPWh0dHBzJTNBJTJGJTJGbWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGluZyZz
YT1EJnVzdD0xNzA2MDMwMTAwMDAwMDAwJnVzZz1BT3ZWYXcxRGtpbGlWSVQ2c3JhNnA3Rk5XV28w
DQoNCg0KDQpJZiB5b3UgbmVlZCBjYWxsIGRldGFpbHMsIHBsZWFzZSBjb250YWN0IG1lOiBxdWlu
dGVsYUByZWRoYXQuY29tDQoNCkd1ZXN0cw0KcXVpbnRlbGFAcmVkaGF0LmNvbQ0KbWRlYW5AcmVk
aGF0LmNvbQ0KZmVsaXBlQG51dGFuaXguY29tDQpjd0BmMDBmLm9yZw0KZWJsYWtlQHJlZGhhdC5j
b20NCmVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbQ0KaWdneUB0aGVpZ2d5LmNvbQ0Kamlkb25nLnhp
YW9AZ21haWwuY29tDQpwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcNCnJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmcNCnN0ZWZhbmhhQGdtYWlsLmNvbQ0KaW1wQGJzZGltcC5jb20NCnp3dS5rZXJu
ZWxAZ21haWwuY29tDQpqZ2dAbnZpZGlhLmNvbQ0KY2ppYUBudmlkaWEuY29tDQprb25yYWQud2ls
a0BvcmFjbGUuY29tDQphbGVAcmV2Lm5nDQp3ZWkudy53YW5nQGludGVsLmNvbQ0KbWJ1cnRvbkBx
dGkucXVhbGNvbW0uY29tDQpQaGlsaXBwZSBNYXRoaWV1LURhdWTDqQ0KSm9hbyBNYXJ0aW5zDQph
ZmFlcmJlckBzdXNlLmRlDQpiYmF1bWFuQHJlZGhhdC5jb20NCmVyaWMuYXVnZXJAcmVkaGF0LmNv
bQ0KamFuLmtpc3prYUB3ZWIuZGUNCmpqaGVybmVAbGludXgudm5ldC5pYm0uY29tDQptaW11QGxp
bnV4LnZuZXQuaWJtLmNvbQ0Kei5odW9AMTM5LmNvbQ0KRWxlbmEgVWZpbXRzZXZhDQphbmpvQHJl
di5uZw0KU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KQ2hhbyBQZW5nDQpxZW11LWRldmVsQG5v
bmdudS5vcmcNClZpZXcgYWxsIGd1ZXN0IGluZm8gIA0KaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUu
Y29tL2NhbGVuZGFyL2V2ZW50P2FjdGlvbj1WSUVXJmVpZD1OV1IwTldwcE9EZHFOWEZ5WXpBd2J6
WXphM1J4TjJkb2IzVmZVakl3TWpRd01UQTVWREUwTURBd01DQnhaVzExTFdSbGRtVnNRRzV2Ym1k
dWRTNXZjbWMmdG9rPU5USWpaV2RsWkRkamEya3dOV3h0ZFRGMGJtZDJhMnd6ZEdocFpITkFaM0p2
ZFhBdVkyRnNaVzVrWVhJdVoyOXZaMnhsTG1OdmJUVmlPVEpqWkRCallqTTFZV0l4WVdNeVlUUXdZ
VFEzTkRJME5tRTJObUZtWW1ZME9XUTJPVFkmY3R6PUV1cm9wZSUyRk1hZHJpZCZobD1lbiZlcz0w
DQoNClJlcGx5IGZvciBxZW11LWRldmVsQG5vbmdudS5vcmcgYW5kIHZpZXcgbW9yZSBkZXRhaWxz
ICANCmh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci9ldmVudD9hY3Rpb249VklF
VyZlaWQ9TldSME5XcHBPRGRxTlhGeVl6QXdiell6YTNSeE4yZG9iM1ZmVWpJd01qUXdNVEE1VkRF
ME1EQXdNQ0J4WlcxMUxXUmxkbVZzUUc1dmJtZHVkUzV2Y21jJnRvaz1OVElqWldkbFpEZGphMmt3
Tld4dGRURjBibWQyYTJ3emRHaHBaSE5BWjNKdmRYQXVZMkZzWlc1a1lYSXVaMjl2WjJ4bExtTnZi
VFZpT1RKalpEQmpZak0xWVdJeFlXTXlZVFF3WVRRM05ESTBObUUyTm1GbVltWTBPV1EyT1RZJmN0
ej1FdXJvcGUlMkZNYWRyaWQmaGw9ZW4mZXM9MA0KWW91ciBhdHRlbmRhbmNlIGlzIG9wdGlvbmFs
Lg0KDQp+fi8vfn4NCkludml0YXRpb24gZnJvbSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2Fs
ZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci8NCg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFp
bCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0ZW5kZWUgb24gdGhlIGV2ZW50LiBUbyAgDQpzdG9wIHJl
Y2VpdmluZyBmdXR1cmUgdXBkYXRlcyBmb3IgdGhpcyBldmVudCwgZGVjbGluZSB0aGlzIGV2ZW50
Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBjb3VsZCBhbGxvdyBhbnkgcmVjaXBpZW50
IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3JnYW5pemVyLCBiZSBhZGRlZCB0byB0aGUg
Z3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRsZXNzIG9mICANCnRoZWlyIG93biBpbnZp
dGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNWUC4NCg0KTGVhcm4gbW9yZSBodHRwczov
L3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3ZXIvMzcxMzUjZm9yd2FyZGluZw0K
--00000000000039adb2060f3b8384
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
entRescheduled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://=
schema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar=
"/></span><meta itemprop=3D"eventId/googleCalendar" content=3D"5dt5ji87j5qr=
c00o63ktq7ghou_R20240109T140000"/><span style=3D"display: none; font-size: =
1px; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max=
-width: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU developers=
 fortnightly conference call</span><meta itemprop=3D"url" content=3D"https:=
//calendar.google.com/calendar/event?action=3DVIEW&amp;eid=3DNWR0NWppODdqNX=
FyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&a=
mp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2=
xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEur=
ope%2FMadrid&amp;hl=3Den&amp;es=3D0"/><span aria-hidden=3D"true"><time item=
prop=3D"startDate" datetime=3D"20240109T140000Z"></time><time itemprop=3D"e=
ndDate" datetime=3D"20240109T150000Z"></time></span><div style=3D"display: =
none; font-size: 1px; color: #fff; line-height: 1px; height: 0; max-height:=
 0; width: 0; max-width: 0; opacity: 0; overflow: hidden;">If you need call=
 details, please contact me: quintela@redhat.com</div><table border=3D"0" c=
ellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" s=
tyle=3D"width:100%;" class=3D"body-container"><tbody><tr><td style=3D"" cla=
ss=3D"" align=3D"left"><!--[if mso | IE]><table border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D"16" style=3D"=
height:16px;"><![endif]--><div style=3D"height:16px;" aria-hidden=3D"true">=
 &nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"c=
enter" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"background-=
color: #e6f4ea;color: #0d5327;padding: 12px 32px; border-radius: 8px;font-f=
amily: Roboto, sans-serif;font-size: 14px; line-height: 20px;text-align: le=
ft;" class=3D"info-bar-inner"><span style=3D"font-weight: 700;">This event =
has been updated</span><br/><span style=3D"display:none" itemprop=3D"about"=
 itemscope itemtype=3D"http://schema.org/Thing/Clock"><meta itemprop=3D"des=
cription" content=3D"Time updated"/></span><div style=3D""><span style=3D"f=
ont-weight: 700;">Changed:</span> time</div></td></tr></tbody></table><!--[=
if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation"><tr><td height=3D"12" style=3D"height:12px;"><![endif]-->=
<div style=3D"height:12px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso =
| IE]></td></tr></table><![endif]--><table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%=
;" class=3D""><tbody><tr><td style=3D"border: solid 1px #dadce0; border-rad=
ius: 8px; direction: rtl; font-size: 0; padding: 24px 32px; text-align: lef=
t; vertical-align: top;" class=3D"main-container-inner"><!--[if mso | IE]><=
table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation=
"><tr><![endif]--><div class=3D"" style=3D"font-size: 13px; text-align: lef=
t; direction: ltr; display: inline-block; vertical-align: top; width: 100%;=
overflow: hidden; word-wrap: break-word;"><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%" class=3D"main=
-column-table-ltr" style=3D"padding-right: 32px; padding-left: 0;;table-lay=
out: fixed;"><tbody><tr><td class=3D"main-column-td" style=3D"padding:0; ve=
rtical-align:top;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" =
role=3D"presentation" width=3D"100%" style=3D"table-layout: fixed;"><tr><td=
 style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-wor=
d;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font=
-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; lette=
r-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-t=
ext" role=3D"presentation"><span>If you need call details, please contact m=
e: <a href=3D"mailto:quintela@redhat.com" target=3D"_blank">quintela@redhat=
.com</a></span><meta itemprop=3D"description" content=3D"If you need call d=
etails, please contact me: quintela@redhat.com"/></div></td></tr><tr><td st=
yle=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;=
padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-st=
yle: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-s=
pacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text=
" role=3D"presentation"><span aria-hidden=3D"true"><time itemprop=3D"startD=
ate" datetime=3D"20240109T140000Z"></time><time itemprop=3D"endDate" dateti=
me=3D"20240109T150000Z"></time></span><table border=3D"0" cellpadding=3D"0"=
 cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr=
><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; te=
xt-decoration: none;font-weight: 700;-webkit-font-smoothing: antialiased;ma=
rgin: 0; padding: 0;">When</h2></td><td style=3D"width: 8px;"></td><td styl=
e=3D"padding-top: 2px; padding-bottom: 3px;"><div style=3D"background-color=
: #1e8e3e; border-radius: 10px; padding: 1px 5px; line-height: 13px;"><span=
 style=3D"color: white; font-size: 11px; font-weight: 700; letter-spacing: =
0.8px; text-transform: uppercase; vertical-align: top;">CHANGED</span></div=
></td></tr></table><span>Every 2 weeks from 15:00 to 16:00 on Tuesday from =
Tuesday 2024-01-09 to Tuesday 2024-01-23 (Central European Time - Madrid)<b=
r/><span style=3D"text-decoration: line-through;"><del><span style=3D"displ=
ay: none; font-size: 1px; color: #fff; line-height: 1px; height: 0; max-hei=
ght: 0; width: 0; max-width: 0; opacity: 0; overflow: hidden;font-size: 0; =
display: block;">Old: </span>Every 2 weeks from 15:00 to 16:00 on Tuesday (=
Central European Time - Madrid)</del></span></span></div></td></tr><tr><td =
style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word=
;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-=
style: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter=
-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-te=
xt" role=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 cla=
ss=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text-decoratio=
n: none;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; pad=
ding: 0;">Location</h2></td></tr></table><span itemprop=3D"location" itemsc=
ope itemtype=3D"http://schema.org/Place"><span itemprop=3D"name" class=3D"p=
rimary-text notranslate" style=3D"font-family: Roboto, sans-serif;font-styl=
e: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spa=
cing: 0.2px;color: #3c4043; text-decoration: none;">https://meet.jit.si/kvm=
callmeeting</span><br/><a href=3D"https://www.google.com/url?q=3Dhttps%3A%2=
F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D1706030100000000&amp;=
usg=3DAOvVaw1DkiliVIT6sra6p7FNWWo0" class=3D"accent-text underline-on-hover=
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
coration: none;" href=3D"mailto:mdean@redhat.com">mdean@redhat.com</a></spa=
n><meta itemprop=3D"email" content=3D"mdean@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:felipe@nutanix.com">felipe@nutanix=
.com</a></span><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f00f.org">cw@f=
00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.org"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:eblake@redhat.com">ebla=
ke@redhat.com</a></span><meta itemprop=3D"email" content=3D"eblake@redhat.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:edgar.igles=
ias@gmail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"email" =
content=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:iggy@theiggy.com">iggy@theiggy.com</a></span><meta it=
emprop=3D"email" content=3D"iggy@theiggy.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com=
</a></span><meta itemprop=3D"email" content=3D"jidong.xiao@gmail.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:peter.maydell@linaro=
.org">peter.maydell@linaro.org</a></span><meta itemprop=3D"email" content=
=3D"peter.maydell@linaro.org"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org<=
/a></span><meta itemprop=3D"email" content=3D"richard.henderson@linaro.org"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:stefanha@gmail=
.com">stefanha@gmail.com</a></span><meta itemprop=3D"email" content=3D"stef=
anha@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:imp@bsdimp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=
=3D"imp@bsdimp.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:zwu.kernel@gmail.com">zwu.kernel@gmail.com</a></span><meta itemprop=
=3D"email" content=3D"zwu.kernel@gmail.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a></span><meta=
 itemprop=3D"email" content=3D"jgg@nvidia.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:cjia@nvidia.com">cjia@nvidia.com</a></span>=
<meta itemprop=3D"email" content=3D"cjia@nvidia.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:konrad.wilk@oracle.com">konrad.wilk@o=
racle.com</a></span><meta itemprop=3D"email" content=3D"konrad.wilk@oracle.=
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
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:wei.w.wang@intel.=
com">wei.w.wang@intel.com</a></span><meta itemprop=3D"email" content=3D"wei=
.w.wang@intel.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</a></span><meta item=
prop=3D"email" content=3D"mburton@qti.qualcomm.com"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:f4bug@amsat.org">Philippe Mathieu-Daud=
=C3=A9</a></span><meta itemprop=3D"email" content=3D"f4bug@amsat.org"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:joao.m.martins@oracl=
e.com">Joao Martins</a></span><meta itemprop=3D"email" content=3D"joao.m.ma=
rtins@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee=
" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" c=
lass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"=
display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mail=
to:afaerber@suse.de">afaerber@suse.de</a></span><meta itemprop=3D"email" co=
ntent=3D"afaerber@suse.de"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:bbauman@redhat.com">bbauman@redhat.com</a></span><meta itempr=
op=3D"email" content=3D"bbauman@redhat.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</=
a></span><meta itemprop=3D"email" content=3D"eric.auger@redhat.com"/></span=
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
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jjherne@li=
nux.vnet.ibm.com">jjherne@linux.vnet.ibm.com</a></span><meta itemprop=3D"em=
ail" content=3D"jjherne@linux.vnet.ibm.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.c=
om</a></span><meta itemprop=3D"email" content=3D"mimu@linux.vnet.ibm.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:z.huo@139.com">z=
.huo@139.com</a></span><meta itemprop=3D"email" content=3D"z.huo@139.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:elena.ufimtseva@=
oracle.com">Elena Ufimtseva</a></span><meta itemprop=3D"email" content=3D"e=
lena.ufimtseva@oracle.com"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:anjo@rev.ng">anjo@rev.ng</a></span><meta itemprop=3D"email" c=
ontent=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:shameerali.kolothum.thodi@huawei.com">Shameerali Kolothum Thodi</a>=
</span><meta itemprop=3D"email" content=3D"shameerali.kolothum.thodi@huawei=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:chao.p.pe=
ng@linux.intel.com">Chao Peng</a></span><meta itemprop=3D"email" content=3D=
"chao.p.peng@linux.intel.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a></span><met=
a itemprop=3D"email" content=3D"qemu-devel@nongnu.org"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div></div><a href=3D"https://calendar.google.com/calendar/event?action=
=3DVIEW&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwM=
CBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdG=
hpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0N=
mE2NmFmYmY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=
=3D"display: inline-block;;color: #1a73e8; text-decoration: none;font-weigh=
t: 700;" target=3D"_blank" class=3D"accent-text underline-on-hover">View al=
l guest info</a></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; =
text-align: left; word-break: break-word;;padding-bottom:0px;"><div style=
=3D"color: #3c4043; text-decoration: none;;font-family: Roboto, sans-serif;=
font-size: 14px; line-height: 20px; mso-line-height-rule: exactly; text-ali=
gn: left;" class=3D"primary-text"><div><span style=3D"font-weight: 700;-web=
kit-font-smoothing: antialiased;">RSVP</span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"> for <a class=3D"secondar=
y-text underline-on-hover" style=3D"display: inline-block;;color: #70757a; =
text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@no=
ngnu.org</a> for all events in this series</span></div></div></td></tr><tr>=
<td style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-=
word;;padding-bottom:16px;"><div style=3D"font-family: Roboto, sans-serif;f=
ont-size: 14px; line-height: 20px; mso-line-height-rule: exactly; text-alig=
n: left;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"p=
resentation" style=3D"border-collapse: separate;"><tr><td style=3D"padding-=
top: 8px; padding-left: 0; padding-right: 12px;"><!-- RSVP buttons --><tabl=
e border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" st=
yle=3D"border: solid 1px #dadce0; border-radius: 16px; border-collapse: sep=
arate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;;display: inli=
ne-block;;margin-right: 12px; margin-left: 0;"><tr><td align=3D"center" ver=
tical-align=3D"middle" role=3D"presentation"><span itemprop=3D"potentialact=
ion" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"=
attendance" content=3D"http://schema.org/RsvpAttendance/Yes"/><span itempro=
p=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHandler"><l=
ink itemprop=3D"method" href=3D"http://schema.org/HttpRequestMethod/GET"/><=
span style=3D"color: #5f6367;"><a href=3D"https://calendar.google.com/calen=
dar/event?action=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUj=
IwMjQwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&amp;tok=3DNTI=
jZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOT=
JjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid=
&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#39;Google=
 Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height=
: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; te=
xt-transform: none;" class=3D"grey-button-text" itemprop=3D"url" target=3D"=
_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pre=
sentation"><tr><td align=3D"center" role=3D"presentation" valign=3D"middle"=
 style=3D"padding: 6px 0; padding-left: 16px; padding-right: 12px; white-sp=
ace: nowrap;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/=
event?action=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMj=
QwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&amp;tok=3DNTIjZWd=
lZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZD=
BjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp=
;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" target=3D"=
_blank"><![endif]--><span class=3D"grey-button-text" style=3D"font-weight: =
400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; =
font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: =
0; text-decoration: none; text-transform: none;">Yes</span><!--[if mso]></a=
><![endif]--></td></tr></table></a></span></span></span></td><td align=3D"c=
enter" vertical-align=3D"middle" role=3D"presentation" style=3D"border-left=
: solid 1px #dadce0; border-right: solid 1px #dadce0;"><span itemprop=3D"po=
tentialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta it=
emprop=3D"attendance" content=3D"http://schema.org/RsvpAttendance/No"/><spa=
n itemprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHa=
ndler"><link itemprop=3D"method" href=3D"http://schema.org/HttpRequestMetho=
d/GET"/><span style=3D"color: #5f6367;"><a href=3D"https://calendar.google.=
com/calendar/event?action=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN=
2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D2&amp;=
tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlL=
mNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEurope=
%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#=
39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; li=
ne-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration:=
 none; text-transform: none;" class=3D"grey-button-text" itemprop=3D"url" t=
arget=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" ro=
le=3D"presentation"><tr><td align=3D"center" role=3D"presentation" valign=
=3D"middle" style=3D"padding: 6px 12px; white-space: nowrap;"><!--[if mso]>=
<a href=3D"https://calendar.google.com/calendar/event?action=3DRESPOND&amp;=
eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LWRld=
mVsQG5vbmdudS5vcmc&amp;rst=3D2&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdG=
hpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0N=
mE2NmFmYmY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" class=
=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><![endif]--><span =
class=3D"grey-button-text" style=3D"font-weight: 400;font-family: &#39;Goog=
le Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-heig=
ht: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; =
text-transform: none;">No</span><!--[if mso]></a><![endif]--></td></tr></ta=
ble></a></span></span></span></td><td align=3D"center" vertical-align=3D"mi=
ddle" role=3D"presentation"><span itemprop=3D"potentialaction" itemscope it=
emtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"attendance" conte=
nt=3D"http://schema.org/RsvpAttendance/Maybe"/><span itemprop=3D"handler" i=
temscope itemtype=3D"http://schema.org/HttpActionHandler"><link itemprop=3D=
"method" href=3D"http://schema.org/HttpRequestMethod/GET"/><span style=3D"c=
olor: #5f6367;"><a href=3D"https://calendar.google.com/calendar/event?actio=
n=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0M=
DAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D3&amp;tok=3DNTIjZWdlZDdja2kwNW=
xtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxY=
WMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&am=
p;es=3D0" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Rob=
oto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-lin=
e-height-rule: exactly; margin: 0; text-decoration: none; text-transform: n=
one;" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><table =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr>=
<td align=3D"center" role=3D"presentation" valign=3D"middle" style=3D"paddi=
ng: 6px 0; padding-left: 12px; padding-right: 16px; white-space: nowrap;"><=
!--[if mso]><a href=3D"https://calendar.google.com/calendar/event?action=3D=
RESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwM=
CBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D3&amp;tok=3DNTIjZWdlZDdja2kwNWxtdT=
F0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyY=
TQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=
=3D0" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><![endi=
f]--><span class=3D"grey-button-text" style=3D"font-weight: 400;font-family=
: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px=
; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decorat=
ion: none; text-transform: none;">Maybe</span><!--[if mso]></a><![endif]-->=
</td></tr></table></a></span></span></span></td></tr></table><!-- More opti=
ons --><a href=3D"https://calendar.google.com/calendar/event?action=3DVIEW&=
amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11L=
WRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3=
JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmY=
mY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"displ=
ay: inline-block;;font-weight: 400;font-family: &#39;Google Sans&#39;, Robo=
to, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line=
-height-rule: exactly; margin: 0; text-decoration: none; text-transform: no=
ne;" class=3D"grey-button-text" target=3D"_blank"><table border=3D"0" cellp=
adding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"border: solid=
 1px #dadce0; border-radius: 16px; border-collapse: separate;font-family: &=
#39;Google Sans&#39;, Roboto, sans-serif;"><tr><td align=3D"center" vertica=
l-align=3D"middle" role=3D"presentation" style=3D"padding: 6px 0; padding-l=
eft: 16px; padding-right: 12px; white-space: nowrap;;color: #5f6367;"><!--[=
if mso]><a href=3D"https://calendar.google.com/calendar/event?action=3DVIEW=
&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11=
LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ=
3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFm=
YmY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"grey=
-button-text" target=3D"_blank"><![endif]--><span class=3D"grey-button-text=
" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, san=
s-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height=
-rule: exactly; margin: 0; text-decoration: none; text-transform: none;">Mo=
re options</span><!--[if mso]></a><![endif]--></td></tr></table></a></td></=
tr></table></div></td></tr></table></td></tr></tbody></table></div><!--[if =
mso | IE]></tr></table><![endif]--></td></tr></tbody></table><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"c=
enter" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"font-size: =
0; padding: 0; text-align: left; word-break: break-word;;padding:4px 12px;"=
 class=3D"" align=3D"left"><div class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;font-family: Roboto, sans-serif;font-size: 12p=
x; line-height: 16px; mso-line-height-rule: exactly; text-align: left;"><p>=
Invitation from <a href=3D"https://calendar.google.com/calendar/" class=3D"=
accent-text underline-on-hover" style=3D"font-family: Roboto, sans-serif;fo=
nt-size: 12px; line-height: 16px; mso-line-height-rule: exactly;;color: #1a=
73e8; text-decoration: none;" target=3D"_blank">Google Calendar</a></p><p>Y=
ou are receiving this email because you are an attendee on the event. To st=
op receiving future updates for this event, decline this event.</p><p>Forwa=
rding this invitation could allow any recipient to send a response to the o=
rganizer, be added to the guest list, invite others regardless of their own=
 invitation status, or modify your RSVP. <a class=3D"accent-text underline-=
on-hover" style=3D"font-family: Roboto, sans-serif;font-size: 12px; line-he=
ight: 16px; mso-line-height-rule: exactly;;color: #1a73e8; text-decoration:=
 none;" href=3D"https://support.google.com/calendar/answer/37135#forwarding=
">Learn more</a></p></div></td></tr></tbody></table></td></tr></tbody></tab=
le></span></span></body></html>
--00000000000039adb2060f3b8384
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: 7bit

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
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
DTSTART;TZID=America/New_York:20240109T090000
DTEND;TZID=America/New_York:20240109T100000
RRULE:FREQ=WEEKLY;WKST=MO;UNTIL=20240123T045959Z;INTERVAL=2;BYDAY=TU
DTSTAMP:20240118T171539Z
ORGANIZER;CN=KVM call for qemu developers:mailto:eged7cki05lmu1tngvkl3thids
 @group.calendar.google.com
UID:5dt5ji87j5qrc00o63ktq7ghou_R20240109T140000@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=DECLINED;RSVP=TRUE
 ;CN=quintela@redhat.com;X-NUM-GUESTS=0:mailto:quintela@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mdean@redhat.com;X-NUM-GUESTS=0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=felipe@nutanix.com;X-NUM-GUESTS=0:mailto:felipe@nutanix.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=cw@f00f.org;X-NUM-GUESTS=0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=eblake@redhat.com;X-NUM-GUESTS=0:mailto:eblake@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=edgar.iglesias@gmail.com;X-NUM-GUESTS=0:mailto:edgar.iglesias@gmail
 .com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=iggy@theiggy.com;X-NUM-GUESTS=0:mailto:iggy@theiggy.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jidong.xiao@gmail.com;X-NUM-GUESTS=0:mailto:jidong.xiao@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=peter.maydell@linaro.org;X-NUM-GUESTS=0:mailto:peter.maydell@linaro
 .org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=richard.henderson@linaro.org;X-NUM-GUESTS=0:mailto:richard.henderso
 n@linaro.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=stefanha@gmail.com;X-NUM-GUESTS=0:mailto:stefanha@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=TENTATIVE;RSVP=TRU
 E;CN=imp@bsdimp.com;X-NUM-GUESTS=0:mailto:imp@bsdimp.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=zwu.kernel@gmail.com;X-NUM-GUESTS=0:mailto:zwu.kernel@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jgg@nvidia.com;X-NUM-GUESTS=0:mailto:jgg@nvidia.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=cjia@nvidia.com;X-NUM-GUESTS=0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=konrad.wilk@oracle.com;X-NUM-GUESTS=0:mailto:konrad.wilk@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=ale@rev.ng;X-NUM-GUESTS=0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=wei.w.wang@intel.com;X-NUM-GUESTS=0:mailto:wei.w.wang@intel.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=mburton@qti.qualcomm.com;X-NUM-GUESTS=0:mailto:mburton@qti.qualcomm.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;X-NUM-GUESTS=0:mailto:f4bug@amsat.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Joao Martins;X-NUM-GUESTS=0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=afaerber@suse.de;X-NUM-GUESTS=0:mailto:afaerber@suse.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=bbauman@redhat.com;X-NUM-GUESTS=0:mailto:bbauman@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=eric.auger@redhat.com;X-NUM-GUESTS=0:mailto:eric.auger@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jan.kiszka@web.de;X-NUM-GUESTS=0:mailto:jan.kiszka@web.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jjherne@linux.vnet.ibm.com;X-NUM-GUESTS=0:mailto:jjherne@linux.vnet
 .ibm.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mimu@linux.vnet.ibm.com;X-NUM-GUESTS=0:mailto:mimu@linux.vnet.ibm.c
 om
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=z.huo@139.com;X-NUM-GUESTS=0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Elena Ufimtseva;X-NUM-GUESTS=0:mailto:elena.ufimtseva@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=anjo@rev.ng;X-NUM-GUESTS=0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Shameerali Kolothum Thodi;X-NUM-GUESTS=0:mailto:shameerali.kolothum
 .thodi@huawei.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Chao Peng;X-NUM-GUESTS=0:mailto:chao.p.peng@linux.intel.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=qemu-devel@nongnu.org;X-NUM-GUESTS=0:mailto:qemu-devel@nongnu.org
X-MICROSOFT-CDO-OWNERAPPTID:-1610811808
CLASS:PUBLIC
CREATED:20220823T150022Z
DESCRIPTION:If you need call details\, please contact me: quintela@redhat.c
 om
LAST-MODIFIED:20240118T171529Z
LOCATION:https://meet.jit.si/kvmcallmeeting
SEQUENCE:1
STATUS:CONFIRMED
SUMMARY:QEMU developers fortnightly conference call
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR

--00000000000039adb2060f3b8384--

--00000000000039adb4060f3b8386
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvTmV3X1lvcmsNClgtTElDLUxPQ0FUSU9O
OkFtZXJpY2EvTmV3X1lvcmsNCkJFR0lOOkRBWUxJR0hUDQpUWk9GRlNFVEZST006LTA1MDANClRa
T0ZGU0VUVE86LTA0MDANClRaTkFNRTpFRFQNCkRUU1RBUlQ6MTk3MDAzMDhUMDIwMDAwDQpSUlVM
RTpGUkVRPVlFQVJMWTtCWU1PTlRIPTM7QllEQVk9MlNVDQpFTkQ6REFZTElHSFQNCkJFR0lOOlNU
QU5EQVJEDQpUWk9GRlNFVEZST006LTA0MDANClRaT0ZGU0VUVE86LTA1MDANClRaTkFNRTpFU1QN
CkRUU1RBUlQ6MTk3MDExMDFUMDIwMDAwDQpSUlVMRTpGUkVRPVlFQVJMWTtCWU1PTlRIPTExO0JZ
REFZPTFTVQ0KRU5EOlNUQU5EQVJEDQpFTkQ6VlRJTUVaT05FDQpCRUdJTjpWRVZFTlQNCkRUU1RB
UlQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjQwMTA5VDA5MDAwMA0KRFRFTkQ7VFpJRD1BbWVy
aWNhL05ld19Zb3JrOjIwMjQwMTA5VDEwMDAwMA0KUlJVTEU6RlJFUT1XRUVLTFk7V0tTVD1NTztV
TlRJTD0yMDI0MDEyM1QwNDU5NTlaO0lOVEVSVkFMPTI7QllEQVk9VFUNCkRUU1RBTVA6MjAyNDAx
MThUMTcxNTM5Wg0KT1JHQU5JWkVSO0NOPUtWTSBjYWxsIGZvciBxZW11IGRldmVsb3BlcnM6bWFp
bHRvOmVnZWQ3Y2tpMDVsbXUxdG5ndmtsM3RoaWRzDQogQGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5j
b20NClVJRDo1ZHQ1amk4N2o1cXJjMDBvNjNrdHE3Z2hvdV9SMjAyNDAxMDlUMTQwMDAwQGdvb2ds
ZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPURFQ0xJTkVEO1JTVlA9VFJVRQ0KIDtDTj1xdWludGVsYUByZWRoYXQuY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzpxdWludGVsYUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPW1kZWFuQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1kZWFuQHJl
ZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZmVsaXBlQG51dGFuaXguY29t
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpmZWxpcGVAbnV0YW5peC5jb20NCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtS
U1ZQPQ0KIFRSVUU7Q049Y3dAZjAwZi5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmN3QGYwMGYu
b3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWVibGFrZUByZWRoYXQuY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzplYmxha2VAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1lZGdhci5pZ2xlc2lhc0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVk
Z2FyLmlnbGVzaWFzQGdtYWlsDQogLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1p
Z2d5QHRoZWlnZ3kuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzppZ2d5QHRoZWlnZ3kuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWppZG9uZy54aWFvQGdtYWlsLmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86amlkb25nLnhpYW9AZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPXBldGVyLm1heWRlbGxAbGluYXJvLm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86
cGV0ZXIubWF5ZGVsbEBsaW5hcm8NCiAub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnJpY2hh
cmQuaGVuZGVyc28NCiBuQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
c3RlZmFuaGFAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzdGVmYW5oYUBnbWFpbC5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049aW1wQGJzZGltcC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmltcEBic2RpbXAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXp3
dS5rZXJuZWxAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6d3Uua2VybmVsQGdtYWls
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qZ2dAbnZpZGlhLmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86amdnQG52aWRpYS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049Y2ppYUBudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjamlhQG52aWRpYS5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049a29ucmFkLndpbGtAb3JhY2xlLmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86a29ucmFkLndpbGtAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1hbGVAcmV2Lm5nO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbGVAcmV2Lm5n
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049d2VpLncud2FuZ0BpbnRlbC5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOndlaS53LndhbmdAaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7
Q049bWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYnVydG9u
QHF0aS5xdWFsY29tbS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmY0YnVnQGFtc2F0Lm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1K
b2FvIE1hcnRpbnM7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YWZhZXJiZXJAc3VzZS5kZTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86YWZhZXJiZXJAc3VzZS5kZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1iYmF1bWFuQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmJiYXVtYW5AcmVk
aGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lcmljLmF1Z2VyQHJlZGhhdC5j
b207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1qYW4ua2lzemthQHdlYi5kZTtYLU5VTS1HVUVTVFM9MDptYWls
dG86amFuLmtpc3prYUB3ZWIuZGUNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ampoZXJu
ZUBsaW51eC52bmV0LmlibS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpqaGVybmVAbGludXgu
dm5ldA0KIC5pYm0uY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1pbXVAbGludXgu
dm5ldC5pYm0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptaW11QGxpbnV4LnZuZXQuaWJtLmMN
CiBvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj16Lmh1b0AxMzkuY29tO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzp6Lmh1b0AxMzkuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PUVsZW5hIFVmaW10c2V2YTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWxlbmEudWZpbXRzZXZhQG9y
YWNsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YW5qb0ByZXYubmc7WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmFuam9AcmV2Lm5nDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PVNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGk7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnNoYW1lZXJh
bGkua29sb3RodW0NCiAudGhvZGlAaHVhd2VpLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1DaGFvIFBlbmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNoYW8ucC5wZW5nQGxpbnV4Lmlu
dGVsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1xZW11LWRldmVsQG5vbmdudS5v
cmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KWC1NSUNST1NP
RlQtQ0RPLU9XTkVSQVBQVElEOi0xNjEwODExODA4DQpDTEFTUzpQVUJMSUMNCkNSRUFURUQ6MjAy
MjA4MjNUMTUwMDIyWg0KREVTQ1JJUFRJT046SWYgeW91IG5lZWQgY2FsbCBkZXRhaWxzXCwgcGxl
YXNlIGNvbnRhY3QgbWU6IHF1aW50ZWxhQHJlZGhhdC5jDQogb20NCkxBU1QtTU9ESUZJRUQ6MjAy
NDAxMThUMTcxNTI5Wg0KTE9DQVRJT046aHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1jYWxsbWVldGlu
Zw0KU0VRVUVOQ0U6MQ0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpRRU1VIGRldmVsb3BlcnMg
Zm9ydG5pZ2h0bHkgY29uZmVyZW5jZSBjYWxsDQpUUkFOU1A6T1BBUVVFDQpFTkQ6VkVWRU5UDQpF
TkQ6VkNBTEVOREFSDQo=
--00000000000039adb4060f3b8386--

