Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B72FB0AB28
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Jul 2025 22:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucroR-0004bY-D3; Fri, 18 Jul 2025 16:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucrPe-0003JY-2r
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 16:10:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucrPc-0007zw-1k
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 16:10:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so2544031b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752869430; x=1753474230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aMvBP39AC2o9BS6kOXbkpWCMjeEEdge4IA4jjYzhezw=;
 b=qrF8sJ2VfWhxOP+GSS9Fyrynevw3FrUB4ZSYlXyqQFyPw+61BZLrO8nWYq9qzFAoUP
 OwlqMenPO6ISkgyl1b0HV2da77gWqjN9/UZdfieXQ4qhZvRsQUH6sHXbbdQKVYZZGa0n
 4c80wgpCbLSpj0fsWFMkNsK6xSkra0fuS1A9HPU61qvsqPk6DcFi8TY4R/cmemVT6bD1
 H79P9gkc62o3aiIFsK2NYcoZ/jAr+uqWMDKizIvpywJfOQugWDVfiklvsWF3hHL1V95Y
 UvOq5q5S8hfZpyGV9D5BYC5D/2T2XaVXvJbf+pGH0jLOtFD3oD08OFGi5uYu6AGzT39m
 Eckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752869430; x=1753474230;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aMvBP39AC2o9BS6kOXbkpWCMjeEEdge4IA4jjYzhezw=;
 b=B5pUMKpC7ykR0I17D+SqpMJb5i7oAig8PIy1w/1F995gh3qvqrf7CSABKKSLjzouoo
 0Z259oCBl0R1BTQK5hEWTkRJlrFK38x+IS4MYnFQFLqV2LOH99NZs3d/7AJPoWlo0Xtz
 BPjFvPMsXUnfiVriV1QrNep14vivcH2/VBKU5ux29UcZQW0sRvmmHeyEUd1rlr8M/fQs
 3Mx/pa7uqXnafT5vvWE8tng4XOWkMrfEfbRuYe7WbMnrHBOYA532qAymPqXgnyl85Acy
 8FVzrFkrxIOU0at2DZlvxkWDI82X+0ItLyKpAKKZ5tRpq6oUnOeWjJ3hD6aJDKbp+lR2
 ebiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnYbfkddESw2jx3TjWWquEKFsgG7ckGg5SyTJrfalti4TNz3hJEKYz9AgXwTqizBRfk3xamlzBPO6o@nongnu.org
X-Gm-Message-State: AOJu0YyB3NZ4OVEBVX+1UBt65a4KTBXTQoRz6oCrFalA8XEVhKxig01j
 fxqjlrRbz3KeHHMzj9v9/OXa5t1hAicxmHwDplLpZAt8BKA8gXqwtKE+1mMCPA+2QeY=
X-Gm-Gg: ASbGncsK3o5TLBmstOo2zUr6iA8RlOf/9pwxkRNz04U556DNuysCTkDFEpp+bFVv48K
 5nLuHUXVqq7uu7JeHX8PTXbxpS24BWi8J++eUTFnpC4so17kxL/D7YVbzJPkwp/K5hKULwDpS9P
 ABqjW64ajFbzeVAyGZeweqL5Kr1puDK2e6jy1/+6xyivKDtoLitvFDKuuawwNLanQQD4wQ0rYy/
 bUErzZwKrXxfAC8Ackf0THoXHuWo0hKycwL2zCTC5iBwibQem/EcMlleeVFibW2GiQ5peGkDgEt
 zOiyzKf0sCzCMqmmZqpiTxAcqsmtIpA1ply8p7IzIwRCNijSdHs5bdyMekQ/dQXLr0iHw6xUhDh
 dOOaqGhbga7MiNtVAg1UTgTrTPrrkzJ8Op5g=
X-Google-Smtp-Source: AGHT+IGB996OLW+DI6MRwBYWdjZ5RUVDlN5Nx5khIKl+KeYJDVOyTwnLG1kLRNbkg+gBJdNcnQi0nA==
X-Received: by 2002:a05:6a00:bd82:b0:755:93be:40fd with SMTP id
 d2e1a72fcca58-75836faac43mr12327024b3a.2.1752869429561; 
 Fri, 18 Jul 2025 13:10:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb67901csm1707628b3a.100.2025.07.18.13.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 13:10:29 -0700 (PDT)
Message-ID: <269598c8-3ccf-4105-9934-7b8cfec55058@linaro.org>
Date: Fri, 18 Jul 2025 13:10:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] tcg/optimize: Don't fold INDEX_op_and_vec to
 extract
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250718173832.47820-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250718173832.47820-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/18/25 10:38 AM, Richard Henderson wrote:
> There is no such thing as vector extract.
> 
> Fixes: 932522a9ddc1 ("tcg/optimize: Fold and to extract during optimize")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3036
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 62a128bc9b..3638ab9fea 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1454,7 +1454,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
>       a_mask = t1->z_mask & ~t2->o_mask;
>   
>       if (!fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask)) {
> -        if (ti_is_const(t2)) {
> +        if (op->opc == INDEX_op_and && ti_is_const(t2)) {
>               /*
>                * Canonicalize on extract, if valid.  This aids x86 with its
>                * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode

This solves the failures observed, thanks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

