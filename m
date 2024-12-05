Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AEB9E4EC5
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Dec 2024 08:38:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ6QG-0005wv-Rf; Thu, 05 Dec 2024 02:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1tJ6QC-0005vt-9s; Thu, 05 Dec 2024 02:37:12 -0500
Received: from smtp84.cstnet.cn ([159.226.251.84] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1tJ6Q8-0003Mj-Jq; Thu, 05 Dec 2024 02:37:11 -0500
Received: from f9905068bba7.home.arpa (unknown [124.16.138.129])
 by APP-05 (Coremail) with SMTP id zQCowADn738UWFFne1MECA--.48444S2;
 Thu, 05 Dec 2024 15:36:53 +0800 (CST)
From: MollyChen <xiaoou@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: MollyChen <xiaoou@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v1] target/riscv: add support for RV64 Xiangshan Nanhu CPU
Date: Thu,  5 Dec 2024 07:36:20 +0000
Message-Id: <20241205073622.46052-1-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADn738UWFFne1MECA--.48444S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1fZw45Jw48Aw13AFy7Jrb_yoW5Xr4xpr
 4UGa909rWDJasFka1fJF1DWrZ5Xw4ru3yag39xZ3W3XF43JrW7JF1Dt34UuryDXF4rX3WI
 93WkCF15CF43Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
 4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
 xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
 0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
 IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
 AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
 6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6J
 UUUUU==
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.84; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.827, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a CPU entry for the RV64 XiangShan NANHU CPU which
supports single-core and dual-core configurations. More
details can be found at
https://docs.xiangshan.cc/zh-cn/latest/integration/overview

Signed-off-by: MollyChen <xiaoou@iscas.ac.cn>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 6547642287..d56b067bf2 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -50,6 +50,7 @@
 #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
+#define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8447ad0dfb..38baaa39f8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -645,6 +645,34 @@ static void rv64_tt_ascalon_cpu_init(Object *obj)
 #endif
 }
 
+static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
+    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU);
+    env->priv_ver = PRIV_VERSION_1_12_0;
+
+    /* Enable ISA extensions */
+    cpu->cfg.ext_zbc = true;
+    cpu->cfg.ext_zbkb = true;
+    cpu->cfg.ext_zbkc = true;
+    cpu->cfg.ext_zbkx = true;
+    cpu->cfg.ext_zknd = true;
+    cpu->cfg.ext_zkne = true;
+    cpu->cfg.ext_zknh = true;
+    cpu->cfg.ext_zksed = true;
+    cpu->cfg.ext_zksh = true;
+    cpu->cfg.ext_svinval = true;
+
+    cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
+
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
+#endif
+}
+
 #ifdef CONFIG_TCG
 static void rv128_base_cpu_init(Object *obj)
 {
@@ -3050,6 +3078,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
 #ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
 #endif /* CONFIG_TCG */
-- 
2.34.1


