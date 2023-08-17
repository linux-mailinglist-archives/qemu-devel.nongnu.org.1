Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 523D577F35B
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWZMH-000181-91; Thu, 17 Aug 2023 05:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qWZM1-0007Nv-AC
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qWZLs-0002Ye-4E
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:44 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxnuvu6N1kQnUZAA--.50064S3;
 Thu, 17 Aug 2023 17:31:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSPs6N1kjKdcAA--.12060S2; 
 Thu, 17 Aug 2023 17:31:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, philmd@linaro.org,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, yijun@loongson.cn,
 shenjinyang@loongson.cn
Subject: [PATCH v3 00/18] Add some checks before translating instructions
Date: Thu, 17 Aug 2023 17:31:03 +0800
Message-Id: <20230817093121.1053890-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSPs6N1kjKdcAA--.12060S2
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

Hi,

This series adds some checks before translating instructions

This includes:

CPUCFG[1].IOCSR

CPUCFG[2].FP
CPUCFG[2].FP_SP
CPUCFG[2].FP_DP
CPUCFG[2].LSPW
CPUCFG[2].LAM
CPUCFG[2].LSX


And this series adds [1] patches together.

Patch 11,12,16 need review.

V3:
- Rebase;
- The la32 instructions following Table 2 at [2].

V2:
- Add a check parameter to the TRANS macro.
- remove TRANS_64.
- Add avail_ALL/64/FP/FP_SP/FP_DP/LSPW/LAM/LSX/IOCSR
  to check instructions.

[1]: https://patchew.org/QEMU/20230809083258.1787464-1-c@jia.je/
[2]: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#overview-of-basic-integer-instructions

Please review.

Thanks.
Song Gao

Jiajie Chen (10):
  target/loongarch: Add function to check current arch
  target/loongarch: Add new object class for loongarch32 cpus
  target/loongarch: Add GDB support for loongarch32 mode
  target/loongarch: Support LoongArch32 TLB entry
  target/loongarch: Support LoongArch32 DMW
  target/loongarch: Support LoongArch32 VPPN
  target/loongarch: Add LA64 & VA32 to DisasContext
  target/loongarch: Truncate high 32 bits of address in VA32 mode
  target/loongarch: Sign extend results in VA32 mode
  target/loongarch: Add loongarch32 cpu la132

Song Gao (8):
  target/loongarch: Fix loongarch_la464_initfn() misses setting LSPW.
  target/loongarch: Add a check parameter to the TRANS macro
  target/loongarch: Add avail_64 to check la64-only instructions
  target/loongarch: Add avail_FP/FP_SP/FP_DP to check fpu instructions
  target/loongarch: Add avail_LSPW to check LSPW instructions
  target/loongarch: Add avail_LAM to check atomic instructions
  target/loongarch: Add avail_LSX to check LSX instructions
  target/loongarch: Add avail_IOCSR to check iocsr instructions

 configs/targets/loongarch64-softmmu.mak       |    2 +-
 gdb-xml/loongarch-base32.xml                  |   45 +
 hw/loongarch/virt.c                           |    5 -
 target/loongarch/cpu-csr.h                    |   22 +-
 target/loongarch/cpu.c                        |   75 +-
 target/loongarch/cpu.h                        |   33 +
 target/loongarch/gdbstub.c                    |   34 +-
 target/loongarch/insn_trans/trans_arith.c.inc |   98 +-
 .../loongarch/insn_trans/trans_atomic.c.inc   |   85 +-
 target/loongarch/insn_trans/trans_bit.c.inc   |   56 +-
 .../loongarch/insn_trans/trans_branch.c.inc   |   27 +-
 target/loongarch/insn_trans/trans_extra.c.inc |   24 +-
 .../loongarch/insn_trans/trans_farith.c.inc   |   96 +-
 target/loongarch/insn_trans/trans_fcmp.c.inc  |    8 +
 target/loongarch/insn_trans/trans_fcnv.c.inc  |   56 +-
 .../loongarch/insn_trans/trans_fmemory.c.inc  |   62 +-
 target/loongarch/insn_trans/trans_fmov.c.inc  |   52 +-
 target/loongarch/insn_trans/trans_lsx.c.inc   | 1520 +++++++++--------
 .../loongarch/insn_trans/trans_memory.c.inc   |  118 +-
 .../insn_trans/trans_privileged.c.inc         |   24 +-
 target/loongarch/insn_trans/trans_shift.c.inc |   34 +-
 target/loongarch/op_helper.c                  |    4 +-
 target/loongarch/tlb_helper.c                 |   66 +-
 target/loongarch/translate.c                  |   46 +
 target/loongarch/translate.h                  |   19 +-
 25 files changed, 1539 insertions(+), 1072 deletions(-)
 create mode 100644 gdb-xml/loongarch-base32.xml

-- 
2.39.1


