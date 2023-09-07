Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F03797235
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:14:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDt2-0002mJ-CX; Thu, 07 Sep 2023 08:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeDsr-0002jT-8K
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:13:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeDsk-0001EJ-0E
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:13:16 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxLOtTvvlk+V0hAA--.61070S3;
 Thu, 07 Sep 2023 20:13:07 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxzM5SvvlkoKNwAA--.7403S3; 
 Thu, 07 Sep 2023 20:13:06 +0800 (CST)
Subject: Re: [PATCH 2/2] target/arm: Use tcg_gen_gvec_cmpi for compare vs 0
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230831030904.1194667-1-richard.henderson@linaro.org>
 <20230831030904.1194667-3-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <6bfa3740-fd68-b1da-5312-80237f264689@loongson.cn>
Date: Thu, 7 Sep 2023 20:13:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230831030904.1194667-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxzM5SvvlkoKNwAA--.7403S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw1ruF18Aw45JrWDZF18Zwc_yoW5Xr4fpr
 1agw4xtrWxtayrAa4j9F1UuFnrWF1vy3yY9wn2qrs3Zrs8Zrn8ZF1DJryvkrWjgFZ7ZFWj
 ya4Skr1Y9F4kXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwMKu
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
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

ÔÚ 2023/8/31 ÉÏÎç11:09, Richard Henderson Ð´µÀ:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.c | 56 ++++++--------------------------------
>   1 file changed, 9 insertions(+), 47 deletions(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 38ad8dd4bd..89a7392ed3 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao

> @@ -2943,54 +2943,16 @@ void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>       gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
>   }
>   
> -#define GEN_CMP0(NAME, COND)                                            \
> -    static void gen_##NAME##0_i32(TCGv_i32 d, TCGv_i32 a)               \
> -    {                                                                   \
> -        tcg_gen_negsetcond_i32(COND, d, a, tcg_constant_i32(0));        \
> -    }                                                                   \
> -    static void gen_##NAME##0_i64(TCGv_i64 d, TCGv_i64 a)               \
> -    {                                                                   \
> -        tcg_gen_negsetcond_i64(COND, d, a, tcg_constant_i64(0));        \
> -    }                                                                   \
> -    static void gen_##NAME##0_vec(unsigned vece, TCGv_vec d, TCGv_vec a) \
> -    {                                                                   \
> -        TCGv_vec zero = tcg_constant_vec_matching(d, vece, 0);          \
> -        tcg_gen_cmp_vec(COND, vece, d, a, zero);                        \
> -    }                                                                   \
> -    void gen_gvec_##NAME##0(unsigned vece, uint32_t d, uint32_t m,      \
> -                            uint32_t opr_sz, uint32_t max_sz)           \
> -    {                                                                   \
> -        const GVecGen2 op[4] = {                                        \
> -            { .fno = gen_helper_gvec_##NAME##0_b,                       \
> -              .fniv = gen_##NAME##0_vec,                                \
> -              .opt_opc = vecop_list_cmp,                                \
> -              .vece = MO_8 },                                           \
> -            { .fno = gen_helper_gvec_##NAME##0_h,                       \
> -              .fniv = gen_##NAME##0_vec,                                \
> -              .opt_opc = vecop_list_cmp,                                \
> -              .vece = MO_16 },                                          \
> -            { .fni4 = gen_##NAME##0_i32,                                \
> -              .fniv = gen_##NAME##0_vec,                                \
> -              .opt_opc = vecop_list_cmp,                                \
> -              .vece = MO_32 },                                          \
> -            { .fni8 = gen_##NAME##0_i64,                                \
> -              .fniv = gen_##NAME##0_vec,                                \
> -              .opt_opc = vecop_list_cmp,                                \
> -              .prefer_i64 = TCG_TARGET_REG_BITS == 64,                  \
> -              .vece = MO_64 },                                          \
> -        };                                                              \
> -        tcg_gen_gvec_2(d, m, opr_sz, max_sz, &op[vece]);                \
> -    }
> +#define GEN_CMP0(NAME, COND)                              \
> +    void NAME(unsigned vece, uint32_t d, uint32_t m,      \
> +              uint32_t opr_sz, uint32_t max_sz)           \
> +    { tcg_gen_gvec_cmpi(COND, vece, d, m, 0, opr_sz, max_sz); }
>   
> -static const TCGOpcode vecop_list_cmp[] = {
> -    INDEX_op_cmp_vec, 0
> -};
> -
> -GEN_CMP0(ceq, TCG_COND_EQ)
> -GEN_CMP0(cle, TCG_COND_LE)
> -GEN_CMP0(cge, TCG_COND_GE)
> -GEN_CMP0(clt, TCG_COND_LT)
> -GEN_CMP0(cgt, TCG_COND_GT)
> +GEN_CMP0(gen_gvec_ceq0, TCG_COND_EQ)
> +GEN_CMP0(gen_gvec_cle0, TCG_COND_LE)
> +GEN_CMP0(gen_gvec_cge0, TCG_COND_GE)
> +GEN_CMP0(gen_gvec_clt0, TCG_COND_LT)
> +GEN_CMP0(gen_gvec_cgt0, TCG_COND_GT)
>   
>   #undef GEN_CMP0
>   
> 


