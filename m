Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11125786158
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:24:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOW-0008Ic-T0; Wed, 23 Aug 2023 16:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0008Hu-Lu
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:48 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuO1-0005TD-Q1
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bbff6b2679so40184435ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822208; x=1693427008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cl7hBEk6ddkWfoo0pLieO35zvYWL0WBllZUA4wh6zOg=;
 b=yrcyGrpfY4zlPlVFRL3bXAgwtjk6yB+zpsyoj72MG7hE9kn53RDhWN7fyUf6DdMqsw
 PKBTsj4XVr/3QXUGJmpoa/HduE3yfn6nogiBhf1YFbl2wgDVj+TcnpdRCTpOZLHHnZc5
 RfKta4fxER7jD6hbpn4hPSwiHIuTFWxMk+oA1i7Ojfw1YdFFUGBMrKOh0qFJ787KWnmF
 UTb+VVtj/1ilNPWlNjoTKgcR6Esl1I7z1Wmvjw38DEGag+syzvdo1vfNgc/+wMYDF2UK
 R8ipBg7i8zy6cHKstgV80t7uQ4EwaOPtb7Hyc8yKgXCIonfVSVkqbE5WKi9ZL4OvxLX4
 M1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822208; x=1693427008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cl7hBEk6ddkWfoo0pLieO35zvYWL0WBllZUA4wh6zOg=;
 b=YjMFjL5jPL5h0LNpp5i/s5KN4IqmyW11NCk/xuEbhTlK3+aS+ClLOc6gUSUmpH397j
 /FF0pzabE0V5npC9a8/kMNpMlAsMKHb6qshGQvw8p1Mci0xpQG31tis6TPRXOwMXjZjV
 ypgsj8lgnHod3BMnpK8ZlWQoSiR8f5pusyA7KuPqpTv8oQF67RahE3vg7buVKm6OZU0B
 gddmR3++X1DDrDyrdLXhXihZPaSd+TJk4/xiTGdY8AXt20kIXEwUPQAkTeojuqehd/hS
 xjocteb1crHavdVXkKobJeZEu1G8LO23SbevTYoebwjuBC/dRrFG1oBXi5T0izBUB/Sy
 DGfw==
X-Gm-Message-State: AOJu0Yx0KhUhS4b5/0oGHREKii1EyFJhhCtTa1ydySxSA3vBWyGoh3a6
 r7wXkdNumfY09ti3xyEz+2O7hvaDWApSpaqin2I=
X-Google-Smtp-Source: AGHT+IGvyF+AY4a9ZJw6LTfhNPp7AISyY5AoxGChDjvSXxIaVbs1a8HQ5LK2/kjbKtb5onrjpwUn9Q==
X-Received: by 2002:a17:902:ac8e:b0:1bb:79b4:d45e with SMTP id
 h14-20020a170902ac8e00b001bb79b4d45emr10031188plr.69.1692822208243; 
 Wed, 23 Aug 2023 13:23:28 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/48] tcg patch queue
Date: Wed, 23 Aug 2023 13:22:38 -0700
Message-Id: <20230823202326.1353645-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

The following changes since commit b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa:

  Open 8.2 development tree (2023-08-22 07:14:07 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230823

for you to fetch changes up to 05e09d2a830a74d651ca6106e2002ec4f7b6997a:

  tcg: spelling fixes (2023-08-23 13:20:47 -0700)

----------------------------------------------------------------
accel/*: Widen pc/saved_insn for *_sw_breakpoint
accel/tcg: Replace remaining target_ulong in system-mode accel
tcg: spelling fixes
tcg: Document bswap, hswap, wswap byte patterns
tcg: Introduce negsetcond opcodes
tcg: Fold deposit with zero to and
tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
tcg/i386: Drop BYTEH deposits for 64-bit
tcg/i386: Allow immediate as input to deposit
target/*: Use tcg_gen_negsetcond_*

----------------------------------------------------------------
Anton Johansson via (9):
      accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
      accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
      sysemu/kvm: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint
      sysemu/hvf: Use vaddr for hvf_arch_[insert|remove]_hw_breakpoint
      include/exec: Replace target_ulong with abi_ptr in cpu_[st|ld]*()
      include/exec: typedef abi_ptr to vaddr in softmmu
      include/exec: Widen tlb_hit/tlb_hit_page()
      accel/tcg: Widen address arg in tlb_compare_set()
      accel/tcg: Update run_on_cpu_data static assert

Mark Cave-Ayland (1):
      docs/devel/tcg-ops: fix missing newlines in "Host vector operations"

Michael Tokarev (1):
      tcg: spelling fixes

Philippe Mathieu-Daudé (9):
      docs/devel/tcg-ops: Bury mentions of trunc_shr_i64_i32()
      tcg/tcg-op: Document bswap16_i32() byte pattern
      tcg/tcg-op: Document bswap16_i64() byte pattern
      tcg/tcg-op: Document bswap32_i32() byte pattern
      tcg/tcg-op: Document bswap32_i64() byte pattern
      tcg/tcg-op: Document bswap64_i64() byte pattern
      tcg/tcg-op: Document hswap_i32/64() byte pattern
      tcg/tcg-op: Document wswap_i64() byte pattern
      target/cris: Fix a typo in gen_swapr()

Richard Henderson (28):
      target/m68k: Use tcg_gen_deposit_i32 in gen_partset_reg
      tcg/i386: Drop BYTEH deposits for 64-bit
      tcg: Fold deposit with zero to and
      tcg/i386: Allow immediate as input to deposit_*
      tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
      tcg: Introduce negsetcond opcodes
      tcg: Use tcg_gen_negsetcond_*
      target/alpha: Use tcg_gen_movcond_i64 in gen_fold_mzero
      target/arm: Use tcg_gen_negsetcond_*
      target/m68k: Use tcg_gen_negsetcond_*
      target/openrisc: Use tcg_gen_negsetcond_*
      target/ppc: Use tcg_gen_negsetcond_*
      target/sparc: Use tcg_gen_movcond_i64 in gen_edge
      target/tricore: Replace gen_cond_w with tcg_gen_negsetcond_tl
      tcg/ppc: Implement negsetcond_*
      tcg/ppc: Use the Set Boolean Extension
      tcg/aarch64: Implement negsetcond_*
      tcg/arm: Implement negsetcond_i32
      tcg/riscv: Implement negsetcond_*
      tcg/s390x: Implement negsetcond_*
      tcg/sparc64: Implement negsetcond_*
      tcg/i386: Merge tcg_out_brcond{32,64}
      tcg/i386: Merge tcg_out_setcond{32,64}
      tcg/i386: Merge tcg_out_movcond{32,64}
      tcg/i386: Use CMP+SBB in tcg_out_setcond
      tcg/i386: Clear dest first in tcg_out_setcond if possible
      tcg/i386: Use shift in tcg_out_setcond
      tcg/i386: Implement negsetcond_*

 docs/devel/tcg-ops.rst                     |  15 +-
 accel/tcg/atomic_template.h                |  16 +-
 include/exec/cpu-all.h                     |   4 +-
 include/exec/cpu_ldst.h                    |  28 +--
 include/sysemu/hvf.h                       |  12 +-
 include/sysemu/kvm.h                       |  12 +-
 include/tcg/tcg-op-common.h                |   4 +
 include/tcg/tcg-op.h                       |   2 +
 include/tcg/tcg-opc.h                      |   6 +-
 include/tcg/tcg.h                          |   4 +-
 tcg/aarch64/tcg-target.h                   |   5 +-
 tcg/arm/tcg-target.h                       |   1 +
 tcg/i386/tcg-target-con-set.h              |   2 +-
 tcg/i386/tcg-target-con-str.h              |   1 -
 tcg/i386/tcg-target.h                      |   9 +-
 tcg/loongarch64/tcg-target.h               |   6 +-
 tcg/mips/tcg-target.h                      |   5 +-
 tcg/ppc/tcg-target.h                       |   5 +-
 tcg/riscv/tcg-target.h                     |   5 +-
 tcg/s390x/tcg-target.h                     |   5 +-
 tcg/sparc64/tcg-target.h                   |   5 +-
 tcg/tci/tcg-target.h                       |   5 +-
 accel/hvf/hvf-accel-ops.c                  |   4 +-
 accel/hvf/hvf-all.c                        |   2 +-
 accel/kvm/kvm-all.c                        |   3 +-
 accel/tcg/cputlb.c                         |  17 +-
 target/alpha/translate.c                   |   7 +-
 target/arm/hvf/hvf.c                       |   4 +-
 target/arm/kvm64.c                         |   6 +-
 target/arm/tcg/translate-a64.c             |  22 +--
 target/arm/tcg/translate.c                 |  12 +-
 target/cris/translate.c                    |  20 +-
 target/i386/hvf/hvf.c                      |   4 +-
 target/i386/kvm/kvm.c                      |   8 +-
 target/m68k/translate.c                    |  35 ++--
 target/openrisc/translate.c                |   6 +-
 target/ppc/kvm.c                           |  13 +-
 target/riscv/vector_helper.c               |   2 +-
 target/rx/op_helper.c                      |   6 +-
 target/s390x/kvm/kvm.c                     |   6 +-
 target/sparc/translate.c                   |  17 +-
 target/tricore/translate.c                 |  16 +-
 tcg/optimize.c                             |  78 +++++++-
 tcg/tcg-op-gvec.c                          |   6 +-
 tcg/tcg-op.c                               | 151 ++++++++++++---
 tcg/tcg.c                                  |   9 +-
 target/ppc/translate/fixedpoint-impl.c.inc |   6 +-
 target/ppc/translate/vmx-impl.c.inc        |   8 +-
 tcg/aarch64/tcg-target.c.inc               |  14 +-
 tcg/arm/tcg-target.c.inc                   |  19 +-
 tcg/i386/tcg-target.c.inc                  | 291 ++++++++++++++++++-----------
 tcg/ppc/tcg-target.c.inc                   | 149 ++++++++++-----
 tcg/riscv/tcg-target.c.inc                 |  49 ++++-
 tcg/s390x/tcg-target.c.inc                 |  78 +++++---
 tcg/sparc64/tcg-target.c.inc               |  40 +++-
 55 files changed, 832 insertions(+), 433 deletions(-)

