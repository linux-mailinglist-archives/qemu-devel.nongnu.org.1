Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E618831E40
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 18:16:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQVzX-0005nZ-GF; Thu, 18 Jan 2024 12:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ulypZQ0JCk0y9p2.59x28t0pv1px0.r315t19-stAt0232v29.36v@calendar-server.bounces.google.com>)
 id 1rQVzT-0005gr-Vg
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 12:15:44 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ulypZQ0JCk0y9p2.59x28t0pv1px0.r315t19-stAt0232v29.36v@calendar-server.bounces.google.com>)
 id 1rQVzR-0002sE-Ew
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 12:15:43 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-40e5980dfdfso62067825e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 09:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705598138; x=1706202938; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1LbsZhesI15SOLpbSibJ3jy/PKzNl4QxTEsgQKDMXIs=;
 b=a5n4FGJw0uJGvvojbXagTrtLwlqfr1d/VBkIyLbrevTG/loc8ilHgxL2EefqdJTUMR
 qZ54CcvMe4tgnrm0kGJMko4S0URMm62UzWSxlIGSoxdJM/8PYGDUAuXf8j5TeOIduBRd
 hfqBE1axcTDn/fG8dNIhVTuLTqWqRYgl83a28KmBCXolgb0gv4Fialso0JmRTpQmt5Z8
 2j4JyUoEcDVvdOmqb9Y0Q9tLfRnfxRmnNViYPoCEFfB55qdLKlt0zc0g3/G+II89vfoE
 IYz1ZNmp8FLWblfQu6USm26RCfDocB/0eBmaRsYfCt3CDkn59eK21D0EhOe0RuU5ZG8k
 4Ieg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705598138; x=1706202938; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1LbsZhesI15SOLpbSibJ3jy/PKzNl4QxTEsgQKDMXIs=;
 b=eM4IR09X84IHZv7xanbwA1dtKHX85uIfVVAzIOAydidGgJpqpU57oH6rdELz7ipMYV
 tGz34RCaJDfsRwAA22XwOFaYl6tVejZPi6Tw3sHrZOW2U9ptncmK6MWFmpAqcBDfpbVF
 5nDqcPzC5RAmlh5nauS4OuVZQJVTm2Vz2lVEEzIMeWpB/lVa1d/vfb6Zp5xfSMRAN6RH
 PBDRXHestW1vjhl3bYLGZ3bNZRYXVd0/avf7GLJhtZVRLqbhzPLWWxsp8h0xYTMa+0ai
 K12VcoatwE+rLDJkhqSLB3n8k4b/v0UZ7clRaKRosSOdjmldHofjQVEPgAjhe+0w1BGa
 UYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705598138; x=1706202938;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1LbsZhesI15SOLpbSibJ3jy/PKzNl4QxTEsgQKDMXIs=;
 b=fpfu9Xe/LKyF9Wgh4AUZ6NRflbOTsSNo1Kx2+mbij39a4Ts2ItV+C9vxduALBCDjOJ
 6KNp04gZUFBZFq+J5bhLuYnXASNtWjqdo6GZMhP2KBeuYL76k5KICQ3KqnVuI2AA455Y
 14j56SqGWNNrLNrbHuUybuiSmU9T0iFcavNVTWb/WTXCFQK4i+xnttwrZTlDJV23ZEBA
 RGN180FwdF0ONhTuoMjJ5n7a69zj/JAqfB4aLYCwrWDcyXutDkIRqsWfMJ4NZivM4zVQ
 F6XdpCIk9Bn8XFQv8zRJllsPArVfS7R6YDKiFVWotxNdEqoo/WBdudLoTWYQFkdVpgVB
 Rh3w==
X-Gm-Message-State: AOJu0Yy6DIu83g1+1uPPGQrEYYPMTdRLJnwJAvrc9HAEQRj8Xg2tc2Xq
 u2v1xIk3tTnLRMSN46ByBaaMDqw0a1oAlwsu2DqPIsEis29cQ1+GTdRZIWK9jxPkpNitTjmw+ZC
 xuYVctUNbFqYJTUEJNE8+L1fZuDqB5X0+vg==
X-Google-Smtp-Source: AGHT+IHuF73W+qloYqPZ8d+8+e0yTPFvIPN4mnDUV9Alsb4Uxv+oTKRiRMGqKMf0sfqGINEHpKzNw4D6hq50lj4ivBMf
MIME-Version: 1.0
X-Received: by 2002:a05:600c:a696:b0:40d:5ccd:cb6f with SMTP id
 ip22-20020a05600ca69600b0040d5ccdcb6fmr695114wmb.158.1705598138571; Thu, 18
 Jan 2024 09:15:38 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-397f4fea-197a-4ac2-aa73-8aa3e1f349fc@google.com>
Date: Thu, 18 Jan 2024 17:15:38 +0000
Subject: Updated invitation: QEMU developers fortnightly conference call @
 Every 2 weeks from 15:00 to 16:00 on Tuesday from Tue 2022-08-23 to Tue
 2024-01-23 (GMT+2) (qemu-devel@nongnu.org)
From: Juan Quintela <juan.quintela@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 Joao Martins <joao.m.martins@oracle.com>, quintela@redhat.com, mdean@redhat.com,
 felipe@nutanix.com, afaerber@suse.de, bbauman@redhat.com, cw@f00f.org, 
 eblake@redhat.com, edgar.iglesias@gmail.com, eric.auger@redhat.com, 
 iggy@theiggy.com, jan.kiszka@web.de, jidong.xiao@gmail.com, 
 jjherne@linux.vnet.ibm.com, mimu@linux.vnet.ibm.com, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, stefanha@gmail.com, imp@bsdimp.com, 
 z.huo@139.com, zwu.kernel@gmail.com, jgg@nvidia.com, cjia@nvidia.com, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, konrad.wilk@oracle.com,
 ale@rev.ng, 
 anjo@rev.ng, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 wei.w.wang@intel.com, 
 Chao Peng <chao.p.peng@linux.intel.com>, mburton@qti.qualcomm.com
Content-Type: multipart/mixed; boundary="0000000000002de4e4060f3b83e9"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3ulypZQ0JCk0y9p2.59x28t0pv1px0.r315t19-stAt0232v29.36v@calendar-server.bounces.google.com;
 helo=mail-wm1-x349.google.com
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

--0000000000002de4e4060f3b83e9
Content-Type: multipart/alternative; boundary="0000000000002de4e2060f3b83e7"

--0000000000002de4e2060f3b83e7
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiB1cGRhdGVkDQpDaGFuZ2VkOiB0aW1lDQoNCg0KUUVNVSBkZXZl
bG9wZXJzIGZvcnRuaWdodGx5IGNvbmZlcmVuY2UgY2FsbA0KRXZlcnkgMiB3ZWVrcyBmcm9tIDE1
OjAwIHRvIDE2OjAwIG9uIFR1ZXNkYXkgZnJvbSBUdWVzZGF5IDIwMjItMDgtMjMgdG8gIA0KVHVl
c2RheSAyMDI0LTAxLTIzDQpDZW50cmFsIEV1cm9wZWFuIFRpbWUgLSBNYWRyaWQNCg0KTG9jYXRp
b24NCmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5nb29n
bGUuY29tL3VybD9xPWh0dHBzJTNBJTJGJTJGbWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGluZyZz
YT1EJnVzdD0xNzA2MDMwMTAwMDAwMDAwJnVzZz1BT3ZWYXcxRGtpbGlWSVQ2c3JhNnA3Rk5XV28w
DQoNCg0KDQpJZiB5b3UgbmVlZCBjYWxsIGRldGFpbHMsIHBsZWFzZSBjb250YWN0IG1lOiBxdWlu
dGVsYUByZWRoYXQuY29tDQoNCkd1ZXN0cw0KUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCkpvYW8g
TWFydGlucw0KcXVpbnRlbGFAcmVkaGF0LmNvbQ0KbWRlYW5AcmVkaGF0LmNvbQ0KZmVsaXBlQG51
dGFuaXguY29tDQphZmFlcmJlckBzdXNlLmRlDQpiYmF1bWFuQHJlZGhhdC5jb20NCmN3QGYwMGYu
b3JnDQplYmxha2VAcmVkaGF0LmNvbQ0KZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tDQplcmljLmF1
Z2VyQHJlZGhhdC5jb20NCmlnZ3lAdGhlaWdneS5jb20NCmphbi5raXN6a2FAd2ViLmRlDQpqaWRv
bmcueGlhb0BnbWFpbC5jb20NCmpqaGVybmVAbGludXgudm5ldC5pYm0uY29tDQptaW11QGxpbnV4
LnZuZXQuaWJtLmNvbQ0KcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnDQpyaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnDQpzdGVmYW5oYUBnbWFpbC5jb20NCmltcEBic2RpbXAuY29tDQp6Lmh1b0Ax
MzkuY29tDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KamdnQG52aWRpYS5jb20NCmNqaWFAbnZpZGlh
LmNvbQ0KRWxlbmEgVWZpbXRzZXZhDQprb25yYWQud2lsa0BvcmFjbGUuY29tDQphbGVAcmV2Lm5n
DQphbmpvQHJldi5uZw0KU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0Kd2VpLncud2FuZ0BpbnRl
bC5jb20NCkNoYW8gUGVuZw0KcWVtdS1kZXZlbEBub25nbnUub3JnDQptYnVydG9uQHF0aS5xdWFs
Y29tbS5jb20NClZpZXcgYWxsIGd1ZXN0IGluZm8gIA0KaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUu
Y29tL2NhbGVuZGFyL2V2ZW50P2FjdGlvbj1WSUVXJmVpZD1OV1IwTldwcE9EZHFOWEZ5WXpBd2J6
WXphM1J4TjJkb2IzVWdjV1Z0ZFMxa1pYWmxiRUJ1YjI1bmJuVXViM0puJnRvaz1OVElqWldkbFpE
ZGphMmt3Tld4dGRURjBibWQyYTJ3emRHaHBaSE5BWjNKdmRYQXVZMkZzWlc1a1lYSXVaMjl2WjJ4
bExtTnZiVGxoWldJMk9XWTBNbUUwWlRBM05qUXpPR014T1dSaE5tTTNOREZtWkRjeFpUZzFObUV5
WkdZJmN0ej1FdXJvcGUlMkZNYWRyaWQmaGw9ZW4mZXM9MA0KDQpSZXBseSBmb3IgcWVtdS1kZXZl
bEBub25nbnUub3JnIGFuZCB2aWV3IG1vcmUgZGV0YWlscyAgDQpodHRwczovL2NhbGVuZGFyLmdv
b2dsZS5jb20vY2FsZW5kYXIvZXZlbnQ/YWN0aW9uPVZJRVcmZWlkPU5XUjBOV3BwT0RkcU5YRnlZ
ekF3YnpZemEzUnhOMmRvYjNVZ2NXVnRkUzFrWlhabGJFQnViMjVuYm5VdWIzSm4mdG9rPU5USWpa
V2RsWkRkamEya3dOV3h0ZFRGMGJtZDJhMnd6ZEdocFpITkFaM0p2ZFhBdVkyRnNaVzVrWVhJdVoy
OXZaMnhsTG1OdmJUbGhaV0kyT1dZME1tRTBaVEEzTmpRek9HTXhPV1JoTm1NM05ERm1aRGN4WlRn
MU5tRXlaR1kmY3R6PUV1cm9wZSUyRk1hZHJpZCZobD1lbiZlcz0wDQpZb3VyIGF0dGVuZGFuY2Ug
aXMgb3B0aW9uYWwuDQoNCn5+Ly9+fg0KSW52aXRhdGlvbiBmcm9tIEdvb2dsZSBDYWxlbmRhcjog
aHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyLw0KDQpZb3UgYXJlIHJlY2Vpdmlu
ZyB0aGlzIGVtYWlsIGJlY2F1c2UgeW91IGFyZSBhbiBhdHRlbmRlZSBvbiB0aGUgZXZlbnQuIFRv
ICANCnN0b3AgcmVjZWl2aW5nIGZ1dHVyZSB1cGRhdGVzIGZvciB0aGlzIGV2ZW50LCBkZWNsaW5l
IHRoaXMgZXZlbnQuDQoNCkZvcndhcmRpbmcgdGhpcyBpbnZpdGF0aW9uIGNvdWxkIGFsbG93IGFu
eSByZWNpcGllbnQgdG8gc2VuZCBhIHJlc3BvbnNlIHRvICANCnRoZSBvcmdhbml6ZXIsIGJlIGFk
ZGVkIHRvIHRoZSBndWVzdCBsaXN0LCBpbnZpdGUgb3RoZXJzIHJlZ2FyZGxlc3Mgb2YgIA0KdGhl
aXIgb3duIGludml0YXRpb24gc3RhdHVzLCBvciBtb2RpZnkgeW91ciBSU1ZQLg0KDQpMZWFybiBt
b3JlIGh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2NhbGVuZGFyL2Fuc3dlci8zNzEzNSNmb3J3
YXJkaW5nDQo=
--0000000000002de4e2060f3b83e7
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
c00o63ktq7ghou"/><span style=3D"display: none; font-size: 1px; color: #fff;=
 line-height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacit=
y: 0; overflow: hidden;" itemprop=3D"name">QEMU developers fortnightly conf=
erence call</span><meta itemprop=3D"url" content=3D"https://calendar.google=
.com/calendar/event?action=3DVIEW&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2d=
ob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2w=
zdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNm=
M3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0"/><s=
pan aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20220823T=
130000Z"></time><time itemprop=3D"endDate" datetime=3D"20220823T140000Z"></=
time></span><div style=3D"display: none; font-size: 1px; color: #fff; line-=
height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacity: 0; =
overflow: hidden;">If you need call details, please contact me: quintela@re=
dhat.com</div><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D"body-cont=
ainer"><tbody><tr><td style=3D"" class=3D"" align=3D"left"><!--[if mso | IE=
]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentat=
ion"><tr><td height=3D"16" style=3D"height:16px;"><![endif]--><div style=3D=
"height:16px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></=
tr></table><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D=
"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""=
><tbody><tr><td style=3D"background-color: #e6f4ea;color: #0d5327;padding: =
12px 32px; border-radius: 8px;font-family: Roboto, sans-serif;font-size: 14=
px; line-height: 20px;text-align: left;" class=3D"info-bar-inner"><span sty=
le=3D"font-weight: 700;">This event has been updated</span><br/><span style=
=3D"display:none" itemprop=3D"about" itemscope itemtype=3D"http://schema.or=
g/Thing/Clock"><meta itemprop=3D"description" content=3D"Time updated"/></s=
pan><div style=3D""><span style=3D"font-weight: 700;">Changed:</span> time<=
/div></td></tr></tbody></table><!--[if mso | IE]><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D"12" s=
tyle=3D"height:12px;"><![endif]--><div style=3D"height:12px;" aria-hidden=
=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
align=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"b=
order: solid 1px #dadce0; border-radius: 8px; direction: rtl; font-size: 0;=
 padding: 24px 32px; text-align: left; vertical-align: top;" class=3D"main-=
container-inner"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" ce=
llspacing=3D"0" role=3D"presentation"><tr><![endif]--><div class=3D"" style=
=3D"font-size: 13px; text-align: left; direction: ltr; display: inline-bloc=
k; vertical-align: top; width: 100%;overflow: hidden; word-wrap: break-word=
;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presenta=
tion" width=3D"100%" class=3D"main-column-table-ltr" style=3D"padding-right=
: 32px; padding-left: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main=
-column-td" style=3D"padding:0; vertical-align:top;"><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%" styl=
e=3D"table-layout: fixed;"><tr><td style=3D"font-size: 0; padding: 0; text-=
align: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"fo=
nt-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-si=
ze: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-dec=
oration: none;" class=3D"primary-text" role=3D"presentation"><span>If you n=
eed call details, please contact me: <a href=3D"mailto:quintela@redhat.com"=
 target=3D"_blank">quintela@redhat.com</a></span><meta itemprop=3D"descript=
ion" content=3D"If you need call details, please contact me: quintela@redha=
t.com"/></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-ali=
gn: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-=
family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size:=
 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decora=
tion: none;" class=3D"primary-text" role=3D"presentation"><span aria-hidden=
=3D"true"><time itemprop=3D"startDate" datetime=3D"20220823T130000Z"></time=
><time itemprop=3D"endDate" datetime=3D"20220823T140000Z"></time></span><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"=
font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-web=
kit-font-smoothing: antialiased;margin: 0; padding: 0;">When</h2></td><td s=
tyle=3D"width: 8px;"></td><td style=3D"padding-top: 2px; padding-bottom: 3p=
x;"><div style=3D"background-color: #1e8e3e; border-radius: 10px; padding: =
1px 5px; line-height: 13px;"><span style=3D"color: white; font-size: 11px; =
font-weight: 700; letter-spacing: 0.8px; text-transform: uppercase; vertica=
l-align: top;">CHANGED</span></div></td></tr></table><span>Every 2 weeks fr=
om 15:00 to 16:00 on Tuesday from Tuesday 2022-08-23 to Tuesday 2024-01-23 =
(Central European Time - Madrid)<br/><span style=3D"text-decoration: line-t=
hrough;"><del><span style=3D"display: none; font-size: 1px; color: #fff; li=
ne-height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacity: =
0; overflow: hidden;font-size: 0; display: block;">Old: </span>Every 2 week=
s from 15:00 to 16:00 on Tuesday (Central European Time - Madrid)</del></sp=
an></span></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-a=
lign: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"fon=
t-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-siz=
e: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-deco=
ration: none;" class=3D"primary-text" role=3D"presentation"><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"p=
adding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size:=
 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-s=
moothing: antialiased;margin: 0; padding: 0;">Location</h2></td></tr></tabl=
e><span itemprop=3D"location" itemscope itemtype=3D"http://schema.org/Place=
"><span itemprop=3D"name" class=3D"primary-text notranslate" style=3D"font-=
family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size:=
 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decora=
tion: none;">https://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https=
://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=
=3DD&amp;ust=3D1706030100000000&amp;usg=3DAOvVaw1DkiliVIT6sra6p7FNWWo0" cla=
ss=3D"accent-text underline-on-hover" style=3D"display: inline-block;;color=
: #1a73e8; text-decoration: none;font-weight: 700;" target=3D"_blank" itemp=
rop=3D"map">View map</a></span></div></td></tr><tr><td style=3D"font-size: =
0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:24p=
x;"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-=
weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;colo=
r: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presenta=
tion"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"prese=
ntation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" =
style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight:=
 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2=
></td></tr></table><div style=3D"padding-bottom: 4px; text-align: left;;col=
or: #3c4042;"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:f4bug@amsat.org">Philippe =
Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" content=3D"f4bug@amsa=
t.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:joao.m.m=
artins@oracle.com">Joao Martins</a></span><meta itemprop=3D"email" content=
=3D"joao.m.martins@oracle.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:quintela@redhat.com">quintela@redhat.com</a></span><meta it=
emprop=3D"email" content=3D"quintela@redhat.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:mdean@redhat.com">mdean@redhat.com</a></s=
pan><meta itemprop=3D"email" content=3D"mdean@redhat.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:felipe@nutanix.com">felipe@nutan=
ix.com</a></span><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:afaerber@suse.de"=
>afaerber@suse.de</a></span><meta itemprop=3D"email" content=3D"afaerber@su=
se.de"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:bbauman@=
redhat.com">bbauman@redhat.com</a></span><meta itemprop=3D"email" content=
=3D"bbauman@redhat.com"/></span><span class=3D"secondary-text" style=3D"col=
or: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"at=
tendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"n=
ame" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" sty=
le=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:cw@f00f.org">cw@f00f.org</a></span><meta itemprop=3D"email" cont=
ent=3D"cw@f00f.org"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:eblake@redhat.com">eblake@redhat.com</a></span><meta itemprop=3D"ema=
il" content=3D"eblake@redhat.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</a></=
span><meta itemprop=3D"email" content=3D"edgar.iglesias@gmail.com"/></span>=
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
:iggy@theiggy.com">iggy@theiggy.com</a></span><meta itemprop=3D"email" cont=
ent=3D"iggy@theiggy.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D=
"email" content=3D"jan.kiszka@web.de"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com</a></sp=
an><meta itemprop=3D"email" content=3D"jidong.xiao@gmail.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:jjherne@linux.vnet.ibm.com=
">jjherne@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" content=3D"=
jjherne@linux.vnet.ibm.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.com</a></span><=
meta itemprop=3D"email" content=3D"mimu@linux.vnet.ibm.com"/></span><span c=
lass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></=
span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sc=
hema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"=
primary-text underline-on-hover" style=3D"display: inline-block;;color: #3c=
4043; text-decoration: none;" href=3D"mailto:peter.maydell@linaro.org">pete=
r.maydell@linaro.org</a></span><meta itemprop=3D"email" content=3D"peter.ma=
ydell@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee=
" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" c=
lass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"=
display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a></span><me=
ta itemprop=3D"email" content=3D"richard.henderson@linaro.org"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:stefanha@gmail.com">stefan=
ha@gmail.com</a></span><meta itemprop=3D"email" content=3D"stefanha@gmail.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:imp@bsdimp.=
com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=3D"imp@bsdim=
p.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:z.huo@13=
9.com">z.huo@139.com</a></span><meta itemprop=3D"email" content=3D"z.huo@13=
9.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:zwu.kern=
el@gmail.com">zwu.kernel@gmail.com</a></span><meta itemprop=3D"email" conte=
nt=3D"zwu.kernel@gmail.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a></span><meta itemprop=3D"e=
mail" content=3D"jgg@nvidia.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div><div><span itemp=
rop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span item=
prop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-h=
over" style=3D"display: inline-block;;color: #3c4043; text-decoration: none=
;" href=3D"mailto:cjia@nvidia.com">cjia@nvidia.com</a></span><meta itemprop=
=3D"email" content=3D"cjia@nvidia.com"/></span><span class=3D"secondary-tex=
t" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span=
 itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><spa=
n itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underlin=
e-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration=
: none;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></sp=
an><meta itemprop=3D"email" content=3D"elena.ufimtseva@oracle.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:konrad.wilk@oracle.com"=
>konrad.wilk@oracle.com</a></span><meta itemprop=3D"email" content=3D"konra=
d.wilk@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:ale@rev.ng">ale@rev.ng</a></span><meta itemprop=3D"email" content=3D"al=
e@rev.ng"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:anjo@=
rev.ng">anjo@rev.ng</a></span><meta itemprop=3D"email" content=3D"anjo@rev.=
ng"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:shameerali.=
kolothum.thodi@huawei.com">Shameerali Kolothum Thodi</a></span><meta itempr=
op=3D"email" content=3D"shameerali.kolothum.thodi@huawei.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:wei.w.wang@intel.com">wei.=
w.wang@intel.com</a></span><meta itemprop=3D"email" content=3D"wei.w.wang@i=
ntel.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:chao.=
p.peng@linux.intel.com">Chao Peng</a></span><meta itemprop=3D"email" conten=
t=3D"chao.p.peng@linux.intel.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a></span><=
meta itemprop=3D"email" content=3D"qemu-devel@nongnu.org"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:mburton@qti.qualcomm.com">mburto=
n@qti.qualcomm.com</a></span><meta itemprop=3D"email" content=3D"mburton@qt=
i.qualcomm.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div></div><a href=3D"https://calendar=
.google.com/calendar/event?action=3DVIEW&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYz=
a3RxN2dob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0=
bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGM=
xOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=
=3D0" style=3D"display: inline-block;;color: #1a73e8; text-decoration: none=
;font-weight: 700;" target=3D"_blank" class=3D"accent-text underline-on-hov=
er">View all guest info</a></div></td></tr><tr><td style=3D"font-size: 0; p=
adding: 0; text-align: left; word-break: break-word;;padding-bottom:0px;"><=
div style=3D"color: #3c4043; text-decoration: none;;font-family: Roboto, sa=
ns-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: exactly;=
 text-align: left;" class=3D"primary-text"><div><span style=3D"font-weight:=
 700;-webkit-font-smoothing: antialiased;">RSVP</span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"> for <a class=3D=
"secondary-text underline-on-hover" style=3D"display: inline-block;;color: =
#70757a; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu=
-devel@nongnu.org</a> for all events in this series</span></div></div></td>=
</tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-brea=
k: break-word;;padding-bottom:16px;"><div style=3D"font-family: Roboto, san=
s-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: exactly; =
text-align: left;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" =
role=3D"presentation" style=3D"border-collapse: separate;"><tr><td style=3D=
"padding-top: 8px; padding-left: 0; padding-right: 12px;"><!-- RSVP buttons=
 --><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"present=
ation" style=3D"border: solid 1px #dadce0; border-radius: 16px; border-coll=
apse: separate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;;disp=
lay: inline-block;;margin-right: 12px; margin-left: 0;"><tr><td align=3D"ce=
nter" vertical-align=3D"middle" role=3D"presentation"><span itemprop=3D"pot=
entialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta ite=
mprop=3D"attendance" content=3D"http://schema.org/RsvpAttendance/Yes"/><spa=
n itemprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHa=
ndler"><link itemprop=3D"method" href=3D"http://schema.org/HttpRequestMetho=
d/GET"/><span style=3D"color: #5f6367;"><a href=3D"https://calendar.google.=
com/calendar/event?action=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN=
2dob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D1&amp;tok=3DNTIjZWdlZDdja2kwN=
WxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3=
NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&a=
mp;es=3D0" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Ro=
boto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-li=
ne-height-rule: exactly; margin: 0; text-decoration: none; text-transform: =
none;" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><table=
 border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr=
><td align=3D"center" role=3D"presentation" valign=3D"middle" style=3D"padd=
ing: 6px 0; padding-left: 16px; padding-right: 12px; white-space: nowrap;">=
<!--[if mso]><a href=3D"https://calendar.google.com/calendar/event?action=
=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub2=
5nbnUub3Jn&amp;rst=3D1&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3=
JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZ=
Tg1NmEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-=
button-text" itemprop=3D"url" target=3D"_blank"><![endif]--><span class=3D"=
grey-button-text" style=3D"font-weight: 400;font-family: &#39;Google Sans&#=
39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%;=
 mso-line-height-rule: exactly; margin: 0; text-decoration: none; text-tran=
sform: none;">Yes</span><!--[if mso]></a><![endif]--></td></tr></table></a>=
</span></span></span></td><td align=3D"center" vertical-align=3D"middle" ro=
le=3D"presentation" style=3D"border-left: solid 1px #dadce0; border-right: =
solid 1px #dadce0;"><span itemprop=3D"potentialaction" itemscope itemtype=
=3D"http://schema.org/RsvpAction"><meta itemprop=3D"attendance" content=3D"=
http://schema.org/RsvpAttendance/No"/><span itemprop=3D"handler" itemscope =
itemtype=3D"http://schema.org/HttpActionHandler"><link itemprop=3D"method" =
href=3D"http://schema.org/HttpRequestMethod/GET"/><span style=3D"color: #5f=
6367;"><a href=3D"https://calendar.google.com/calendar/event?action=3DRESPO=
ND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub25nbnUub3=
Jn&amp;rst=3D2&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2=
FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZ=
GY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: =
400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; =
font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: =
0; text-decoration: none; text-transform: none;" class=3D"grey-button-text"=
 itemprop=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" role=3D"presentation"><tr><td align=3D"center" role=3D"pre=
sentation" valign=3D"middle" style=3D"padding: 6px 12px; white-space: nowra=
p;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/event?acti=
on=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBu=
b25nbnUub3Jn&amp;rst=3D2&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNA=
Z3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDc=
xZTg1NmEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"gre=
y-button-text" itemprop=3D"url" target=3D"_blank"><![endif]--><span class=
=3D"grey-button-text" style=3D"font-weight: 400;font-family: &#39;Google Sa=
ns&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: 1=
20%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; text-=
transform: none;">No</span><!--[if mso]></a><![endif]--></td></tr></table><=
/a></span></span></span></td><td align=3D"center" vertical-align=3D"middle"=
 role=3D"presentation"><span itemprop=3D"potentialaction" itemscope itemtyp=
e=3D"http://schema.org/RsvpAction"><meta itemprop=3D"attendance" content=3D=
"http://schema.org/RsvpAttendance/Maybe"/><span itemprop=3D"handler" itemsc=
ope itemtype=3D"http://schema.org/HttpActionHandler"><link itemprop=3D"meth=
od" href=3D"http://schema.org/HttpRequestMethod/GET"/><span style=3D"color:=
 #5f6367;"><a href=3D"https://calendar.google.com/calendar/event?action=3DR=
ESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub25nbn=
Uub3Jn&amp;rst=3D3&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdX=
AuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1N=
mEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"font-weig=
ht: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f63=
68; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; marg=
in: 0; text-decoration: none; text-transform: none;" class=3D"grey-button-t=
ext" itemprop=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0" role=3D"presentation"><tr><td align=3D"center" role=3D=
"presentation" valign=3D"middle" style=3D"padding: 6px 0; padding-left: 12p=
x; padding-right: 16px; white-space: nowrap;"><!--[if mso]><a href=3D"https=
://calendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DNWR0NWppOD=
dqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D3&amp;tok=
=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNv=
bTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEurope%2F=
Madrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" =
target=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=3D"fon=
t-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color:=
 #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly=
; margin: 0; text-decoration: none; text-transform: none;">Maybe</span><!--=
[if mso]></a><![endif]--></td></tr></table></a></span></span></span></td></=
tr></table><!-- More options --><a href=3D"https://calendar.google.com/cale=
ndar/event?action=3DVIEW&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3UgcWVt=
dS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNA=
Z3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDc=
xZTg1NmEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"dis=
play: inline-block;;font-weight: 400;font-family: &#39;Google Sans&#39;, Ro=
boto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-li=
ne-height-rule: exactly; margin: 0; text-decoration: none; text-transform: =
none;" class=3D"grey-button-text" target=3D"_blank"><table border=3D"0" cel=
lpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"border: sol=
id 1px #dadce0; border-radius: 16px; border-collapse: separate;font-family:=
 &#39;Google Sans&#39;, Roboto, sans-serif;"><tr><td align=3D"center" verti=
cal-align=3D"middle" role=3D"presentation" style=3D"padding: 6px 0; padding=
-left: 16px; padding-right: 12px; white-space: nowrap;;color: #5f6367;"><!-=
-[if mso]><a href=3D"https://calendar.google.com/calendar/event?action=3DVI=
EW&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub25nbnUub3=
Jn&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ2=
9vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=
=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" targe=
t=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=3D"font-wei=
ght: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6=
368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; mar=
gin: 0; text-decoration: none; text-transform: none;">More options</span><!=
--[if mso]></a><![endif]--></td></tr></table></a></td></tr></table></div></=
td></tr></table></td></tr></tbody></table></div><!--[if mso | IE]></tr></ta=
ble><![endif]--></td></tr></tbody></table><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"wi=
dth:100%;" class=3D""><tbody><tr><td style=3D"font-size: 0; padding: 0; tex=
t-align: left; word-break: break-word;;padding:4px 12px;" class=3D"" align=
=3D"left"><div class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;font-family: Roboto, sans-serif;font-size: 12px; line-height: 1=
6px; mso-line-height-rule: exactly; text-align: left;"><p>Invitation from <=
a href=3D"https://calendar.google.com/calendar/" class=3D"accent-text under=
line-on-hover" style=3D"font-family: Roboto, sans-serif;font-size: 12px; li=
ne-height: 16px; mso-line-height-rule: exactly;;color: #1a73e8; text-decora=
tion: none;" target=3D"_blank">Google Calendar</a></p><p>You are receiving =
this email because you are an attendee on the event. To stop receiving futu=
re updates for this event, decline this event.</p><p>Forwarding this invita=
tion could allow any recipient to send a response to the organizer, be adde=
d to the guest list, invite others regardless of their own invitation statu=
s, or modify your RSVP. <a class=3D"accent-text underline-on-hover" style=
=3D"font-family: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso=
-line-height-rule: exactly;;color: #1a73e8; text-decoration: none;" href=3D=
"https://support.google.com/calendar/answer/37135#forwarding">Learn more</a=
></p></div></td></tr></tbody></table></td></tr></tbody></table></span></spa=
n></body></html>
--0000000000002de4e2060f3b83e7
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
DTSTART;TZID=America/New_York:20220823T090000
DTEND;TZID=America/New_York:20220823T100000
RRULE:FREQ=WEEKLY;WKST=MO;UNTIL=20240109T045959Z;INTERVAL=2;BYDAY=TU
DTSTAMP:20240118T171538Z
ORGANIZER;CN=KVM call for qemu developers:mailto:eged7cki05lmu1tngvkl3thids
 @group.calendar.google.com
UID:5dt5ji87j5qrc00o63ktq7ghou@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;X-NUM-GUESTS=0:mailto:f4bug@amsat.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Joao Martins;X-NUM-GUESTS=0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=quintela@redhat.com;X-NUM-GUESTS=0:mailto:quintela@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mdean@redhat.com;X-NUM-GUESTS=0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=felipe@nutanix.com;X-NUM-GUESTS=0:mailto:felipe@nutanix.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=afaerber@suse.de;X-NUM-GUESTS=0:mailto:afaerber@suse.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=bbauman@redhat.com;X-NUM-GUESTS=0:mailto:bbauman@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=cw@f00f.org;X-NUM-GUESTS=0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=eblake@redhat.com;X-NUM-GUESTS=0:mailto:eblake@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=edgar.iglesias@gmail.com;X-NUM-GUESTS=0:mailto:edgar.iglesias@gmail
 .com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=eric.auger@redhat.com;X-NUM-GUESTS=0:mailto:eric.auger@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=iggy@theiggy.com;X-NUM-GUESTS=0:mailto:iggy@theiggy.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jan.kiszka@web.de;X-NUM-GUESTS=0:mailto:jan.kiszka@web.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jidong.xiao@gmail.com;X-NUM-GUESTS=0:mailto:jidong.xiao@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jjherne@linux.vnet.ibm.com;X-NUM-GUESTS=0:mailto:jjherne@linux.vnet
 .ibm.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mimu@linux.vnet.ibm.com;X-NUM-GUESTS=0:mailto:mimu@linux.vnet.ibm.c
 om
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
 TRUE;CN=z.huo@139.com;X-NUM-GUESTS=0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=zwu.kernel@gmail.com;X-NUM-GUESTS=0:mailto:zwu.kernel@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jgg@nvidia.com;X-NUM-GUESTS=0:mailto:jgg@nvidia.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=cjia@nvidia.com;X-NUM-GUESTS=0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Elena Ufimtseva;X-NUM-GUESTS=0:mailto:elena.ufimtseva@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=konrad.wilk@oracle.com;X-NUM-GUESTS=0:mailto:konrad.wilk@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=ale@rev.ng;X-NUM-GUESTS=0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=anjo@rev.ng;X-NUM-GUESTS=0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Shameerali Kolothum Thodi;X-NUM-GUESTS=0:mailto:shameerali.kolothum
 .thodi@huawei.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=wei.w.wang@intel.com;X-NUM-GUESTS=0:mailto:wei.w.wang@intel.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Chao Peng;X-NUM-GUESTS=0:mailto:chao.p.peng@linux.intel.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=qemu-devel@nongnu.org;X-NUM-GUESTS=0:mailto:qemu-devel@nongnu.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=mburton@qti.qualcomm.com;X-NUM-GUESTS=0:mailto:mburton@qti.qualcomm.com
X-MICROSOFT-CDO-OWNERAPPTID:-1326661108
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

--0000000000002de4e2060f3b83e7--

--0000000000002de4e4060f3b83e9
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
UlQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjIwODIzVDA5MDAwMA0KRFRFTkQ7VFpJRD1BbWVy
aWNhL05ld19Zb3JrOjIwMjIwODIzVDEwMDAwMA0KUlJVTEU6RlJFUT1XRUVLTFk7V0tTVD1NTztV
TlRJTD0yMDI0MDEwOVQwNDU5NTlaO0lOVEVSVkFMPTI7QllEQVk9VFUNCkRUU1RBTVA6MjAyNDAx
MThUMTcxNTM4Wg0KT1JHQU5JWkVSO0NOPUtWTSBjYWxsIGZvciBxZW11IGRldmVsb3BlcnM6bWFp
bHRvOmVnZWQ3Y2tpMDVsbXUxdG5ndmtsM3RoaWRzDQogQGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5j
b20NClVJRDo1ZHQ1amk4N2o1cXJjMDBvNjNrdHE3Z2hvdUBnb29nbGUuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpmNGJ1Z0BhbXNhdC5vcmcNCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Sm9hbyBNYXJ0aW5zO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049
cXVpbnRlbGFAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cXVpbnRlbGFAcmVkaGF0
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tZGVhbkByZWRoYXQuY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzptZGVhbkByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPWZlbGlwZUBudXRhbml4LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZmVsaXBlQG51
dGFuaXguY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWFmYWVyYmVyQHN1c2UuZGU7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFmYWVyYmVyQHN1c2UuZGUNCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049YmJhdW1hbkByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpiYmF1
bWFuQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Y3dAZjAwZi5vcmc7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmN3QGYwMGYub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPWVibGFrZUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxha2VAcmVk
aGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lZGdhci5pZ2xlc2lhc0BnbWFp
bC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVkZ2FyLmlnbGVzaWFzQGdtYWlsDQogLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lcmljLmF1Z2VyQHJlZGhhdC5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1pZ2d5QHRoZWlnZ3kuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzppZ2d5QHRo
ZWlnZ3kuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWphbi5raXN6a2FAd2ViLmRl
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqYW4ua2lzemthQHdlYi5kZQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1qaWRvbmcueGlhb0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRv
OmppZG9uZy54aWFvQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qamhl
cm5lQGxpbnV4LnZuZXQuaWJtLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ampoZXJuZUBsaW51
eC52bmV0DQogLmlibS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWltdUBsaW51
eC52bmV0LmlibS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1pbXVAbGludXgudm5ldC5pYm0u
Yw0KIG9tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8NCiAub3JnDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnJpY2hhcmQuaGVuZGVyc28NCiBuQGxpbmFyby5vcmcNCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049c3RlZmFuaGFAZ21haWwuY29tO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzpzdGVmYW5oYUBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049
aW1wQGJzZGltcC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmltcEBic2RpbXAuY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXouaHVvQDEzOS5jb207WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOnouaHVvQDEzOS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049end1Lmtlcm5l
bEBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnp3dS5rZXJuZWxAZ21haWwuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWpnZ0BudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpqZ2dAbnZpZGlhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jamlh
QG52aWRpYS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNqaWFAbnZpZGlhLmNvbQ0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMt
QUNUSU9OO1JTVlA9DQogVFJVRTtDTj1FbGVuYSBVZmltdHNldmE7WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOmVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPWtvbnJhZC53aWxrQG9yYWNsZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmtvbnJhZC53
aWxrQG9yYWNsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YWxlQHJldi5uZztY
LU5VTS1HVUVTVFM9MDptYWlsdG86YWxlQHJldi5uZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1hbmpvQHJldi5uZztYLU5VTS1HVUVTVFM9MDptYWlsdG86YW5qb0ByZXYubmcNCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049U2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86c2hhbWVlcmFsaS5rb2xvdGh1bQ0KIC50aG9kaUBodWF3ZWkuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1B
Q0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049d2VpLncud2FuZ0BpbnRlbC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOndlaS53LndhbmdAaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPUNoYW8gUGVuZztYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2hhby5wLnBlbmdAbGludXguaW50
ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXFlbXUtZGV2ZWxAbm9uZ251Lm9y
ZztYLU5VTS1HVUVTVFM9MDptYWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtS
U1ZQPVRSVUUNCiA7Q049bWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzptYnVydG9uQHF0aS5xdWFsY29tbS5jb20NClgtTUlDUk9TT0ZULUNETy1PV05FUkFQUFRJ
RDotMTMyNjY2MTEwOA0KQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIwMjIwODIzVDE1MDAyMloNCkRF
U0NSSVBUSU9OOklmIHlvdSBuZWVkIGNhbGwgZGV0YWlsc1wsIHBsZWFzZSBjb250YWN0IG1lOiBx
dWludGVsYUByZWRoYXQuYw0KIG9tDQpMQVNULU1PRElGSUVEOjIwMjQwMTE4VDE3MTUyOVoNCkxP
Q0FUSU9OOmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcNClNFUVVFTkNFOjENClNU
QVRVUzpDT05GSVJNRUQNClNVTU1BUlk6UUVNVSBkZXZlbG9wZXJzIGZvcnRuaWdodGx5IGNvbmZl
cmVuY2UgY2FsbA0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KRU5EOlZDQUxFTkRBUg0K
--0000000000002de4e4060f3b83e9--

