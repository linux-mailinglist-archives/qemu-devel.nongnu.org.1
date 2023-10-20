Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0957D0AE2
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:50:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlCe-0006Ly-4J; Fri, 20 Oct 2023 04:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qtlCb-0006L7-NS
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:49:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qtlCV-0008Fn-Br
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:49:53 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx5_ETPzJl0G4zAA--.34006S3;
 Fri, 20 Oct 2023 16:49:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxiuQSPzJlyiAsAA--.29649S3; 
 Fri, 20 Oct 2023 16:49:23 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com, peter.maydell@linaro.org,
 eblake@redhat.com, armbru@redhat.com, maobibo@loongson.cn
Subject: [PATCH v3 1/3] target/loongarch: Add cpu model 'max'
Date: Fri, 20 Oct 2023 16:49:23 +0800
Message-Id: <20231020084925.3457084-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231020084925.3457084-1-gaosong@loongson.cn>
References: <20231020084925.3457084-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxiuQSPzJlyiAsAA--.29649S3
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

We use cpu la464 for the 'max' cpu.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ef1bf89dac..ef6922e812 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -474,6 +474,12 @@ static void loongarch_la132_initfn(Object *obj)
     env->cpucfg[1] = data;
 }
 
+static void loongarch_max_initfn(Object *obj)
+{
+    /* '-cpu max' for TCG: we use cpu la464. */
+    loongarch_la464_initfn(obj);
+}
+
 static void loongarch_cpu_list_entry(gpointer data, gpointer user_data)
 {
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
@@ -829,6 +835,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
     },
     DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
+    DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)
-- 
2.25.1


