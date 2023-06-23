Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C924773BBA4
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCihX-0004CO-7k; Fri, 23 Jun 2023 11:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCihU-0004Bn-St
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:27:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCihS-0001GT-Nx
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:27:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-311167ba376so811275f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687534069; x=1690126069;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3bapb1uIWU8osWCQeAbH94wUdSZPNdcUv6pKH5Ucfc=;
 b=ZXByn1VO/WNsVT2oq3VvbfI3ez6LPWCXtBKL9NCBFiShfO4rKNJe2NPJFwy9uW4g8S
 +JeSXdU6ZUkoz7JZ7Dzv1ANYoYPU80r/X7lhjQfbMIdb3JWA8p9cpMFuotqoU1Y1mAB1
 CI3D7+tYxb2ClCK1/NyftDZRJG1DQMZ3bMKFTKqQCeHGHbQNjOopMm91ewTBpZ4J1DtK
 NKHYrYADzkvp2Vt3/ZzV55i2FeZoJHUl4dpTuYP4kxctzJn4H5NCKEj8OVzjTAqJNbHx
 /BKu3+2gQ82zbBi9ZljprwhPVfUy/OyQP6qazzL4wB0lJkE0xtPfHDFECPPdtKl4dLXc
 eAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687534069; x=1690126069;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N3bapb1uIWU8osWCQeAbH94wUdSZPNdcUv6pKH5Ucfc=;
 b=igZxXvjEmimFQWHMG+j++hs774tLi6E1W7h0alYwhAFiykjuXPUtQ90u2jxLNEhZow
 PX5eyb1DCyMxEDbfZC5UnqYTm9CjsKGRx6uHWm8X9vocPGyi+R08oYVQqGqmGXk+d5AN
 M+oIAd2qvIrQ6pnbGCs6hZffOAPfvlId9OxeRIhDxdU6NufDfO1QcEIcBiLVQGPj66tK
 D2wAyiV4ldvyLauRsUfb7zb8nyL1lTuE7ii+OlJeV8Qi4oC8iDRdsuK9quNYKMiar/QO
 DArXZ3TvU3eD6tP8oFNlxFtDFjirR2Zt+5H0vuhCjC3VuYNKsmT1lLlHtuBFZkkLWvtD
 lFBQ==
X-Gm-Message-State: AC+VfDwgsUynEHVX1pzoN1qYPgp6jZEqBM+mD4cTMpUgmYn9/S0sE4c/
 bfabLQlkjYVDa794PzJKjXZuDA==
X-Google-Smtp-Source: ACHHUZ4O+GWUPhd92vpS3egA9nicXF2oENYIGN1uuG7W9+98FSFlJi6G944GXaFfq46fS6zBUv0bRg==
X-Received: by 2002:adf:de8a:0:b0:30f:bc8f:6d49 with SMTP id
 w10-20020adfde8a000000b0030fbc8f6d49mr18479398wrl.13.1687534069134; 
 Fri, 23 Jun 2023 08:27:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y16-20020adfd090000000b003110dc7f408sm9763125wrh.41.2023.06.23.08.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 08:27:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 670731FFBB;
 Fri, 23 Jun 2023 16:27:48 +0100 (BST)
References: <8780abd9-59ef-c452-bfee-c3bfbf275e51@linux.vnet.ibm.com>
 <a474146f-cd1d-b91a-eefd-596a1d08f772@kaod.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Nicholas Piggin
 <npiggin@gmail.com>, harshpb@linux.ibm.com
Subject: Re: qemu-system-ppc64 option -smp 2 broken with commit
 20b6643324a79860dcdfe811ffe4a79942bca21e
Date: Fri, 23 Jun 2023 16:22:22 +0100
In-reply-to: <a474146f-cd1d-b91a-eefd-596a1d08f772@kaod.org>
Message-ID: <87y1kadwqz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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


C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Hello Anushree,
>
> On 6/23/23 13:09, Anushree Mathur wrote:
>> Hi everyone,
>> I was trying to boot rhel9.3 image with upstream qemu-system-ppc64
>> -smp 2 option and observed a segfault (qemu crash).
>> qemu command line used:
>> qemu-system-ppc64 -name Rhel9.3.ppc64le -smp 2 -m 16G -vga none
>> -nographic -machine pseries -cpu POWER10 -accel tcg -device
>> virtio-scsi-pci -drive
>> file=3D/home/rh93.qcow2,if=3Dnone,format=3Dqcow2,id=3Dhd0 -device
>> scsi-hd,drive=3Dhd0 -boot c
>> After doing a git bisect, I found the first bad commit which
>> introduced this issue is below:
>
> Could you please open a gitlab issue on QEMU project ?
>
>  https://gitlab.com/qemu-project/qemu/-/issues

Is it broken generated code that faults or does the goto_tb code break
the execution sequence in some subtle way further down the line?

If you can isolate the guest address the output from:

  -dfilter 0xBADADDR+0x100 -d in_asm,op,out_asm

would be useful for the bug report. Although conceivably the out_asm
output might make sense at translation time and then be broken when it
is patched. Having rr on power would be really useful to debug this sort
of thing.=20

>
> Thanks,
>
> C.
>
>> [qemu]# git bisect good
>> 20b6643324a79860dcdfe811ffe4a79942bca21e is the first bad commit
>> commit 20b6643324a79860dcdfe811ffe4a79942bca21e
>> Author: Richard Henderson <richard.henderson@linaro.org>
>> Date:=C2=A0=C2=A0 Mon Dec 5 17:45:02 2022 -0600
>>  =C2=A0=C2=A0=C2=A0 tcg/ppc: Reorg goto_tb implementation
>>  =C2=A0=C2=A0=C2=A0 The old ppc64 implementation replaces 2 or 4 insns, =
which
>> leaves a race
>>  =C2=A0=C2=A0=C2=A0 condition in which a thread could be stopped at a PC=
 in the middle of
>>  =C2=A0=C2=A0=C2=A0 the sequence, and when restarted does not see the co=
mplete address
>>  =C2=A0=C2=A0=C2=A0 computation and branches to nowhere.
>>  =C2=A0=C2=A0=C2=A0 The new implemetation replaces only one insn, swappi=
ng between
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <dest>
>>  =C2=A0=C2=A0=C2=A0 and
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mtct=
r=C2=A0=C2=A0 r31
>>  =C2=A0=C2=A0=C2=A0 falling through to a general-case indirect branch.
>>  =C2=A0=C2=A0=C2=A0 Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
>>  =C2=A0=C2=A0=C2=A0 Signed-off-by: Richard Henderson <richard.henderson@=
linaro.org>
>>  =C2=A0tcg/ppc/tcg-target.c.inc | 152
>> +++++++++++++----------------------------------
>>  =C2=A0tcg/ppc/tcg-target.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>  =C2=A02 files changed, 41 insertions(+), 114 deletions(-)
>> [qemu]#
>> Can someone please take a look and suggest a fix to resolve this
>> issue?
>> Thanks in advance.
>> Regards,
>> Anushree-Mathur
>>=20


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

