Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3795478D422
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:33:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGdT-0000g1-IB; Wed, 30 Aug 2023 04:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbGdS-0000bO-2K
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:33:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbGdP-0004OT-4V
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:33:09 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso4207960f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693384385; x=1693989185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LkrL4NdYmvE3rPS5Wg2IOg1d5N37QWBFCErJIfFx3jk=;
 b=UGwoK9OhuuI2rFzOEgBQ+AsLlQKuO/S5seK7xYpOTpa4OQ6Zyd5A65XKabUFJsejHq
 1zcCqZ+y+jCf4YNAZ8R3YHX1vyLfWQpFZYdahugvMVdSMlpjEZeCXlORYZsgU87Nt3GB
 rl4h1BiaQtxg2h1l9t8l06ckPdKhhk7ArqWhFqo4AWyTaIKzD/9DFzGXsCSBmdl6kdk7
 dQ16EiNfSc9ztrN+/V5QDM0nwFzsHgA5lm3TjkqQQnt3w2kJ5kgSOanc/JFgIaG1BpO9
 Pv9cX8CHaa4oH4rGPpSKN8GFK7a4kUaBwIqm/szckeI+ga5j+WhmcPZBGn4E1txafmZD
 yG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693384385; x=1693989185;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LkrL4NdYmvE3rPS5Wg2IOg1d5N37QWBFCErJIfFx3jk=;
 b=cAksvxjmhWKDpboF+Viq9fIiYMt5q8cnrCCDpvv+JP5TzdVV92hbBIa88Fv8vhwaem
 Pa9ZkhI2zOrpINArYPJC93zjQZTxqvWGe4vVt51x1q0oZineOLcSSQrEgO7W0KlyFa2q
 K0dVplTrF2zISfIRtneygrZhH53rRr9lUv5xOBwcwHJQ+KOO/i06xK98jrsiKRV0CflW
 qDvtYTHGyc4u8JAu7COKHIffR2hmihnmxjzAKOwCwRnl7gvlSF0ZdAwwmlLF618AObiN
 z0UwBAM8BsqOloyf5lb2y33+MFHqdHqs9IOwT1Pyyfln7uaIPObJM5RWg0jv40uE5LdQ
 tjiQ==
X-Gm-Message-State: AOJu0Ywj2jKGJPsIPJGUdYyOInIuT6erzlcYWuQ6Seux/y2EOv0JGSb8
 X4ydjRryAB3sQhtt9bq2XIpBUg==
X-Google-Smtp-Source: AGHT+IGseNbNXRsyVdB8d3WKK2dmc3+cX7BMbdEZSX4wduB9lxHpQFl+b+HOe8L0BmFwxtwnEuJKMg==
X-Received: by 2002:adf:f9c2:0:b0:319:7134:a3cf with SMTP id
 w2-20020adff9c2000000b003197134a3cfmr1195845wrr.31.1693384385529; 
 Wed, 30 Aug 2023 01:33:05 -0700 (PDT)
Received: from [192.168.32.175] (123.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.123]) by smtp.gmail.com with ESMTPSA id
 w12-20020a5d4b4c000000b0031416362e23sm16038420wrs.3.2023.08.30.01.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 01:33:05 -0700 (PDT)
Message-ID: <eab126a5-7d4e-5251-3a85-d6e95cd2c491@linaro.org>
Date: Wed, 30 Aug 2023 10:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH for-8.2 3/3] hw/arm: Set number of MPU regions correctly
 for an505, an521, an524
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230724174335.2150499-1-peter.maydell@linaro.org>
 <20230724174335.2150499-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230724174335.2150499-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 24/7/23 19:43, Peter Maydell wrote:
> The IoTKit, SSE200 and SSE300 all default to 8 MPU regions.  The
> MPS2/MPS3 FPGA images don't override these except in the case of
> AN547, which uses 16 MPU regions.
> 
> Define properties on the ARMSSE object for the MPU regions (using the
> same names as the documented RTL configuration settings, and
> following the pattern we already have for this device of using
> all-caps names as the RTL does), and set them in the board code.
> 
> We don't actually need to override the default except on AN547,
> but it's simpler code to have the board code set them always
> rather than tracking which board subtypes want to set them to
> a non-default value separately from what that value is.
> 
> Tho overall effect is that for mps2-an505, mps2-an521 and mps3-an524
> we now correctly use 8 MPU regions, while mps3-an547 stays at its
> current 16 regions.
> 
> It's possible some guest code wrongly depended on the previous
> incorrectly modeled number of memory regions. (Such guest code
> should ideally check the number of regions via the MPU_TYPE
> register.) The old behaviour can be obtained with additional
> -global arguments to QEMU:
> 
> For mps2-an521 and mps2-an524:
>   -global sse-200.CPU0_MPU_NS=16 -global sse-200.CPU0_MPU_S=16 -global sse-200.CPU1_MPU_NS=16 -global sse-200.CPU1_MPU_S=16
> 
> For mps2-an505:
>   -global sse-200.CPU0_MPU_NS=16 -global sse-200.CPU0_MPU_S=16
> 
> NB that the way the implementation allows this use of -global
> is slightly fragile: if the board code explicitly sets the
> properties on the sse-200 object, this overrides the -global
> command line option. So we rely on:
>   - the boards that need fixing all happen to use the SSE defaults
>   - we can write the board code to only set the property if it
>     is different from the default, rather than having all boards
>     explicitly set the property
>   - the board that does need to use a non-default value happens
>     to need to set it to the same value (16) we previously used
> This works, but there are some kinds of refactoring of the
> mps2-tz.c code that would break the support for -global here.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1772
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm not super-enthusiastic about the -global handling here, as you
> may have guessed from the wording above, though it does avoid having
> explicit back-compat code.  The other option for back-compat would be
> to add an explicit board property to say "use the old values".
> ---
>   include/hw/arm/armsse.h |  5 +++++
>   hw/arm/armsse.c         | 16 ++++++++++++++++
>   hw/arm/mps2-tz.c        | 29 +++++++++++++++++++++++++++++
>   3 files changed, 50 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


