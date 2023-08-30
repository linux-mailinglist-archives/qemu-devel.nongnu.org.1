Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B878D6F5
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbN4L-0000PC-Hz; Wed, 30 Aug 2023 11:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbN4J-0000P3-QC
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:25:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbN4F-0000Ns-SX
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:25:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so51803335e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693409113; x=1694013913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ivrglc4YP6SuS5Vm+jZAsGr1koeCbx+EG330WyUoBY0=;
 b=diTcYbarMArhf7YlvrLF37wurRU3qWtNO0NRMZvtcCmUz6BQ7oAKf+SKxHjk/w9rqS
 RlKkFN5cEOoIDAvbDDuL4TLjCKHPmuKOOSSdN42C2Mt53j5AJiFREcAGnpWSJcbi+J/U
 CpwgsGWJqLv/gKoRuzQmo5p2In1EiBg6k2g6yuKui36d83dnhy0wMFZuzL7Dh0dnw9nQ
 SOaaFu7w2gxm8sKqQncIpTX1h6BKYT1BlKjxUgliNQ6D+CGLyRp7X8oXUYsqswXnhEKa
 9TwFMMUSlT9UZcsVvl2ddnXVyYMZ5wtuHt2pn0/txUOZtSx6ECvK+1UBHlMaChBEL5Td
 yuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693409113; x=1694013913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ivrglc4YP6SuS5Vm+jZAsGr1koeCbx+EG330WyUoBY0=;
 b=UAapUGfQk0phm/j8xfi9/yTGvzZzVNEN8v+VdBnr0LL+/VxWYAbuBdlklTeCVnhTdS
 Wn9cIWalbY7a/qXrT9Q/QwbPHzC3BQZ3RDAwxg4p8tcP+MoXVkY2iDjgBFfQd1BO8/Cq
 8ou7kNk45MYeIpq4cckCOZ2/FMKMU62LqHrlT1ZUO09/Qo4LEwo4ngIelclIKEBfBTPe
 edK0V0G1BN/5gyNIacpAXWJtKhNPuHu5P6Y1VTuyhYEvzSLRU0ZNP3PbJBO5hfvdCPJT
 xVf1NURe6Z7CpoV3pO4I1wp2G5Wo6poUuU8xQCUEeI0o9VEXyMdf7nL276XCa4hsKpKf
 /8Hg==
X-Gm-Message-State: AOJu0Yz5F6LoFExBqXNKoIRLQaF2oypObgdPJeCzYHDz3UcwN0IFTAz7
 vdaDFa17VkNfgvPwXjE9XWo67g==
X-Google-Smtp-Source: AGHT+IH/BoG9elSrI192oZnaGrxAr/1+pQ4ypSLFz1/EJ4hYhAnQ3qE1OshgCL3FoO/PfoZc6zUDWw==
X-Received: by 2002:a05:600c:2288:b0:3fb:a100:2581 with SMTP id
 8-20020a05600c228800b003fba1002581mr2012057wmf.14.1693409113253; 
 Wed, 30 Aug 2023 08:25:13 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 z23-20020a1c4c17000000b00401d8181f8bsm2575633wmf.25.2023.08.30.08.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:25:12 -0700 (PDT)
Message-ID: <9d2d6517-7f2d-6bbf-fbd5-879a1fec81ab@linaro.org>
Date: Wed, 30 Aug 2023 17:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 64/67] arm/kconfig: XLNX_ZYNQMP_ARM depends on PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-65-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-65-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The Display Port has some strong PIXMAN dependency.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/arm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 7e68348440..7ea956b286 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -451,7 +451,7 @@ config STM32F405_SOC
>   config XLNX_ZYNQMP_ARM
>       bool
>       default y
> -    depends on TCG && AARCH64
> +    depends on TCG && AARCH64 && PIXMAN

Better would be to add a proper Kconfig XLNX_DISPLAYPORT.

>       select AHCI
>       select ARM_GIC
>       select CADENCE


