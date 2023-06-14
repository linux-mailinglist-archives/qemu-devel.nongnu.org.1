Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9945772FFF0
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 15:23:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9PlG-0002fE-5F; Wed, 14 Jun 2023 08:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9Pl3-0002cO-O7
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:37:53 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9Pl0-0002Jc-QK
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:37:53 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-977ed383b8aso106328966b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686746269; x=1689338269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZLNB7YXANmg/7KCrAhVUC2d8nFaEDBnbf3IFLm52OCw=;
 b=kt9Gd/IimNM7Dc1t/GDRpflBgbsSyivK3Z+XJtWWjaGWD3Elez5YiZ6Ej0yr+koO5P
 L0PMA1ltxDHe/JTKGjlJpzs5/e9fhlcLI/5u1Kaa2NjtB2XpdY+O+AuTciV3gsqP6H3g
 3n05We9+zJgDfoj/CZI/dwQOgMjqL5WT+7QbMeviMU8eT3xmaF6CMiTNyYPIo5hvJFQd
 RSvG5knqhKRxlhJmbPzsKyzClhlotkrzqTLBcW+lbeDyvYKJ3bD/xikgWuvbnReJoGqI
 uKUhgtKpjTELUEcBmYqAU2/p7KGcWBuqQYK8/NCaKGc/Jv4k2L6xWmuiHC1P7LuAsSYF
 dM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686746269; x=1689338269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLNB7YXANmg/7KCrAhVUC2d8nFaEDBnbf3IFLm52OCw=;
 b=NOEEVqXvXmnpFYU2pNjmF+GwyuasszNP6Db5esm2CY00PHBvQr5ZUjq4ghpV5ockCE
 nMwLozbda1cz50bEMY7qIVe/YISbs+VwUTHhjAqt0eyko9od2kVq31hcYcf6xYuhw0De
 vCM2D3TYjHj3kU+KbC5PjC0Wb6a/SwadmvlEx0fv0+CzFpbZ/JKS3SHFBZC+/lWI51v4
 C4CjLcYfkejWEDgh7ebVFAkmppupp/va5NHuIBh0eXQ5bUi2hoKxn8/QaIuB8tElj2bn
 tTYjekBKcy5Yds/YgG3cKIi/r5IvR5HvUFpnqBtbBakkon/OzkX/Ffx/DB4Azcsl6hNl
 2e0g==
X-Gm-Message-State: AC+VfDyvm8TA78NZYSHichXfo51Cqc8SkRMg30iS4AWmgCHm3ihhF5fM
 bFcs6JjLo7GXFBl+jcAkQglrWw==
X-Google-Smtp-Source: ACHHUZ5uWczDqJiyLuLUd0QL60th27xXzGPrPKN1w8VzAG4R049b7kvxOk2EH6YTCiu9SfsZDZx4eA==
X-Received: by 2002:a17:907:6d1e:b0:97a:e0c0:2f91 with SMTP id
 sa30-20020a1709076d1e00b0097ae0c02f91mr14120835ejc.8.1686746268916; 
 Wed, 14 Jun 2023 05:37:48 -0700 (PDT)
Received: from [10.14.201.118] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 e26-20020a170906045a00b0096fc35ca733sm7903232eja.41.2023.06.14.05.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 05:37:48 -0700 (PDT)
Message-ID: <9e51e81c-49d0-3fa3-69cb-dc7df7e1b3af@linaro.org>
Date: Wed, 14 Jun 2023 14:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 22/26] target/arm/tcg: Reduce 'helper-m.h.inc' inclusion
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-23-philmd@linaro.org>
 <96940129-08a9-97bb-db71-236789d5b373@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <96940129-08a9-97bb-db71-236789d5b373@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 14/6/23 06:55, Richard Henderson wrote:
> On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
>> +++ b/target/arm/tcg/translate.c
>> @@ -37,6 +37,11 @@
>>   #include "exec/helper-gen.h.inc"
>>   #undef  HELPER_H
>> +#define HELPER_H "tcg/helper-m.h.inc"
>> +#include "exec/helper-proto.h.inc"
>> +#include "exec/helper-gen.h.inc"
>> +#undef  HELPER_H
> 
> You don't need helper-proto.h here do you?

Right, rebase left-over...

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


