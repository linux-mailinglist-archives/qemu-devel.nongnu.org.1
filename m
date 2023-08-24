Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30891786BCF
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6bm-0003N1-Dk; Thu, 24 Aug 2023 05:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6bT-0003Ep-Aa
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:26:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6bO-0004D6-Gj
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:26:10 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxd+jIIedko3kbAA--.20150S3;
 Thu, 24 Aug 2023 17:24:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S32; 
 Thu, 24 Aug 2023 17:24:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>
Subject: [PULL 30/31] target/loongarch: Split fcc register to fcc0-7 in gdbstub
Date: Thu, 24 Aug 2023 17:24:08 +0800
Message-Id: <20230824092409.1492470-31-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S32
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

From: Jiajie Chen <c@jia.je>

Since GDB 13.1(GDB commit ea3352172), GDB LoongArch changed to use
fcc0-7 instead of fcc register. This commit partially reverts commit
2f149c759 (`target/loongarch: Update gdb_set_fpu() and gdb_get_fpu()`)
to match the behavior of GDB.

Note that it is a breaking change for GDB 13.0 or earlier, but it is
also required for GDB 13.1 or later to work.

Signed-off-by: Jiajie Chen <c@jia.je>
Acked-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20230808054315.3391465-1-c@jia.je>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 gdb-xml/loongarch-fpu.xml  |  9 ++++++++-
 target/loongarch/gdbstub.c | 16 +++++++---------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/gdb-xml/loongarch-fpu.xml b/gdb-xml/loongarch-fpu.xml
index 78e42cf5dd..e81e3382e7 100644
--- a/gdb-xml/loongarch-fpu.xml
+++ b/gdb-xml/loongarch-fpu.xml
@@ -45,6 +45,13 @@
   <reg name="f29" bitsize="64" type="fputype" group="float"/>
   <reg name="f30" bitsize="64" type="fputype" group="float"/>
   <reg name="f31" bitsize="64" type="fputype" group="float"/>
-  <reg name="fcc" bitsize="64" type="uint64" group="float"/>
+  <reg name="fcc0" bitsize="8" type="uint8" group="float"/>
+  <reg name="fcc1" bitsize="8" type="uint8" group="float"/>
+  <reg name="fcc2" bitsize="8" type="uint8" group="float"/>
+  <reg name="fcc3" bitsize="8" type="uint8" group="float"/>
+  <reg name="fcc4" bitsize="8" type="uint8" group="float"/>
+  <reg name="fcc5" bitsize="8" type="uint8" group="float"/>
+  <reg name="fcc6" bitsize="8" type="uint8" group="float"/>
+  <reg name="fcc7" bitsize="8" type="uint8" group="float"/>
   <reg name="fcsr" bitsize="32" type="uint32" group="float"/>
 </feature>
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index e20b20f99b..b09804b62f 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -88,10 +88,9 @@ static int loongarch_gdb_get_fpu(CPULoongArchState *env,
 {
     if (0 <= n && n < 32) {
         return gdb_get_reg64(mem_buf, env->fpr[n].vreg.D(0));
-    } else if (n == 32) {
-        uint64_t val = read_fcc(env);
-        return gdb_get_reg64(mem_buf, val);
-    } else if (n == 33) {
+    } else if (32 <= n && n < 40) {
+        return gdb_get_reg8(mem_buf, env->cf[n - 32]);
+    } else if (n == 40) {
         return gdb_get_reg32(mem_buf, env->fcsr0);
     }
     return 0;
@@ -105,11 +104,10 @@ static int loongarch_gdb_set_fpu(CPULoongArchState *env,
     if (0 <= n && n < 32) {
         env->fpr[n].vreg.D(0) = ldq_p(mem_buf);
         length = 8;
-    } else if (n == 32) {
-        uint64_t val = ldq_p(mem_buf);
-        write_fcc(env, val);
-        length = 8;
-    } else if (n == 33) {
+    } else if (32 <= n && n < 40) {
+        env->cf[n - 32] = ldub_p(mem_buf);
+        length = 1;
+    } else if (n == 40) {
         env->fcsr0 = ldl_p(mem_buf);
         length = 4;
     }
-- 
2.39.1


