Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6C57D0AE4
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlCd-0006L5-AW; Fri, 20 Oct 2023 04:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qtlCb-0006Ke-1P
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:49:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qtlCV-0008G4-Bu
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:49:52 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxTesXPzJl124zAA--.29000S3;
 Fri, 20 Oct 2023 16:49:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxiuQSPzJlyiAsAA--.29649S5; 
 Fri, 20 Oct 2023 16:49:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com, peter.maydell@linaro.org,
 eblake@redhat.com, armbru@redhat.com, maobibo@loongson.cn
Subject: [PATCH v3 3/3] target/loongarch: Implement query-cpu-model-expansion
Date: Fri, 20 Oct 2023 16:49:25 +0800
Message-Id: <20231020084925.3457084-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231020084925.3457084-1-gaosong@loongson.cn>
References: <20231020084925.3457084-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxiuQSPzJlyiAsAA--.29649S5
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

Add support for the query-cpu-model-expansion QMP command to LoongArch.
We support query the cpu features.

  e.g
    la464 and max cpu support LSX/LASX, default enable,
    la132 not support LSX/LASX.

    1. start with '-cpu max,lasx=off'

    (QEMU) query-cpu-model-expansion type=static  model={"name":"max"}
    {"return": {"model": {"name": "max", "props": {"lasx": false, "lsx": true}}}}

    2. start with '-cpu la464,lasx=off'
    (QEMU) query-cpu-model-expansion type=static  model={"name":"la464"}
    {"return": {"model": {"name": "max", "props": {"lasx": false, "lsx": true}}}

    3. start with '-cpu la132,lasx=off'
    qemu-system-loongarch64: can't apply global la132-loongarch-cpu.lasx=off: Property 'la132-loongarch-cpu.lasx' not found

    4. start with '-cpu max,lasx=off' or start with '-cpu la464,lasx=off' query cpu model la132
    (QEMU) query-cpu-model-expansion type=static  model={"name":"la132"}
    {"return": {"model": {"name": "la132"}}}

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 qapi/machine-target.json              |  6 ++-
 target/loongarch/loongarch-qmp-cmds.c | 64 +++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index f0a6b72414..752b18cced 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -228,7 +228,8 @@
   'data': { 'model': 'CpuModelInfo' },
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
-                   'TARGET_ARM' ] } }
+                   'TARGET_ARM',
+                   'TARGET_LOONGARCH64' ] } }
 
 ##
 # @query-cpu-model-expansion:
@@ -273,7 +274,8 @@
   'returns': 'CpuModelExpansionInfo',
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
-                   'TARGET_ARM' ] } }
+                   'TARGET_ARM',
+                   'TARGET_LOONGARCH64' ] } }
 
 ##
 # @CpuDefinitionInfo:
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 6c25957881..645672ff59 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -7,8 +7,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "cpu.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qom/qom-qobject.h"
 
 static void loongarch_cpu_add_definition(gpointer data, gpointer user_data)
 {
@@ -35,3 +40,62 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
     return cpu_list;
 }
+
+static const char *cpu_model_advertised_features[] = {
+    "lsx", "lasx", NULL
+};
+
+CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                                                     CpuModelInfo *model,
+                                                     Error **errp)
+{
+    CpuModelExpansionInfo *expansion_info;
+    QDict *qdict_out;
+    ObjectClass *oc;
+    Object *obj;
+    const char *name;
+    int i;
+
+    if (type != CPU_MODEL_EXPANSION_TYPE_STATIC) {
+        error_setg(errp, "The requested expansion type is not supported");
+        return NULL;
+    }
+
+    oc = cpu_class_by_name(TYPE_LOONGARCH_CPU, model->name);
+    if (!oc) {
+        error_setg(errp, "The CPU type '%s' is not a recognized LoongArch CPU type",
+                   model->name);
+        return NULL;
+    }
+
+    obj = object_new(object_class_get_name(oc));
+
+    expansion_info = g_new0(CpuModelExpansionInfo, 1);
+    expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
+    expansion_info->model->name = g_strdup(model->name);
+
+    qdict_out = qdict_new();
+
+    i = 0;
+    while ((name = cpu_model_advertised_features[i++]) != NULL) {
+        ObjectProperty *prop = object_property_find(obj, name);
+        if (prop) {
+            QObject *value;
+
+            assert(prop->get);
+            value = object_property_get_qobject(obj, name, &error_abort);
+
+            qdict_put_obj(qdict_out, name, value);
+        }
+    }
+
+    if (!qdict_size(qdict_out)) {
+        qobject_unref(qdict_out);
+    } else {
+        expansion_info->model->props = QOBJECT(qdict_out);
+    }
+
+    object_unref(obj);
+
+    return expansion_info;
+}
-- 
2.25.1


