Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FA67AB4E1
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiEk-0005ah-4C; Fri, 22 Sep 2023 11:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjiEh-0005ZG-FP
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:38:31 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjiEf-0001lk-8I
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:38:31 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so2229431f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695397107; x=1696001907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=61Nw5qSFEFXff6TdAdTRcJZh+UlX6tbX8SbqKuCFpJM=;
 b=YHtMp4U6G+XPHuOfHo+yn9J66zfJuVF3F4HxHpDVSYQSldnPbYgFLuMkn5J5ILTNuS
 qJRoOHScTPUyqAsaZ5Rak90h49snAS54nEgTuu04k3BBEuyzjXOr3VgHcYIfxDr6QW+d
 ZTU1rUSstVDbsQZFMg1QoXrVGwjzYfYM3sg1jknuFUnkYTJyhKRuD5ZqH/BF+2pMfb67
 j4h31Kb5go+Hztz2Necs495o9EU1OBf4UsQdLeuds9S0LTi3X73w6BQPlBP1qkraHwBd
 nPKiFaE10GbL9iZBJmZeCdbzrlWLotSCIIVjmS4T80VOyX+DNqYdHzbtmB8Z8wh3e+c6
 DH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397107; x=1696001907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=61Nw5qSFEFXff6TdAdTRcJZh+UlX6tbX8SbqKuCFpJM=;
 b=L6QbemL4+iZnLLQuBOdR1n75MOSv6yNsBGvyB85P6wWhhdywkV3rEhBMfqyL1p0gxa
 cFY4kxmz7Pp6zUNTWA1tx4/SuSIXMhHcCb9X2Cj4TJD7c6BpVV3Xv2JSDec3sB04v9JE
 lvNp6mt8Q4E1mNBwnm5n7YtPJ2fmfIC/Dwc81LHexWEYBPVsCHeHkySGFg2DqKt0vRP5
 u7i1Xihe1eVb6EeMTUzUJbaVr7tIK7TgSeC47dA4WPr8dW+j6/utZ4loOhoTEwU4/07Y
 C1iA1x6xVrH0TUrpMeK1TgU3+Kvx5ZAs4vw5BlP1t7ldee1V9NFdhnWAc8Pa1Utp5yf5
 5EFQ==
X-Gm-Message-State: AOJu0YzPRGZk5nryXmxjqV0RBStRk1JQoOgjeRAqh8R3XxhlWD2GiBez
 6vaemFBMNarUdfj+KYE5H3esl0mnFY9Wp7YUaWEhN400
X-Google-Smtp-Source: AGHT+IGr3JCrv9KhKKFDlF7webDEG+83yeDwWYA/zfx2uhvrcyHmXTiTuh58BnkxthpXCj8nE6cHPg==
X-Received: by 2002:a05:6000:924:b0:321:4d1c:425f with SMTP id
 cx4-20020a056000092400b003214d1c425fmr14659wrb.47.1695397107455; 
 Fri, 22 Sep 2023 08:38:27 -0700 (PDT)
Received: from [192.168.250.175] (234.red-88-28-23.dynamicip.rima-tde.net.
 [88.28.23.234]) by smtp.gmail.com with ESMTPSA id
 g12-20020a5d698c000000b0031c8a43712asm4714848wru.69.2023.09.22.08.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 08:38:27 -0700 (PDT)
Message-ID: <cc480044-5b62-69b9-9c75-ebd012675cfc@linaro.org>
Date: Fri, 22 Sep 2023 17:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] hw/arm/smmuv3.c: Avoid shadowing variable
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230922152944.3583438-1-peter.maydell@linaro.org>
 <20230922152944.3583438-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922152944.3583438-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 22/9/23 17:29, Peter Maydell wrote:
> Avoid shadowing a variable in smmuv3_notify_iova():
> 
> ../../hw/arm/smmuv3.c: In function ‘smmuv3_notify_iova’:
> ../../hw/arm/smmuv3.c:1043:23: warning: declaration of ‘event’ shadows a previous local [-Wshadow=local]
>   1043 |         SMMUEventInfo event = {.inval_ste_allowed = true};
>        |                       ^~~~~
> ../../hw/arm/smmuv3.c:1038:19: note: shadowed declaration is here
>   1038 |     IOMMUTLBEvent event;
>        |                   ^~~~~
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/smmuv3.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


