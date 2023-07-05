Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F18AD748826
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:36:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4Y0-00046l-K1; Wed, 05 Jul 2023 11:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Xy-0003yO-8i
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:36:02 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Xw-0007mt-MC
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:36:01 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fb7b2e3dacso10792367e87.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571359; x=1691163359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/1P1T8jOCfAGQ8DJzT/zpsYSziVzWO3nB2roOeoQ9a0=;
 b=tbH/CP0/TDI/4O2LlTJB4qUr22WBOPwp8wtdEAMl/6Dcu7fqASm9Iteo9rrinf53za
 eBi9HFm/8Rnm02d84OHvgQz3N5w+Qi15GuoG0OfcfSaioVK6CeofuQ6sPJnrgd91VdXr
 J1bOxN+hQXsiBqMTAX/hpcpIybre+Zl7cmByuNYiAgYWNneZklfb6c7IFnzrz43eUTwD
 wOsM3ivK5D/OcNceUPrQkNyV9FET24RlslKvch1Ltt7Mm9QtlqVVPN7qaByb/bJI4fmm
 9YwQnEKtpv7c48OxQezQeMZrLkTMP64mcvmMzobKRGJVIH30U5rX+etqPcv0/5y1ejAH
 71gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571359; x=1691163359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/1P1T8jOCfAGQ8DJzT/zpsYSziVzWO3nB2roOeoQ9a0=;
 b=Tox9Sjom58dBXI3AvL0tzJYepyOirSSEk6hntPXCuHXhYGZqTi6LlO4W+4sXAjRT74
 H/u3iKeGN6eeNvLy7ivadY0kyWcYNhi1DPmEOfFNwTiJN8NADQMvsTLeWq1m7gti8y5U
 rQvaM73+XjqtXQM+yNAveFXXWhA7nBN220z5hdS1fOOlu2ZOeqktXvn+KssovAnkBxmQ
 EtHDGcCOvSh9FsE12ZwQJmg38+CHsITZIgChuA9DOLzLzH5nI1f6i/2FV1lXFsUav6Gn
 b4h5sr3csqNWUG+dNGnXDnRgo5zgVM6XX+6MvDuOiyMhyl1Sox3joASrjBFoRytZy5Bf
 UIdA==
X-Gm-Message-State: ABy/qLZoxuEy6QThqPmVIflp8dwUqe2Vj6SfIXvgQQPh+oMEFDqoT8gK
 AWOG2DscPl0YPb6y+m428CEWmw==
X-Google-Smtp-Source: APBJJlF/kO3HK80Ym/ppURFlod3ZIqtfBf+btivX65iD9PrPINPt+9GzuNDz0My/2UZ95kniD+PsIw==
X-Received: by 2002:a05:6512:3142:b0:4f8:75cf:fdd7 with SMTP id
 s2-20020a056512314200b004f875cffdd7mr10070942lfi.22.1688571358809; 
 Wed, 05 Jul 2023 08:35:58 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a056512040f00b004faa2de9877sm5353340lfk.286.2023.07.05.08.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:35:58 -0700 (PDT)
Message-ID: <35e86604-cd60-529d-90ca-8824dd66a62e@linaro.org>
Date: Wed, 5 Jul 2023 17:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 11/19] hw/timer/arm_timer: Convert ArmTimer::freq to
 uint32_t type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/4/23 16:50, Philippe Mathieu-Daudé wrote:
> In preparation of accessing ArmTimer::freq as a QOM property,
> convert it to uint32_t (so we'll be able to use DEFINE_PROP_UINT32).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/arm_timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

