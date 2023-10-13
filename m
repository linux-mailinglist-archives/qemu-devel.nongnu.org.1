Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDAB7C7CB8
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:32:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9q1-00016L-E2; Fri, 13 Oct 2023 00:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9pz-00016D-NO
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:31:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9py-00017J-62
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:31:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9fa869a63so1814685ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697171503; x=1697776303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7OmGRlNIkw1lYktjWEVaPS41MAbmjd4p8wed79YkpNg=;
 b=GLdyi0oYHSY/Bn5HVcmIxr1fI7w9YshuZ4ChZHSG1VOmOybqSN0/0Efm3J6Rj8M22X
 kpg5gbWFPrdd/+kGK+ASz7Y1kIO8nXV6FGyS8Rn/CEL66Rc4QEHk1vH6LzDhge8t1Myy
 yJQdp6fTQxKz8einHWR9qs2uL/MJoexVqMPEjIgsw6KY1Rlaz9yT7hRu6E8bHl/2P5R2
 8wXCewZAGSbO3ML8YWmfRnIanN8nvrkd9+wiyc0a9JjWQ8HsAak8o6N1VJgD/UeDvAMK
 JZnvQxLfOQ9eq2ZByM95nhA5BPLGuNdAUiquma1w+OQmGlIobxBqEs55qdpPmEqJskcy
 liKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697171503; x=1697776303;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7OmGRlNIkw1lYktjWEVaPS41MAbmjd4p8wed79YkpNg=;
 b=Wkohj0Ki9P3LlE5RWU7nIQuaMJchMwz5TVM6o137FOoDgI2d67fg2sAWaxCqyuKZ05
 Z0Il8Q4TFS/wNy09DqnCyjVJZhld9mhyWzA1ifllzI44Juc6vW9Q5zrIsEiVQnAVmHzt
 h5zzCUCtD3SrgZtbr0dUozYeLc2yrhSUgbMrC+XYzJVzGqYW3JYhkRKOXf+JuEOzKXo4
 wRsXT5wJLS7lV7QnRpFxEhPE9ioGCP9oZF7oBdp0Ja6AmUotrHKktG9XBz90QTydcnsM
 cyELZshWfFo3k5gVNw0ILZXzrIVKUjWqo/E0787q3QGBVaw2YrraU6oiUbMK8uzaecke
 yOJA==
X-Gm-Message-State: AOJu0YzdPaA6HpBlDQ1OdxivLHgmOpR+EoglCEWE6TN8guPr4PnOZG5S
 65alM1ZGXs43t5H7N7eMnVVB7A==
X-Google-Smtp-Source: AGHT+IG4TXGCHa1IhuA/u0tMbmerK7gUU+DG9Jgvml3lraLc8NRd7ZiGw3QVG//Fpk3Z684w8yZ+dQ==
X-Received: by 2002:a17:902:da81:b0:1c9:db23:704c with SMTP id
 j1-20020a170902da8100b001c9db23704cmr5566659plx.27.1697171503426; 
 Thu, 12 Oct 2023 21:31:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 i16-20020a170902c95000b001c73f51e61csm2811792pla.106.2023.10.12.21.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:31:43 -0700 (PDT)
Message-ID: <a443c60e-bef1-4fa4-8b3a-713e013acd72@linaro.org>
Date: Thu, 12 Oct 2023 21:31:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] target/i386: Make X86_CPU common to new I386_CPU /
 X86_64_CPU types
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> "target/foo/cpu-qom.h" can not use any target specific definitions.
> 
> Currently "target/i386/cpu-qom.h" defines TYPE_X86_CPU depending
> on the i386/x86_64 build type. This doesn't scale in a heterogeneous
> context where we need to access both types concurrently.
> 
> In order to do that, introduce the new I386_CPU / X86_64_CPU
> types, both inheriting a common TYPE_X86_CPU base type.
> 
> Keep the current "base" and "max" CPU types as 32 or 64-bit,
> depending on the binary built.
> 
> Adapt the cpu-plug-test, since the 'base' architecture is now
> common to both 32/64-bit x86 targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/cpu-qom.h       | 16 +++++++++-------
>   target/i386/cpu.h           |  3 +++
>   target/i386/cpu.c           | 20 ++++++++++++++++++--
>   tests/qtest/cpu-plug-test.c |  2 +-
>   4 files changed, 31 insertions(+), 10 deletions(-)

I suppose the concurrent existence of these two types will be used by follow-on cleanups?

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

