Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2D7CC3EA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:05:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjUy-0002L4-I7; Tue, 17 Oct 2023 08:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjUu-0002HP-3N
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:48:32 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjUi-0001Bu-S0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:48:31 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so907323266b.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697546899; x=1698151699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YlHuA2uoNWxtLjQaJ6jG5mttnQNTAHKXn44yFnClLpg=;
 b=b660ZHcR+CT7ule9nDJF9Hs1XGCTzHlWwG1Iwc3kBOvOus5N2zpcJKlmGxNoMGI87v
 Ib+hE1Ua64y0M/DlcGpN32Wz/QyFZtQXJuOkgA6pSVqRBLGVa/qDZw73lovEkJfEvY40
 /9awMGl5bs4UquuS7Ffs444PCk50ghuf12zqTeVBumMjIekqaQEBUxDJFSny2H8GW2yX
 4gR/ipJq2pjKNXgyxIeIbYzXjskz8my6gH6aVoVIaVUJyNvjxHWj8Y9SGDpFva7C4CRY
 ToXWEvoxnWOzXTH0z9VPXHoNT0friKvBVI7O5kmwqqJ0NzYsm40KLEWiQYwS3xwh/DEQ
 3gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546899; x=1698151699;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YlHuA2uoNWxtLjQaJ6jG5mttnQNTAHKXn44yFnClLpg=;
 b=MDuwhkTO/6FoqLt/32mEwQSXEC6z0Ahqb/rz7GAHKYdYAAeJ0mSUXBQD9dr7pTDnKB
 EE0R3Rz5zap76I41TbRV7V3d7dK7zi9i1DHM5MGtODdCYjdw6JavPP55h5lNBsVwi6yE
 H5dTc8jaF6r8ubFGiF6nnTSxOGNX38P631iFkKtvZeEtAZdZAN/0IoaY4zYQRAOpPuQ+
 Q/WhNpRlNHWCeWOKbFxc8u80tcpQMXKd1/MI0Aw74gQnzrC8uKm5tFTcICk+oB/n2qmr
 WlCmqrrthzHx33HzMbJdjGjb/87KOfXNrgbG0okFk3e02ddUJ3rCO5/oYbChHlwX1IT9
 Mivw==
X-Gm-Message-State: AOJu0YwTOC5r/4vwo7cAHMzf/9L7mzteHHJywlqYYXN3xXCINDaJjYbq
 Os3NRASxvJnN5yU0BSM/DttsYg==
X-Google-Smtp-Source: AGHT+IHPQckCDDNteDRfWp6WdmE4YmPH7rftseur4qG46kRWlcui2jDk/qLJj1++awDY+MEL5Z7ftg==
X-Received: by 2002:a17:907:2ce6:b0:9ae:3d17:d5d0 with SMTP id
 hz6-20020a1709072ce600b009ae3d17d5d0mr1560919ejc.31.1697546899394; 
 Tue, 17 Oct 2023 05:48:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 cw5-20020a170906c78500b009ad8d444be4sm1184475ejb.43.2023.10.17.05.48.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 05:48:18 -0700 (PDT)
Message-ID: <f85817c0-df0f-6e71-c5d4-61e6f2082a75@linaro.org>
Date: Tue, 17 Oct 2023 14:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 5/6] hw/input/stellaris_input: Convert to qdev
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
 <20231017122302.1692902-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017122302.1692902-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 17/10/23 14:23, Peter Maydell wrote:
> Convert the hw/input/stellaris_input device to qdev.
> 
> The interface uses an array property for the board to specify the
> keycodes to use, so the s->keycodes memory is now allocated by the
> array-property machinery.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/input/stellaris_gamepad.h | 25 +++++++++-
>   hw/arm/stellaris.c                   | 26 +++++++---
>   hw/input/stellaris_gamepad.c         | 73 +++++++++++++++++++---------
>   3 files changed, 92 insertions(+), 32 deletions(-)


> +#define TYPE_STELLARIS_GAMEPAD "stellaris-gamepad"
> +OBJECT_DECLARE_SIMPLE_TYPE(StellarisGamepad, STELLARIS_GAMEPAD)
> +
> +struct StellarisGamepad {
> +    /*< private >*/

Since commit 067109a11c ("docs/devel: mention the spacing requirement
for QOM") we don't use these private/public comments anymore.

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    uint32_t num_buttons;
> +    qemu_irq *irqs;
> +    uint32_t *keycodes;
> +    uint8_t *pressed;
> +    int extension;
> +};


