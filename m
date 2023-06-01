Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D441719100
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:10:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Yhm-0003W6-PM; Wed, 31 May 2023 23:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yhk-0003VZ-Gc
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:10:24 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yhi-0001gy-Qn
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:10:24 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-3f6bb5e8ed2so2464891cf.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 20:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685589021; x=1688181021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jwhO8v48lzUhCJVA9SNVdwsnfkyhktZGOfQ1MAJIZ0U=;
 b=ZFmLm3AQCyLHiT0bD44V+Xzgs/8AZoyHAQNBbQNsxBcRmCBzIMj9C8sZWG3kZa2t3f
 pQ5UhBJFEIPTAaHmKnnK5wU4aT9yjE5N26dqv9potX9cXeOK3LKNIklga5mOmG37V1TZ
 veSXWbETNM5TjiqXbTB+1XtQ/Yws745ohMYQfrRUElBWMuH2ohbC1zBE7UXAgO/4if4C
 EpcZaILtmBBnyFdFWoelYj1QKLZI8sGaQ/JuKq479dWW1AsKFh/RRTYgbcrsp7Omb6EO
 wmLOXLBZN10w2udfjcJ+nQt1KBVM5V5nQn/i4/MpszY7QWax+HgTXU1jsOvwo6ItVvhJ
 EKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685589021; x=1688181021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jwhO8v48lzUhCJVA9SNVdwsnfkyhktZGOfQ1MAJIZ0U=;
 b=KKcbDqqgYMHyBVY25yLvI30jOX7gn+WMoy73WzcyOr/dnVu/fAEhyZHLmwOZCvbhck
 jorPPVdSrJvUNMvktwicn86EtWpqEo35bzFewLDqyuZb+3H9lTFQMD5mjYRfpXV9dCQ/
 WtYEuDVgSH0OTA2HYKazmSzEkXlPSZaeg5y/m0BhBSyUk7Z08c7IwZiHpGfWnN0fzYgw
 ZiEgIZT+zIlessVWjgjz8TlCW6Fih2U0ryxH5etHxLVQ/HyAVPtTmpA/SCQOyxfHB99s
 WsE5+jWSwyc3b+o60E9S/EiJ+eIBZIMF+bFYjyaoR/74/zc24aqxz/ax/BUYVoC2ZZyQ
 sPLQ==
X-Gm-Message-State: AC+VfDzt+t1NxIX3idNtGBfn1drbb1PXsfAY+vbvqGT7hMJZlMf3VDyC
 nolVqCJ7kU70h9cGwUpBUvg9lA==
X-Google-Smtp-Source: ACHHUZ7xfHFgur5DOIXKUlob8tJkfz3l2kRfdAb4rtisutRkc859WYplony5cngCGpuN0z43irFl3A==
X-Received: by 2002:ac8:5cc4:0:b0:3f5:41d9:fde8 with SMTP id
 s4-20020ac85cc4000000b003f541d9fde8mr7703596qta.57.1685589021665; 
 Wed, 31 May 2023 20:10:21 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 y126-20020a633284000000b0050f9b7e64fasm2037629pgy.77.2023.05.31.20.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 20:10:21 -0700 (PDT)
Message-ID: <2b01867f-2c9f-8704-54da-f618eca69913@linaro.org>
Date: Wed, 31 May 2023 20:10:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/7] hw/sysbus: Make SYSBUS_DEVICE_GPIO_IRQ API internal
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230531223341.34827-1-philmd@linaro.org>
 <20230531223341.34827-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531223341.34827-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/31/23 15:33, Philippe Mathieu-Daudé wrote:
> Since we don't have any use of the SYSBUS_DEVICE_GPIO_IRQ definition
> outside of sysbus.c, we can reduce its scope, making it internal to
> the API.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/sysbus.h | 2 --
>   hw/core/sysbus.c    | 2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)

Yay!

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

