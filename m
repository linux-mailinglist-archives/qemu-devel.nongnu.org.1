Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D70782887
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY3ew-00009X-B3; Mon, 21 Aug 2023 08:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY3ep-00009G-Qa
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:05:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY3ek-0005op-AQ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:05:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fef56f7222so1562975e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692619512; x=1693224312;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qgSJwPRA5hrVZH1zAaKntnMzqtB7CyWmFX/4UC6TuDg=;
 b=AGgN+oCQjXZCkfgb9tQoXkZ3AtrME82rYRvdla5RUeElTAJhN0OXPblhA9BJmsp9zd
 viWR5tPhA1lkWgWLRwx/N9lhM7uB1Br9Gf3SGHI7CgHAqfZCg4+xLIGb1XNAeCVhFTTh
 I9h9N2TQ12KMS4tfQRBSuAXqy4XYMppXtY1Hrf/pNT2+Y+BYV+tlO6V+H1psW4bau/KN
 gGn3MBw1XMmO8baZCQloSEzfr6HWEkO6oSFBgqXQvI9Jv3Oi7Dpuc62yPH214Ap49Ysd
 6JX4G6JkVLXFS3YTH++9jmXUwUuLj7cnSYuOVj0Jf6r2uf2Vffr5+qAcHfqwFCUOAJCk
 iOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692619512; x=1693224312;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgSJwPRA5hrVZH1zAaKntnMzqtB7CyWmFX/4UC6TuDg=;
 b=PajSwPZKAhZUBrH3sCwumEzb/srVXezmdg4L60xeeR/MSKpfNK59CG0EnafHqy6TIG
 x7PWn7s2gjEjd3K9EgmIYCn9QlHP/n0Nz0masRguGKLOBwH9Wy0oytjYWSqaCFyH3WHZ
 TaEhyFOMJfFx8LxYfLRn0GoYf24bAqPG2tHierwqMHv/HUJnc2bo5v6l0IPOnLHN9gCx
 J3ElAC4HGr8z0i1cUvDVLnlKHzM99bUXRtQTSHx/iK//pIY4ZdC7ZezNLg4famdNXpGk
 +VkiOyM8hxEpRGP73vXwk1x5oEvut4eHcFMvLpik76Xmav8I3g8KIoY5aZ9a7+VSkLud
 U7Bw==
X-Gm-Message-State: AOJu0YybK2NvT/UgpFB33Q8IdxJv1Gxkrx51744lXUp57KZzG0j0Rwfz
 vnI8vjsX7G89lbjh/zuf5lAjIgrJskRGZm6SEQQ=
X-Google-Smtp-Source: AGHT+IEqGJHSVHXfaNhAOby/e/R8f2AFc6u2rel8LdUfi5NvrQkJPEPmiRqxjabubChjBQEh9OIteg==
X-Received: by 2002:a1c:7908:0:b0:3fe:22a9:907 with SMTP id
 l8-20020a1c7908000000b003fe22a90907mr4694559wme.20.1692619511953; 
 Mon, 21 Aug 2023 05:05:11 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 w3-20020a05600c014300b003fe0a0e03fcsm15988777wmm.12.2023.08.21.05.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 05:05:11 -0700 (PDT)
Message-ID: <9732e941-33a4-f506-65d9-80f7ca27b49f@linaro.org>
Date: Mon, 21 Aug 2023 14:05:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] tcg: Fold deposit with zero to and
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230816145547.477974-1-richard.henderson@linaro.org>
 <20230816145547.477974-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816145547.477974-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 16/8/23 16:55, Richard Henderson wrote:
> Inserting a zero into a value, or inserting a value
> into zero at offset 0 my be implemented with AND.

Typo "may".

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index d2156367a3..956114b631 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1279,6 +1279,8 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_deposit(OptContext *ctx, TCGOp *op)
>   {
> +    TCGOpcode and_opc;
> +
>       if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
>           uint64_t t1 = arg_info(op->args[1])->val;
>           uint64_t t2 = arg_info(op->args[2])->val;
> @@ -1287,6 +1289,39 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>           return tcg_opt_gen_movi(ctx, op, op->args[0], t1);
>       }
>   
> +    switch (ctx->type) {
> +    case TCG_TYPE_I32:
> +        and_opc = INDEX_op_and_i32;
> +        break;
> +    case TCG_TYPE_I64:
> +        and_opc = INDEX_op_and_i64;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (arg_is_const(op->args[1])
> +        && arg_info(op->args[1])->val == 0
> +        && op->args[3] == 0) {

            /* Inserting a value into zero at offset 0. */

> +        uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
> +
> +        op->opc = and_opc;
> +        op->args[1] = op->args[2];
> +        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
> +        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
> +        return false;
> +    }
> +
> +    if (arg_is_const(op->args[2])
> +        && arg_info(op->args[2])->val == 0) {

            /* Inserting a zero into a value. */

> +        uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
> +
> +        op->opc = and_opc;
> +        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
> +        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
> +        return false;
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



