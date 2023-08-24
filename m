Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6684786BA9
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:25:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6Zt-0003ZL-5x; Thu, 24 Aug 2023 05:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6Zq-0003Tb-Ab
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6Zk-0003GG-C8
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:29 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxxPC7IedkKnkbAA--.56950S3;
 Thu, 24 Aug 2023 17:24:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S2; 
 Thu, 24 Aug 2023 17:24:10 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	richard.henderson@linaro.org
Subject: [PULL 00/31] loongarch-to-apply queue
Date: Thu, 24 Aug 2023 17:23:38 +0800
Message-Id: <20230824092409.1492470-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20230824

for you to fetch changes up to 3f6bec4a9f7c159d32d49f6df5c2c3d587b953b9:

  hw/loongarch: Fix ACPI processor id off-by-one error (2023-08-24 16:58:16 +0800)

----------------------------------------------------------------
pull-loongarch-20230824

* Add la32 & va32 support for loongarch64-softmmu;
* Cleanups in preparation of loongarch32 support;
* Add some checks before translating instructions;
* Split fcc register to fcc0-7 in gdbstub;
* Fix ACPI processor id off-by-one error;
* Implement get_arch_id callback;
* Fix edge triggered irq handling.

----------------------------------------------------------------
Bibo Mao (2):
      target/loongarch: cpu: Implement get_arch_id callback
      hw/intc/loongarch_pch: fix edge triggered irq handling

Jiajie Chen (16):
      target/loongarch: Add function to check current arch
      target/loongarch: Add new object class for loongarch32 cpus
      target/loongarch: Add GDB support for loongarch32 mode
      target/loongarch: Support LoongArch32 TLB entry
      target/loongarch: Support LoongArch32 DMW
      target/loongarch: Support LoongArch32 VPPN
      target/loongarch: Add LA64 & VA32 to DisasContext
      target/loongarch: Extract make_address_x() helper
      target/loongarch: Extract make_address_i() helper
      target/loongarch: Extract make_address_pc() helper
      target/loongarch: Extract set_pc() helper
      target/loongarch: Truncate high 32 bits of address in VA32 mode
      target/loongarch: Sign extend results in VA32 mode
      target/loongarch: Add LoongArch32 cpu la132
      target/loongarch: Split fcc register to fcc0-7 in gdbstub
      hw/loongarch: Fix ACPI processor id off-by-one error

Philippe Mathieu-Daudé (4):
      target/loongarch: Log I/O write accesses to CSR registers
      target/loongarch: Remove duplicated disas_set_info assignment
      target/loongarch: Introduce abstract TYPE_LOONGARCH64_CPU
      target/loongarch: Extract 64-bit specifics to loongarch64_cpu_class_init

Song Gao (9):
      target/loongarch: Fix loongarch_la464_initfn() misses setting LSPW
      target/loongarch: Add a check parameter to the TRANS macro
      target/loongarch: Add avail_64 to check la64-only instructions
      hw/loongarch: Remove restriction of la464 cores in the virt machine
      target/loongarch: Add avail_FP/FP_SP/FP_DP to check fpu instructions
      target/loongarch: Add avail_LSPW to check LSPW instructions
      target/loongarch: Add avail_LAM to check atomic instructions
      target/loongarch: Add avail_LSX to check LSX instructions
      target/loongarch: Add avail_IOCSR to check iocsr instructions

 configs/targets/loongarch64-softmmu.mak            |    2 +-
 gdb-xml/loongarch-base32.xml                       |   45 +
 gdb-xml/loongarch-fpu.xml                          |    9 +-
 hw/intc/loongarch_pch_pic.c                        |    7 +-
 hw/loongarch/acpi-build.c                          |    2 +-
 hw/loongarch/virt.c                                |    7 +-
 target/loongarch/cpu-csr.h                         |   22 +-
 target/loongarch/cpu.c                             |  110 +-
 target/loongarch/cpu.h                             |   35 +
 target/loongarch/gdbstub.c                         |   50 +-
 target/loongarch/insn_trans/trans_arith.c.inc      |   98 +-
 target/loongarch/insn_trans/trans_atomic.c.inc     |   85 +-
 target/loongarch/insn_trans/trans_bit.c.inc        |   56 +-
 target/loongarch/insn_trans/trans_branch.c.inc     |   27 +-
 target/loongarch/insn_trans/trans_extra.c.inc      |   24 +-
 target/loongarch/insn_trans/trans_farith.c.inc     |   96 +-
 target/loongarch/insn_trans/trans_fcmp.c.inc       |    8 +
 target/loongarch/insn_trans/trans_fcnv.c.inc       |   56 +-
 target/loongarch/insn_trans/trans_fmemory.c.inc    |   62 +-
 target/loongarch/insn_trans/trans_fmov.c.inc       |   52 +-
 target/loongarch/insn_trans/trans_lsx.c.inc        | 1520 +++++++++++---------
 target/loongarch/insn_trans/trans_memory.c.inc     |  118 +-
 target/loongarch/insn_trans/trans_privileged.c.inc |   24 +-
 target/loongarch/insn_trans/trans_shift.c.inc      |   34 +-
 target/loongarch/op_helper.c                       |    4 +-
 target/loongarch/tlb_helper.c                      |   66 +-
 target/loongarch/translate.c                       |   46 +
 target/loongarch/translate.h                       |   19 +-
 28 files changed, 1591 insertions(+), 1093 deletions(-)
 create mode 100644 gdb-xml/loongarch-base32.xml


