Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD57362FA
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 07:06:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBTYr-00035q-4M; Tue, 20 Jun 2023 01:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBTYa-00035P-GW; Tue, 20 Jun 2023 01:05:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBTYX-0001pb-VM; Tue, 20 Jun 2023 01:05:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b5452b77b4so24881915ad.3; 
 Mon, 19 Jun 2023 22:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687237528; x=1689829528;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aI+bxrj8zYTmW7OzDn6PjfWar9fX241WEO0y6wz03aY=;
 b=ZYY0Bgx50HGyeJweY7ICJR1BAqgArrQIDHNyhb9UzEPBCYw5zR2QjaDpwL1OcFPJAK
 Ejex06rd7g85ZLVCmc+8P4pGM7XcL2+A8j5Pa/GEeG+WD9VcyiITprFA4wzyFVA/Ktne
 Q2f2qBl2EygaOkCT1uJQonVQ3JWibcBo6L+I7iU9r+Ck/svfUiqVEugG0TpAbsBu976A
 UA94Qd04d2FNcXA7p9nlri5fD+ZpkkEaPKZKNoiGJkknVCt5XWcJnHNexzLF7FnscK6E
 C/JbDMFWXH6uQtVj3Tcb8gKZ0HmmL2uiUKwMHnwjXQztNvyEsLJrzs60/r1HETVmKV9T
 qR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687237528; x=1689829528;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aI+bxrj8zYTmW7OzDn6PjfWar9fX241WEO0y6wz03aY=;
 b=IRx75JOqMhbUzGDo6wTHzaRWjOjJKiOG/1OVMwX6RGUdxBPIUdf+QYJuYyR8k6Rn89
 8tidc2vJ9oejuvCPzDGu856DAYlO4NgQUS9DfQlw2DcFalIqJj2dhng3v6v335vI0R6n
 my5ib4483lBa0YqTLtyAF08uA7M6hT0Wjc4IkfNp8NGxCHsllUGTO9m3Pf+f3EGHWNOd
 ST5l+/vodeP9p9FRe5klAWrP8Ob0OcRaYKdMrU2RjKjbEmzyXzzAhQ5lYo6NgmurMIEU
 Dbs05t0bYk5fFToi2o/bBieQOiz50IZ+QjimMeLZ4ychAqnCU3z4P1dV8tcGZuXsJTk/
 S8Hg==
X-Gm-Message-State: AC+VfDygKBplcZQCC6jzNaJBiFto9RgwNnj3xHLKQIhGAMa1lXmsApaY
 +Qht7axhr1y018ISnKhpOcs=
X-Google-Smtp-Source: ACHHUZ62b2GNcBKHUgkLLJwwJjm19ggu7+TCqCQbvv6Ja8vb0DqARaS5uo8QeTL4kJh1hL9coFj7BA==
X-Received: by 2002:a17:903:258e:b0:1b1:78ba:f350 with SMTP id
 jb14-20020a170903258e00b001b178baf350mr10168571plb.46.1687237528248; 
 Mon, 19 Jun 2023 22:05:28 -0700 (PDT)
Received: from localhost ([1.146.127.111]) by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f54400b001b008b3dee2sm598276plf.287.2023.06.19.22.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 22:05:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 15:05:22 +1000
Message-Id: <CTH7S9BB9YYE.2XS3E91DZ8OKT@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH v3 10/14] target/ppc: Simplify syscall exception handlers
X-Mailer: aerc 0.14.0
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <ec260247d973fa0b60f2bb7920ed09c599ac2586.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <ec260247d973fa0b60f2bb7920ed09c599ac2586.1686868895.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Fri Jun 16, 2023 at 9:03 AM AEST, BALATON Zoltan wrote:
> After previous changes the hypercall handling in 7xx and 74xx
> exception handlers can be folded into one if statement to simpilfy
> this code.

Simplify and add unlikely?

I like to avoid slipping in improvements with cleanups. Arguably
the changelog is actually more important to describe the stuff
that isn't just rejig of code. Pretty minor in this case, but
good practice otherwise it can get out of hand.

Thanks,
Nick

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/excp_helper.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index ef363b0285..a62103b8ac 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -741,25 +741,21 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int e=
xcp)
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>      {
>          int lev =3D env->error_code;
> -
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
> +        if (unlikely(lev =3D=3D 1 && cpu->vhyp)) {
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
> @@ -885,25 +881,21 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int =
excp)
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>      {
>          int lev =3D env->error_code;
> -
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
> +        if (unlikely(lev =3D=3D 1 && cpu->vhyp)) {
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


