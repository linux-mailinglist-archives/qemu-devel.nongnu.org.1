Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 773BE828854
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:39:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNDFV-0008II-47; Tue, 09 Jan 2024 09:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNDFK-0008AF-UP
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:38:28 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNDFI-0005uR-6Q
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:38:26 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a2b4aba3a8aso87374766b.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704811101; x=1705415901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5nxawoRihqumzFW48lyZ40gh5UVOM7tC9BVhJ34oU+U=;
 b=bd8nwWS72kELiiY692AfFG1t1dwM6p68hS5npcLFodkeNzGq6+aM6Hri0IdSHI9WVA
 T7eHZitHp+mtxkZVJ7I+bPrM2VS+w5yqousn+DJgRxXBfoGtaoKo7BxVfghjn4TBwu2W
 Bp+DHPcFdI7GND7fNr+SIm4nIzBsyzT6ppckWHnrzvYAweL8/FJYt/1c8L9ZWN5rm9TQ
 KeAd77esCJRpAnd14zxycpqzxmsTheRzMJy++7RI15oSgg9OxcfFnsMXf0kIkm++fDmg
 QnRIbQKiuGYBmUV5SiBwKNiIEX+uFN0I95cELAnzAdUmiXB3jBY5I8ihofU0nRzj0+uU
 oP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704811101; x=1705415901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5nxawoRihqumzFW48lyZ40gh5UVOM7tC9BVhJ34oU+U=;
 b=wMprs2a7kt9XKfwDdqemhY26fX+g3Wt6TMOcXPgZKXeF1bS5W/SF3zalB3+7rXd2mz
 kbpB+xrp7JJpB1g+IQcUH59walmVgf+AghxtN2VhCW8cyx37pCrr37Y3emyS6+eexOOf
 JVPo3LY9W6Jcyie4tpYhhS6gyjI56bqheXCmjPi3NsYs9/Xw9yWgyVuUfIkHZNzkkpGT
 8OeGolN59SqNKCzZVTpKTcZ2DN8N2z87QlMACN/H3ApErdidEfE5Y1wIGxI9y5rzG+pr
 ruMkcDnBRuO3G/TFHsg09+rcql+paTwPZb0RjrTB0SAK6JRF/jaIM1c0xxsK5Z6GQuKz
 uifA==
X-Gm-Message-State: AOJu0Yywh3W741dlfrVcOH4IXjxm3NEsszInm4KNU/fpQYTVZ6E+hcKB
 ENz4zg50a+KwUJJrTvBIKqN+i9eC0Lz3SQ==
X-Google-Smtp-Source: AGHT+IHb9hw0Kl1NrQ2RpmojRzUX+MioLczt6AwA/hCR/LJ1TXLjsFMm7jS3wSfBgebaixCp2DIOxA==
X-Received: by 2002:a17:907:808:b0:a2b:2046:6b2a with SMTP id
 wv8-20020a170907080800b00a2b20466b2amr717971ejb.99.1704811101262; 
 Tue, 09 Jan 2024 06:38:21 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 i19-20020a170906091300b00a26aa734349sm1098536ejd.39.2024.01.09.06.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 06:38:20 -0800 (PST)
Message-ID: <97b28e68-7609-4f4c-a59b-7d2f40edfaae@linaro.org>
Date: Tue, 9 Jan 2024 15:38:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Deprecate the shix machine and the TC58128 flash
 device
Content-Language: en-US
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 devel@lists.libvirt.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20240109083053.2581588-1-sam@rfc1149.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240109083053.2581588-1-sam@rfc1149.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 9/1/24 09:30, Samuel Tardieu wrote:

> Samuel Tardieu (2):
>    target/sh4: Deprecate the shix machine
>    hw/block: Deprecate the TC58128 block device
> 
>   docs/about/deprecated.rst | 5 +++++
>   hw/block/tc58128.c        | 1 +
>   hw/sh4/shix.c             | 1 +
>   3 files changed, 7 insertions(+)

Series:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And queued, thanks!


