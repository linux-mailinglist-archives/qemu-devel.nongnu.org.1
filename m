Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA7C77F363
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWZMF-00010W-I6; Thu, 17 Aug 2023 05:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qWZLw-0006RU-UZ
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qWZLr-0002Yj-L2
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:40 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxRvHw6N1kS3UZAA--.52296S3;
 Thu, 17 Aug 2023 17:31:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSPs6N1kjKdcAA--.12060S4; 
 Thu, 17 Aug 2023 17:31:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, philmd@linaro.org,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, yijun@loongson.cn,
 shenjinyang@loongson.cn
Subject: [PATCH v3 02/18] target/loongarch: Add new object class for
 loongarch32 cpus
Date: Thu, 17 Aug 2023 17:31:05 +0800
Message-Id: <20230817093121.1053890-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230817093121.1053890-1-gaosong@loongson.cn>
References: <20230817093121.1053890-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSPs6N1kjKdcAA--.12060S4
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

Add object class for future loongarch32 cpus. It is derived from the
loongarch64 object class.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 19 +++++++++++++++++++
 target/loongarch/cpu.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ad93ecac92..c6b73444b4 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -732,12 +732,22 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 #endif
 }
 
+static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
+{
+}
+
 #define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
     { \
         .parent = TYPE_LOONGARCH_CPU, \
         .instance_init = initfn, \
         .name = LOONGARCH_CPU_TYPE_NAME(model), \
     }
+#define DEFINE_LOONGARCH32_CPU_TYPE(model, initfn) \
+    { \
+        .parent = TYPE_LOONGARCH32_CPU, \
+        .instance_init = initfn, \
+        .name = LOONGARCH_CPU_TYPE_NAME(model), \
+    }
 
 static const TypeInfo loongarch_cpu_type_infos[] = {
     {
@@ -750,6 +760,15 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .class_size = sizeof(LoongArchCPUClass),
         .class_init = loongarch_cpu_class_init,
     },
+    {
+        .name = TYPE_LOONGARCH32_CPU,
+        .parent = TYPE_LOONGARCH_CPU,
+        .instance_size = sizeof(LoongArchCPU),
+
+        .abstract = true,
+        .class_size = sizeof(LoongArchCPUClass),
+        .class_init = loongarch32_cpu_class_init,
+    },
     DEFINE_LOONGARCH_CPU_TYPE("la464", loongarch_la464_initfn),
 };
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 5a71d64a04..2af4c414b0 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -382,6 +382,7 @@ struct ArchCPU {
 };
 
 #define TYPE_LOONGARCH_CPU "loongarch-cpu"
+#define TYPE_LOONGARCH32_CPU "loongarch32-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(LoongArchCPU, LoongArchCPUClass,
                         LOONGARCH_CPU)
-- 
2.39.1


