Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 105857B4027
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 13:41:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmYLW-0006Iy-1a; Sat, 30 Sep 2023 07:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmYLT-000699-EY
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 07:41:15 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmYLR-00082D-JW
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 07:41:15 -0400
Received: from [192.168.1.2] (unknown [223.72.88.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id CF6B844345;
 Sat, 30 Sep 2023 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1696074072; bh=MoMfbniPfhKWi0AeVNcTKvl0CEqoBZRsXPlFWQPJmFA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cyhotaJwq6dR/aBj+W7jxFmJoh01slrNnxu1fN0PRi1K+UNRJTTKgbcwDWJzUqEOf
 aRM7qReI0uG9TI6SSGjwsJwjgEo1mXWv0KjC33sGZiMvCKi3W8Q9vP/OcVRG8HWNuK
 PkuiMAkBNOXLkXpa2dOJX+PmoEe9gKdRsLuxRIW0=
Message-ID: <896294f0-e705-41fb-ab9d-4c7162ad2e78@jia.je>
Date: Sat, 30 Sep 2023 19:41:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] tcg/loongarch64: Use cpuinfo.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, gaosong@loongson.cn, yangxiaojuan@loongson.cn
References: <20230916220151.526140-1-richard.henderson@linaro.org>
 <20230916220151.526140-5-richard.henderson@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <20230916220151.526140-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


On 2023/9/17 06:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.h     | 8 ++++----
>   tcg/loongarch64/tcg-target.c.inc | 8 +-------
>   2 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
> index 03017672f6..1bea15b02e 100644
> --- a/tcg/loongarch64/tcg-target.h
> +++ b/tcg/loongarch64/tcg-target.h
> @@ -29,6 +29,8 @@
>   #ifndef LOONGARCH_TCG_TARGET_H
>   #define LOONGARCH_TCG_TARGET_H
>   
> +#include "host/cpuinfo.h"
> +
>   #define TCG_TARGET_INSN_UNIT_SIZE 4
>   #define TCG_TARGET_NB_REGS 64
>   
> @@ -85,8 +87,6 @@ typedef enum {
>       TCG_VEC_TMP0 = TCG_REG_V23,
>   } TCGReg;
>   
> -extern bool use_lsx_instructions;
> -
>   /* used for function call generation */
>   #define TCG_REG_CALL_STACK              TCG_REG_SP
>   #define TCG_TARGET_STACK_ALIGN          16
> @@ -171,10 +171,10 @@ extern bool use_lsx_instructions;
>   #define TCG_TARGET_HAS_muluh_i64        1
>   #define TCG_TARGET_HAS_mulsh_i64        1
>   
> -#define TCG_TARGET_HAS_qemu_ldst_i128   use_lsx_instructions
> +#define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
>   
>   #define TCG_TARGET_HAS_v64              0
> -#define TCG_TARGET_HAS_v128             use_lsx_instructions
> +#define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
>   #define TCG_TARGET_HAS_v256             0
>   
>   #define TCG_TARGET_HAS_not_vec          1
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 40074c46b8..52f2c26ce1 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -32,8 +32,6 @@
>   #include "../tcg-ldst.c.inc"
>   #include <asm/hwcap.h>
>   
> -bool use_lsx_instructions;
> -
>   #ifdef CONFIG_DEBUG_TCG
>   static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
>       "zero",
> @@ -2316,10 +2314,6 @@ static void tcg_target_init(TCGContext *s)
>           exit(EXIT_FAILURE);
>       }
>   
> -    if (hwcap & HWCAP_LOONGARCH_LSX) {
> -        use_lsx_instructions = 1;
> -    }
> -
>       tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
>       tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
>   
> @@ -2335,7 +2329,7 @@ static void tcg_target_init(TCGContext *s)
>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S8);
>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
>   
> -    if (use_lsx_instructions) {
> +    if (cpuinfo & CPUINFO_LSX) {
>           tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
>           tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
>           tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V25);


Reviewed-by: Jiajie Chen <c@jia.je>



