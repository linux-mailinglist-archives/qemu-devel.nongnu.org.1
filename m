Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2578572F3BC
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IRP-0001Re-6E; Wed, 14 Jun 2023 00:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IRM-0001Qo-LZ
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:49:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IRL-00045j-78
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:49:04 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30aeee7c8a0so4662882f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718140; x=1689310140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L+cf2hw8IZO4Tom2qkH3ytSPQxmYGP8/jurKHfkL0T4=;
 b=wa4rwKAAYOhxILevAslSQDFn1XiYLw08C/h0C5sMUSnZY4Y6NbCyMmDTgwWaH6LgEF
 kmDZO4cHLyvwsEXA5Q4itu5DJMls4EN2jO63x/9curpatQre6JIpQYdiHvzRxoVhi0+0
 dfoygShbpN5IjReeWg+dHQ1fAp6g8FDp+l/bbtoumviZThpRRuykn+7plTuxtD6DOQp9
 pmA2gY7ddi/ITbsws6hANJpXFKowaRnkawD1jy/UWDDa1A5gRACE4qxSyT2XrY5EHRDW
 s/f6A2OSFDXKNCn+egHSl1gU2kalwS/zOKLEi3AntK8wncu+VjhQ9Eok3jl62IFYdCQp
 bmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718140; x=1689310140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L+cf2hw8IZO4Tom2qkH3ytSPQxmYGP8/jurKHfkL0T4=;
 b=L6xUtb7ndT0SUxlmracg94XhTAn6mJOfOsVW66jytAxY9/iSDl2d4yT6TVaDNcLtmH
 hUikTeH5PV+U86cSJ8esmlbbF/xYUJTQLK0K4YTwmlFxxrfVTOa+QRmyRX75+wjydFLR
 NM72mjqhyJ4R9uwjQaQILwOHq+WQc8p6/eHzm9VZCUJR1P02UBHrJ2eWtvmcZ9iGNuNc
 OpKRCi5TXZUq3YX24Abf0k6dRdK0FBGZY+IAHKdKyNn55Ehmb4AbB+yC2wssKuZP4wNd
 Rmzaa8qXxIbkYzO4jJBEJcof5MFaPyNWxCYVW3mdPzA1DkputHYlsUSY06sp5oVVT6k9
 A03Q==
X-Gm-Message-State: AC+VfDyPOtJeL8OPGYR/S3jsPcv4dGfWWDTVMLgEoOR6zY0yWe/OoEio
 +HT1Pk0s1HL5cqmjapBbex+71g==
X-Google-Smtp-Source: ACHHUZ6FxLz+zw4rRCWGrQnoUUaZ+4IVrmuChYbAmhIaydPSpAbsDDkpNijizF+dA2HYlLJiPyG+mQ==
X-Received: by 2002:a05:6000:4ea:b0:30f:c420:1743 with SMTP id
 cr10-20020a05600004ea00b0030fc4201743mr325497wrb.26.1686718140702; 
 Tue, 13 Jun 2023 21:49:00 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 n7-20020adff087000000b0030ae5a0516csm16947732wro.17.2023.06.13.21.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:49:00 -0700 (PDT)
Message-ID: <f5eb076b-aff1-91b2-e45c-cf7c7713cf22@linaro.org>
Date: Wed, 14 Jun 2023 06:48:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 14/26] target/arm/tcg: Reduce 'helper-neon.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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
> Instead of including helper-neon.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h             | 1 -
>   target/arm/tcg/neon_helper.c    | 5 ++++-
>   target/arm/tcg/translate-a64.c  | 4 ++++
>   target/arm/tcg/translate-neon.c | 6 ++++++
>   target/arm/tcg/translate-sme.c  | 4 ++++
>   target/arm/tcg/translate.c      | 4 ++++
>   target/arm/tcg/vec_helper.c     | 4 ++++
>   7 files changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

