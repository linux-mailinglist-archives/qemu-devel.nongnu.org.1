Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A0C743655
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:02:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92G-00084J-6m; Fri, 30 Jun 2023 03:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92D-00082t-9C
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF929-0007ub-7s
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:16 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxR8VJi55kVzQEAA--.6843S3;
 Fri, 30 Jun 2023 15:59:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S2; 
 Fri, 30 Jun 2023 15:59:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 00/46] Add LoongArch LASX instructions
Date: Fri, 30 Jun 2023 15:58:18 +0800
Message-Id: <20230630075904.45940-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S2
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

Hi, 

This series adds LoongArch LASX instructions.

About test:
We use RISU test the LoongArch LASX instructions.

QEMU:
    https://github.com/loongson/qemu/tree/tcg-old-abi-support-lasx
RISU:
    https://github.com/loongson/risu/tree/loongarch-suport-lasx

Please review, Thanks.

Changes for v2:
- Expand the definition of VReg to be 256 bits.
- Use more LSX functions.
- R-b.

Song Gao (46):
  target/loongarch: Add LASX data support
  target/loongarch: meson.build support build LASX
  target/loongarch: Add CHECK_ASXE maccro for check LASX enable
  target/loongarch: Implement xvadd/xvsub
  target/loongarch: Implement xvreplgr2vr
  target/loongarch: Implement xvaddi/xvsubi
  target/loongarch: Implement xvneg
  target/loongarch: Implement xvsadd/xvssub
  target/loongarch: Implement xvhaddw/xvhsubw
  target/loongarch: Implement xvaddw/xvsubw
  target/loongarch: Implement xavg/xvagr
  target/loongarch: Implement xvabsd
  target/loongarch: Implement xvadda
  target/loongarch: Implement xvmax/xvmin
  target/loongarch: Implement xvmul/xvmuh/xvmulw{ev/od}
  target/loongarch: Implement xvmadd/xvmsub/xvmaddw{ev/od}
  target/loongarch; Implement xvdiv/xvmod
  target/loongarch: Implement xvsat
  target/loongarch: Implement xvexth
  target/loongarch: Implement vext2xv
  target/loongarch: Implement xvsigncov
  target/loongarch: Implement xvmskltz/xvmskgez/xvmsknz
  target/loognarch: Implement xvldi
  target/loongarch: Implement LASX logic instructions
  target/loongarch: Implement xvsll xvsrl xvsra xvrotr
  target/loongarch: Implement xvsllwil xvextl
  target/loongarch: Implement xvsrlr xvsrar
  target/loongarch: Implement xvsrln xvsran
  target/loongarch: Implement xvsrlrn xvsrarn
  target/loongarch: Implement xvssrln xvssran
  target/loongarch: Implement xvssrlrn xvssrarn
  target/loongarch: Implement xvclo xvclz
  target/loongarch: Implement xvpcnt
  target/loongarch: Implement xvbitclr xvbitset xvbitrev
  target/loongarch: Implement xvfrstp
  target/loongarch: Implement LASX fpu arith instructions
  target/loongarch: Implement LASX fpu fcvt instructions
  target/loongarch: Implement xvseq xvsle xvslt
  target/loongarch: Implement xvfcmp
  target/loongarch: Implement xvbitsel xvset
  target/loongarch: Implement xvinsgr2vr xvpickve2gr
  target/loongarch: Implement xvreplve xvinsve0 xvpickve xvb{sll/srl}v
  target/loongarch: Implement xvpack xvpick xvilv{l/h}
  target/loongarch: Implement xvshuf xvperm{i} xvshuf4i xvextrins
  target/loongarch: Implement xvld xvst
  target/loongarch: CPUCFG support LASX

 linux-user/loongarch64/signal.c               |    1 +
 target/loongarch/cpu.c                        |    4 +
 target/loongarch/cpu.h                        |   26 +-
 target/loongarch/disas.c                      |  925 ++++++
 target/loongarch/gdbstub.c                    |    1 +
 target/loongarch/helper.h                     |  694 ++--
 target/loongarch/insn_trans/trans_lasx.c.inc  | 1034 ++++++
 target/loongarch/insn_trans/trans_lsx.c.inc   | 1867 ++++++-----
 target/loongarch/insns.decode                 |  782 +++++
 target/loongarch/internals.h                  |   22 -
 target/loongarch/machine.c                    |   40 +-
 target/loongarch/meson.build                  |    2 +-
 target/loongarch/translate.c                  |    6 +
 target/loongarch/vec.h                        |   98 +
 .../loongarch/{lsx_helper.c => vec_helper.c}  | 2923 ++++++++++-------
 15 files changed, 6009 insertions(+), 2416 deletions(-)
 create mode 100644 target/loongarch/insn_trans/trans_lasx.c.inc
 create mode 100644 target/loongarch/vec.h
 rename target/loongarch/{lsx_helper.c => vec_helper.c} (50%)

-- 
2.39.1


