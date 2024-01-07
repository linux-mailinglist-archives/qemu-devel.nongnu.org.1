Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFEA8263D8
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 11:55:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMQnR-00085g-O0; Sun, 07 Jan 2024 05:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMQnK-00085J-TJ
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 05:54:19 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMQnJ-00029e-4w
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 05:54:18 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-552d39ac3ccso3339419a12.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704624854; x=1705229654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EXiTcwZN/McvxxD+6uZFVt0k7TEyWj0CQ4vszqFl0ew=;
 b=hs+32MJOeL3X++8LjKsS9ltoEqCdm0EkAphVcrK1UWcfwZR0cWJw6G2Nj3UIJ8gwmV
 4vMg46Avnthz7txgk0OrAtiuEThVymhRzLKSs2LK+1AMpj4tiIRntGXwjBr4gPTL1upF
 vRS2XM6OWeK6vygCuuZ9nP1jmpaqtvi0T2tNdepljoJk7s40IVBEI/JdF8h0WsdE3dBn
 aDJjvBxAQ4JfnP5uQ93TEEv+TMuePQiboDS0ZLpNh0iksSKrVpCtJpaEPl/xcL0rmQK7
 EouzMKzM3O4V3H74rD6lZvtRFJ2VN+dkVx8cGymXmLiFJGVFIo3Gme0hUwyfzGNtxSRD
 MImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704624854; x=1705229654;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EXiTcwZN/McvxxD+6uZFVt0k7TEyWj0CQ4vszqFl0ew=;
 b=N8KNSOwrmV9UxpFoWds2P6jPY5de+Pa8Z7Md5/XLl6W3j3l3KEHmZ5dGO+tzR4WGrr
 dF76yOEVMnyUgVZINP7HKsW4TONHTVS1fRxoQARfcoqY0OW/yFBnIKvBL/RNexyywkKl
 5YIKF81n9+yENVLg3CaT+Ub23aZeJ9Hjd59JMaYFeBVyeDHAZJlEFKDqSNZXx+uw+WU4
 wK1CE390EvAO8w8ZQXsRxr1RJ2UC/p7yBcyrprROnr9y5kBwXwG9oubvf4wQlO/0h++3
 2MLc73hIBbe3JFMCHeyPcwCXLaIwb43rAz6AVElm2JVE5eI9PFPmumgNW+Lj1/cSkICN
 EHBA==
X-Gm-Message-State: AOJu0YysOTa91pv80BNcbNoEnYEg6iau8xJ5j/fu/JSuS/YiQnj2dL8Y
 AoGaUnOjbJDWgTT3T1wyR6pR4mJFK3cDsA==
X-Google-Smtp-Source: AGHT+IHKj/EIMW6mVlTrp8b2tTf03tBbm26boXsBSbAJOR9gFFUUha6iM7v5/LdWKP93oZlI/JmP+A==
X-Received: by 2002:a17:906:452:b0:a28:f8d2:7399 with SMTP id
 e18-20020a170906045200b00a28f8d27399mr2187440eja.11.1704624854649; 
 Sun, 07 Jan 2024 02:54:14 -0800 (PST)
Received: from [192.168.69.100] (mab78-h01-176-184-55-22.dsl.sta.abo.bbox.fr.
 [176.184.55.22]) by smtp.gmail.com with ESMTPSA id
 fp14-20020a1709069e0e00b00a29430458efsm2725089ejc.65.2024.01.07.02.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jan 2024 02:54:14 -0800 (PST)
Message-ID: <4ca9e87d-1123-408c-ad49-71c01e332828@linaro.org>
Date: Sun, 7 Jan 2024 11:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/tci: Fix TCI on hppa host and update TCI test matrix
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <ZZpQZ77s2t81mXIT@p100>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZZpQZ77s2t81mXIT@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Cc'ing Akihiko for commit a1eaa6281f.

On 7/1/24 08:19, Helge Deller wrote:
> Update the TCI interpreter test matrix for big-endian hosts with
> big- (hppa, hppa64) and little-endian (x86,x96-64) targets.
> I used native ppc64 and hppa hosts for those tests.
> 
> Starting TCI on a hppa host crashed immediately, because hppa is
> the only archive left where the stack grows upwards.
> Write-protecting the stack guard page at the top of the stack
> fixes the crash.
> 

Fixes: a1eaa6281f ("util: Delete checks for old host definitions")

> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/tcg/tci/README b/tcg/tci/README
> index 4a8b5b5401..0c1e50779e 100644
> --- a/tcg/tci/README
> +++ b/tcg/tci/README
> @@ -72,16 +72,16 @@ host and target with same or different endianness.
>               | host (le)                     host (be)
>               | 32             64             32             64
>   ------------+------------------------------------------------------------
> -target (le) | s0, u0         s1, u1         s?, u?         s?, u?
> +target (le) | s0, u0         s1, u1         s2, u?         s2, u?
>   32 bit      |
>               |
> -target (le) | sc, uc         s1, u1         s?, u?         s?, u?
> +target (le) | sc, uc         s1, u1         s2, u?         s2, u?
>   64 bit      |
>               |
> -target (be) | sc, u0         sc, uc         s?, u?         s?, u?
> +target (be) | sc, u0         sc, uc         s2, u?         s2, u?
>   32 bit      |
>               |
> -target (be) | sc, uc         sc, uc         s?, u?         s?, u?
> +target (be) | sc, uc         sc, uc         s?, u?         s2, u?
>   64 bit      |
>               |
>   
> @@ -110,6 +115,10 @@ u1 = linux-user-test works
>     A cross compiled QEMU for ppc host works at least partially:
>     i386-linux-user/qemu-i386 can run a simple hello-world program
>     (tested in a ppc emulation).
> +  The big-endian tests were run on native hppa (big-endian, 32-bit) and
> +  ppc64 (big-endian, 64-bit) machines. Tested target machines were
> +  x86 and x86-64 (little-endian, debian install ISO) and 32- and 64-bit
> +  big-endian hppa (NetBSD and Debian install ISOs).
>   
>   * Some TCG opcodes are either missing in the code generator and/or
>     in the interpreter. These opcodes raise a runtime exception, so it is
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index e86fd64e09..e378b71641 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -585,11 +585,8 @@ char *qemu_get_pid_name(pid_t pid)
>   
>   void *qemu_alloc_stack(size_t *sz)
>   {
> -    void *ptr;
> +    void *ptr, *ptr2;
>       int flags;
> -#ifdef CONFIG_DEBUG_STACK_USAGE
> -    void *ptr2;
> -#endif
>       size_t pagesz = qemu_real_host_page_size();
>   #ifdef _SC_THREAD_STACK_MIN
>       /* avoid stacks smaller than _SC_THREAD_STACK_MIN */
> @@ -619,7 +616,12 @@ void *qemu_alloc_stack(size_t *sz)
>       }
>   
>       /* Stack grows down -- guard page at the bottom. */
> -    if (mprotect(ptr, pagesz, PROT_NONE) != 0) {
> +    ptr2 = ptr;
> +#if defined(__hppa__)

Is it worth make this generic by declaring some TARGET_STACK_GROWS_UP
definition in target/foo/cpu-param.h?

> +    /* but on hppa the stack grows up, so guard the top page instead */
> +    ptr2 = ptr + *sz - pagesz;
> +#endif
> +    if (mprotect(ptr2, pagesz, PROT_NONE) != 0) {
>           perror("failed to set up stack guard page");
>           abort();
>       }
> 


