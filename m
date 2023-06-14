Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2033772F810
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 10:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9M28-0003rx-34; Wed, 14 Jun 2023 04:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UREO=CC=kaod.org=clg@ozlabs.org>)
 id 1q9M25-0003r8-Ee; Wed, 14 Jun 2023 04:39:13 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UREO=CC=kaod.org=clg@ozlabs.org>)
 id 1q9M23-00018S-Ax; Wed, 14 Jun 2023 04:39:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QgzNm5SKhz4x4G;
 Wed, 14 Jun 2023 18:39:04 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QgzNk5p7kz4wgq;
 Wed, 14 Jun 2023 18:39:02 +1000 (AEST)
Message-ID: <100fcfb4-9423-551f-23e1-cea23b1801b1@kaod.org>
Date: Wed, 14 Jun 2023 10:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] target/ppc: add TFMR SPR implementation with read and
 write helpers
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230603233612.125879-1-npiggin@gmail.com>
 <20230603233612.125879-4-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230603233612.125879-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=UREO=CC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.098, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/4/23 01:36, Nicholas Piggin wrote:
> TFMR is the Time Facility Management Register which is specific to POWER
> CPUs, and used for the purpose of timebase management (generally by
> firmware, not the OS).
> 
> This adds an initial simple TFMR register, which will form part of the
> core timebase facility model in the next patch.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/cpu_init.c        |  2 +-
>   target/ppc/helper.h          |  2 ++
>   target/ppc/spr_common.h      |  2 ++
>   target/ppc/timebase_helper.c | 13 +++++++++++++
>   target/ppc/translate.c       | 10 ++++++++++
>   5 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index da0f7a7159..37088021d2 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5662,7 +5662,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
>       spr_register_hv(env, SPR_TFMR, "TFMR",
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> +                 &spr_read_tfmr, &spr_write_tfmr,
>                    0x00000000);
>       spr_register_hv(env, SPR_LDBAR, "LDBAR",
>                    SPR_NOACCESS, SPR_NOACCESS,
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 16bb485c1a..166cacb3f9 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -746,6 +746,8 @@ DEF_HELPER_2(store_40x_dbcr0, void, env, tl)
>   DEF_HELPER_2(store_40x_sler, void, env, tl)
>   DEF_HELPER_FLAGS_2(store_booke_tcr, TCG_CALL_NO_RWG, void, env, tl)
>   DEF_HELPER_FLAGS_2(store_booke_tsr, TCG_CALL_NO_RWG, void, env, tl)
> +DEF_HELPER_1(load_tfmr, tl, env)
> +DEF_HELPER_2(store_tfmr, void, env, tl)
>   DEF_HELPER_3(store_ibatl, void, env, i32, tl)
>   DEF_HELPER_3(store_ibatu, void, env, i32, tl)
>   DEF_HELPER_3(store_dbatl, void, env, i32, tl)
> diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
> index d6c679cd99..8ab17123a4 100644
> --- a/target/ppc/spr_common.h
> +++ b/target/ppc/spr_common.h
> @@ -196,6 +196,8 @@ void spr_write_ebb(DisasContext *ctx, int sprn, int gprn);
>   void spr_read_ebb_upper32(DisasContext *ctx, int gprn, int sprn);
>   void spr_write_ebb_upper32(DisasContext *ctx, int sprn, int gprn);
>   void spr_write_hmer(DisasContext *ctx, int sprn, int gprn);
> +void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
> +void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
>   void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
>   void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
>   #endif
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index de1ee85e0b..34b1d5ad05 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -270,6 +270,19 @@ void helper_store_booke_tsr(CPUPPCState *env, target_ulong val)
>       store_booke_tsr(env, val);
>   }
>   
> +#if defined(TARGET_PPC64)
> +/* POWER processor Timebase Facility */
> +target_ulong helper_load_tfmr(CPUPPCState *env)
> +{
> +    return env->spr[SPR_TFMR];
> +}
> +
> +void helper_store_tfmr(CPUPPCState *env, target_ulong val)
> +{
> +    env->spr[SPR_TFMR] = val;
> +}
> +#endif
> +
>   /*****************************************************************************/
>   /* Embedded PowerPC specific helpers */
>   
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 8b312b46e0..9dcd66eac8 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1255,6 +1255,16 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
>       spr_store_dump_spr(sprn);
>   }
>   
> +void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn)
> +{
> +    gen_helper_load_tfmr(cpu_gpr[gprn], cpu_env);
> +}
> +
> +void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_store_tfmr(cpu_env, cpu_gpr[gprn]);
> +}
> +
>   void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
>   {
>       gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);


