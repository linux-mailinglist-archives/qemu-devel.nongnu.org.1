Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97885A9CB29
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 16:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jfx-0004Ib-PG; Fri, 25 Apr 2025 10:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangran@bosc.ac.cn>)
 id 1u8I4d-0003n8-Mg; Fri, 25 Apr 2025 08:22:31 -0400
Received: from out28-75.mail.aliyun.com ([115.124.28.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangran@bosc.ac.cn>)
 id 1u8I4b-0004G5-27; Fri, 25 Apr 2025 08:22:31 -0400
Received: from localhost.localdomain(mailfrom:wangran@bosc.ac.cn
 fp:SMTPD_---.cWiD-Y1_1745583737 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 25 Apr 2025 20:22:21 +0800
From: Ran Wang <wangran@bosc.ac.cn>
To: alistair23@gmail.com
Cc: 3543977024@qq.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] target/riscv: Add BOSC's Xiangshan Kunminghu CPU
Date: Fri, 25 Apr 2025 20:22:12 +0800
Message-Id: <20250425122212.364-1-wangran@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.75; envelope-from=wangran@bosc.ac.cn;
 helo=out28-75.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 10:04:56 -0400
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

From: Huang Borong <3543977024@qq.com>

Add a CPU entry for the Xiangshan Kunminghu CPU, an open-source,
high-performance RISC-V processor. More details can be found at:
https://github.com/OpenXiangShan/XiangShan

Note: The ISA extensions supported by the Xiangshan Kunminghu CPU are
categorized based on four RISC-V specifications: Volume I: Unprivileged
Architecture, Volume II: Privileged Architecture, AIA, and RVA23. The
extensions within each category are organized according to the chapter
order in the specifications.

Signed-off-by: Yu Hu <huyu@bosc.ac.cn>
Signed-off-by: Ran Wang <wangran@bosc.ac.cn>
Signed-off-by: Borong Huang <3543977024@qq.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 64 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1ee05eb393..75f4e43408 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -55,6 +55,7 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
+#define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ee20bd7ca2..1fde2769bf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3171,6 +3171,70 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV39,
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVB | RVS | RVU | RVH | RVV,
+        .priv_spec = PRIV_VERSION_1_13_0,
+
+	/*
+	 * The RISC-V Instruction Set Manual: Volume I
+	 * Unprivileged Architecture
+	 */
+	.cfg.ext_zicntr = true,
+	.cfg.ext_zihpm = true,
+	.cfg.ext_zihintntl = true,
+	.cfg.ext_zihintpause = true,
+	.cfg.ext_zimop = true,
+	.cfg.ext_zcmop = true,
+	.cfg.ext_zicond = true,
+	.cfg.ext_zawrs = true,
+	.cfg.ext_zacas = true,
+	.cfg.ext_zfh = true,
+	.cfg.ext_zfa = true,
+	.cfg.ext_zcb = true,
+	.cfg.ext_zbc = true,
+	.cfg.ext_zvfh = true,
+	.cfg.ext_zkn = true,
+	.cfg.ext_zks = true,
+	.cfg.ext_zkt = true,
+	.cfg.ext_zvbb = true,
+	.cfg.ext_zvkt = true,
+
+	/*
+	 * The RISC-V Instruction Set Manual: Volume II
+	 * Privileged Architecture
+	 */
+	.cfg.ext_smstateen = true,
+	.cfg.ext_smcsrind = true,
+	.cfg.ext_sscsrind = true,
+	.cfg.ext_svnapot = true,
+	.cfg.ext_svpbmt = true,
+	.cfg.ext_svinval = true,
+	.cfg.ext_sstc = true,
+	.cfg.ext_sscofpmf = true,
+	.cfg.ext_ssdbltrp = true,
+	.cfg.ext_ssnpm = true,
+	.cfg.ext_smnpm = true,
+	.cfg.ext_smmpm = true,
+	.cfg.ext_sspm = true,
+	.cfg.ext_supm = true,
+
+	/* The RISC-V Advanced Interrupt Architecture */
+	.cfg.ext_smaia = true,
+	.cfg.ext_ssaia = true,
+
+	/* RVA23 Profiles */
+	.cfg.ext_zicbom = true,
+	.cfg.ext_zicbop = true,
+	.cfg.ext_zicboz = true,
+	.cfg.ext_svade = true,
+
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV48,
+    ),
+
 #ifdef CONFIG_TCG
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.34.1


