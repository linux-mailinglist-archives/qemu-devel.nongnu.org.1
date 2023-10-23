Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8677D42D0
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 00:43:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv3cC-00047r-B0; Mon, 23 Oct 2023 18:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv3cA-00047g-DA
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 18:41:38 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv3c8-0000EF-P6
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 18:41:38 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-357c7e9cab6so10718675ab.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698100895; x=1698705695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4vbQwn6S9+eOPpS2UAsCDXR77gQbkITvc2qa9gdlbrA=;
 b=hfyG9w2ub+iWcJ2XrVZb4V4ZFMK1HlvlgOclP8Ec3yBIk2qKx9zzO4H9d+NAbfWVwa
 2Qt9mVvzk7C+Ynm2n035hAChUyJuHo5iq7oIyJLH6HeN7wtvYLCnrJWWJPNwwGgfhX8x
 BNRwp4xkQd9ObUn1U4Ysq2LeAziRgJvbSt51780p53XpZFkLbWMpKN5sKFy4suEf1moE
 eA4WL/Jl82BjY+JKUnqMEwDztBIRptuGV7KZ/753o1en0YqLjRfd4/K8P9nYInX5aOz5
 dURu27aF1Kr+2n4a70w7UhwJRP5sp+8BvpqHCRFuGi1gg9iRGK9wEBNHRE48/nBBJoNe
 K3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698100895; x=1698705695;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4vbQwn6S9+eOPpS2UAsCDXR77gQbkITvc2qa9gdlbrA=;
 b=B9faUJ6DLI+gCNDbsI/Gf+ftRNLeXicjmrKIcy3u/C5ptFzSwdiCqT9F3lFOHY1gfw
 bweIg3vujc/NyFchcVr0NlvqyS5V6URSp/6YuzZfsYFayAYiB+VH74ZjeffupzerlNA2
 RLU81609uy261ZmElls+K+mnPfxsXm1xERosZ7VsXN6mgbelaCOJ/J4m4cTTsi8+uqFP
 OQwxxEhn0Elkfj9C9OgueYn4+IcEeITQfvtnjXS3ieYMwToSlxJRJDAZ9KjqN0sFTfBZ
 1AfIh36THndzP4xEbdczbQdSD0BYsnQgbyShYl4jiOMKLy6vlG2W0GDAOk8BHeTlIrHu
 YG2w==
X-Gm-Message-State: AOJu0YyDqD+dKQ2h8fctUn4EVt84RNbPb2kmeQI+y9jHQJuDprJyO1G6
 HX1GMhwy/2HkEJVKIUFJyupHXN2FV7dbKYpUpk8=
X-Google-Smtp-Source: AGHT+IE8LNOhqIFwu8TfwiK6wjGDmnh9KwHUdit4vFFfkmMEcLkOEwONcT8WI1MqkY6+51deF/kMkQ==
X-Received: by 2002:a05:6e02:1c27:b0:352:5066:55b1 with SMTP id
 m7-20020a056e021c2700b00352506655b1mr14917795ilh.6.1698100895251; 
 Mon, 23 Oct 2023 15:41:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a626205000000b0066a31111cc5sm6906168pfb.152.2023.10.23.15.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 15:41:34 -0700 (PDT)
Message-ID: <461f37ca-856f-44e2-92c6-49afdfee8971@linaro.org>
Date: Mon, 23 Oct 2023 15:41:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/94] target/sparc: Convert to decodetree
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20231022232932.80507-1-richard.henderson@linaro.org>
 <0527eade-2132-4f4d-b862-0e097dcc7c52@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0527eade-2132-4f4d-b862-0e097dcc7c52@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/23/23 11:04, Mark Cave-Ayland wrote:
> On 23/10/2023 00:27, Richard Henderson wrote:
> 
>> Changes for v5:
>>    * Add Mark's a-b and t-b.
>>
>>    * Fixes to features:
>>      - Use CPU_FEATURE_BIT_* in feature_name[] (patch 7).
>>      - Don't allow features to be set/unset in nonsensical ways (new patch 8).
>>
>>    * Adjustments to ifdefs:
>>      - Make avail_FOO() constant when the feature must be set/unset.
>>        This fixes the do_wrhtstate build issue Mark saw.
>>      - Introduce envN_field_offsetof().
>>      - Remove TCG globals only used for {RD,WR}{PR,HPR} (new patches 30-32).
> 
> Do you need me to run v5 through my boot tests just to be sure, or are the latest changes 
> trivial enough that this won't be an issue?

I believe them to be trivial -- errors should be caught by failed build.
I really re-sent this for history and acks/reviews.


r~


