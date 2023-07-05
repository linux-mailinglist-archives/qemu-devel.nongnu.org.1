Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA7774883C
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:45:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4gV-0002gB-5r; Wed, 05 Jul 2023 11:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4gS-0002fJ-U0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:44:48 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4gQ-0001sk-Vq
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:44:48 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fb5bcb9a28so10681499e87.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571885; x=1691163885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=88PU+23+COU/1+XJxieediUwqsawj83pgn9dvBTwEYU=;
 b=LC/oQ1Ko1F1Yt9XiHsf/xcF9jkCCsqkvyocammJlV0M7FyzBo1YLG6xdvU6MkMXXPq
 Fz0k3v4idOh896/km+11u+KwXh6rUYco1eA0jR+iTl66NjjTr/0p3U3oiapJBHFPKRHw
 SxEnqmGQAzlJtzQ2kj166PZJhBp0MbhN1kvxWCH1JDmM+DiQEBVvzHeXFL1h6JF5Ffzg
 TfNaNtOfrn1xIYgOC+XRFoTuJZepEnhNXEqD2cjyKFGNZ7+Mlie7PfKl68qbZxar4/9o
 trTn4L8ZrAioAeNftZEd0pS/zjLNhM3S9HN5tZMBEjCmFh7dkH1guT2j6XK3KJTSC2OP
 EZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571885; x=1691163885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=88PU+23+COU/1+XJxieediUwqsawj83pgn9dvBTwEYU=;
 b=I1CwZ9y7blReWR3OHnVWvLd9uVTsBlHPiHOl4/Mw+A1tpXz01FD88PvHy0WpsoS6tl
 HmkuP++8dQCMN5OkPuRPo9k6OFgEsnfefCk6okAWUPqNaixPG47ytDTq52yNl6bg5n7d
 87MY1+1jBQYt7/KngaxxFQ0f2/o0pWd6y72OdUNRce09v3sVzz/88tcdHNesO8nXbM6m
 kti8XpcTuVPcUYwLa8uHkGBemTbT5WqV6B4+CZqWoc1Xua48fflgb9VD83/6Snq+M5aQ
 8SnAEgect2tkh8mg67kurtdnTEB6MTS3YQnfp44XrDQ/j4XiKPyysSfkhM7ZF5O2gvXl
 LOmQ==
X-Gm-Message-State: ABy/qLYPONEXkQdawUgO/9Q6htH1gaSZf9fpZqWlPxlyEvtsnZ/45MQ+
 eripBY+aJ5lQhQL0jiJ8PpfJ7Q==
X-Google-Smtp-Source: APBJJlG4GZu6DkgaSnK5zx5Pz+SRylNaywckwn5sd/xajksGdJX7PxHwF00zt9M5PojIBp3n7SCa+g==
X-Received: by 2002:a05:6512:398d:b0:4fb:741f:75bf with SMTP id
 j13-20020a056512398d00b004fb741f75bfmr14677584lfu.16.1688571884908; 
 Wed, 05 Jul 2023 08:44:44 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a19ae04000000b004fb75441c94sm4935551lfc.9.2023.07.05.08.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:44:44 -0700 (PDT)
Message-ID: <5bf5f559-be92-c853-da47-9fe807d63cac@linaro.org>
Date: Wed, 5 Jul 2023 17:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 19/19] hw/timer/arm_timer: Map ARM_TIMER MMIO regions
 into SP804Timer
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-20-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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
> Instead of manually forwarding MMIO accesses to each ARM_TIMER,
> let have the generic memory code dispatch that for us.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/timer/arm_timer.c | 23 ++---------------------
>   1 file changed, 2 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

