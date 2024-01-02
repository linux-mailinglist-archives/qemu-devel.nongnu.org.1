Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E9A821F5E
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 17:17:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKhQp-0004yn-L4; Tue, 02 Jan 2024 11:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhQe-0004u3-Fg
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:15:44 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhQb-0004IH-Dn
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:15:43 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3373a30af67so2056060f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 08:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704212139; x=1704816939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kHHTaMmaf3ppwIK2mjmf5zQwjb0h9+pVdKUcQkkWC5w=;
 b=an7a+SM14zD/EaxvWh5nE5IZ7NsmymuoclDcMbAwXI7zlxIyAM1a1p8pK4e4fvjcE2
 /Neh4f4m/G+Pr3ZcJnbG2E2HBcfcZVDIE1vNCr2OfN84qny+W+KSyaWFLKxuk5AarRMN
 hnveEtUzSEe2r/sbXWhNY++TopfCREl0KQ9RBubg8c2YEkBbOxRup2G/x/Jj9yOvIY8F
 Y+72sOGe8QufBYWsJm062JCPjXF74zzNnpKAbsWZgrcq029/9eTxHWGUF9mzlNpZih6G
 7+liViIAkxRI7a9DWwpnYqYX6ehS3/Oq8+QNaUko+an/p0AzOdK+mgZlEItZwTEpJ66L
 gCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704212139; x=1704816939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kHHTaMmaf3ppwIK2mjmf5zQwjb0h9+pVdKUcQkkWC5w=;
 b=CEMEpxl16V6qKRVjBPuI11NTyJsXs+06NOwZPLP68FWo9wOXGzp1ihZ6845wNzS8od
 v9r5JpheTR3zObFAh6BVeZvXHY48FE4KMYtL6nvN3qYO8IGQ9u1Em6GvcoDHUhG0YjwS
 JLQJdsatZ7AL9B9mIkkrz/gHrx+e/hrfRASBgaiHGlqtJfMNbBTnWmR3DTv9Jd1xZ94n
 Zw+ltgvp7gByV0NIVcdGZpyOBSBkP01foER5tsbsK8WJILapy9Vlcywg7hJQgTW75P/C
 cO2XHaL4YuxGDK3PPAQjU5v83gooTqhTVWqOQ2RBJatNfpa47hpmPYxH8JkucDsnEnCT
 aK3g==
X-Gm-Message-State: AOJu0YzWwg8NupvZdY2fYCy+s2sTBaAKKOa3/VNoX2ngibR43Ynol6or
 lrBqiGyzciQkQ44mP3rozJxSh390TZtsxQ==
X-Google-Smtp-Source: AGHT+IEeiO/lxozpbeVdVYkVdQgCa4ACsTIz+p1SvARmA1bxULapsJ7uYgQn5jewG9PH2Ey6SQaFYw==
X-Received: by 2002:adf:a4ce:0:b0:336:3df4:f293 with SMTP id
 h14-20020adfa4ce000000b003363df4f293mr6561417wrb.72.1704212138970; 
 Tue, 02 Jan 2024 08:15:38 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 x4-20020a5d54c4000000b0033662c2820bsm28590244wrv.117.2024.01.02.08.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 08:15:38 -0800 (PST)
Message-ID: <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
Date: Tue, 2 Jan 2024 17:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231212162935.42910-1-philmd@linaro.org>
 <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Cédric,

On 2/1/24 15:55, Cédric Le Goater wrote:
> On 12/12/23 17:29, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> When a MPCore cluster is used, the Cortex-A cores belong the the
>> cluster container, not to the board/soc layer. This series move
>> the creation of vCPUs to the MPCore private container.
>>
>> Doing so we consolidate the QOM model, moving common code in a
>> central place (abstract MPCore parent).
> 
> Changing the QOM hierarchy has an impact on the state of the machine
> and some fixups are then required to maintain migration compatibility.
> This can become a real headache for KVM machines like virt for which
> migration compatibility is a feature, less for emulated ones.

All changes are either moving properties (which are not migrated)
or moving non-migrated QOM members (i.e. pointers of ARMCPU, which
is still migrated elsewhere). So I don't see any obvious migration
problem, but I might be missing something, so I Cc'ed Juan :>

> 
> I don't have a good solution to propose to overcome this problem :/
> 
> C.
> 
> 
>>
>> This eventually allow removing one qemu_get_cpu() use, which we
>> want to remove in heterogeneous machines (machines using MPCore
>> are candidate for heterogeneous emulation).


>>   include/hw/arm/aspeed_soc.h    |   5 +-
>>   include/hw/arm/boot.h          |   4 +-
>>   include/hw/arm/exynos4210.h    |   6 +-
>>   include/hw/arm/fsl-imx6.h      |   6 +-
>>   include/hw/arm/fsl-imx6ul.h    |   8 +-
>>   include/hw/arm/fsl-imx7.h      |   8 +-
>>   include/hw/arm/npcm7xx.h       |   3 +-
>>   include/hw/cpu/a15mpcore.h     |  44 -------
>>   include/hw/cpu/a9mpcore.h      |  39 -------
>>   include/hw/cpu/cortex_mpcore.h | 135 ++++++++++++++++++++++

