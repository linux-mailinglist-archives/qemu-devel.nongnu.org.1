Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 495DD7EC6ED
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:14:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3HaN-00047q-Gh; Wed, 15 Nov 2023 10:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3HZl-0003uh-3z
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3HZe-0003G7-Hh
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700061174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOhJPPcnT8CXmET/U4fU6CBNjKcfyHQ7CBakNpC48zE=;
 b=XR19/nJY+DAEy0QkC49QI5ndc1jukh5w8/QvMhXqj2QLjruGmqjmhGiJiS5XNt0fj+BTr5
 XQ8tG1i1fJn6viEYjx2cyrGZKq8kXf9I/KSLHz0a+toWOtQrqVQXFYTyudt8XI063fnGag
 Zd8BMUK5eZKTnL03ZrrRPyGYobcT3yM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-bB4xzy9jMemIXWvGXvX61g-1; Wed,
 15 Nov 2023 10:12:50 -0500
X-MC-Unique: bB4xzy9jMemIXWvGXvX61g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62CDD3C100A8;
 Wed, 15 Nov 2023 15:12:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDE1D1C060AE;
 Wed, 15 Nov 2023 15:12:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E99A8180AC13; Wed, 15 Nov 2023 16:12:42 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 graf@amazon.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 09/16] hw/uefi: add support for storing persistent variables
 on disk
Date: Wed, 15 Nov 2023 16:12:31 +0100
Message-ID: <20231115151242.184645-10-kraxel@redhat.com>
In-Reply-To: <20231115151242.184645-1-kraxel@redhat.com>
References: <20231115151242.184645-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Define qapi schema for the uefi variable store state.

Use it and the generated visitor helper functions to
store persistent variables in JSON format on disk.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-json.c | 194 +++++++++++++++++++++++++++++++++++++
 qapi/meson.build           |   1 +
 qapi/qapi-schema.json      |   1 +
 qapi/uefi.json             |  40 ++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 hw/uefi/var-service-json.c
 create mode 100644 qapi/uefi.json

diff --git a/hw/uefi/var-service-json.c b/hw/uefi/var-service-json.c
new file mode 100644
index 000000000000..d8d74945bbf1
--- /dev/null
+++ b/hw/uefi/var-service-json.c
@@ -0,0 +1,194 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - serialize non-volatile varstore from/to json,
+ *                    using qapi
+ *
+ * tools which can read/write these json files:
+ *  - https://gitlab.com/kraxel/virt-firmware
+ *  - https://github.com/awslabs/python-uefivars
+ */
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "sysemu/dma.h"
+
+#include "hw/uefi/var-service.h"
+
+#include "qapi/dealloc-visitor.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi/qmp/qobject.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qapi-types-uefi.h"
+#include "qapi/qapi-visit-uefi.h"
+
+static UefiVarStore *uefi_vars_to_qapi(uefi_vars_state *uv)
+{
+    static const char hex[] = {
+        '0', '1', '2', '3', '4', '5', '6', '7',
+        '8', '9', 'a', 'b', 'c', 'd', 'e', 'f',
+    };
+    UefiVarStore *vs;
+    UefiVariableList **tail;
+    UefiVariable *v;
+    QemuUUID be;
+    uefi_variable *var;
+    uint8_t *data;
+    unsigned int i;
+
+    vs = g_new0(UefiVarStore, 1);
+    vs->version = 2;
+    tail = &vs->variables;
+
+    QTAILQ_FOREACH(var, &uv->variables, next) {
+        if (!(var->attributes & EFI_VARIABLE_NON_VOLATILE)) {
+            continue;
+        }
+
+        v = g_new0(UefiVariable, 1);
+        be = qemu_uuid_bswap(var->guid);
+        v->guid = qemu_uuid_unparse_strdup(&be);
+        v->name = uefi_ucs2_to_ascii(var->name, var->name_size);
+        v->attr = var->attributes;
+
+        v->data = g_malloc(var->data_size * 2 + 1);
+        data = var->data;
+        for (i = 0; i < var->data_size * 2;) {
+            v->data[i++] = hex[*data >> 4];
+            v->data[i++] = hex[*data & 15];
+            data++;
+        }
+        v->data[i++] = 0;
+
+        QAPI_LIST_APPEND(tail, v);
+    }
+    return vs;
+}
+
+static unsigned parse_hexchar(char c)
+{
+    switch (c) {
+    case '0' ... '9': return c - '0';
+    case 'a' ... 'f': return c - 'a' + 0xa;
+    case 'A' ... 'F': return c - 'A' + 0xA;
+    default: return 0;
+    }
+}
+
+static void uefi_vars_from_qapi(uefi_vars_state *uv, UefiVarStore *vs)
+{
+    UefiVariableList *item;
+    UefiVariable *v;
+    QemuUUID be;
+    uefi_variable *var;
+    uint8_t *data;
+    size_t i, len;
+
+    for (item = vs->variables; item != NULL; item = item->next) {
+        v = item->value;
+
+        var = g_new0(uefi_variable, 1);
+        var->attributes = v->attr;
+        qemu_uuid_parse(v->guid, &be);
+        var->guid = qemu_uuid_bswap(be);
+
+        len = strlen(v->name);
+        var->name_size = len * 2 + 2;
+        var->name = g_malloc(var->name_size);
+        for (i = 0; i <= len; i++) {
+            var->name[i] = v->name[i];
+        }
+
+        len = strlen(v->data);
+        var->data_size = len / 2;
+        var->data = data = g_malloc(var->data_size);
+        for (i = 0; i < len; i += 2) {
+            *(data++) =
+                parse_hexchar(v->data[i]) << 4 |
+                parse_hexchar(v->data[i + 1]);
+        }
+
+        QTAILQ_INSERT_TAIL(&uv->variables, var, next);
+    }
+}
+
+static GString *uefi_vars_to_json(uefi_vars_state *uv)
+{
+    UefiVarStore *vs = uefi_vars_to_qapi(uv);
+    QObject *qobj = NULL;
+    Visitor *v;
+    GString *gstr;
+
+    v = qobject_output_visitor_new(&qobj);
+    if (visit_type_UefiVarStore(v, NULL, &vs, NULL)) {
+        visit_complete(v, &qobj);
+    }
+    visit_free(v);
+    qapi_free_UefiVarStore(vs);
+
+    gstr = qobject_to_json_pretty(qobj, true);
+    qobject_unref(qobj);
+
+    return gstr;
+}
+
+void uefi_vars_json_init(uefi_vars_state *uv, Error **errp)
+{
+    if (uv->jsonfile) {
+        uv->jsonfd = qemu_create(uv->jsonfile, O_RDWR, 0666, errp);
+    }
+}
+
+void uefi_vars_json_save(uefi_vars_state *uv)
+{
+    GString *gstr;
+
+    if (uv->jsonfd == -1) {
+        return;
+    }
+
+    gstr = uefi_vars_to_json(uv);
+
+    lseek(uv->jsonfd, 0, SEEK_SET);
+    write(uv->jsonfd, gstr->str, gstr->len);
+    ftruncate(uv->jsonfd, gstr->len);
+    fsync(uv->jsonfd);
+
+    g_string_free(gstr, true);
+}
+
+void uefi_vars_json_load(uefi_vars_state *uv, Error **errp)
+{
+    UefiVarStore *vs;
+    QObject *qobj;
+    Visitor *v;
+    char *str;
+    size_t len;
+
+    if (uv->jsonfd == -1) {
+        return;
+    }
+
+    len = lseek(uv->jsonfd, 0, SEEK_END);
+    if (len == 0) {
+        return;
+    }
+
+    str = g_malloc(len + 1);
+    lseek(uv->jsonfd, 0, SEEK_SET);
+    read(uv->jsonfd, str, len);
+    str[len] = 0;
+
+    qobj = qobject_from_json(str, errp);
+    v = qobject_input_visitor_new(qobj);
+    visit_type_UefiVarStore(v, NULL, &vs, errp);
+    visit_free(v);
+
+    if (!(*errp)) {
+        uefi_vars_from_qapi(uv, vs);
+    }
+
+    qapi_free_UefiVarStore(vs);
+    qobject_unref(qobj);
+    g_free(str);
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index f81a37565ca7..0cd1b1e0b2d1 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -64,6 +64,7 @@ if have_system
     'rdma',
     'rocker',
     'tpm',
+    'uefi',
   ]
 endif
 if have_system or have_tools
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index c01ec335e680..d169b4660b20 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -80,3 +80,4 @@
 { 'include': 'virtio.json' }
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
+{ 'include': 'uefi.json' }
diff --git a/qapi/uefi.json b/qapi/uefi.json
new file mode 100644
index 000000000000..152c4d404824
--- /dev/null
+++ b/qapi/uefi.json
@@ -0,0 +1,40 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+
+##
+# @UefiVariable:
+#
+# UEFI Variable
+#
+# @guid: variable namespace guid
+#
+# @name: variable name (utf-8)
+#
+# @attr: variable attributes
+#
+# @data: variable content (base64)
+#
+# Since: 9.0
+##
+{ 'struct' : 'UefiVariable',
+  'data' : { 'guid'  : 'str',
+             'name'  : 'str',
+             'attr'  : 'int',
+             'data'  : 'str',
+             '*time' : 'str'}}
+
+##
+# @UefiVarStore:
+#
+# UEFI Variable Store
+#
+# @version: 2
+#
+# @variables: list of uefi variables
+#
+# Since: 9.0
+##
+{ 'struct' : 'UefiVarStore',
+  'data' : { 'version'   : 'int',
+             'variables' : [ 'UefiVariable' ] }}
-- 
2.41.0


