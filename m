Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D4C7D042A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:48:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtarh-0002OO-HU; Thu, 19 Oct 2023 17:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtarf-0002O6-S5
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:47:35 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtare-0003LQ-9g
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:47:35 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53e70b0a218so138099a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697752052; x=1698356852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jByMSKTDHdidYhvmqVnVXF7CIedHsc8SEDpM8Ex758o=;
 b=N+zDZ4pIAmmdqfgVVh6+Ve8/jDUgncSKooXpU04XmZWvdI47vGAk077FCCf2Aj+SRA
 RG4SGYAqd1JJ4Yy6dwOy+SgUD4gZsBzqjVHsqpX1W34oC3THSydfZRQUzV2HpfWjl0a9
 6NjCS0z8CmXRs3T0gA9fPIYX41G/nk3vmM0FmQ+7T/f5i+XkD0ASYCYI+QRWpY90ziXV
 Vth0BbB7YmAP9/urem8JnqDm3hoDkA9Q1U2IEorhiamJLEmdiLME4p7HU4pn7JrhPXmo
 vMjtV+gslajtrdjKfjZFCWQW/igZzpStkWUZjjIm9WlaWgoREr6f6lhZG+7Mu0Yiq77c
 7CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697752052; x=1698356852;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jByMSKTDHdidYhvmqVnVXF7CIedHsc8SEDpM8Ex758o=;
 b=PFQdoAx5pCRZP8gb3mdFgSvWv2URTNBlyF99ljSw//a0vx7faMovDduRnhJZr9hinx
 TMGpBaOyFwMifOnogXC69qxVmodzzaxyYI8CoWIiYk/j1kPOszCy3pHaj/9xIHWS880T
 IxuXyoJCKOLoblG2QgoUKaJLWypOMYZ4c0CLR6tagQ5jY/R5f9u7IDp8WYo+egWcFYoN
 Kg0PXZCIosjr5FEBug60oIva+BB+nEvVauoIDRR/qAj+BvqvkqAI+GCN6e9sMnHid8EP
 LTJxoBbzn/GGqOi5ZCqKWrw1PU/gtUNiOd3Cz5NOSsyPWadK5M7VYz2vbGElWzNANgF7
 HxsA==
X-Gm-Message-State: AOJu0YwwCgyTHS0biCGfGYn6bX7nPwT8Obn0B5vO20cxG5EWHGbrqqOC
 4mQgqZVz03mg6dd6V8hDKhwfnXqIqk+nY/qCXWuJUA==
X-Google-Smtp-Source: AGHT+IE+7tD+s14jikzLDB02Wc5SXzuEJzibhcV+ZhYdLhGFArTlGPJhJjXOaeqlyx7hOHyZZZkrVQ==
X-Received: by 2002:a17:907:3da2:b0:9be:e153:3f24 with SMTP id
 he34-20020a1709073da200b009bee1533f24mr2795599ejc.63.1697752052326; 
 Thu, 19 Oct 2023 14:47:32 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 me26-20020a170906aeda00b00997e00e78e6sm231032ejb.112.2023.10.19.14.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:47:32 -0700 (PDT)
Message-ID: <2f3a1b99-6a09-4a30-5875-bead957c4fed@linaro.org>
Date: Thu, 19 Oct 2023 23:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] hw/input/stellaris_gamepad: Convert to
 qemu_input_handler_register()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
 <20231017122302.1692902-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017122302.1692902-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Peter,

On 17/10/23 14:23, Peter Maydell wrote:
> Now that we have converted to qdev, we can use the newer
> qemu_input_handler_register() API rather than the legacy
> qemu_add_kbd_event_handler().
> 
> Since we only have one user, take the opportunity to convert
> from scancodes to QCodes, rather than using
> qemu_input_key_value_to_scancode() (which adds an 0xe0
> prefix and encodes up/down indication in the scancode,
> which our old handler function then had to reverse). That
> lets us drop the old state field which was tracking whether
> we were halfway through a two-byte scancode.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/input/stellaris_gamepad.h |  2 +-
>   hw/arm/stellaris.c                   |  6 ++++-
>   hw/input/stellaris_gamepad.c         | 33 +++++++++++++---------------
>   3 files changed, 21 insertions(+), 20 deletions(-)

If 
https://lore.kernel.org/qemu-devel/20231019211814.30576-47-philmd@linaro.org/
gets merged before you respin, this structure needs to be declared
const:

> +static QemuInputHandler stellaris_gamepad_handler = {
> +    .name = "Stellaris Gamepad",
> +    .mask = INPUT_EVENT_MASK_KEY,
> +    .event = stellaris_gamepad_event,
> +};


