Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49632748835
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:41:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4d1-0000b0-Dt; Wed, 05 Jul 2023 11:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4cx-0000Up-Iq
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:41:11 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4cv-000112-PC
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:41:11 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4faaaa476a9so11136527e87.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571668; x=1691163668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=63v8MvgHzFrmnLCG9jUQWQLThc4dtGA6q7ee9vcXv7I=;
 b=U7hn+dZRH+zREblWmTyV65j/RZCBQaJ+2hKaxR4UlRFdirxXgMYWVEHJlj0DQfCP0v
 mPQI2Pt9AuBUNVN2m6LJB8olXNGkbjBQz+pW2Mp2A3Sy393ikiCaWojippP1TLY+ylcF
 Moqg0HMbULWwmAm/pvMfFylpNeou9bl1UcFA0UDdPMW9HmK6e6YrG0ZJVgUqsYmnimbl
 W5zwqkGUk2vxBjRlx/473s6qM7v3PaeZEE9w97lzeuL3xdS61h9+QwDhj+f4G9rYZH34
 iQbkEWcSoll2alO7iJZBuBTdibdWz2Da0pzZ27jjYRsgYRHT6z+/PrpjOdYDQksA+i0y
 IZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571668; x=1691163668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=63v8MvgHzFrmnLCG9jUQWQLThc4dtGA6q7ee9vcXv7I=;
 b=GBkru2ijHkhzI97Ol4/Zwju2mgqbVspzrd7Vl9WY2lfpQAWQjG2mFbxvZCw0qJv7AS
 uXQtBlPckBbqFpMvETUT8YVRrF3N9y+k3pp9W/kfQCnTImLme41XP+W4EVZwbFhBrXjX
 /pW1oO8631hunSZmBzFnmubsCYPLDYCVHHIFQnrRXaD+RFr4irWZj5563sgwvK5e1vIH
 imsS/cHtY20krmY/d7kfbYGIdDv64nIV0oWdpvWxIlxsJHusBXKt6+p0fTts7nIkoSAc
 XvysoQzhAPjdmifBi4P7+slMUIRrhubkKaqNGwVu38lopUS3MtUpNwn9t9XFWgtcO/bw
 BMwQ==
X-Gm-Message-State: ABy/qLZ7jeffeLixPfUB0yBv9LDHJyrc7zfzUUgVpZ/IJb3T1PB15Xzj
 YGuEiBBaCRNjr+T24AaTmryYXw==
X-Google-Smtp-Source: APBJJlExERYWNljDmlQzQHRRp/g2amNFK0w2P+UfwmU36hdIQFArTQEWAR1jh9Zt9CKNdqk2TJuZWw==
X-Received: by 2002:a2e:9252:0:b0:2b3:4ea3:d020 with SMTP id
 v18-20020a2e9252000000b002b34ea3d020mr11397565ljg.17.1688571667885; 
 Wed, 05 Jul 2023 08:41:07 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a2e7001000000b002b484bdae08sm6322243ljc.32.2023.07.05.08.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:41:07 -0700 (PDT)
Message-ID: <d869697c-0d15-b18a-1f92-19df8d5d536d@linaro.org>
Date: Wed, 5 Jul 2023 17:41:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 16/19] hw/timer/arm_timer: Extract icp_pit_realize()
 from icp_pit_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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
> To make the next commit easier to digest, extract icp_pit_realize()
> from icp_pit_init() as a preliminary step.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/timer/arm_timer.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

