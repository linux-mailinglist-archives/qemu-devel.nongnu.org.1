Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E117190FE
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:10:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4YhB-0002qx-19; Wed, 31 May 2023 23:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yh9-0002qQ-FE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:09:47 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yh6-0001Qm-Qk
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:09:46 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-38dec65ab50so225837b6e.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 20:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685588983; x=1688180983;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=376KjYjs6cIczYw3jg1YphMynMdhpj5XTJNtf8c9HIE=;
 b=E9DASwS4NS9TW9ms3TYpHBm+sAIB2AIZCXflW15o0LuSG/l6oIA6LzEvaW8lnPac4C
 Yz5drjy+PNZsUfWaUIZbRx+A1MR+7R6I6lRkm7l628LWKN3IDXOgCGrmIWy4hN8sTU/C
 zGysWg1u146/drxfygxJ34pOYEBuJispDR60pneJ6TPJjJn9jMwKwCDk13n+U1YC+L27
 3roLkfUYPb3wmvi6lh4wSY308a7wAOCC5RHCcouYqaioQK5qunUzBlhKwnEOgThIxVIa
 SyMRCZ2+bngLA00wTnKTAtNBtUBx/dP+keHWC0TFxOOyhCKd5dEb/Or+9StZfUMow9KL
 VAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685588983; x=1688180983;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=376KjYjs6cIczYw3jg1YphMynMdhpj5XTJNtf8c9HIE=;
 b=D8kznhiBbouj99MYaPyul7/rwmggJkIfnRM69HnPMHT+J7rRMJOCrSC6YHomUmYXmn
 JFZaNSMbljoMfGb+4PABDTymlSdJv6q167X5wPcWbxUlHHyGWgNDhHk70+HMV9jZ5cvo
 SUdn0lbgdYgG2F2Pgln504mdkWaL4xjEKS9d2Cym+lfr21dZmzHljL6/I+z2XBJdEHuA
 roj0V6iVCWENTzvsTFzI/iAy7M/v1R8qh8R1lIx4V+s8EXgNvXPrgkCFUCIotTgFu53U
 c9rgqfORXdyH5hvQK41rJTvRW3dDPlH8bb4f3iWBQLEHoDdRkN7vAcqhEyY8t/8R2Y2W
 9dVA==
X-Gm-Message-State: AC+VfDwW6lqBX8d/LYimUVIVJQv/CAmAhY+YszVX2JgS98MpAlsrX87p
 HJiJlEaWNuVk9+5aiVN7+xkIMA==
X-Google-Smtp-Source: ACHHUZ6jTU2uQfmYKXugkXVsoW6UYQPiaVub8LhvE76PRdo+C9JnvArZ08MYe/s6KVXcMzQjZ/X4Xg==
X-Received: by 2002:a05:6808:8c2:b0:398:36a0:d42 with SMTP id
 k2-20020a05680808c200b0039836a00d42mr6020755oij.39.1685588983605; 
 Wed, 31 May 2023 20:09:43 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a170902760600b001b1920cffdasm751783pll.204.2023.05.31.20.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 20:09:43 -0700 (PDT)
Message-ID: <edddb52e-d8e3-55e7-6c16-869e08160125@linaro.org>
Date: Wed, 31 May 2023 20:09:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] hw/usb/hcd-xhci: Use sysbus_init_irqs()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230531223341.34827-1-philmd@linaro.org>
 <20230531223341.34827-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531223341.34827-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/31/23 15:33, Philippe Mathieu-Daudé wrote:
> The SYSBUS_DEVICE_GPIO_IRQ definition should be internal to
> the SysBus API. Use the recently introduced sysbus_init_irqs()
> method to avoid using this internal definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/usb/hcd-xhci-sysbus.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

