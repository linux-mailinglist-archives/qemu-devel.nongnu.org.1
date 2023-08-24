Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09289786BAA
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:25:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6Zu-0003cA-3F; Thu, 24 Aug 2023 05:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6Zq-0003TP-9Q
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6Zk-0003N4-ME
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:29 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxc_C+IedkOnkbAA--.56248S3;
 Thu, 24 Aug 2023 17:24:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S7; 
 Thu, 24 Aug 2023 17:24:14 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/31] target/loongarch: Extract 64-bit specifics to
 loongarch64_cpu_class_init
Date: Thu, 24 Aug 2023 17:23:43 +0800
Message-Id: <20230824092409.1492470-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S7
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Extract loongarch64 specific code from loongarch_cpu_class_init()
to a new loongarch64_cpu_class_init().

In preparation of supporting loongarch32 cores, rename these
functions using the '64' suffix.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230821125959.28666-6-philmd@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 34d6c5a31d..6384bda1bd 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -695,11 +695,6 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
 };
 #endif
 
-static gchar *loongarch_gdb_arch_name(CPUState *cs)
-{
-    return g_strdup("loongarch64");
-}
-
 static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 {
     LoongArchCPUClass *lacc = LOONGARCH_CPU_CLASS(c);
@@ -724,16 +719,27 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     cc->disas_set_info = loongarch_cpu_disas_set_info;
     cc->gdb_read_register = loongarch_cpu_gdb_read_register;
     cc->gdb_write_register = loongarch_cpu_gdb_write_register;
-    cc->gdb_num_core_regs = 35;
-    cc->gdb_core_xml_file = "loongarch-base64.xml";
     cc->gdb_stop_before_watchpoint = true;
-    cc->gdb_arch_name = loongarch_gdb_arch_name;
 
 #ifdef CONFIG_TCG
     cc->tcg_ops = &loongarch_tcg_ops;
 #endif
 }
 
+static gchar *loongarch64_gdb_arch_name(CPUState *cs)
+{
+    return g_strdup("loongarch64");
+}
+
+static void loongarch64_cpu_class_init(ObjectClass *c, void *data)
+{
+    CPUClass *cc = CPU_CLASS(c);
+
+    cc->gdb_num_core_regs = 35;
+    cc->gdb_core_xml_file = "loongarch-base64.xml";
+    cc->gdb_arch_name = loongarch64_gdb_arch_name;
+}
+
 #define DEFINE_LOONGARCH_CPU_TYPE(size, model, initfn) \
     { \
         .parent = TYPE_LOONGARCH##size##_CPU, \
@@ -757,6 +763,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .parent = TYPE_LOONGARCH_CPU,
 
         .abstract = true,
+        .class_init = loongarch64_cpu_class_init,
     },
     DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
 };
-- 
2.39.1


