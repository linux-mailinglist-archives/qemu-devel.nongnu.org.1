Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A33BC799BE5
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 00:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf6ID-0000iq-N9; Sat, 09 Sep 2023 18:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf6I7-0000fe-Fp
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 18:18:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf6I5-0005IF-BF
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 18:18:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf11b1c7d0so29940055ad.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694297936; x=1694902736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Us81877DVhbNJO9n0y/yT7mE10ZAcWDFBW+7dfm9auU=;
 b=C38ws0U4qb8bEnrF1fHEkUS49z/jV+B0pJjIsVKFwTI6kSBF/tWFNSFwK8eYpUKjl8
 9EDbwEJWKQbQ5TnJWCUc43/1te5CWA0tVXPbt5+R7fEnN+j/cQPZ6z/HE8OpMWmEsowm
 clvu1IGodr5Yt23hKu5CkhBxCpAaTBT8xmNpHz5aMPN39YGjHJxheFpAm5RNg63HEA37
 oUFSpt9UX4IzxqHy328cW07z6E6i3aHhNEpjs/3Ixo0wGgGZYehF+kWHT/rI5pr0B4Xj
 4IFcje/TZ6Gx9RLkwdBFsa/yHkzkx+cSyFkDZxM83sUtOlwo4c32E+lI5VGkNj3xLrFN
 tgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694297936; x=1694902736;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Us81877DVhbNJO9n0y/yT7mE10ZAcWDFBW+7dfm9auU=;
 b=NvYB/8ngO+zBn3pgxrIyW6LoK+1PrDD4P2qUPymGDqsG1AOLhjsAWUcv1lik1EWSIH
 960qg9rY+sKMcoDAZRCuj5zmXmb2bDTyICD8XpjdSoXZBQlAZIYh3+G6caQpjbR60/mg
 bLuTlf+wykow0YzYqps1qzMUrBUJ6k95U66aO2OO9E9htj03D4BSJ1E2lR1klYSqEiWR
 Te0B2j9WmAvLbjbfGfDNYqyzbXGtS5NxKGqE09vhzP/5KWVX5GHTJASZ/Lmx3A0zIxQe
 qD3KC0sxOypdPDoUNv3AI53zyaKzVLCbMpP+gCIZDZvqEp7UyclW0GeL5jP0fFUTS0Ft
 IMjQ==
X-Gm-Message-State: AOJu0YyZoFRjtF/DK7UML+7ZeT6Tq4aCPhCxEvQY3Uwm1xqh4yZwLvF0
 f9r2iJQbDJcbooThgi55+hEKgg==
X-Google-Smtp-Source: AGHT+IE+uswNM4QEjwjaZA8l4BsNCBAyEi1vLmZjFtKyc++DneV/tdkHjnmEO/NQX1X9xt2pqd3X9g==
X-Received: by 2002:a17:90b:17c5:b0:26d:49a0:2071 with SMTP id
 me5-20020a17090b17c500b0026d49a02071mr8015801pjb.13.1694297935740; 
 Sat, 09 Sep 2023 15:18:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 12-20020a17090a194c00b0026f90d7947csm3465656pjh.34.2023.09.09.15.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 15:18:55 -0700 (PDT)
Message-ID: <c65ed67c-6d16-f06e-e6c2-6acb736771f7@linaro.org>
Date: Sat, 9 Sep 2023 15:18:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] hw/cpu: Call object_class_is_abstract() once in
 cpu_class_by_name()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230908112235.75914-1-philmd@linaro.org>
 <20230908112235.75914-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230908112235.75914-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 9/8/23 04:22, Philippe Mathieu-Daudé wrote:
> Let CPUClass::class_by_name() handlers to return abstract classes,
> and filter them once in the public cpu_class_by_name() method.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/core/cpu.h  |  7 ++++---
>   hw/core/cpu-common.c   | 14 +++++++++++---
>   target/arm/cpu.c       |  3 +--
>   target/avr/cpu.c       |  3 +--
>   target/cris/cpu.c      |  3 +--
>   target/hexagon/cpu.c   |  3 +--
>   target/loongarch/cpu.c |  3 +--
>   target/m68k/cpu.c      |  3 +--
>   target/openrisc/cpu.c  |  3 +--
>   target/riscv/cpu.c     |  3 +--
>   target/rx/cpu.c        |  6 +-----
>   target/sh4/cpu.c       |  3 ---
>   target/tricore/cpu.c   |  3 +--
>   target/xtensa/cpu.c    |  3 +--
>   14 files changed, 26 insertions(+), 34 deletions(-)

Missed the cleanup for alpha, which you introduced in patch 1.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

