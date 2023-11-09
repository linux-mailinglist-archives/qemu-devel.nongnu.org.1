Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB207E708F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:43:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r193U-0003I8-Pj; Thu, 09 Nov 2023 12:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r193K-0003Hm-Uw
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:42:51 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1933-0004iC-LP
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:42:48 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9c603e2354fso237361866b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699551751; x=1700156551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vMBMXe9GahojgUxssF5EDiZZKvx1RhckJbULNf5AZfQ=;
 b=BqJPqktb1WY+0k4zaE0aF4llZoa6frA2SthGPQQuK7cDaJntztFNpkxQPkAo98wPuR
 ZlizAnBVxrvG8P/VMKgnGYS50IwFc2Ye3YAhUouxEPv+H9FvYlIfX5HOcNerRgTi57xi
 ScCej0pBM5o/3JFsVML7U1ea2q7uVCVxw5VY0tOnE3cM6dEboETUGa4rvoALcaF2wEo5
 I7PIFszDuzGd/2WS7gt7cXxa66O0jB6+xKMa2f6da0oR8fbIPEHihjQIyrgBSeHcH/Al
 aSne0CDQckFX783MD4juVKmPoV7XUWjJ8+h9rfTeVsy/AF9ku89IY6EsY7BKwFXaX6Xx
 7M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699551751; x=1700156551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vMBMXe9GahojgUxssF5EDiZZKvx1RhckJbULNf5AZfQ=;
 b=SEzpsdndotIWl+Dsyacn8ZJWVLWQeDha+CsNLbkAca76cT9V4RyXWLlQZrnwliny8K
 g7GDRkn2qG+ClsFvcwA30aRAbd65Zi8UlpAyCSOPEZMcmhV3B+ISMpe/aufxP9F0D7Yd
 aEEhAPwvxETP9Rp6P6PE3BN+/k6+4IoBSLNT10zN4DX2v/ShF/lotxRDmzRXJmnUz6ii
 gB1NAkIaozhw8ISxZi9g2tz7oCVp1OQdMhDdPN5e2u3TOFueb6CvV1XDTDKOGPIoBYeE
 SPVwz1bkQNv1+TV/mqFySOTPLWjhFNJGQS3L8fUkQNfxj1aEltHTI8SOGmnwo27LmzEQ
 6McA==
X-Gm-Message-State: AOJu0Yxr0IETHqd/0VBqhfDyxPSUDy/T1x1SO2nXiuQ0fEkpRQhYnowU
 qfbQIbs2WM/im0wzfpUIWAIGHw==
X-Google-Smtp-Source: AGHT+IGETaObppX7w70RgG1lquwzFgsqr/NPM6OVz5h1E63IhE6+bYH/XrHEFh2dKkL2GAoTljCOhA==
X-Received: by 2002:a17:906:5346:b0:9dd:b919:79bf with SMTP id
 j6-20020a170906534600b009ddb91979bfmr8521617ejo.36.1699551751485; 
 Thu, 09 Nov 2023 09:42:31 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a509b41000000b0054358525a5bsm77509edj.62.2023.11.09.09.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 09:42:31 -0800 (PST)
Message-ID: <14ce82cf-ea27-47af-99af-8f8c2d6567ec@linaro.org>
Date: Thu, 9 Nov 2023 18:42:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-snd: check AUD_register_card return value
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/11/23 17:20, Manos Pitsidianakis wrote:
> AUD_register_card might fail. Even though errp was passed as an
> argument, the call's return value was not checked for failure.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/audio/virtio-snd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


