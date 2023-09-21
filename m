Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEB07A953E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 16:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjKfe-0004qs-MV; Thu, 21 Sep 2023 10:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lu.Gao@verisilicon.com>)
 id 1qjKfc-0004qV-8J
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 10:28:44 -0400
Received: from shasxm06.verisilicon.com ([101.89.135.45]
 helo=shasxm03.verisilicon.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <Lu.Gao@verisilicon.com>)
 id 1qjKfX-0005gn-J0
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 10:28:44 -0400
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=Verisilicon.com; s=default;
 c=simple/simple; t=1695305813; h=from:subject:to:date:message-id;
 bh=G9QiXhfeHm9a9VUJ1s2FhfY2iWlPEVdz61WfyPp/s2A=;
 b=T/ZgwM3rdK9EO507WA2/eHOx8+m+Xe1zLSqsDP6y879ZEvYZ+lyVB4Sirmq8kydQs14SuPvRMbd
 LLGPsHl1IP/hFocT0or4k1LpfHHKxp6NyMyeinbVjI0tYZ2+zuH4FiuwByaIsV33wz8aKmmU97K1J
 2LyfNF9m7YJ8Hm7+f4o=
Received: from coding0919.verisilicon.com (192.168.103.179) by
 SHASXM06.verisilicon.com (10.10.128.205) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 21 Sep 2023 22:16:53 +0800
From: Lu Gao <lu.gao@verisilicon.com>
To: <qemu-devel@nongnu.org>
CC: "Gao, Lu" <lu.gao@verisilicon.com>, Jianxian Wen
 <jianxian.wen@verisilicon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>
Subject: [PATCH] qom/object_interfaces: Handle `len-` property first
Date: Thu, 21 Sep 2023 22:16:34 +0800
Message-ID: <20230921141634.26233-1-lu.gao@verisilicon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [192.168.103.179]
Received-SPF: pass client-ip=101.89.135.45;
 envelope-from=Lu.Gao@verisilicon.com; helo=shasxm03.verisilicon.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Gao, Lu" <lu.gao@verisilicon.com>

Array property needs corresponding `len-` property set first to add
actual array properties. Then we need to make sure `len-` property is
set first before array property.

But when the model is used with like
`-device driver[,prop[=value][,...]]`
in QEMU command line options, this is not guaranteed in current
property set from qdict. Array property might be
handled before 'len-' property, then leads to an error.

Signed-off-by: Lu Gao <lu.gao@verisilicon.com>
Signed-off-by: Jianxian Wen <jianxian.wen@verisilicon.com>
---
 qom/object_interfaces.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 7d31589b04..87500401a4 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -18,6 +18,7 @@
 #include "qapi/opts-visitor.h"
 #include "qemu/config-file.h"
 #include "qemu/keyval.h"
+#include "hw/qdev-properties.h"
 
 bool user_creatable_complete(UserCreatable *uc, Error **errp)
 {
@@ -52,8 +53,22 @@ static void object_set_properties_from_qdict(Object *obj, const QDict *qdict,
         return;
     }
     for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
-        if (!object_property_set(obj, e->key, v, errp)) {
-            goto out;
+        /* set "len-" first for the array props to be allocated first */
+        if (strncmp(e->key, PROP_ARRAY_LEN_PREFIX,
+                    strlen(PROP_ARRAY_LEN_PREFIX)) == 0) {
+            if (!object_property_set(obj, e->key, v, errp)) {
+                goto out;
+            }
+        }
+    }
+
+    for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
+        /* "len-" has been set above */
+        if (strncmp(e->key, PROP_ARRAY_LEN_PREFIX,
+                    strlen(PROP_ARRAY_LEN_PREFIX)) != 0) {
+            if (!object_property_set(obj, e->key, v, errp)) {
+                goto out;
+            }
         }
     }
     visit_check_struct(v, errp);
-- 
2.17.1


