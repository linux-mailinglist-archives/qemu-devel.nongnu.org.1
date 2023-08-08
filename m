Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC5C773614
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBwp-0002aa-2w; Mon, 07 Aug 2023 21:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBwm-0002a4-UQ
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:55:45 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBwk-0003dV-P9
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:55:44 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id BF17043F4C;
 Tue,  8 Aug 2023 01:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691459741; bh=2c3vHFINLH9H5Hfqun4P9Qhp0YDac7L0yGbQpgGcxNg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ROWLPsJ/2qLb2Xerpn+S4UaNvUmjnK5UiWwiD6Yy9Lu86jk9H1QoucOzJqN0i0mVp
 BAo/Su9USSBRf5BOmNMz9qmsLwHwSzFd+yYXxXR0cbAR5v/TDIUvz9s0LvrFV6HJUF
 d8gonGK+HBylrOHS0xEstS1q870eZN1SxpY4wDDU=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>
Subject: [PATCH v4 02/11] target/loongarch: Add new object class for
 loongarch32 cpus
Date: Tue,  8 Aug 2023 09:54:28 +0800
Message-ID: <20230808015506.1705140-3-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808015506.1705140-1-c@jia.je>
References: <20230808015506.1705140-1-c@jia.je>
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

Add object class for future loongarch32 cpus. It is derived from the
loongarch64 object class.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.c | 24 ++++++++++++++++++++++++
 target/loongarch/cpu.h | 11 +++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ad93ecac92..3bd293d00a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -732,6 +732,10 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 #endif
 }
 
+static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
+{
+}
+
 #define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
     { \
         .parent = TYPE_LOONGARCH_CPU, \
@@ -754,3 +758,23 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)
+
+#define DEFINE_LOONGARCH32_CPU_TYPE(model, initfn) \
+    { \
+        .parent = TYPE_LOONGARCH32_CPU, \
+        .instance_init = initfn, \
+        .name = LOONGARCH_CPU_TYPE_NAME(model), \
+    }
+
+static const TypeInfo loongarch32_cpu_type_infos[] = {
+    {
+        .name = TYPE_LOONGARCH32_CPU,
+        .parent = TYPE_LOONGARCH_CPU,
+        .instance_size = sizeof(LoongArchCPU),
+
+        .abstract = true,
+        .class_size = sizeof(LoongArchCPUClass),
+        .class_init = loongarch32_cpu_class_init,
+    },
+};
+DEFINE_TYPES(loongarch32_cpu_type_infos)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index bf0da8d5b4..396869c3b6 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -404,6 +404,17 @@ struct LoongArchCPUClass {
     ResettablePhases parent_phases;
 };
 
+#define TYPE_LOONGARCH32_CPU "loongarch32-cpu"
+typedef struct LoongArch32CPUClass LoongArch32CPUClass;
+DECLARE_CLASS_CHECKERS(LoongArch32CPUClass, LOONGARCH32_CPU,
+                       TYPE_LOONGARCH32_CPU)
+
+struct LoongArch32CPUClass {
+    /*< private >*/
+    LoongArchCPUClass parent_class;
+    /*< public >*/
+};
+
 /*
  * LoongArch CPUs has 4 privilege levels.
  * 0 for kernel mode, 3 for user mode.
-- 
2.41.0


