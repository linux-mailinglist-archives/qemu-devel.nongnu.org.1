Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FFD82F064
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:16:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkEJ-0007QY-8N; Tue, 16 Jan 2024 09:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanj27272@gmail.com>)
 id 1rPggT-0007A6-DC
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:28:41 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sanj27272@gmail.com>)
 id 1rPggR-0003n4-LW
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:28:41 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28e7933c317so314917a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705400917; x=1706005717; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4DdECowrP/SXAEdsnP2Zg0ogtjmu+YBSYLv6dlWrQ5k=;
 b=AZYWTSSexAOR8QSJbTk5hYxeGGaGHRuVJDO8aZvNwDlDXel9XvuxWCUrQ0yUbkME8g
 72MUr+a1ySP4q/S0FJ++eLx4rnlJbtvM1fxOYSxeol1fitYafo63d5BKunQO9wXUPF2j
 IMUjPaGivalMlWD7UL9gUTcwPRwNy1wtRP6s9Is/quH5+/Wed6ZZa2qZcq82WqcAsDfr
 kZn38H74ieS75hqiHOOoIJaZPRCrslRqrTlaPRw/3K59lg5zSbrtRoyhas/hTuNdNIWC
 pBBHLQx2lD62K14I9wNgzitGe/rxDajP+w/UgTF+qJcc8JnNeJ4UHlkEjuc5A3pLREVk
 MRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705400917; x=1706005717;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4DdECowrP/SXAEdsnP2Zg0ogtjmu+YBSYLv6dlWrQ5k=;
 b=kWFb6sktCBKJdeUXIt5vaRi1F6iU8daRmAlypvaBETEot/ebFY1Ovo1lJZcf2hIHKx
 h4r/p5plsHEJh1VQY6lbIyR4y9xBaugDXadAsEJ0B3Xl1FE9tH4dk1AILHE2Uiuj46Sr
 X/VmHa6n6ILaPjNraekGuSInEdsIKRdV5w1wRx/W9CSsRFzOxqEd7EL2qGYUTBtkNlxn
 zlVqjwB7HSfQusEaKXJfjsjS8qM11kz2ufKYcnwMsr26mHqC97USKXJBPGmPBWgNZS1B
 /uBnbi6zc/na9H8V7ugfGuqKhQO0Ma9BZFU/t+JojdMiUWPfaGYQMGLUGkQZJqktzhRd
 UTCA==
X-Gm-Message-State: AOJu0YzjDWM2qETxVXUuHK8vBS08AgTrpBNLy18J78Bp9hF9Pc2OpTzr
 q2MuxvttuOUHpqSrE6LeW2Hjai8aFjdGvc0er4nI+VJyQa8=
X-Google-Smtp-Source: AGHT+IGUHNFBPeC/uYeYa85u8/tuSly4V1Ocb4HAZkpn0FwKWr5rtX8LM1FHk8V3OHC+g1DZQeBvDupF30QyoJoz5Ac=
X-Received: by 2002:a17:90a:ff95:b0:28d:bd0d:c7c9 with SMTP id
 hf21-20020a17090aff9500b0028dbd0dc7c9mr3947298pjb.28.1705400916641; Tue, 16
 Jan 2024 02:28:36 -0800 (PST)
MIME-Version: 1.0
From: sanjana gogte <sanj27272@gmail.com>
Date: Tue, 16 Jan 2024 15:58:25 +0530
Message-ID: <CA+ji3pGBJBp+trjM-RhgkYjOs8rrtLJgHsaNvf=EyGtWB4gAow@mail.gmail.com>
Subject: Assistance Required for QEMU Hardfault Error with Cortex-M33 on
 MPS2AN505
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d6098a060f0d9736"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=sanj27272@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_FONT_FACE_BAD=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Jan 2024 09:15:43 -0500
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

--000000000000d6098a060f0d9736
Content-Type: text/plain; charset="UTF-8"

I hope this message finds you well. I am reaching out to seek your
expertise regarding a persistent issue I have encountered while working
with QEMU, specifically a hardfault error when emulating the MPS2AN505 with
a Cortex-M33 core.

I have been grappling with this issue for some time and am unsure of the
next steps to take. Could you please advise on potential areas to
investigate or adjustments that might resolve this error? I am particularly
curious if the issue lies with the vector table placement or the
configuration in my linker script.

The error I am facing is as follows:
*qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)*

This occurs when I attempt to run my kernel.elf file using the following
QEMU command:




*qemu-system-arm -machine mps2-an505 -cpu cortex-m33 \                -m
16M \                -nographic -serial mon:stdio \                -device
loader,file=kernel.elf*

For your reference, here are the relevant details of my setup:

Startup File (Boot.s)
*.**thumb*
*.section .isr_vector*
*    .long    __StackTop         /* Initial Top of Stack */*
*    .long    Reset_Handler      /* Reset Handler */*

*.text*
*.global Reset_Handler*
*Reset_Handler:  *
*    ldr     R0, = main*
*bx      R0*

Linker Script (Kernel.ld)






















*MEMORY{   NS_CODE (rx)     : ORIGIN = 0x00000000, LENGTH = 512K
 S_CODE_BOOT (rx) : ORIGIN = 0x10000000, LENGTH = 512k   RAM   (rwx) :
ORIGIN = 0x20000000, LENGTH = 512k}/* Entry Point
*/ENTRY(Reset_Handler)SECTIONS{    .text :    {
KEEP(*(.isr_vector))        *(.text)        *(.data)        *(.bss)    } >
S_CODE_BOOT    /* Set stack top to end of S_CODE_BOOT. */    __StackTop =
ORIGIN(S_CODE_BOOT) + LENGTH(S_CODE_BOOT);}*

Toolchain Used:
*arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi*

Compilation Commands to generate my elf file:




*arm-none-eabi-gcc -mcpu=cortex-m33 -g -c boot.s -o boot.oarm-none-eabi-ld
boot.o main.o -T kernel.ld -o kernel.elfarm-none-eabi-objdump -d kernel.elf
> kernel.listarm-none-eabi-objdump -t kernel.elf | sed '1,/SYMBOL TABLE/d;
s/ .* / /; /^$/d' > kernel.symarm-none-eabi-readelf -A kernel.elf*

Main Function (main.c):



*void main(void){    while (1);}*

Output of readelf -wl Command:











*Elf file type is EXEC (Executable file)Entry point 0x10000008There is 1
program header, starting at offset 52Program Headers:  Type
Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align  LOAD
0x001000 0x10000000 0x10000000 0x00016 0x00016 R E 0x1000 Section to
Segment mapping:  Segment Sections...   00     .text*

Guest Errors Observed:
I
*nvalid read at addr 0x10000000, size 4, region '(null)', reason:
rejectedInvalid read at addr 0x10000004, size 4, region '(null)', reason:
rejected*

Your guidance on this matter would be greatly appreciated. I am eager to
understand and resolve this issue, and I believe your expertise could be
invaluable in this context.

Thank you for your time and consideration. I look forward to any insights
or suggestions you might have.

Best regards,
Sanjana Gogte

--000000000000d6098a060f0d9736
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"border:0px solid rgb(217,217,227);box-sizing:b=
order-box;margin:1.25em 0px;font-family:S=C3=B6hne,ui-sans-serif,system-ui,=
-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto Sans&=
quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Color Emoji&q=
uot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Colo=
r Emoji&quot;"><font color=3D"#000000">I hope this message finds you well. =
I am reaching out to seek your expertise regarding a persistent issue I hav=
e encountered while working with QEMU, specifically a hardfault error when =
emulating the MPS2AN505 with a Cortex-M33 core.=C2=A0</font></p><p style=3D=
"border:0px solid rgb(217,217,227);box-sizing:border-box;margin:1.25em 0px;=
font-family:S=C3=B6hne,ui-sans-serif,system-ui,-apple-system,&quot;Segoe UI=
&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto Sans&quot;,sans-serif,&quot;Helve=
tica Neue&quot;,Arial,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&qu=
ot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;"><span style=
=3D"font-family:Arial,Helvetica,sans-serif">I have been grappling with this=
 issue for some time and am unsure of the next steps to take. Could you ple=
ase advise on potential areas to investigate or adjustments that might reso=
lve this error? I am particularly curious if the issue lies with the vector=
 table placement or the configuration in my linker script.</span><font colo=
r=3D"#000000"><br></font></p><p style=3D"border:0px solid rgb(217,217,227);=
box-sizing:border-box;margin:1.25em 0px;font-family:S=C3=B6hne,ui-sans-seri=
f,system-ui,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quo=
t;Noto Sans&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple C=
olor Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&qu=
ot;Noto Color Emoji&quot;">The error I am facing is as follows:<br><b>qemu:=
 fatal: Lockup: can&#39;t escalate 3 to HardFault (current priority -1)</b>=
</p><p style=3D"border:0px solid rgb(217,217,227);box-sizing:border-box;mar=
gin:1.25em 0px;font-family:S=C3=B6hne,ui-sans-serif,system-ui,-apple-system=
,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto Sans&quot;,sans-se=
rif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Color Emoji&quot;,&quot;Se=
goe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;=
">This occurs when I attempt to run my kernel.elf file using the following =
QEMU command:</p><p style=3D"border:0px solid rgb(217,217,227);box-sizing:b=
order-box;margin:1.25em 0px;font-family:S=C3=B6hne,ui-sans-serif,system-ui,=
-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto Sans&=
quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Color Emoji&q=
uot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Colo=
r Emoji&quot;"><b style=3D"background-color:rgb(204,204,204)">qemu-system-a=
rm -machine mps2-an505 -cpu cortex-m33 \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 -m 16M \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 -nographic -serial mon:stdio \<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -device loader,file=3Dkernel.elf</b><br>=
</p><p style=3D"border:0px solid rgb(217,217,227);box-sizing:border-box;mar=
gin:1.25em 0px;font-family:S=C3=B6hne,ui-sans-serif,system-ui,-apple-system=
,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto Sans&quot;,sans-se=
rif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Color Emoji&quot;,&quot;Se=
goe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;=
">For your reference, here are the relevant details of my setup:<br></p><p =
style=3D"border:0px solid rgb(217,217,227);box-sizing:border-box;margin:1.2=
5em 0px;font-family:S=C3=B6hne,ui-sans-serif,system-ui,-apple-system,&quot;=
Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto Sans&quot;,sans-serif,&qu=
ot;Helvetica Neue&quot;,Arial,&quot;Apple Color Emoji&quot;,&quot;Segoe UI =
Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;">Start=
up File (Boot.s)</p><b style=3D"font-family:S=C3=B6hne,ui-sans-serif,system=
-ui,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto S=
ans&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Color Emo=
ji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto =
Color Emoji&quot;">.</b><b style=3D"font-family:S=C3=B6hne,ui-sans-serif,sy=
stem-ui,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;No=
to Sans&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Color=
 Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;N=
oto Color Emoji&quot;"><span style=3D"background-color:rgb(204,204,204)">th=
umb</span></b><br><b style=3D"font-family:S=C3=B6hne,ui-sans-serif,system-u=
i,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto San=
s&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Color Emoji=
&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Co=
lor Emoji&quot;"><span style=3D"background-color:rgb(204,204,204)">.section=
 .isr_vector</span></b><br><b style=3D"font-family:S=C3=B6hne,ui-sans-serif=
,system-ui,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot=
;Noto Sans&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Co=
lor Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quo=
t;Noto Color Emoji&quot;"><span style=3D"background-color:rgb(204,204,204)"=
>=C2=A0 =C2=A0 .long =C2=A0 =C2=A0__StackTop =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Initial Top of Stack */</span></b><br><b style=3D"font-family:S=C3=B6hne,u=
i-sans-serif,system-ui,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Can=
tarell,&quot;Noto Sans&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&q=
uot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbo=
l&quot;,&quot;Noto Color Emoji&quot;"><span style=3D"background-color:rgb(2=
04,204,204)">=C2=A0 =C2=A0 .long =C2=A0 =C2=A0Reset_Handler =C2=A0 =C2=A0 =
=C2=A0/* Reset Handler */</span></b><br><font face=3D"S=C3=B6hne, ui-sans-s=
erif, system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Cantarell, Noto S=
ans, sans-serif, Helvetica Neue, Arial, Apple Color Emoji, Segoe UI Emoji, =
Segoe UI Symbol, Noto Color Emoji"><b><br></b></font><b style=3D"font-famil=
y:S=C3=B6hne,ui-sans-serif,system-ui,-apple-system,&quot;Segoe UI&quot;,Rob=
oto,Ubuntu,Cantarell,&quot;Noto Sans&quot;,sans-serif,&quot;Helvetica Neue&=
quot;,Arial,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;=
Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;"><span style=3D"backgrou=
nd-color:rgb(204,204,204)">.text</span></b><br><b style=3D"font-family:S=C3=
=B6hne,ui-sans-serif,system-ui,-apple-system,&quot;Segoe UI&quot;,Roboto,Ub=
untu,Cantarell,&quot;Noto Sans&quot;,sans-serif,&quot;Helvetica Neue&quot;,=
Arial,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe =
UI Symbol&quot;,&quot;Noto Color Emoji&quot;"><span style=3D"background-col=
or:rgb(204,204,204)">.global Reset_Handler</span></b><br><b style=3D"font-f=
amily:S=C3=B6hne,ui-sans-serif,system-ui,-apple-system,&quot;Segoe UI&quot;=
,Roboto,Ubuntu,Cantarell,&quot;Noto Sans&quot;,sans-serif,&quot;Helvetica N=
eue&quot;,Arial,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&q=
uot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;"><span style=3D"back=
ground-color:rgb(204,204,204)">Reset_Handler: =C2=A0</span></b><br><b style=
=3D"font-family:S=C3=B6hne,ui-sans-serif,system-ui,-apple-system,&quot;Sego=
e UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto Sans&quot;,sans-serif,&quot;H=
elvetica Neue&quot;,Arial,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoj=
i&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;"><span sty=
le=3D"background-color:rgb(204,204,204)">=C2=A0 =C2=A0 ldr =C2=A0 =C2=A0 R0=
, =3D main</span></b><div><b style=3D"font-family:S=C3=B6hne,ui-sans-serif,=
system-ui,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;=
Noto Sans&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot=
;Noto Color Emoji&quot;"><span style=3D"background-color:rgb(204,204,204)">=
bx =C2=A0 =C2=A0 =C2=A0R0</span></b><b style=3D"font-family:S=C3=B6hne,ui-s=
ans-serif,system-ui,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantar=
ell,&quot;Noto Sans&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&quot=
;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&q=
uot;,&quot;Noto Color Emoji&quot;"><span style=3D"background-color:rgb(204,=
204,204)"><br></span></b><br>Linker Script (Kernel.ld)</div><div><br></div>=
<div><b style=3D"background-color:rgb(204,204,204)">MEMORY<br>{<br>=C2=A0 =
=C2=A0NS_CODE (rx) =C2=A0 =C2=A0 : ORIGIN =3D 0x00000000, LENGTH =3D 512K<b=
r>=C2=A0 =C2=A0S_CODE_BOOT (rx) : ORIGIN =3D 0x10000000, LENGTH =3D 512k<br=
>=C2=A0 =C2=A0RAM =C2=A0 (rwx) : ORIGIN =3D 0x20000000, LENGTH =3D 512k<br>=
}<br><br>/* Entry Point */<br>ENTRY(Reset_Handler)<br><br>SECTIONS<br>{<br>=
=C2=A0 =C2=A0 .text :<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 KEE=
P(*(.isr_vector))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(.text)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 *(.data)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(.bss)<br>=C2=A0 =C2=
=A0 } &gt; S_CODE_BOOT<br>=C2=A0 =C2=A0 /* Set stack top to end of S_CODE_B=
OOT. */<br>=C2=A0 =C2=A0 __StackTop =3D ORIGIN(S_CODE_BOOT) + LENGTH(S_CODE=
_BOOT);<br>}</b></div><div><b><br></b></div><div>Toolchain Used:</div><div>=
<b style=3D"background-color:rgb(204,204,204)">arm-gnu-toolchain-13.2.Rel1-=
x86_64-arm-none-eabi</b></div><div><b style=3D"background-color:rgb(204,204=
,204)"><br></b></div><div>Compilation Commands to generate my elf file:<br>=
</div><div><b style=3D"background-color:rgb(204,204,204)">arm-none-eabi-gcc=
 -mcpu=3Dcortex-m33 -g -c boot.s -o boot.o<br>arm-none-eabi-ld boot.o main.=
o -T kernel.ld -o kernel.elf<br>arm-none-eabi-objdump -d kernel.elf &gt; ke=
rnel.list<br>arm-none-eabi-objdump -t kernel.elf | sed &#39;1,/SYMBOL TABLE=
/d; s/ .* / /; /^$/d&#39; &gt; kernel.sym<br>arm-none-eabi-readelf -A kerne=
l.elf</b><br></div><div><b style=3D"background-color:rgb(204,204,204)"><br>=
</b></div><div>Main Function (main.c):<br></div><div><b style=3D"background=
-color:rgb(204,204,204)">void main(void)<br>{<br>=C2=A0 =C2=A0 while (1);<b=
r>}</b><br></div><div><b><br></b></div><div>Output of readelf -wl Command:<=
br></div><div><br></div><div><b style=3D"background-color:rgb(204,204,204)"=
>Elf file type is EXEC (Executable file)<br>Entry point 0x10000008<br>There=
 is 1 program header, starting at offset 52<br><br>Program Headers:<br>=C2=
=A0 Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset =C2=A0 VirtAddr =C2=A0 P=
hysAddr =C2=A0 FileSiz MemSiz =C2=A0Flg Align<br>=C2=A0 LOAD =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x001000 0x10000000 0x10000000 0x00016 0x00016 R E 0x1=
000<br><br>=C2=A0Section to Segment mapping:<br>=C2=A0 Segment Sections...<=
br>=C2=A0 =C2=A000 =C2=A0 =C2=A0 .text</b><br></div><div><b style=3D"backgr=
ound-color:rgb(204,204,204)"><br></b></div><div>Guest Errors Observed:<br><=
/div><div><span style=3D"background-color:rgb(204,204,204)">I<b>nvalid read=
 at addr 0x10000000, size 4, region &#39;(null)&#39;, reason: rejected<br>I=
nvalid read at addr 0x10000004, size 4, region &#39;(null)&#39;, reason: re=
jected</b><br></span></div><div><br></div><div>Your guidance on this matter=
 would be greatly appreciated. I am eager to understand and resolve this is=
sue, and I believe your expertise could be invaluable in this context.<br><=
br>Thank you for your time and consideration. I look forward to any insight=
s or suggestions you might have.<br><br>Best regards,<br>Sanjana Gogte</div=
></div>

--000000000000d6098a060f0d9736--

