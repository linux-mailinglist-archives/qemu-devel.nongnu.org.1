Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11393831666
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 11:06:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQPGd-0008MD-GF; Thu, 18 Jan 2024 05:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQPGc-0008M3-AI
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:04:58 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQPGV-0001vf-W8
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:04:57 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-559dbeba085so2021159a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 02:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705572289; x=1706177089; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8nHvjlxSm2UeNRjVOzGaH7Tc4KpH34QKsnvOQREX8I=;
 b=llsgdWwmWG7ii7WoORdnLnXgngNZEP74QjIHMNJBKJxHZzFBCElUHjEvAAjYDZESjd
 7mqt6VwdQz22zw4MsSQd+hODT5SeZ6RANzUAMI7bWQ8u3xzZRwMw2URhihBqHKss9bsZ
 bE93rEDk4pas1+wsh3W8wnmpP82QKB5hY/GYECvznHNy4brm6zOr5AvpFBGaYcncuhCv
 w/zamVcB3eceKa1x6IF6/1ly3rfgx8mTUPf8PqcyHq66WJyP73vt+dA+0Q4d9h8/HqJA
 tVq7Kp1w7VGhe/Kmv2UFs4ITAz/H6VUzIGJtCi6QNs5dL/FQKJJB6txBFIHhSZ0FMDKJ
 6XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705572289; x=1706177089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8nHvjlxSm2UeNRjVOzGaH7Tc4KpH34QKsnvOQREX8I=;
 b=KGSA01dj5p2rXb9StL1X7FLY0qeZVZZCxRN+Hr5O7RI+xoKrvLlikyM4t/vP6Qyl27
 bIaX2KMA4XH13aCO16riJW3Pkes8Zx1A8nYcdRKSuY317nlBTirUecb0S7QnzjVEBplq
 e4FIg76RPih4yStr9/iDhqryV+2T15Qzy3avLj8kcLckDd3NOue+Efp06EPyfE+hlrVD
 RJn3ZMMkCQqTSpdRaLBuvEC8O6ftHU5XvTcYIdUiyz4YwN5qXv9rqRG2RG+1B4ygbuFr
 W1lAyOXGRKX5IMv5mwnMM1lJJyF4+cBxfJfPjpUV8sUUXukMff0340rxuxfgtW/Nl6d+
 wQKA==
X-Gm-Message-State: AOJu0YyeMV6L148rJsl1qry2/tt7ui4PO6vMapsrxeZzL6BtdvND5rVx
 y2hTMGaCQWU1HfioVniu/w6BeTDuvKPPaEKSBrdL+SPILumdkhtsWC4btvnY3S1ZJsQkfxZ5iNm
 nvOoYCxKPzO0zBM0pqSHiCcB0WQK02IW2pp2nlgyREFSdrxxw
X-Google-Smtp-Source: AGHT+IG40vkLOckOZF/QsLMSzTGrOVoXt/nrVy62+Hqt6E2MNmDawFLxZr0Tpztwufk+XM+MkztyQ/EbMpe3rMmyIVQ=
X-Received: by 2002:aa7:cb50:0:b0:55a:8d7:ac8f with SMTP id
 w16-20020aa7cb50000000b0055a08d7ac8fmr336838edt.2.1705572289139; Thu, 18 Jan
 2024 02:04:49 -0800 (PST)
MIME-Version: 1.0
References: <CA+ji3pGBJBp+trjM-RhgkYjOs8rrtLJgHsaNvf=EyGtWB4gAow@mail.gmail.com>
 <CAFEAcA-L2vepWXfgaHW=ogLAvAZjJd5yv1hm6dBU6dsEOS_gCA@mail.gmail.com>
 <CA+ji3pGVBmDAeUoPM9Zk8pOtpxcR+92XeUBN8G=Mmmyi4Eh8-g@mail.gmail.com>
In-Reply-To: <CA+ji3pGVBmDAeUoPM9Zk8pOtpxcR+92XeUBN8G=Mmmyi4Eh8-g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2024 10:04:36 +0000
Message-ID: <CAFEAcA9AeqbWt1Q5QM_HEwi+A2KYXFs1ZEqfFJcqdktYwWujTQ@mail.gmail.com>
Subject: Re: Assistance Required for QEMU Hardfault Error with Cortex-M33 on
 MPS2AN505
To: sanjana gogte <sanj27272@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 18 Jan 2024 at 06:30, sanjana gogte <sanj27272@gmail.com> wrote:
>
> Hi,
> 1) I am using QEMU Version 7.1.0. I am currently using this version with =
a plan to connect the remote port from Xilinx to the mps2an505 board. The d=
ecision to use this specific version is heavily influenced by the fact that=
 it is the same version utilized by Xilinx's QEMU.
>
> 2) Debug Logs :
> guest_errors:
>
> Invalid read at addr 0x10000000, size 4, region '(null)', reason: rejecte=
d
> Invalid read at addr 0x10000004, size 4, region '(null)', reason: rejecte=
d
> Invalid read at addr 0x10800000, size 2, region '(null)', reason: rejecte=
d
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
>
> in_asm:

>
> IN:
> 0x10000008:
> OBJD-T: 00480047

Whoever built your QEMU didn't do it with libcapstone-dev
installed, so the debug logs have only binary dumps of
instructions, not the actual instructions, which is a pity
(--enable-capstone will force configure to either find the
necessary library or else give you an error message.)

Also, I did not mean "do logs of every -d option separately",
I meant "do a single log, with -d
in_asm,exec,cpu,int,cpu_reset,unimp,guest_errors,nochain"
That way you get the different bits of logging in their
correct sequence relative to each other.

Luckily, this bit is enough to figure out what's going on:

> Loaded reset SP 0x0 PC 0x0 from vector table
> Loaded reset SP 0x10080000 PC 0x10000008 from vector table

We load the PC from the vector table, but it does not
have the low bit set, which is not correct. (All entries
in the vector table must be function pointers in the
usual Thumb convention, where the lowest bit is set to
indicate Thumb mode and clear to indicate Arm mode.)
This means that we will start without the Thumb T bit set...

> Taking exception 18 [v7M INVSTATE UsageFault] on CPU 0

...which on M-profile means we immediately take a fault trying
to execute the first instruction...

> ...taking pending secure exception 3
> ...loading from element 3 of secure vector table at 0x1000000c
> ...loaded new PC 0x10000011

...but because your vector table includes no entry for
the hardfault vector, we instead load a PC value which
doesn't point anywhere useful...

> Taking exception 3 [Prefetch Abort] on CPU 0
> ...at fault address 0x10800000
> ...with CFSR.IBUSERR
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

...and eventually we execute off the end of the ROM memory,
and then take a bus fault on the instruction fetch. This
is a Lockup because we were already in a HardFault handler
when we took this fault.

> 3) You said the vector table is too small so I tried something like this =
from your reference files but it gives me the same error:
>
> Boot.s ( Startup file )
>
> .thumb
> .syntax unified
>
> .section .isr_vector
>     .long __StackTop
>     .long Reset_Handler
>     .word 0

Zeroes here aren't very helpful because the CPU will try
to jump to address 0 (and then immediately take another
fault because the Thumb bit isn't set, which will be
a Lockup condition again). If you at least make them point to
branch-to-self instructions it'll be a bit clearer when
you take an exception you weren't expecting, because in
the debugger you'll see execution looping at that insn.

>     .word 0
>     .rept 7
>     .word 0
>     .endr
>     .word 0
>     .word 0
>     .word 0
>     .word 0
>     .word 0
>     .rept 32
>     .word 0
>     .endr
>
>
> .text
> .global Reset_Handler
> Reset_Handler:
>     ldr     R0, =3D main
>     bx      R0

But really your problem is here. You haven't told the assembler
that "Reset_Handler" is a function entry point, and so it treats
it like a data label. That means that the least significant bit
is not set when you reference it in the vector table.

Something like this will do what you want:
        .type Reset_Handler, function
        .global Reset_Handler
Reset_Handler:

PS: a hint for later: your code here does not do anything
to enable the FPU before it jumps into C code. If your
C compiler is generating code to use the FPU this will
mean it will take an exception. So either make sure the
C compiler is configured not to use the FPU, or else enable
the FPU first.

thanks
-- PMM

