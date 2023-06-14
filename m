Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E41C72F339
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 05:48:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9HUM-0002Ye-IW; Tue, 13 Jun 2023 23:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HUK-0002YL-G0; Tue, 13 Jun 2023 23:48:04 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HUI-0007va-QB; Tue, 13 Jun 2023 23:48:04 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-55b619e0ed1so230449eaf.3; 
 Tue, 13 Jun 2023 20:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686714481; x=1689306481;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyMCV1fmGcIdbhG+yaSKn2gkvgC2QRWZYKk8eDgxIlQ=;
 b=HRxBcnEjOEnghmn55LAlhavIRqVHuNTNCh+WoN097L2CT8ybNCvRpfUpomhPLmzn2n
 BRIH7SUL1vBJyMnBNhaRkg2FT4mopxjNLW2TmOOOepjjZBn37zndIWQ5hZkgNLKZtdZH
 1sYFNzSVqhuD9Y/+VwOZIr8P5fwiD81G/3ZyY62zVX+TqejdwiYe1eOAlF8rRpoOMhy9
 epSgOyUv1l/fRa1u5miITPAHMtcoPa6mrwoQWxhMxq+yrWjiBDbdqnyRXT4TROEtZugm
 /PM17RjM2+MsmfRPlLhtJSLUIuztO1ywYJsEgrQ4BLhPsmQxTksQ2ZjXteUdL0hMs5/I
 LwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686714481; x=1689306481;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eyMCV1fmGcIdbhG+yaSKn2gkvgC2QRWZYKk8eDgxIlQ=;
 b=VHYn6s7JH7+S32/GzbS4zXNJSkI76R+b2qAILNtBwAjUBCWkmU67zACPk/2u+JpkHr
 HDSML6lcK4TRGsoG+1g3HDoP8DDkLCkWVKzOfn06oDD18QMOyyYI5bXIOFheKV/vmtQG
 WfpHyFx2Q3kYRlTt7EAphfbfrnBgXTSNFEoU3IEvVJS+1g7IvHwwKc6WyQNUqfDR9iv6
 sU/WqZ/UTI8P+FDasqRxSEqtqe43B/PljYLUKGaZNbnCiuhM0cw8+Z+222QhHHEJPgdA
 6/jd32nQQzRDkAvEc2/Iht/0Mp6LugZd5gP7+RA5EbcpJ/kfyJlbpP0ZYJEZqvcv0ay/
 LeGQ==
X-Gm-Message-State: AC+VfDzW1TSU73v/aLBqrWp1FS8jpIe2rvYYXaAsrK+FVYOTBj2kdouM
 wLIlOCDB7ABzTOrhmzS5FU4=
X-Google-Smtp-Source: ACHHUZ4jpzhxDoo3oB03AsHtSbIafs++GXEEfEVDba7+RdXcIxwQBZ7MTAP9TxLkc4qlFiG8HphHtg==
X-Received: by 2002:a05:6808:1a96:b0:398:5adf:3609 with SMTP id
 bm22-20020a0568081a9600b003985adf3609mr8262517oib.44.1686714481114; 
 Tue, 13 Jun 2023 20:48:01 -0700 (PDT)
Received: from localhost ([1.146.66.73]) by smtp.gmail.com with ESMTPSA id
 t3-20020a17090b018300b0025c11d9fb76sm2246107pjs.19.2023.06.13.20.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 20:48:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 13:47:51 +1000
Message-Id: <CTC2DN50X8A2.2UVS9YQ2HNYJ9@wheely>
Subject: Re: [PATCH 08/10] target/ppc: Fix gen_sc to use correct nip
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <7ae167986e18144bc665bbdd836b49fe723a90a1.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <7ae167986e18144bc665bbdd836b49fe723a90a1.1686522199.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc34.google.com
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
> Most exceptions are raised with nip pointing to the faulting
> instruction but the sc instruction generating a syscall exception
> leaves nip pointing to next instruction. Fix gen_sc to not use
> gen_exception_err() which sets nip back but correctly set nip to
> pc_next so we don't have to patch this in the exception handlers.
>
> This changes the nip logged in dump_syscall and dump_hcall debug
> functions but now this matches how nip would be on a real CPU.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/excp_helper.c | 39 ---------------------------------------
>  target/ppc/translate.c   |  8 +++++---
>  2 files changed, 5 insertions(+), 42 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 885e479301..4f6a6dfb19 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -493,12 +493,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int ex=
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
> @@ -609,12 +603,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int ex=
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
> @@ -757,13 +745,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int ex=
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
> @@ -908,13 +889,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int e=
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
> @@ -1073,12 +1047,6 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, in=
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
> @@ -1320,13 +1288,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, in=
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

Generally for blame and bisect I don't like to mix cleanup with real
change, I guess this is pretty minor though.

Great cleanup though, sc is certainly defined to set SRR0 to the
instruction past the sc unlike other interrupts so it is more natural
and less hacky feeling do it like this.

Could you do scv while you are here? It has the same semantics as
sc.

Thanks,
Nick

