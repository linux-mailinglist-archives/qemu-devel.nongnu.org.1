Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 279CC775577
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTedF-0003cN-6Z; Wed, 09 Aug 2023 04:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedB-0003bz-6r
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:26 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTed7-0001m7-CJ
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:23 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id CB35243ED8;
 Wed,  9 Aug 2023 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691569998; bh=+qXQDGdEr0jahDKSC5Qx+TUcPz19BX0gqj64otWV3mM=;
 h=From:To:Cc:Subject:Date;
 b=XDd78Z4XpBCq+iXgOpmYqiConTsTCdT+lL9wQ+CQ9sS3a+QYMzgyhlKtIjfJMO2P0
 37D6yw0uMMyxbp+dHFrXG2ky0CvXpgnhP8a86jZYIONlFR4Ixzc//TkxtheY6blNT3
 NSLdeCg/0tPqKAvRQ7kyT7cXEPFkO1GILPdgjJC4=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>
Subject: [PATCH v5 00/11] Add la32 & va32 support for loongarch64-softmmu
Date: Wed,  9 Aug 2023 16:26:28 +0800
Message-ID: <20230809083258.1787464-1-c@jia.je>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This patch series allow qemu-system-loongarch64 to emulate a LoongArch32
machine. A new CPU model (la132) is added for loongarch32, however due
to lack of public documentation, details will need to be added in the
future. Initial GDB support is added.

At the same time, VA32(32-bit virtual address) support is introduced for
LoongArch64.

LA32 support is tested using a small supervisor program at
https://github.com/jiegec/supervisor-la32. VA32 mode under LA64 is not
tested yet.

Changes since v4:

- Code refactor, thanks Richard Henderson for great advice
- Truncate higher 32 bits of PC in VA32 mode
- Revert la132 initfn refactor

Changes since v3:

- Support VA32 mode for LoongArch64
- Check the current arch from CPUCFG.ARCH
- Reject la64-only instructions in la32 mode

Changes since v2:

- Fix typo in previous commit
- Fix VPPN width in TLBEHI/TLBREHI

Changes since v1:

- No longer create a separate qemu-system-loongarch32 executable, but
  allow user to run loongarch32 emulation using qemu-system-loongarch64
- Add loongarch32 cpu support for virt machine

Full changes:

Jiajie Chen (11):
  target/loongarch: Add function to check current arch
  target/loongarch: Add new object class for loongarch32 cpus
  target/loongarch: Add GDB support for loongarch32 mode
  target/loongarch: Support LoongArch32 TLB entry
  target/loongarch: Support LoongArch32 DMW
  target/loongarch: Support LoongArch32 VPPN
  target/loongarch: Add LA64 & VA32 to DisasContext
  target/loongarch: Reject la64-only instructions in la32 mode
  target/loongarch: Truncate high 32 bits of address in VA32 mode
  target/loongarch: Sign extend results in VA32 mode
  target/loongarch: Add loongarch32 cpu la132

 configs/targets/loongarch64-softmmu.mak       |   2 +-
 gdb-xml/loongarch-base32.xml                  |  45 ++++++++
 hw/loongarch/virt.c                           |   5 -
 target/loongarch/cpu-csr.h                    |  22 ++--
 target/loongarch/cpu.c                        |  74 +++++++++++--
 target/loongarch/cpu.h                        |  33 ++++++
 target/loongarch/gdbstub.c                    |  34 ++++--
 target/loongarch/insn_trans/trans_arith.c.inc |  32 +++---
 .../loongarch/insn_trans/trans_atomic.c.inc   |  81 +++++++-------
 target/loongarch/insn_trans/trans_bit.c.inc   |  28 ++---
 .../loongarch/insn_trans/trans_branch.c.inc   |  11 +-
 target/loongarch/insn_trans/trans_extra.c.inc |  16 +--
 .../loongarch/insn_trans/trans_fmemory.c.inc  |  30 ++----
 target/loongarch/insn_trans/trans_fmov.c.inc  |   4 +-
 target/loongarch/insn_trans/trans_lsx.c.inc   |  38 ++-----
 .../loongarch/insn_trans/trans_memory.c.inc   | 102 ++++++++----------
 target/loongarch/insn_trans/trans_shift.c.inc |  14 +--
 target/loongarch/op_helper.c                  |   4 +-
 target/loongarch/tlb_helper.c                 |  66 +++++++++---
 target/loongarch/translate.c                  |  43 ++++++++
 target/loongarch/translate.h                  |   9 ++
 21 files changed, 445 insertions(+), 248 deletions(-)
 create mode 100644 gdb-xml/loongarch-base32.xml

-- 
2.41.0


