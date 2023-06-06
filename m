Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1567245FC
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:30:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XhH-00039U-0z; Tue, 06 Jun 2023 10:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Xh5-00032t-S1
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:29:56 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Xh3-0000a1-4a
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:29:55 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-53fbb3a013dso5675326a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686061792; x=1688653792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o0XnDz4BJ5M9khAi12lzjtgCuFHU98s/PWfB01AaiPU=;
 b=J2CyBKcYRJxR4uZyg3TRESo9+RxXyDoeFAQacTzIW5A5tvIdxfYs+lq1wlrQOEieVg
 u1pvyOdeXnq4zuo75bgOBQ5eG+hPhltMuvYJ7F4rWAsWT9WKEcfPBd0/FCjNJTgpONGK
 n3VWtCIktuXh6rDEXaLKRdaLMOpNmnHn1jaFGdbzxo3ZFoXisAaI+oVDiDZOzy9JukRq
 Gy66MkNy+JHk/clJqoQCg53FQ4c0eskWrJfgrr6bx30n/l0D2JRRYTOkB8rjvSKiOgRM
 88tMfQkDM5DFeqjMtCjkkAvC448PkFuSalQ8UFMbjOjCH/CdL7CjxubWd+p3LNF6JmXc
 fG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061792; x=1688653792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o0XnDz4BJ5M9khAi12lzjtgCuFHU98s/PWfB01AaiPU=;
 b=URHGCg98D2CanfjeSA3gioU/25BIUJ92cVtJIbxhOlWF31lqgpnXOJVAkW8X69vFsF
 YZ2WrDnkBECGyPZUQAZnJ7DPS0DFuKNo9GlBnyUAO7vOJDGvMgZOle1xckMDuDxj0yOf
 KYPkVAw2dvc+SArquqpxUGi8Vv99CjJTDXIkyCddQRH33BnX+5vOwphZ+g2Ta3/MOaDV
 MpgyQWGAi2ludUmRgcX1wrFZ+jAP8MqNDng9goozbAWAQ+k6XkZ1uFI2yJFa0hUjV53J
 u5oZpzDaGobyxGXMgYdiX4vzbgYMDjvwV41mFvhYvScESZiL1+0BJgGR2hBsn9JPzf9V
 Hs/g==
X-Gm-Message-State: AC+VfDwwiD8Y2CI6WBc0IQIc1puYkTcETxzNVvnJjULq49JeBh73neBw
 QluJmrwl5vPADGeovop1gZq1Fv3pD7/LYUFPjG0=
X-Google-Smtp-Source: ACHHUZ4/DPotijfhKEJixkSCHDSuaAoGq1ix4wE5ca9AE4f0MZOInRV6xvOZk+5YZptSXG+eUY40MQ==
X-Received: by 2002:a17:90a:194e:b0:259:224a:9d05 with SMTP id
 14-20020a17090a194e00b00259224a9d05mr2090396pjh.3.1686061791808; 
 Tue, 06 Jun 2023 07:29:51 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 em20-20020a17090b015400b002535a0f2028sm9551098pjb.51.2023.06.06.07.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:29:51 -0700 (PDT)
Message-ID: <324917f6-62fd-9930-8d33-725ec934ee75@linaro.org>
Date: Tue, 6 Jun 2023 07:29:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] tests/tcg/aarch64: Rename bti-crt.inc.c ->
 bti-crt.c.inc
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
References: <20230606141252.95032-1-philmd@linaro.org>
 <20230606141252.95032-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230606141252.95032-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/6/23 07:12, Philippe Mathieu-Daudé wrote:
> Since commit 139c1837db ("meson: rename included C source files
> to .c.inc"), QEMU standard procedure for included C files is to
> use *.c.inc.
> 
> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
> about includes") this is documented as the Coding Style:
> 
>    If you do use template header files they should be named with
>    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>    being included for expansion.
> 
> Therefore rename 'bti-crt.inc.c' as 'bti-crt.c.inc'.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   tests/tcg/aarch64/bti-1.c                          | 2 +-
>   tests/tcg/aarch64/bti-3.c                          | 2 +-
>   tests/tcg/aarch64/{bti-crt.inc.c => bti-crt.c.inc} | 0
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename tests/tcg/aarch64/{bti-crt.inc.c => bti-crt.c.inc} (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

