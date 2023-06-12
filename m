Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D472C4F3
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 14:51:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8gzi-000703-HQ; Mon, 12 Jun 2023 08:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8gzS-0006yS-2O
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 08:49:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8gzP-0004Ut-E9
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 08:49:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f61530506aso44609165e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686574180; x=1689166180;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2oh2BND4F6yiVvr06OlvB07UZxyEQRuaBdzugKVotNs=;
 b=efrYWNrSH8C+JUCt3VmxqOwW135EVzvyvV4GXPOvHglFuluHlyFQFTV2R8Q8IPR10U
 MYoAhuF0oekX7vccv4dDGQDk9irZF12FqFb+dGKOhEFDmbYBoW/xsEbSn7W3Fk2qeqCE
 v3RF45TWf4DBRZUNSFRGZdN6b467YN6mh+CPL3kgyAEj/MNxyMNIcKlhKX3EunrwQ5Y1
 hG7CEzei9Ht/hmpssWKxY+DTVvQ/bdFUdb8b/Cd0twFDGDkw2MI4qyZ5qlF4qWsyzlXJ
 aM4qt47riLxFDjPcx9XYs7xxsg+KwXVP9TrTfTv1R8t2GZ9RpY17bWPLB2d4k542G95U
 +frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686574180; x=1689166180;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2oh2BND4F6yiVvr06OlvB07UZxyEQRuaBdzugKVotNs=;
 b=LRqoMxbpcyro24+xqaB6BA3eYNGpiZrDCfBJFHolRemqyknQTe1Y6sfMAhXTjEswdW
 pukQf+/hABANTVbx1mxN9IYF4jHI4orWsmgso35DnLjxo04fh/8uC4s2vBIuvyDye/AT
 0eHqn9vqgJoEP+4niOcW8R6vtKX7tvOEh/b1Zt3q96Ul+xM+8eSKIg1ry6cQVlUsdUSi
 q37l7hkN1Da0rE6gVbAaSz0CwEE4O/Yla6pyVh6mArSU7Vdor8aDDTtTZhmStguEIQeB
 4Ml0rZEk3KmBlN1KeHg8Pz1+slX7axWW4tk9weq5MH+a5HgyoKLYEDtdEirW8SplSUjR
 KCiA==
X-Gm-Message-State: AC+VfDx4Yn1yHygTEczHuv6Y+8wu87vQ5tF+elEwM2UF8VKHuRXXDSHn
 9zuTl8qGhNkoUp9+DyLqT4zQKA==
X-Google-Smtp-Source: ACHHUZ6xcMU/pFAaldt8SZIz5hJxPpE3leT3sj8iacb6lUs05gJ673vKFOoB8+RXMJBDD3QLZ0bLLQ==
X-Received: by 2002:a1c:740b:0:b0:3f7:33cf:707e with SMTP id
 p11-20020a1c740b000000b003f733cf707emr7253411wmc.18.1686574180441; 
 Mon, 12 Jun 2023 05:49:40 -0700 (PDT)
Received: from [192.168.112.175] (176.red-88-28-1.dynamicip.rima-tde.net.
 [88.28.1.176]) by smtp.gmail.com with ESMTPSA id
 f25-20020a7bcd19000000b003f7ff520a14sm11292588wmj.22.2023.06.12.05.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 05:49:40 -0700 (PDT)
Message-ID: <fe7a9750-efb7-9898-6b3e-9e85f4c1e141@linaro.org>
Date: Mon, 12 Jun 2023 14:49:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 4/5] cmd646: rename cmd646_bmdma_ops to bmdma_ops
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 shentey@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
 <20230609185119.691152-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609185119.691152-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 9/6/23 20:51, Mark Cave-Ayland wrote:
> This is to allow us to use the cmd646_bmdma_ops name for the CMD646
> device-specific registers in the next commit.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ide/cmd646.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


