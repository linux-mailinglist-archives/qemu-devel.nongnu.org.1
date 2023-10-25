Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1927D6CA1
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:02:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvdW8-0001ee-35; Wed, 25 Oct 2023 09:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvdVf-0001NS-As
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:01:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvdVd-0001jn-Ic
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:01:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso44450985e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698238875; x=1698843675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UGYfFD6FZuCoZ0+PVEeRuRnNgK02r/WDHE/W/HQz5qE=;
 b=zg2H6/ceo2tL4HYJ8vfxi6m6/LnCiJ/QMRA2x5cN3DojrseYgdGA38AA58HnG3sb+I
 vclTeaB1CJwl5obuG4jCGg9iU0XXKnKmFYZ01SYhEzpSqWztJODmzWpmNMb5BfH10Xme
 5UQvmC/KV4UoIBeV80suE6EoD7+ozLxov220jIUa5LrS7vLLwPXtHTEmNcUSyWKuepFu
 bV7sfE8mc4nXa47TfY32RP8lm/eYVTYAKdolRYCmomykRMh5vTQazM/Lf+9o8SlrT6rg
 prjdfqirPVU4G82i6xnUNPxSSZeHAuTHw+6e/1Ox7viLTAhfcyNSV4kzebreR50iUTgg
 EgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698238875; x=1698843675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UGYfFD6FZuCoZ0+PVEeRuRnNgK02r/WDHE/W/HQz5qE=;
 b=Gw+tJhHa4jhAliksfkMEwD3lAyGBzLcVL8oJCItR5z2IHZB9RPJbAbHfc4yHKj0qP1
 c6vK6UBvQzzuZY/D8gCcV/QoC6uqLMjm0nCTAO9o1p8qZOx5soEUgIUUQGKtm+q6TSJP
 TtUa3TEXwWIX7HZCuvVAt9zTtQ2/i5FKgOnhZeUulMBCdb2xMWgjYpTWfbJHwnNlUrbn
 ZK1KTnNCh/c5ogK84XAg+3IYXpP53Y5mNkXnIia1TMwi5noUgmynQO7r32gigE7iowLu
 qa7uPCgJHyCVgVS+8aeXn8qHhQ/KQE8RzP0tLw1RKSwf8Qn17dUAb5mD0GaSGyyZ02OG
 F/Mw==
X-Gm-Message-State: AOJu0YzdPruTvujeN3k7S22wVUsYSa0yhFhNq3HGnwHvF25MuT9jPUXA
 qRANamXhnxnWApGQ5aTNiUVthgPOrjPrK4GrFnY=
X-Google-Smtp-Source: AGHT+IGodIUKopbmjOgwHBNEDKsUmBHWzaajDVLjgr296wY70QrWxl/KaPIiOTX1o/itFepHGLGvUQ==
X-Received: by 2002:a05:600c:4b96:b0:404:6ed9:98d1 with SMTP id
 e22-20020a05600c4b9600b004046ed998d1mr11496175wmp.41.1698238875438; 
 Wed, 25 Oct 2023 06:01:15 -0700 (PDT)
Received: from [192.168.69.115] (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c320900b0040644e699a0sm19205355wmp.45.2023.10.25.06.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 06:01:14 -0700 (PDT)
Message-ID: <721493f2-fe31-548e-83e8-d8d6bd3a53df@linaro.org>
Date: Wed, 25 Oct 2023 15:01:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 00/11] hw/arm/aspeed: Split AspeedSoCState per
 2400/2600/10x0
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20231024162423.40206-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231024162423.40206-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/10/23 18:24, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (11):
>    hw/arm/aspeed: Extract code common to all boards to a common file
>    hw/arm/aspeed: Rename aspeed_soc_init() as AST2400/2500 specific
>    hw/arm/aspeed: Rename aspeed_soc_realize() as AST2400/2500 specific
>    hw/arm/aspeed: Dynamically allocate AspeedMachineState::soc field
>    hw/arm/aspeed: Introduce TYPE_ASPEED10X0_SOC
>    hw/arm/aspeed: Introduce TYPE_ASPEED2600_SOC
>    hw/arm/aspeed: Introduce TYPE_ASPEED2400_SOC
>    hw/arm/aspeed: Check 'memory' link is set in common aspeed_soc_realize
>    hw/arm/aspeed: Move AspeedSoCState::armv7m to Aspeed10x0SoCState
>    hw/arm/aspeed: Move AspeedSoCState::a7mpcore to Aspeed2600SoCState
>    hw/arm/aspeed: Move AspeedSoCState::cpu/vic to Aspeed2400SoCState

Updating other reviewers, this series has been queued in
Cédric's ASPEED queue.

