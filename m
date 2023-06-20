Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 137F673628E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 06:10:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBSgq-00011q-Tq; Tue, 20 Jun 2023 00:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBSgl-00010y-Ln; Tue, 20 Jun 2023 00:09:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBSgh-0005nK-IP; Tue, 20 Jun 2023 00:09:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b50e309602so34589445ad.0; 
 Mon, 19 Jun 2023 21:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687234189; x=1689826189;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtsWcmqe3j4iH9XqjJS8YvFc0XOOI2h0YsQm/ZJM/OA=;
 b=ludQijCh7kPD+Ojh4dCdqp2NlmR8mlXX640L+g45eDLvtJOcArtGZU6z234IsnvIgx
 g0KpBIX60oEnrMfRnW2o4m5kOCJwKbGnQouE1FUdwX5xmpR0623kCHJa5WXaYmXdwu04
 KLyS8DQsrVagi08K69jsIT83wlsvoyg0F/dpnIu+PLr59QyN940vH2kj34ucKS7nzOGw
 9HrNxZZp+iwhGy8vBDvNxPLIWfxCgLzDo/3CTYY10zIrfP/X2v2Jcr/mP6T69vZeGZRI
 vELcMnw4K9oOvxWd/EdHy4iPXhfcHomWrK196Eyv+KZR6r6x1U7+scKuHDfT9IqHP2eq
 vd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687234189; x=1689826189;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vtsWcmqe3j4iH9XqjJS8YvFc0XOOI2h0YsQm/ZJM/OA=;
 b=Az9AC48C/VFXyBEjYM6GO58RM+k+lv+NNeEsQ2H3yrh6KYqY0aKWo6FOpHJGwnWwSf
 k09vK1TcP2ukuWeEOFz5RqU5x9NjbU38qmuKvzRR6R2DweuDlvYi8wK1AiN0wS6Y66Eb
 nXKR9liCXemFt06HxtYZBz6IqBubfaaz4MeDiYicNmmCsfJdKeDRcUaIDqydj8HFZGaG
 YQzb9D9REK5d3ge9gaaPGogvnSPN0ij64ur3IWrTRGqO4Uje0wxJTbPpIAYAwL92uta/
 h6MOaCDu1pj7O4LKYd0DlPybj1kPjtinpBmDLRio6VOVwO/YPSyT87iYiFKPGFj8GuUv
 aCWQ==
X-Gm-Message-State: AC+VfDw2Ce92LkHrL5NuOYKi1HcrwRVDUgQZlWc13OGc0HuA9OeIqRmv
 IfwcSE2dP6atl12iDJUngo4=
X-Google-Smtp-Source: ACHHUZ5Pct4FBjO9JziHOXM0oZ1LEXe5aGt9O/LX9meqJFniePQVwGjkUBqSH6CCD3TlwwuvhV8D5g==
X-Received: by 2002:a17:903:1108:b0:1b0:2d08:eb51 with SMTP id
 n8-20020a170903110800b001b02d08eb51mr14985573plh.12.1687234189574; 
 Mon, 19 Jun 2023 21:09:49 -0700 (PDT)
Received: from localhost ([1.146.65.59]) by smtp.gmail.com with ESMTPSA id
 l4-20020a17090270c400b001ab39cd875csm539242plt.133.2023.06.19.21.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 21:09:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 14:09:42 +1000
Message-Id: <CTH6LN434MCH.2IK0QCFPCBW6F@wheely>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH v3 09/14] target/ppc: Move patching nip from exception
 handler to helper_scv
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <b7317331ebccb0209fd0b12687945af6f626b0eb.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <b7317331ebccb0209fd0b12687945af6f626b0eb.1686868895.git.balaton@eik.bme.hu>
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

On Fri Jun 16, 2023 at 9:03 AM AEST, BALATON Zoltan wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
>
> Unlike sc, for scv a facility unavailable interrupt must be generated
> if FSCR[SCV]=3D0 so we can't raise the exception with nip set to next
> instruction but we can move advancing nip if the FSCR check passes to
> helper_scv so the exception handler does not need to change it.
>
> [balaton: added commit message]
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Ah you sent it, fine, thank you. But actually now I look again,
now we're off by one in the other direction for the dumps.

So... probably your way is still better because it matches the
interrupt semantics of the ISA when executing the instruction,
but it needs this patch:

For my patch you can add

Signed-off-by: Nicholas Piggin <npiggin@gmail.com

Thanks,
Nick


diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0e21cb4451..d7f42639c8 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -117,7 +117,7 @@ static void dump_syscall(CPUPPCState *env)
                   ppc_dump_gpr(env, 0), ppc_dump_gpr(env, 3),
                   ppc_dump_gpr(env, 4), ppc_dump_gpr(env, 5),
                   ppc_dump_gpr(env, 6), ppc_dump_gpr(env, 7),
-                  ppc_dump_gpr(env, 8), env->nip);
+                  ppc_dump_gpr(env, 8), env->nip - 4);
 }

 static void dump_hcall(CPUPPCState *env)
@@ -132,7 +132,7 @@ static void dump_hcall(CPUPPCState *env)
                   ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
                   ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
                   ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
-                  env->nip);
+                  env->nip - 4);
 }

 #ifdef CONFIG_TCG



> ---
> This needs SoB from Nick
>
>  target/ppc/excp_helper.c | 2 +-
>  target/ppc/translate.c   | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 903216c2a6..ef363b0285 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1304,7 +1304,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int=
 excp)
>      case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                =
     */
>          lev =3D env->error_code;
>          dump_syscall(env);
> -        env->nip +=3D 4;
>          new_msr |=3D env->msr & ((target_ulong)1 << MSR_EE);
>          new_msr |=3D env->msr & ((target_ulong)1 << MSR_RI);
> =20
> @@ -2410,6 +2409,7 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
>  void helper_scv(CPUPPCState *env, uint32_t lev)
>  {
>      if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
> +        env->nip +=3D 4;
>          raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
>      } else {
>          raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4260d3d66f..0360a17fb3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4433,7 +4433,11 @@ static void gen_scv(DisasContext *ctx)
>  {
>      uint32_t lev =3D (ctx->opcode >> 5) & 0x7F;
> =20
> -    /* Set the PC back to the faulting instruction. */
> +    /*
> +     * Set the PC back to the scv instruction (unlike sc), because a fac=
ility
> +     * unavailable interrupt must be generated if FSCR[SCV]=3D0. The hel=
per
> +     * advances nip if the FSCR check passes.
> +     */
>      gen_update_nip(ctx, ctx->cia);
>      gen_helper_scv(cpu_env, tcg_constant_i32(lev));
> =20
> --=20
> 2.30.9


