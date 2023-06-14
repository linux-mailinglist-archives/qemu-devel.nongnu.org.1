Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6452572F463
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 08:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Jc1-0004nQ-Up; Wed, 14 Jun 2023 02:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9Jbz-0004im-4E
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 02:04:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9Jbx-0004XZ-JR
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 02:04:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f739ec88b2so1734205e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 23:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686722644; x=1689314644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hzsdbb2DRisex8V+DOn+ush1cRPMFQbkp/xo4X0VBRo=;
 b=jzOgqsKmXoBpAze/Uf3d24jK3GeHqmP79KjVic/whHm7sfWR2J7GCKuoFc8I9hZXoJ
 uxqE75sixzkrA3ZOfdDLl/2dtzOPs/GeOkRjEY+is8urbQ/qGQ7bD61QzPns5VgUMcq9
 wygifep0Yfcae6z7mn7nPGEssvdGKfU9j6Ili8rvZOgAD8/l9Tang57TPRWkag/Ta0Zw
 rYKGrf9DjPexkFQwjeulcdUjAA9IAQt6Yndg7pTz4ZdlVNoeVMOfgSjrnCndpsT2cIbq
 DJkV7KnPMFV9CgbTpP6tymojGfZzM+IEdBsMSBFO6N1mWgUGOF9CD9j6dQlPm8tploOV
 0oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686722644; x=1689314644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hzsdbb2DRisex8V+DOn+ush1cRPMFQbkp/xo4X0VBRo=;
 b=ind3eAUdgXDq63s0NRTa31u43Q3zulteIHjBfcB3cexJCXjjmOsPZmBdXvE4FSFQ/k
 NbABmOvoSO4AOXVwartIhvrfrTmKP0VS4skUcFsT/qkt1qCWriKjXD436HNVJEdeWN4V
 GkSB2jS1grPL/+vo8a6Ug4dGfbbJxa4W6+jiQm8+MPod52JIRxUyxRe1YdTlcXnhSyf7
 8xXkUcwV7VnZ7Gtz38NdK2BrxFow42GDoNT7sBCXBEc9Vr5i+dgqMYYTJDHMjbREPtbD
 I2ULF0AVrKFKAIUnOPnMK/ox9MlgP1yeejGhy2yitD2ADUG8UE2gCzOKqmxjwEMR1bKH
 FrDA==
X-Gm-Message-State: AC+VfDyfriqNyPOPaHfPooAq3K2DULCNJvY1jlwNzQQ5WFQB5/WsmUlt
 js2/LuFY+r9rCqx4r/MOLN5Upg==
X-Google-Smtp-Source: ACHHUZ6zWtoudwfvqPXDcF7UiUE1klmZ5SBTZwWKzEcM42r1qqcntt68v3rIwtS60GjcXZfwrHMPNA==
X-Received: by 2002:adf:ef0b:0:b0:30a:e9cb:1a2e with SMTP id
 e11-20020adfef0b000000b0030ae9cb1a2emr7180046wro.65.1686722643833; 
 Tue, 13 Jun 2023 23:04:03 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 u13-20020adfeb4d000000b00301a351a8d6sm17114476wrn.84.2023.06.13.23.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 23:04:03 -0700 (PDT)
Message-ID: <7f19c83f-1fdd-7624-0053-e691ea63966d@linaro.org>
Date: Wed, 14 Jun 2023 08:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v3 3/4] hw/misc/bcm2835_property: Replace magic
 frequency values by definitions
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230612223456.33824-1-philmd@linaro.org>
 <20230612223456.33824-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230612223456.33824-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 6/13/23 00:34, Philippe Mathieu-Daudé wrote:
> From: Sergey Kambalin<sergey.kambalin@auriga.com>
> 
> Signed-off-by: Sergey Kambalin<sergey.kambalin@auriga.com>
> Message-Id:<20230531155258.8361-1-sergey.kambalin@auriga.com>
> [PMD: Split from bigger patch: 4/4]
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> FIXME: RPI_FIRMWARE_DEFAULT_CLK_RATE is raspi1-specific... Good enough for now?
> ---
>   include/hw/arm/raspi_platform.h | 5 +++++
>   hw/misc/bcm2835_property.c      | 8 +++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

