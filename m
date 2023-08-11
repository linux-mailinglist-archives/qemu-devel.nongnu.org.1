Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D88FD778A91
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 12:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUOyR-0006c9-H4; Fri, 11 Aug 2023 06:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qUOyL-0006OT-IX
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:02:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qUOyG-0002EJ-Hf
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:02:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxnusiB9Zku4AVAA--.43537S3;
 Fri, 11 Aug 2023 18:02:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSMhB9ZkBcpUAA--.61494S2; 
 Fri, 11 Aug 2023 18:02:09 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, c@jia.je
Subject: [PATCH v2 0/8] Add some checks before translating instructions
Date: Fri, 11 Aug 2023 18:02:00 +0800
Message-Id: <20230811100208.271649-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSMhB9ZkBcpUAA--.61494S2
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

Based-on: https://patchew.org/QEMU/20230809083258.1787464-1-c@jia.je/

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

V2:
- Add a check parameter to the TRANS macro.
- remove TRANS_64.
- Add avail_ALL/64/FP/FP_SP/FP_DP/LSPW/LAM/LSX/IOCSR
  to check instructions.

Thanks.
Song Gao

Song Gao (8):
  target/loongarch: Fix loongarch_la464_initfn() misses setting LSPW.
  target/loongarch: Add a check parameter to the TRANS macro
  target/loongarch: Add avail_64 to check la64-only instructions
  target/loongarch: Add avail_FP/FP_SP/FP_DP to check fpu instructions
  target/loongarch: Add avail_LSPW to check LSPW instructions
  target/loongarch: Add avail_LAM to check atomic instructions
  target/loongarch: Add avail_LSX to check LSX instructions
  target/loongarch: Add avail_IOCSR to check iocsr instructions

 target/loongarch/cpu.c                        |    1 +
 target/loongarch/insn_trans/trans_arith.c.inc |   96 +-
 .../loongarch/insn_trans/trans_atomic.c.inc   |   92 +-
 target/loongarch/insn_trans/trans_bit.c.inc   |   56 +-
 .../loongarch/insn_trans/trans_branch.c.inc   |   20 +-
 target/loongarch/insn_trans/trans_extra.c.inc |   28 +-
 .../loongarch/insn_trans/trans_farith.c.inc   |   96 +-
 target/loongarch/insn_trans/trans_fcmp.c.inc  |    8 +
 target/loongarch/insn_trans/trans_fcnv.c.inc  |   56 +-
 .../loongarch/insn_trans/trans_fmemory.c.inc  |   32 +-
 target/loongarch/insn_trans/trans_fmov.c.inc  |   52 +-
 target/loongarch/insn_trans/trans_lsx.c.inc   | 1482 +++++++++--------
 .../loongarch/insn_trans/trans_memory.c.inc   |   84 +-
 .../insn_trans/trans_privileged.c.inc         |   24 +-
 target/loongarch/insn_trans/trans_shift.c.inc |   34 +-
 target/loongarch/translate.c                  |    3 +
 target/loongarch/translate.h                  |   24 +-
 17 files changed, 1237 insertions(+), 951 deletions(-)

-- 
2.39.1


