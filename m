Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9646872F375
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:20:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Hy7-0008RZ-5k; Wed, 14 Jun 2023 00:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9Hy0-0008RE-HN; Wed, 14 Jun 2023 00:18:49 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9Hxx-0006do-Cw; Wed, 14 Jun 2023 00:18:42 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-66665b66dbaso78404b3a.1; 
 Tue, 13 Jun 2023 21:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686716319; x=1689308319;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDEaBusD47v4tfx/dve2DMIqFnnDlEVASvWnMplBnzg=;
 b=NJYxjyH4YTrVBPwGQF6hdkhRMGPzbSrsiyJidhxbI4yILyZ2lFRmSj7V+5RU2A7JwG
 sNvS3JgOtVw43LFTg1c9OJhxY7m9uZdt0RCXcLlJ8D4QKsuJmZ8Cb61wcwFU5PH7QBd4
 /blYzY/zmqPOEEy5Tb42XhnBpzZigWUoP2tiAyTjIDYL6r3mf8NeCQZYRfM3N6/Okf8o
 ISlCDLGilBLAk/Bv081LR3923R7O1kasmmnR2rx11sER6tmM3Mvb/aUd7yQWL+fYys4o
 fs/8CTDfEOrgzuhqiMJLyN92Kpl8LKUvweyIXiV1e2ktIDPEeR32hlL93eO2yoNT0e9R
 niyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686716319; x=1689308319;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iDEaBusD47v4tfx/dve2DMIqFnnDlEVASvWnMplBnzg=;
 b=fziUiSFGTIiJyoB/lvHpibWxcKWQ8vFuP5rC3YrISKR47AwXkcrdKvWiu8GUhPl+Hs
 3JQu0EIMCL1W+ywbTt7mYAt6RK8zTEHb4sCECtjb8fW0UjGg1n0z0f4tuDJW2pIPqmwq
 4Kw3CGvG0pSxO1wBleK+VGUEqQ5TRyNHVLYbOIa36L+nxjhs82mNiON5vuJ72NUxjqYK
 grmlRH8M+iW2ahQ8xff/IGoCobueM14yIqahfUVSfaDn0/WjS6I0Z1WevkqwXiFxy3bg
 usDmhPLUUTVUpVCYKhj3XuNIdyohTj6nlfcn8S2clrgjKLc6ro4HzbSmuqaSGHCDMyN+
 QbDA==
X-Gm-Message-State: AC+VfDw1sT+a5npVDbpw45qEW4SZzK82RuPyAhsgWXH3ck7a7X54IGiU
 iDIonj0hs3NfE2gCGNSg1P0=
X-Google-Smtp-Source: ACHHUZ5MEp9qqxVU7/KI4+AXncM1bosdE+pBtKPI5dEhVL04Yv+gPzjQCXvnSRN+YRHGWKjD3GD3vQ==
X-Received: by 2002:a05:6a21:970c:b0:10c:6dbc:2806 with SMTP id
 ub12-20020a056a21970c00b0010c6dbc2806mr590116pzb.46.1686716319445; 
 Tue, 13 Jun 2023 21:18:39 -0700 (PDT)
Received: from localhost ([1.146.74.129]) by smtp.gmail.com with ESMTPSA id
 d21-20020aa78e55000000b0063d24fcc2b7sm2060992pfr.1.2023.06.13.21.18.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:18:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 14:18:33 +1000
Message-Id: <CTC3156BMOHL.1CSJOLOF48ZK5@wheely>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH 09/10] target/ppc: Simplify syscall exception handlers
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <ddb1379de4b3c20e543b37fb18fde5581191af49.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <ddb1379de4b3c20e543b37fb18fde5581191af49.1686522199.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> After previous changes the hypercall handling in 7xx and 74xx
> exception handlers can be folded into one if statement to simpilfy
> this code.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/excp_helper.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 4f6a6dfb19..089417894e 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -738,26 +738,23 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int e=
xcp)
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>      {
> -        int lev =3D env->error_code;
> +        PowerPCCPU *cpu =3D env_archcpu(env);

I prefer to keep lev. Makes sense to combine the tests though
I suppose. Although with powernv it's not really clear that we
want to dump_syscall. dump_hcall is probably better (powernv
could support a non-PAPR hypervisor with different hcall
semantics, but also it could support an OS with different
syscall semantics too). I guess that could be changed back
when necessary though.

Thanks,
Nick

> =20
> -        if (lev =3D=3D 1 && cpu->vhyp) {
> -            dump_hcall(env);
> -        } else {
> -            dump_syscall(env);
> -        }
>          /*
>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>           * instruction to communicate with QEMU. The pegasos2 machine
>           * uses VOF and the 7xx CPUs, so although the 7xx don't have
>           * HV mode, we need to keep hypercall support.
>           */
> -        if (lev =3D=3D 1 && cpu->vhyp) {
> +        if (unlikely(env->error_code =3D=3D 1 && cpu->vhyp)) {
>              PPCVirtualHypervisorClass *vhc =3D
>                  PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +            dump_hcall(env);
>              vhc->hypercall(cpu->vhyp, cpu);
>              return;
> +        } else {
> +            dump_syscall(env);
>          }
> -
>          break;
>      }
>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception=
     */
> @@ -882,26 +879,23 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int =
excp)
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>      {
> -        int lev =3D env->error_code;
> +        PowerPCCPU *cpu =3D env_archcpu(env);
> =20
> -        if (lev =3D=3D 1 && cpu->vhyp) {
> -            dump_hcall(env);
> -        } else {
> -            dump_syscall(env);
> -        }
>          /*
>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>           * instruction to communicate with QEMU. The pegasos2 machine
>           * uses VOF and the 74xx CPUs, so although the 74xx don't have
>           * HV mode, we need to keep hypercall support.
>           */
> -        if (lev =3D=3D 1 && cpu->vhyp) {
> +        if (unlikely(env->error_code =3D=3D 1 && cpu->vhyp)) {
>              PPCVirtualHypervisorClass *vhc =3D
>                  PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +            dump_hcall(env);
>              vhc->hypercall(cpu->vhyp, cpu);
>              return;
> +        } else {
> +            dump_syscall(env);
>          }
> -
>          break;
>      }
>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception=
     */
> --=20
> 2.30.9


