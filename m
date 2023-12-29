Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E281FEB9
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:38:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9JJ-0002I1-P1; Fri, 29 Dec 2023 04:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rJ9JH-0002HT-0A
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:37:43 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rJ9JD-0001lE-Vs
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:37:42 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxmupZk45lr2oAAA--.1152S3;
 Fri, 29 Dec 2023 17:37:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxPL5Xk45lL7kPAA--.23722S2; 
 Fri, 29 Dec 2023 17:37:27 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn, zhaotianrui@loongson.cn
Subject: [PATCH 1/1] target/loongarch: move translate modules to tcg/
Date: Fri, 29 Dec 2023 17:24:35 +0800
Message-Id: <20231229092435.3416025-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxPL5Xk45lL7kPAA--.23722S2
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

Introduce the target/loongarch/tcg directory. Its purpose is to hold the TCG
code that is selected by CONFIG_TCG

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/{ => tcg}/constant_timer.c     |  0
 target/loongarch/{ => tcg}/csr_helper.c         |  0
 target/loongarch/{ => tcg}/fpu_helper.c         |  0
 target/loongarch/{ => tcg}/iocsr_helper.c       |  0
 target/loongarch/{ => tcg}/op_helper.c          |  0
 target/loongarch/{ => tcg}/tlb_helper.c         |  0
 target/loongarch/{ => tcg}/translate.c          |  0
 target/loongarch/{ => tcg}/vec_helper.c         |  0
 .../{ => tcg}/insn_trans/trans_arith.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_atomic.c.inc     |  0
 .../{ => tcg}/insn_trans/trans_bit.c.inc        |  0
 .../{ => tcg}/insn_trans/trans_branch.c.inc     |  0
 .../{ => tcg}/insn_trans/trans_extra.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_farith.c.inc     |  0
 .../{ => tcg}/insn_trans/trans_fcmp.c.inc       |  0
 .../{ => tcg}/insn_trans/trans_fcnv.c.inc       |  0
 .../{ => tcg}/insn_trans/trans_fmemory.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_fmov.c.inc       |  0
 .../{ => tcg}/insn_trans/trans_memory.c.inc     |  0
 .../{ => tcg}/insn_trans/trans_privileged.c.inc |  0
 .../{ => tcg}/insn_trans/trans_shift.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_vec.c.inc        |  0
 target/loongarch/meson.build                    | 17 ++---------------
 target/loongarch/tcg/meson.build                | 15 +++++++++++++++
 24 files changed, 17 insertions(+), 15 deletions(-)
 rename target/loongarch/{ => tcg}/constant_timer.c (100%)
 rename target/loongarch/{ => tcg}/csr_helper.c (100%)
 rename target/loongarch/{ => tcg}/fpu_helper.c (100%)
 rename target/loongarch/{ => tcg}/iocsr_helper.c (100%)
 rename target/loongarch/{ => tcg}/op_helper.c (100%)
 rename target/loongarch/{ => tcg}/tlb_helper.c (100%)
 rename target/loongarch/{ => tcg}/translate.c (100%)
 rename target/loongarch/{ => tcg}/vec_helper.c (100%)
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
 create mode 100644 target/loongarch/tcg/meson.build

diff --git a/target/loongarch/constant_timer.c b/target/loongarch/tcg/constant_timer.c
similarity index 100%
rename from target/loongarch/constant_timer.c
rename to target/loongarch/tcg/constant_timer.c
diff --git a/target/loongarch/csr_helper.c b/target/loongarch/tcg/csr_helper.c
similarity index 100%
rename from target/loongarch/csr_helper.c
rename to target/loongarch/tcg/csr_helper.c
diff --git a/target/loongarch/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
similarity index 100%
rename from target/loongarch/fpu_helper.c
rename to target/loongarch/tcg/fpu_helper.c
diff --git a/target/loongarch/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
similarity index 100%
rename from target/loongarch/iocsr_helper.c
rename to target/loongarch/tcg/iocsr_helper.c
diff --git a/target/loongarch/op_helper.c b/target/loongarch/tcg/op_helper.c
similarity index 100%
rename from target/loongarch/op_helper.c
rename to target/loongarch/tcg/op_helper.c
diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
similarity index 100%
rename from target/loongarch/tlb_helper.c
rename to target/loongarch/tcg/tlb_helper.c
diff --git a/target/loongarch/translate.c b/target/loongarch/tcg/translate.c
similarity index 100%
rename from target/loongarch/translate.c
rename to target/loongarch/tcg/translate.c
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/tcg/vec_helper.c
similarity index 100%
rename from target/loongarch/vec_helper.c
rename to target/loongarch/tcg/vec_helper.c
diff --git a/target/loongarch/insn_trans/trans_arith.c.inc b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_arith.c.inc
rename to target/loongarch/tcg/insn_trans/trans_arith.c.inc
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_atomic.c.inc
rename to target/loongarch/tcg/insn_trans/trans_atomic.c.inc
diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_bit.c.inc
rename to target/loongarch/tcg/insn_trans/trans_bit.c.inc
diff --git a/target/loongarch/insn_trans/trans_branch.c.inc b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_branch.c.inc
rename to target/loongarch/tcg/insn_trans/trans_branch.c.inc
diff --git a/target/loongarch/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_extra.c.inc
rename to target/loongarch/tcg/insn_trans/trans_extra.c.inc
diff --git a/target/loongarch/insn_trans/trans_farith.c.inc b/target/loongarch/tcg/insn_trans/trans_farith.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_farith.c.inc
rename to target/loongarch/tcg/insn_trans/trans_farith.c.inc
diff --git a/target/loongarch/insn_trans/trans_fcmp.c.inc b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_fcmp.c.inc
rename to target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
diff --git a/target/loongarch/insn_trans/trans_fcnv.c.inc b/target/loongarch/tcg/insn_trans/trans_fcnv.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_fcnv.c.inc
rename to target/loongarch/tcg/insn_trans/trans_fcnv.c.inc
diff --git a/target/loongarch/insn_trans/trans_fmemory.c.inc b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_fmemory.c.inc
rename to target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
diff --git a/target/loongarch/insn_trans/trans_fmov.c.inc b/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_fmov.c.inc
rename to target/loongarch/tcg/insn_trans/trans_fmov.c.inc
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_memory.c.inc
rename to target/loongarch/tcg/insn_trans/trans_memory.c.inc
diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_privileged.c.inc
rename to target/loongarch/tcg/insn_trans/trans_privileged.c.inc
diff --git a/target/loongarch/insn_trans/trans_shift.c.inc b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_shift.c.inc
rename to target/loongarch/tcg/insn_trans/trans_shift.c.inc
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
similarity index 100%
rename from target/loongarch/insn_trans/trans_vec.c.inc
rename to target/loongarch/tcg/insn_trans/trans_vec.c.inc
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index 18e8191e2b..a004523439 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -3,31 +3,18 @@ gen = decodetree.process('insns.decode')
 loongarch_ss = ss.source_set()
 loongarch_ss.add(files(
   'cpu.c',
+  'gdbstub.c'
 ))
-loongarch_tcg_ss = ss.source_set()
-loongarch_tcg_ss.add(gen)
-loongarch_tcg_ss.add(files(
-  'fpu_helper.c',
-  'op_helper.c',
-  'translate.c',
-  'gdbstub.c',
-  'vec_helper.c',
-))
-loongarch_tcg_ss.add(zlib)
 
 loongarch_system_ss = ss.source_set()
 loongarch_system_ss.add(files(
   'loongarch-qmp-cmds.c',
   'machine.c',
-  'tlb_helper.c',
-  'constant_timer.c',
-  'csr_helper.c',
-  'iocsr_helper.c',
 ))
 
 common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
 
-loongarch_ss.add_all(when: 'CONFIG_TCG', if_true: [loongarch_tcg_ss])
+subdir('tcg')
 
 target_arch += {'loongarch': loongarch_ss}
 target_system_arch += {'loongarch': loongarch_system_ss}
diff --git a/target/loongarch/tcg/meson.build b/target/loongarch/tcg/meson.build
new file mode 100644
index 0000000000..bb7411e5e5
--- /dev/null
+++ b/target/loongarch/tcg/meson.build
@@ -0,0 +1,15 @@
+loongarch_ss.add([zlib, gen])
+
+loongarch_ss.add(files(
+  'fpu_helper.c',
+  'op_helper.c',
+  'vec_helper.c',
+  'translate.c',
+))
+
+loongarch_system_ss.add(files(
+  'constant_timer.c',
+  'iocsr_helper.c',
+  'tlb_helper.c',
+  'csr_helper.c',
+))
-- 
2.25.1


