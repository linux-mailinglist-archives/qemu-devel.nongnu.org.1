Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3607DA8E7
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:25:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwova-0006Px-G2; Sat, 28 Oct 2023 15:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwovY-0006OS-SB
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:24:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwovX-0000Tr-BF
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:24:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b5e6301a19so3154272b3a.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698521094; x=1699125894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j5kYdfxDs3iFYwleCQwmRSWTd7rPCAN6Tr+Jmwis1Is=;
 b=Y6rsHypI66JMdE9kTQfnlflTqwQq8tpDrKYFxuD/YgM4CqD6WBgG/Pp3sCjFHEhXJ+
 7YwsZX9TUjX4/huSeRBdEV8R0iYe0Jw+hEOT00bzRCz6Ul/bbb6W5UAI/CNevEjtTnkP
 wHIvGM6G2WXz7+N0NHLkniz3v+85bgjeEtGoEs7bd3p+PooarW3u8aY0LrWRY6BK6mHW
 FaUfqShPetnBkdXtPdBjOism40Pyi3zL2lBCxcTyRRn4IOXugnru2LWmF51bSgEsIs8Y
 sryvsguhi/MFTpFPk92c0/utc16fcELO/X8rl0IVZoeYhM9rDkrObUMw/cq1tQ2OHn4A
 aQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698521094; x=1699125894;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j5kYdfxDs3iFYwleCQwmRSWTd7rPCAN6Tr+Jmwis1Is=;
 b=hYeblA4UCFp28Dpc3zktehdSlkWtksahx0sTRnsDAqVz+7Hy/YfnT7W3I6/TTNylVW
 1ecjFSe7Wgx3ANBU48SwPK/Vqa37320vBaADeP6IcMAINdy2UPx1xXKpntRlua28SPAa
 RTO0R2RwHu9cNsqNID4xqhrtZkjLLjpyKK3TAn1CjsN3tcWYPo+3lkdGZnJXsrRmwfIp
 Cn4/lsBctv7NCRCz6EkKoG6my+5FBRc2bUDue/QK7HmUczi/0qkmc/XVMGWwNNS88HMy
 7nQAranNW3K8d2574yTVgyyuuOLLM6TBKsA6kkNbX80dg0htKFOWnle4hQrjKW4zOzaH
 f1cg==
X-Gm-Message-State: AOJu0YzIqBaO8HTCGtS5xPuNCv0Qiwc4MFR4/SEgcet+UHb+WD/JEoWs
 RVGL8VkMU06wSwMMuS4pQPm/YA==
X-Google-Smtp-Source: AGHT+IE54p/MHLBaZn2bddUdUJvOvrere60H+jO8pC1mGTX8nNWoPeIBa3Lor3C6ENDHwsw/kx7JCA==
X-Received: by 2002:a05:6a21:47c7:b0:16b:f586:3c4 with SMTP id
 as7-20020a056a2147c700b0016bf58603c4mr7409355pzc.58.1698521093994; 
 Sat, 28 Oct 2023 12:24:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fn4-20020a056a002fc400b006b4ac8885b4sm3390045pfb.14.2023.10.28.12.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:24:53 -0700 (PDT)
Message-ID: <1f799c12-bb8e-4337-b5f5-f0f1d0fd045f@linaro.org>
Date: Sat, 28 Oct 2023 12:24:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] tests/docker: use debian-all-test-cross for mips64
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/28/23 03:33, Alex Bennée wrote:
> Maintaining two sets of containers for test building is silly. While
> it makes sense for the QEMU cross-compile targets to have their own
> fat containers built by lcitool we might as well merge the other
> random debian based compilers into the same one used on gitlab.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure                                     |  2 +-
>   .gitlab-ci.d/container-cross.yml              |  6 ------
>   tests/docker/Makefile.include                 |  1 -
>   .../dockerfiles/debian-mips64-cross.docker    | 19 -------------------
>   4 files changed, 1 insertion(+), 27 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

