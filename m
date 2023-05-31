Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1CA717988
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Gp0-0008Hb-7E; Wed, 31 May 2023 04:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4GoX-00083F-Ub
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:04:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4GoW-0005RM-4w
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:04:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6042d605dso40161965e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685520250; x=1688112250;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GP7ltB3f8lWOmf7sLDdQWCWCkAFSQ9WZw+PAQ26UGwE=;
 b=fIMs29oOlgRRU+sUAoNdgvgmO1fQuweQ2dXJS/UAzwg2OFo/jFM0YFq5NIT2Mi4sEr
 /Ck7wdvtK/D3o+3NeEXWD6FC+K+8cM1SxzCKu97LxDc8iJc8+3FPAozBM8T4j111lc70
 as5tXGqVnCCtYK8snD5zo2231PH/7j1NCjEsL5BDupuqGExbs2Ixk21C6MEvLiLtzS79
 xfy5UpcqBpvaSvRy0+sxxIEu7vnBP2Fd3/zUl//F54wHMhze6HcnOvSlnD3XlfaHthXv
 aBiIk11gEEIY0uBNsi8qNpib/0LRdrfDdpSYhxU/cheoCX4DwvnYgfOgB1LvwN/SN5XC
 0JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685520250; x=1688112250;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GP7ltB3f8lWOmf7sLDdQWCWCkAFSQ9WZw+PAQ26UGwE=;
 b=ZyiMIwOEsdsdV814aCHDmdxf8xwQhcozcmy8vJ1SlmCsyVriYJRBWFU6za+pXVi3Ti
 KfOxMBkbKs+hb3MqkcCYRWB1y/UnJGLuPfz2nk1WJtOtzQ4A2iEUmcEr79r6U6nS84sv
 YpJ1AXBnV+1Tst1XfkezXcAfFY1Xhi3HQwzQs98SwnUvW1tV6ZwNA/WVRZ2uOhucDJ8t
 mh8rxprZCeCZy++hpMxTnsOePKVdzKLiLs8jBqvskqRaHbDw1rPf88bNTZERASW9ihCx
 qqsf/fjxwoIx92wl5kMXg6B00ITYNH2SD8OMCKmh2Z3ecUfsBXg3qgRINyvEQNGkZmVM
 hNzw==
X-Gm-Message-State: AC+VfDxAvDJTpkbmdxQDJdyYtfszMu6MU8e/cxkax+aBY8QpDeBWaj4w
 LSmcSvW1l1vfhueTLb/uttaA+Q==
X-Google-Smtp-Source: ACHHUZ40LoaQsCKAnYramW2PPI5plTaoLWoLZRVD2deCO/OxsjmqHWlNjnb9KK1TyEZNiuMMBwNABw==
X-Received: by 2002:a1c:7717:0:b0:3f6:15c:96fc with SMTP id
 t23-20020a1c7717000000b003f6015c96fcmr3549676wmi.17.1685520250429; 
 Wed, 31 May 2023 01:04:10 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a05600c21c400b003f0aefcc457sm23551506wmj.45.2023.05.31.01.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 01:04:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9CA541FFBB;
 Wed, 31 May 2023 09:04:09 +0100 (BST)
References: <20230530142430.45834-1-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC] Native Library Calls
Date: Wed, 31 May 2023 09:02:12 +0100
In-reply-to: <20230530142430.45834-1-fufuyqqqqqq@gmail.com>
Message-ID: <87mt1lc4g6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> This patch introduces a set of feature instructions for native calls
> and provides helpers to translate these instructions to corresponding
> native functions. A shared library is also implemented, where native
> functions are rewritten as feature instructions. At runtime, user
> programs load the shared library, and feature instructions are
> executed when native functions are called. This patch is applicable
> to user programs with architectures x86, x86_64, arm, aarch64, mips,
> and mips64. To build, compile libnative.c into a shared library for
> the user program's architecture and run the
> '../configure --enable-user-native-call && make' command.
>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  include/exec/user/native-func.h      |  8 +++
>  libnative.c                          | 76 ++++++++++++++++++++++++++++
<snip>
> --- /dev/null
> +++ b/libnative.c
> @@ -0,0 +1,76 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#define NATIVE_MEMCPY 0x1001
> +#define NATIVE_MEMCMP 0x1002
> +#define NATIVE_MEMSET 0x1003
> +#define NATIVE_STRCPY 0x1004
> +#define NATIVE_STRCMP 0x1005
> +#define NATIVE_STRCAT 0x1006
> +
> +void *memcpy(void *dest, const void *src, size_t n);
> +int memcmp(const void *s1, const void *s2, size_t n);
> +void *memset(void *s, int c, size_t n);
> +char *strcpy(char *dest, const char *src);
> +int strcmp(const char *s1, const char *s2);
> +char *strcat(char *dest, const char *src);
> +
> +#define STR_MACRO(str) #str
> +#define STR(num) STR_MACRO(num)
> +
> +#if defined(TARGET_X86_64) || defined(TARGET_I386)
> +
> +/* unused opcode */
> +#define __PREFIX_INSTR \
> +    ".byte 0x0f,0xff;"
> +
> +#define NATIVE_CALL_EXPR(func) \
> +    __PREFIX_INSTR             \
> +    ".word " STR(func) ";" : : :
> +#endif
> +
> +#if defined(TARGET_ARM) || defined(TARGET_AARCH64)
> +
> +/* unused syscall number */
> +#define __PREFIX_INSTR \
> +    "svc 0xff;"
> +
> +#define NATIVE_CALL_EXPR(func) \
> +    __PREFIX_INSTR             \
> +    ".word " STR(func) ";" : : :
> +
> +#endif
> +
> +#if defined(TARGET_MIPS) || defined(TARGET_MIPS64)
> +
> +/* unused bytes in syscall instructions */
> +#define NATIVE_CALL_EXPR(func) \
> +    ".long " STR((0x1 << 24) + (func << 8) + 0xC) ";" : : :
> +
> +#endif
> +
> +void *memcpy(void *dest, const void *src, size_t n)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCPY));
> +}
> +
> +int memcmp(const void *s1, const void *s2, size_t n)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCMP));
> +}
> +void *memset(void *s, int c, size_t n)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMSET));
> +}
> +char *strcpy(char *dest, const char *src)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCPY));
> +}
> +int strcmp(const char *s1, const char *s2)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCMP));
> +}
> +char *strcat(char *dest, const char *src)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCAT));
> +}

I've just realised we don't actually plumb libnative into the build. We
do have cross compilers available so we should use them when we have
them. See tests/tcg/$ARCH-linux-user/config-target.mak.

We also use these to build some of the firmware when needed.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

