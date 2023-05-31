Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23519718474
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:15:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MbE-0000OR-2X; Wed, 31 May 2023 10:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MbA-0000OH-Hu
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:14:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Mb8-0000Qy-M5
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:14:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6e13940daso61848915e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685542484; x=1688134484;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nEq8SS25/oJcOQZOyqKR5A3ZGera/VcpzaXDFGuUoFY=;
 b=LsmOtuuz5rwpI+KvMfKurIrSuJN2mk4aZ/2tWVXUZsniojZTFu6dY8jy+1wWGZMlIP
 R68aTTE/FMzl7UxehQtV/fl3D5jCoYWHHVWldW2uHJota5B7xu+wxqSvXMJN8TNMRn0m
 1qlzq9uCQY1ZF/0BAV19e4aEZI9AOb9TJPFMfhyJctvz9TIHROtXXGl4CqH83aoFhK2T
 SAR+ekF/SQMM71k4Fe1mglLjNmYJNm33Lul95RpJQF7ATfm0eG8F3crxTG+bKQXdpZTj
 tgUMYinc3ARevbXQ9ro0GfQ9iMr9k1GvIYsQEcBYTYyo4K4i8jZLhhPapHWmX9hMS9N2
 eM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685542484; x=1688134484;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nEq8SS25/oJcOQZOyqKR5A3ZGera/VcpzaXDFGuUoFY=;
 b=b0xynfktPlZwqzq+B31+MnRb07/JCx5G35XS2StVgTMMM7d08qVdj7z2T3JQChxMC0
 P6Q3NR+KUSdDJprERy2a0ukfgjPxX/H4tHlL6NozoLJz3hZg3sUy6F/+sloQ9pvIChuN
 OiqLilq3lLg1hjFozV2DDMLSiAOl4XQ4UWeC1KIDrGP5u6vicRidvQg8qZOHTVnENjk3
 /+i6i5IqfUJYw5CBxkq+MsQeL03hYgpVBnf9VDbsDxIcStLqAi4mFi0IvqGYVA8oNFwp
 tEgYiTBozIBg5NoZRWOwmNVvLsisMijK9XQG9IGHIIkDfEPVbbdQdhu61IqY/gHK3Ie7
 ZU7g==
X-Gm-Message-State: AC+VfDyxk8KoELh7tE8gAN5hGbstkuPAlimmRQ+RnAOW2YbP8k21IIpg
 YmkiJgC5GRHCI1uMQTGJUfvAyA==
X-Google-Smtp-Source: ACHHUZ6+ii/g5u+OKEXF6YvMdR9dmQxe/ayHqKsvv2eyAEjhwv3WU9GYNR0vEN9MZNdWAHLdaj+iXA==
X-Received: by 2002:a05:600c:acd:b0:3f4:253b:92a9 with SMTP id
 c13-20020a05600c0acd00b003f4253b92a9mr4401397wmr.30.1685542484427; 
 Wed, 31 May 2023 07:14:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a7bc7d6000000b003f4fbd9cdb3sm20845611wmk.34.2023.05.31.07.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 07:14:43 -0700 (PDT)
Message-ID: <b87f853c-bb2d-d3df-b2f6-3a13bbb12a93@linaro.org>
Date: Wed, 31 May 2023 16:14:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 19/48] tcg: Move TCGHelperInfo and dependencies to
 tcg/helper-info.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 06:03, Richard Henderson wrote:
> This will be required outside of tcg-internal.h soon.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/helper-info.h | 59 +++++++++++++++++++++++++++++++++++++++
>   tcg/tcg-internal.h        | 47 +------------------------------
>   2 files changed, 60 insertions(+), 46 deletions(-)
>   create mode 100644 include/tcg/helper-info.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


