Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 871F573E39D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:41:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKE-0000Id-J1; Mon, 26 Jun 2023 11:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJk-0000GM-SS
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJg-0002nW-Mv
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-311099fac92so4749094f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793986; x=1690385986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HtJrW0MtsTbH+dH2loK0fhAgDE6xLP/itfYmyy304Mk=;
 b=OdEA96k1Sh/9AJORyUCgqVPdvLSuMxx3x/MXYeMwycpcRAsuZpdY+mnrIabRreAoew
 /fS4M1WuXBnqjwcswExl2WvEGEi20FSiLTPQn+fm32bR7bTEdhwOcpjHHsDFVM8bfPF8
 V8VxrS3S9YpLmtJdpqF949G/R7i1BB+yxlgD4xhv4YnyRJQwlvKZQo5XJaHOhPbaXyXl
 TTz/Tg8b36buEEy1VJrSu0j9XzGXdulpFBdbnmCq3DuUlKGAmAGrZMOEn1Yzdiz+rrvb
 Ma5W06fUEDFtvf7CIRYkGrJCqmk0YtaakiTxySYZ5ZkoVUwabBRW36blnk7Qr5LMuFGC
 STAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793986; x=1690385986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HtJrW0MtsTbH+dH2loK0fhAgDE6xLP/itfYmyy304Mk=;
 b=FbIupxLYFoyjVTzx4qR++QKmlV6ELrnd+XL4mYo6574yBskV73KlgZJPuo2XmLvr9o
 rE/m8kYo4r6h+yYRMJh2Lry/s7pIXxlgQ7l2oq8ZH6da10ua6S4paSRpE5DVQ3IFm4P6
 1ApP+0QCX1JbOLxOR4sRYYZzqH595V3wIv2lAQgzkyciXwxzHsdvAjJv3F/vBY4zN68u
 GfIRSSQpaxVTcnH2nVR2N4yZ3G7812+iSonO9nY94LX5piEZbr669XJZlJ7QMUgsGD1i
 HSGGxbPRMR7NDDXNpFktIVhaQ7hAOtj0ACNgqxSD/YRxEV3GM5PUIndjl4gHERzNdukv
 I2Fw==
X-Gm-Message-State: AC+VfDxfAs07OVzTq/dxm32DrDMWnIVgWqFRY3k/VluN2WIi22Q3Uzhi
 DRxrR+mYRt/5/4FgZ4p/38Ql52Zqq9kSqQ9ijze2Kyxe
X-Google-Smtp-Source: ACHHUZ4z/qeh0s0m2bslULG9fbAPA0vGhYKOAvOqL0HH1fny0iaoHxgkcJiip6ibhVenZ07C8e/K8g==
X-Received: by 2002:adf:f643:0:b0:313:ee73:cc9a with SMTP id
 x3-20020adff643000000b00313ee73cc9amr3640901wrp.70.1687793986552; 
 Mon, 26 Jun 2023 08:39:46 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/22] tcg patch queue
Date: Mon, 26 Jun 2023 17:39:23 +0200
Message-Id: <20230626153945.76180-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

The following changes since commit 390e8fc6b0e7b521c9eceb8dfe0958e141009ab9:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-06-26 16:05:45 +0200)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230626

for you to fetch changes up to a0eaae08c7c6a59c185cf646b02f4167b2ac6ec0:

  accel/tcg: Renumber TLB_DISCARD_WRITE (2023-06-26 17:33:00 +0200)

----------------------------------------------------------------
accel/tcg: Replace target_ulong in some APIs
accel/tcg: Remove CONFIG_PROFILER
accel/tcg: Store some tlb flags in CPUTLBEntryFull
tcg: Issue memory barriers as required for the guest memory model
tcg: Fix temporary variable in tcg_gen_gvec_andcs

----------------------------------------------------------------
Alex Bennée (1):
      softfloat: use QEMU_FLATTEN to avoid mistaken isra inlining

Anton Johansson (11):
      accel: Replace target_ulong in tlb_*()
      accel/tcg/translate-all.c: Widen pc and cs_base
      target: Widen pc/cs_base in cpu_get_tb_cpu_state
      accel/tcg/cputlb.c: Widen CPUTLBEntry access functions
      accel/tcg/cputlb.c: Widen addr in MMULookupPageData
      accel/tcg/cpu-exec.c: Widen pc to vaddr
      accel/tcg: Widen pc to vaddr in CPUJumpCache
      accel: Replace target_ulong with vaddr in probe_*()
      accel/tcg: Replace target_ulong with vaddr in *_mmu_lookup()
      accel/tcg: Replace target_ulong with vaddr in translator_*()
      cpu: Replace target_ulong with hwaddr in tb_invalidate_phys_addr()

Fei Wu (1):
      accel/tcg: remove CONFIG_PROFILER

Max Chou (1):
      tcg: Fix temporary variable in tcg_gen_gvec_andcs

Richard Henderson (8):
      tests/plugin: Remove duplicate insn log from libinsn.so
      target/microblaze: Define TCG_GUEST_DEFAULT_MO
      tcg: Do not elide memory barriers for !CF_PARALLEL in system mode
      tcg: Add host memory barriers to cpu_ldst.h interfaces
      accel/tcg: Remove check_tcg_memory_orders_compatible
      accel/tcg: Store some tlb flags in CPUTLBEntryFull
      accel/tcg: Move TLB_WATCHPOINT to TLB_SLOW_FLAGS_MASK
      accel/tcg: Renumber TLB_DISCARD_WRITE

 meson.build                              |   2 -
 qapi/machine.json                        |  18 --
 accel/tcg/internal.h                     |  40 +++-
 accel/tcg/tb-hash.h                      |  12 +-
 accel/tcg/tb-jmp-cache.h                 |   2 +-
 include/exec/cpu-all.h                   |  27 ++-
 include/exec/cpu-defs.h                  |  10 +-
 include/exec/cpu_ldst.h                  |  10 +-
 include/exec/exec-all.h                  |  95 +++++----
 include/exec/translator.h                |   6 +-
 include/hw/core/cpu.h                    |   1 +
 include/qemu/plugin-memory.h             |   2 +-
 include/qemu/timer.h                     |   9 -
 include/tcg/tcg.h                        |  26 ---
 target/alpha/cpu.h                       |   4 +-
 target/arm/cpu.h                         |   4 +-
 target/avr/cpu.h                         |   4 +-
 target/cris/cpu.h                        |   4 +-
 target/hexagon/cpu.h                     |   4 +-
 target/hppa/cpu.h                        |   5 +-
 target/i386/cpu.h                        |   4 +-
 target/loongarch/cpu.h                   |   6 +-
 target/m68k/cpu.h                        |   4 +-
 target/microblaze/cpu.h                  |   7 +-
 target/mips/cpu.h                        |   4 +-
 target/nios2/cpu.h                       |   4 +-
 target/openrisc/cpu.h                    |   5 +-
 target/ppc/cpu.h                         |   8 +-
 target/riscv/cpu.h                       |   4 +-
 target/rx/cpu.h                          |   4 +-
 target/s390x/cpu.h                       |   4 +-
 target/sh4/cpu.h                         |   4 +-
 target/sparc/cpu.h                       |   4 +-
 target/tricore/cpu.h                     |   4 +-
 target/xtensa/cpu.h                      |   4 +-
 accel/stubs/tcg-stub.c                   |   6 +-
 accel/tcg/cpu-exec.c                     |  43 ++--
 accel/tcg/cputlb.c                       | 351 +++++++++++++++++--------------
 accel/tcg/monitor.c                      |  31 ---
 accel/tcg/tb-maint.c                     |   2 +-
 accel/tcg/tcg-accel-ops.c                |  10 -
 accel/tcg/tcg-all.c                      |  39 +---
 accel/tcg/translate-all.c                |  46 +---
 accel/tcg/translator.c                   |  10 +-
 accel/tcg/user-exec.c                    |  24 ++-
 cpu.c                                    |   2 +-
 fpu/softfloat.c                          |  22 +-
 softmmu/runstate.c                       |   9 -
 target/arm/helper.c                      |   4 +-
 target/ppc/helper_regs.c                 |   4 +-
 target/riscv/cpu_helper.c                |   4 +-
 tcg/tcg-op-gvec.c                        |   2 +-
 tcg/tcg-op-ldst.c                        |   2 +-
 tcg/tcg-op.c                             |  14 +-
 tcg/tcg.c                                | 214 -------------------
 tests/plugin/insn.c                      |   9 +-
 tests/qtest/qmp-cmd-test.c               |   3 -
 hmp-commands-info.hx                     |  15 --
 meson_options.txt                        |   2 -
 scripts/meson-buildoptions.sh            |   3 -
 tests/tcg/i386/Makefile.softmmu-target   |   9 -
 tests/tcg/i386/Makefile.target           |   6 -
 tests/tcg/x86_64/Makefile.softmmu-target |   9 -
 63 files changed, 469 insertions(+), 781 deletions(-)

