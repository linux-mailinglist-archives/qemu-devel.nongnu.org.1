Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4DC824C92
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 02:32:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLZ30-0003Ci-7E; Thu, 04 Jan 2024 20:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rLZ2s-0003CE-Uy
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 20:30:47 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rLZ2p-0000px-RW
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 20:30:46 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxoOm5W5dlaCQCAA--.3815S3;
 Fri, 05 Jan 2024 09:30:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxut23W5dlmqECAA--.6905S2; 
 Fri, 05 Jan 2024 09:30:31 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org
Subject: [PULL 0/2] loongarch-to-apply queue
Date: Fri,  5 Jan 2024 09:17:37 +0800
Message-Id: <20240105011739.1217818-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxut23W5dlmqECAA--.6905S2
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit d328fef93ae757a0dd65ed786a4086e27952eef3:

  Merge tag 'pull-20231230' of https://gitlab.com/rth7680/qemu into staging (2024-01-04 10:23:34 +0000)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240105

for you to fetch changes up to 0cd8b379081fa71c23836052feb65da4685f8ec7:

  target/loongarch: move translate modules to tcg/ (2024-01-05 09:31:05 +0800)

----------------------------------------------------------------
pull-loongarch-20240105

----------------------------------------------------------------
Song Gao (2):
      target/loongarch/meson: move gdbstub.c to loongarch.ss
      target/loongarch: move translate modules to tcg/

 target/loongarch/meson.build                          | 15 +--------------
 target/loongarch/{ => tcg}/constant_timer.c           |  0
 target/loongarch/{ => tcg}/csr_helper.c               |  0
 target/loongarch/{ => tcg}/fpu_helper.c               |  0
 .../loongarch/{ => tcg}/insn_trans/trans_arith.c.inc  |  0
 .../loongarch/{ => tcg}/insn_trans/trans_atomic.c.inc |  0
 target/loongarch/{ => tcg}/insn_trans/trans_bit.c.inc |  0
 .../loongarch/{ => tcg}/insn_trans/trans_branch.c.inc |  0
 .../loongarch/{ => tcg}/insn_trans/trans_extra.c.inc  |  0
 .../loongarch/{ => tcg}/insn_trans/trans_farith.c.inc |  0
 .../loongarch/{ => tcg}/insn_trans/trans_fcmp.c.inc   |  0
 .../loongarch/{ => tcg}/insn_trans/trans_fcnv.c.inc   |  0
 .../{ => tcg}/insn_trans/trans_fmemory.c.inc          |  0
 .../loongarch/{ => tcg}/insn_trans/trans_fmov.c.inc   |  0
 .../loongarch/{ => tcg}/insn_trans/trans_memory.c.inc |  0
 .../{ => tcg}/insn_trans/trans_privileged.c.inc       |  0
 .../loongarch/{ => tcg}/insn_trans/trans_shift.c.inc  |  0
 target/loongarch/{ => tcg}/insn_trans/trans_vec.c.inc |  0
 target/loongarch/{ => tcg}/iocsr_helper.c             |  0
 target/loongarch/tcg/meson.build                      | 19 +++++++++++++++++++
 target/loongarch/{ => tcg}/op_helper.c                |  0
 target/loongarch/{ => tcg}/tlb_helper.c               |  0
 target/loongarch/{ => tcg}/translate.c                |  0
 target/loongarch/{ => tcg}/vec_helper.c               |  0
 24 files changed, 20 insertions(+), 14 deletions(-)
 rename target/loongarch/{ => tcg}/constant_timer.c (100%)
 rename target/loongarch/{ => tcg}/csr_helper.c (100%)
 rename target/loongarch/{ => tcg}/fpu_helper.c (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_arith.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_atomic.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_bit.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_branch.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_extra.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_farith.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_fcmp.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_fcnv.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_fmemory.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_fmov.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_memory.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_privileged.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_shift.c.inc (100%)
 rename target/loongarch/{ => tcg}/insn_trans/trans_vec.c.inc (100%)
 rename target/loongarch/{ => tcg}/iocsr_helper.c (100%)
 create mode 100644 target/loongarch/tcg/meson.build
 rename target/loongarch/{ => tcg}/op_helper.c (100%)
 rename target/loongarch/{ => tcg}/tlb_helper.c (100%)
 rename target/loongarch/{ => tcg}/translate.c (100%)
 rename target/loongarch/{ => tcg}/vec_helper.c (100%)


