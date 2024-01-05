Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A14C08254B6
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 14:56:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkfJ-00046U-MH; Fri, 05 Jan 2024 08:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLkfI-00046K-5w
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:55:12 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLkfF-0002gY-Vx
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:55:11 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cd0c17e42bso18761561fa.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 05:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704462908; x=1705067708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MiIpUnnuHacmfwdVvHosOSRE3xuKEeEb7B96g/UFOlo=;
 b=qSAaZ1BzDR9M9ctXJYrrDG0zudoOEMee7YF0/fvv/E2cFZ/hor1fzMh35yUN5KJ7pG
 4abWQ8Yn8ARfulMzNlznY99nB6kJDTdle9Gyfnb1UqySySiELjpZHKGgwcohwxWLIj1f
 +UwaMmpGmu01yd465n5e4Cq0Gm1hd48igGPkpJ71BdB3NaWQQsfm3IybIU141MbNNwiy
 STG33jKwkC321B5OyDcqfuD4Y5wA/PENApuXTBWYWI03N88T8pQpbsN4LrNkD10TffGW
 vcX0M0zlzQRqMO2su7vs34WXC4qLzwmzrv1pPpbfnCGuYIFEa1gpBzJZ6jvdKNqt6P0Z
 g2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704462908; x=1705067708;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MiIpUnnuHacmfwdVvHosOSRE3xuKEeEb7B96g/UFOlo=;
 b=wZvXrrW5BCW34yyaYrLHMNYONkiRz2A3d0/9zAHaOYWtoq6nRtpo3PnPrA2kpIxYUy
 LETY1Tl5zfCv+z7QcKdDRKQOKPNoWn7v0xwDyyQKnlT3BUxAfUtc/qjRu0WZidrun1qS
 gyz5l1QBoEKWWsm7Hrdlsz5I8p+xnHyUNTUkLUZmYyM7cMIq0dB/mFGLcgmSgJlY/+KI
 bdcWYTQKPLqBizgxtsOyLku6g1alR3x0Dtv9HPH7mu8FReQUBTV4m4OwhwFZELTo6YH3
 ThfJngIhnboHDrMwzhN/mDeM1YVKtHFIN18rRZsZVi4rh1BrorlOIUsGcWKOVpLWWqW3
 9qnA==
X-Gm-Message-State: AOJu0YyMlYC5wXAh7YYJ083ZQ6dXWNMbmR7RxHoPwFFsBZBsblsDDYoV
 BcTI1zbOXdG0X0SnMRoxU8SRMRrfmFvGyw==
X-Google-Smtp-Source: AGHT+IFemHcdYOTlcAmAi8HN94qd4Puw/ZtcbOvLTM9xZnFfqahxxOM1TKU5iSJP9F7RncJ84KZdNw==
X-Received: by 2002:a05:651c:516:b0:2cc:9817:6389 with SMTP id
 o22-20020a05651c051600b002cc98176389mr1278924ljp.99.1704462908005; 
 Fri, 05 Jan 2024 05:55:08 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 d8-20020a50fb08000000b0055350d989dasm981352edq.88.2024.01.05.05.55.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 05:55:07 -0800 (PST)
Message-ID: <7616e931-3f92-4150-9264-0732e559dd4e@linaro.org>
Date: Fri, 5 Jan 2024 14:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/33] linux-user: Improve host and guest page size
 handling
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Cc'ing Pierrick

On 2/1/24 02:57, Richard Henderson wrote:
> Changes for v3:
>    * Rebase.
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
>   cpu-target.c                              |  13 -
>   hw/tpm/tpm_ppi.c                          |   3 +-
>   linux-user/elfload.c                      |  67 +-
>   linux-user/main.c                         |  33 +-
>   linux-user/mmap.c                         | 714 +++++++++++++---------
>   migration/ram.c                           |  22 +-
>   system/physmem.c                          |  17 +-
>   system/vl.c                               |   1 -
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


