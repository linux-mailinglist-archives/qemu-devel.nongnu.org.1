Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A631F72F3D1
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IXY-0006kc-RC; Wed, 14 Jun 2023 00:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IXW-0006jo-E6
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:55:26 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IXU-0005XO-Sg
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:55:26 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b1bb2fc9c6so3554261fa.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718523; x=1689310523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0M/12ms2R1td4FYCkfV0A/uTWat9Q/VUDDXnu2dZQ2U=;
 b=qYrPZZpgilp/oBhFx4alD7XNo3erBZaDJyUqIdBhCTCyoKq2MXWJUYd3FEPD6Q1nfa
 NrxogRoo5D1iFYfQ3+T3/5jy0FeubwT76p9AlqJcBKDtRLjrUfQ6t3i+hJloFCXYWEOq
 6kWnx3WG7ozN12DmOf8Y6UR3YEousxde6VM40aM+ZrqBeZ1aM0MHrQAgagVCH/uWLtHl
 NED73VGjQPu79y9bGcZvBkeBpooAIU5hf73eB/JzVX+q1DIPWsgRloHgJVWNHNobvhhc
 V+YhbNkUfBpWR+CttKx82nllD4XkZKLEDmMYDzyKATqvgyJneD8snrD4cDznS/yYpAo2
 SUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718523; x=1689310523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0M/12ms2R1td4FYCkfV0A/uTWat9Q/VUDDXnu2dZQ2U=;
 b=MakBE9gHDJJC1BVoRi9dTJ4xZsOkibevBCPQHe2mz4xED6V5oHJLh/LKQifd37Xsbo
 kuRWvsOqO7x7rkP/fyvTLw6jVhsVj2eBm900aTEpwdwn6xwU1J6+eWuTWUhDkH/OfUDg
 5Vb5bjvF2cx5YEekQrQM6wpx7RKPUufGM7Jsf3MPy95gybDc0zp1nJScONZhc0lK4Ld3
 cUl7oqPyktMX+665wmd8doPAyo4eYDp0TRDzrqwAOHAESNXaG2r6Ng6YHXNX5+GCU6z7
 vVaMqlaRr8gQg6UjhcTW1/o8mRVgZ5E9h62209AkVSjzFKBe6YP4z7/icIsWe2LzYXv9
 JGuw==
X-Gm-Message-State: AC+VfDwHB8n8w/GyMrD+Q7/+hZMS5F9V5e0UDUIgbWqLuxjQr9asP2Rs
 j5TVEwtAHGPhIF/ncS/foRgGMQ==
X-Google-Smtp-Source: ACHHUZ7ZNTA2LCwiXS0IJ3zlfLGD8ioWZzac23npPD8jhyCTuvDe3i0IOkJHooViqZmPnXoBDCZRbg==
X-Received: by 2002:a2e:9bd8:0:b0:2b1:eba8:c23e with SMTP id
 w24-20020a2e9bd8000000b002b1eba8c23emr5622982ljj.27.1686718522879; 
 Tue, 13 Jun 2023 21:55:22 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a05600c378600b003f42d8dd7d1sm16300623wmr.7.2023.06.13.21.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:55:22 -0700 (PDT)
Message-ID: <96940129-08a9-97bb-db71-236789d5b373@linaro.org>
Date: Wed, 14 Jun 2023 06:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 22/26] target/arm/tcg: Reduce 'helper-m.h.inc' inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-23-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
> +++ b/target/arm/tcg/translate.c
> @@ -37,6 +37,11 @@
>   #include "exec/helper-gen.h.inc"
>   #undef  HELPER_H
>   
> +#define HELPER_H "tcg/helper-m.h.inc"
> +#include "exec/helper-proto.h.inc"
> +#include "exec/helper-gen.h.inc"
> +#undef  HELPER_H

You don't need helper-proto.h here do you?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

