Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB4879A7E2
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 14:17:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qffq9-00086h-4Y; Mon, 11 Sep 2023 08:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qffq6-00085i-QD
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:16:27 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qffq2-0000Bv-RF
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:16:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c65820134so4021372f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694434581; x=1695039381; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cVixcCMBazVt4GDV3EydwLTjw2D4rAs8jyybEOv3MQ=;
 b=fZDjIr3SctrAFM2rHepy34QfdZEAVCXOjYXkUXtcuDnW7DqYJc2tSJIezokiYteMvP
 wYWJfFPrx4Exykp0CnD8IMjxcD5NC6csJ7plYLcvCu1+Kg0hUEOki/mmwGS5srZyCfwl
 NEDSTRggJKAy/v2xcAPGqBu4B9s3OVGLzKqSFcZ+CK5HMbK0Rfv2NtI/Zss1pQP9vWsk
 wYjCiNRXA/0+mfb/Xsb0i7e61NF1c6a9lys1wcHIvadjfN+RrI4/5FrvF4KdYdz64s6a
 oDmuQCN84Ycpy941Xz3bGgnf/BNOIbgUC1Wi5nWkvWPEQT6Cc4hHLHkzWwYeEXyxjShI
 Wv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694434581; x=1695039381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4cVixcCMBazVt4GDV3EydwLTjw2D4rAs8jyybEOv3MQ=;
 b=kA2sfKRWJcv7I2+zkP4jffXQi36FveCdaXXWL3MYQ0f2/p6ECVV4kEBgiIukWzJYyh
 8ulOmd/pdisJgSB7w2P/7fiBtB0+gK9gDAArpyZ29rB1EfNNKVBOd/Bxmu+93mZHIuHC
 gVoGugdW47DEY3Owi0uOYbw5A6nh58j8x3aFbyw4YygGn4ZLvJWDM2hdE7Bg1r5HpbHJ
 /JbEwywJIj/NvfT6UOuEDTYZd++8pF9wtswo4p44kLIJVY7GnjLOJ7oEEzJlMjAKFlUF
 cKDGYLVIXS1ym1pNtWlR+icQlsqSpgvqnHYc3C2xHHes/9g/z5YZ5+tEWkbjCpgioXjN
 Phiw==
X-Gm-Message-State: AOJu0Yy0R/xGY1mutUUAH9bX1PcEiQ2Yldgo7bqRextRSFSPNJ1PRcFD
 NtWn+n+VqWcmTuIjiYpKo5NcYW95dvg/l9wndCmNug==
X-Google-Smtp-Source: AGHT+IFhNUwDT0LeYQ8+oz27/30UxTVC/ZJTlhTrdJTISTn7FHqe8Cpr1w0hZv+vNfk36EkuvNn6CiF4nCW6MhMQOcg=
X-Received: by 2002:adf:a2d2:0:b0:31f:b0ba:f2ce with SMTP id
 t18-20020adfa2d2000000b0031fb0baf2cemr865640wra.9.1694434580651; Mon, 11 Sep
 2023 05:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <afa1c81a-3077-45f9-83e7-d6b87b0fcf80@reext.ru>
 <8734zlosqd.fsf@linaro.org>
In-Reply-To: <8734zlosqd.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 13:16:09 +0100
Message-ID: <CAFEAcA9hz=0_wp=i3d=7NVF=H31zk0qJCbMmQ7PdbGRVbG26xA@mail.gmail.com>
Subject: Re: Disassembler disagrees with translator over instruction decoding
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?B?0KHRgtCw0L3QuNGB0LvQsNCyINCu0LTQuNC9?= <CityAceE@reext.ru>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 11 Sept 2023 at 12:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> =D0=A1=D1=82=D0=B0=D0=BD=D0=B8=D1=81=D0=BB=D0=B0=D0=B2 =D0=AE=D0=B4=D0=B8=
=D0=BD <CityAceE@reext.ru> writes:
>
> > Hello,
> >
> > I've just got this message, when I dubugging my code:
> >
> > Disassembler disagrees with translator over instruction decoding
> > Please report this to qemu-devel@nongnu.org
> >
> > *
> >
> > Binary code is in the attachment.
>
> The binary seems to reconfigure itself as it executes as I can't find
> the instructions in the objdump. However via gdbstub we get to:
>
>   (gdb) x/4i $pc
>   =3D> 0x60011ab8:  pop     {r0, r1, r2, r3, r4, r5, r6, pc}
>      0x60011aba:  push    {lr}
>      0x60011abc:  mov.w   r11, #4
>      0x60011ac0:  ldrb.w  r7, [r0, r10]
>   (gdb) x/10i 0x60010168
>      0x60010168:  ldrb    r6, [r0, r1]
>      0x6001016a:  addw    r7, pc, #6
>      0x6001016e:  ldr.w   pc, [r7]
>      0x60010172:  lsls    r2, r6, #21
>      0x60010174:  str     r1, [r0, #0]
>      0x60010176:  lsls    r2, r7, #21
>      0x60010178:  str     r1, [r0, #0]
>      0x6001017a:  lsls    r6, r3, #22
>      0x6001017c:  str     r1, [r0, #0]
>      0x6001017e:  lsls    r6, r5, #22
>   (gdb) hbreak *0x6001016e
>   Hardware assisted breakpoint 2 at 0x6001016e
>   (gdb) c
>   Continuing.
>
>   Breakpoint 2, 0x6001016e in ?? ()
>   (gdb) i
>   0x60010572 in ?? ()
>   =3D> 0x60010572:  streq   pc, [r4, #-421] @ 0xfffffe5b
>      0x60010576:  ldmiblt r7, {r0, r12, sp, lr, pc}^
>      0x6001057a:  tsteq   r1, r1, lsl #2  @ <UNPREDICTABLE>
>   (gdb) x/5i $pc
>   =3D> 0x60010572:  streq   pc, [r4, #-421] @ 0xfffffe5b
>      0x60010576:  ldmiblt r7, {r0, r12, sp, lr, pc}^
>      0x6001057a:  tsteq   r1, r1, lsl #2  @ <UNPREDICTABLE>
>      0x6001057e:  smlabteq        r0, r0, r2, pc  @ <UNPREDICTABLE>
>      0x60010582:  blt     0x61da66a2
>   (gdb) x/10w $pc
>   0x60010572:     0x0504f1a5      0xb9d7f001      0x0101f101      0x0100f=
2c0
>   0x60010582:     0xba765846      0x0300f2c0      0x0436bfe1      0x31024=
333
>   0x60010592:     0x0100f2c0      0x050af1a5
>   (gdb)

Notice that the PC here is not 4-aligned, but the
disassembly is being done in Arm mode. (Presumably the
guest code has messed up trying to jump to Thumb code.)

In the trace in the screenshot, you can also see that the
warning happens after an attempted ldr.w   pc, [r7],
and the next thing translated is at address 0xc, which
is an exception entry point. So likely the complaint is
about the bogus instruction at wherever the incorrect
return address takes us, which provoked an exception.

(Note to the original reporter: you'll find it easier to
debug from -d logging if you add 'exec,cpu,int' to your -d list:
this will then log (a) actual execution with guest register
contents, not just translation-time instruction traces
(b) information about when an exception is taken.)

> Which seems to agree with the disassembler from the console:
>
>   (qemu) x/5i 0x60010572
>   0x60010572:  0504f1a5  streq    pc, [r4, #-0x1a5]
>   0x60010576:  b9d7f001  ldmiblt  r7, {r0, ip, sp, lr, pc} ^
>   0x6001057a:  0101f101  mrseq    pc, apsr
>   0x6001057e:  0100f2c0  smlabteq r0, r0, r2, pc
>   0x60010582:  ba765846  blt      #0x61da66a2

I think we should delete that warning message, personally.
There are a few "expected" corner cases where it can fire,
I think, though I can't remember the details.[*] It wouldn't
surprise me too much if "try to dissassemble in Arm mode
starting at an unaligned address" was one of those cases.
But more generally it assumes that the disassemblers are
reliable sources of information on the length of instructions,
and I don't think that's true any more -- they tend to lag
behind on newer instruction set features and we don't try
to keep them up to date.

[*] One example from 2017, caused by the translator stopping
reading insn bytes in an x86 variable length insn as soon as
it identifies it as not being valid:
https://lore.kernel.org/qemu-devel/CAFEAcA9HLbnZnfBisNLPnKuf364kPtq8=3D0soF=
movYRzRWrOtkA@mail.gmail.com/

thanks
-- PMM

