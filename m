Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1CD7988F4
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:39:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeccb-0005oi-SB; Fri, 08 Sep 2023 10:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccJ-0005et-QL
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccG-00077f-Fa
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694183867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gN/x78zkCjmttDAG1vhbIHZqHUQBCvqc7tTYgYVzYY4=;
 b=YAMZ8BOSjqWQhNVi6SXSLkttuJfueIdNCXDOA8RoVy1/jtvM4YafbW47w10nPGxjQcSef9
 +WnztmaQEFegwEyrEJFQ1rrMH5B1NKk8+f8O/THHCL79kReA+6PZmky6uk5OZg6C+C8TTd
 kWLDyLjh0omD4HHLqXl/NoNYen2FN/Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-iP4E2jIuPFC_Vj_R8MhPZA-1; Fri, 08 Sep 2023 10:37:44 -0400
X-MC-Unique: iP4E2jIuPFC_Vj_R8MhPZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13D323C0E472;
 Fri,  8 Sep 2023 14:37:44 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE27140E962;
 Fri,  8 Sep 2023 14:37:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
Subject: [PATCH 01/11] qdev: Add qdev_prop_set_array()
Date: Fri,  8 Sep 2023 16:36:52 +0200
Message-ID: <20230908143703.172758-2-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-1-kwolf@redhat.com>
References: <20230908143703.172758-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Instead of exposing the ugly hack of how we represent arrays in qdev (a
static "foo-len" property and after it is set, dynamically created
"foo[i]" properties) to boards, add an interface that allows setting the
whole array at once.

Once all internal users of devices with array properties have been
converted to use this function, we can change the implementation to move
away from this hack.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/qdev-properties.h |  3 +++
 hw/core/qdev-properties.c    | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index e1df08876c..7fa2fdb7c9 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -206,6 +206,9 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
                            const uint8_t *value);
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 
+/* Takes ownership of @values */
+void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
+
 void *object_field_prop_ptr(Object *obj, Property *prop);
 
 void qdev_prop_register_global(GlobalProperty *prop);
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 357b8761b5..950ef48e01 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -3,12 +3,14 @@
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qlist.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qdev-prop-internal.h"
+#include "qom/qom-qobject.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -739,6 +741,25 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
                             &error_abort);
 }
 
+void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
+{
+    const QListEntry *entry;
+    g_autofree char *prop_len = g_strdup_printf("len-%s", name);
+    uint32_t i = 0;
+
+    object_property_set_int(OBJECT(dev), prop_len, qlist_size(values),
+                            &error_abort);
+
+    QLIST_FOREACH_ENTRY(values, entry) {
+        g_autofree char *prop_idx = g_strdup_printf("%s[%u]", name, i);
+        object_property_set_qobject(OBJECT(dev), prop_idx, entry->value,
+                                    &error_abort);
+        i++;
+    }
+
+    qobject_unref(values);
+}
+
 static GPtrArray *global_props(void)
 {
     static GPtrArray *gp;
-- 
2.41.0


