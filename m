Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485C829CB8
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 15:39:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNZia-0000vv-RP; Wed, 10 Jan 2024 09:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogdan.kostiv@gmail.com>)
 id 1rNTIj-0003ss-10
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:47:01 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogdan.kostiv@gmail.com>)
 id 1rNTIf-0004xM-FP
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:47:00 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28d2be70358so2037684a91.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 23:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704872815; x=1705477615; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dGwYISQT4vMPjKCRHJOZJRZB/VO+15If2FooiItWERo=;
 b=MmaXWIpMohswiA+1teJNIsWscqMEVbqQaj0vXhQOKngch1rI41ZT3Qz/fFm06AZZQu
 uuMOz7QXE4K07x83YjRHvtI44VYxsgAWyoU+xWb3Ej6FdL6B9XKzJulk/NbUt6DcKA0J
 41xcHVEwBnxFYvRuGg/SrMUOuGSFKQgIV0ahDFs+4GHmgyrYioLIgq04SUlz1LWcs9eE
 V59rpGqNqmbb62u/ODguwTXrj+Xste8W4gb1oPZf5Znl+YCI1A8ghwNIVrojhkdJgUms
 mFRrMkkWfcUCkB21Hjt5PDgAibZUEz5G5gBwFA77jja1dFkqGbmIgLR2aH3TTGarFsK1
 Tp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704872815; x=1705477615;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dGwYISQT4vMPjKCRHJOZJRZB/VO+15If2FooiItWERo=;
 b=tpFHca4s6vrRnjLIcCC5W1lTgEy8e4f73DvovAHVx6Yw02CzBUsKCyQ5cX4zVbv5ia
 XBvHfYQyOPvR9LcBXEgwrr4F+LHgnXIli0fBJNWzLjqIOgsOA+TAvpoiySU5p0biNyLe
 TGDJzh0RIKBX3RxvUWygRrH+59Bs87tbXp3CqkW6eW26af65rktpxj1OBjdJpT5olkzh
 OH3GfMEqsfJUdLk0NpykmQB0sQ/kK6vp/jvYnIwwM/whAKUVBIt+ey4px+kgNIQ9D2YP
 9ypS5wzyDRmfe6tIYZheFzy4uDm/PuaiUpwdPkvvxaRGTzxRfdPsCIg3Y/um8TxagJ7O
 9HNw==
X-Gm-Message-State: AOJu0YxgtNt5Q29+KYZbQQs4OZRdhl8YhNVATGDSwLMGs9Tr1wgNFJr9
 pAh0xi+AvNuKfMDns6+Lsnhp42lUjme7nZ+SgDZQ/Z2G6he/YQ==
X-Google-Smtp-Source: AGHT+IGi6Nsf4rfxJqFZ3kK/JtavXpPC/qn5vtq6IvhVSZSjYsfZ6u0kYlGjUW4wQHG06Cg20INmbnMnJjM8hi1Qq/4=
X-Received: by 2002:a17:90b:1e0f:b0:28c:a872:e25b with SMTP id
 pg15-20020a17090b1e0f00b0028ca872e25bmr302553pjb.86.1704872814731; Tue, 09
 Jan 2024 23:46:54 -0800 (PST)
MIME-Version: 1.0
From: Bohdan Kostiv <bogdan.kostiv@gmail.com>
Date: Wed, 10 Jan 2024 11:46:42 +0400
Message-ID: <CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com>
Subject: [PATCH] Fixed '-serial none' usage breaks following '-serial ...'
 usage
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000827a72060e92a2b1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=bogdan.kostiv@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 10 Jan 2024 09:37:58 -0500
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--000000000000827a72060e92a2b1
Content-Type: multipart/alternative; boundary="000000000000827a70060e92a2af"

--000000000000827a70060e92a2af
Content-Type: text/plain; charset="UTF-8"

Hello,

I have faced an issue in using serial ports when I need to skip a couple of
ports in the CLI.

For example the ARM machine netduinoplus2 supports up to 7 UARTS.
Following case works (the first UART is used to send data in the firmware):
qemu-system-arm -machine netduinoplus2 -nographic -serial mon:stdio -kernel
path-to-fw/firmware.elf
But this one doesn't  (the third UART is used to send data in the firmware):
qemu-system-arm -machine netduinoplus2 -nographic -serial none -serial none
-serial mon:stdio -kernel path-to-fw/firmware.elf

The patch fixes the issue.

Best regards,
Bohdan

--000000000000827a70060e92a2af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Hel=
lo,</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><=
div class=3D"gmail_default" style=3D"font-size:small">I have faced an issue=
 in using serial ports when I need to skip a couple of ports in the CLI.</d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">For example the ARM machine=
=C2=A0netduinoplus2 supports up to 7 UARTS.=C2=A0</div><div class=3D"gmail_=
default" style=3D"font-size:small">Following case works (the first UART is =
used to send data in the firmware):</div><div class=3D"gmail_default" style=
=3D"font-size:small">qemu-system-arm -machine netduinoplus2=C2=A0-nographic=
 -serial mon:stdio -kernel path-to-fw/firmware.elf<br></div><div class=3D"g=
mail_default" style=3D"font-size:small">But this one doesn&#39;t=C2=A0<span=
 class=3D"gmail-Apple-converted-space">=C2=A0</span>(the third UART is used=
 to send data<span class=3D"gmail-Apple-converted-space">=C2=A0</span>in th=
e firmware):</div><div class=3D"gmail_default" style=3D"font-size:small">qe=
mu-system-arm -machine netduinoplus2=C2=A0-nographic -serial none -serial n=
one -serial mon:stdio -kernel path-to-fw/firmware.elf</div><div class=3D"gm=
ail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">The patch=C2=A0fixes the issue.</div><div clas=
s=3D"gmail_default" style=3D"font-size:small"><br></div><div><div dir=3D"lt=
r" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr">Best regards,<br>Bohdan</div></div></div></div>

--000000000000827a70060e92a2af--

--000000000000827a72060e92a2b1
Content-Type: application/octet-stream; 
	name="0001-Fixed-serial-none-breaks-following-serial.patch"
Content-Disposition: attachment; 
	filename="0001-Fixed-serial-none-breaks-following-serial.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lr7gml7h0>
X-Attachment-Id: f_lr7gml7h0

RnJvbSBlZTgwMjNmM2Q0NjZjM2E1YWQ5Y2I5ZDExN2UxMTUwMWM0NGRhMzc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCb2hkYW4gS29zdGl2IDxib2dkYW4ua29zdGl2QGdtYWlsLmNv
bT4KRGF0ZTogV2VkLCAxMCBKYW4gMjAyNCAxMTowOToxMSArMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IEZpeGVkICctc2VyaWFsIG5vbmUnIHVzYWdlIGJyZWFrcyBmb2xsb3dpbmcgJy1zZXJpYWwgLi4u
JyB1c2FnZSAKClNpZ25lZC1vZmYtYnk6IEJvaGRhbiBLb3N0aXYgPGJvaGRhbi5rb3N0aXZAdGlp
LmFlPgotLS0KIHN5c3RlbS92bC5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3N5c3RlbS92bC5jIGIvc3lzdGVt
L3ZsLmMKaW5kZXggMmJjZDllZmI5YS4uYjg3NDQ0NzVjZCAxMDA2NDQKLS0tIGEvc3lzdGVtL3Zs
LmMKKysrIGIvc3lzdGVtL3ZsLmMKQEAgLTE0NDIsOCArMTQ0MiwxMSBAQCBzdGF0aWMgaW50IHNl
cmlhbF9wYXJzZShjb25zdCBjaGFyICpkZXZuYW1lKQogICAgIGludCBpbmRleCA9IG51bV9zZXJp
YWxfaGRzOwogICAgIGNoYXIgbGFiZWxbMzJdOwogCi0gICAgaWYgKHN0cmNtcChkZXZuYW1lLCAi
bm9uZSIpID09IDApCisgICAgaWYgKHN0cmNtcChkZXZuYW1lLCAibm9uZSIpID09IDApIHsKKyAg
ICAgICAgbnVtX3NlcmlhbF9oZHMrKzsKICAgICAgICAgcmV0dXJuIDA7CisgICAgfQorCiAgICAg
c25wcmludGYobGFiZWwsIHNpemVvZihsYWJlbCksICJzZXJpYWwlZCIsIGluZGV4KTsKICAgICBz
ZXJpYWxfaGRzID0gZ19yZW5ldyhDaGFyZGV2ICosIHNlcmlhbF9oZHMsIGluZGV4ICsgMSk7CiAK
LS0gCjIuMzkuMyAoQXBwbGUgR2l0LTE0NSkKCg==
--000000000000827a72060e92a2b1--

