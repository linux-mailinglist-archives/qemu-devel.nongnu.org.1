Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1061782419
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyvE-0006Xt-E1; Mon, 21 Aug 2023 03:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyuh-0006VC-M2
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:01:26 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyud-00065N-Ff
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:01:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso732942f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692601261; x=1693206061;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8d1aKDDRAY300osh579nOjCHwiD6n4Ualhbuidh8T4Y=;
 b=DWT0mVJZg3EM5B4H5HJZm9QGX1na9ixikDpg9BCpgXqXJ+AV+IdOHD9c1/m/4kgRX7
 euPWmXX1hBAa7mTt2TzqGi+YnNVtZpTjdNRn5yY3ZfW6gmFtYsdEIuN6XeWWExF8hVXv
 kSKyG8k2N4z4we91/Rn+2jEHhTs44No8xGevS/YkuQMxlTDVUZ2k0n/XP9PH6x/GxDNA
 YWrevbS4IyAhYkiB9eakpaALa6hkS9hyi4IgfBKVa2PJz1lIuVg508nRTilIw+Z/Qc5x
 pcaV93pznzNblT7eNrII1BQyosmFxny3Ma+SVTAAZxqmw26hAmLC/vGpf2SdXUlpzVyE
 hxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692601261; x=1693206061;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8d1aKDDRAY300osh579nOjCHwiD6n4Ualhbuidh8T4Y=;
 b=cb7G0r+NK1bDf8jBU2j0JQzqV15yAf9/VGcaYOmRx7SYQsxsaNdMECwCZwRiH75bx4
 jdWGnDUUZ/GZvM8RJw3xua/ikMKN/wp3bhmYXfRuVfztZJcIVC803WTSUs+4iudnhvVW
 haZHzbHDfcf76TFjtyyiiTq7Hvhq3dNJruVVX/zXW263/f/vOdikq/jSzZ5sd8NnFRkZ
 ccyKex8ONptMrVF8GmaY1EUUz9SLDcr6el+n47povTepu9KmNjvpg5vyxNP8/B8jFQu7
 x2gdJtkn8CipKAo343Uk3+bU9hdevnPKu1NB3I9Wt+SjLNCrbCyN8jpov0vmDlUUys2W
 YMxg==
X-Gm-Message-State: AOJu0Yzwdq1uEEp4hpjUyzbBdoscHaV+kVbZEPlOcNR6f7gXKIPHb0ve
 PNc5y5Na5taaikZusA8/u8AcKA==
X-Google-Smtp-Source: AGHT+IHY5V+KTsltW5TN9DSy4eYWCPfIINv/JR7QgoHmgHwT2KQ9WhZiiDBCSMNGNDPbgLGC3VHWBw==
X-Received: by 2002:a5d:4803:0:b0:317:df3a:d030 with SMTP id
 l3-20020a5d4803000000b00317df3ad030mr4304395wrq.14.1692601260902; 
 Mon, 21 Aug 2023 00:01:00 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 r5-20020adfe685000000b0030647449730sm11450126wrm.74.2023.08.21.00.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:01:00 -0700 (PDT)
Message-ID: <0e2676aa-20a8-891d-4169-5c24260391d3@linaro.org>
Date: Mon, 21 Aug 2023 09:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 27/33] cpu: Remove page_size_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230818171227.141728-1-richard.henderson@linaro.org>
 <20230818171227.141728-28-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818171227.141728-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 18/8/23 19:12, Richard Henderson wrote:
> Move qemu_host_page_{size,mask} and HOST_PAGE_ALIGN into bsd-user.
> It should be removed from bsd-user as well, but defer that cleanup.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/qemu.h           |  7 +++++++
>   include/exec/cpu-common.h |  7 -------
>   include/hw/core/cpu.h     |  2 --
>   accel/tcg/translate-all.c |  1 -
>   bsd-user/main.c           | 12 ++++++++++++
>   cpu.c                     | 13 -------------
>   softmmu/vl.c              |  1 -
>   7 files changed, 19 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


