Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB1A71F065
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 19:13:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4lqG-0001Ft-OR; Thu, 01 Jun 2023 13:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q4lqD-0001D5-78
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 13:12:01 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q4lq8-0005xb-9s
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 13:12:00 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-96fe88cd2fcso148415666b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685639514; x=1688231514;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bpnIYG1WWrR3cGpvPSFYxbTCsws385yfGazSCMdwV5k=;
 b=ejA6UQjjuULohvP5tXw1yX+2C4AejYpha67Ph4ugiGBldl28/eWRUfNl5itd6V/ypQ
 ww6m50xFoXxgMFgh/kIs6dK7mmgshuPPeNT8zaKvUZvX53Qknh1CT1hha4ZIhoSO40zx
 Enzdx+FdfE3AUgcyAhg7NosuPBg6CSyd+dEQDqgtmmSEJDgKr6iz+x83AYIBXCJDPYVk
 EG7faqO4fsWLF4zkGTCUgqcDVSoZ5p/RjAn6tfKDAJ4Ux5NEx4QwDGQXVthRd52yG2uX
 JlIvzvyD8sXnIlyyzZjmm3iNyRguy8P02So2RI9Ww+1VyFKZtAjEZYXpZm24YlTqKy8P
 3CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685639514; x=1688231514;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bpnIYG1WWrR3cGpvPSFYxbTCsws385yfGazSCMdwV5k=;
 b=YTgV5lvcY3Cnq5kq0gSpy9Hpuq2B4CYS+YtJDgomhUlacxfsxUcZLz33jZ+LJTlDX5
 5q7M/XUUIV0I9EtXMjsDVZjo6dhw2bmChE9n/rEKCizzq+PFZRzsG/IlfH2tPiBm0Xqi
 b2sdyl2guMw/oFGAj6bxAS8myBR6c/JgFoZFFs00bRsAbddJ9mLFyAKzZY8m50faelxH
 afetAtgqG10g8P8o60/NWaGczhmLM8BcOi5QLEf0JXEiFyVeclEoMgCsPl0b9crN4Ai9
 Df5NWwg+PtWEqGwI0Bvoxafu9y6263CwMELYcaZuCnlXmFXn3R+CDqtrt5gUy35pWXRL
 XNbQ==
X-Gm-Message-State: AC+VfDzz+rCBxy7xRL5Op0K3F8LaXelV3Z5ae3EeKvtT611JAq6NyBz4
 vKcg6cRSHtdcG9VSDp1hH9WrCg==
X-Google-Smtp-Source: ACHHUZ4cFPosHpyaoIq2b0/pYWtpI/h/QcvnKrNNYJJatqiAMm/0OtVZ692kwutlBuQdPtsWxDRdJA==
X-Received: by 2002:a17:907:1c86:b0:96f:2b40:4503 with SMTP id
 nb6-20020a1709071c8600b0096f2b404503mr8238528ejc.74.1685639514019; 
 Thu, 01 Jun 2023 10:11:54 -0700 (PDT)
Received: from [192.168.200.206] (83.21.93.182.ipv4.supernova.orange.pl.
 [83.21.93.182]) by smtp.gmail.com with ESMTPSA id
 gz15-20020a170906f2cf00b00965ac8f8a3dsm10935839ejb.173.2023.06.01.10.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 10:11:53 -0700 (PDT)
Message-ID: <5b8e5ca1-2fba-6edd-6fa7-14b003ec2ff8@linaro.org>
Date: Thu, 1 Jun 2023 19:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Content-Language: pl-PL, en-GB, en-HK
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Graeme Gregory <graeme@xora.org.uk>, wangyuquan1236@phytium.com.cn,
 chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
 <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
 <CAFEAcA8h9-YWUYsvuERttmsEK3xi+K+xasFdoWmnFm26S6npNw@mail.gmail.com>
 <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
 <CAFEAcA_9Prr1xV2s1q2+GpWEnrsEEFT57bbLDnop5Hw3MaxM0A@mail.gmail.com>
 <da42c1fc-4adc-5eaa-2d72-6747b74f8ae8@linaro.org>
 <CAFEAcA9pUGUa4ev_y3U1z1BdU+AaGGKtRMcQjC5prvWvT9AWEg@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA9pUGUa4ev_y3U1z1BdU+AaGGKtRMcQjC5prvWvT9AWEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

W dniu 1.06.2023 o 18:39, Peter Maydell pisze:
>> So something like below? I only tested does system boot into Debian.
>> To make it work also changes to EDK2 would be needed to list XHCI
>> controller in DSDT.

> Yes, and you also want to drop the useless EHCI controller,
> and (as you note) both these things mean firmware changes
> so presumably that's a version-bump event?

First we need to get two patches through TF-A to get current information 
from QEMU. And it takes time.

https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/20871

https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/20953

