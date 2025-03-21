Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E55A6B2D4
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Mar 2025 03:08:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvRnM-0005iy-0g; Thu, 20 Mar 2025 22:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tvRnI-0005iR-UX
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 22:07:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tvRnE-0008EL-Sa
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 22:07:32 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxHHLZydxnRIWfAA--.7333S3;
 Fri, 21 Mar 2025 10:07:21 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxXsXUydxn6RxXAA--.56528S3;
 Fri, 21 Mar 2025 10:07:19 +0800 (CST)
Subject: Re: [PATCH] host/include/loongarch64: Fix inline assembly
 compatibility with Clang
To: Yao Zi <ziyao@disroot.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20250314033150.53268-3-ziyao@disroot.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <935124ae-c6f8-15eb-4637-266a95fa6176@loongson.cn>
Date: Fri, 21 Mar 2025 10:06:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250314033150.53268-3-ziyao@disroot.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXsXUydxn6RxXAA--.56528S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw1fXFyfCrWkGF18GFWkKrX_yoW5ur4fpF
 9Iyw4kKF4xW3ySvFyUAw17tr13Xw129F1jgrW5Cw18CFya93WUXFsFkas29F1jqws29r12
 qF48KayrWa92qrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.608,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

applied to loongarch-next.

Regards
Bibo Mao

On 2025/3/14 上午11:31, Yao Zi wrote:
> Clang on LoongArch only accepts fp register names in the dollar-prefixed
> form, while GCC allows omitting the dollar. Change registers in ASM
> clobbers to the dollar-prefixed form to make user emulators buildable
> with Clang on loongarch64. No functional change invovled.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>   host/include/loongarch64/host/atomic128-ldst.h.inc        | 4 ++--
>   host/include/loongarch64/host/bufferiszero.c.inc          | 6 ++++--
>   host/include/loongarch64/host/load-extract-al16-al8.h.inc | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/host/include/loongarch64/host/atomic128-ldst.h.inc b/host/include/loongarch64/host/atomic128-ldst.h.inc
> index 9a4a8f8b9e..754d2143f0 100644
> --- a/host/include/loongarch64/host/atomic128-ldst.h.inc
> +++ b/host/include/loongarch64/host/atomic128-ldst.h.inc
> @@ -28,7 +28,7 @@ static inline Int128 atomic16_read_ro(const Int128 *ptr)
>       asm("vld $vr0, %2, 0\n\t"
>           "vpickve2gr.d %0, $vr0, 0\n\t"
>           "vpickve2gr.d %1, $vr0, 1"
> -	: "=r"(l), "=r"(h) : "r"(ptr), "m"(*ptr) : "f0");
> +        : "=r"(l), "=r"(h) : "r"(ptr), "m"(*ptr) : "$f0");
>   
>       return int128_make128(l, h);
>   }
> @@ -46,7 +46,7 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
>       asm("vinsgr2vr.d $vr0, %1, 0\n\t"
>           "vinsgr2vr.d $vr0, %2, 1\n\t"
>           "vst $vr0, %3, 0"
> -	: "=m"(*ptr) : "r"(l), "r"(h), "r"(ptr) : "f0");
> +        : "=m"(*ptr) : "r"(l), "r"(h), "r"(ptr) : "$f0");
>   }
>   
>   #endif /* LOONGARCH_ATOMIC128_LDST_H */
> diff --git a/host/include/loongarch64/host/bufferiszero.c.inc b/host/include/loongarch64/host/bufferiszero.c.inc
> index 69891eac80..bb2598fdc3 100644
> --- a/host/include/loongarch64/host/bufferiszero.c.inc
> +++ b/host/include/loongarch64/host/bufferiszero.c.inc
> @@ -61,7 +61,8 @@ static bool buffer_is_zero_lsx(const void *buf, size_t len)
>       "2:"
>           : "=&r"(ret), "+r"(p)
>           : "r"(buf), "r"(e), "r"(l)
> -        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
> +        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
> +          "$fcc0");
>   
>       return ret;
>   }
> @@ -119,7 +120,8 @@ static bool buffer_is_zero_lasx(const void *buf, size_t len)
>       "3:"
>           : "=&r"(ret), "+r"(p)
>           : "r"(buf), "r"(e), "r"(l)
> -        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
> +        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
> +          "$fcc0");
>   
>       return ret;
>   }
> diff --git a/host/include/loongarch64/host/load-extract-al16-al8.h.inc b/host/include/loongarch64/host/load-extract-al16-al8.h.inc
> index d1fb59d8af..9528521e7d 100644
> --- a/host/include/loongarch64/host/load-extract-al16-al8.h.inc
> +++ b/host/include/loongarch64/host/load-extract-al16-al8.h.inc
> @@ -31,7 +31,7 @@ static inline uint64_t load_atom_extract_al16_or_al8(void *pv, int s)
>       asm("vld $vr0, %2, 0\n\t"
>           "vpickve2gr.d %0, $vr0, 0\n\t"
>           "vpickve2gr.d %1, $vr0, 1"
> -	: "=r"(l), "=r"(h) : "r"(ptr_align), "m"(*ptr_align) : "f0");
> +        : "=r"(l), "=r"(h) : "r"(ptr_align), "m"(*ptr_align) : "$f0");
>   
>       return (l >> shr) | (h << (-shr & 63));
>   }
> 


