Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C887E5CCE
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 18:59:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0mob-0001RQ-KZ; Wed, 08 Nov 2023 12:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0moZ-0001Qr-SY
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 12:58:07 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0moY-0004ue-6L
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 12:58:07 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc3bb32b5dso64702835ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 09:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699466281; x=1700071081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rLkQdS9K2tJkSdPGhqarVQweq7Lj8et8vEun6av1fX0=;
 b=bM8+m/2XFJTZFGDk1512YZNgJVyK2M1pkWpc6qgfb6ibK4S9N8iuj8Eyaj9cPBkHbm
 Rnt68lqY+ESIDk6zKALdInnvg8tUH4uA5mSLqEUMOAkJOKV5onKR4LDtN76mgden7gG8
 Z0JIzk1SZh2k+l4SpciinVliiBLue7aVpfJjqt5WUZJUay4Luki/NTfx1ZPl2rVd1a8L
 GRtSAq3mR87Zw1vLWz0P1KCaPIJ8+S12IrIV963Fk0weJcpqq5GhRZdxJL6U0af1u7Bj
 +UOY9lqwqXrmpprcPcTZhPihrWCBGzpcBLmm96aS44ApE9gYM6vngyY//0lGNF+BnZWk
 4jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699466281; x=1700071081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rLkQdS9K2tJkSdPGhqarVQweq7Lj8et8vEun6av1fX0=;
 b=m5/uo1N4m7xIAqb/RheWYmbu8DFB0PwfQrZpn2Nhfs4eXd5mTzjRa/bs7X1vOZk/Bo
 F7PjPk8ut4hfFGvzfwSlg3V7pfnCb8Bmx0jC7XOErJw84rjbIUdZYffLGgTP2pVLppL6
 4FZIW80o9quhVwPTR52P8YJQK4QtUwePSck5SIPUCcoOqYJCU/UIQOchO6qpqRXCzYWy
 00FEsVw+ctv9bGs1SHFV6vl+crbSoIdfMLvlO5McP6jEcT3UDJaeOeMlOEH5v+cxISja
 U4KRr02wLUxhDE9gKRM3Q4U7H8rV44tBOhBB8SGYydO0weJOQoHaNA7QD8vvGKgZgvW4
 bFDA==
X-Gm-Message-State: AOJu0YzWglBogr3E3oXUHOrs2dborAKnxUm/CAyLONizyynqc2AnYz8P
 Dpl8QzRtQgn4HstMTjspM8tIlA==
X-Google-Smtp-Source: AGHT+IF5JHNh5tKUyBqeZ0ypdorNboVg+7lIx5wL1YLnhYK/fD5zUZ73V1oBgFGqZrs88Rvd1lZ6TA==
X-Received: by 2002:a17:902:da89:b0:1cc:665d:f822 with SMTP id
 j9-20020a170902da8900b001cc665df822mr3154823plx.32.1699466280865; 
 Wed, 08 Nov 2023 09:58:00 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a17090341cd00b001bdb85291casm2012181ple.208.2023.11.08.09.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 09:58:00 -0800 (PST)
Message-ID: <b5945b9e-f696-4a71-b358-b95a5aaa7da9@linaro.org>
Date: Wed, 8 Nov 2023 09:57:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host/include/generic/host/atomic128: Fix compilation
 problem with Clang 17
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20231108085954.313071-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231108085954.313071-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 11/8/23 00:59, Thomas Huth wrote:
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

