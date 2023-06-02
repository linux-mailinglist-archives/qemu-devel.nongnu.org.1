Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA16720C23
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 00:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Diu-0002ot-05; Fri, 02 Jun 2023 18:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Dis-0002oj-I5
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:58:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Diq-000091-9K
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:58:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3094910b150so2690132f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685746694; x=1688338694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dN/C2Z/IypqiJDPUDKDk5iRGQANDZyURN+5+o6WKaGY=;
 b=ocEPQTqRkGzLJI8GKh9TMVrDFuZT9PRYvL/7WSXyZ9VbsIy6LdYBVJwPiGtLGvNv/m
 mO1NZBRP7VhJmDjRMHqlOLn5kV6Z3slnKSDxtpTPx9NMcDxU/eezLBJiNyQ6LikcSqpg
 xW/K8tmiA2UGhvPuAVxREzXlzNIrZPFbpDjxyUWTUVrTivNvbJmMlnzivXx3mgqAg7FA
 KqJ+qdOYulDaeVZC3hxPabR1DL2pgyyyZp1UPrytoN7C6fDeol5sJbwF0QcPQ31A1wcA
 dMjZ4YQ+fxeQbd53yZ57LLp03nHx5W1AhHqMcFLEt/SIMHTvPl68mnOSYUEh9NnpQuJT
 oVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685746694; x=1688338694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dN/C2Z/IypqiJDPUDKDk5iRGQANDZyURN+5+o6WKaGY=;
 b=MMWgf8m7EoaeRDjFOdBWjERDfZ2kGJNOwRRWIn1BgqaLeol7gq2Af3ZaFnyL8W3nJ7
 3Z/YjkAV9KtXPqUlnVaX5qZd1V7vK/yvODKjwosjxYTogePAxiub4641fE/tUupAV4PS
 UDZz4i2BZzSH7kMVPm7FsKHlDLwKLbagAWakk9umL9PLr2cpX5lTGgj6mdwlJOTPp0Co
 OWCZc6wuNZeKxtMJVQbqE89cLUQJ0/jpkA49bRUiYir/6WfgtN4C/gQOW+BFkGJpgjkN
 c41e1HEF6kVKLw5RTZLvfZPuM9ZLGnwLgCd+Rh5j9tf1ZNCvWvTpDB2qtecksK8QxmXe
 5ywQ==
X-Gm-Message-State: AC+VfDwa2RusqmeUIp8oxnDlc8bdqpNgtYVyS/Prx9naLIcI4MMttuLF
 2H8BUTz6/159kQlTCspFUVPaL+OEJ3wdEWoYpDo=
X-Google-Smtp-Source: ACHHUZ4yGvatha808jnnM2IlMkvODVWVtH2I6RqcYVaLBkJy45+DIUdbaNXWlC/Ak5TXa1EQmotbzQ==
X-Received: by 2002:adf:dfd1:0:b0:30a:f3ca:17ad with SMTP id
 q17-20020adfdfd1000000b0030af3ca17admr980144wrn.66.1685746694311; 
 Fri, 02 Jun 2023 15:58:14 -0700 (PDT)
Received: from localhost.localdomain ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm2797758wrq.89.2023.06.02.15.58.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Jun 2023 15:58:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/2] bulk: Replace !CONFIG_SOFTMMU and !CONFIG_USER_ONLY
Date: Sat,  3 Jun 2023 00:58:09 +0200
Message-Id: <20230602225811.60152-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Since CONFIG_SOFTMMU is poisoned, we are using its opposite
form via "!CONFIG_USER_ONLY" (because CONFIG_USER_ONLY is
not poisoned).
Since patch [2] unpoison CONFIG_SOFTMMU, we can remove the
kludge, resulting is a more logical code to review.

Personally I like the resulting code, but I can understand
others simply see code churn here, so I'm simply posting as
bulk patches. I don't have problem to split if nobody object
to this change.

Based-on: 20230531040330.8950-1-richard.henderson@linaro.org
          "tcg: Build once for system, once for user" (v3)
[1] https://lore.kernel.org/qemu-devel/20230531040330.8950-1-richard.henderson@linaro.org/
[2] https://lore.kernel.org/qemu-devel/20230531040330.8950-48-richard.henderson@linaro.org/

*** BLURB HERE ***

Philippe Mathieu-Daudé (2):
  bulk: Replace !CONFIG_SOFTMMU -> CONFIG_USER_ONLY
  bulk: Replace !CONFIG_USER_ONLY -> CONFIG_SOFTMMU

 scripts/coccinelle/round.cocci                |   6 +
 include/exec/address-spaces.h                 |   2 +-
 include/exec/confidential-guest-support.h     |   4 +-
 include/exec/cpu-all.h                        |   4 +-
 include/exec/cpu-common.h                     |   4 +-
 include/exec/cpu-defs.h                       |  14 +-
 include/exec/cputlb.h                         |   2 +-
 include/exec/exec-all.h                       |   6 +-
 include/exec/ioport.h                         |   2 +-
 include/exec/memory-internal.h                |   2 +-
 include/exec/memory.h                         |   2 +-
 include/exec/ram_addr.h                       |   2 +-
 include/exec/ramblock.h                       |   2 +-
 include/hw/core/cpu.h                         |  12 +-
 include/hw/core/tcg-cpu-ops.h                 |   8 +-
 include/hw/intc/armv7m_nvic.h                 |   4 +-
 include/hw/s390x/css.h                        |   2 +-
 include/qemu/accel.h                          |   6 +-
 include/semihosting/semihost.h                |   4 +-
 include/sysemu/cpus.h                         |   2 +-
 include/sysemu/xen.h                          |   4 +-
 target/alpha/cpu.h                            |   6 +-
 target/arm/common-semi-target.h               |   2 +-
 target/arm/cpu.h                              |  14 +-
 target/arm/internals.h                        |   6 +-
 target/arm/tcg/arm_ldst.h                     |   2 +-
 target/arm/tcg/translate.h                    |   2 +-
 target/cris/cpu.h                             |   2 +-
 target/hppa/cpu.h                             |   2 +-
 target/hppa/helper.h                          |   2 +-
 target/i386/cpu-internal.h                    |   4 +-
 target/i386/cpu.h                             |  12 +-
 target/i386/helper.h                          |  12 +-
 target/i386/sev.h                             |   2 +-
 target/i386/tcg/helper-tcg.h                  |   4 +-
 target/loongarch/cpu.h                        |   4 +-
 target/loongarch/helper.h                     |   2 +-
 target/loongarch/internals.h                  |   4 +-
 target/m68k/cpu.h                             |   6 +-
 target/microblaze/cpu.h                       |  12 +-
 target/microblaze/helper.h                    |   2 +-
 target/mips/cpu.h                             |   6 +-
 target/mips/helper.h                          |   8 +-
 target/mips/internal.h                        |   4 +-
 target/mips/tcg/tcg-internal.h                |   4 +-
 target/nios2/cpu.h                            |  10 +-
 target/nios2/helper.h                         |   2 +-
 target/openrisc/cpu.h                         |   8 +-
 target/ppc/cpu-qom.h                          |   4 +-
 target/ppc/cpu.h                              |  32 ++---
 target/ppc/helper.h                           |   8 +-
 target/ppc/internal.h                         |   6 +-
 target/ppc/kvm_ppc.h                          |   8 +-
 target/ppc/mmu-book3s-v3.h                    |   2 +-
 target/ppc/mmu-hash32.h                       |   2 +-
 target/ppc/mmu-hash64.h                       |   2 +-
 target/ppc/mmu-radix64.h                      |   2 +-
 target/ppc/power8-pmu.h                       |   2 +-
 target/ppc/spr_common.h                       |   2 +-
 target/riscv/cpu.h                            |  10 +-
 target/riscv/helper.h                         |   4 +-
 target/riscv/internals.h                      |   2 +-
 target/rx/cpu.h                               |   4 +-
 target/s390x/cpu.h                            |   8 +-
 target/s390x/helper.h                         |   2 +-
 target/s390x/s390x-internal.h                 |   8 +-
 target/sh4/cpu.h                              |   2 +-
 target/sparc/cpu.h                            |  10 +-
 target/sparc/helper.h                         |   2 +-
 target/xtensa/cpu.h                           |   6 +-
 target/xtensa/helper.h                        |   4 +-
 target/s390x/tcg/insn-data.h.inc              |   2 +-
 accel/accel-common.c                          |   8 +-
 accel/tcg/cpu-exec.c                          |  24 ++--
 accel/tcg/tcg-all.c                           |   4 +-
 accel/tcg/translate-all.c                     |   2 +-
 cpu.c                                         |   8 +-
 gdbstub/gdbstub.c                             |   8 +-
 plugins/api.c                                 |   4 +-
 plugins/loader.c                              |   4 +-
 semihosting/arm-compat-semi.c                 |  10 +-
 semihosting/guestfd.c                         |   2 +-
 semihosting/syscalls.c                        |   6 +-
 softmmu/memory.c                              |   2 +-
 target/alpha/cpu.c                            |  10 +-
 target/alpha/helper.c                         |   4 +-
 target/alpha/sys_helper.c                     |   4 +-
 target/alpha/translate.c                      |  22 ++--
 target/arm/cpu.c                              |  44 +++----
 target/arm/debug_helper.c                     |   4 +-
 target/arm/gdbstub.c                          |   6 +-
 target/arm/helper.c                           |  48 +++----
 target/arm/tcg/cpu32.c                        |  18 +--
 target/arm/tcg/helper-a64.c                   |   2 +-
 target/arm/tcg/m_helper.c                     |   6 +-
 target/arm/tcg/op_helper.c                    |   2 +-
 target/arm/tcg/sve_helper.c                   |   2 +-
 target/arm/tcg/tlb_helper.c                   |   4 +-
 target/arm/tcg/translate-a64.c                |   2 +-
 target/arm/tcg/translate.c                    |   6 +-
 target/cris/cpu.c                             |  18 +--
 target/cris/op_helper.c                       |   8 +-
 target/cris/translate.c                       |   2 +-
 target/hexagon/genptr.c                       |   2 +-
 target/hppa/cpu.c                             |  14 +-
 target/hppa/helper.c                          |   4 +-
 target/hppa/translate.c                       |  36 ++---
 target/i386/cpu-dump.c                        |   6 +-
 target/i386/cpu.c                             |  42 +++---
 target/i386/gdbstub.c                         |  14 +-
 target/i386/helper.c                          |  14 +-
 target/i386/tcg/bpt_helper.c                  |   2 +-
 target/i386/tcg/excp_helper.c                 |   2 +-
 target/i386/tcg/fpu_helper.c                  |   4 +-
 target/i386/tcg/seg_helper.c                  |   8 +-
 target/i386/tcg/tcg-cpu.c                     |   6 +-
 target/i386/tcg/translate.c                   |   4 +-
 target/loongarch/cpu.c                        |  14 +-
 target/loongarch/op_helper.c                  |   2 +-
 target/m68k/cpu.c                             |   6 +-
 target/m68k/helper.c                          |   4 +-
 target/m68k/op_helper.c                       |   4 +-
 target/microblaze/cpu.c                       |  12 +-
 target/microblaze/helper.c                    |   4 +-
 target/microblaze/op_helper.c                 |   2 +-
 target/microblaze/translate.c                 |  12 +-
 target/mips/cpu.c                             |  18 +--
 target/mips/gdbstub.c                         |   4 +-
 target/mips/tcg/ldst_helper.c                 |   4 +-
 target/mips/tcg/msa_helper.c                  |   2 +-
 target/mips/tcg/op_helper.c                   |   4 +-
 target/mips/tcg/translate.c                   |  26 ++--
 target/nios2/cpu.c                            |  18 +--
 target/nios2/op_helper.c                      |   4 +-
 target/nios2/translate.c                      |  10 +-
 target/openrisc/cpu.c                         |  14 +-
 target/openrisc/interrupt.c                   |   2 +-
 target/openrisc/sys_helper.c                  |  10 +-
 target/ppc/compat.c                           |   2 +-
 target/ppc/cpu.c                              |   2 +-
 target/ppc/cpu_init.c                         | 124 +++++++++---------
 target/ppc/excp_helper.c                      |  17 +--
 target/ppc/gdbstub.c                          |   8 +-
 target/ppc/helper_regs.c                      |  20 +--
 target/ppc/mem_helper.c                       |   2 +-
 target/ppc/misc_helper.c                      |   2 +-
 target/ppc/power8-pmu.c                       |   4 +-
 target/ppc/ppc-qmp-cmds.c                     |   2 +-
 target/ppc/timebase_helper.c                  |   4 +-
 target/ppc/translate.c                        |  62 ++++-----
 target/riscv/cpu.c                            |  66 +++++-----
 target/riscv/cpu_helper.c                     |  20 +--
 target/riscv/csr.c                            |  42 +++---
 target/riscv/gdbstub.c                        |   6 +-
 target/riscv/op_helper.c                      |   8 +-
 target/riscv/translate.c                      |  12 +-
 target/riscv/zce_helper.c                     |   2 +-
 target/rx/cpu.c                               |  10 +-
 target/rx/helper.c                            |   4 +-
 target/s390x/cpu-dump.c                       |   2 +-
 target/s390x/cpu.c                            |  26 ++--
 target/s390x/cpu_features.c                   |   4 +-
 target/s390x/cpu_models.c                     |   8 +-
 target/s390x/gdbstub.c                        |   4 +-
 target/s390x/interrupt.c                      |   6 +-
 target/s390x/tcg/cc_helper.c                  |   2 +-
 target/s390x/tcg/excp_helper.c                |  10 +-
 target/s390x/tcg/mem_helper.c                 |   8 +-
 target/s390x/tcg/misc_helper.c                |  12 +-
 target/s390x/tcg/translate.c                  |  48 +++----
 target/sh4/cpu.c                              |  12 +-
 target/sh4/helper.c                           |   6 +-
 target/sh4/op_helper.c                        |   2 +-
 target/sparc/cpu.c                            |  16 +--
 target/sparc/helper.c                         |   6 +-
 target/sparc/int32_helper.c                   |   4 +-
 target/sparc/int64_helper.c                   |   4 +-
 target/sparc/ldst_helper.c                    |  16 +--
 target/sparc/translate.c                      |  50 +++----
 target/sparc/win_helper.c                     |  10 +-
 target/xtensa/cpu.c                           |  22 ++--
 target/xtensa/exc_helper.c                    |   4 +-
 target/xtensa/helper.c                        |   4 +-
 target/xtensa/op_helper.c                     |   6 +-
 target/xtensa/translate.c                     |  62 ++++-----
 tcg/tcg.c                                     |   4 +-
 .../loongarch/insn_trans/trans_farith.c.inc   |   2 +-
 target/loongarch/insn_trans/trans_lsx.c.inc   |   2 +-
 target/mips/cpu-defs.c.inc                    |   2 +-
 target/mips/tcg/micromips_translate.c.inc     |   4 +-
 target/mips/tcg/nanomips_translate.c.inc      |   6 +-
 target/ppc/power8-pmu-regs.c.inc              |   4 +-
 target/ppc/translate/branch-impl.c.inc        |   2 +-
 .../ppc/translate/processor-ctrl-impl.c.inc   |   8 +-
 target/ppc/translate/storage-ctrl-impl.c.inc  |  16 +--
 .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
 target/riscv/insn_trans/trans_rvh.c.inc       |   4 +-
 target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
 target/riscv/insn_trans/trans_xthead.c.inc    |   8 +-
 tcg/aarch64/tcg-target.c.inc                  |   4 +-
 tcg/arm/tcg-target.c.inc                      |   4 +-
 tcg/i386/tcg-target.c.inc                     |   8 +-
 tcg/loongarch64/tcg-target.c.inc              |   4 +-
 tcg/mips/tcg-target.c.inc                     |   6 +-
 tcg/ppc/tcg-target.c.inc                      |   4 +-
 tcg/riscv/tcg-target.c.inc                    |   2 +-
 tcg/s390x/tcg-target.c.inc                    |   4 +-
 tcg/sparc64/tcg-target.c.inc                  |   8 +-
 208 files changed, 948 insertions(+), 945 deletions(-)

-- 
2.38.1


