Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6007D5742
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJqj-0003BV-H5; Tue, 24 Oct 2023 12:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1qvJqc-0002rf-BB
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:01:41 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1qvJqa-0003uO-2P
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:01:37 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id A7B37A0112; Tue, 24 Oct 2023 17:52:28 +0200 (CEST)
Date: Tue, 24 Oct 2023 17:52:28 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 4/8] target/ppc: Move patching nip from exception
 handler to helper_scv
In-Reply-To: <de324de29469374ca87b3e5f9b6a9aaf61ea5f2b.1698158152.git.balaton@eik.bme.hu>
Message-ID: <alpine.LMD.2.03.2310241751310.1739@eik.bme.hu>
References: <cover.1698158152.git.balaton@eik.bme.hu>
 <de324de29469374ca87b3e5f9b6a9aaf61ea5f2b.1698158152.git.balaton@eik.bme.hu>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: none client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 24 Oct 2023, Nicholas Piggin wrote:

Oops, this should have had a From: line here but it was your patch, sorry 
about the wrong headers.

Reagrds,
BALATON Zoltan

> Unlike sc, for scv a facility unavailable interrupt must be generated
> if FSCR[SCV]=0 so we can't raise the exception with nip set to next
> instruction but we can move advancing nip if the FSCR check passes to
> helper_scv so the exception handler does not need to change it.
>
> [balaton: added commit message]
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> target/ppc/excp_helper.c | 2 +-
> target/ppc/translate.c   | 6 +++++-
> 2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 22361b6c17..dd08efe4f2 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1405,7 +1405,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>     case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                     */
>         lev = env->error_code;
>         dump_syscall(env);
> -        env->nip += 4;
>         new_msr |= env->msr & ((target_ulong)1 << MSR_EE);
>         new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
>
> @@ -2528,6 +2527,7 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
> void helper_scv(CPUPPCState *env, uint32_t lev)
> {
>     if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
> +        env->nip += 4;
>         raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
>     } else {
>         raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index a80d24143e..d8cd34721c 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4554,7 +4554,11 @@ static void gen_scv(DisasContext *ctx)
> {
>     uint32_t lev = (ctx->opcode >> 5) & 0x7F;
>
> -    /* Set the PC back to the faulting instruction. */
> +    /*
> +     * Set the PC back to the scv instruction (unlike sc), because a facility
> +     * unavailable interrupt must be generated if FSCR[SCV]=0. The helper
> +     * advances nip if the FSCR check passes.
> +     */
>     gen_update_nip(ctx, ctx->cia);
>     gen_helper_scv(tcg_env, tcg_constant_i32(lev));
>
> -- 
> 2.30.9
>
>
>

