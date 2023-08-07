Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E94E771D87
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwrU-0002kH-QA; Mon, 07 Aug 2023 05:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwrA-0002Sz-9u
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:48:58 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwr7-0003YD-BE
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:48:55 -0400
Received: from [172.20.10.3] (unknown [112.97.80.95])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 8B2FF43AAE;
 Mon,  7 Aug 2023 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691401732; bh=lDLFXZpZ318btt41gZNpQD2ZmTFTU25kkXhDqzm41Uo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dd/1vmTbYUD9PTplTsCAyApGZIfDUejG4NRhMHz0OgKWagn/XPE2+SQb477ty7cZB
 USgXr7P84Yz1cF2NIFM1WkIL9dKnprFdD+YZQh7l3JCDkM8BBvgPdCyQpHG7RjeyGN
 xdaYxgxnl/zi09pKfujtm18CkAUfT8bLX+4iEMGY=
Message-ID: <4cbe7855-6d64-1b3f-a5ad-cea7f3f0aa2c@jia.je>
Date: Mon, 7 Aug 2023 17:48:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 6/6] target/loongarch: Support LoongArch32 VPPN
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn, 
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-7-c@jia.je>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <20230807094505.2030603-7-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2023/8/7 17:45, Jiajie Chen wrote:
> VPPN of TLBEHI/TLBREHI is limited to 19 bits in LA32.
>
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/cpu-csr.h    |  6 ++++--
>   target/loongarch/tlb_helper.c | 23 ++++++++++++++++++-----
>   2 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index b93f99a9ef..9501a969af 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -57,7 +57,8 @@ FIELD(CSR_TLBIDX, PS, 24, 6)
>   FIELD(CSR_TLBIDX, NE, 31, 1)
>   
>   #define LOONGARCH_CSR_TLBEHI         0x11 /* TLB EntryHi */
> -FIELD(CSR_TLBEHI, VPPN, 13, 35)
> +FIELD(CSR_TLBEHI_32, VPPN, 13, 35)
> +FIELD(CSR_TLBEHI_64, VPPN, 13, 19)
Sorry, the bit width is wrong.
>   
>   #define LOONGARCH_CSR_TLBELO0        0x12 /* TLB EntryLo0 */
>   #define LOONGARCH_CSR_TLBELO1        0x13 /* TLB EntryLo1 */
> @@ -164,7 +165,8 @@ FIELD(CSR_TLBRERA, PC, 2, 62)
>   #define LOONGARCH_CSR_TLBRELO1       0x8d /* TLB refill entrylo1 */
>   #define LOONGARCH_CSR_TLBREHI        0x8e /* TLB refill entryhi */
>   FIELD(CSR_TLBREHI, PS, 0, 6)
> -FIELD(CSR_TLBREHI, VPPN, 13, 35)
> +FIELD(CSR_TLBREHI_32, VPPN, 13, 35)
> +FIELD(CSR_TLBREHI_64, VPPN, 13, 19)
>   #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
>   FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
>   FIELD(CSR_TLBRPRMD, PIE, 2, 1)
> diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
> index cf6f5863f9..7926c40252 100644
> --- a/target/loongarch/tlb_helper.c
> +++ b/target/loongarch/tlb_helper.c
> @@ -305,8 +305,13 @@ static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
>   
>       if (tlb_error == TLBRET_NOMATCH) {
>           env->CSR_TLBRBADV = address;
> -        env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, VPPN,
> -                                      extract64(address, 13, 35));
> +        if (env->mode == LA64) {
> +            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_64,
> +                                        VPPN, extract64(address, 13, 35));
> +        } else {
> +            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_32,
> +                                        VPPN, extract64(address, 13, 19));
> +        }
>       } else {
>           if (!FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
>               env->CSR_BADV = address;
> @@ -371,12 +376,20 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
>   
>       if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
>           csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
> -        csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, VPPN);
> +        if (env->mode == LA64) {
> +            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
> +        } else {
> +            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, VPPN);
> +        }
>           lo0 = env->CSR_TLBRELO0;
>           lo1 = env->CSR_TLBRELO1;
>       } else {
>           csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
> -        csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI, VPPN);
> +        if (env->mode == LA64) {
> +            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
> +        } else {
> +            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
> +        }
>           lo0 = env->CSR_TLBELO0;
>           lo1 = env->CSR_TLBELO1;
>       }
> @@ -496,7 +509,7 @@ void helper_tlbfill(CPULoongArchState *env)
>   
>       if (pagesize == stlb_ps) {
>           /* Only write into STLB bits [47:13] */
> -        address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_VPPN_SHIFT);
> +        address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
>   
>           /* Choose one set ramdomly */
>           set = get_random_tlb(0, 7);

