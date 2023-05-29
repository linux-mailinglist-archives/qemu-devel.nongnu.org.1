Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A271425C
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 05:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3TmK-0002FM-Eg; Sun, 28 May 2023 23:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3TmH-0002Ej-GM; Sun, 28 May 2023 23:42:37 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3TmF-00039g-Ps; Sun, 28 May 2023 23:42:37 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b038064d97so5399875ad.0; 
 Sun, 28 May 2023 20:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685331754; x=1687923754;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FJjlN4l8ctSQQ9/9iOMpfcxG+GApuiHmudbxDNihBo=;
 b=sKJQ6tfQw0S2b61y3DETapSxab1zglhm6VxCVSXQ1iGOPCR+PphGJnc++oLIrH2oWc
 iWz+1Ir7esKauxZEeZGqjIWEhFmoqHEe4fXjQrXscvSL4E16OqpqKMefBtsIB2OWMT3u
 bA57Lq/BYuVnwKkr5oySy1MIhETJbsFhUAJC8Rnh9nPUX93mLJ92Xj3qAY7+qUj78LvN
 WuwOeX4mUXF4X5KAJm85C+v5riEs2PvEfnzsM6B6OAXxQ/3KJ5Sj6pYbSPCtqdlQi1bD
 APQjXYF2j1YnK9nujVI+bdzzTgKQF9WxoSD0v+OFHg4Y7gb5HTWMJx5bhCokuN2SU8N1
 TZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685331754; x=1687923754;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4FJjlN4l8ctSQQ9/9iOMpfcxG+GApuiHmudbxDNihBo=;
 b=bys6VQCT1X0+sMBX07V9OEx68wd/CRPrBFXnc233ADAtLuYNmxYGqv4l7IwcZ2yMh0
 LcTbIGV/jowQLhKJVVN/uLCkLaS2mPDpqBBPPJEzuAopfXwgGwWxr/17P6YiBz/BiPSk
 R2ljBguVS6AjSwOYU4C5A4lJLJd/1O9C8uDcQhXMUpKKl0SxPNK+1NdhzZIXGpNGoV6/
 4QvrkVg6qN3D6ieeXii5kbdMVK+gfqGlC+6sw/RTYBIcMcFXqBxlmSc2BtbMYtW8QSKG
 BI1T8VkhQ1WSeaSn0VdKvxLa9UNwopQpyUyIPyN+vy1du4wMXUZieVFzL27EXhF5tecn
 iMtQ==
X-Gm-Message-State: AC+VfDywoTXe0oKkZFlQvBwoLtlAJWFl9RH4kd5qpN3MV19KQAimt+17
 2cB6c0NRy7Blwk2GtBcFzvA=
X-Google-Smtp-Source: ACHHUZ4VIlpjJ5N8aJKpAjFqAHgyXC6iwuOyrYxYF+80hFlhqsA32UI9XVSybpGUpZS/KKa/8TV+wQ==
X-Received: by 2002:a17:902:e744:b0:1ac:86b5:70d9 with SMTP id
 p4-20020a170902e74400b001ac86b570d9mr6938780plf.32.1685331754131; 
 Sun, 28 May 2023 20:42:34 -0700 (PDT)
Received: from localhost ([203.221.142.9]) by smtp.gmail.com with ESMTPSA id
 s17-20020a170902989100b001a245b49731sm3272203plp.128.2023.05.28.20.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 20:42:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 May 2023 13:42:26 +1000
Message-Id: <CSYG8RTMAB5O.2H9DDPSRE7JR0@wheely>
Subject: Re: [PATCH v3] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>, <danielhb413@gmail.com>,
 <clg@kaod.org>, <david@gibson.dropbear.id.au>, <groug@kaod.org>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <farosas@suse.de>,
 <npiggin@linux.ibm.com>, <vaibhav@linux.ibm.com>, <harshpb@linux.ibm.com>,
 <sbhat@linux.ibm.com>
X-Mailer: aerc 0.14.0
References: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
In-Reply-To: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

Oh, and now I see it cpu_get_dump_info just picks the first CPU to test
this! So a test that can change at runtime is surely not the right one.
If you use MSR[HV] then if you have a SMP machine that is doing a bunch
of things and you want to dump to debug the system, this will just
randomly give you a wrong-endian dump if CPU0 just happened to be
running some KVM guest.

I know HILE techically does change at runtime, but at least in practice
it is just boot (and maybe kexec or reboot) so that is the least worst
option. Part of the problem is perhaps the tools and commands aren't so
so suited to ppc's bi-endian nature.

But even ignoring all of that, let's say you have all the same endian
host and guest kernels and dump format... If you dump host memory then
you need host kernel and structures to debug guest kernel/image
(assuming crash or the person debugging it is smart enough to make sense
of it). So I don't see how you can sanely use the crash dump of host
memory with the guest kernel. I must still be missing something.

Thanks,
Nick


