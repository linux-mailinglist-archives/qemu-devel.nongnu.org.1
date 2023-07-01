Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BC574487A
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:27:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXoL-0001xG-K6; Sat, 01 Jul 2023 06:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qFXoI-0001ww-BI; Sat, 01 Jul 2023 06:26:34 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qFXoG-0004Xl-MJ; Sat, 01 Jul 2023 06:26:34 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6b71ee710edso2420574a34.2; 
 Sat, 01 Jul 2023 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688207191; x=1690799191;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbGMm5bPF8+Vir4MEnRbwMqq2h86ALmnibsZEyfCwjI=;
 b=b8AHUJiiq71eczF4HCPeRDoiB1tTBL0dI9B8bZ4beuDD9cDo7uxpJAPA9wXrG64tos
 JJLcU1bMw7zNbW+AsZTBcaPvlnPFNxEagMaG2o6qxFSvyODdCsz8ebAnNrgAx69bHIOi
 +FCc50b8aGcsouPWGGHw9+6lk8l7LZl1JyUz48W3tV34X4fR1W/mdY1UoSFAhIt0Xdye
 irmEZ3inr2BUk5fehKJMZK2ckDydH7XrHCgm4ZXLPyyLaFyF0+YdjW0QmEtfs4O/MCne
 tc+oRQFHceHMosVdK8m98DjinPy9E4UlYyBaePhFPbrJzCVP6A9maeFtXgXuH+Oz0kKl
 gjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688207191; x=1690799191;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SbGMm5bPF8+Vir4MEnRbwMqq2h86ALmnibsZEyfCwjI=;
 b=ZO1V6TqDMyw5zrC+cjTMEjyNrLmBA4nJvYWm96VC2c81x5Zq+88W0MVw8wIMVWA0Y/
 CxzXUyK4PXlYrxh+C17YJ/QiLmy9C9ASqY4TzdQPtBQA3UoAGqk7WG7/yhz7FIurtNwo
 Hnnl6G76bnmOd0XWiBv5l161mz9jUcpxhbmMvHJtPWuJC0Tu6r3MRiCwoDwrpTlcIgoL
 AfXqnT6QaZcgMg9UUdY5jtpI6DvLPg5aTVqLb+0myq7XY6QT8wP+fKIX4+B12ZnwDkIL
 RglxSrIKt2wuHk5imFpT1lkL42k4S454uwn1hYHb8GRXT8cMZio0umuDq/kAqoPzcMXe
 lmVw==
X-Gm-Message-State: ABy/qLZA7FHZBsSj+WQ989m8GNBQfhEBJSkN1uAwmFBvpkkzEVyqq0pR
 EiRbxtQeWrdWbmgxAhU6hEE=
X-Google-Smtp-Source: APBJJlF1mq+wdDQbCZGJsAGDKkKaZhVItP/LzDrunXK1IZ5m/YfaZdvlGbM0XWWccqMZSog4spYZoQ==
X-Received: by 2002:a05:6358:7059:b0:134:c984:ab85 with SMTP id
 25-20020a056358705900b00134c984ab85mr3878086rwp.2.1688207190687; 
 Sat, 01 Jul 2023 03:26:30 -0700 (PDT)
Received: from localhost (220-244-154-206.tpgi.com.au. [220.244.154.206])
 by smtp.gmail.com with ESMTPSA id
 y1-20020a1709027c8100b001b025aba9edsm6781977pll.220.2023.07.01.03.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 03:26:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Jul 2023 20:26:22 +1000
Message-Id: <CTQRI13GTLA2.NWLI671Q3DJ3@wheely>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <farosas@suse.de>,
 <npiggin@linux.ibm.com>, <vaibhav@linux.ibm.com>, <harshpb@linux.ibm.com>,
 <sbhat@linux.ibm.com>
Subject: Re: [PATCH v4] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>, <danielhb413@gmail.com>,
 <clg@kaod.org>, <david@gibson.dropbear.id.au>, <groug@kaod.org>
X-Mailer: aerc 0.15.2
References: <20230623072506.34713-1-nnmlinux@linux.ibm.com>
In-Reply-To: <20230623072506.34713-1-nnmlinux@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x332.google.com
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

On Fri Jun 23, 2023 at 5:25 PM AEST, Narayana Murty N wrote:
> Currently on PPC64 qemu always dumps the guest memory in
> Big Endian (BE) format even though the guest running in Little Endian
> (LE) mode. So crash tool fails to load the dump as illustrated below:
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
> Host-Endianess Qemu-Target-Machine                Qemu-Generated-Guest
>                                                   Memory-Dump-Format
> BE             powernv(OPAL/PowerNV)                   LE
> BE             powernv(OPAL/PowerNV)                   BE
> LE             powernv(OPAL/PowerNV)                   LE
> LE             powernv(OPAL/PowerNV)                   BE
> LE             pseries(OPAL/PowerNV/pSeries) KVMHV     LE
> LE             pseries TCG                             LE
>
> Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv =
memory
> dumps")
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>

Did I forget to send RB? It looks good to me now, thanks for clearing
up my confusion.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

> ---
> Changes since V3:
> commit message modified as per feedback from Greg Kurz, C=C3=A9dric Le
> Goater and Nicholas Piggin.
> Changes since V2:
> commit message modified as per feedback from Nicholas Piggin.
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


