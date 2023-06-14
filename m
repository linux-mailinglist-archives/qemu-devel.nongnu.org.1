Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA772F3CD
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:53:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IVO-0004lx-PC; Wed, 14 Jun 2023 00:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IVM-0004jc-7H
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:53:12 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IVK-00056y-JV
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:53:11 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f629ccb8ebso7812702e87.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718389; x=1689310389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DhQoA09t3FyQijGD8o7KHuGvrnMyeMr+rdGpHP0//JY=;
 b=KbO7Wn/ClU/SXoOnStSR2tn8aq4YSbDgZ3xrTIa7bYlBLiskIxgACfmf1Z3CxU0xUt
 8AYsj5sboGQ6+1fvr1Rtil/H/GQZLaK7IGBxJrK/kFyWMrYJGtQCpMsQdsmTGDXhokQ0
 QQRt0WWGNsmo5aj9bVuA+hHOMpRDJC4fxTaioBcFLmNcw9CxXQgBnFBOOvsxkknY4FET
 /cda6HDSzuvOX6LO8BAOymOPKuza9uV45PZAw5DhmRaS6R9uxg92nsrgoYvgN4qDO9BZ
 v6X+7dOtTFWux/apOg1LZ+p47ZH0xptUfoUiOn72VHj9JB9zdW8GIBlHwlhOU7lmWTLd
 8w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718389; x=1689310389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DhQoA09t3FyQijGD8o7KHuGvrnMyeMr+rdGpHP0//JY=;
 b=CH4sNG59hpfjDqRoXS5G18S6H3I1ckYcaREf7977aODaVQHG+kuUjcE86yLJtIl1wu
 mZEbecR++yAxGfl3x5dC/G6vQjdk9iYG+iPnBfFKB5oMxwyIUPPWa7S80uihulbp4Emd
 3cbJ9hdEM1wpkHyFvP4wLVbDx7BUBPcgpo/7oupvyR6RALwapIEzRMLJL7LaBti+9bTm
 PoTzLSczFCfYfV19sHHvx+DgR1yZaFzzTWwCKJEfPMvnu0AAaI6u4hk+SM4bJJrgeKWn
 QEoKCmbYjqjjRDwgUMZ3wmZOiYsnfCJFjN4wv5u1lVsyUpzTJo4ZFUzsYWPgsBwS++ya
 lu2g==
X-Gm-Message-State: AC+VfDyvS//VdljvWqJLbQiHZLKRaLEn0mQHLaDN8feA0vkIWfYW0GKg
 Rv9UOdcKamlBmimhaxwBsU6ScQ==
X-Google-Smtp-Source: ACHHUZ7J75Hi8B7dj1uGXcLUfz4ZTZw6LHcpL6VTQ70xvK9rZAexDEiPgHSCwQSehKq3hcu/4tMAhg==
X-Received: by 2002:a19:e04b:0:b0:4f3:895f:f3f8 with SMTP id
 g11-20020a19e04b000000b004f3895ff3f8mr5707326lfj.16.1686718388875; 
 Tue, 13 Jun 2023 21:53:08 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a1c770f000000b003f8d0308604sm3238280wmi.9.2023.06.13.21.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:53:08 -0700 (PDT)
Message-ID: <6709f34f-af52-751e-6c3a-08504319b12e@linaro.org>
Date: Wed, 14 Jun 2023 06:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 20/26] target/arm/tcg: Move v8m_stackcheck() from
 op_helper.c to m_helper.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-21-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
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

On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
> No need to have the v8m_stackcheck() helper in the generic
> op_helper.c, move it with the rest of the M-profile helpers.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/m_helper.c  | 16 ++++++++++++++++
>   target/arm/tcg/op_helper.c | 16 ----------------
>   2 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

