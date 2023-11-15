Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A117D7EBAA6
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:41:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33xu-0007WW-FS; Tue, 14 Nov 2023 19:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33xs-0007WN-4r
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:41:08 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33xq-0000MQ-Gh
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:41:07 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b2f28caab9so3869221b6e.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700008865; x=1700613665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T6WnmlHy8oDXvoi7JvNmVa3K272wf2HZSTr/P/dEjc0=;
 b=qyAp0bjwIeyiKBT3v1KAXAptN3B9Os7Gjlxuh+QVerzo+07YpJYhtwYV/b/v7OHIRZ
 gsj1qtLhL9HpJX0pkNYayF51DZYRd9OT1KnL3ZUKjzb/Y2NMpv0PBkUGXCnF4plWWEzu
 XOOCiZXMuFO2C13qsneEtZtuJ6QOSJBf4rawT634cQys/xommO4e//HixPI20+vCNDZn
 /aMpOpv6Zi0Kskfz9sIVczGmt/+0PVMTw076IyyQkJFlPiTddDLBQpWwi6CvLVkZC7nW
 oH/NUkXqKDJoZZcMckVuRSFEXG3TndC0zjNLRyepFNGLe0Sgbldzz7nlhAUnoT3PLh2Z
 xobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700008865; x=1700613665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6WnmlHy8oDXvoi7JvNmVa3K272wf2HZSTr/P/dEjc0=;
 b=Vt4M3MphSU4nLO51K9DkuikCxt9t+kDda6OwZYCt/GxgSfi0/MTq4nLxvS0AI8+nV/
 FLLhktylfRif2LSU2+wKhL1VbZ8t78Z3gY8m63oFcX1PsPnlDAu48A0yc54cu/vIEkE0
 DGURT505qg8ekCrl8hYWW2OgjDjx7Y0pTR6pT0uS4UgwNCTl8M3sfBggCz/jBlQb/ONB
 wEWYroITOcxGv5M5iu3G8F17r7fFTQ+umh2VXre7CX8jRQg9/KLsrnhzo7xaMZL2EWmS
 J6cjgtBIVaB8rK6TF/v3HWRcKhFy/9im02NYSt/9rUttlXTS2kXTcc/mqIvyq+GWb+Hm
 OW6Q==
X-Gm-Message-State: AOJu0Yx/MrGzWydANMBcnT0ZMF14nAIq1XVXayo8MVv6/KMtKPa3QXKe
 KBV+0bURs/AAtIWTt7PcsTKaXA==
X-Google-Smtp-Source: AGHT+IEmIHQQm9MMSxl8LRzcKpgSjrqbKN9BETTwJPHey6r5baK4l1cKUC+3MTCy9G8NoJBX6vweDQ==
X-Received: by 2002:a05:6808:3d9:b0:3b6:d1cc:4c6 with SMTP id
 o25-20020a05680803d900b003b6d1cc04c6mr13200813oie.16.1700008864773; 
 Tue, 14 Nov 2023 16:41:04 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 2-20020a630202000000b005b3a91e8a94sm120068pgc.76.2023.11.14.16.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:41:04 -0800 (PST)
Message-ID: <c0708795-671d-4c75-94e8-db15947534e7@linaro.org>
Date: Tue, 14 Nov 2023 16:41:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/31] target/arm: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-9-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-9-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> No changes of the output from the following command before and
> after it's applied.
> 
> [gshan@gshan q]$ ./build/qemu-system-aarch64 -cpu ?
> Available CPUs:
>    a64fx
>    arm1026
>    arm1136
>    arm1136-r2
>    arm1176
>    arm11mpcore
>    arm926
>    arm946
>    cortex-a15
>    cortex-a35
>    cortex-a53
>    cortex-a55
>    cortex-a57
>    cortex-a7
>    cortex-a710
>    cortex-a72
>    cortex-a76
>    cortex-a8
>    cortex-a9
>    cortex-m0
>    cortex-m3
>    cortex-m33
>    cortex-m4
>    cortex-m55
>    cortex-m7
>    cortex-r5
>    cortex-r52
>    cortex-r5f
>    max
>    neoverse-n1
>    neoverse-n2
>    neoverse-v1
>    pxa250
>    pxa255
>    pxa260
>    pxa261
>    pxa262
>    pxa270-a0
>    pxa270-a1
>    pxa270
>    pxa270-b0
>    pxa270-b1
>    pxa270-c0
>    pxa270-c5
>    sa1100
>    sa1110
>    ti925t
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/arm/cpu.h    |  3 ---
>   target/arm/helper.c | 46 ---------------------------------------------
>   2 files changed, 49 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

