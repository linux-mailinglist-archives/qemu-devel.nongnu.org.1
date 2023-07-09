Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7B174C1D2
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 12:11:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIRMz-0008Bo-3V; Sun, 09 Jul 2023 06:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1qIRMx-0008BQ-5R
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 06:10:19 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1qIRMv-00010y-Hj
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 06:10:18 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b69f958ef3so53996351fa.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688897415; x=1691489415;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yOZhObTfVt34Ev7QTSPTTZo8ZXQUXnH2rhoYdA3bk1g=;
 b=NjNCSgluJOvxgZ5+MUjeo8wA1AVqCnagCG88n9zQza8wATqg4Z2E12uuBrhyfzqWFO
 6I8eWEWhSzu0AhLXdGVSRJoL+3WutevkAzugeQ0DJ/2fHc4dM8M4lXBHkVF4jD52FDNL
 nJrhdfHh/fmJOtaMua3OuVQjwZM77sHQTpOuRFQCDC+/PfjbUKiH4RUIwuSUUVZOTHVm
 QTmzIUEqRlTeFUC5PuyaxN9n+Rzjz//khWVWhUk/UNAuadJzYxQOF30U4DeySCCs6aML
 plNKBIyb700BtTJLbK9rPBxRLPZ+lFR3KwKGEyjcdAo/OQWZPLX5sDOBJwiynShMZWfN
 Bf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688897415; x=1691489415;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yOZhObTfVt34Ev7QTSPTTZo8ZXQUXnH2rhoYdA3bk1g=;
 b=TuF0PfRY26EN+CXqVLsiSc/X21g7/B3WLJHH2VSXUQv8nZEdlsINUnaRj42JwRA3mB
 AZljFRVZq+pdUiViF2QiShEWQh9hs3RmEhJyw5DPdXl0prMxX4XEq91nDcZu5Jfuw+Wa
 TamBf0TOS/+0NEKRGK4Sdqcfzw62Eq2ydXoezcvYPrWJ+duLtWR9mo3E8Zh3G2W2wr8o
 AYJzs3AjBBKEh6r/WLow4EpAa9dJ88COatIZ/NOsF1rxQ3lQdfokximTXl3ZHxLwCKGs
 xRfTb6nLJMw5lA3up2q17ZgBT00xxESduTp3dH/8ynkU21KubsC4mw4ImKi/m/jTU5ei
 z+XQ==
X-Gm-Message-State: ABy/qLZB5Fn/hDTF++Y276/nvQIf3d2xtZ/YLPDnyOaueEC5pX5MTnuc
 7lDpTpgjsxt/uiBUcfKBrAutoJyXiF60hs0XoGTidgfxVtYR4w==
X-Google-Smtp-Source: APBJJlEIMoLkMBZlepKIEa2heYX0M40vVPpU49XtGKfLShNcjPsjXYlC5/rZgPhaqciv1uMiHWSqK4SnXblbySNp4ho=
X-Received: by 2002:a2e:7801:0:b0:2b6:fa71:5bae with SMTP id
 t1-20020a2e7801000000b002b6fa715baemr7504240ljc.12.1688897414597; Sun, 09 Jul
 2023 03:10:14 -0700 (PDT)
MIME-Version: 1.0
From: Shivam <shivamvijay543@gmail.com>
Date: Sun, 9 Jul 2023 15:40:04 +0530
Message-ID: <CAC583hH=tPw=hdv8tuS1QQ4GcK+bwXB8d21wB7WcVMmnSjKXAw@mail.gmail.com>
Subject: Request for Assistance: Adding I2C Support in QEMU for Raspberry Pi
 (BCM2835 Peripherals)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="00000000000075901e06000b12d2"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=shivamvijay543@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--00000000000075901e06000b12d2
Content-Type: text/plain; charset="UTF-8"

Hi, I have added bcm2835_i2c.c inside the i2c folder and wired up it with
bcm2835_peripheral.c , I tried to launch qemu with "-device
pca9552,address=0x60" , and it launches without any error means it can able
to found the i2c-bus


But in the emulated rpi terminal I cant able to detect this device

I tried to enable i2c but it says *Unknown parameter i2c_arm


and on i2cdetect -y 1 it throws error

Error: Could not open file /dev/i2c-1' or /dev/i2c/1': No such file or
directory

This is the output for info qtree ( related to i2c) in qemu monitor

dev: bcm2835-i2c, id ""

gpio-out "sysbus-irq" 1mmio ffffffffffffffff/0000000000001000bus: i2c
type i2c-bus  dev: pca9552, id ""   gpio-out "" 16    description =
"pca-unspecified"    address = 96 (0x60)`

Thanks & Regards
Shivam Vijay

--00000000000075901e06000b12d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr">Hi, I have added bcm2835_i2c.c in=
side the i2c folder and wired up it with bcm2835_peripheral.c , I tried to =
launch qemu with &quot;-device pca9552,address=3D0x60&quot; , and it launch=
es without any error means it can able to found the i2c-bus<span><table cel=
lpadding=3D"0" cellspacing=3D"0" style=3D"color:rgb(255,255,255);font-size:=
medium;vertical-align:-webkit-baseline-middle;font-family:Arial"><tbody><tr=
><td><table cellpadding=3D"0" cellspacing=3D"0" style=3D"vertical-align:-we=
bkit-baseline-middle;font-family:Arial"><tbody><tr><td style=3D"vertical-al=
ign:top"><br></td><td width=3D"46"></td><td style=3D"padding:0px;vertical-a=
lign:middle"><br></td></tr></tbody></table></td></tr></tbody></table></span=
><div dir=3D"ltr">But in the emulated rpi terminal I cant able to detect th=
is device</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">I tried to enabl=
e i2c but it says *Unknown parameter i2c_arm<table cellpadding=3D"0" cellsp=
acing=3D"0" style=3D"color:rgb(255,255,255);font-size:medium;vertical-align=
:-webkit-baseline-middle;font-family:Arial"><tbody><tr><td><table cellpaddi=
ng=3D"0" cellspacing=3D"0" style=3D"vertical-align:-webkit-baseline-middle"=
><tbody><tr><td style=3D"vertical-align:top"><br></td><td width=3D"46"></td=
><td style=3D"padding:0px;vertical-align:middle"><br></td></tr></tbody></ta=
ble></td></tr></tbody></table><p dir=3D"auto">and on i2cdetect -y 1 it thro=
ws error</p><p dir=3D"auto">Error: Could not open file=C2=A0<code>/dev/i2c-=
1&#39; or=C2=A0</code>/dev/i2c/1&#39;: No such file or directory</p><p dir=
=3D"auto">This is the output for info qtree ( related to i2c) in qemu monit=
or</p><p dir=3D"auto">dev: bcm2835-i2c, id &quot;&quot;</p><div><pre lang=
=3D"plaintext" id=3D"m_-3609197695166407714gmail-code-61" style=3D"text-wra=
p: wrap;"><code><span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-=
LC1">gpio-out &quot;sysbus-irq&quot; 1</span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC2"></span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC3">mmio ffffff=
ffffffffff/0000000000001000</span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC4"></span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC5">bus: i2c</s=
pan>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC6"></span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC7">  type i2c-=
bus</span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC8"></span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC9">  dev: pca9=
552, id &quot;&quot;</span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC10"></span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC11">   gpio-ou=
t &quot;&quot; 16</span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC12"></span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC13">    descri=
ption =3D &quot;pca-unspecified&quot;</span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC14"></span>
<span lang=3D"plaintext" id=3D"m_-3609197695166407714gmail-LC15">    addres=
s =3D 96 (0x60)`

Thanks &amp; Regards
Shivam Vijay</span></code></pre></div></div></div></div></div></div>

--00000000000075901e06000b12d2--

