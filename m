Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B167D293D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 06:08:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qumD5-00070B-Bf; Mon, 23 Oct 2023 00:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1qumD2-000701-IE
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 00:06:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1qumCy-0001Rf-JA
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 00:06:32 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8Cx5_Ez8TVlX9ozAA--.34934S3;
 Mon, 23 Oct 2023 12:06:11 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxzt4u8TVlq9IuAA--.35592S3; 
 Mon, 23 Oct 2023 12:06:08 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Support 4K page size
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org
References: <20231023024059.3858349-1-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <b0e7be32-ab05-a39c-f722-44b2eaac8318@loongson.cn>
Date: Mon, 23 Oct 2023 12:06:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231023024059.3858349-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxzt4u8TVlq9IuAA--.35592S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFyUKFykZryDCw48Zw4DKFX_yoW8uFW8pr
 W7AF1jkF4UKrZrG3Zaga45WrnrZr47Gr4aqa1fKrWFyrs0q34xZF1ktwsI9F4xJw45ur4I
 qw1qya4j9F4UXacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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



ÔÚ 2023/10/23 ÉÏÎç10:40, Song Gao Ð´µÀ:
> The LoongArch kernel supports 4K page size.
> Change TARGET_PAGE_BITS to 12.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu-param.h  | 2 +-
>   target/loongarch/tlb_helper.c | 9 ++++-----
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
> index 1265dc7cb5..cfe195db4e 100644
> --- a/target/loongarch/cpu-param.h
> +++ b/target/loongarch/cpu-param.h
> @@ -12,6 +12,6 @@
>   #define TARGET_PHYS_ADDR_SPACE_BITS 48
>   #define TARGET_VIRT_ADDR_SPACE_BITS 48
>   
> -#define TARGET_PAGE_BITS 14
> +#define TARGET_PAGE_BITS 12
Hi Gaosong,

The popular OS about LoongArch still uses 16K page size, qemu should 
follow the rule of OS rather than defining 4K page size alone.

Regards
Bibo Mao

>   
>   #endif
> diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
> index c8b8b0497f..449043c68b 100644
> --- a/target/loongarch/tlb_helper.c
> +++ b/target/loongarch/tlb_helper.c
> @@ -60,6 +60,9 @@ static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
>           tlb_rplv = 0;
>       }
>   
> +    /* Remove sw bit between bit12 -- bit PS*/
> +    tlb_ppn = tlb_ppn & ~(((0x1UL << (tlb_ps - 12)) -1));
> +
>       /* Check access rights */
>       if (!tlb_v) {
>           return TLBRET_INVALID;
> @@ -82,10 +85,6 @@ static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
>           return TLBRET_DIRTY;
>       }
>   
> -    /*
> -     * tlb_entry contains ppn[47:12] while 16KiB ppn is [47:15]
> -     * need adjust.
> -     */
>       *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
>                   (address & MAKE_64BIT_MASK(0, tlb_ps));
>       *prot = PAGE_READ;
> @@ -774,7 +773,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>           /* Move Global bit */
>           tmp0 = ((tmp0 & (1 << LOONGARCH_HGLOBAL_SHIFT))  >>
>                   LOONGARCH_HGLOBAL_SHIFT) << R_TLBENTRY_G_SHIFT |
> -                (tmp0 & (~(1 << R_TLBENTRY_G_SHIFT)));
> +                (tmp0 & (~(1 << LOONGARCH_HGLOBAL_SHIFT)));
>           ps = ptbase + ptwidth - 1;
>           if (odd) {
>               tmp0 += MAKE_64BIT_MASK(ps, 1);
> 


