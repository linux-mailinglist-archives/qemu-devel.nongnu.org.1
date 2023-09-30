Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE7F7B4024
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 13:41:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmYK4-0004MY-IV; Sat, 30 Sep 2023 07:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmYJu-0004MI-JK
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 07:39:38 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmYJr-0007Lc-Mm
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 07:39:37 -0400
Received: from [192.168.1.2] (unknown [223.72.88.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 0F84543A7F;
 Sat, 30 Sep 2023 11:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1696073973; bh=XDRXWNlQY/Gaah7lXj7wTm3X0WGrcNMMwXke6hFk0Fk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ULK6WYJn/rMILhhorELN/3eEoo9h0L+25WpvJvLQtFFgANxXcuhcKNVoBNlhtjGar
 fRncSNlBQ4fzssHJVceVJ7HIV6Otakq1iXH/DTPRdadEkVy6GdPa0/HygA7FfSuYl7
 nQF++iPjpGUsBjLHQ8t5Endu0YNJ+EWfOLIl4xdo=
Message-ID: <24419e2e-5d84-474c-8974-f4a3bfd0aaf3@jia.je>
Date: Sat, 30 Sep 2023 19:39:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tcg: Add C_N2_I1
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, gaosong@loongson.cn, yangxiaojuan@loongson.cn
References: <20230916220151.526140-1-richard.henderson@linaro.org>
 <20230916220151.526140-2-richard.henderson@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <20230916220151.526140-2-richard.henderson@linaro.org>
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
> Constraint with two outputs, both in new registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 604fa9bf3e..fdbf79689a 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -644,6 +644,7 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
>   #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4),
>   
>   #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2),
> +#define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1),
>   
>   #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1),
>   #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2),
> @@ -666,6 +667,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
>   #undef C_O1_I3
>   #undef C_O1_I4
>   #undef C_N1_I2
> +#undef C_N2_I1
>   #undef C_O2_I1
>   #undef C_O2_I2
>   #undef C_O2_I3
> @@ -685,6 +687,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
>   #define C_O1_I4(O1, I1, I2, I3, I4)     { .args_ct_str = { #O1, #I1, #I2, #I3, #I4 } },
>   
>   #define C_N1_I2(O1, I1, I2)             { .args_ct_str = { "&" #O1, #I1, #I2 } },
> +#define C_N2_I1(O1, O2, I1)             { .args_ct_str = { "&" #O1, "&" #O2, #I1 } },
>   
>   #define C_O2_I1(O1, O2, I1)             { .args_ct_str = { #O1, #O2, #I1 } },
>   #define C_O2_I2(O1, O2, I1, I2)         { .args_ct_str = { #O1, #O2, #I1, #I2 } },
> @@ -706,6 +709,7 @@ static const TCGTargetOpDef constraint_sets[] = {
>   #undef C_O1_I3
>   #undef C_O1_I4
>   #undef C_N1_I2
> +#undef C_N2_I1
>   #undef C_O2_I1
>   #undef C_O2_I2
>   #undef C_O2_I3
> @@ -725,6 +729,7 @@ static const TCGTargetOpDef constraint_sets[] = {
>   #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4)
>   
>   #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2)
> +#define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1)
>   
>   #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1)
>   #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2)


Reviewed-by: Jiajie Chen <c@jia.je>


