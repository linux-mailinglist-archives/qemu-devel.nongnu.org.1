Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDF879A3B1
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaeD-0000AM-5v; Mon, 11 Sep 2023 02:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfae9-0000AB-LW
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:43:45 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfae4-0004Qc-IP
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:43:43 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c39bc0439bso8732885ad.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414618; x=1695019418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ptH70eaHZ9hqnH84X8NNemVuNRzgMAg3dpeSY96q0I4=;
 b=ntgapzgtJTvohI/xCU1vN5QVb/CYJI8FWKWqKFdD3xYMNRz/uSQuOKgqKEkmvWWONG
 QsfTn7qdYFAFbDdmVOb5FSNYFSY/aMhhFvAZTDmFe0N3zHtWz/X03goeopgmVxuzLUhR
 ELtsx3i2ib+UcIkSKIMo9TV1amyD9Jri38bgDTMv5b9FV55RrjEzgCkeupGk7HuzE/UM
 zQ074qc3K/a/avTqlp7h+Z4972talWSwzaKgYi/odRA54m6eWpo3bcOoStSl51yeRYlM
 k145LnF17jfCg6sb7cIJFGxBJOkt4Z6Wob8G/g1JQw1P6eD2VxYFQuoSR78MWFYKAGFP
 rRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414618; x=1695019418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ptH70eaHZ9hqnH84X8NNemVuNRzgMAg3dpeSY96q0I4=;
 b=G1e9SipGcQI5gPMgXAiO2ntypwLZU+E8/6hu1gw9dlS/HcbDZXdbdYM5ZWQXy2RmhW
 H3df2FmoQbJ6znB+fhk3KEggjLvSixCl3S33BMURgZghUeJXhsFJwC6uGos7TOqzyj6h
 HQZkPtyArW43tWSg/TNn/U93wJ7EUMuOu7D2aBNWi4ZXRJqSbj43LHMW9sEu3b1XR4ou
 9uOvB8qcncmT4N0q2vj6anDp2jAAqtZSH6msR8YlAz+zOtaf6jb46Y3K6b1C1izUbb/i
 Au0esL48dWeX+vev3smDGipyPRK/glxdMFfVrpitU83Qt5wOhxAM8ttNCr+bZjw4bSk5
 yE9g==
X-Gm-Message-State: AOJu0YzCNCpwGRI4sfmGMH2R0juaEPFFEdMQ/jXsHHPweb7fCWPABjlT
 OZC6nnN3slkc3uJcGYiA96CMIF/0VTCuiA==
X-Google-Smtp-Source: AGHT+IG+39zt2J1L88ZsfM7avFkyudlHbiBcC8/CJGEY/fsKxTc7fM1LfkhnaCqf9t9c/Qm+ZPkbZw==
X-Received: by 2002:a17:902:f549:b0:1bc:7312:78e2 with SMTP id
 h9-20020a170902f54900b001bc731278e2mr15644228plf.5.1694414618036; 
 Sun, 10 Sep 2023 23:43:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:43:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 00/45] riscv-to-apply queue
Date: Mon, 11 Sep 2023 16:42:35 +1000
Message-ID: <20230911064320.939791-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit c5ea91da443b458352c1b629b490ee6631775cb4:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2023-09-08 10:06:25 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230911

for you to fetch changes up to e7a03409f29e2da59297d55afbaec98c96e43e3a:

  target/riscv: don't read CSR in riscv_csrrw_do64 (2023-09-11 11:45:55 +1000)

----------------------------------------------------------------
First RISC-V PR for 8.2

 * Remove 'host' CPU from TCG
 * riscv_htif Fixup printing on big endian hosts
 * Add zmmul isa string
 * Add smepmp isa string
 * Fix page_check_range use in fault-only-first
 * Use existing lookup tables for MixColumns
 * Add RISC-V vector cryptographic instruction set support
 * Implement WARL behaviour for mcountinhibit/mcounteren
 * Add Zihintntl extension ISA string to DTS
 * Fix zfa fleq.d and fltq.d
 * Fix upper/lower mtime write calculation
 * Make rtc variable names consistent
 * Use abi type for linux-user target_ucontext
 * Add RISC-V KVM AIA Support
 * Fix riscv,pmu DT node path in the virt machine
 * Update CSR bits name for svadu extension
 * Mark zicond non-experimental
 * Fix satp_mode_finalize() when satp_mode.supported = 0
 * Fix non-KVM --enable-debug build
 * Add new extensions to hwprobe
 * Use accelerated helper for AES64KS1I
 * Allocate itrigger timers only once
 * Respect mseccfg.RLB for pmpaddrX changes
 * Align the AIA model to v1.0 ratified spec
 * Don't read the CSR in riscv_csrrw_do64

----------------------------------------------------------------
Akihiko Odaki (1):
      target/riscv: Allocate itrigger timers only once

Ard Biesheuvel (2):
      target/riscv: Use existing lookup tables for MixColumns
      target/riscv: Use accelerated helper for AES64KS1I

Conor Dooley (1):
      hw/riscv: virt: Fix riscv,pmu DT node path

Daniel Henrique Barboza (6):
      target/riscv/cpu.c: do not run 'host' CPU with TCG
      target/riscv/cpu.c: add zmmul isa string
      target/riscv/cpu.c: add smepmp isa string
      target/riscv: fix satp_mode_finalize() when satp_mode.supported = 0
      hw/riscv/virt.c: fix non-KVM --enable-debug build
      hw/intc/riscv_aplic.c fix non-KVM --enable-debug build

Dickon Hood (2):
      target/riscv: Refactor translation of vector-widening instruction
      target/riscv: Add Zvbb ISA extension support

Jason Chien (3):
      target/riscv: Add Zihintntl extension ISA string to DTS
      hw/intc: Fix upper/lower mtime write calculation
      hw/intc: Make rtc variable names consistent

Kiran Ostrolenk (4):
      target/riscv: Refactor some of the generic vector functionality
      target/riscv: Refactor vector-vector translation macro
      target/riscv: Refactor some of the generic vector functionality
      target/riscv: Add Zvknh ISA extension support

LIU Zhiwei (3):
      target/riscv: Fix page_check_range use in fault-only-first
      target/riscv: Fix zfa fleq.d and fltq.d
      linux-user/riscv: Use abi type for target_ucontext

Lawrence Hunter (2):
      target/riscv: Add Zvbc ISA extension support
      target/riscv: Add Zvksh ISA extension support

Leon Schuermann (1):
      target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX changes

Max Chou (3):
      crypto: Create sm4_subword
      crypto: Add SM4 constant parameter CK
      target/riscv: Add Zvksed ISA extension support

Nazar Kazakov (4):
      target/riscv: Remove redundant "cpu_vl == 0" checks
      target/riscv: Move vector translation checks
      target/riscv: Add Zvkned ISA extension support
      target/riscv: Add Zvkg ISA extension support

Nikita Shubin (1):
      target/riscv: don't read CSR in riscv_csrrw_do64

Rob Bradford (1):
      target/riscv: Implement WARL behaviour for mcountinhibit/mcounteren

Robbin Ehn (1):
      linux-user/riscv: Add new extensions to hwprobe

Thomas Huth (2):
      hw/char/riscv_htif: Fix printing of console characters on big endian hosts
      hw/char/riscv_htif: Fix the console syscall on big endian hosts

Tommy Wu (1):
      target/riscv: Align the AIA model to v1.0 ratified spec

Vineet Gupta (1):
      riscv: zicond: make non-experimental

Weiwei Li (1):
      target/riscv: Update CSR bits name for svadu extension

Yong-Xuan Wang (5):
      target/riscv: support the AIA device emulation with KVM enabled
      target/riscv: check the in-kernel irqchip support
      target/riscv: Create an KVM AIA irqchip
      target/riscv: update APLIC and IMSIC to support KVM AIA
      target/riscv: select KVM AIA in riscv virt machine

 include/crypto/aes.h                      |   7 +
 include/crypto/sm4.h                      |   9 +
 target/riscv/cpu_bits.h                   |   8 +-
 target/riscv/cpu_cfg.h                    |   9 +
 target/riscv/debug.h                      |   3 +-
 target/riscv/helper.h                     |  98 +++
 target/riscv/kvm_riscv.h                  |   5 +
 target/riscv/vector_internals.h           | 228 +++++++
 target/riscv/insn32.decode                |  58 ++
 crypto/aes.c                              |   4 +-
 crypto/sm4.c                              |  10 +
 hw/char/riscv_htif.c                      |  12 +-
 hw/intc/riscv_aclint.c                    |  11 +-
 hw/intc/riscv_aplic.c                     |  52 +-
 hw/intc/riscv_imsic.c                     |  25 +-
 hw/riscv/virt.c                           | 374 ++++++------
 linux-user/riscv/signal.c                 |   4 +-
 linux-user/syscall.c                      |  14 +-
 target/arm/tcg/crypto_helper.c            |  10 +-
 target/riscv/cpu.c                        |  83 ++-
 target/riscv/cpu_helper.c                 |   6 +-
 target/riscv/crypto_helper.c              |  51 +-
 target/riscv/csr.c                        |  54 +-
 target/riscv/debug.c                      |  15 +-
 target/riscv/kvm.c                        | 201 ++++++-
 target/riscv/pmp.c                        |   4 +
 target/riscv/translate.c                  |   1 +
 target/riscv/vcrypto_helper.c             | 970 ++++++++++++++++++++++++++++++
 target/riscv/vector_helper.c              | 245 +-------
 target/riscv/vector_internals.c           |  81 +++
 target/riscv/insn_trans/trans_rvv.c.inc   | 171 +++---
 target/riscv/insn_trans/trans_rvvk.c.inc  | 606 +++++++++++++++++++
 target/riscv/insn_trans/trans_rvzfa.c.inc |   4 +-
 target/riscv/meson.build                  |   4 +-
 34 files changed, 2785 insertions(+), 652 deletions(-)
 create mode 100644 target/riscv/vector_internals.h
 create mode 100644 target/riscv/vcrypto_helper.c
 create mode 100644 target/riscv/vector_internals.c
 create mode 100644 target/riscv/insn_trans/trans_rvvk.c.inc

