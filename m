Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9D6797A48
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 19:35:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeItY-0005vT-TT; Thu, 07 Sep 2023 13:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeItV-0005su-GD
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 13:34:17 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeItT-0004hT-9h
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 13:34:17 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68bed8de5b9so1062289b3a.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694108051; x=1694712851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4FUOHcIebPixLUvx3SI/Jyza3CeRo8hit/Xwc8Rdw1Q=;
 b=nKcjVGIWmjD7YUDdSc5lok7koly8bazuh09PybC+LpTN0dmtgxCUxX9zGbjHb6OZeP
 WR65UArRRBLY8Ed8j/9M/yEFwQABQufQsMt/fyPK5zFn9ppMQ4t/zeXJdMgElrickmpW
 kFxHskBW9Mcfx91xCvVZtZOcRxJw4x+C9EG7kr/noSWKSja6zAeQjjPe98KfwZS3lda+
 WZFCoKlW4SMuuboN01qp46pj+70bJOMYc4IuRsaJsjzWyjg5fUnF/aV0hlrOoYacG/W2
 QxYEd3KxmC8p+3L3bGYM1/iXObOrB40JCuaHB+ZLcBidmLwc1PyniNKIaW23EmxZZxFm
 E2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694108051; x=1694712851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4FUOHcIebPixLUvx3SI/Jyza3CeRo8hit/Xwc8Rdw1Q=;
 b=d/GtSxUst0GLJxvAlWLX1hLey7Q5N3d9VMuJCD82vMOQOh8plYSaINcofQuIw+BO7v
 JivPVyu2Utz6VqI0TAeCjgQ7TR3oE+ILySend4pju+8nF/2T2I6G8TGYJmXLEhpmrsx2
 M+i5SW3ScnQsTJ3+oln49iWNRHIr2VDZmMU0xQO9jdDd1kBM6CE/OU+O58nM9sjxm4/z
 gFFqZEuKgAyEj5hNbCVl4UT0xZifesnenF4rY22yVVvANWOqZzHLoEqsQjf5FuM9BInT
 iDfKQc5FXV2gkxh0ZiJNx8GW/PHVC/yLsdAGL1iZ3IBQ35X4pSa18O1FsBYksm6h1/Ps
 ActA==
X-Gm-Message-State: AOJu0YzvvzM/g1hjykttHcXJcoVGZQNQymD+QOEnV7xqThNvkvSSmBxx
 d1gHmhT2y1WgMaSpy3BwKyhJPLFXLFwh+kUMMQ0=
X-Google-Smtp-Source: AGHT+IHSMCnS7ih51BkcxuVGoBFuG733kPiN0B2XF20HPVtzeBVqinEBVGM0H+7oFVXKwMnqRBeOyQ==
X-Received: by 2002:a05:6a00:1496:b0:68e:3f55:742 with SMTP id
 v22-20020a056a00149600b0068e3f550742mr29725pfu.30.1694108051159; 
 Thu, 07 Sep 2023 10:34:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a62e813000000b0068a690b44basm6169pfi.31.2023.09.07.10.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 10:34:10 -0700 (PDT)
Message-ID: <6a7579a2-d502-bf8b-7975-2ae33304cacb@linaro.org>
Date: Thu, 7 Sep 2023 10:34:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 03/57] target/loongarch: Use
 gen_helper_gvec_4_ptr for 4OP + env vector instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-4-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 01:31, Song Gao wrote:
> +static bool gen_vvvv_ptr_vl(DisasContext *ctx, arg_vvvv *a, uint32_t oprsz,
> +                            gen_helper_gvec_4_ptr *fn)
> +{
> +    tcg_gen_gvec_4_ptr(vec_full_offset(a->vd),
> +                       vec_full_offset(a->vj),
> +                       vec_full_offset(a->vk),
> +                       vec_full_offset(a->va),
> +                       cpu_env,
> +                       oprsz, ctx->vl / 8, oprsz, fn);
                                               ^^^^^

This next to last argument is 'data', which is unused for this case.
Just use 0 here.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

