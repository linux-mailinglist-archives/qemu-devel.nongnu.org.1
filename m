Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D8278B620
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafmG-0006gE-Bq; Mon, 28 Aug 2023 13:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qafm5-0006Sy-Db
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:11:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qafm0-0005Iz-K8
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:11:37 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so2872967f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693242691; x=1693847491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xaDbjoyHeH4SIpK5gVdsutEucsHDPYzquxyGlOye2CE=;
 b=aq5DDV7AD/nsX/qGpXm/SWbKkih0cUci534rYr+fpfIRsEZ0KIVKVyvBOG3sleaInw
 K6j0dsJTiLgGlFHIcrVsoPfwB0O/WTV/+zs0dZoTnLyKu0ibwkAVB2dZVF0rESvtNK4b
 vkPt+12DdJJ2qUkW4Mc+sbXj4ysWjpdwbSDBW6BAqutlnDt8UQBEzCSUUCkkxxjcNanE
 sJfPUE8ypPhswKkvygKRP+l83YOEsF+keSBJ1vmlsfZBeYq2n+81Q2DquUu9qvn0EpDI
 DHIjR6Xn0GdtIn7rhp8nj2H7n6psJrcaN+voW4QSsB8HlP2IYpxuQBJ1CTnFUccsI+aT
 BckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693242691; x=1693847491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xaDbjoyHeH4SIpK5gVdsutEucsHDPYzquxyGlOye2CE=;
 b=bN1UsvzVyogoVB1DOYFmos3mkt3nz/L5iorxQC9CBYgz5/0yj1D+hzOBeqR6k51y8F
 npPbxID2S6A04/qoqEMHr4EgS+47Rh3VVOHh8jIixCOTO/xbCZFs3ddxQ6spkIzxhXT+
 99IQOnHSObeYFUVLev8tJ14iVdZ6PhSKuvIMrSlwS2VE7GxcRQlXx4GgHR3I8wt/vJCv
 c60s/qUfEB5lX0/JGE/AIRiGg3QNKgOOUnavS7NzrCKl7rLkFSlue+sflril0tkh9Z1T
 PTCDuTQRaMrW8pfiVAbGU2DWKpG+psChbW6Tv1n7RpDFsn05NssDoPs0swJ0GUBtP1Z0
 kDlw==
X-Gm-Message-State: AOJu0Yxndu3U7oBCgiHCMPafQ1fXXY4aCKfVTurMVUSu3o9vHmZco80Y
 f8Vy6ecOVp7XGXQL3UZn0ATj1Q==
X-Google-Smtp-Source: AGHT+IGvsgh/yLLfRWlAOTrNQkSEI/W7O7iaNxMZ2xuq1xIpntbM7V3EYLwxlUdccJHKjA7lgulEww==
X-Received: by 2002:adf:cf09:0:b0:317:6ea5:ab71 with SMTP id
 o9-20020adfcf09000000b003176ea5ab71mr17213367wrj.30.1693242691004; 
 Mon, 28 Aug 2023 10:11:31 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c365300b003fed1ba0b8esm11408333wmq.8.2023.08.28.10.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:11:30 -0700 (PDT)
Message-ID: <65ccba91-565a-5dc4-7d2f-dbb7578ca83f@linaro.org>
Date: Mon, 28 Aug 2023 19:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 13/32] hw/sd: Introduce a "sd-card" SPI variant model
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Bin Meng <bin.meng@windriver.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-14-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703132509.2474225-14-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 3/7/23 15:24, Cédric Le Goater wrote:
> and replace the SDState::spi attribute with a test checking the
> SDProto array of commands.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/sd/sd.h  |  3 +++
>   hw/arm/stellaris.c  |  3 +--
>   hw/riscv/sifive_u.c |  3 +--
>   hw/sd/sd.c          | 52 +++++++++++++++++++++++++++++++++------------
>   4 files changed, 43 insertions(+), 18 deletions(-)

I'd rather TYPE_SD_CARD_SPI have a SSI parent bus, having
the realize() method create an internal TYPE_SSI_SD
SD <-> SPI bus bridge, and attaching the SD card on it.
Then we could even make TYPE_SSI_SD private.

Anyway, "can be done later" and "good enough for now"
I suppose, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

