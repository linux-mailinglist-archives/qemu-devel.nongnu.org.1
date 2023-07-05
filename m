Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE2874883D
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:45:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4g7-0002Zf-PR; Wed, 05 Jul 2023 11:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4g6-0002Z9-At
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:44:26 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4g4-0001h4-QT
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:44:26 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fba8f2197bso7785529e87.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571863; x=1691163863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1uyztzwuDD9Ah8M4GvDKZTZYgGChTPxk+odW3+66f9Y=;
 b=K3vNufOCBbeDglvR5WfXBHVWCHv0nXROSmvnkxf/+lhQ1Y+BSb2UqsrGpFZ81RrPFM
 Y1+eWL4gTC0HIfMPuqTXxtaj5tX4pvdYUvZ02F/i1KdLp2/aRvIYeY3CO03nuu1ucl08
 mIWLqX0WniExn8cVnQk2ht0yEKESEMy9ldTN7qH1Nvsn5XjFxnY6Tbuly6CgBtnqzPzr
 DECewG84reA1URZzK8a+2U9h3JYWqa8dDN1Jejt6SvfgbSRbc8S2s6ygqXtq0CLBi9oM
 MGhJl3HKpSeU8zDMqWRx7rppOl7NqHiDP4zS/ifYbZMKVGD4Ma97MciTwum3seKjebeN
 Uq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571863; x=1691163863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1uyztzwuDD9Ah8M4GvDKZTZYgGChTPxk+odW3+66f9Y=;
 b=SBhcTlpatEAaFJZzg0L08Uk0Jx8Qcef4qjghU2dr5poTVJtzD3WuU2uxLapRjPFaNL
 46WRIKa1ohbGePN6NZv3OyUKpd5r9hz52gIhDkx59zq9L95ZflwsC6OUtt8cnX41aCTR
 8yMdP/AmoZAPvToVRyQnJmYwnHW0fvYUuUt1l6yIhvB0bsy/j6mFCTw+dU97M/7+S7HU
 8xuN0VlTO75ib3ze0dMIaQ6GxkuZqfDjIpnm/HpHcCMFaV8iTLM0fU/t4EdUMERsPfQo
 e0mwYtobBrGaY8nG51Uq1pP3XpsvZ0P37luQMM3K3inR9pDQ+ItxLGDUE/TtPQ5/h0uQ
 hHrQ==
X-Gm-Message-State: ABy/qLb7w3ZWa1bUQMpHQPYqeIUR4tuMMtokS3LWvllBbOM5tQ95EeGA
 glg7QKaps4XhQUY+p7bamE7jaA==
X-Google-Smtp-Source: APBJJlEpk+ZAHVbiowC0ruGHnVAJFpupjPOrqIKHsAo1Nh4PbsgOUHWU4z5AS8Ask5KdmVgzV5yBlw==
X-Received: by 2002:a05:6512:285:b0:4fb:82d8:994f with SMTP id
 j5-20020a056512028500b004fb82d8994fmr11109016lfp.33.1688571862564; 
 Wed, 05 Jul 2023 08:44:22 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a19550a000000b004fb844a03c7sm4316346lfe.186.2023.07.05.08.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:44:22 -0700 (PDT)
Message-ID: <12239add-3fbb-819f-891a-3e7278fc5d11@linaro.org>
Date: Wed, 5 Jul 2023 17:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 18/19] hw/timer/arm_timer: Map ARM_TIMER MMIO regions
 into IntegratorPIT
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-19-philmd@linaro.org>
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
> Instead of manually forwarding MMIO accesses to each ARM_TIMER,
> let have the generic memory code dispatch that for us.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/timer/arm_timer.c | 43 ++++---------------------------------------
>   1 file changed, 4 insertions(+), 39 deletions(-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

