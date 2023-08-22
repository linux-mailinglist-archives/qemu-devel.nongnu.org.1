Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2067844DF
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:00:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYSr2-0002FV-Fk; Tue, 22 Aug 2023 10:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYSr0-0002F5-JC
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:59:34 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYSqw-0007XY-LC
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:59:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68a43131e82so2125517b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 07:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692716369; x=1693321169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lzualKWYaXny5AQniRFo2a8WnbpJADHPG/kp0LtcUEM=;
 b=ISwKSuZUshVXeAEZ0aS9PEx6qPQoBilygaysuHXzoKSth6qPl0Ga4epMe4mX9d6GXG
 k/H9GWTCA/lVKsxkzNMFHQ27FIlNhwiqR4mUBN6smwnhgB6DI58lfK6aMNhs/wmPgHxC
 Dew1jA+ezRHnetHuLjPfcMjmTDzQGB7L0VKL7niwSKH9yBamyPG2gq9WZJAR+rnaCgkE
 S4Cd6J08aSB5cad4QBW71J+z+xHefYJRckgrUS8zQSD4LxioeVaMB1IA/yXq0o/m7qpD
 /f+Qs5GBPLD57rbU/RzvAr0+8y7S7Ct6JjGkfJljdGMyw2yVUgHC1hlqZIF1qabCI2em
 BDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692716369; x=1693321169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lzualKWYaXny5AQniRFo2a8WnbpJADHPG/kp0LtcUEM=;
 b=NjFC1aCqEbJ1UfMVa9MM6mAloD3eiYhoaw+s10O8JpsP6ofXSLIf/cEetyjQSWkazJ
 plYAWnfEN9mE2IzQ9Xk4ned73ETI+BngTGzRwmjWWg93qR1wEQTKOcEHLzwRyWKcZ8gZ
 SM5wvDzN4Id7880Hle7UczrBGIoo+Jw7OLQHgmcOWWA9OBoRiibR7V+Yq+DaZD4IVcwI
 jxQH/TVgT8TgAeuVRrDLNwGiw9abJI2aZDCl+PJ8zaOVQ1SIgVrUidE/yCyPQGo4G24V
 4gog0p+CsrbnEnkRS3H+FHuXwfZjU8GRtxuwPnBbqI+h26PVJHQZxBMR3XgW3qHQeGX7
 FdGQ==
X-Gm-Message-State: AOJu0YyEXwOJRUWkVyUPu8w8Zb4RxIPlcsRHLQxgZNSu6zsDR0s+9+/P
 7gEUSOqfZzyeL3wVD8YQ6C5M8w==
X-Google-Smtp-Source: AGHT+IFlu7uLMpDAYfli2n7ub4y08gDWad6vzoZTc6z4k5QIOQLK2atVTtVHuwRPnYY28F74W/g1Yg==
X-Received: by 2002:a05:6a20:4421:b0:140:22b0:9ddd with SMTP id
 ce33-20020a056a20442100b0014022b09dddmr14002319pzb.0.1692716369176; 
 Tue, 22 Aug 2023 07:59:29 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 k1-20020aa78201000000b0066a31111cc5sm7878047pfi.152.2023.08.22.07.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 07:59:28 -0700 (PDT)
Message-ID: <2658cb0b-70e0-3482-d427-77bf720ed5d0@linaro.org>
Date: Tue, 22 Aug 2023 07:59:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] target/arm: Use hswap_i32() in VREV/SMLAD opcodes
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <20230822110129.41022-1-philmd@linaro.org>
 <20230822110129.41022-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822110129.41022-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 04:01, Philippe Mathieu-Daudé wrote:
> Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
> introduced the generic hswap_i32(). Use it instead of open-coding
> it as gen_swap_half().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/translate-a32.h  | 6 ------
>   target/arm/tcg/translate-neon.c | 4 ++--
>   target/arm/tcg/translate.c      | 4 ++--
>   3 files changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

