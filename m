Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D500748822
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:35:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4Wi-0001Kf-LA; Wed, 05 Jul 2023 11:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4We-0001Ir-9d
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:34:40 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Wc-0007Gh-JC
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:34:39 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fb96e2b573so11160419e87.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571277; x=1691163277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YRT1GNxZuXOH+ykrEwU9JPtek3gcjBVtoTfvmbKMxjI=;
 b=PcVAuiSJwVKFGQg1dcyOGq3oP05BIhZd0CNxG87bhUbpD8X7uBJlDdDaeQbH/7ASju
 Qn1ETMMz0b2R2wxJFvoYNiD9CRP9GA0DrT/zFM0uxYMDo4dXqryDnH1wABcWTee3JaUh
 p2FXHtmbcwHMRtpJPRH0Y79+ng0AwOkcUqR9Z+YhJimErzdNQ3wDuFOWSB/4D5ZGY6Wk
 41v740vYn1d3FrVloJj1yNeT4HZIaU0Qn7azQC2JU3S1QP4qh0tf8js6AoIZBjHil48v
 iSXRPg0I8xds3vICrIAwC5DM4Qx8N1am2KHH/cyKSrRx6wIx2V9gozGyjJvslC2cdB2G
 /85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571277; x=1691163277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YRT1GNxZuXOH+ykrEwU9JPtek3gcjBVtoTfvmbKMxjI=;
 b=BveNuNKoN41QnkCcdW2Y2Sssci6EtLfuh3hCwjpPPqYM9lWI3wcKxbBGS7EZ/52DaG
 fU6DKZj8rngO2rwXLXIHBW/xamZG17pM5EK0hDv8cTby+AlUFsEcx/ry1bJdO8b/+ktW
 oknJHBjBUByfahK4Vy/Ve6gQBmT9DU+q4e1245P3G04ycA9RGIciz+dPc3rtvAq7bQ8a
 mroo0qBY/iSWVq99YR9Sr8Pb2mPHJZRuZDcwcCXJWINZColPTW2U+iU20AfRdKXm8txH
 7s/qae0m8zeWJrSpYL9KLFuakg6Vx/SRmFZTY+1FW8kpuYhozK7SxZOgZTeeEI9GBhVc
 fr9g==
X-Gm-Message-State: ABy/qLZ/uvprSws4jJb5TFsEokVr0uLy5rfWqO4sdqZyLvwwDlRyN52r
 sj8umGQ0h0UFIj15S8um9Zk5eA==
X-Google-Smtp-Source: APBJJlGw6c+TLQYOY8uC+KbXigA3butcFM5bys7QPVUnfBIMaFM6rULfJSF+JIrfxazuTctpPmHDEQ==
X-Received: by 2002:a05:6512:2007:b0:4f7:604f:f4c8 with SMTP id
 a7-20020a056512200700b004f7604ff4c8mr11339879lfb.18.1688571276534; 
 Wed, 05 Jul 2023 08:34:36 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 d20-20020ac25454000000b004faa369ac1esm5361166lfn.91.2023.07.05.08.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:34:36 -0700 (PDT)
Message-ID: <06f12565-7458-d233-a39d-cd74110a9af7@linaro.org>
Date: Wed, 5 Jul 2023 17:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 08/19] hw/timer/arm_timer: Extract
 arm_timer_reset_hold()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12d.google.com
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
> Extract arm_timer_reset_hold() before converting this model to
> QOM/QDev in few commits. This will become our ResettableHoldPhase
> handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/timer/arm_timer.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

