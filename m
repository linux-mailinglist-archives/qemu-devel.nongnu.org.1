Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8624826C1F
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:07:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnTT-0001ga-3g; Mon, 08 Jan 2024 06:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnTI-0001V6-P0
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:07:10 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnTG-00036g-EM
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:07:08 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7811db57cb4so142252985a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704712025; x=1705316825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NnkEp8gUOsdF2Aq//6qpECXLC0VnSwCYzR8pykb3uuk=;
 b=JAE4Pl70ln7M19JUitEJS2KyCkPpxA/qCqMlIRmfkVBVDvgj1FX1t0ghqRt+EOyjOr
 Xs9n5XrmWk+a8fC2kxEkmFycbzAuIbUR+ietP+CzuZ+RJaefBTepZqMaeBbTSh5Imbon
 3N+WOh43qoY3NnUUFzfQlyTOBKbBllyYPlQXfeEP6uQZvjWT+N4njxvuHkNAZeKQwWCy
 Vq914hndYCUaAhBhP/jvkD8C5rCa23mwUL+tT6Ta7XHwFZkZvI1rctChmRD6NmlwZj+0
 MdIcdxs+diiJdH39tZ3utQaWtcwEfyXIYCPVnOhccgfZcp/at5E3i3qOjk9es7zRaqWl
 yrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704712025; x=1705316825;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NnkEp8gUOsdF2Aq//6qpECXLC0VnSwCYzR8pykb3uuk=;
 b=qYf12DPxD/e8NzKjlbEmv2yIidoAnfPdmgbUKGYfY56dqxf1jFFWZJ9SpnSJvqLsYI
 6pwDNmw2j9az7D5IPsAdkV2LJPGgQW+aCrDUmspfkmpEMbib4bhoh5frua03BNR00son
 l5NbR7W7T55Uavg7AWBNKgxEf/BnR2RHKbNeFJ4f4EQ9NvU8zyp1wHD5e6hGnwXCvZlh
 EeTaViPX2gkTqQnu5ENT0twKvt27tnirYeGkTWFFM4LGTtHSpVsEjwXi/+6xZkka4sYM
 LNSKrz9MbUOx9B2NF4K7SGWYXQ+k5n15bx96+6Y0WEkueurXfWi3YMTF+3XxP3mcCn/X
 QtWA==
X-Gm-Message-State: AOJu0Ywbl4VYHc80FQ0P9AnlLt+cGbN+lIoaQcu8XAup3eIq9mkDuQ60
 uotGi93wmat66eWIQFR8HIBKllhpZ28yicuGPAiytGj4dEg=
X-Google-Smtp-Source: AGHT+IF2nsUtrdj6JCL3HiO8j7Blak+ecQZ1fhvAdDTDP3VxGn3QqvSg4JgTZOxpqC/3Ub9c5mmaKw==
X-Received: by 2002:a05:620a:8221:b0:77f:25ef:eb92 with SMTP id
 ow33-20020a05620a822100b0077f25efeb92mr7926235qkn.27.1704712025076; 
 Mon, 08 Jan 2024 03:07:05 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a05620a164a00b00781663f3161sm2592930qko.85.2024.01.08.03.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:07:04 -0800 (PST)
Message-ID: <ae55d6b5-d520-4da0-b2d8-b5bfe9d97904@linaro.org>
Date: Mon, 8 Jan 2024 15:07:02 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/33] tests/tcg: Remove run-test-mmap-*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-25-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72b.google.com
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

On 1/2/24 05:57, Richard Henderson wrote:
> These tests are confused, because -p does not change
> the guest page size, but the host page size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/alpha/Makefile.target     |  3 ---
>   tests/tcg/arm/Makefile.target       |  3 ---
>   tests/tcg/hppa/Makefile.target      |  3 ---
>   tests/tcg/i386/Makefile.target      |  3 ---
>   tests/tcg/m68k/Makefile.target      |  3 ---
>   tests/tcg/multiarch/Makefile.target |  9 ---------
>   tests/tcg/ppc/Makefile.target       | 12 ------------
>   tests/tcg/sh4/Makefile.target       |  3 ---
>   tests/tcg/sparc64/Makefile.target   |  6 ------
>   9 files changed, 45 deletions(-)
>   delete mode 100644 tests/tcg/ppc/Makefile.target
>   delete mode 100644 tests/tcg/sparc64/Makefile.target
> 
> diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
> index b94500a7d9..fdd7ddf64e 100644
> --- a/tests/tcg/alpha/Makefile.target
> +++ b/tests/tcg/alpha/Makefile.target
> @@ -13,6 +13,3 @@ test-cmov: test-cond.c
>   	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
>   
>   run-test-cmov: test-cmov
> -
> -# On Alpha Linux only supports 8k pages
> -EXTRA_RUNS+=run-test-mmap-8192
> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
> index 3473f4619e..0a1965fce7 100644
> --- a/tests/tcg/arm/Makefile.target
> +++ b/tests/tcg/arm/Makefile.target
> @@ -79,6 +79,3 @@ sha512-vector: sha512.c
>   ARM_TESTS += sha512-vector
>   
>   TESTS += $(ARM_TESTS)
> -
> -# On ARM Linux only supports 4k pages
> -EXTRA_RUNS+=run-test-mmap-4096
> diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
> index cdd0d572a7..ea5ae2186d 100644
> --- a/tests/tcg/hppa/Makefile.target
> +++ b/tests/tcg/hppa/Makefile.target
> @@ -2,9 +2,6 @@
>   #
>   # HPPA specific tweaks - specifically masking out broken tests
>   
> -# On parisc Linux supports 4K/16K/64K (but currently only 4k works)
> -EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-16384 run-test-mmap-65536
> -
>   # This triggers failures for hppa-linux about 1% of the time
>   # HPPA is the odd target that can't use the sigtramp page;
>   # it requires the full vdso with dwarf2 unwind info.
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> index 3dec7c6c42..53540ac96a 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -71,9 +71,6 @@ endif
>   I386_TESTS:=$(filter-out $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
>   TESTS=$(MULTIARCH_TESTS) $(I386_TESTS)
>   
> -# On i386 and x86_64 Linux only supports 4k pages (large pages are a different hack)
> -EXTRA_RUNS+=run-test-mmap-4096
> -
>   sha512-sse: CFLAGS=-msse4.1 -O3
>   sha512-sse: sha512.c
>   	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
> index 6ff214e60a..33f7b1b127 100644
> --- a/tests/tcg/m68k/Makefile.target
> +++ b/tests/tcg/m68k/Makefile.target
> @@ -5,6 +5,3 @@
>   
>   VPATH += $(SRC_PATH)/tests/tcg/m68k
>   TESTS += trap denormal
> -
> -# On m68k Linux supports 4k and 8k pages (but 8k is currently broken)
> -EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
> index d31ba8d6ae..313f7417ba 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -51,18 +51,9 @@ run-plugin-vma-pthread-with-%: vma-pthread
>   	$(call skip-test, $<, "flaky on CI?")
>   endif
>   
> -# We define the runner for test-mmap after the individual
> -# architectures have defined their supported pages sizes. If no
> -# additional page sizes are defined we only run the default test.
> -
> -# default case (host page size)
>   run-test-mmap: test-mmap
>   	$(call run-test, test-mmap, $(QEMU) $<, $< (default))
>   
> -# additional page sizes (defined by each architecture adding to EXTRA_RUNS)
> -run-test-mmap-%: test-mmap
> -	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<, $< ($* byte pages))
> -
>   ifneq ($(GDB),)
>   GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
>   
> diff --git a/tests/tcg/ppc/Makefile.target b/tests/tcg/ppc/Makefile.target
> deleted file mode 100644
> index f5e08c7376..0000000000
> --- a/tests/tcg/ppc/Makefile.target
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -# -*- Mode: makefile -*-
> -#
> -# PPC - included from tests/tcg/Makefile
> -#
> -
> -ifneq (,$(findstring 64,$(TARGET_NAME)))
> -# On PPC64 Linux can be configured with 4k (default) or 64k pages (currently broken)
> -EXTRA_RUNS+=run-test-mmap-4096 #run-test-mmap-65536
> -else
> -# On PPC32 Linux supports 4K/16K/64K/256K (but currently only 4k works)
> -EXTRA_RUNS+=run-test-mmap-4096 #run-test-mmap-16384 run-test-mmap-65536 run-test-mmap-262144
> -endif
> diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
> index 47c39a44b6..16eaa850a8 100644
> --- a/tests/tcg/sh4/Makefile.target
> +++ b/tests/tcg/sh4/Makefile.target
> @@ -3,9 +3,6 @@
>   # SuperH specific tweaks
>   #
>   
> -# On sh Linux supports 4k, 8k, 16k and 64k pages (but only 4k currently works)
> -EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192 run-test-mmap-16384 run-test-mmap-65536
> -
>   # This triggers failures for sh4-linux about 10% of the time.
>   # Random SIGSEGV at unpredictable guest address, cause unknown.
>   run-signals: signals
> diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefile.target
> deleted file mode 100644
> index 408dace783..0000000000
> --- a/tests/tcg/sparc64/Makefile.target
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# -*- Mode: makefile -*-
> -#
> -# sparc specific tweaks
> -
> -# On Sparc64 Linux support 8k pages
> -EXTRA_RUNS+=run-test-mmap-8192

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

