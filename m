Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D51773D927
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhFx-0007DN-DB; Mon, 26 Jun 2023 04:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhFL-0007Ao-7S
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:06:51 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhFJ-0007q3-BQ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:06:50 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4faaaa476a9so1582015e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687766807; x=1690358807;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=haSY8KexJgmpOVHOqbqlEw44PcpqxSYje0bRWpuDkp4=;
 b=QzMTsmItQyxo/QzUursq4CIXXxLmVUFPUGia1aZqM72z2ncUFih2yW4EKjavuNXd7r
 JmL+99cDKhEoE2v5S7Yue99I9UKCE5FsMr8NNXryikZgGW32JP1yKB13GA5bN0vZxg9V
 NhXIoKDfEn9Z7hFoTWR7yFzX9FkP2W65sE89W2u+uQI/sXJW21Q0fuoXgNQy3a9Tgpaq
 8gD8UZid6MsCAaTUnqnIG609DWbnETUOQb170mqoGRmag7qFwHZVr9OBnQEuvak4gMgN
 7CJFCsl8SMEFiIjV5SQofeEJPZ5E0wnVanUfQCmVr6A7bSzAzZOXM8G4Fnj5flsaaRRF
 uGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687766807; x=1690358807;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=haSY8KexJgmpOVHOqbqlEw44PcpqxSYje0bRWpuDkp4=;
 b=fPc1c4yJxj+CCZsbpyTi5+LJUg2L/HQVk9rwfmzDRCSH+3hKLe+TPLvkY+6QTfmkMl
 83znQBOc22l+/GyszNYGkFN+8Z5T8QAPqoPwdli2CppRTobLygVZGG2472rqhmJ2Hmxj
 J5ctQLYqzYj8BdGmq21TW+F/Ue+SjIGVH2Wk2vENrdUcqG4rrUnKy53Smx67xjn03gCr
 BAAMxBbXQA9q3nCVjONyOr/0m6Zh7yHk3G3p8RPTvsr1J2LKBsTN3NHeLjX/8/Mev9LA
 TUbbxgHFpNMuYM9ZuU1mu0kjXa7oBK1W0irhOpCmm67jT28G9Ww0zjcUlBy4TBKxls0Y
 6kRw==
X-Gm-Message-State: AC+VfDx5ZcWooJKuCzv3/uqiXuZOIseg4cdIggsG/Z80NAjX+x8OQy/3
 y9sSvIYb/Xgmkp911nRXIXW1dw==
X-Google-Smtp-Source: ACHHUZ5XxytZ+g2BrkYZQoVx7nqOBf+vXIM/V1vdr+Ja+RP+3FAiiW4zcb6GQvuNgUZ8LUZweukffA==
X-Received: by 2002:ac2:5058:0:b0:4f8:67f0:724e with SMTP id
 a24-20020ac25058000000b004f867f0724emr14151726lfm.33.1687766807503; 
 Mon, 26 Jun 2023 01:06:47 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a7bcbd2000000b003f90846d8a7sm10033817wmi.6.2023.06.26.01.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:06:46 -0700 (PDT)
Message-ID: <42b497a0-e234-64db-e845-1c37b67839fc@linaro.org>
Date: Mon, 26 Jun 2023 10:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/26] tests/qtests: clean-up and fix leak in generic_fuzz
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/23/23 14:20, Alex Bennée wrote:
> An update to the clang tooling detects more issues with the code
> including a memory leak from the g_string_new() allocation. Clean up
> the code with g_autoptr and use ARRAY_SIZE while we are at it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/qtest/fuzz/generic_fuzz.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
> index c525d22951..a4841181cc 100644
> --- a/tests/qtest/fuzz/generic_fuzz.c
> +++ b/tests/qtest/fuzz/generic_fuzz.c
> @@ -954,17 +954,14 @@ static void register_generic_fuzz_targets(void)
>               .crossover = generic_fuzz_crossover
>       });
>   
> -    GString *name;
> +    g_autoptr(GString) name = g_string_new("");
>       const generic_fuzz_config *config;
>   
> -    for (int i = 0;
> -         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
> -         i++) {
> +    for (int i = 0; i < ARRAY_SIZE(predefined_configs); i++) {
>           config = predefined_configs + i;
> -        name = g_string_new("generic-fuzz");
> -        g_string_append_printf(name, "-%s", config->name);
> +        g_string_printf(name, "generic-fuzz-%s", config->name);
>           fuzz_add_target(&(FuzzTarget){
> -                .name = name->str,
> +                .name = g_strdup(name->str),
>                   .description = "Predefined generic-fuzz config.",
>                   .get_init_cmdline = generic_fuzz_predefined_config_cmdline,
>                   .pre_fuzz = generic_pre_fuzz,

This is

   .name = g_strconcat("generic-fuzz-", config->name, NULL),

without the extra GString or printf stuff.


r~

