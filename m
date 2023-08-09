Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9FA775584
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:35:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTedI-0003dU-LJ; Wed, 09 Aug 2023 04:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedG-0003d2-Jd
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:30 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedC-0001mJ-Qn
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:28 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 3E81944026;
 Wed,  9 Aug 2023 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691570004; bh=Zeg8+GrrND4Zup6VHzwKgrMCrHbmMy0kXOkxjD1xPa0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XyJRQ9/NGWMtIrdqseMKQ4qWGlFliEAW22BSWfPicTu4DCXYne+wOydVBFGs/bPfI
 L2yanUJOAOv8iuAOnowaikJEfXwfqv6dWwMNZMDOGsPrEA48sCvhjcyhWUk7mPviG3
 svnKDSotqBi95htJ2DrkAJsjCpXOO7l+SrIAJcqY=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH v5 02/11] target/loongarch: Add new object class for
 loongarch32 cpus
Date: Wed,  9 Aug 2023 16:26:30 +0800
Message-ID: <20230809083258.1787464-3-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083258.1787464-1-c@jia.je>
References: <20230809083258.1787464-1-c@jia.je>
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
2.41.0


