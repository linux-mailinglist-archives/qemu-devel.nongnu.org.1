Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6557787848
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZFTI-0006Of-3L; Thu, 24 Aug 2023 14:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZFTH-0006OX-3Z
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:54:19 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZFTE-0002YO-2S
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:54:18 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68bec436514so178552b3a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692903254; x=1693508054;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y5x1YFEKtefwqJzUXuvNFdzbHLrdLux2idUzQctDcn4=;
 b=qL9KlSjuCBhK4FpUHXBPSNB7xylK7Lw92LKI+lll/uTjY8Ji3H1Y5HRoilyQUKI2/i
 TzS/8m56y51PV1dmKm6Hg7qiKBfRiK86t3vINt4NiZYP/UVJqmRi6mZMW0oBNDbc7h9Q
 4AcZza4PSwCYxOLAROCHCvCuJHUTy2jlWxpQo/1BZbtL3ftZy6bC4ApN0q09eZTW/T/1
 Fk8h1DiKqwcagSr1b1ALOsaadYA8HLM1YejpwO3boEq1dkhwq5w6A6xMK5zogourLbxS
 reD54iZPZjX3tl1CybRmweBRs2udUHTZgLzzTmKXxmky7uyP4cMDU5A8EXkU3DZ76fla
 HkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692903254; x=1693508054;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y5x1YFEKtefwqJzUXuvNFdzbHLrdLux2idUzQctDcn4=;
 b=h+kri0/q3dnnFJJNWqhZMu7xwNu9ksH9gBM/iOvP/8KnjodASP3Wu2JRbMcsIRLuVp
 ZA58yPCwvf6v3sjTYyszg/2+anhR+oYUy46DLdG1cZvXbgtNt9kbR593IxE2fKHX9CaY
 otwMb2AMM6L1QZ2KAi6G4VqnCKkyYkO9E2iV308SPw8lfLkx19ECAjVvIpEXRX5ax6Lz
 Tgk0kTJByJIXNFVtvsgoZy0cgFasNw6qbqLoyRCZwJmgmeLKWL2YZKqGb/ss0aXaM9np
 XCIYeWoRzb2qDXPYiCMlCJTGztOYh8tmeS5LHULug/aS0RrZAKxB+7uG9z/vpS00exiD
 qb3g==
X-Gm-Message-State: AOJu0YweO9osH872B1Cmp6BSmJeZKPFYPJPttUGNnviBUjC8aT2xMejp
 iSq1loluIQnpU6h5k+Em7wDBEExZR7gPQLUIA/w=
X-Google-Smtp-Source: AGHT+IEQMkWMO1c49s0kmPcZtq9dXykTbEIcy1A2s4eRf4q5ejf5KHMW4+NRLyR2W8n3ue7ffpzoKA==
X-Received: by 2002:a05:6a00:194b:b0:68b:e7d4:2564 with SMTP id
 s11-20020a056a00194b00b0068be7d42564mr4424382pfk.24.1692903254315; 
 Thu, 24 Aug 2023 11:54:14 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:5418:3064:bd46:c048?
 ([2602:47:d483:7301:5418:3064:bd46:c048])
 by smtp.gmail.com with ESMTPSA id
 r25-20020a62e419000000b0068bc2432ee2sm74819pfh.51.2023.08.24.11.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 11:54:13 -0700 (PDT)
Message-ID: <9c5b31e1-7127-3d1c-52d4-36193ce44681@linaro.org>
Date: Thu, 24 Aug 2023 11:54:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PULL v2 00/48] tcg patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230824182854.1572951-1-richard.henderson@linaro.org>
In-Reply-To: <20230824182854.1572951-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Dangit, missed the PULL tag for v2.
The only change is fixing Anton's --author.

r~

On 8/24/23 11:28, Richard Henderson wrote:
> The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:
> 
>    Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230823-2
> 
> for you to fetch changes up to 4daad8d9d6b9d426beb8ce505d2164ba36ea3168:
> 
>    tcg: spelling fixes (2023-08-24 11:22:42 -0700)
> 
> ----------------------------------------------------------------
> accel/*: Widen pc/saved_insn for *_sw_breakpoint
> accel/tcg: Replace remaining target_ulong in system-mode accel
> tcg: spelling fixes
> tcg: Document bswap, hswap, wswap byte patterns
> tcg: Introduce negsetcond opcodes
> tcg: Fold deposit with zero to and
> tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
> tcg/i386: Drop BYTEH deposits for 64-bit
> tcg/i386: Allow immediate as input to deposit
> target/*: Use tcg_gen_negsetcond_*
> 
> ----------------------------------------------------------------
> Anton Johansson (9):
>        accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
>        accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
>        sysemu/kvm: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint
>        sysemu/hvf: Use vaddr for hvf_arch_[insert|remove]_hw_breakpoint
>        include/exec: Replace target_ulong with abi_ptr in cpu_[st|ld]*()
>        include/exec: typedef abi_ptr to vaddr in softmmu
>        include/exec: Widen tlb_hit/tlb_hit_page()
>        accel/tcg: Widen address arg in tlb_compare_set()
>        accel/tcg: Update run_on_cpu_data static assert
> 
> Mark Cave-Ayland (1):
>        docs/devel/tcg-ops: fix missing newlines in "Host vector operations"
> 
> Michael Tokarev (1):
>        tcg: spelling fixes
> 
> Philippe Mathieu-Daudé (9):
>        docs/devel/tcg-ops: Bury mentions of trunc_shr_i64_i32()
>        tcg/tcg-op: Document bswap16_i32() byte pattern
>        tcg/tcg-op: Document bswap16_i64() byte pattern
>        tcg/tcg-op: Document bswap32_i32() byte pattern
>        tcg/tcg-op: Document bswap32_i64() byte pattern
>        tcg/tcg-op: Document bswap64_i64() byte pattern
>        tcg/tcg-op: Document hswap_i32/64() byte pattern
>        tcg/tcg-op: Document wswap_i64() byte pattern
>        target/cris: Fix a typo in gen_swapr()
> 
> Richard Henderson (28):
>        target/m68k: Use tcg_gen_deposit_i32 in gen_partset_reg
>        tcg/i386: Drop BYTEH deposits for 64-bit
>        tcg: Fold deposit with zero to and
>        tcg/i386: Allow immediate as input to deposit_*
>        tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
>        tcg: Introduce negsetcond opcodes
>        tcg: Use tcg_gen_negsetcond_*
>        target/alpha: Use tcg_gen_movcond_i64 in gen_fold_mzero
>        target/arm: Use tcg_gen_negsetcond_*
>        target/m68k: Use tcg_gen_negsetcond_*
>        target/openrisc: Use tcg_gen_negsetcond_*
>        target/ppc: Use tcg_gen_negsetcond_*
>        target/sparc: Use tcg_gen_movcond_i64 in gen_edge
>        target/tricore: Replace gen_cond_w with tcg_gen_negsetcond_tl
>        tcg/ppc: Implement negsetcond_*
>        tcg/ppc: Use the Set Boolean Extension
>        tcg/aarch64: Implement negsetcond_*
>        tcg/arm: Implement negsetcond_i32
>        tcg/riscv: Implement negsetcond_*
>        tcg/s390x: Implement negsetcond_*
>        tcg/sparc64: Implement negsetcond_*
>        tcg/i386: Merge tcg_out_brcond{32,64}
>        tcg/i386: Merge tcg_out_setcond{32,64}
>        tcg/i386: Merge tcg_out_movcond{32,64}
>        tcg/i386: Use CMP+SBB in tcg_out_setcond
>        tcg/i386: Clear dest first in tcg_out_setcond if possible
>        tcg/i386: Use shift in tcg_out_setcond
>        tcg/i386: Implement negsetcond_*
> 
>   docs/devel/tcg-ops.rst                     |  15 +-
>   accel/tcg/atomic_template.h                |  16 +-
>   include/exec/cpu-all.h                     |   4 +-
>   include/exec/cpu_ldst.h                    |  28 +--
>   include/sysemu/hvf.h                       |  12 +-
>   include/sysemu/kvm.h                       |  12 +-
>   include/tcg/tcg-op-common.h                |   4 +
>   include/tcg/tcg-op.h                       |   2 +
>   include/tcg/tcg-opc.h                      |   6 +-
>   include/tcg/tcg.h                          |   4 +-
>   tcg/aarch64/tcg-target.h                   |   5 +-
>   tcg/arm/tcg-target.h                       |   1 +
>   tcg/i386/tcg-target-con-set.h              |   2 +-
>   tcg/i386/tcg-target-con-str.h              |   1 -
>   tcg/i386/tcg-target.h                      |   9 +-
>   tcg/loongarch64/tcg-target.h               |   6 +-
>   tcg/mips/tcg-target.h                      |   5 +-
>   tcg/ppc/tcg-target.h                       |   5 +-
>   tcg/riscv/tcg-target.h                     |   5 +-
>   tcg/s390x/tcg-target.h                     |   5 +-
>   tcg/sparc64/tcg-target.h                   |   5 +-
>   tcg/tci/tcg-target.h                       |   5 +-
>   accel/hvf/hvf-accel-ops.c                  |   4 +-
>   accel/hvf/hvf-all.c                        |   2 +-
>   accel/kvm/kvm-all.c                        |   3 +-
>   accel/tcg/cputlb.c                         |  17 +-
>   target/alpha/translate.c                   |   7 +-
>   target/arm/hvf/hvf.c                       |   4 +-
>   target/arm/kvm64.c                         |   6 +-
>   target/arm/tcg/translate-a64.c             |  22 +--
>   target/arm/tcg/translate.c                 |  12 +-
>   target/cris/translate.c                    |  20 +-
>   target/i386/hvf/hvf.c                      |   4 +-
>   target/i386/kvm/kvm.c                      |   8 +-
>   target/m68k/translate.c                    |  35 ++--
>   target/openrisc/translate.c                |   6 +-
>   target/ppc/kvm.c                           |  13 +-
>   target/riscv/vector_helper.c               |   2 +-
>   target/rx/op_helper.c                      |   6 +-
>   target/s390x/kvm/kvm.c                     |   6 +-
>   target/sparc/translate.c                   |  17 +-
>   target/tricore/translate.c                 |  16 +-
>   tcg/optimize.c                             |  78 +++++++-
>   tcg/tcg-op-gvec.c                          |   6 +-
>   tcg/tcg-op.c                               | 151 ++++++++++++---
>   tcg/tcg.c                                  |   9 +-
>   target/ppc/translate/fixedpoint-impl.c.inc |   6 +-
>   target/ppc/translate/vmx-impl.c.inc        |   8 +-
>   tcg/aarch64/tcg-target.c.inc               |  14 +-
>   tcg/arm/tcg-target.c.inc                   |  19 +-
>   tcg/i386/tcg-target.c.inc                  | 291 ++++++++++++++++++-----------
>   tcg/ppc/tcg-target.c.inc                   | 149 ++++++++++-----
>   tcg/riscv/tcg-target.c.inc                 |  49 ++++-
>   tcg/s390x/tcg-target.c.inc                 |  78 +++++---
>   tcg/sparc64/tcg-target.c.inc               |  40 +++-
>   55 files changed, 832 insertions(+), 433 deletions(-)


