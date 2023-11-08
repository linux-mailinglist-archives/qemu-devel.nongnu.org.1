Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E457E52CC
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:43:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0f5l-00089n-19; Wed, 08 Nov 2023 04:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0f5i-00089U-A6
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:43:18 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0f5d-0000Lx-IZ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:43:15 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so88396511fa.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 01:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699436591; x=1700041391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cmKGUI0MXUu0G3l1gwbfWSG2rRPn9CNeDMhQ5ovvOUA=;
 b=l6eKzMyd6vFQPVEIQDADOpoTogzo2oDtMKaQot7q+tJcGFSa3wiSeTTDm3h/gTrczr
 yfokdlaRe4j4nr4Tefb5i2WU6J0rNIxHc2bZR/ud44gm2HxXnhom6qumFZHgP5xSxd1T
 K3brevnBsoqLeYsiTBq6CxV6F+Yn3cZ+iEqc2BQZhHKrgKZlfFLmY8do1Jh003f6ZfXY
 nt0b7Bw42X9R6uQK4S8CRhZ1wLYazVrekjnTfgEefn4Fhy39DY9CaUMoMm8QbFcXq8wi
 tzw3RJYTvhdipaSQu17FVF4a0HjXC2ZffhIXjBIsQ+K5sHcolt3KzFGgOyFajEgqQSS8
 yjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699436591; x=1700041391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmKGUI0MXUu0G3l1gwbfWSG2rRPn9CNeDMhQ5ovvOUA=;
 b=CrsAN9AG8ETUJvYOxxgVCK/U6kKY7f8iLYPlWBd8uHtlga5uFWoVVRxwfgsbnzbcCh
 SdCbzqur9Ao1g0SAmxaP1eq+Pgw6hkAHya+w7KdYnxN/JYILgBG0WtFAmtQkACa9svv9
 HJp4LiX8wq2hTCVzDQqJR5Q9BPh00RYRg4+9JhahOTG9sFjkk/9BNZsuTXpvTwD3+ScP
 +3mbAeBLqVH3uGkpCmCb/C5QPNK5Sw+sOeTWzt0/PbKkSHZ6WKAw/bKyZkhZsr/ICrED
 HmKiyMjT/d4eT8m+2ujFHu2p8UE40t04uNl+mrDEOYFKHaQ3CpyqXDlLlL5s56e0ygWp
 /RJA==
X-Gm-Message-State: AOJu0YwHwAMsg9HUwGW5X9cz7HKLVkaLZz9sYVrth2+RBGnHT8VybY5K
 l3xeG8LZOHeLDsYbZ8o90PSYIA==
X-Google-Smtp-Source: AGHT+IEqs+o4zoNpxELy76PmZzX8hRMJHWp7ecc1JUgbVGewMukw3tol6zp5c3uc6Tqayl36yCLR/Q==
X-Received: by 2002:a2e:9c57:0:b0:2c0:7d6:570a with SMTP id
 t23-20020a2e9c57000000b002c007d6570amr1053109ljj.33.1699436591377; 
 Wed, 08 Nov 2023 01:43:11 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4c9400b004065e235417sm17888707wmp.21.2023.11.08.01.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 01:43:10 -0800 (PST)
Message-ID: <4db39931-c8d3-4ce2-a7d6-a62578194763@linaro.org>
Date: Wed, 8 Nov 2023 10:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host/include/generic/host/atomic128: Fix compilation
 problem with Clang 17
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org
References: <20231108085954.313071-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231108085954.313071-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/11/23 09:59, Thomas Huth wrote:
> When compiling QEMU with Clang 17 on a s390x, the compilation fails:
> 
> In file included from ../accel/tcg/cputlb.c:32:
> In file included from /root/qemu/include/exec/helper-proto-common.h:10:
> In file included from /root/qemu/include/qemu/atomic128.h:62:
> /root/qemu/host/include/generic/host/atomic128-ldst.h:68:15: error:
>   __sync builtin operation MUST have natural alignment (consider using __
> atomic). [-Werror,-Wsync-alignment]
>     68 |     } while (!__sync_bool_compare_and_swap_16(ptr_align, old, new.i));
>        |               ^
> In file included from ../accel/tcg/cputlb.c:32:
> In file included from /root/qemu/include/exec/helper-proto-common.h:10:
> In file included from /root/qemu/include/qemu/atomic128.h:61:
> /root/qemu/host/include/generic/host/atomic128-cas.h:36:11: error:
>   __sync builtin operation MUST have natural alignment (consider using __a
> tomic). [-Werror,-Wsync-alignment]
>     36 |     r.i = __sync_val_compare_and_swap_16(ptr_align, c.i, n.i);
>        |           ^
> 2 errors generated.
> 
> It's arguably a bug in Clang since we already use __builtin_assume_aligned()
> to tell the compiler that the pointer is properly aligned. But according to
> https://github.com/llvm/llvm-project/issues/69146 it seems like the Clang
> folks don't see an easy fix on their side and recommend to use a type
> declared with __attribute__((aligned(16))) to work around this problem.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1934
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   host/include/generic/host/atomic128-cas.h  | 2 +-
>   host/include/generic/host/atomic128-ldst.h | 2 +-
>   include/qemu/int128.h                      | 1 +
>   3 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


