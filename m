Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E910B92A54E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jul 2024 17:00:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpqc-0001sU-Rk; Mon, 08 Jul 2024 11:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <33_6LZgsKCkgkvo7.loxxoovsxk1y.y1q0ow4-no5ovxyxqx4.y1q@calendar-server.bounces.google.com>)
 id 1sQpqP-0001kR-0E
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:59:57 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <33_6LZgsKCkgkvo7.loxxoovsxk1y.y1q0ow4-no5ovxyxqx4.y1q@calendar-server.bounces.google.com>)
 id 1sQpqJ-0000Pi-Qz
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:59:56 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-42661a89287so14402795e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720450784; x=1721055584; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ar3t88uvbOGwA5EJQzMP1xJ/BmxMsARFWIr7lv6RKjs=;
 b=2PtHwL4RqE3EK5+sdEi8RMeCKtU/rxxyHhKoTIe2M47cMALzuzju+DYYB0Z5l37Nv3
 88fjKeVwUqn67bTiiVFVCZnq/0bdoNxr/sm4RqUk59h8vZrhYitvjxAPWHsqnEZqp2C2
 PCiDAxXJaaYB600UCAm6SbaxLGoxtScCbxafMMnpQhYtEJfmlxWpfy8OvknlHBEhmf+H
 l3kIf4UO5tfBUMb6gNrdp7v4/pIafH+AEnXvicSEVZBKDca4ReMEpxsg8GRVLI+briw8
 Ng0aRY/3GMlyxdlnwlN3Ws7B633y20U2+9+OzBH/XQ7+63X7agjhWRw5BsXh4KgbErR+
 puQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720450784; x=1721055584; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ar3t88uvbOGwA5EJQzMP1xJ/BmxMsARFWIr7lv6RKjs=;
 b=EJFZB6459JbYoQNuYgCBvzvxocW3W5SeUCeLubhRPR7IKXjpSjWUkcsLbFz0NCkr+c
 Q24A2/BUL8CXA6W5hsJ1/8HI+3cBvR5FnPEVwUNDZc+N7mvf3iYtXKcYOaIWotFG1o5/
 RUjs2ude1you8dhqmPiO61TqhaAYp2VO5cmDzOZPwwkdJpNmbIDrcU9c4yKJsV9bR/a/
 vFe9uIujoPVRb8cu3NfCRBArkCCeqoezqCv1N8EYEj1EEYG8aMHtSYQRnnZxBHcsd5TE
 EBYF1ZLNNF8olDWt9xsPqBjbiwOKhIhmoyMZsWk8iHMUT4qmtdMtkmqcK1nEIR42Ixdg
 XqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720450784; x=1721055584;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ar3t88uvbOGwA5EJQzMP1xJ/BmxMsARFWIr7lv6RKjs=;
 b=B1Ut2gRnpeiMOVh68EP6xgndL2WF236XC2TctBrLps4EYv+ZbaUz7LjJNkEiN1z47z
 Cf2R073D9oD3lt9Vb+/JC5M69j2tyzszjglTlX5TNXPpqlbW6NU9jOmpObga3qtHQm8F
 d0LCqW57rUVjK/Y77VMCJoBdg2nr+5nltrp13Zs23VT5e2zVDKjrzRRSHk0FXsNlyYc3
 ZR2Wsdvip3AEvP2bv76x5ZMXbieauF/EmCcjfmk6iXbvbgn6LZhmpIRkhi6rRhaEG3EA
 Rgk0Ukuj1cyNxWUwf4bCZa5Phh1OLCQ9b3Qbby4fOPRu1jH7JzDL/bdvFV3c84d7PARJ
 NpEw==
X-Gm-Message-State: AOJu0YwNECp+rS/+cehcHdbplhIIsT1sy6K9NN7QmB8ys0uyLXTI2KDI
 TSG5KkiCn/PuJv1G+2a8ZB3Pt28h9Y1QEtpcJJgbQt7d+Rx2BbAQW0c/CVUpTDOO7x1JzOWR9AW
 9qTVLRjz+9ROFpwZYZPTf5Fr62dn55ASkJ9R4xptjlLSsSJdg+Q==
X-Google-Smtp-Source: AGHT+IFAIVHWbjLtiyqUP8spLI8DdLoKEBvztFr8ceDrxBJNlXpYiFQwJ0x8u2htcUzQm+xE3mXuIAS6DFYMySBFBoL3
MIME-Version: 1.0
X-Received: by 2002:a05:6000:4023:b0:366:eb00:9ddd with SMTP id
 ffacd0b85a97d-3679dd1576emr9145133f8f.8.1720450783592; Mon, 08 Jul 2024
 07:59:43 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-f7db9b85-cc1a-4143-9341-cf2a75fa2d8a@google.com>
Date: Mon, 08 Jul 2024 14:59:43 +0000
Subject: Updated invitation: QEMU/KVM developers conference call @ Every 2
 weeks from 14:00 to 15:00 on Tuesday (BST) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>, 
 Alistair Francis <alistair.francis@wdc.com>, armbru@redhat.com,
 bcain@quicinc.com, berrange@redhat.com, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 cw@f00f.org, eblake@redhat.com, edgar.iglesias@gmail.com, eduardo@habkost.net, 
 felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com, jgg@nvidia.com, 
 jidong.xiao@gmail.com, jim.shu@sifive.com, konrad.wilk@oracle.com, 
 mburton@qti.qualcomm.com, mdean@redhat.com, paul.walmsley@sifive.com, 
 pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, shentey@gmail.com,
 stefanha@gmail.com, wei.w.wang@intel.com, zwu.kernel@gmail.com, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, eblot@rivosinc.com, 
 max.chou@sifive.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 afaerber@suse.de, 
 Anton Johansson <anjo@rev.ng>, Chao Peng <chao.p.peng@linux.intel.com>, 
 Damien Hedde <dhedde@kalrayinc.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com, 
 jan.kiszka@web.de, jjherne@linux.vnet.ibm.com, 
 Joao Martins <joao.m.martins@oracle.com>, Luc Michel <luc@lmichel.fr>,
 mimu@linux.vnet.ibm.com, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/mixed; boundary="000000000000cf679d061cbda94d"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=33_6LZgsKCkgkvo7.loxxoovsxk1y.y1q0ow4-no5ovxyxqx4.y1q@calendar-server.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--000000000000cf679d061cbda94d
Content-Type: multipart/alternative; boundary="000000000000cf679d061cbda94b"

--000000000000cf679d061cbda94b
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiB1cGRhdGVkDQoNClFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVy
ZW5jZSBjYWxsDQpFdmVyeSAyIHdlZWtzIGZyb20gMTQ6MDAgdG8gMTU6MDAgb24gVHVlc2RheQ0K
VW5pdGVkIEtpbmdkb20gVGltZQ0KDQpMb2NhdGlvbg0KaHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1j
YWxsbWVldGluZwkNCmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vdXJsP3E9aHR0cHMlM0ElMkYlMkZt
ZWV0LmppdC5zaSUyRmt2bWNhbGxtZWV0aW5nJnNhPUQmdXN0PTE3MjA4ODI3NDAwMDAwMDAmdXNn
PUFPdlZhdzBqeHVJd3BTSndFRzEtVmROdE10Q0sNCg0KDQoNCkF0dGFjaG1lbnRzDQpOb3RlcyDi
gJMgUUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwgIA0KaHR0cHM6Ly9kb2NzLmdv
b2dsZS5jb20vZG9jdW1lbnQvZC8xLUx0cTExTEx6eENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNK
QkdRWnJlay9lZGl0DQoNCklmIHlvdSBuZWVkIGNhbGwgZGV0YWlscywgcGxlYXNlIGNvbnRhY3Qg
bWU6IGFsZXguYmVubmVlQGxpbmFyby5vcmcNCg0KR3Vlc3RzDQpBbGVzc2FuZHJvIERpIEZlZGVy
aWNvDQpBbGV4IEJlbm7DqWUNCkFsaXN0YWlyIEZyYW5jaXMNCmFybWJydUByZWRoYXQuY29tDQpi
Y2FpbkBxdWljaW5jLmNvbQ0KYmVycmFuZ2VAcmVkaGF0LmNvbQ0KY2ppYUBudmlkaWEuY29tDQpD
w6lkcmljIExlIEdvYXRlcg0KY3dAZjAwZi5vcmcNCmVibGFrZUByZWRoYXQuY29tDQplZGdhci5p
Z2xlc2lhc0BnbWFpbC5jb20NCmVkdWFyZG9AaGFia29zdC5uZXQNCmZlbGlwZUBudXRhbml4LmNv
bQ0KaWdneUB0aGVpZ2d5LmNvbQ0KaW1wQGJzZGltcC5jb20NCmpnZ0BudmlkaWEuY29tDQpqaWRv
bmcueGlhb0BnbWFpbC5jb20NCmppbS5zaHVAc2lmaXZlLmNvbQ0Ka29ucmFkLndpbGtAb3JhY2xl
LmNvbQ0KbWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tDQptZGVhbkByZWRoYXQuY29tDQpwYXVsLndh
bG1zbGV5QHNpZml2ZS5jb20NCnBib256aW5pQHJlZGhhdC5jb20NClBldGVyIE1heWRlbGwNClJp
Y2hhcmQgSGVuZGVyc29uDQpzaGVudGV5QGdtYWlsLmNvbQ0Kc3RlZmFuaGFAZ21haWwuY29tDQp3
ZWkudy53YW5nQGludGVsLmNvbQ0Kend1Lmtlcm5lbEBnbWFpbC5jb20NClBoaWwgTWF0aGlldS1E
YXVkw6kNCmVibG90QHJpdm9zaW5jLmNvbQ0KbWF4LmNob3VAc2lmaXZlLmNvbQ0KTWFub3MgUGl0
c2lkaWFuYWtpcw0KYWZhZXJiZXJAc3VzZS5kZQ0KQW50b24gSm9oYW5zc29uDQpDaGFvIFBlbmcN
CkRhbWllbiBIZWRkZQ0KRWxlbmEgVWZpbXRzZXZhDQplcmljLmF1Z2VyQHJlZGhhdC5jb20NCmph
bi5raXN6a2FAd2ViLmRlDQpqamhlcm5lQGxpbnV4LnZuZXQuaWJtLmNvbQ0KSm9hbyBNYXJ0aW5z
DQpMdWMgTWljaGVsDQptaW11QGxpbnV4LnZuZXQuaWJtLmNvbQ0KU2hhbWVlcmFsaSBLb2xvdGh1
bSBUaG9kaQ0Kei5odW9AMTM5LmNvbQ0KTElVIFpoaXdlaQ0KcWVtdS1kZXZlbEBub25nbnUub3Jn
DQpWaWV3IGFsbCBndWVzdCBpbmZvICANCmh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxl
bmRhci9ldmVudD9hY3Rpb249VklFVyZlaWQ9TVdkMmRXSTVORE0xYnpkb2NuSmxiVEJoTUhKaGJH
NXNOV2xmVWpJd01qUXdOekE1VkRFek1EQXdNQ0J4WlcxMUxXUmxkbVZzUUc1dmJtZHVkUzV2Y21j
JnRvaz1OVFFqWTE5ck5YQXliSEJuZG1Kd2RHUnBjbXQxTlhOcE1ERmliRzF1YTBCbmNtOTFjQzVq
WVd4bGJtUmhjaTVuYjI5bmJHVXVZMjl0T0dNeU1tTmxaR1l3TlRCaE5UQXhabVl3Wm1KaFkyWmtP
R1F4TlRJMFpUazVObVl6WVRjek9BJmN0ej1FdXJvcGUlMkZMb25kb24maGw9ZW4mZXM9MA0KDQpS
ZXBseSBmb3IgcWVtdS1kZXZlbEBub25nbnUub3JnIGFuZCB2aWV3IG1vcmUgZGV0YWlscyAgDQpo
dHRwczovL2NhbGVuZGFyLmdvb2dsZS5jb20vY2FsZW5kYXIvZXZlbnQ/YWN0aW9uPVZJRVcmZWlk
PU1XZDJkV0k1TkRNMWJ6ZG9jbkpsYlRCaE1ISmhiRzVzTldsZlVqSXdNalF3TnpBNVZERXpNREF3
TUNCeFpXMTFMV1JsZG1Wc1FHNXZibWR1ZFM1dmNtYyZ0b2s9TlRRalkxOXJOWEF5YkhCbmRtSndk
R1JwY210MU5YTnBNREZpYkcxdWEwQm5jbTkxY0M1allXeGxibVJoY2k1bmIyOW5iR1V1WTI5dE9H
TXlNbU5sWkdZd05UQmhOVEF4Wm1Zd1ptSmhZMlprT0dReE5USTBaVGs1Tm1ZellUY3pPQSZjdHo9
RXVyb3BlJTJGTG9uZG9uJmhsPWVuJmVzPTANCllvdXIgYXR0ZW5kYW5jZSBpcyBvcHRpb25hbC4N
Cg0Kfn4vL35+DQpJbnZpdGF0aW9uIGZyb20gR29vZ2xlIENhbGVuZGFyOiBodHRwczovL2NhbGVu
ZGFyLmdvb2dsZS5jb20vY2FsZW5kYXIvDQoNCllvdSBhcmUgcmVjZWl2aW5nIHRoaXMgZW1haWwg
YmVjYXVzZSB5b3UgYXJlIGFuIGF0dGVuZGVlIG9uIHRoZSBldmVudC4gVG8gIA0Kc3RvcCByZWNl
aXZpbmcgZnV0dXJlIHVwZGF0ZXMgZm9yIHRoaXMgZXZlbnQsIGRlY2xpbmUgdGhpcyBldmVudC4N
Cg0KRm9yd2FyZGluZyB0aGlzIGludml0YXRpb24gY291bGQgYWxsb3cgYW55IHJlY2lwaWVudCB0
byBzZW5kIGEgcmVzcG9uc2UgdG8gIA0KdGhlIG9yZ2FuaXplciwgYmUgYWRkZWQgdG8gdGhlIGd1
ZXN0IGxpc3QsIGludml0ZSBvdGhlcnMgcmVnYXJkbGVzcyBvZiAgDQp0aGVpciBvd24gaW52aXRh
dGlvbiBzdGF0dXMsIG9yIG1vZGlmeSB5b3VyIFJTVlAuDQoNCkxlYXJuIG1vcmUgaHR0cHM6Ly9z
dXBwb3J0Lmdvb2dsZS5jb20vY2FsZW5kYXIvYW5zd2VyLzM3MTM1I2ZvcndhcmRpbmcNCg==
--000000000000cf679d061cbda94b
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
  src: url(//fonts.gstatic.com/s/materialiconsextended/v151/kJEjBvgX7BgnkSr=
UwT8UnLVc38YydejYY-oE_LvM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialicons/v141/Gw6kwdfw6UnXLJCcm=
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
  src: url(//fonts.gstatic.com/s/googlematerialiconsfilled/v116/WWXFlimHYg6=
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
"/></span><meta itemprop=3D"eventId/googleCalendar" content=3D"1gvub9435o7h=
rrem0a0ralnl5i_R20240709T130000"/><span style=3D"display: none; font-size: =
1px; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max=
-width: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develo=
pers conference call</span><meta itemprop=3D"url" content=3D"https://calend=
ar.google.com/calendar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbT=
BhMHJhbG5sNWlfUjIwMjQwNzA5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=
=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUu=
Y29tOGMyMmNlZGYwNTBhNTAxZmYwZmJhY2ZkOGQxNTI0ZTk5NmYzYTczOA&amp;ctz=3DEurope=
%2FLondon&amp;hl=3Den&amp;es=3D0"/><span aria-hidden=3D"true"><time itempro=
p=3D"startDate" datetime=3D"20240709T130000Z"></time><time itemprop=3D"endD=
ate" datetime=3D"20240709T140000Z"></time></span><div style=3D"display: non=
e; font-size: 1px; color: #fff; line-height: 1px; height: 0; max-height: 0;=
 width: 0; max-width: 0; opacity: 0; overflow: hidden;">If you need call de=
tails, please contact me: alex.bennee@linaro.org</div><table border=3D"0" c=
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
has been updated</span></td></tr></tbody></table><!--[if mso | IE]><table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><=
td height=3D"12" style=3D"height:12px;"><![endif]--><div style=3D"height:12=
px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></table=
><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><tbody>=
<tr><td style=3D"border: solid 1px #dadce0; border-radius: 8px; direction: =
rtl; font-size: 0; padding: 24px 32px; text-align: left; vertical-align: to=
p;" class=3D"main-container-inner"><!--[if mso | IE]><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><![endif]--><!-=
-[if mso | IE]><td class=3D"" style=3D"vertical-align:top;width:37%;" ><![e=
ndif]--><div class=3D"column-per-37 outlook-group-fix" style=3D"font-size: =
13px; text-align: left; direction: ltr; display: inline-block; vertical-ali=
gn: top; width: 100%;overflow: hidden; word-wrap: break-word;"><table borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"=
100%"><tbody><tr><td style=3D"vertical-align:top;padding:0;"><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"1=
00%"><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-brea=
k: break-word;;padding-bottom:0px;"><div style=3D"font-family: Roboto, sans=
-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: exactly; t=
ext-align: left;" class=3D"primary-text" role=3D"presentation"><table borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"=
padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size=
: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-=
smoothing: antialiased;margin: 0; padding: 0;">Attachments</h2></td></tr></=
table></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align=
: left; word-break: break-word;;padding-bottom:24px;padding-left: 1px; padd=
ing-right: 1px;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" ro=
le=3D"presentation" class=3D"attachment-chip" style=3D"border: solid 1px #d=
adce0; border-radius: 16px; border-collapse: separate; padding: 4px 0 4px 0=
;"><tr><td style=3D"padding: 3px 10px; height: 14px; width: 14px;"><img src=
=3D"https://drive-thirdparty.googleusercontent.com/16/type/application/vnd.=
google-apps.document" width=3D"14" height=3D"14" alt=3D"" style=3D"display:=
 inline-block; vertical-align: middle;"></td><td align=3D"left" style=3D"pa=
dding: 0; padding-left: 0; padding-right: 10px; max-width: 160px; overflow:=
 hidden; text-overflow: ellipsis; white-space: nowrap;"><div style=3D"overf=
low: hidden; height: 20px;"><a href=3D"https://docs.google.com/document/d/1=
-Ltq11LLzxCccfqfNNKcMG74HMUJf6DURmSJBGQZrek/edit" target=3D"_blank" style=
=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif=
;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: =
exactly; margin: 0; text-decoration: none; text-transform: none;;font-famil=
y: Roboto, sans-serif;; display: inline-block; height: 20px; max-width: 160=
px; line-height: 20px; overflow: hidden; text-overflow: ellipsis; vertical-=
align: middle; white-space: normal;" class=3D"grey-button-text" title=3D"No=
tes =E2=80=93 QEMU/KVM developers conference call">Notes =E2=80=93 QEMU/KVM=
 devel...</a></div></td></tr></table></td></tr></table></td></tr></tbody></=
table></div><!--[if mso | IE]></td><![endif]--><!--[if mso | IE]><td class=
=3D"" style=3D"vertical-align:top;width:63%;padding-right:32px;" ><![endif]=
--><div class=3D"column-per-63 outlook-group-fix" style=3D"font-size: 13px;=
 text-align: left; direction: ltr; display: inline-block; vertical-align: t=
op; width: 100%;overflow: hidden; word-wrap: break-word;"><table border=3D"=
0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%"=
 class=3D"main-column-table-ltr" style=3D"padding-right: 32px; padding-left=
: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main-column-td" style=3D=
"padding:0; vertical-align:top;"><table border=3D"0" cellpadding=3D"0" cell=
spacing=3D"0" role=3D"presentation" width=3D"100%" style=3D"table-layout: f=
ixed;"><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-br=
eak: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, s=
ans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-heigh=
t: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" clas=
s=3D"primary-text" role=3D"presentation"><span>If you need call details, pl=
ease contact me: <a href=3D"mailto:quintela@redhat.com" target=3D"_blank">a=
lex.bennee@linaro.org</a></span><meta itemprop=3D"description" content=3D"I=
f you need call details, please contact me: alex.bennee@linaro.org"/></div>=
</td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word=
-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto=
, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-he=
ight: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" c=
lass=3D"primary-text" role=3D"presentation"><span aria-hidden=3D"true"><tim=
e itemprop=3D"startDate" datetime=3D"20240709T130000Z"></time><time itempro=
p=3D"endDate" datetime=3D"20240709T140000Z"></time></span><table border=3D"=
0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"paddi=
ng-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14p=
x;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoot=
hing: antialiased;margin: 0; padding: 0;">When</h2></td></tr></table><span>=
Every 2 weeks from 14:00 to 15:00 on Tuesday (United Kingdom Time)</span></=
div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; =
word-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Ro=
boto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; lin=
e-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none=
;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpad=
ding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom:=
 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #=
3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: anti=
aliased;margin: 0; padding: 0;">Location</h2></td></tr></table><span itempr=
op=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span itempr=
op=3D"name" class=3D"primary-text notranslate" style=3D"font-family: Roboto=
, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-he=
ight: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;">h=
ttps://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.google.=
com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=
=3D1720882740000000&amp;usg=3DAOvVaw0jxuIwpSJwEG1-VdNtMtCK" class=3D"accent=
-text underline-on-hover" style=3D"display: inline-block;;color: #1a73e8; t=
ext-decoration: none;font-weight: 700;" target=3D"_blank" itemprop=3D"map">=
View map</a></span></div></td></tr><tr><td style=3D"font-size: 0; padding: =
0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div sty=
le=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400;=
 font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; =
text-decoration: none;" class=3D"primary-text" role=3D"presentation"><table=
 border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" sty=
le=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"fon=
t-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit=
-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2></td></tr><=
/table><div style=3D"padding-bottom: 4px; text-align: left;;color: #3c4042;=
"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:ale@rev.ng">Alessandro Di Federico</a><=
/span><meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:alex.bennee@linaro.org">Alex Benn=
=C3=A9e</a></span><meta itemprop=3D"email" content=3D"alex.bennee@linaro.or=
g"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:alistair.fra=
ncis@wdc.com">Alistair Francis</a></span><meta itemprop=3D"email" content=
=3D"alistair.francis@wdc.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a></span><meta itempr=
op=3D"email" content=3D"armbru@redhat.com"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:bcain@quicinc.com">bcain@quicinc.com</a></span>=
<meta itemprop=3D"email" content=3D"bcain@quicinc.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:berrange@redhat.com">berrange@redh=
at.com</a></span><meta itemprop=3D"email" content=3D"berrange@redhat.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:cjia@nvidia.com"=
>cjia@nvidia.com</a></span><meta itemprop=3D"email" content=3D"cjia@nvidia.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:clg@kaod.o=
rg">C=C3=A9dric Le Goater</a></span><meta itemprop=3D"email" content=3D"clg=
@kaod.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f=
00f.org">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.=
org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@red=
hat.com">eblake@redhat.com</a></span><meta itemprop=3D"email" content=3D"eb=
lake@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</a></span><meta itempr=
op=3D"email" content=3D"edgar.iglesias@gmail.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:eduardo@habkost.net">eduardo@habkost.net=
</a></span><meta itemprop=3D"email" content=3D"eduardo@habkost.net"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:felipe@nutanix.com">fe=
lipe@nutanix.com</a></span><meta itemprop=3D"email" content=3D"felipe@nutan=
ix.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
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
o:imp@bsdimp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=
=3D"imp@bsdimp.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:jgg@nvidia.com">jgg@nvidia.com</a></span><meta itemprop=3D"email" co=
ntent=3D"jgg@nvidia.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com</a></span><meta ite=
mprop=3D"email" content=3D"jidong.xiao@gmail.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:jim.shu@sifive.com">jim.shu@sifive.com</=
a></span><meta itemprop=3D"email" content=3D"jim.shu@sifive.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:konrad.wilk@oracle.com">k=
onrad.wilk@oracle.com</a></span><meta itemprop=3D"email" content=3D"konrad.=
wilk@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</a></span><meta itempr=
op=3D"email" content=3D"mburton@qti.qualcomm.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:mdean@redhat.com">mdean@redhat.com</a></=
span><meta itemprop=3D"email" content=3D"mdean@redhat.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:paul.walmsley@sifive.com">paul.=
walmsley@sifive.com</a></span><meta itemprop=3D"email" content=3D"paul.walm=
sley@sifive.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:pbonzini@redhat.com">pbonzini@redhat.com</a></span><meta itemprop=3D"emai=
l" content=3D"pbonzini@redhat.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:peter.maydell@linaro.org">Peter Maydell</a></span><meta=
 itemprop=3D"email" content=3D"peter.maydell@linaro.org"/></span><span clas=
s=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></spa=
n></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schem=
a.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pri=
mary-text underline-on-hover" style=3D"display: inline-block;;color: #3c404=
3; text-decoration: none;" href=3D"mailto:richard.henderson@linaro.org">Ric=
hard Henderson</a></span><meta itemprop=3D"email" content=3D"richard.hender=
son@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:shentey@gmail.com">shentey@gmail.com</a></span><meta itemprop=3D"email" co=
ntent=3D"shentey@gmail.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a></span><meta itemp=
rop=3D"email" content=3D"stefanha@gmail.com"/></span><span class=3D"seconda=
ry-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div=
><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person=
"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text un=
derline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-deco=
ration: none;" href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a=
></span><meta itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:zwu.kernel@gmail.com">zw=
u.kernel@gmail.com</a></span><meta itemprop=3D"email" content=3D"zwu.kernel=
@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a;=
 text-decoration: none;"></span></div><div><span itemprop=3D"attendee" item=
scope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:p=
hilmd@linaro.org">Phil Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email=
" content=3D"philmd@linaro.org"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:eblot@rivosinc.com">eblot@rivosinc.com</a></span><meta ite=
mprop=3D"email" content=3D"eblot@rivosinc.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:max.chou@sifive.com">max.chou@sifive.com</a=
></span><meta itemprop=3D"email" content=3D"max.chou@sifive.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:manos.pitsidianakis@linar=
o.org">Manos Pitsidianakis</a></span><meta itemprop=3D"email" content=3D"ma=
nos.pitsidianakis@linaro.org"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:afaerber@suse.de">afaerber@suse.de</a></span><meta itemprop=
=3D"email" content=3D"afaerber@suse.de"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:anjo@rev.ng">Anton Johansson</a></span><meta itemp=
rop=3D"email" content=3D"anjo@rev.ng"/></span><span class=3D"secondary-text=
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
 #3c4043; text-decoration: none;" href=3D"mailto:dhedde@kalrayinc.com">Dami=
en Hedde</a></span><meta itemprop=3D"email" content=3D"dhedde@kalrayinc.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:elena.ufimtse=
va@oracle.com">Elena Ufimtseva</a></span><meta itemprop=3D"email" content=
=3D"elena.ufimtseva@oracle.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a></span><me=
ta itemprop=3D"email" content=3D"eric.auger@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.=
de</a></span><meta itemprop=3D"email" content=3D"jan.kiszka@web.de"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:jjherne@linux.vnet.ibm=
.com">jjherne@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" content=
=3D"jjherne@linux.vnet.ibm.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:joao.m.martins@oracle.com">Joao Martins</a></span><meta it=
emprop=3D"email" content=3D"joao.m.martins@oracle.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:luc@lmichel.fr">Luc Michel</a></sp=
an><meta itemprop=3D"email" content=3D"luc@lmichel.fr"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linu=
x.vnet.ibm.com</a></span><meta itemprop=3D"email" content=3D"mimu@linux.vne=
t.ibm.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:sham=
eerali.kolothum.thodi@huawei.com">Shameerali Kolothum Thodi</a></span><meta=
 itemprop=3D"email" content=3D"shameerali.kolothum.thodi@huawei.com"/></spa=
n><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: =
none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"=
http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;c=
olor: #3c4043; text-decoration: none;" href=3D"mailto:z.huo@139.com">z.huo@=
139.com</a></span><meta itemprop=3D"email" content=3D"z.huo@139.com"/></spa=
n><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: =
none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"=
http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;c=
olor: #3c4043; text-decoration: none;" href=3D"mailto:zhiwei_liu@linux.alib=
aba.com">LIU Zhiwei</a></span><meta itemprop=3D"email" content=3D"zhiwei_li=
u@linux.alibaba.com"/></span><span class=3D"secondary-text" style=3D"color:=
 #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atten=
dee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name=
" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a></span><meta itempro=
p=3D"email" content=3D"qemu-devel@nongnu.org"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div></d=
iv><a href=3D"https://calendar.google.com/calendar/event?action=3DVIEW&amp;=
eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwNzA5VDEzMDAwMCBxZW11LWRld=
mVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm=
91cC5jYWxlbmRhci5nb29nbGUuY29tOGMyMmNlZGYwNTBhNTAxZmYwZmJhY2ZkOGQxNTI0ZTk5N=
mYzYTczOA&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"displa=
y: inline-block;;color: #1a73e8; text-decoration: none;font-weight: 700;" t=
arget=3D"_blank" class=3D"accent-text underline-on-hover">View all guest in=
fo</a></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align=
: left; word-break: break-word;;padding-bottom:0px;"><div style=3D"color: #=
3c4043; text-decoration: none;;font-family: Roboto, sans-serif;font-size: 1=
4px; line-height: 20px; mso-line-height-rule: exactly; text-align: left;" c=
lass=3D"primary-text"><div><span style=3D"font-weight: 700;-webkit-font-smo=
othing: antialiased;">RSVP</span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"> for <a class=3D"secondary-text under=
line-on-hover" style=3D"display: inline-block;;color: #70757a; text-decorat=
ion: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>=
 for all events in this series</span></div></div></td></tr><tr><td style=3D=
"font-size: 0; padding: 0; text-align: left; word-break: break-word;;paddin=
g-bottom:16px;"><div style=3D"font-family: Roboto, sans-serif;font-size: 14=
px; line-height: 20px; mso-line-height-rule: exactly; text-align: left;"><t=
able border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"=
 style=3D"border-collapse: separate;"><tr><td style=3D"padding-top: 8px; pa=
dding-left: 0; padding-right: 12px;"><!-- RSVP buttons --><table border=3D"=
0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"borde=
r: solid 1px #dadce0; border-radius: 16px; border-collapse: separate;font-f=
amily: &#39;Google Sans&#39;, Roboto, sans-serif;;display: inline-block;;ma=
rgin-right: 12px; margin-left: 0;"><tr><td align=3D"center" vertical-align=
=3D"middle" role=3D"presentation"><span itemprop=3D"potentialaction" itemsc=
ope itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"attendance"=
 content=3D"http://schema.org/RsvpAttendance/Yes"/><span itemprop=3D"handle=
r" itemscope itemtype=3D"http://schema.org/HttpActionHandler"><link itempro=
p=3D"method" href=3D"http://schema.org/HttpRequestMethod/GET"/><span style=
=3D"color: #5f6367;"><a href=3D"https://calendar.google.com/calendar/event?=
action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwNzA5=
VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&amp;tok=3DNTQjY19rNXAyb=
HBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tOGMyMmNlZGYw=
NTBhNTAxZmYwZmJhY2ZkOGQxNTI0ZTk5NmYzYTczOA&amp;ctz=3DEurope%2FLondon&amp;hl=
=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#39;Google Sans&#=
39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%;=
 mso-line-height-rule: exactly; margin: 0; text-decoration: none; text-tran=
sform: none;" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"=
><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentati=
on"><tr><td align=3D"center" role=3D"presentation" valign=3D"middle" style=
=3D"padding: 6px 0; padding-left: 16px; padding-right: 12px; white-space: n=
owrap;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/event?=
action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwNzA5=
VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&amp;tok=3DNTQjY19rNXAyb=
HBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tOGMyMmNlZGYw=
NTBhNTAxZmYwZmJhY2ZkOGQxNTI0ZTk5NmYzYTczOA&amp;ctz=3DEurope%2FLondon&amp;hl=
=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" target=3D"_bl=
ank"><![endif]--><span class=3D"grey-button-text" style=3D"font-weight: 400=
;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; fon=
t-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; =
text-decoration: none; text-transform: none;">Yes</span><!--[if mso]></a><!=
[endif]--></td></tr></table></a></span></span></span></td><td align=3D"cent=
er" vertical-align=3D"middle" role=3D"presentation" style=3D"border-left: s=
olid 1px #dadce0; border-right: solid 1px #dadce0;"><span itemprop=3D"poten=
tialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta itemp=
rop=3D"attendance" content=3D"http://schema.org/RsvpAttendance/No"/><span i=
temprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHandl=
er"><link itemprop=3D"method" href=3D"http://schema.org/HttpRequestMethod/G=
ET"/><span style=3D"color: #5f6367;"><a href=3D"https://calendar.google.com=
/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5s=
NWlfUjIwMjQwNzA5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D2&amp;tok=
=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUu=
Y29tOGMyMmNlZGYwNTBhNTAxZmYwZmJhY2ZkOGQxNTI0ZTk5NmYzYTczOA&amp;ctz=3DEurope=
%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#=
39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; li=
ne-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration:=
 none; text-transform: none;" class=3D"grey-button-text" itemprop=3D"url" t=
arget=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" ro=
le=3D"presentation"><tr><td align=3D"center" role=3D"presentation" valign=
=3D"middle" style=3D"padding: 6px 12px; white-space: nowrap;"><!--[if mso]>=
<a href=3D"https://calendar.google.com/calendar/event?action=3DRESPOND&amp;=
eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwNzA5VDEzMDAwMCBxZW11LWRld=
mVsQG5vbmdudS5vcmc&amp;rst=3D2&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMD=
FibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tOGMyMmNlZGYwNTBhNTAxZmYwZmJhY2ZkO=
GQxNTI0ZTk5NmYzYTczOA&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" cla=
ss=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><![endif]--><spa=
n class=3D"grey-button-text" style=3D"font-weight: 400;font-family: &#39;Go=
ogle Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-he=
ight: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none=
; text-transform: none;">No</span><!--[if mso]></a><![endif]--></td></tr></=
table></a></span></span></span></td><td align=3D"center" vertical-align=3D"=
middle" role=3D"presentation"><span itemprop=3D"potentialaction" itemscope =
itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"attendance" con=
tent=3D"http://schema.org/RsvpAttendance/Maybe"/><span itemprop=3D"handler"=
 itemscope itemtype=3D"http://schema.org/HttpActionHandler"><link itemprop=
=3D"method" href=3D"http://schema.org/HttpRequestMethod/GET"/><span style=
=3D"color: #5f6367;"><a href=3D"https://calendar.google.com/calendar/event?=
action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwNzA5=
VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D3&amp;tok=3DNTQjY19rNXAyb=
HBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tOGMyMmNlZGYw=
NTBhNTAxZmYwZmJhY2ZkOGQxNTI0ZTk5NmYzYTczOA&amp;ctz=3DEurope%2FLondon&amp;hl=
=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#39;Google Sans&#=
39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%;=
 mso-line-height-rule: exactly; margin: 0; text-decoration: none; text-tran=
sform: none;" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"=
><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentati=
on"><tr><td align=3D"center" role=3D"presentation" valign=3D"middle" style=
=3D"padding: 6px 0; padding-left: 12px; padding-right: 16px; white-space: n=
owrap;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/event?=
action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwNzA5=
VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D3&amp;tok=3DNTQjY19rNXAyb=
HBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tOGMyMmNlZGYw=
NTBhNTAxZmYwZmJhY2ZkOGQxNTI0ZTk5NmYzYTczOA&amp;ctz=3DEurope%2FLondon&amp;hl=
=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" target=3D"_bl=
ank"><![endif]--><span class=3D"grey-button-text" style=3D"font-weight: 400=
;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; fon=
t-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; =
text-decoration: none; text-transform: none;">Maybe</span><!--[if mso]></a>=
<![endif]--></td></tr></table></a></span></span></span></td></tr></table><!=
-- More options --><a href=3D"https://calendar.google.com/calendar/event?ac=
tion=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwNzA5VDEzM=
DAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NX=
NpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tOGMyMmNlZGYwNTBhNTAxZmYwZmJhY=
2ZkOGQxNTI0ZTk5NmYzYTczOA&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0"=
 style=3D"display: inline-block;;font-weight: 400;font-family: &#39;Google =
Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height:=
 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; tex=
t-transform: none;" class=3D"grey-button-text" target=3D"_blank"><table bor=
der=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=
=3D"border: solid 1px #dadce0; border-radius: 16px; border-collapse: separa=
te;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;"><tr><td align=
=3D"center" vertical-align=3D"middle" role=3D"presentation" style=3D"paddin=
g: 6px 0; padding-left: 16px; padding-right: 12px; white-space: nowrap;;col=
or: #5f6367;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/=
event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwN=
zA5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBndmJwdG=
Rpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tOGMyMmNlZGYwNTBhNTAxZ=
mYwZmJhY2ZkOGQxNTI0ZTk5NmYzYTczOA&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp=
;es=3D0" class=3D"grey-button-text" target=3D"_blank"><![endif]--><span cla=
ss=3D"grey-button-text" style=3D"font-weight: 400;font-family: &#39;Google =
Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height:=
 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; tex=
t-transform: none;">More options</span><!--[if mso]></a><![endif]--></td></=
tr></table></a></td></tr></table></div></td></tr></table></td></tr></tbody>=
</table></div><!--[if mso | IE]></td><![endif]--><!--[if mso | IE]></tr></t=
able><![endif]--></td></tr></tbody></table><table border=3D"0" cellpadding=
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
--000000000000cf679d061cbda94b
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: quoted-printable

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
RRULE:FREQ=3DYEARLY;BYMONTH=3D3;BYDAY=3D2SU
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:-0400
TZOFFSETTO:-0500
TZNAME:EST
DTSTART:19701101T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D11;BYDAY=3D1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTSTART;TZID=3DAmerica/New_York:20240709T090000
DTEND;TZID=3DAmerica/New_York:20240709T100000
RRULE:FREQ=3DWEEKLY;WKST=3DMO;INTERVAL=3D2;BYDAY=3DTU
DTSTAMP:20240708T145943Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i_R20240709T130000@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAlessandro Di Federico;X-NUM-GUESTS=3D0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:alex.bennee@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAlistair Francis;X-NUM-GUESTS=3D0:mailto:alistair.francis@wdc.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Darmbru@redhat.com;X-NUM-GUESTS=3D0:mailto:armbru@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dbcain@quicinc.com;X-NUM-GUESTS=3D0:mailto:bcain@quicinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dberrange@redhat.com;X-NUM-GUESTS=3D0:mailto:berrange@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dcjia@nvidia.com;X-NUM-GUESTS=3D0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:clg@kaod.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dcw@f00f.org;X-NUM-GUESTS=3D0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Deblake@redhat.com;X-NUM-GUESTS=3D0:mailto:eblake@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dedgar.iglesias@gmail.com;X-NUM-GUESTS=3D0:mailto:edgar.iglesias@=
gmail
 .com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Deduardo@habkost.net;X-NUM-GUESTS=3D0:mailto:eduardo@habkost.net
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dfelipe@nutanix.com;X-NUM-GUESTS=3D0:mailto:felipe@nutanix.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Diggy@theiggy.com;X-NUM-GUESTS=3D0:mailto:iggy@theiggy.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dimp@bsdimp.com;X-NUM-GUESTS=3D0:mailto:imp@bsdimp.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Djgg@nvidia.com;X-NUM-GUESTS=3D0:mailto:jgg@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Djidong.xiao@gmail.com;X-NUM-GUESTS=3D0:mailto:jidong.xiao@gmail.=
com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Djim.shu@sifive.com;X-NUM-GUESTS=3D0:mailto:jim.shu@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dkonrad.wilk@oracle.com;X-NUM-GUESTS=3D0:mailto:konrad.wilk@oracl=
e.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmburton@qti.qualcomm.com;X-NUM-GUESTS=3D0:mailto:mburton@qti.qua=
lcomm
 .com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3Dmdean@redhat.com;X-NUM-GUESTS=3D0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Dpaul.walmsley@sifive.com;X-NUM-GUESTS=3D0:mailto:paul.walmsley@sifi=
ve.co
 m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dpbonzini@redhat.com;X-NUM-GUESTS=3D0:mailto:pbonzini@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DPeter Maydell;X-NUM-GUESTS=3D0:mailto:peter.maydell@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DRichard Henderson;X-NUM-GUESTS=3D0:mailto:richard.henderson@lina=
ro.or
 g
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Dshentey@gmail.com;X-NUM-GUESTS=3D0:mailto:shentey@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Dstefanha@gmail.com;X-NUM-GUESTS=3D0:mailto:stefanha@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dwei.w.wang@intel.com;X-NUM-GUESTS=3D0:mailto:wei.w.wang@intel.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dzwu.kernel@gmail.com;X-NUM-GUESTS=3D0:mailto:zwu.kernel@gmail.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:philmd@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Deblot@rivosinc.com;X-NUM-GUESTS=3D0:mailto:eblot@rivosinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmax.chou@sifive.com;X-NUM-GUESTS=3D0:mailto:max.chou@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DManos Pitsidianakis;X-NUM-GUESTS=3D0:mailto:manos.pitsidianakis@=
linar
 o.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dafaerber@suse.de;X-NUM-GUESTS=3D0:mailto:afaerber@suse.de
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAnton Johansson;X-NUM-GUESTS=3D0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DChao Peng;X-NUM-GUESTS=3D0:mailto:chao.p.peng@linux.intel.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3DDamien Hedde;X-NUM-GUESTS=3D0:mailto:dhedde@kalrayinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DElena Ufimtseva;X-NUM-GUESTS=3D0:mailto:elena.ufimtseva@oracle.c=
om
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Deric.auger@redhat.com;X-NUM-GUESTS=3D0:mailto:eric.auger@redhat.=
com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Djan.kiszka@web.de;X-NUM-GUESTS=3D0:mailto:jan.kiszka@web.de
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Djjherne@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:jjherne@linux=
.vnet
 .ibm.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DJoao Martins;X-NUM-GUESTS=3D0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DLuc Michel;X-NUM-GUESTS=3D0:mailto:luc@lmichel.fr
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmimu@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:mimu@linux.vnet.=
ibm.c
 om
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DShameerali Kolothum Thodi;X-NUM-GUESTS=3D0:mailto:shameerali.kol=
othum
 .thodi@huawei.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dz.huo@139.com;X-NUM-GUESTS=3D0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DLIU Zhiwei;X-NUM-GUESTS=3D0:mailto:zhiwei_liu@linux.alibaba.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Dqemu-devel@nongnu.org;X-NUM-GUESTS=3D0:mailto:qemu-devel@nongnu.org
X-MICROSOFT-CDO-OWNERAPPTID:-1740392407
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20240708T145931Z
LOCATION:https://meet.jit.si/kvmcallmeeting
SEQUENCE:0
STATUS:CONFIRMED
SUMMARY:QEMU/KVM developers conference call
TRANSP:OPAQUE
ATTACH;FILENAME=3DNotes =E2=80=93 QEMU/KVM developers conference call;FMTTY=
PE=3Dapplica
 tion/vnd.google-apps.document:https://docs.google.com/document/d/1-Ltq11LL=
z
 xCccfqfNNKcMG74HMUJf6DURmSJBGQZrek/edit
BEGIN:VALARM
ACTION:EMAIL
DESCRIPTION:This is an event reminder
SUMMARY:Alarm notification
ATTENDEE:mailto:qemu-devel@nongnu.org
TRIGGER:-P2D
END:VALARM
END:VEVENT
END:VCALENDAR

--000000000000cf679d061cbda94b--

--000000000000cf679d061cbda94d
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
UlQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjQwNzA5VDA5MDAwMA0KRFRFTkQ7VFpJRD1BbWVy
aWNhL05ld19Zb3JrOjIwMjQwNzA5VDEwMDAwMA0KUlJVTEU6RlJFUT1XRUVLTFk7V0tTVD1NTztJ
TlRFUlZBTD0yO0JZREFZPVRVDQpEVFNUQU1QOjIwMjQwNzA4VDE0NTk0M1oNCk9SR0FOSVpFUjtD
Tj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJrdTVzaTAxYmxt
bmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjFndnViOTQzNW83aHJyZW0wYTBy
YWxubDVpX1IyMDI0MDcwOVQxMzAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1BbGVzc2FuZHJvIERpIEZlZGVyaWNvO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbGVA
cmV2Lm5nDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0wOm1haWx0bzph
bGV4LmJlbm5lZUBsaW5hcm8ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUFsaXN0
YWlyIEZyYW5jaXM7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFsaXN0YWlyLmZyYW5jaXNAd2RjLmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1hcm1icnVAcmVkaGF0LmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86YXJtYnJ1QHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049YmNhaW5AcXVpY2luYy5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmJjYWluQHF1aWNp
bmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWJlcnJhbmdlQHJlZGhhdC5jb207
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtS
U1ZQPQ0KIFRSVUU7Q049Y2ppYUBudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjamlh
QG52aWRpYS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOmNsZ0BrYW9kLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jd0BmMDBmLm9y
ZztYLU5VTS1HVUVTVFM9MDptYWlsdG86Y3dAZjAwZi5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049ZWJsYWtlQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVibGFrZUBy
ZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWVkZ2FyLmlnbGVzaWFzQGdt
YWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWRnYXIuaWdsZXNpYXNAZ21haWwNCiAuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1URU5UQVRJVkU7UlNWUD1UUlUNCiBFO0NOPWVkdWFyZG9AaGFia29zdC5uZXQ7WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmVkdWFyZG9AaGFia29zdC5uZXQNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049ZmVsaXBlQG51dGFuaXguY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpmZWxpcGVAbnV0
YW5peC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049aWdneUB0aGVpZ2d5LmNvbTtY
LU5VTS1HVUVTVFM9MDptYWlsdG86aWdneUB0aGVpZ2d5LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1pbXBAYnNkaW1wLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86aW1wQGJzZGlt
cC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amdnQG52aWRpYS5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmpnZ0BudmlkaWEuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPWppZG9uZy54aWFvQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amlkb25nLnhp
YW9AZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWppbS5zaHVAc2lmaXZl
LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amltLnNodUBzaWZpdmUuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPWtvbnJhZC53aWxrQG9yYWNsZS5jb207WC1OVU0tR1VFU1RTPTA6
bWFpbHRvOmtvbnJhZC53aWxrQG9yYWNsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049bWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYnVydG9u
QHF0aS5xdWFsY29tbQ0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFDQ0VQVEVEO1JTVlA9VFJVRQ0KIDtDTj1tZGVhbkByZWRo
YXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptZGVhbkByZWRoYXQuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1URU5UQVRJVkU7
UlNWUD1UUlUNCiBFO0NOPXBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86cGF1bC53YWxtc2xleUBzaWZpdmUuY28NCiBtDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPXBib256aW5pQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBib256aW5p
QHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049UGV0ZXIgTWF5ZGVsbDtY
LU5VTS1HVUVTVFM9MDptYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPVJpY2hhcmQgSGVuZGVyc29uO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3INCiBnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1URU5UQVRJVkU7UlNWUD1UUlUNCiBF
O0NOPXNoZW50ZXlAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzaGVudGV5QGdtYWls
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9VEVOVEFUSVZFO1JTVlA9VFJVDQogRTtDTj1zdGVmYW5oYUBnbWFpbC5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOnN0ZWZhbmhhQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj13ZWkudy53YW5nQGludGVsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86d2VpLncu
d2FuZ0BpbnRlbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049end1Lmtlcm5lbEBn
bWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnp3dS5rZXJuZWxAZ21haWwuY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwaGlsbWRAbGluYXJv
Lm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9VEVOVEFUSVZFO1JTVlA9VFJVDQogRTtDTj1lYmxvdEByaXZvc2luYy5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmVibG90QHJpdm9zaW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1tYXguY2hvdUBzaWZpdmUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYXguY2hv
dUBzaWZpdmUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPU1hbm9zIFBpdHNpZGlh
bmFraXM7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1hbm9zLnBpdHNpZGlhbmFraXNAbGluYXINCiBv
Lm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1hZmFlcmJlckBzdXNlLmRlO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzphZmFlcmJlckBzdXNlLmRlDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPUFudG9uIEpvaGFuc3NvbjtYLU5VTS1HVUVTVFM9MDptYWlsdG86YW5qb0ByZXYubmcN
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Q2hhbyBQZW5nO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpjaGFvLnAucGVuZ0BsaW51eC5pbnRlbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFDQ0VQVEVEO1JTVlA9VFJVRQ0KIDtD
Tj1EYW1pZW4gSGVkZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmRoZWRkZUBrYWxyYXlpbmMuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUVsZW5hIFVmaW10c2V2YTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049ZXJpYy5hdWdlckByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpl
cmljLmF1Z2VyQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amFuLmtp
c3prYUB3ZWIuZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmphbi5raXN6a2FAd2ViLmRlDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWpqaGVybmVAbGludXgudm5ldC5pYm0uY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzpqamhlcm5lQGxpbnV4LnZuZXQNCiAuaWJtLmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1Kb2FvIE1hcnRpbnM7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpv
YW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049THVj
IE1pY2hlbDtYLU5VTS1HVUVTVFM9MDptYWlsdG86bHVjQGxtaWNoZWwuZnINCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049bWltdUBsaW51eC52bmV0LmlibS5jb207WC1OVU0tR1VFU1RTPTA6
bWFpbHRvOm1pbXVAbGludXgudm5ldC5pYm0uYw0KIG9tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPVNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGk7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnNo
YW1lZXJhbGkua29sb3RodW0NCiAudGhvZGlAaHVhd2VpLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj16Lmh1b0AxMzkuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6Lmh1b0AxMzku
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUxJVSBaaGl3ZWk7WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOnpoaXdlaV9saXVAbGludXguYWxpYmFiYS5jb20NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRS
VQ0KIEU7Q049cWVtdS1kZXZlbEBub25nbnUub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpxZW11
LWRldmVsQG5vbmdudS5vcmcNClgtTUlDUk9TT0ZULUNETy1PV05FUkFQUFRJRDotMTc0MDM5MjQw
Nw0KQ1JFQVRFRDoyMDIzMDIyMVQxNTM5NTBaDQpERVNDUklQVElPTjpJZiB5b3UgbmVlZCBjYWxs
IGRldGFpbHNcLCBwbGVhc2UgY29udGFjdCBtZTogPGEgaHJlZj0ibWFpbHRvOnENCiB1aW50ZWxh
QHJlZGhhdC5jb20iPmFsZXguYmVubmVlQGxpbmFyby5vcmc8L2E+DQpMQVNULU1PRElGSUVEOjIw
MjQwNzA4VDE0NTkzMVoNCkxPQ0FUSU9OOmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRp
bmcNClNFUVVFTkNFOjANClNUQVRVUzpDT05GSVJNRUQNClNVTU1BUlk6UUVNVS9LVk0gZGV2ZWxv
cGVycyBjb25mZXJlbmNlIGNhbGwNClRSQU5TUDpPUEFRVUUNCkFUVEFDSDtGSUxFTkFNRT1Ob3Rl
cyDigJMgUUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGw7Rk1UVFlQRT1hcHBsaWNh
DQogdGlvbi92bmQuZ29vZ2xlLWFwcHMuZG9jdW1lbnQ6aHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20v
ZG9jdW1lbnQvZC8xLUx0cTExTEx6DQogeENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNKQkdRWnJl
ay9lZGl0DQpCRUdJTjpWQUxBUk0NCkFDVElPTjpFTUFJTA0KREVTQ1JJUFRJT046VGhpcyBpcyBh
biBldmVudCByZW1pbmRlcg0KU1VNTUFSWTpBbGFybSBub3RpZmljYXRpb24NCkFUVEVOREVFOm1h
aWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmcNClRSSUdHRVI6LVAyRA0KRU5EOlZBTEFSTQ0KRU5E
OlZFVkVOVA0KRU5EOlZDQUxFTkRBUg0K
--000000000000cf679d061cbda94d--

