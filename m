Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3E17C81AF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrEF9-0000jI-OW; Fri, 13 Oct 2023 05:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qrEF1-0000eP-Qc; Fri, 13 Oct 2023 05:13:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1qrEEw-0005iD-RC; Fri, 13 Oct 2023 05:13:54 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxRuhICillHasxAA--.42165S3;
 Fri, 13 Oct 2023 17:13:44 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx3y9FCillB7EiAA--.7826S3; 
 Fri, 13 Oct 2023 17:13:43 +0800 (CST)
Subject: Re: [RFC PATCH v3 01/78] include/qemu/compiler.h: replace
 QEMU_FALLTHROUGH with fallthrough
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM SMMU" <qemu-arm@nongnu.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697186560.git.manos.pitsidianakis@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d2893541-a8cd-5e45-7261-3c228fee2eda@loongson.cn>
Date: Fri, 13 Oct 2023 17:13:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx3y9FCillB7EiAA--.7826S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr4DGFyrtr4kGr1rAF4rXrc_yoWxJw1xpF
 s7CayDKF4fJrW5GF97Cw4agFn5Ww4rGryjgrWqg3W0yr43Kw4kXrWktrnFkFW8WrWSvrW7
 uFyxZry5WayqqrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
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

ÔÚ 2023/10/13 ÏÂÎç4:45, Emmanouil Pitsidianakis Ð´µÀ:
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   audio/pwaudio.c              |  8 ++++----
>   hw/arm/smmuv3.c              |  2 +-
>   include/qemu/compiler.h      | 30 +++++++++++++++++++++++-------
>   include/qemu/osdep.h         |  4 ++--
>   target/loongarch/cpu.c       |  4 ++--
>   target/loongarch/translate.c |  2 +-
>   tcg/optimize.c               |  8 ++++----
>   7 files changed, 37 insertions(+), 21 deletions(-)
For LoongArch:
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao.

> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 3ce5f6507b..bf26fadb06 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -8,16 +8,16 @@
>    * SPDX-License-Identifier: GPL-2.0-or-later
>    */
>   
> +#include <spa/param/audio/format-utils.h>
> +#include <spa/utils/ringbuffer.h>
> +#include <spa/utils/result.h>
> +#include <spa/param/props.h>
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
>   #include "audio.h"
>   #include <errno.h>
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> -#include <spa/param/audio/format-utils.h>
> -#include <spa/utils/ringbuffer.h>
> -#include <spa/utils/result.h>
> -#include <spa/param/props.h>
>   
>   #include <pipewire/pipewire.h>
>   #include "trace.h"
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 6f2b2bd45f..545d82ff04 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1291,7 +1291,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>                   cmd_error = SMMU_CERROR_ILL;
>                   break;
>               }
> -            QEMU_FALLTHROUGH;
> +            fallthrough;
>           case SMMU_CMD_TLBI_NSNH_ALL:
>               trace_smmuv3_cmdq_tlbi_nh();
>               smmu_inv_notifiers_all(&s->smmu_state);
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 1109482a00..959982805d 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -165,15 +165,31 @@
>   #define QEMU_ALWAYS_INLINE
>   #endif
>   
> -/**
> - * In most cases, normal "fallthrough" comments are good enough for
> - * switch-case statements, but sometimes the compiler has problems
> - * with those. In that case you can use QEMU_FALLTHROUGH instead.
> +/*
> + * Add the pseudo keyword 'fallthrough' so case statement blocks
> + * must end with any of these keywords:
> + *   break;
> + *   fallthrough;
> + *   continue;
> + *   goto <label>;
> + *   return [expression];
> + *
> + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
>    */
> -#if __has_attribute(fallthrough)
> -# define QEMU_FALLTHROUGH __attribute__((fallthrough))
> +
> +/*
> + * glib_macros.h contains its own definition of fallthrough, so if we define
> + * the pseudokeyword here it will expand when the glib header checks for the
> + * attribute. glib headers must be #included after this header.
> + */
> +#ifdef fallthrough
> +#undef fallthrough
> +#endif
> +
> +#if __has_attribute(__fallthrough__)
> +# define fallthrough                    __attribute__((__fallthrough__))
>   #else
> -# define QEMU_FALLTHROUGH do {} while (0) /* fallthrough */
> +# define fallthrough                    do {} while (0)  /* fallthrough */
>   #endif
>   
>   #ifdef CONFIG_CFI
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 475a1c62ff..8f790f0deb 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -50,8 +50,6 @@
>    */
>   #pragma GCC poison TARGET_WORDS_BIGENDIAN
>   
> -#include "qemu/compiler.h"
> -
>   /* Older versions of C++ don't get definitions of various macros from
>    * stdlib.h unless we define these macros before first inclusion of
>    * that system header.
> @@ -160,6 +158,8 @@ QEMU_EXTERN_C int daemon(int, int);
>    */
>   #include "glib-compat.h"
>   
> +#include "qemu/compiler.h"
> +
>   #ifdef _WIN32
>   #include "sysemu/os-win32.h"
>   #endif
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 2bea7ca5d5..e01d626b15 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -178,7 +178,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>               env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DEI, 1);
>               goto set_DERA;
>           }
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>       case EXCCODE_PIF:
>       case EXCCODE_ADEF:
>           cause = cs->exception_index;
> @@ -193,7 +193,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>       case EXCCODE_SXD:
>       case EXCCODE_ASXD:
>           env->CSR_BADV = env->pc;
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>       case EXCCODE_BCE:
>       case EXCCODE_ADEM:
>       case EXCCODE_PIL:
> diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
> index 21f4db6fbd..36fceb1beb 100644
> --- a/target/loongarch/translate.c
> +++ b/target/loongarch/translate.c
> @@ -317,7 +317,7 @@ static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>           break;
>       case DISAS_EXIT_UPDATE:
>           tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>       case DISAS_EXIT:
>           tcg_gen_exit_tb(NULL, 0);
>           break;
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 3013eb04e6..3da135a353 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1089,7 +1089,7 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
>   
>       case TCG_COND_NE:
>           inv = 1;
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>       case TCG_COND_EQ:
>           /*
>            * Simplify EQ/NE comparisons where one of the pairs
> @@ -1445,7 +1445,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
>           break;
>       case INDEX_op_ext_i32_i64:
>           type_change = true;
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>       case INDEX_op_ext32s_i64:
>           sign = INT32_MIN;
>           z_mask = (uint32_t)z_mask;
> @@ -1489,7 +1489,7 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
>       case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extu_i32_i64:
>           type_change = true;
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>       case INDEX_op_ext32u_i64:
>           z_mask = (uint32_t)z_mask;
>           break;
> @@ -1861,7 +1861,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
>   
>       case TCG_COND_NE:
>           inv = 1;
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>       case TCG_COND_EQ:
>           /*
>            * Simplify EQ/NE comparisons where one of the pairs


