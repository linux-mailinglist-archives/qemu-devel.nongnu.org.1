Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80B714244
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 05:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3TPv-0007uA-LF; Sun, 28 May 2023 23:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3TPt-0007td-IG; Sun, 28 May 2023 23:19:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3TPr-0004FD-Me; Sun, 28 May 2023 23:19:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b038064d97so5304305ad.0; 
 Sun, 28 May 2023 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685330366; x=1687922366;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7vosFpkRZZZVEJdyGzfbjJe7lYI19grZ1pEYfGgbPU=;
 b=gCNTHnCk95CbcunWhQ2Zm8sU8wx9kXdu2b9l0zlEzIh2VQy4aZZDRODgQBIhKtdGRb
 86jc3MeAQ9TYFQwV/oZTTx9MnXuw4YioJL147Bpn37EveswPkaIlcKs7sXdXgH8x0w3m
 DK1+2aJSdHZDCdfsWiCYUZw47KL3keW3KqQy4KKR6u8h3V3Z6EjTVF2nWELpzoyXHZYG
 5fVQpaq6liul8xRGO8nyOnq6OD25OP4SJEL86wk2FGkcUGQ21TZxI8F1T5f58J3tZS+Y
 xwmDfZYitwl/LdwT/NCdEytyycxDjCMOPr625yo0idNt4s0vO69n5vT6DEg3VusE+fJ8
 E/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685330366; x=1687922366;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h7vosFpkRZZZVEJdyGzfbjJe7lYI19grZ1pEYfGgbPU=;
 b=VD9XgXJl2yDGNe3M2Wo1uE1AIgbkU576onI5qsWP1i4C9ebnmjzXMFEpETkePIPaDP
 s+QBhFXrQ6Dr67H1pfgTybWaf49JPmAClLgTqNNfs88yMFWM/jICd4kA0zf8qSKDKWy0
 PYzxeSw3GFpPLM5x4nt7ev0Gqpyt3/crqaJucMrRj908Ihwl2OrsETxsgbN4/UtUa+d7
 8f7uV/W8UX92o5WTVwu22dwFDqrvf6R2JG0Ovwu3qwy4wWOMOT9ZfHC5Qmiz32hNSgx9
 /pTfbuPWqQG+UT/+dTruPZuu0P8YGsFs7kQBnLVKyeG8Aa81j5PGR6M+aa893UCYICE2
 VYng==
X-Gm-Message-State: AC+VfDxU0JUs8dKPLqw8HZ71KKBwcecU77/jggYHrsoGa9wu9HPUckLJ
 n4/1D64YjSaz9bBktUw/AN8=
X-Google-Smtp-Source: ACHHUZ6pmij6fviPNVCxWUPOVBWQWyiCnP63C1lLvGrc6ljrDe8Rx70I+gs2MEzQT1/WSdDo1Td59A==
X-Received: by 2002:a17:902:da84:b0:1ac:92db:9677 with SMTP id
 j4-20020a170902da8400b001ac92db9677mr6986736plx.28.1685330365759; 
 Sun, 28 May 2023 20:19:25 -0700 (PDT)
Received: from localhost ([203.221.142.9]) by smtp.gmail.com with ESMTPSA id
 x1-20020a170902820100b001a5260a6e6csm6950153pln.206.2023.05.28.20.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 20:19:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 May 2023 13:19:16 +1000
Message-Id: <CSYFR1KH5WRY.1DE47N1LKXVJ8@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>, <danielhb413@gmail.com>,
 <clg@kaod.org>, <david@gibson.dropbear.id.au>, <groug@kaod.org>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <farosas@suse.de>,
 <npiggin@linux.ibm.com>, <vaibhav@linux.ibm.com>, <harshpb@linux.ibm.com>,
 <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
X-Mailer: aerc 0.14.0
References: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
In-Reply-To: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue May 23, 2023 at 2:02 AM AEST, Narayana Murty N wrote:
> Currently on PPC64 qemu always dumps the guest memory in
> Big Endian (BE) format even though the guest running in Little Endian
> (LE) mode.

The guest? Are you talking about the immediate target, or a
KVM guest running under that? Or both?

> So crash tool fails to load the dump as illustrated below:
>
> Log :
> $ virsh dump DOMAIN --memory-only dump.file
>
> Domain 'DOMAIN' dumped to dump.file
>
> $ crash vmlinux dump.file
>
> <snip>
> crash 8.0.2-1.el9
>
> WARNING: endian mismatch:
>           crash utility: little-endian
>           dump.file: big-endian
>
> WARNING: machine type mismatch:
>           crash utility: PPC64
>           dump.file: (unknown)
>
> crash: dump.file: not a supported file format
> <snip>
>
> This happens because cpu_get_dump_info() passes cpu->env->has_hv_mode
> to function ppc_interrupts_little_endian(), the cpu->env->has_hv_mode
> always set for powerNV even though the guest is not running in hv mode.
> The hv mode should be taken from msr_mask MSR_HVB bit
> (cpu->env.msr_mask & MSR_HVB). This patch fixes the issue by passing
> MSR_HVB value to ppc_interrupts_little_endian() in order to determine
> the guest endianness.
>
> The crash tool also expects guest kernel endianness should match the
> endianness of the dump.
>
> The patch was tested on POWER9 box booted with Linux as host in
> following cases:
>
> Host-Endianess Qemu-Target-Machine Qemu-Guest-Endianess  Qemu-Generated-G=
uest
>                                                           Memory-Dump-For=
mat
> BE             powernv             LE KVM guest                 LE
> BE             powernv             BE KVM guest                 BE
> LE             powernv             LE KVM guest                 LE
> LE             powernv             BE KVM guest                 BE
> LE             pseries KVM         LE KVM guest                 LE
> LE             pseries TCG         LE guest                     LE

I'm still having a bit of trouble with this like the others.

First thing first, take "guest" out of it entirely. If I read it right,
then the dump will be done in whichever endian the OS running on the
machine has set the interrupt endian mode to, and crash expects that to
match the vmlinux. Is that correct?

For the powernv machine, when the OS runs a KVM guest, the crash dump
continues to be generated in the same endianness even if the guest OS is
the opposite.

If my understanding is correct, I don't see why that is desirable to
change it to the arbitrary guest setting. The OS running on the target
is the one you want to debug if you dump from the first QEMU. If you
want to debug the guest you would dump from the QEMU running in the
target that is running the guest, no?

For the pseries machine, the TCG nested HV thing probably takes over
LPCR when running the nested HV guest. I would argue that's wrong and it
should actually match powernv behaviour.

Thanks,
Nick

>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
> Changes since V2:
> commit message modified as per feedbak from Nicholas Piggin.
> Changes since V1:
> https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.=
ibm.com/
> The approach to solve the issue was changed based on feedback from
> Fabiano Rosas on patch V1.
> ---
>  target/ppc/arch_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index f58e6359d5..a8315659d9 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>      info->d_machine =3D PPC_ELF_MACHINE;
>      info->d_class =3D ELFCLASS;
> =20
> -    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
> +    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_HVB=
))) {
>          info->d_endian =3D ELFDATA2LSB;
>      } else {
>          info->d_endian =3D ELFDATA2MSB;
> --=20
> 2.39.2


