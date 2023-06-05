Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9EA722654
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:49:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69e6-0003Kp-Ve; Mon, 05 Jun 2023 08:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69e0-0002wc-Sg
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:49:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69dw-0005qR-4S
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:49:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f732d37d7cso20727385e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969342; x=1688561342;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dNZuqPAEgbramDA0l1U7Y+ZkUDJE80aMGxKGtEr5I2w=;
 b=YVgcPCPkuxgt3SgkaOWTTwnTs7mjCI/5QI1itoTtEipmJ7DDSnrsBj5vRMLN4ZxXzA
 0XFQqepLrWwSJwZ7buzNFuRiIfw0MEmLxA6YIHTLhsoKAYSXQKv8rmadTDqQ5RhNZgyp
 KtXQjF4pUvmhzyxhOGK2HCiW2JryHyoCALLUPUX8P1mQo8GZv6tXIVUi0H2ITicelCXf
 ydiMMOdUl7o5JaSPz5eyVjgxX9ezQUJgqjrxRwr6X5nhtoknSCY4iOgxbc7QfTZlQ/fh
 IYtrig/9jHoBYbh/ST9bPBuT9dVcd+N3HIfHLMtYHRdSXgF397EduAieAK9HWpW1rrYd
 AQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969342; x=1688561342;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNZuqPAEgbramDA0l1U7Y+ZkUDJE80aMGxKGtEr5I2w=;
 b=d52l0RuYkBYcSUXgz7IiXHmipOGUXzZRYBawUa1LkqwoIxyyLtLw6gnJdwTTJFroKI
 YUB2AttFEDeW6+YqAKaCpm1a5fhL3ljuTlTCUJdstYtIvbQrm3OelmuCZ12BjZJOX6KM
 oCfTBSpoO8302fhzFXLvaxA2uqIdmvjcfHTDNsu9oJL1UdrEDWPyJspYuyS2Vqh1vYmf
 IJMe52WGyuWu14ch8ca/KQzf+tLEC1se9BEFINUBqAJYc/C64NB+f/PLffrCBrBkOyNE
 b3fKM8Ox8SNt/YKNvONeuHdVbMt9fDL4TRN7598ReRusM2rzwXoNGwonHhbnrhzjoWEZ
 /FUA==
X-Gm-Message-State: AC+VfDzwS+YxDEkbcc3g8TRvUljppNdz0dmxI/R4giccUljlzW6Ff4Iv
 7mlF6OZiUxABr1qx0kk6FfYVOA==
X-Google-Smtp-Source: ACHHUZ5FRbCprA/61iFR243w9HzDp4TA+SPLa9Ofo8PE2lV09J6Eh/aqkLHE97RqQjaMkbqRjQ70Hw==
X-Received: by 2002:a1c:7212:0:b0:3f6:128:36a5 with SMTP id
 n18-20020a1c7212000000b003f6012836a5mr7146491wmc.10.1685969342606; 
 Mon, 05 Jun 2023 05:49:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a1c7210000000b003f736e28cd6sm5354060wmc.4.2023.06.05.05.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:49:02 -0700 (PDT)
Message-ID: <4b4b5bb8-9e76-6aad-3181-097e0080a255@linaro.org>
Date: Mon, 5 Jun 2023 14:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 09/23] q800: introduce mac-io container memory region
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-10-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230604131450.428797-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/6/23 15:14, Mark Cave-Ayland wrote:
> Move all devices from the IO region to within the container in preparation
> for updating the IO aliasing mechanism.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/m68k/q800.c         | 6 ++++++
>   include/hw/m68k/q800.h | 1 +
>   2 files changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


