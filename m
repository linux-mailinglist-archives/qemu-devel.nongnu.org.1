Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB75773801
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 07:45:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTFVM-00056f-Tw; Tue, 08 Aug 2023 01:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTFVI-00053Q-CT
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 01:43:36 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTFVG-0003qK-Js
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 01:43:35 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id C7EDD43E34;
 Tue,  8 Aug 2023 05:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691473412; bh=RhvYQMAhwfqQwXvHRfnnmFB8gjdsLVfep/cj+pEIKQM=;
 h=From:To:Cc:Subject:Date;
 b=YFOlbeEAoMTaFE7H4KzUZ/Ud8P0jYv5q3+LosSLQJ9CWo4tePnTV+VHk1LsHKDNq3
 Z/ABVfVS9rZvSmfWkJHeMHhHK89HiLh8JBPp46A8KUNX20uFZ3hI6VMzVEjTegHW/c
 CoYQbREhwpj5c6Q1a8sQXcypIOSXHP0RDgLT8ue0=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/loongarch: Split fcc register to fcc0-7 in gdbstub
Date: Tue,  8 Aug 2023 13:42:47 +0800
Message-ID: <20230808054315.3391465-1-c@jia.je>
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

Since GDB 13.1(GDB commit ea3352172), GDB LoongArch changed to use
fcc0-7 instead of fcc register. This commit partially reverts commit
2f149c759 (`target/loongarch: Update gdb_set_fpu() and gdb_get_fpu()`)
to match the behavior of GDB.

Note that it is a breaking change for GDB 13.0 or earlier, but it is
also required for GDB 13.1 or later to work.

Signed-off-by: Jiajie Chen <c@jia.je>
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
index 0752fff924..15ad6778f1 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -70,10 +70,9 @@ static int loongarch_gdb_get_fpu(CPULoongArchState *env,
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
@@ -87,11 +86,10 @@ static int loongarch_gdb_set_fpu(CPULoongArchState *env,
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
2.41.0


