Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D877231B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 13:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSyoH-0001Ei-P1; Mon, 07 Aug 2023 07:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qSyoE-0001Dj-S1
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 07:54:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qSyoB-0007sU-4E
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 07:54:02 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxCPJQ29BkOPsRAA--.40205S3;
 Mon, 07 Aug 2023 19:53:52 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxHCNP29BkdhdNAA--.45696S3; 
 Mon, 07 Aug 2023 19:53:51 +0800 (CST)
Subject: Re: [PATCH v3 6/6] target/loongarch: Support LoongArch32 VPPN
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn, 
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-7-c@jia.je>
From: gaosong <gaosong@loongson.cn>
Message-ID: <07898c8a-c787-f692-77dc-9c0d7b7ca2b6@loongson.cn>
Date: Mon, 7 Aug 2023 19:53:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230807094505.2030603-7-c@jia.je>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHCNP29BkdhdNAA--.45696S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGryUXr18Xw18XFWrCry7XFc_yoWrGr13pF
 yFkry8CFy8trZFy3Z3ta4Yyr43Xw1Iya4vqwsxGryavr1DWw18ZrWxurZ7tFyxAwn5ur48
 AFnay3y5CFyrArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 uc_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.809, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2023/8/7 ÏÂÎç5:45, Jiajie Chen Ð´µÀ:
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
> 

FIELD(CSR_TLBEHI_32, VPPN, 13, 19)
FIELD(CSR_TLBEHI_64, VPPN, 13, 35)

>   #define LOONGARCH_CSR_TLBELO0        0x12 /* TLB EntryLo0 */
>   #define LOONGARCH_CSR_TLBELO1        0x13 /* TLB EntryLo1 */
> @@ -164,7 +165,8 @@ FIELD(CSR_TLBRERA, PC, 2, 62)
>   #define LOONGARCH_CSR_TLBRELO1       0x8d /* TLB refill entrylo1 */
>   #define LOONGARCH_CSR_TLBREHI        0x8e /* TLB refill entryhi */
>   FIELD(CSR_TLBREHI, PS, 0, 6)
> -FIELD(CSR_TLBREHI, VPPN, 13, 35)
> +FIELD(CSR_TLBREHI_32, VPPN, 13, 35)
> +FIELD(CSR_TLBREHI_64, VPPN, 13, 19)

FIELD(CSR_TLBREHI_32, VPPN, 13, 19)
FIELD(CSR_TLBREHI_64, VPPN, 13, 35)

We should test booting a 64 bit kernel or system,
and adding a 32bit example in patch0 would be more useful.


Thanks.
Song Gao

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
> 


