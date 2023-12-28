Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8CB81F372
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 01:37:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIeNI-0004Us-4i; Wed, 27 Dec 2023 19:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIeN5-0004OR-4L
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:35:37 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIeN3-0002fa-Dy
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:35:34 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d9a795cffbso2016602b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 16:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703723731; x=1704328531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=psuphBxHsi+8TV4IpOtqt9VCOF2n/GnOnM6qRWZGDrs=;
 b=YeJnGV2MMK9mH1qsHJQcK755Xi8Z4te1nD3xYI9cs0PeDLdJ9ssZegiBlg8QKmhQO3
 AtvRGEEVvFqhB/8Yr1t1rdCDHGNg+z+UBuTJbHDG4w4h4uosAvvSBG94EHce1B0EEfg7
 cFSCmDs3/1oYNmV4yuqNlsGKVgwWHMmIZ8x4pI97zif//TjJGO9OpWZEixRFlR0DmSBe
 AMcYqltDuvVeM8UXhVRaoCssqCrqoSzLHoDfWKBBvjAv8aTM2PE+5aWcbaybDUWHyfDa
 L4FDddQPtZqV2HwUwGn9Zxspy+AyK63uYrRgIKXCmB3FwrVXOuSw06PMcksS31psG87n
 rzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703723731; x=1704328531;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=psuphBxHsi+8TV4IpOtqt9VCOF2n/GnOnM6qRWZGDrs=;
 b=gmOUvZWj4qFHMX687YhF7fHC88LZHEuWCoG+9GJjaDKeDt1zHAi0RN1U3sr0cx+gRP
 oG9oUl0PZcEwVsjDQg2VambjLtvBZoHTY8GWswQKekyWsM8Lrp6NBt6Ig2k4TvVfzhwc
 nzKKfIUGvTJSnzaYOQgUPe7sb+ttaZfsULYzvoBqKJJRANH6VRxuZCizwcyeNTHJxYLQ
 kqbPuUVrQnadgVBAUsAI0Ype1udDESOsYSt6YstB55vTRI4MpWDKCGhLCoRQCzRcdj9H
 Mj4SAI59Pf97XW6i6hrDNYlXSAW2PtZddp0s3nKfAvKZubFgqLx528s4O2dIYQDFWluv
 uYIg==
X-Gm-Message-State: AOJu0YySQNCYvm2oXo4DKQ3av2o02nPXTa5E/6Rl9mIzuf0GbpaVXd4U
 lf1adBAOq5hblBh5t69K8tbgXLEEvLc9EA==
X-Google-Smtp-Source: AGHT+IEDx7o57cXe9wIdaoXp9PMcc6nkDQHLLRKTUu5OcHbmAmS3ROKNBUryDLBYS1eWaXIa4lQ8dQ==
X-Received: by 2002:a05:6a00:1d0a:b0:6d9:be60:9b93 with SMTP id
 a10-20020a056a001d0a00b006d9be609b93mr6105884pfx.12.1703723731250; 
 Wed, 27 Dec 2023 16:35:31 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a634756000000b005cd945c0399sm11861840pgk.80.2023.12.27.16.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 16:35:30 -0800 (PST)
Message-ID: <e0bcbc40-6d5d-443d-9003-6dd76f96c771@linaro.org>
Date: Thu, 28 Dec 2023 11:35:23 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/35] target/arm: Mark up VNCR offsets (offsets 0x0..0xff)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-29-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-29-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 12/18/23 22:32, Peter Maydell wrote:
> Mark up the cpreginfo structs to indicate offsets for system
> registers from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ in
> the Arm ARM. This commit covers offsets below 0x100; all of these
> registers are redirected to memory regardless of the value of
> HCR_EL2.NV1.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

