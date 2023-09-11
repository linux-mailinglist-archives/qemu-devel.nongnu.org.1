Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F279A79C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:27:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qff4V-0000O4-Tz; Mon, 11 Sep 2023 07:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qff4T-0000B6-Qs
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:27:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qff4Q-0007R1-7o
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:27:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso26921945e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694431627; x=1695036427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1tsTdQT4SoHjC3h8EhXaWp2t8YkjNND1wnF74yoLiw=;
 b=R2L2dh/Hk2QCwN0twSLQkGt6lC63BUsZ5AjCT6CxV+cr4hUaQi3rnT/rfyM2jHaI/Q
 ccLNrBFK/Id0bEs/kg6Wckzenb2MoHeKfiSUcVHH1m3VVII3Dqhl6wHTUMcGgCXl0Gpi
 215jrN/32JwKMjo0LweFkKPgj6toRrRs7BGUuF3d89oCL64uaUMN9SyhfSgRAkmsf/FU
 M2hmnnKzIwFKisKY51wqPqTlTTOFt2XZqDEpG/JTBySGN1LFdVKM+xZQ957FHmSdCKHU
 8wpqUONmLHdpOFfK5oPPs7aCD2xiFFe6RhawM80g7cOBybMhVKb4dyagGQAv+tO/oCZQ
 opeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694431627; x=1695036427;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n1tsTdQT4SoHjC3h8EhXaWp2t8YkjNND1wnF74yoLiw=;
 b=YuIIVy3sWgpLvACkFMz0vAWm3ZKWjHYPscKjFxiqGjqGZ/1e11jkyqiLzKFVDPaydA
 6LxnX9E+SbhGCi+VaFAOEKu5iSgP7o2sK7dRWgg2a1wS67frOM7IBMK1pZxDFbsWZ4bS
 B5oeSsLNFT/hCXXcQ+GDbncUfTd2G6nDSRTKj/zXvSmFVtoZj0Bu5SLiDKzEUXEjBaSG
 idLHb1awN3Iu+lHbTm5ysZ/2+BCpgSifp9LuCkaghcoTtzfWNAJ2hsRUD4cSk9jaLzC3
 1Z9orM9lOdmoYLVQevSUc9/cAP1okulciqHDlK1z2KoxciQjUDNIglLwejD3gRiKkSd/
 Yy+w==
X-Gm-Message-State: AOJu0Yyi3c9kEogS7HP5NS9PTJuKKcmQ21eLb+51HUTLZmS/s5nVzg2r
 XFKeqLutLLARzDMuvbLO+p9Ve5k9MQOeLzYg1qo=
X-Google-Smtp-Source: AGHT+IF0vgFTSSRqM6SN0gqbGWGMIvbPbcVWlLFMfP4xGXGhzJTs3o4iqfHWdcpejEfiXYKQoksxbw==
X-Received: by 2002:a05:600c:378b:b0:402:ea5c:1845 with SMTP id
 o11-20020a05600c378b00b00402ea5c1845mr7132032wmr.5.1694431627598; 
 Mon, 11 Sep 2023 04:27:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a05600c0ac900b003fef60005b5sm9800137wmr.9.2023.09.11.04.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 04:27:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C3FC81FFBB;
 Mon, 11 Sep 2023 12:27:06 +0100 (BST)
References: <afa1c81a-3077-45f9-83e7-d6b87b0fcf80@reext.ru>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?B?0KHRgtCw0L3QuNGB0LvQsNCyINCu0LTQuNC9?= <CityAceE@reext.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: Disassembler disagrees with translator over instruction decoding
Date: Mon, 11 Sep 2023 12:20:56 +0100
In-reply-to: <afa1c81a-3077-45f9-83e7-d6b87b0fcf80@reext.ru>
Message-ID: <8734zlosqd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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


=D0=A1=D1=82=D0=B0=D0=BD=D0=B8=D1=81=D0=BB=D0=B0=D0=B2 =D0=AE=D0=B4=D0=B8=
=D0=BD <CityAceE@reext.ru> writes:

> Hello,
>
> I've just got this message, when I dubugging my code:
>
> Disassembler disagrees with translator over instruction decoding
> Please report this to qemu-devel@nongnu.org
>
> *
>
> Binary code is in the attachment.

The binary seems to reconfigure itself as it executes as I can't find
the instructions in the objdump. However via gdbstub we get to:

  (gdb) x/4i $pc
  =3D> 0x60011ab8:  pop     {r0, r1, r2, r3, r4, r5, r6, pc}
     0x60011aba:  push    {lr}
     0x60011abc:  mov.w   r11, #4
     0x60011ac0:  ldrb.w  r7, [r0, r10]
  (gdb) x/10i 0x60010168
     0x60010168:  ldrb    r6, [r0, r1]
     0x6001016a:  addw    r7, pc, #6
     0x6001016e:  ldr.w   pc, [r7]
     0x60010172:  lsls    r2, r6, #21
     0x60010174:  str     r1, [r0, #0]
     0x60010176:  lsls    r2, r7, #21
     0x60010178:  str     r1, [r0, #0]
     0x6001017a:  lsls    r6, r3, #22
     0x6001017c:  str     r1, [r0, #0]
     0x6001017e:  lsls    r6, r5, #22
  (gdb) hbreak *0x6001016e
  Hardware assisted breakpoint 2 at 0x6001016e
  (gdb) c
  Continuing.

  Breakpoint 2, 0x6001016e in ?? ()
  (gdb) i
  0x60010572 in ?? ()
  =3D> 0x60010572:  streq   pc, [r4, #-421] @ 0xfffffe5b
     0x60010576:  ldmiblt r7, {r0, r12, sp, lr, pc}^
     0x6001057a:  tsteq   r1, r1, lsl #2  @ <UNPREDICTABLE>
  (gdb) x/5i $pc
  =3D> 0x60010572:  streq   pc, [r4, #-421] @ 0xfffffe5b
     0x60010576:  ldmiblt r7, {r0, r12, sp, lr, pc}^
     0x6001057a:  tsteq   r1, r1, lsl #2  @ <UNPREDICTABLE>
     0x6001057e:  smlabteq        r0, r0, r2, pc  @ <UNPREDICTABLE>
     0x60010582:  blt     0x61da66a2
  (gdb) x/10w $pc
  0x60010572:     0x0504f1a5      0xb9d7f001      0x0101f101      0x0100f2c0
  0x60010582:     0xba765846      0x0300f2c0      0x0436bfe1      0x31024333
  0x60010592:     0x0100f2c0      0x050af1a5
  (gdb)=20

Which seems to agree with the disassembler from the console:

  (qemu) x/5i 0x60010572
  0x60010572:  0504f1a5  streq    pc, [r4, #-0x1a5]
  0x60010576:  b9d7f001  ldmiblt  r7, {r0, ip, sp, lr, pc} ^
  0x6001057a:  0101f101  mrseq    pc, apsr
  0x6001057e:  0100f2c0  smlabteq r0, r0, r2, pc
  0x60010582:  ba765846  blt      #0x61da66a2

>
> It launches by this command:
>
> "c:\Program Files\qemu\qemu-system-arm.exe" -M vexpress-a9 -serial stdio =
-m 512M -kernel speciarmlist.bin -d
> in_asm
>
>
> qemu-system-arm.exe -version
> QEMU emulator version 8.0.94 (v8.1.0-rc4-12032-g74a4cbee04)
> Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

