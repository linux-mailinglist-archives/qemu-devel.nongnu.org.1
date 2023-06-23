Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B52F73B05B
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 07:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCZht-0001aV-87; Fri, 23 Jun 2023 01:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCZhZ-0001XM-In
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:51:28 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCZhX-0001hH-K3
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:51:21 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31121494630so333322f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 22:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687499478; x=1690091478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Da+fiiyiYm1jjFwClyYt1QkK9rQQnuNqjE+jZipwsUw=;
 b=JhZYZ8pCpgp2BHTNXXeShV62SWupl21fQoxzpQ2n4/n1t5RrArPvyj5uSGGmWGuw6h
 kGUJMvas1E+7Z2R9CLt9oH18SCLS9qj94aoq68/6B38wK/YU3lcOA/qDGGCj3rEcR6Oy
 4t4Mtr2ujbBXtfqAmuBPZKjXGVgKH60fS+yGxXqdJ3wG5xdyL8RrBUjrINCBXk4MlKpI
 AnozE61vz3XNgvqoBn4dzlnfowrVZpdR9VL4xIPjWS2r1ND4XPQOpRbIqY1CpIYVqVvY
 Zq3Tjuhp8Y+FzcrwSLB9ILcIiw0D6emI5U+6OheXnyPwknCvoSeqJsIvWzIYqg7LnkRo
 WYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687499478; x=1690091478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Da+fiiyiYm1jjFwClyYt1QkK9rQQnuNqjE+jZipwsUw=;
 b=koVPTEaTKn9jvZw09GqbqPVXHaz3SvIAF6Del9Ik/kQPjAxdDmQk12l3KUSS6NR9nS
 UXgsPqSHqrF2giCzwWYIOJH2cRc2RXY2CiL+6idLcASKqdDBKmhn9bCiF+A5sAdgraBJ
 BSPvBdWefHRg1zXvsLFyDKsZWbbglppkYyaVFZOVSMMwMHp+OuP5nmvslMJGnahChLbv
 +qQRCsqaScTmnIbwq+W7n5PqfWHS63LWoapzOdNkMKKUvV3Wxe1KG+M+QYu8zcfZ9MUx
 1LV0LOYQYWP8P5U/K+KXP8CY9ydsxfJg98aJwqzqaBga06QB3Idd72rfEbqk1wS+29Q0
 AVyA==
X-Gm-Message-State: AC+VfDzVs1PY7JwLNkA24Z6SmZVu6nsQd6olcfaDuss6a1emrx4NMUZq
 upU7tDekxRrFZ0DHNkN6HbTctA==
X-Google-Smtp-Source: ACHHUZ70y6eEYvciPB6OHq9Abeqrf/Zar+zFOosjg3MkBjzG+7ABAg94fBD+KxUPLZjkOdFq52MSkQ==
X-Received: by 2002:adf:ef50:0:b0:30f:cc45:5af1 with SMTP id
 c16-20020adfef50000000b0030fcc455af1mr16865502wrp.45.1687499478179; 
 Thu, 22 Jun 2023 22:51:18 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.168.147])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a5d438d000000b0030e5c8d55f2sm8660758wrq.6.2023.06.22.22.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 22:51:17 -0700 (PDT)
Message-ID: <8eb6866b-1b2f-99b3-d42a-4e5808727a88@linaro.org>
Date: Fri, 23 Jun 2023 07:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 00/12] Start replacing target_ulong with vaddr
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, eduardo@habkost.net, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com
References: <20230621135633.1649-1-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230621135633.1649-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/21/23 15:56, Anton Johansson wrote:
> This is a first patchset in removing target_ulong from non-target/
> directories.  As use of target_ulong is spread accross the codebase we
> are attempting to target as few maintainers as possible with each
> patchset in order to ease reviewing.
> 
> The following instances of target_ulong remain in accel/ and tcg/
>      - atomic helpers (atomic_common.c.inc), cpu_atomic_*()
>        (atomic_template.h,) and cpu_[st|ld]*()
>        (cputlb.c/ldst_common.c.inc) are only used in target/ and can
>        be pulled out into a separate target-specific file;
> 
>      - walk_memory_regions() is used in user-exec.c and
>        linux-user/elfload.c;
> 
>      - kvm_find_sw_breakpoint() in kvm-all.c used in target/;
> 
> Changes in v2:
>      - addr argument in tb_invalidate_phys_addr() changed from vaddr
>        to hwaddr;
> 
>      - Removed previous patch:
> 
>          "[PATCH 4/8] accel/tcg: Replace target_ulong with vaddr in helper_unaligned_*()"
> 
>        as these functions are removed by Richard's patches;
> 
>      - First patch:
> 
>          "[PATCH 1/8] accel: Replace `target_ulong` with `vaddr` in TB/TLB"
> 
>        has been split into patches 1-7 to ease reviewing;
> 
>      - Pulled in target/ changes to cpu_get_tb_cpu_state() into this
>        patchset.  This was done to avoid pointer casts to target_ulong *
>        which would break for 32-bit targets on a 64-bit BE host;
> 
>        Note the small target/ changes are collected in a single
>        patch to not break bisection.  If it's still desirable to split
>        based on maintainer, let me know;
> 
>      - `last` argument of pageflags_[find|next] changed from target_long
>         to vaddr.  This change was left out of the last patchset due to
>         triggering a "Bad ram pointer" error (softmmu/physmem.c:2273)
>         when running make check for a i386-softmmu target.
> 
>         I was not able to recreate this on master or post rebase on
>         Richard's tcg-once branch.
> 
> Changes in v3:
>      - Rebased on master
> 
> Finally, the grand goal is to allow for heterogeneous QEMU binaries
> consisting of multiple frontends.
> 
> RFC: https://lists.nongnu.org/archive/html/qemu-devel/2022-12/msg04518.html
> 
> Anton Johansson (12):
>    accel: Replace target_ulong in tlb_*()
>    accel/tcg/translate-all.c: Widen pc and cs_base
>    target: Widen pc/cs_base in cpu_get_tb_cpu_state
>    accel/tcg/cputlb.c: Widen CPUTLBEntry access functions
>    accel/tcg/cputlb.c: Widen addr in MMULookupPageData
>    accel/tcg/cpu-exec.c: Widen pc to vaddr
>    accel/tcg: Widen pc to vaddr in CPUJumpCache
>    accel: Replace target_ulong with vaddr in probe_*()
>    accel/tcg: Replace target_ulong with vaddr in *_mmu_lookup()
>    accel/tcg: Replace target_ulong with vaddr in translator_*()
>    accel/tcg: Replace target_ulong with vaddr in page_*()
>    cpu: Replace target_ulong with hwaddr in tb_invalidate_phys_addr()
> 
>   accel/stubs/tcg-stub.c       |   6 +-
>   accel/tcg/cpu-exec.c         |  43 ++++---
>   accel/tcg/cputlb.c           | 233 +++++++++++++++++------------------
>   accel/tcg/internal.h         |   6 +-
>   accel/tcg/tb-hash.h          |  12 +-
>   accel/tcg/tb-jmp-cache.h     |   2 +-
>   accel/tcg/tb-maint.c         |   2 +-
>   accel/tcg/translate-all.c    |  13 +-
>   accel/tcg/translator.c       |  10 +-
>   accel/tcg/user-exec.c        |  58 +++++----
>   cpu.c                        |   2 +-
>   include/exec/cpu-all.h       |  10 +-
>   include/exec/cpu-defs.h      |   4 +-
>   include/exec/cpu_ldst.h      |  10 +-
>   include/exec/exec-all.h      |  95 +++++++-------
>   include/exec/translate-all.h |   2 +-
>   include/exec/translator.h    |   6 +-
>   include/qemu/plugin-memory.h |   2 +-
>   target/alpha/cpu.h           |   4 +-
>   target/arm/cpu.h             |   4 +-
>   target/arm/helper.c          |   4 +-
>   target/avr/cpu.h             |   4 +-
>   target/cris/cpu.h            |   4 +-
>   target/hexagon/cpu.h         |   4 +-
>   target/hppa/cpu.h            |   5 +-
>   target/i386/cpu.h            |   4 +-
>   target/loongarch/cpu.h       |   6 +-
>   target/m68k/cpu.h            |   4 +-
>   target/microblaze/cpu.h      |   4 +-
>   target/mips/cpu.h            |   4 +-
>   target/nios2/cpu.h           |   4 +-
>   target/openrisc/cpu.h        |   5 +-
>   target/ppc/cpu.h             |   8 +-
>   target/ppc/helper_regs.c     |   4 +-
>   target/riscv/cpu.h           |   4 +-
>   target/riscv/cpu_helper.c    |   4 +-
>   target/rx/cpu.h              |   4 +-
>   target/s390x/cpu.h           |   4 +-
>   target/sh4/cpu.h             |   4 +-
>   target/sparc/cpu.h           |   4 +-
>   target/tricore/cpu.h         |   4 +-
>   target/xtensa/cpu.h          |   4 +-
>   42 files changed, 307 insertions(+), 313 deletions(-)
> 
> --
> 2.41.0

Queued to tcg-next, thanks.


r~

