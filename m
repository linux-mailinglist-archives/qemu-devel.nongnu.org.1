Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CBA7B4026
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 13:41:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmYKL-0004Nu-GK; Sat, 30 Sep 2023 07:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmYKH-0004Ni-H0
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 07:40:01 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmYKD-0007WF-18
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 07:39:58 -0400
Received: from [192.168.1.2] (unknown [223.72.88.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 7DA7F4437D;
 Sat, 30 Sep 2023 11:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1696073996; bh=piuQZvjrgVp057UySZvi5ehXmPVeJf82QpyEB0KxbLA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=S7gNia6CUR11Dw5OHPdOzeYAh4O7hwLfPWvijcQ3GuyMpyf0w4C7Y6hi7+27/s/cc
 eYmGM+w7j2/AmzyOKV1CLvAV5WN5cOG74fv8im4Omhom3cZXk+LgtmSHMa+Rflttq2
 1mSCu6y7JkImaT05sQ6H9zhoEb1FGUPwXNwT5IFI=
Message-ID: <9cce79ee-ba15-4edb-859a-af3bd69b53bb@jia.je>
Date: Sat, 30 Sep 2023 19:39:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tcg/loongarch64: Use C_N2_I1 for
 INDEX_op_qemu_ld_a*_i128
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, gaosong@loongson.cn, yangxiaojuan@loongson.cn
References: <20230916220151.526140-1-richard.henderson@linaro.org>
 <20230916220151.526140-3-richard.henderson@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <20230916220151.526140-3-richard.henderson@linaro.org>
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
> Use new registers for the output, so that we never overlap
> the input address, which could happen for user-only.
> This avoids a "tmp = addr + 0" in that case.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  2 +-
>   tcg/loongarch64/tcg-target.c.inc     | 17 +++++++++++------
>   2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
> index 77d62e38e7..cae6c2aad6 100644
> --- a/tcg/loongarch64/tcg-target-con-set.h
> +++ b/tcg/loongarch64/tcg-target-con-set.h
> @@ -38,4 +38,4 @@ C_O1_I2(w, w, wM)
>   C_O1_I2(w, w, wA)
>   C_O1_I3(w, w, w, w)
>   C_O1_I4(r, rZ, rJ, rZ, rZ)
> -C_O2_I1(r, r, r)
> +C_N2_I1(r, r, r)
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index b701df50db..40074c46b8 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1105,13 +1105,18 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, TCGReg data_hi
>           }
>       } else {
>           /* Otherwise use a pair of LD/ST. */
> -        tcg_out_opc_add_d(s, TCG_REG_TMP0, h.base, h.index);
> +        TCGReg base = h.base;
> +        if (h.index != TCG_REG_ZERO) {
> +            base = TCG_REG_TMP0;
> +            tcg_out_opc_add_d(s, base, h.base, h.index);
> +        }
>           if (is_ld) {
> -            tcg_out_opc_ld_d(s, data_lo, TCG_REG_TMP0, 0);
> -            tcg_out_opc_ld_d(s, data_hi, TCG_REG_TMP0, 8);
> +            tcg_debug_assert(base != data_lo);
> +            tcg_out_opc_ld_d(s, data_lo, base, 0);
> +            tcg_out_opc_ld_d(s, data_hi, base, 8);
>           } else {
> -            tcg_out_opc_st_d(s, data_lo, TCG_REG_TMP0, 0);
> -            tcg_out_opc_st_d(s, data_hi, TCG_REG_TMP0, 8);
> +            tcg_out_opc_st_d(s, data_lo, base, 0);
> +            tcg_out_opc_st_d(s, data_hi, base, 8);
>           }
>       }
>   
> @@ -2049,7 +2054,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>   
>       case INDEX_op_qemu_ld_a32_i128:
>       case INDEX_op_qemu_ld_a64_i128:
> -        return C_O2_I1(r, r, r);
> +        return C_N2_I1(r, r, r);
>   
>       case INDEX_op_qemu_st_a32_i128:
>       case INDEX_op_qemu_st_a64_i128:


Reviewed-by: Jiajie Chen <c@jia.je>



