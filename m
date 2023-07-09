Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E474C6BF
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 19:31:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIYF1-0006KC-R4; Sun, 09 Jul 2023 13:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIYEl-0006J2-3T
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 13:30:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIYEi-0008RI-R3
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 13:30:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso37295285e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688923814; x=1691515814;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=07M1587FEq0sWlOfQNvGLw+Ouq/W1Ksd/L+2eTxyMZ0=;
 b=q5LvXOpmmIPADKRtKBdZoC84++8uqbaH71rLaZUPTCbk3PLLkIWY3JlJfU5VPovQRh
 6BqLqjDHjAwk58DEAvOgWCEAT72DZdPwQN2jUpFSWrso0KoOIMdyYIWxDRyHo7yoq3GH
 2iUHmPhEgIBrUbMfELJOTiLZ3le9KSdJ29fjN6fqWCXEJm9hprSpzm08QN/mrYvYq2YB
 AHqBULzZypgrITd5jUhuuXl1AvAReqIaY3BNs+uQCWCqVmQnEABirazKyDTDw13qSc7B
 H1lDPHm1nks28o8awt+LUfs49YyXJRl9mtlB/++20jMxwIC5vV5NZGhYpNa8Eg1iBn1m
 b3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688923814; x=1691515814;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=07M1587FEq0sWlOfQNvGLw+Ouq/W1Ksd/L+2eTxyMZ0=;
 b=LaeUIiaQAqBr3LxuNyb4CvkK01YKhCOcDBXkw3nCwBTCD8yNAPVYms3OvghGWifpKA
 3glqI/EORnOmFb/wZC2K1yHfSj2Pc5QvwKAqW+YC3uCTE4wyTwl5KNjvuBP4St3DJacD
 vEkBJZj8ORwge8W00f35YEEs7ETKk20hxtfq3hpCSiXkG+EaJ/P55G3nIVg99l7DOwCN
 QXNQzLwq8KEAzTS9hm6yBjKCyTlhPjtheENheoa+ITG9oRdvPjIsuoutg6F+cNGXCBAN
 tqntpcB2a/EpeAyOzZeRFgIyS+Iugkpt3lMdDyPxwBuJ5Grd29wU7kJRh54Emm14lZHJ
 ofMw==
X-Gm-Message-State: ABy/qLZbDGzkyWnvOad2pw9Eh1elk3z1TYpRF+zM6PZGUfK60D5IgRsq
 67vxiZDvSrqJe70g6qK/LvBdx8IfiTqPBSwX0Hs5/g==
X-Google-Smtp-Source: APBJJlF4fhQI3em0Rw+O7SpcWFyXE3WjiOwY5xAL/prcCMoBrYvvDEbXnb5c0F9pBCfY2Kt2sXPiKA==
X-Received: by 2002:a05:600c:2805:b0:3fc:80a:993e with SMTP id
 m5-20020a05600c280500b003fc080a993emr3266483wmb.17.1688923813821; 
 Sun, 09 Jul 2023 10:30:13 -0700 (PDT)
Received: from [192.168.8.133] ([148.252.133.210])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a7bc00d000000b003fbc0a49b57sm8136220wmb.6.2023.07.09.10.30.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jul 2023 10:30:13 -0700 (PDT)
Message-ID: <8a6ed4d0-cc5a-5a23-2523-8d05b24b57bc@linaro.org>
Date: Sun, 9 Jul 2023 18:30:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/37] crypto: Provide aes-round.h and host accel
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230709135945.250311-1-richard.henderson@linaro.org>
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 7/9/23 14:59, Richard Henderson wrote:
> The following changes since commit 276d72ca1b9017916cadc7c170d0d6b31633a9e5:
> 
>    Merge tag 'pull-ppc-20230707-1' ofhttps://gitlab.com/danielhb/qemu  into staging (2023-07-07 22:23:17 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230709
> 
> for you to fetch changes up to ff494c8e2a4c857dd37fb908d8ac8158f5e4f89b:
> 
>    crypto: Unexport AES_*_rot, AES_TeN, AES_TdN (2023-07-09 13:48:23 +0100)
> 
> ----------------------------------------------------------------
> crypto: Provide aes-round.h and host accel

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


