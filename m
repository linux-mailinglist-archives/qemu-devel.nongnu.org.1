Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF5B7E205C
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:51:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy8m-0002dj-TS; Mon, 06 Nov 2023 06:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy8C-0002QY-M5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:51:00 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy8A-00066h-VC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:51:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso26295375e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271457; x=1699876257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yFhNlYHYGt4+Q8AKsGvblSPO23bXpZTGH/vRuzTIMR8=;
 b=FAzzdNeoMWuDN0lcc3FEWJGWOkGoUoG3ZxKUHzlofnFmniEmAj9Bg4a3CDbjvH+QYQ
 yoV0YiNZrPTH0a0i26y1BTFztL3IDgJ672ze2frgLgC9VvfLxUmm516zbjyq4VE9JiTV
 Eaj2K9U+RyCKr+haMNxcw4DvJR3pIeHwEwccb9I4yQxeWNW7wgdGSa1bT+OT6zAJcnue
 uNwC2q7ZLCB8A9OPGkTVL8cdhieFDxK/u2YHof0/t+8xs0MYXRTCPEvgeDHLvcX0JT6J
 eFomD3QKuWC2QYDBdRCiPuupFPguAkzICMCC21uNMmJ27zbXJkZj96WK5+s/I9qRwlxm
 5H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271457; x=1699876257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yFhNlYHYGt4+Q8AKsGvblSPO23bXpZTGH/vRuzTIMR8=;
 b=JBmmrEr1OGiwBfOdhmtNUlxgw4ECsY5GcJAGdLP1/RiNk0C/SgBnlCYFSiLHKHm2a3
 wI4+lWZlQ9oC80M8gDtkvHBTV2iLfz6A07r/U+oZBz9S1IcEzint+wyEdmYB1n28zNzd
 NSNoZ7Sr3q0NJDKhAyCKv/xnbMj/k0y+D9wEDxbm64SvtxPhv4PlKAUjLxEiCQzsn1Ej
 iCoOoYNSZdMS3Pey2mGqVOc8b9VejniJkPtp2iYtjGls5Szp7STD/T6rgc/68kKgeBwF
 1uVP9D32If6cOQwMhi1QCdpbhITHZxxKZ6JkNIXBtUjr8ruM8A5AeBZxgxtdsHfhAf/h
 Kwnw==
X-Gm-Message-State: AOJu0Yz3L5AQVqsCaVOPzM5yOcvEfjCpYu0DL7gpJl+wGJ9buvp+yobY
 1b44aajrXucDDzygpnqVVUh9Mg==
X-Google-Smtp-Source: AGHT+IFogCkMXxsjYsLboTj9PhASPxXIrbb23ojD2cCBL6qo9VWegzbWb/xp0SvLY8uQ+u1tUQEf2Q==
X-Received: by 2002:a05:600c:45c7:b0:408:33ba:569a with SMTP id
 s7-20020a05600c45c700b0040833ba569amr11140141wmo.8.1699271457264; 
 Mon, 06 Nov 2023 03:50:57 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c3b8500b004064e3b94afsm12186240wms.4.2023.11.06.03.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:50:56 -0800 (PST)
Message-ID: <af1008b4-ee67-a5f8-ec3c-083a2258629a@linaro.org>
Date: Mon, 6 Nov 2023 12:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 52/71] hw/sd: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-53-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-53-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 6/11/23 07:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/sd/allwinner-sdhost.c | 2 +-
>   hw/sd/aspeed_sdhci.c     | 2 +-
>   hw/sd/bcm2835_sdhost.c   | 2 +-
>   hw/sd/cadence_sdhci.c    | 2 +-
>   hw/sd/npcm7xx_sdhci.c    | 2 +-
>   hw/sd/pl181.c            | 2 +-
>   hw/sd/pxa2xx_mmci.c      | 2 +-
>   hw/sd/sd.c               | 6 +++---
>   hw/sd/sdhci.c            | 6 +++---
>   hw/sd/ssi-sd.c           | 2 +-
>   10 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


