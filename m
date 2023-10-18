Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 716357CD1C3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 03:20:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsvE3-0004uT-Rd; Tue, 17 Oct 2023 21:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qsvDy-0004uF-8W
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:19:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qsvDw-0008H5-DA
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:19:50 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bxd+iwMi9lAr0yAA--.62184S3;
 Wed, 18 Oct 2023 09:19:44 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxbNywMi9l9YMoAA--.19573S3; 
 Wed, 18 Oct 2023 09:19:44 +0800 (CST)
Subject: Re: [PATCH v2 1/2] tcg: Add tcg_gen_{ld,st}_i128
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231013175109.124308-1-richard.henderson@linaro.org>
 <20231013175109.124308-2-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <33e8747b-7a0e-ad9a-8328-1bba68b5572f@loongson.cn>
Date: Wed, 18 Oct 2023 09:19:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231013175109.124308-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxbNywMi9l9YMoAA--.19573S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4rCFWkCF13Cr1UXrWUGFX_yoW8tFy3pF
 18X3y5WrZFyr1xKF9xAw1Y9ayrWw4vkw1jqryfGrZrGrs0yFy0yF13Kw4aqryxJa1DZr1U
 AFZIyF40krn5J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.339, SPF_HELO_NONE=0.001,
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

ÔÚ 2023/10/14 ÉÏÎç1:51, Richard Henderson Ð´µÀ:
> Do not require the translators to jump through concat and
> extract of i64 in order to move values to and from  env.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  3 +++
>   tcg/tcg-op.c                | 22 ++++++++++++++++++++++
>   2 files changed, 25 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 2048f92b5e..56d4e9cb9f 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -747,6 +747,9 @@ void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
>   void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
>   void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi);
>   
> +void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
> +void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
> +
>   static inline void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi)
>   {
>       tcg_gen_deposit_i64(ret, lo, hi, 32, 32);
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 393dbcd01c..12bcedf42f 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2880,6 +2880,28 @@ void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src)
>       }
>   }
>   
> +void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset)
> +{
> +    if (HOST_BIG_ENDIAN) {
> +        tcg_gen_ld_i64(TCGV128_HIGH(ret), base, offset);
> +        tcg_gen_ld_i64(TCGV128_LOW(ret), base, offset + 8);
> +    } else {
> +        tcg_gen_ld_i64(TCGV128_LOW(ret), base, offset);
> +        tcg_gen_ld_i64(TCGV128_HIGH(ret), base, offset + 8);
> +    }
> +}
> +
> +void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset)
> +{
> +    if (HOST_BIG_ENDIAN) {
> +        tcg_gen_st_i64(TCGV128_HIGH(val), base, offset);
> +        tcg_gen_st_i64(TCGV128_LOW(val), base, offset + 8);
> +    } else {
> +        tcg_gen_st_i64(TCGV128_LOW(val), base, offset);
> +        tcg_gen_st_i64(TCGV128_HIGH(val), base, offset + 8);
> +    }
> +}
> +
>   /* QEMU specific operations.  */
>   
>   void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)


