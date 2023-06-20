Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA873627D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 06:05:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBSaU-0008K1-Hm; Tue, 20 Jun 2023 00:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBSaS-0008Jo-Rd; Tue, 20 Jun 2023 00:03:25 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBSaQ-0004P7-QX; Tue, 20 Jun 2023 00:03:24 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-55e11f94817so2386915eaf.2; 
 Mon, 19 Jun 2023 21:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687233801; x=1689825801;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RiAMFiLZkGxqMC9I4/gm91Qe7ZrOinCfJdtNNLoGkKE=;
 b=d+WYZmK1laN3k1FM+xZ4Ofp1jpdd6+tZQlZvCLrBzEiikhKuL+TQWYrcgN0BLyxjmF
 /cYWAA7q26ZQcjuxQzp166SOmPgz8znLFtgiA92qe6oMwgBoxj1LUycuWAGHD9JV2cp+
 KCUOv7hEfY7K/EY8Ys+DT0aXyRvlov7dkTVqd4Kfi1Zg78ed/0wcgbdYUsryxDKsTXpo
 tHfnbt8Bzn/eBeaRY9J6e8RwVY6WNyZIED1UNTzHz4R7RkckYE7Mfrp2p5HfKhTz23fh
 WxAoBayWNxxPGs8HmgBGonXkTJ3aQeQkVPApQyaWJpdGuhUK/oNGYi5JoJs8EYuu21p5
 yS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687233801; x=1689825801;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RiAMFiLZkGxqMC9I4/gm91Qe7ZrOinCfJdtNNLoGkKE=;
 b=in5IzCc8PfxnmJpmtWPppO1uAtQ2nTnV2IpJoGp/sTUfDTC6xTnN1+A6N4bzYAKYrt
 nmfZRsQqL6lW/e9Ya/DPE23KPoOC4/vEwV/ecXqihVr4I1V4KnEsGbJzWlC5MVl4KI9v
 inkLX5oU3Cg1+z3KArEYmCtgUs4zWpEGL2QKeRLYW0ZZVLrray2YeO/xjPTcV1ATEVQd
 RsaMSLKCpIRe8yScu2AasScy4SDL/qG4j9M1I7BrJYG4RMAdfmdhUTOU4wwYQkDLXIdE
 AYxiMp8/Jk+uH5V/zilanqpCvS3vvNTGjFrh7awaluYqTOI7WbBfuC+sEty5f74TWKuk
 sCJg==
X-Gm-Message-State: AC+VfDysxVdK8mV/EOgQrOCoXBmEVSfc0F+8ZEqwClr7I1QQmhKxuIm1
 WTt9hyzi1JcoGtsURG81aBg=
X-Google-Smtp-Source: ACHHUZ58T5cClk3PXDh8EEK2fxL6K2r9hy697qpIf4TkmozG74k2op9soTFh4u4ybcr+sNiac8fwYA==
X-Received: by 2002:a05:6808:1302:b0:39e:b7aa:9fc8 with SMTP id
 y2-20020a056808130200b0039eb7aa9fc8mr8589732oiv.33.1687233801169; 
 Mon, 19 Jun 2023 21:03:21 -0700 (PDT)
Received: from localhost ([1.146.65.59]) by smtp.gmail.com with ESMTPSA id
 u8-20020a17090a0c4800b0025bc49aa716sm561117pje.27.2023.06.19.21.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 21:03:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 14:03:04 +1000
Message-Id: <CTH6GK21KYBI.1IP2B72YOI8WR@wheely>
Subject: Re: [PATCH v3 08/14] target/ppc: Fix gen_sc to use correct nip
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
X-Mailer: aerc 0.14.0
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <e38e606e937e7b6dfc679c881c762c7037b325a4.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <e38e606e937e7b6dfc679c881c762c7037b325a4.1686868895.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc36.google.com
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
> Most exceptions are raised with nip pointing to the faulting
> instruction but the sc instruction generating a syscall exception
> leaves nip pointing to next instruction. Fix gen_sc to not use
> gen_exception_err() which sets nip back but correctly set nip to
> pc_next so we don't have to patch this in the exception handlers.
>
> This changes the nip logged in dump_syscall and dump_hcall debug
> functions but now this matches how nip would be on a real CPU.

I think this is okay. I'll just send a possible scv change after
this goes in.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/excp_helper.c | 39 ---------------------------------------
>  target/ppc/translate.c   |  8 +++++---
>  2 files changed, 5 insertions(+), 42 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index f19a0f2d1d..903216c2a6 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -495,12 +495,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int ex=
cp)
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>          dump_syscall(env);
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
>          break;
>      case POWERPC_EXCP_FIT:       /* Fixed-interval timer interrupt      =
     */
>          trace_ppc_excp_print("FIT");
> @@ -611,12 +605,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int ex=
cp)
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>          dump_syscall(env);
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
>          break;
>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception=
     */
>      case POWERPC_EXCP_DECR:      /* Decrementer exception               =
     */
> @@ -759,13 +747,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int ex=
cp)
>          } else {
>              dump_syscall(env);
>          }
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
> -
>          /*
>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>           * instruction to communicate with QEMU. The pegasos2 machine
> @@ -910,13 +891,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int e=
xcp)
>          } else {
>              dump_syscall(env);
>          }
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
> -
>          /*
>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>           * instruction to communicate with QEMU. The pegasos2 machine
> @@ -1075,12 +1049,6 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, in=
t excp)
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>          dump_syscall(env);
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
>          break;
>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception=
     */
>      case POWERPC_EXCP_APU:       /* Auxiliary processor unavailable     =
     */
> @@ -1322,13 +1290,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, in=
t excp)
>          } else {
>              dump_syscall(env);
>          }
> -
> -        /*
> -         * We need to correct the NIP which in this case is supposed
> -         * to point to the next instruction
> -         */
> -        env->nip +=3D 4;
> -
>          /* "PAPR mode" built-in hypercall emulation */
>          if (lev =3D=3D 1 && books_vhyp_handles_hcall(cpu)) {
>              PPCVirtualHypervisorClass *vhc =3D
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index a32a9b8a5f..4260d3d66f 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4419,10 +4419,12 @@ static void gen_hrfid(DisasContext *ctx)
>  #endif
>  static void gen_sc(DisasContext *ctx)
>  {
> -    uint32_t lev;
> +    uint32_t lev =3D (ctx->opcode >> 5) & 0x7F;
> =20
> -    lev =3D (ctx->opcode >> 5) & 0x7F;
> -    gen_exception_err(ctx, POWERPC_SYSCALL, lev);
> +    gen_update_nip(ctx, ctx->base.pc_next);
> +    gen_helper_raise_exception_err(cpu_env, tcg_constant_i32(POWERPC_SYS=
CALL),
> +                                   tcg_constant_i32(lev));
> +    ctx->base.is_jmp =3D DISAS_NORETURN;
>  }
> =20
>  #if defined(TARGET_PPC64)
> --=20
> 2.30.9


