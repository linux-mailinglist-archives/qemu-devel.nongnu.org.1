Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81614799A80
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 20:59:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3A6-00058e-9b; Sat, 09 Sep 2023 14:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf3A0-00054j-1O
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 14:58:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf39w-0004ci-LC
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 14:58:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68c0cb00fb3so2934277b3a.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694285899; x=1694890699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EDP5tTjJ64cm2BQtFEqqVAp/P6uvjutVuIBNR4lVyv8=;
 b=FE2yRMyrNZnzVstSbuv1WxEZ1q2ZLUvom6o/+W+y7iLvn/f69kmTvHrGEXNDuncdgI
 G/HyhxeGsWEnrHKwbsr7HP0YdVNf9NiEcH1XjkKuAG5+hPhKeIXUDnU1JnRglRzrzDHs
 T8REcmOhAsR4JI5OuHPHz4Ut9YYEm6hLkG5V6giqR79L6GEwuAloox8ij1HZyhXWW/X9
 v2VQ2+K8f86uFQK4+N2DuPZ7j7ZY+nDjtdq4l8/96+q8ce3xNru5I53ccUyTJlQ97s1A
 7lNA8Ue1jxkbfdvIGpYnQrbshCS+c0MbfgOCNz7OxqksnhJJSNZxLYuNQXAZkNtYr6ma
 aYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694285899; x=1694890699;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EDP5tTjJ64cm2BQtFEqqVAp/P6uvjutVuIBNR4lVyv8=;
 b=rPdTZz+c5lP+6ski7P8SZEJAANr9OXCHpvKDgAoqPv+c+DBDkmInogWRzLuOqAME/R
 sh82A5+ooiNBcvSvtWulOP8QDLJaRvdEYJ/gIH+YxMlfMeVUsKdcnesHoEZcSUn7hQFB
 zqrLtRmrbeuQg4tvnubFDhIIt06SlKoI4QtVJ2ZXN8Jt01ZOSWNwxdDcGAKlF/FpCO72
 02PUgzqtFtwa7J+t7gxHfiX0gI7iM/9On09pKiahJqFBoqwn0H5/g7Q6HW1ExAG1TnB5
 EJr4Qvlvka7n7ZzRakGkilHE1s4KOPrboCSrUXr9MSH05ROSp5RkmyaPJ1dGcXJ95YPS
 FuEg==
X-Gm-Message-State: AOJu0YxZGndTAAzfO7SkuGrx32UXUYvJptHTTQOJh1xe1T5JN5T3QbLt
 RQLI6H/Q73iI7dSpQeuJ8Ca8mSSstEgBYXGBvgs=
X-Google-Smtp-Source: AGHT+IG6M3pZXFG2vjb8NbGr7dDwT2OgqghOfAL/AfLBW+d5U/HhsQmyou8nkyQnxr4UpTnu2AW+Vg==
X-Received: by 2002:a05:6a00:a17:b0:68a:31b2:5219 with SMTP id
 p23-20020a056a000a1700b0068a31b25219mr7058365pfh.22.1694285898849; 
 Sat, 09 Sep 2023 11:58:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 k17-20020aa78211000000b00682d79199e7sm2985217pfi.200.2023.09.09.11.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 11:58:18 -0700 (PDT)
Message-ID: <f5487017-4c14-4019-aade-8877eeb627cc@linaro.org>
Date: Sat, 9 Sep 2023 11:58:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 00/19] crypto: Provide clmul.h and host accel
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230821161854.419893-1-richard.henderson@linaro.org>
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Ping.

Still missing r-b on patches 1, 4, 5, 8, 9, 12, 13, 18.

r~

On 8/21/23 09:18, Richard Henderson wrote:
> Inspired by Ard Biesheuvel's RFC patches [1] for accelerating
> carry-less multiply under emulation.
> 
> Changes for v3:
>    * Update target/i386 ops_sse.h.
>    * Apply r-b.
> 
> Changes for v2:
>    * Only accelerate clmul_64; keep generic helpers for other sizes.
>    * Drop most of the Int128 interfaces, except for clmul_64.
>    * Use the same acceleration format as aes-round.h.
> 
> 
> r~
> 
> 
> [1] https://patchew.org/QEMU/20230601123332.3297404-1-ardb@kernel.org/
> 
> 
> Richard Henderson (19):
>    crypto: Add generic 8-bit carry-less multiply routines
>    target/arm: Use clmul_8* routines
>    target/s390x: Use clmul_8* routines
>    target/ppc: Use clmul_8* routines
>    crypto: Add generic 16-bit carry-less multiply routines
>    target/arm: Use clmul_16* routines
>    target/s390x: Use clmul_16* routines
>    target/ppc: Use clmul_16* routines
>    crypto: Add generic 32-bit carry-less multiply routines
>    target/arm: Use clmul_32* routines
>    target/s390x: Use clmul_32* routines
>    target/ppc: Use clmul_32* routines
>    crypto: Add generic 64-bit carry-less multiply routine
>    target/arm: Use clmul_64
>    target/i386: Use clmul_64
>    target/s390x: Use clmul_64
>    target/ppc: Use clmul_64
>    host/include/i386: Implement clmul.h
>    host/include/aarch64: Implement clmul.h
> 
>   host/include/aarch64/host/cpuinfo.h      |   1 +
>   host/include/aarch64/host/crypto/clmul.h |  41 +++++
>   host/include/generic/host/crypto/clmul.h |  15 ++
>   host/include/i386/host/cpuinfo.h         |   1 +
>   host/include/i386/host/crypto/clmul.h    |  29 ++++
>   host/include/x86_64/host/crypto/clmul.h  |   1 +
>   include/crypto/clmul.h                   |  83 ++++++++++
>   include/qemu/cpuid.h                     |   3 +
>   target/arm/tcg/vec_internal.h            |  11 --
>   target/i386/ops_sse.h                    |  40 ++---
>   crypto/clmul.c                           | 112 ++++++++++++++
>   target/arm/tcg/mve_helper.c              |  16 +-
>   target/arm/tcg/vec_helper.c              | 102 ++-----------
>   target/ppc/int_helper.c                  |  64 ++++----
>   target/s390x/tcg/vec_int_helper.c        | 186 ++++++++++-------------
>   util/cpuinfo-aarch64.c                   |   4 +-
>   util/cpuinfo-i386.c                      |   1 +
>   crypto/meson.build                       |   9 +-
>   18 files changed, 434 insertions(+), 285 deletions(-)
>   create mode 100644 host/include/aarch64/host/crypto/clmul.h
>   create mode 100644 host/include/generic/host/crypto/clmul.h
>   create mode 100644 host/include/i386/host/crypto/clmul.h
>   create mode 100644 host/include/x86_64/host/crypto/clmul.h
>   create mode 100644 include/crypto/clmul.h
>   create mode 100644 crypto/clmul.c
> 


