Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED4183144C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 09:14:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNWP-0008Ph-4i; Thu, 18 Jan 2024 03:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQNWJ-0008P7-7h
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 03:13:03 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQNWH-0007kU-Lq
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 03:13:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e76626170so43011825e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 00:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705565580; x=1706170380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6d5Gn5oC26MIaTuRmxEm3iyNRu1tovKGV3urh6vM/w=;
 b=FjqUZ77YbgAdZp/AeJYEN+AVPQJTVonn+uAHfaGhSPmzeYNg0m2A7l2bYQJt1m3ngu
 dGZjvJtngrr27mKzfD06jcsOlxwk2PPAQOrV14PjNoSrpretSxTVSj8earYTqeDWp1XP
 2UvbID6RYc6SkdY1br5IfwrvFwrRHNDecapnzyFLZUvKxjekgklPzv+x29ty3taKLt5p
 zd2jOHFmAVQVrtLn1WlOdKZhpRk0fPSphHM0MNUzPq5NGE96Gwl4PnHLsQt3iczrUCYB
 qETOmK49sWh7pvik44CaUCwG2MWMV5FLJPToxE7CQixsD0TQ09WkEllqYmEIiJQeE0cc
 RXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705565580; x=1706170380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W6d5Gn5oC26MIaTuRmxEm3iyNRu1tovKGV3urh6vM/w=;
 b=L8x0fym/vSetL3iu6AiDNgqa4lViQAQl9UNmEIce5syltqyn6RFi031ygmqcrsU9wh
 lqrLvhxJalXTI0MpRt3jqzt+nBXt7TI8cbfg3DQwd90MpNO26MXKglsfkGnyhvIVEqqy
 ld/kaxhLaPzE2m5OkSA0QmNOuq1a4uzKY0Fw7wQRhg+z48flv0Sb5NZLafSLM0xSr+IC
 5TfSVPxGxmMXp9LcUSndVyfIj4PaIaR+ZbUJ7gaJCb8944qoWgd/GjWGtsEavjcXLt/f
 KDXltZ7t6eJ+4FJ6yI+IPOqQbCwhXlk8x6/P+/AV+YdUXyP6xgnXa52p2DMOZPc57qEm
 nNbQ==
X-Gm-Message-State: AOJu0Yx4twosMKGfxUw5pT71CGTrRitK+nRpXioad2Ap0dgPhVZ3DSq2
 +96kJIOMPCFn5F+tD5JFgY277yIijheDyi5wVPmV4ymTM3RJJsuNJST9wuZpr0M=
X-Google-Smtp-Source: AGHT+IEHt7o/UP0g9aGroGu5dBpWj+mGFfmAd6f0CL6nApcZxtNYkoUrv5Z2o+RM7RRzSQ27C/UuJA==
X-Received: by 2002:a05:600c:5127:b0:40c:55c4:45f5 with SMTP id
 o39-20020a05600c512700b0040c55c445f5mr251252wms.132.1705565579737; 
 Thu, 18 Jan 2024 00:12:59 -0800 (PST)
Received: from [192.168.61.175] (31.red-95-127-38.staticip.rima-tde.net.
 [95.127.38.31]) by smtp.gmail.com with ESMTPSA id
 w6-20020adfee46000000b00337cf4a20c6sm818336wro.31.2024.01.18.00.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 00:12:59 -0800 (PST)
Message-ID: <8da792b9-f85f-4b2e-b6f6-094c664a953f@linaro.org>
Date: Thu, 18 Jan 2024 09:09:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] intel_iommu: Tear down address spaces before IOMMU
 reset
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
 <20240117091559.144730-4-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240117091559.144730-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Peter,

On 17/1/24 10:15, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> No bug report for this, but logically tearing down of existing address
> space should happen before reset of IOMMU state / registers, because the
> current address spaces may still rely on those information.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1a07faddb4..8b467cbbd2 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4090,8 +4090,8 @@ static void vtd_reset(DeviceState *dev)
>   {
>       IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
>   
> -    vtd_init(s);
>       vtd_address_space_refresh_all(s);
> +    vtd_init(s);
>   }

You might want to convert to 3-phases reset API here, calling
vtd_address_space_refresh_all() in a ResettableEnterPhase handler
and vtd_init() in ResettableHoldPhase (or ResettableExitPhase?).

