Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BFE748820
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:35:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4WG-00013u-3f; Wed, 05 Jul 2023 11:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4WE-00013m-Ps
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:34:14 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4WD-0007Al-8s
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:34:14 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f86e6e4038so1160704e87.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571251; x=1691163251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BijOKpxhsL4YdPUFBh/GVdEMhdIcPEMY6+zmB2m8ez8=;
 b=FqYylTrXvq/ye1S93mYfjHKced+3BV+XTiRF/hZW0aP8VOVJmqMVpfW1b1XBcPj5Fd
 byiTTzlqKh78X4exMCvicJdj53sBNFM4c9/NlLFCf0awP4Z89gwARUohbhT0pZef2ee8
 hvLxG48EAVpOYN7awhNRbado1lNLdJb6AUPcBCwectjjzOS9Ui4NCmIp4qpTaVHtwxAJ
 ZfysbeCWd9ZgnegDwRUbLuoJ+M+tWcLZ4mUsZcAmdTpa4SDjqN7D4xDd91cQBK4eDuoG
 3oisM1Y+w1QkW9A4DWyXZWHY8CulynVPXiDHgjcfUjGiosF+1cCFKDzKtmaqbItboA9T
 90hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571251; x=1691163251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BijOKpxhsL4YdPUFBh/GVdEMhdIcPEMY6+zmB2m8ez8=;
 b=QfQ3r89AMlbRCFbyLUnmUORmawB9YX4OPR5dXGsWFG3Z62kjvV6exEs6fRpgSLZoKM
 jVNaR1+2kdJUqwqPgNJNKCh31nXnxcrPTsbXeX9put1aPlZLRybzPZqt9IBvO/GK93GC
 8bvdN5nsd6fMcpEOy62fqgpq4FHdigzBXUJGagPB+SsY2z+6QBKiwBKJR+PkZyUEg/iE
 xGoE73fZEJCREavE5HVYjJ7I2Sv8D831f7FjtlO4f7G6kpMsyiACkZ1DpZ8eBDfPLecp
 KFFWSQwxaw27znuBVqsVc+juH6qWWE/2sg42n+GVe/FW4B4F7fmghcdpYGziWdOm2/S/
 3o8g==
X-Gm-Message-State: ABy/qLZq7G1FGN78sVWH5hcRKmbzjz3ZR4ll/16p4WqHJ1hPVwdDEaI/
 KyMBq3N5iB0fuWyQdu+00Ka4EA==
X-Google-Smtp-Source: APBJJlG0EHkhr1XFqZsKhoPnltut7Fv7z84OFsvX973egYddM2eiyMjXsNiP06yv3xYJwcWGMLA7hg==
X-Received: by 2002:a05:6512:2509:b0:4f7:6462:e036 with SMTP id
 be9-20020a056512250900b004f76462e036mr1033645lfb.11.1688571251402; 
 Wed, 05 Jul 2023 08:34:11 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 t6-20020ac25486000000b004f8703fbd80sm3915150lfk.57.2023.07.05.08.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:34:11 -0700 (PDT)
Message-ID: <1e438370-e666-fa33-3cad-a362f8689e06@linaro.org>
Date: Wed, 5 Jul 2023 17:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 07/19] hw/timer/arm_timer: Rename TYPE_SP804 ->
 TYPE_SP804_TIMER
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-8-philmd@linaro.org>
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
> Having a QOM object using its device type as suffix is
> often helpful.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/timer/arm_timer.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

