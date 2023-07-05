Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D81D748833
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:41:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4cN-0008D5-HC; Wed, 05 Jul 2023 11:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4cK-0008Cm-Ah
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:40:32 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4cI-0000oY-M4
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:40:32 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b63e5f94f1so11633131fa.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571629; x=1691163629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=53KVq7Nq9uCiBVBBdxVtz201TxrVN46PUmnFMXsFHBY=;
 b=bEvx7KNF4xah8GqIq1T8H8kVAnZsQCZTr+M4sckOA3vVDg89CA8yuqm9OQ1saT32jZ
 TZ+jzo6UtG2Yj7A5Whr9grz6TN+67uwH25/ET2I6ZX+Up3IbhGT4tBqsufR7JW0Wj+N0
 wl5wxsBA26TT5UaaAuyLMTyi7hXGDtUe9bqftcEyqI16tlm0CGvbu6EkO7uibxsCtz31
 1xvfsJNr5X+TDfOKpx3U3BJeR1jzZFYgcUcOIbswG/jeYu1x/Z+877MWF2urXmloRzw1
 xa9ReBcKuiFws7A5SBC2DcD/tHUCdDuKUAUCQNvuZ6nTGHkuQox/pEHyyvu2VKIn67Cw
 e8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571629; x=1691163629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53KVq7Nq9uCiBVBBdxVtz201TxrVN46PUmnFMXsFHBY=;
 b=ko2GofVSPYE9NrmCmE+4wrE1TNVehpghb82Hy+6Zx9fi/lWJXAStgzaN3rOaw6e8rB
 jMZbTMWINJTWegjBah8H/IvblippHA6KTpolPkwSLEUYN/2DnEOZa6riu6XmwN0c+cKz
 7geVzVBwp6Sluvk92w4hB/ybOPEbn/oy4whSjDp/7aYp92jJi43kW7S7Xo84nvhjh6qx
 zB2kjOetGeIBPOyb4gwuTc+2ZkOn0dDOvOYRafgNlWjWHR0vDz7RQcb348MkzO96I3J1
 9sw95KugravoOxFgN4D5szEbcf9fIGZ+pF8i8Rn8KFrvZhqJD/9kyaAjVxaOw7zgk4g4
 aEOg==
X-Gm-Message-State: ABy/qLZ0cRzrMhqlJzpK1vjPSyQhnHzIch55qS7Wj8MMuWG8uhUfwhXA
 fz/lOVhhopamNnBB9dzu2SBuxw==
X-Google-Smtp-Source: APBJJlFcUI61jVpNxkcs72eMMF8WPlU53v0JXwnLAv7GfcG+2IVvMsduHimhEYdY7l5o+1k7hfPgKA==
X-Received: by 2002:a05:651c:339:b0:2b6:9e82:446 with SMTP id
 b25-20020a05651c033900b002b69e820446mr1053715ljp.0.1688571628693; 
 Wed, 05 Jul 2023 08:40:28 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a2ea0c8000000b002b6fcce5e5fsm518666ljm.113.2023.07.05.08.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:40:28 -0700 (PDT)
Message-ID: <c7c73add-6f38-56ec-2a25-b4fb2a213f5a@linaro.org>
Date: Wed, 5 Jul 2023 17:40:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 15/19] hw/timer/arm_timer: Fix misuse of SysBus IRQ in
 IntegratorPIT
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/4/23 16:50, Philippe Mathieu-Daudé wrote:
> SysBus IRQ are*output*  IRQs. As some sort of simplification
> to avoid to forward it, IntegratorPIT misuses it as ARM timer
> input IRQ. Fix that by using a simple IRQ forwarder handler.
> 
> Note: sysbus_pass_irq() forwards GPIOs and IRQs from a container
> to an inner device but only work with an entire set of IRQs, so
> we can not use it here where we forward a single IRQ from each
> timer.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/arm_timer.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

