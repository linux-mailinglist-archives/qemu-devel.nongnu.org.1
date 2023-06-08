Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD890728CC7
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 03:02:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7QW1-000127-Ax; Thu, 08 Jun 2023 21:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ld.adecy@gmail.com>)
 id 1q7Mnj-0004yQ-Ri; Thu, 08 Jun 2023 17:04:11 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ld.adecy@gmail.com>)
 id 1q7Mni-0003nI-DA; Thu, 08 Jun 2023 17:04:11 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-78775a5a84eso431369241.0; 
 Thu, 08 Jun 2023 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686258248; x=1688850248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u9RSWzSinL6wVwRoJnII3tuTXb95PnZ2XHBLF35XMfM=;
 b=SQ4dozRx3j7smFOHvrnxr2sjXBYrrbWC9NbsysW+JbTe3trSE4laa3B1yIqo5B11VJ
 HSgwUQqdjBkiy3DYhLvI06o7utWnz5OOp6Lz7AJxnGlcWkMGzCO5G6pyoNoHtTM+/4QK
 S4mEiduzp0DRkzOe0Yn70IMs4ssZczQT1vMGVR5JBqAZfOLekU0tE6Rc/XUkswj9zmiP
 FVzuyavzy4Cj8dfo78KWZrMPqpzTNH++4l/ZZArTvr5HCcsHEjGhHBO+MHTcIrnH8aRl
 Via8sWsqEmQDJOVuZgnkKci1uAz/vcDl2ruTeGy2qLkMKPvGuvSP3QisVjDkjY6d5oCp
 kBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686258248; x=1688850248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9RSWzSinL6wVwRoJnII3tuTXb95PnZ2XHBLF35XMfM=;
 b=Wr+uOCMpUyNzBqEIEu2gpVtsDmTz3lD2tzTg05F9nkWMOm3fP0yT1uma4DmvOmEshe
 SXqoeh1EjF2q8WBHkU5aXJNojwdDSBv0wLIPirQdfwvcHheHNQlK9Yn5zXq6NuVCnZ1k
 A/npM3g0MTGFnTtvB1Qx4AP1l86mV7AtVyhwgAF+XG5dVxGHtdIc4doh2m1+6dPn3p8K
 HVISre8bKJAM7cdtBoqT6Vn0nYmpmrv6p9+B9VY1VbBBlfft9tw8EPCEf048sK0+Y0HZ
 a7N1zPWpkIv6bcbBvs+Vk+oScMADDm4HGogW2B187iAR6LuW+ANgv42Z7ChUkKZyr6kG
 3NJA==
X-Gm-Message-State: AC+VfDwCZCq6Vu9h4qmg3NV7Xuq4Utb4QsXRw65WOINXibKvIOeCbv9h
 bRvl5HSdfCjqcIpp0q7moioaEkVXegNiLtA4KU55HHokamM=
X-Google-Smtp-Source: ACHHUZ64jV76ohGPBXOvW3y9RF6ttHtOkpHKNDzb/ZtuHeMYw5tytoXkZXcdTWvCLAo/6G5YWO/95IVy8NfsZJhnP/w=
X-Received: by 2002:a05:6102:7c6:b0:434:66e3:74b4 with SMTP id
 y6-20020a05610207c600b0043466e374b4mr2881337vsg.8.1686258247882; Thu, 08 Jun
 2023 14:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAB295yB5cFSZpGE74EW5hDMSNGnZfw06UC5ydepUL0sdT96WGg@mail.gmail.com>
In-Reply-To: <CAB295yB5cFSZpGE74EW5hDMSNGnZfw06UC5ydepUL0sdT96WGg@mail.gmail.com>
From: Adecy <ld.adecy@gmail.com>
Date: Thu, 8 Jun 2023 23:03:57 +0200
Message-ID: <CAB295yAzhzPpKC7KtpKk6t6x4Dn7Bpam=Nwfx8z0wAkZRP-JSg@mail.gmail.com>
Subject: Fwd: QEMU AVR Patch - Correct handling of AVR interrupts
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, qemu-trivial@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000ddf4cf05fda497bb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=ld.adecy@gmail.com; helo=mail-ua1-x936.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 21:02:01 -0400
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

--000000000000ddf4cf05fda497bb
Content-Type: multipart/alternative; boundary="000000000000ddf4ce05fda497b9"

--000000000000ddf4ce05fda497b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
De : Adecy <ld.adecy@gmail.com>
Date: jeu. 1 juin 2023 =C3=A0 21:34
Subject: QEMU AVR Patch - Correct handling of AVR interrupts
To: <qemu-trivial@nongnu.org>


Hello,

I would like to submit the attached patch.

Best regards

--000000000000ddf4ce05fda497b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">---------- Forwarded message ---------<br>De=C2=A0: <strong=
 class=3D"gmail_sendername" dir=3D"auto">Adecy</strong> <span dir=3D"auto">=
&lt;<a href=3D"mailto:ld.adecy@gmail.com">ld.adecy@gmail.com</a>&gt;</span>=
<br>Date: jeu. 1 juin 2023 =C3=A0=C2=A021:34<br>Subject: QEMU AVR Patch - C=
orrect handling of AVR interrupts<br>To:  &lt;<a href=3D"mailto:qemu-trivia=
l@nongnu.org">qemu-trivial@nongnu.org</a>&gt;<br></div><br><br><div dir=3D"=
ltr"><div>Hello,</div><div><div><br></div><div>I would like to submit the a=
ttached patch.</div></div><div><br></div><div>Best regards</div></div>
</div></div>

--000000000000ddf4ce05fda497b9--

--000000000000ddf4cf05fda497bb
Content-Type: application/x-patch; 
	name="0001-Fix-handling-of-AVR-interrupts-above-33-by-switching.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-handling-of-AVR-interrupts-above-33-by-switching.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lidjc0zs0>
X-Attachment-Id: f_lidjc0zs0

RnJvbSBjODcyYzBmMTY0YTVhYjU5NWNmMzQ3ZDA5ODQzMDMwMWU2MjhiNzQxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWNhcyBEaWV0cmljaCA8bGQuYWRlY3lAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDEgSnVuIDIwMjMgMjM6MjY6MzMgKzAyMDAKU3ViamVjdDogW1BBVENIXSBGaXgg
aGFuZGxpbmcgb2YgQVZSIGludGVycnVwdHMgYWJvdmUgMzMgYnkgc3dpdGNoaW5nIGN0ejMyIHRv
CiBjdHo2NAoKVGhpcyBjb21taXQgYWRkcmVzc2VzIGEgYnVnIGluIHRoZSBBVlIgaW50ZXJydXB0
IGhhbmRsaW5nIGNvZGUuClRoZSBtb2RpZmljYXRpb24gaW52b2x2ZXMgcmVwbGFjaW5nIHRoZSB1
c2FnZSBvZiB0aGUgY3R6MzIgZnVuY3Rpb24Kd2l0aCBjdHo2NCB0byBlbnN1cmUgcHJvcGVyIGhh
bmRsaW5nIG9mIGludGVycnVwdHMgYWJvdmUgMzMgaW4gdGhlIEFWUgp0YXJnZXQuCgpQcmV2aW91
c2x5LCB0aW1lcnMgMywgNCwgYW5kIDUgaW50ZXJydXB0cyB3ZXJlIG5vdCBmdW5jdGlvbmluZyBj
b3JyZWN0bHkKYmVjYXVzZSBtb3N0IG9mIHRoZWlyIGludGVycnVwdCB2ZWN0b3JzIGFyZSBudW1i
ZXJlZCBhYm92ZSAzMy4KClNpZ25lZC1vZmYtYnk6IEx1Y2FzIERpZXRyaWNoIDxsZC5hZGVjeUBn
bWFpbC5jb20+Ci0tLQogdGFyZ2V0L2F2ci9oZWxwZXIuYyB8IDQgKystLQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQv
YXZyL2hlbHBlci5jIGIvdGFyZ2V0L2F2ci9oZWxwZXIuYwppbmRleCBjMjdmNzAyOTAxLi5kYjMz
OGE4NzYxIDEwMDY0NAotLS0gYS90YXJnZXQvYXZyL2hlbHBlci5jCisrKyBiL3RhcmdldC9hdnIv
aGVscGVyLmMKQEAgLTQ1LDcgKzQ1LDcgQEAgYm9vbCBhdnJfY3B1X2V4ZWNfaW50ZXJydXB0KENQ
VVN0YXRlICpjcywgaW50IGludGVycnVwdF9yZXF1ZXN0KQogICAgIH0KICAgICBpZiAoaW50ZXJy
dXB0X3JlcXVlc3QgJiBDUFVfSU5URVJSVVBUX0hBUkQpIHsKICAgICAgICAgaWYgKGNwdV9pbnRl
cnJ1cHRzX2VuYWJsZWQoZW52KSAmJiBlbnYtPmludHNyYyAhPSAwKSB7Ci0gICAgICAgICAgICBp
bnQgaW5kZXggPSBjdHozMihlbnYtPmludHNyYyk7CisgICAgICAgICAgICBpbnQgaW5kZXggPSBj
dHo2NChlbnYtPmludHNyYyk7CiAgICAgICAgICAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gRVhD
UF9JTlQoaW5kZXgpOwogICAgICAgICAgICAgY2MtPnRjZ19vcHMtPmRvX2ludGVycnVwdChjcyk7
CiAKQEAgLTczLDcgKzczLDcgQEAgdm9pZCBhdnJfY3B1X2RvX2ludGVycnVwdChDUFVTdGF0ZSAq
Y3MpCiAgICAgaWYgKGNzLT5leGNlcHRpb25faW5kZXggPT0gRVhDUF9SRVNFVCkgewogICAgICAg
ICB2ZWN0b3IgPSAwOwogICAgIH0gZWxzZSBpZiAoZW52LT5pbnRzcmMgIT0gMCkgewotICAgICAg
ICB2ZWN0b3IgPSBjdHozMihlbnYtPmludHNyYykgKyAxOworICAgICAgICB2ZWN0b3IgPSBjdHo2
NChlbnYtPmludHNyYykgKyAxOwogICAgIH0KIAogICAgIGlmIChhdnJfZmVhdHVyZShlbnYsIEFW
Ul9GRUFUVVJFXzNfQllURV9QQykpIHsKLS0gCjIuMzkuMQoK
--000000000000ddf4cf05fda497bb--

