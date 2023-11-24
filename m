Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926E7F78E2
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:26:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Z0C-000528-OY; Fri, 24 Nov 2023 11:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1r6Z02-00051j-Ej
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:25:50 -0500
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1r6Yzu-0004FP-Ap
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LWSY33kyDrgptNXIO5iBxZzuFgHX9QuzDTofovaZBDk=; b=L6LuQacKqoBleTKDGnVuug9zuM
 lsbKG4nI2KlKuHxyt64kKosfEoU2Rlly9JkiRyjBPOTwNbRiNLtJ+b5s++oWGzFi6WXse4dAARXvn
 wepQbcXXhrBf8RW0a4rNQIjOFJqavP4gfo79x0OmLcX9r2tHRNWpsqWVG9k4qKk05ml0MT8JN2xjb
 +4sp9++ilCEWZ33tZT7fPJBcoOND4YKYECL6QrNTvzOI202BvJCXnCrMzYOn3uHEIRlRhm17rYQCo
 G7+PCVa1Q4YZSZw+7mGQviV5bWwdcwZ4UVkLWPch5+od5vnC7yIcmX7/Dn8XT1xpIPc02zIQmsiCK
 XmQ7fasw==;
Received: from 186.pool62-37-3.static.orange.es ([62.37.3.186]
 helo=perseus.local) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1r6YzN-006ldX-Ih; Fri, 24 Nov 2023 17:25:09 +0100
Received: from berto by perseus.local with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1r6YzM-000WQu-20;
 Fri, 24 Nov 2023 17:25:08 +0100
From: Alberto Garcia <berto@igalia.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.0] qapi: Add 'recurse-children' option to qom-list
Date: Fri, 24 Nov 2023 17:24:43 +0100
Message-Id: <20231124162443.124654-1-berto@igalia.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This allows returning a tree of all object properties under a given
path, in a way similar to scripts/qmp/qom-tree.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 qapi/qom.json      | 10 +++++++++-
 qom/qom-hmp-cmds.c |  4 ++--
 qom/qom-qmp-cmds.c | 22 +++++++++++++++++++++-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index c53ef978ff..dfe3a20725 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -33,6 +33,10 @@
 #        qdev device type name.  Link properties form the device model
 #        graph.
 #
+# @children: if specified, a list of @ObjectPropertyInfo describing
+#     the child properties. This requires that this property's @type
+#     is of the form 'child<subtype>' (since 9.0)
+#
 # @description: if specified, the description of the property.
 #
 # @default-value: the default value, if any (since 5.0)
@@ -42,6 +46,7 @@
 { 'struct': 'ObjectPropertyInfo',
   'data': { 'name': 'str',
             'type': 'str',
+            '*children' :  [ 'ObjectPropertyInfo' ],
             '*description': 'str',
             '*default-value': 'any' } }
 
@@ -54,6 +59,9 @@
 # @path: the path within the object model.  See @qom-get for a
 #     description of this parameter.
 #
+# @recurse-children: if true, include the child properties recursively
+#     in the return value (default: false) (since 9.0)
+#
 # Returns: a list of @ObjectPropertyInfo that describe the properties
 #     of the object.
 #
@@ -69,7 +77,7 @@
 #                  { "name": "mon0", "type": "child<chardev-stdio>" } ] }
 ##
 { 'command': 'qom-list',
-  'data': { 'path': 'str' },
+  'data': { 'path': 'str', '*recurse-children': 'bool' },
   'returns': [ 'ObjectPropertyInfo' ],
   'allow-preconfig': true }
 
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 6e3a2175a4..7592184fc3 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -28,7 +28,7 @@ void hmp_qom_list(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    list = qmp_qom_list(path, &err);
+    list = qmp_qom_list(path, false, false, &err);
     if (err == NULL) {
         ObjectPropertyInfoList *start = list;
         while (list != NULL) {
@@ -206,7 +206,7 @@ void object_del_completion(ReadLineState *rs, int nb_args, const char *str)
     len = strlen(str);
     readline_set_completion_index(rs, len);
 
-    start = list = qmp_qom_list("/objects", NULL);
+    start = list = qmp_qom_list("/objects", false, false, NULL);
     while (list) {
         ObjectPropertyInfo *info = list->value;
 
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 7c087299de..5c9cb8a09c 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -28,10 +28,15 @@
 #include "qom/object_interfaces.h"
 #include "qom/qom-qobject.h"
 
-ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
+ObjectPropertyInfoList *qmp_qom_list(const char *path,
+                                     bool has_recurse_children,
+                                     bool recurse_children,
+                                     Error **errp)
 {
+    ERRP_GUARD();
     Object *obj;
     bool ambiguous = false;
+    bool recurse = has_recurse_children && recurse_children;
     ObjectPropertyInfoList *props = NULL;
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
@@ -55,8 +60,23 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
 
         value->name = g_strdup(prop->name);
         value->type = g_strdup(prop->type);
+
+        if (recurse && g_str_has_prefix(prop->type, "child<")) {
+            ObjectPropertyInfoList *children;
+            g_autofree char *childpath = g_strdup_printf("%s/%s", path,
+                                                         prop->name);
+            children = qmp_qom_list(childpath, true, true, errp);
+            if (*errp) {
+                qapi_free_ObjectPropertyInfoList(props);
+                props = NULL;
+                goto out;
+            }
+            value->has_children = true;
+            value->children = children;
+        }
     }
 
+out:
     return props;
 }
 
-- 
2.39.2


