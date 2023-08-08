Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CF774554
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRdJ-0001cG-1F; Tue, 08 Aug 2023 14:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRdG-0001be-O6
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:40:38 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRdF-0002lj-4p
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:40:38 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686be28e1a8so4272126b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691520035; x=1692124835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sd6HOEFfq+SdO2BwaoyjTljBryW7Tlu9BRzjfNygjVg=;
 b=MJvOHzICgVQlin/WljZs7txjO4eHgGorpvbdVKRnk2Zlund+fucuhAD9x0KdDOVL3H
 kq1AuWlbxA5XmiPsEXhSRETDJ9nV3CJ220aEzVTB7SdRjM4DjwfJC8Y1UrdYF14ztcO/
 kSLDrccQGCskp/15FIQMJOgSxPmZUIpzmTKlqB89+2gAagmq2sdBUJsykXsH9UQIiwqv
 /+zK7J1Gsnmx4MRLgVe1pieTODhtx2ijBBc360k2s0FZOQbqrX7Abi3f0cL0Oqhl/h0t
 LujKCORDjeLg8muqKbFCYU+cU4beSq/4taUt0GZzuNNXGB9nFcN3r2oYwbiQQeGdycx/
 EiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691520035; x=1692124835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sd6HOEFfq+SdO2BwaoyjTljBryW7Tlu9BRzjfNygjVg=;
 b=WE5v+Xj0KbhWSsueUHAAimMVXFchswfNJL9W5bwpfQsCFMTcnnkXE1LD7AvfWpALbX
 jlRveTUqGJQuE1rBiWP7QF+wNkFp2BUs1nrJAAohFIXYZATFG7A5Ls/z7ZveLwoYyFYK
 OHlgbpWyeWC/8qOQ8IIqoqdH4u29tE+zZpVe2IO3MdZdIaNArmtE26v9QvuBlwRdAuiG
 iIKwowrnPdZS2Bl0ALkqlJvUJfbnY77PdF1cQsB9Iyej4mTWOYi0pnfi27lupJxyJXKT
 X+PCuqcV++NNlJt6CtJ7BWa5oAhi2f2ArWmT/JnKcrP5WYPBZOnhSfYPwDEyeFL8iuSj
 GyTw==
X-Gm-Message-State: AOJu0YxnyRgT+H4OLfTHo3nHZU4SAkksGE9tx7O0Zm7p2RHNmR8WKmyz
 dIEvIwGwzO1wGqyCxSNbpq/rpA==
X-Google-Smtp-Source: AGHT+IEpBctsmiw3GXrWwDABn0gHWixGKgUiBoSUEt3XIC5smgrjqw5EfMQBOxTsoC+G1plUhrDuqQ==
X-Received: by 2002:a05:6a00:a88:b0:668:753a:b150 with SMTP id
 b8-20020a056a000a8800b00668753ab150mr354741pfl.21.1691520035418; 
 Tue, 08 Aug 2023 11:40:35 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 j8-20020aa78008000000b00686f0b15b06sm8394806pfi.188.2023.08.08.11.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 11:40:34 -0700 (PDT)
Message-ID: <9ce62de2-5f2f-5db6-e78f-de39620dcdc5@linaro.org>
Date: Tue, 8 Aug 2023 11:40:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 07/11] target/loongarch: Add LA32 & VA32 to DisasContext
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-8-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-8-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 18:54, Jiajie Chen wrote:
> --- a/target/loongarch/translate.c
> +++ b/target/loongarch/translate.c
> @@ -119,6 +119,9 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
>           ctx->vl = LSX_LEN;
>       }
>   
> +    ctx->la32 = LOONGARCH_CPUCFG_ARCH(env, LA32);
> +    ctx->va32 = (ctx->base.tb->flags & HW_FLAGS_VA32) != 0;
> +
>       ctx->zero = tcg_constant_tl(0);
>   }
>   
> diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
> index 7f60090580..828f1185d2 100644
> --- a/target/loongarch/translate.h
> +++ b/target/loongarch/translate.h
> @@ -33,6 +33,8 @@ typedef struct DisasContext {
>       uint16_t plv;
>       int vl;   /* Vector length */
>       TCGv zero;
> +    bool la32; /* LoongArch32 mode */

Because if the LA32 Restricted (or simplified), let's make this la64.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

