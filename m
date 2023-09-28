Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C17B261B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:48:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwzY-0004R2-Li; Thu, 28 Sep 2023 15:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwzU-0004PI-NI
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:48:04 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwzS-00013Y-QF
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:48:04 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-690bfd4f3ebso10550343b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695930480; x=1696535280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I3w6cuFLTNl6joPKz+cVZkzDDXpL5yF4RLSKyX3k2fY=;
 b=syX7btWsYei/y4egUygEwTPEe+EDYQVc/AyXcaLlG9fGAkHbN9gaqArzsDiXdVXW2w
 NaBMrl/6LqRb/276iPTrg/NDPu3adT9N3U51/XQH2/X+i2cPxvs8wjAJLGe45NEyDeWr
 kn7ureVCkk08A68ogJAke2o4y8vShKmE2683AS4o6wsI1PizIQnMsTnEmvyWs7bEq8rn
 DScSTr2cklnS8hWfoYnx2ZHCFlgIR7oz1I22MZYM7v3B9R9BZPPc1auMRY5StJQWPL/W
 FlkLEdOM62KdIjdOCT42Jw98SPKKxw2X/kCnGgMNiHMIshZA698g5U2o28h0QUHwVkbA
 rnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695930480; x=1696535280;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3w6cuFLTNl6joPKz+cVZkzDDXpL5yF4RLSKyX3k2fY=;
 b=pNppZoTwTqmhmVVE6jlo2APCMAEMkvwtp9K8mW9QRt77e82v0Wqe9K32w3Mnor4aMH
 Z8gezoiUPIJxm4Wj20xraYekGrjT/y6kKF9vZkhGuGiGS/wlqYiQhe4I6jx5nx1lEDow
 tfosxZjEoQC+EQbQssFoMtvA+oNL+q4rEvBIEAmfidLhFOkYFtC7NprIVmgsb97Td8MN
 X2yc1sKIMnMEDTh2O0J8TUWqS1iJ2u4nGzEiiSz/ZX15aRZ7qWALwTLGnIaikPBwwS7q
 nzGz3hAqe1PMyw7GHVf8fDO1ilCD8SAeDPmZqdCkzW5hVQGCn63GKo/g7Z6pzmsSyQOp
 q1Tw==
X-Gm-Message-State: AOJu0YwJso79iEy20mJYn2piZHgtEgI+IA2M8Tk/+1Jiy/LiuS0rF5fp
 sndx7AXslPJAQ5TtuBN6v+mq5g==
X-Google-Smtp-Source: AGHT+IF2nAsMxbiMqobGrKD9Jj5Jp6slQl4jUsfjn17Q0iLiBkyVdr2pn2YNSiF6GP4d8jXMEkeK4w==
X-Received: by 2002:a05:6a00:1748:b0:68e:3eb6:d45 with SMTP id
 j8-20020a056a00174800b0068e3eb60d45mr2180815pfc.30.1695930480490; 
 Thu, 28 Sep 2023 12:48:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 o28-20020a637e5c000000b0057cb5a780ebsm11518178pgn.76.2023.09.28.12.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 12:48:00 -0700 (PDT)
Message-ID: <8557943c-05e6-aa34-f479-e4a1ab12f69d@linaro.org>
Date: Thu, 28 Sep 2023 12:47:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/arm/common-semi-target.h: Remove unnecessary
 boot.h include
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230925112219.3919261-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230925112219.3919261-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 9/25/23 07:22, Peter Maydell wrote:
> The hw/arm/boot.h include in common-semi-target.h is not actually
> needed, and it's a bit odd because it pulls a hw/arm header into a
> target/arm file.
> 
> This include was originally needed because the semihosting code used
> the arm_boot_info struct to get the base address of the RAM in system
> emulation, to use in a (bad) heuristic for the return values for the
> SYS_HEAPINFO semihosting call.  We've since overhauled how we
> calculate the HEAPINFO values in system emulation, and the code no
> longer uses the arm_boot_info struct.
> 
> Remove the now-redundant include line, and instead directly include
> the cpu-qom.h header that we were previously getting via boot.h.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/common-semi-target.h | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

