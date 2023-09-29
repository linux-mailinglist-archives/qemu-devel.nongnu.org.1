Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FEF7B2A14
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 03:06:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm1wy-0007AW-59; Thu, 28 Sep 2023 21:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qm1wv-0007AO-4d
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 21:05:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qm1ws-0004L5-TX
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 21:05:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c735473d1aso13424635ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 18:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695949541; x=1696554341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VpXHZfEJFm7x8zdwxflKF6jhjhYGOS9jgj9H6igLeao=;
 b=YBQjWymaf3KlzSKYWmaZItNQROIbYM0eKW74uH68ihAhbTF/FcH2ssATP/CuaJFDp3
 l6GkJfQ7WRIIMCt1edy24OVi1CJ+6XgovW3PAi4QWgLpsyBCBTKI9puu36Hj7SLsD2nM
 IoW0D6qBzxg3IehRNzdYr8zzp8b8/XN0sgz1XEv8k1zWmLn1EBEBLxXTs9o7yZkUdjc9
 S9hVjCyBHxkjqVYd3YPgQpF3RN3hA0L5rhAhPgqtQiT/aPGhWaCBFDYbdUHnhJWw0Zma
 1oVV/vO+ivNUp2kigl81XFjhtzkAMDeVHEHZvEGAWnruvor2aCvezlY/YkowZH+UL/dZ
 h8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695949541; x=1696554341;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VpXHZfEJFm7x8zdwxflKF6jhjhYGOS9jgj9H6igLeao=;
 b=DTeN18vNhc2bJ54MasRklIlLy8nueYlgyLgqTr08GxCrv3EFnLFouxQ+ymojD+EScs
 WK457FTqC0z+3idxMLO6YF29+NNEqGT/ac/UdME+6SvnfyFMo6rgXzHuuVU70krhbLTa
 Br4hsfP7tldzcNUsovrvY90GPr1ZF4HyGm5TbaQJyGpV8UhxbeDqcnTvr4qbbFWUpo8i
 6Li7OrTbLsa7jpCITIKZFgsL/Frt46UEB0/rT0rrr2b9udPBuZp1Wc2/4LHfHve6Xoh0
 A28Mb9KzQ9FRRx23IboFU242WvuNSKc1zAJTvm8ZLM8BJY25C/EoPo6aPm02SqP2ZpUZ
 QdhQ==
X-Gm-Message-State: AOJu0YzeChgLXG4VN6WeU6GZ3hCKGJdkHu6MwJtlWKgu6lIUaUBlh9c5
 QjHt46Gq/6EHKNzr0jIgjP8zrn1t5/PmtnAnkZw=
X-Google-Smtp-Source: AGHT+IGHx/vdyAqRYfUVA0j+BRcb73rRJ4v9MNsCYpWzIC+bo2jWSQ5uSjTnDrS/08S7Wu70SGpwQA==
X-Received: by 2002:a17:903:24f:b0:1bd:bba1:be78 with SMTP id
 j15-20020a170903024f00b001bdbba1be78mr3299230plh.23.1695949540902; 
 Thu, 28 Sep 2023 18:05:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a17090341c800b001b7ffca7dbcsm15588326ple.148.2023.09.28.18.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 18:05:40 -0700 (PDT)
Message-ID: <b7c87304-a5af-ce35-7bb7-327b9ec619e4@linaro.org>
Date: Thu, 28 Sep 2023 18:05:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 00/33] linux-user: Improve host and guest page size
 handling
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, alex.bennee@linaro.org
References: <20230901022331.115247-1-richard.henderson@linaro.org>
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

r~

On 8/31/23 19:22, Richard Henderson wrote:
> Based-on: 20230829220228.928506-1-richard.henderson@linaro.org
> ("[PATCH v5 00/20] linux-user: Implement VDSOs")
> 
> Changes for v2:
>    * Minor adjustments to bsd-user.
>    * Update docs for deprecation.
>    * Philippe's r-b.
> 
> Blurb from v1:
> 
> While working on mmap issues for 8.1, I noticed a lot of corner
> cases of host != guest page size that we implement poorly.
> This seems to be particularly visible on Apple M1 with 16k pages,
> more so than Power with 64k pages for some reason.
> 
> Objective 1 is to deprecate and (essentially) disable the -p option.
> 
> The effect of -p is apparently confusing, so much so that our own
> testsuite misuses it.  One cannot really change the host page size,
> and pretending otherwise means that we don't treat the host memory
> system correctly, and stuff breaks.
> 
> I have not yet done the same work for bsd-user.
> 
> Objective 2 is to allow the guest page size to change to match the host.
> 
> There are corner cases of host != guest page size will fail in odd ways.
> For case of host > guest page size, the issues could be solved with
> softmmu, allowing a non-linear mapping between host and guest addresses
> and also disconnecting host and guest page permissions.
> 
> However, host < guest page has issues with SIGBUS which I believe to be
> totally unfixable.  At minimum one would need to monitor changes to all
> files mapped in the address space, but I'm sure there is much more.
> 
> But as always the best behaviour is obtained when the host and guest
> page sizes match -- there are no corner cases to contend with.
> 
> There are a set of guests which can be configured to use multiple page
> sizes, and therefore software developed for those guests (usually) does
> not hard-code a particular page size.  For those, we can allow the
> page size to vary and let the guest match the host.
> 
> I have only changed aarch64, alpha and ppc guests so far, as those
> are both easy to test and, especially for the case of alpha's default
> 8k page size, prone to failure.
> 
> 
> r~
> 
> 
> Richard Henderson (33):
>    accel/tcg: Remove qemu_host_page_size from page_protect/page_unprotect
>    linux-user: Adjust SVr4 NULL page mapping
>    linux-user: Remove qemu_host_page_{size,mask} in probe_guest_base
>    linux-user: Remove qemu_host_page_size from create_elf_tables
>    linux-user/hppa: Simplify init_guest_commpage
>    linux-user/nios2: Remove qemu_host_page_size from init_guest_commpage
>    linux-user/arm: Remove qemu_host_page_size from init_guest_commpage
>    linux-user: Remove qemu_host_page_{size,mask} from mmap.c
>    linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
>    linux-user: Remove HOST_PAGE_ALIGN from mmap.c
>    migration: Remove qemu_host_page_size
>    hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
>    softmmu/physmem: Remove qemu_host_page_size
>    softmmu/physmem: Remove HOST_PAGE_ALIGN
>    linux-user: Remove qemu_host_page_size from main
>    linux-user: Split out target_mmap__locked
>    linux-user: Move some mmap checks outside the lock
>    linux-user: Fix sub-host-page mmap
>    linux-user: Split out mmap_end
>    linux-user: Do early mmap placement only for reserved_va
>    linux-user: Split out mmap_h_eq_g
>    linux-user: Split out mmap_h_lt_g
>    linux-user: Split out mmap_h_gt_g
>    tests/tcg: Remove run-test-mmap-*
>    tests/tcg: Extend file in linux-madvise.c
>    *-user: Deprecate and disable -p pagesize
>    cpu: Remove page_size_init
>    accel/tcg: Disconnect TargetPageDataNode from page size
>    linux-user: Allow TARGET_PAGE_BITS_VARY
>    target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
>    linux-user: Bound mmap_min_addr by host page size
>    target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
>    target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
> 
>   docs/about/deprecated.rst                 |   7 +
>   docs/user/main.rst                        |   3 -
>   bsd-user/qemu.h                           |   7 +
>   include/exec/cpu-common.h                 |   7 -
>   include/hw/core/cpu.h                     |   2 -
>   target/alpha/cpu-param.h                  |  16 +-
>   target/arm/cpu-param.h                    |   6 +-
>   target/ppc/cpu-param.h                    |   9 +-
>   accel/tcg/translate-all.c                 |   1 -
>   accel/tcg/user-exec.c                     |  31 +-
>   bsd-user/main.c                           |  21 +-
>   cpu.c                                     |  13 -
>   hw/tpm/tpm_ppi.c                          |   3 +-
>   linux-user/elfload.c                      |  67 +-
>   linux-user/main.c                         |  33 +-
>   linux-user/mmap.c                         | 714 +++++++++++++---------
>   migration/ram.c                           |  22 +-
>   softmmu/physmem.c                         |  17 +-
>   softmmu/vl.c                              |   1 -
>   target/arm/cpu.c                          |  51 +-
>   tests/tcg/multiarch/linux/linux-madvise.c |   2 +
>   tests/tcg/alpha/Makefile.target           |   3 -
>   tests/tcg/arm/Makefile.target             |   3 -
>   tests/tcg/hppa/Makefile.target            |   3 -
>   tests/tcg/i386/Makefile.target            |   3 -
>   tests/tcg/m68k/Makefile.target            |   3 -
>   tests/tcg/multiarch/Makefile.target       |   9 -
>   tests/tcg/ppc/Makefile.target             |  12 -
>   tests/tcg/sh4/Makefile.target             |   3 -
>   tests/tcg/sparc64/Makefile.target         |   6 -
>   30 files changed, 626 insertions(+), 452 deletions(-)
>   delete mode 100644 tests/tcg/ppc/Makefile.target
>   delete mode 100644 tests/tcg/sparc64/Makefile.target
> 


