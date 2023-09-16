Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1C7A3194
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 19:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhYqU-0006xo-VN; Sat, 16 Sep 2023 13:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhYqM-0006wv-Bi
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 13:12:30 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhYqI-0000Q0-QT
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 13:12:28 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68fb2e9ebcdso2548455b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694884345; x=1695489145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ow/QitEtIQLxnULpZl9GePjubstidjCAUIIrE9tA77A=;
 b=lNBRREWYhMmnwD9xKFgYE/Z2/17Ej5zpvtuhCF/pTywxN4IOjzljBNclK8ju2raZ4j
 anm3QoTdSl//VNkcOlcMwt4l5jbyXGbu1TJAOhdvya55p/tKBLpQWuR2kUM1bsRfIhmC
 r2kWAKQqcifnmtzkuQtVIPiYbb43HEbB144yxF6xXGFGjDqeBKfNEUDWGA5hrfZ20U+r
 Ii9yMrkxVVtJPENJwG6DLyvSGd77nhea53P+9s638l8nJK7rjMqdwBQ5/CNhC1J9rmZo
 EjTYLmGzwqpvRUON7EMLm6sf/GhJ//Joe91v/bZrOnODZEeEHctBL/G8Wi6xe7Q64pIu
 i7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694884345; x=1695489145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ow/QitEtIQLxnULpZl9GePjubstidjCAUIIrE9tA77A=;
 b=Dez/xhaDd98mhN0nsb5piHTTf5nd55Y4iTkZTD6S8GwYu1GE02ulhJXEXwUs5sQDCN
 dSZFloO6ACwfJ9Dpee38uKoqkzfAcYeGpfJmO1YBFpbh5rwaPNTh89gj6ZLCQjFCyv29
 ZsB54C24wBDPOqfDZyQeWBJMg+FskAjugNXuKRcv24npxX0axE6eGetPBOCvBBaO1Eua
 i6adUGGuAnMZH3t7/PZYJbxzxVSEuXJ82Z1wZpVZMpu7GgcT9lpzUy9gSLU5kuQ2kinm
 cqTC+b4MF2+oorUEhB8G2T4U7M99IuA9DjD4fVgXaF+b43BHt9YTGXXjkcEG6NuIY1Vd
 yKXg==
X-Gm-Message-State: AOJu0YzUiGChRFOUkdAsk1jDL/GaD3dyf+zXyjp5buod3SzOflyeP6vH
 i3GV3aKcZ35p/SQvahUbLxZCXIjObBg6Tj0PGvA=
X-Google-Smtp-Source: AGHT+IGAN0iauX/QFhBmfuT4e+pyIqm//K09PmQ39C4N1Zuq/QcSUGj1Gvb5dQh3QyK8KAqKZA9jOA==
X-Received: by 2002:a05:6a00:1a13:b0:690:3f29:a874 with SMTP id
 g19-20020a056a001a1300b006903f29a874mr4081203pfv.23.1694884344595; 
 Sat, 16 Sep 2023 10:12:24 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 i14-20020aa78d8e000000b00689f8dc26c2sm4706705pfr.133.2023.09.16.10.12.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 10:12:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/39] tcg patch queue
Date: Sat, 16 Sep 2023 10:12:22 -0700
Message-Id: <20230916171223.521545-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

v2: tcg/loongarch64 patch set without last minute tweaks.

r~

The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:

  Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qemu-tpm into staging (2023-09-13 13:41:57 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230915-2

for you to fetch changes up to a97a83753c90d79ed15a716610af23fabd84aaed:

  tcg: Map code_gen_buffer with PROT_BTI (2023-09-16 14:57:16 +0000)

----------------------------------------------------------------
*: Delete checks for old host definitions
tcg/loongarch64: Generate LSX instructions
fpu: Add conversions between bfloat16 and [u]int8
fpu: Handle m68k extended precision denormals properly
accel/tcg: Improve cputlb i/o organization
accel/tcg: Simplify tlb_plugin_lookup
accel/tcg: Remove false-negative halted assertion
tcg: Add gvec compare with immediate and scalar operand
tcg/aarch64: Emit BTI insns at jump landing pads

----------------------------------------------------------------
Akihiko Odaki (3):
      util: Delete checks for old host definitions
      softmmu: Delete checks for old host definitions
      thunk: Delete checks for old host definitions

Jiajie Chen (16):
      tcg/loongarch64: Import LSX instructions
      tcg/loongarch64: Lower basic tcg vec ops to LSX
      tcg: pass vece to tcg_target_const_match()
      tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
      tcg/loongarch64: Lower add/sub_vec to vadd/vsub
      tcg/loongarch64: Lower vector bitwise operations
      tcg/loongarch64: Lower neg_vec to vneg
      tcg/loongarch64: Lower mul_vec to vmul
      tcg/loongarch64: Lower vector min max ops
      tcg/loongarch64: Lower vector saturated ops
      tcg/loongarch64: Lower vector shift vector ops
      tcg/loongarch64: Lower bitsel_vec to vbitsel
      tcg/loongarch64: Lower vector shift integer ops
      tcg/loongarch64: Lower rotv_vec ops to LSX
      tcg/loongarch64: Lower rotli_vec to vrotri
      tcg/loongarch64: Implement 128-bit load & store

LIU Zhiwei (2):
      accel/tcg: Fix the comment for CPUTLBEntryFull
      fpu: Add conversions between bfloat16 and [u]int8

Nicholas Piggin (1):
      accel/tcg: mttcg remove false-negative halted assertion

Richard Henderson (17):
      tcg: Add gvec compare with immediate and scalar operand
      target/arm: Use tcg_gen_gvec_cmpi for compare vs 0
      accel/tcg: Simplify tlb_plugin_lookup
      accel/tcg: Split out io_prepare and io_failed
      accel/tcg: Use CPUTLBEntryFull.phys_addr in io_failed
      plugin: Simplify struct qemu_plugin_hwaddr
      accel/tcg: Merge cpu_transaction_failed into io_failed
      accel/tcg: Replace direct use of io_readx/io_writex in do_{ld,st}_1
      accel/tcg: Merge io_readx into do_ld_mmio_beN
      accel/tcg: Merge io_writex into do_st_mmio_leN
      accel/tcg: Introduce do_ld16_mmio_beN
      accel/tcg: Introduce do_st16_mmio_leN
      fpu: Handle m68k extended precision denormals properly
      tcg: Add tcg_out_tb_start backend hook
      util/cpuinfo-aarch64: Add CPUINFO_BTI
      tcg/aarch64: Emit BTI insns at jump landing pads
      tcg: Map code_gen_buffer with PROT_BTI

 accel/tcg/tcg-runtime.h              |   25 +
 host/include/aarch64/host/cpuinfo.h  |    1 +
 include/exec/cpu-defs.h              |   12 +-
 include/exec/user/thunk.h            |    3 +-
 include/fpu/softfloat.h              |   12 +
 include/hw/core/cpu.h                |   13 -
 include/qemu/plugin-memory.h         |   11 +-
 include/qemu/typedefs.h              |    1 -
 include/tcg/tcg-op-gvec-common.h     |    6 +
 tcg/loongarch64/tcg-target-con-set.h |    9 +
 tcg/loongarch64/tcg-target-con-str.h |    3 +
 tcg/loongarch64/tcg-target.h         |   40 +-
 tcg/loongarch64/tcg-target.opc.h     |   12 +
 accel/tcg/cputlb.c                   |  437 ++-
 accel/tcg/tcg-accel-ops-mttcg.c      |    9 +-
 accel/tcg/tcg-runtime-gvec.c         |   26 +
 fpu/softfloat.c                      |   67 +-
 plugins/api.c                        |   27 +-
 softmmu/async-teardown.c             |    3 -
 target/arm/tcg/translate.c           |   56 +-
 tcg/region.c                         |   41 +-
 tcg/tcg-op-gvec.c                    |  149 +
 tcg/tcg.c                            |    7 +-
 tests/tcg/m68k/denormal.c            |   53 +
 util/cpuinfo-aarch64.c               |    7 +
 util/oslib-posix.c                   |   15 +-
 fpu/softfloat-parts.c.inc            |    7 +-
 tcg/aarch64/tcg-target.c.inc         |   59 +-
 tcg/arm/tcg-target.c.inc             |    7 +-
 tcg/i386/tcg-target.c.inc            |    7 +-
 tcg/loongarch64/tcg-insn-defs.c.inc  | 6019 +++++++++++++++++++++++++++++++++-
 tcg/loongarch64/tcg-target.c.inc     |  624 +++-
 tcg/mips/tcg-target.c.inc            |    7 +-
 tcg/ppc/tcg-target.c.inc             |    7 +-
 tcg/riscv/tcg-target.c.inc           |    7 +-
 tcg/s390x/tcg-target.c.inc           |    7 +-
 tcg/sparc64/tcg-target.c.inc         |    7 +-
 tcg/tci/tcg-target.c.inc             |    7 +-
 tests/tcg/m68k/Makefile.target       |    2 +-
 39 files changed, 7419 insertions(+), 393 deletions(-)
 create mode 100644 tcg/loongarch64/tcg-target.opc.h
 create mode 100644 tests/tcg/m68k/denormal.c

