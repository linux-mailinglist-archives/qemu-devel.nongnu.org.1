Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3D73693C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:27:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYZt-0003IW-4S; Tue, 20 Jun 2023 06:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYZi-00039Z-GB
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:27:03 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYZf-0001Lw-2M
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:27:00 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5187aa18410so4776931a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687256817; x=1689848817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzJM+6L56YWxbbo4WFyn1FiBlLs7pGHH6BiG4bZ0DJU=;
 b=iV3oHdAUWNbjQqd8kFSmXlO7BmjBLo0kr2/jizcj0T5gUCrYQVEJyFdxE2cNlX9tFV
 P/AmxuRHPurpUmkkkwJPaPMGBEUOKoEPeTUjCEv4MGEabeN3MPQ9JwlS6J3A+bvhjOp9
 nPzlzemVbPYjLOqGfutulUuFhm8snLwMjFLQfByb+4oC/iVudMulMVGQ2IBbVIe6pcGW
 EicLQGn1RW6kz5+iefWXkOEMbAYaTUz+WW4fVDve4tDTvE0uM9tDCPWsmXOar1RPLFnB
 wYeMqT+puMmBdJfiMxL8lupvcU5rN0Cl31gceK3N0uaNcDESyl4jNIZOjWrDkO/RkwYy
 mTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687256817; x=1689848817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SzJM+6L56YWxbbo4WFyn1FiBlLs7pGHH6BiG4bZ0DJU=;
 b=M3k91/2SJqYEqEwsTk+FjCSLrw2xW9WfSSfoAiFGHxoC6nZF9MxqseXLmuqaxqwmeo
 E1d4GEYuvWzpGAtsI9k7tOhw4EVpTCaMRJHylG78YLZYajqzxxN0m78HmCV9uKOghXoj
 vkPgx03IxGFXBRemq2B81zciDkQfZ/r5p/xDE177sBenPNBBlx0G9F+q5xG7mRCkpYHn
 8t2TNlE0zBl4PWRa9ptvwIExzngl5RKeglHws0OOIB4k444SdoX+qT3jNJYZWnQE04pI
 guEk+aweK3nueekFpmVvIoWPs5oowDcu6qzLXhbwsSUnB0k/cm+6VFYPNbr0umFhbifR
 /thA==
X-Gm-Message-State: AC+VfDxPO8+sUuu1OfwWQXgEQseC63JjWIXehPLg82K/TL0ozEQS9kEa
 Tpi3QgaV+ecduXINfMugjC0uaQ==
X-Google-Smtp-Source: ACHHUZ6h3xgIAj75jG2Oo/8Q4V3Mif9h7/1qdVtJQVJiFxrSRL/xEMkxfOkLW0S2pu0D6jjzOGHHKQ==
X-Received: by 2002:a05:6402:1b0e:b0:516:81d3:2627 with SMTP id
 by14-20020a0564021b0e00b0051681d32627mr8917980edb.0.1687256817288; 
 Tue, 20 Jun 2023 03:26:57 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 b17-20020aa7d491000000b0051499320435sm924435edr.14.2023.06.20.03.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:26:56 -0700 (PDT)
Message-ID: <12a093fe-ff65-2c3e-fbe9-3d9fceb0e276@linaro.org>
Date: Tue, 20 Jun 2023 12:26:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 17/34] target/arm/tcg: Extract gvec definitions to
 'helper-gvec.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 17:54, Philippe Mathieu-Daudé wrote:
> helper.h is used by all units, but not all require the generic
> vector definitions. Move them to a new header; the next commit
> will remove it from the common helper.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h              | 380 +------------------------------
>   target/arm/tcg/helper-gvec.h.inc | 378 ++++++++++++++++++++++++++++++
>   2 files changed, 379 insertions(+), 379 deletions(-)
>   create mode 100644 target/arm/tcg/helper-gvec.h.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

