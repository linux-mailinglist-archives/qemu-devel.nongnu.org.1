Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E40B77E7098
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:44:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r194B-0003o1-Rb; Thu, 09 Nov 2023 12:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r1946-0003nK-2f
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r193s-0004qe-28
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699551803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6oukEQynlH7BlRx8yX7T3FjaA2rs5RzSQk4YXaTzuUg=;
 b=GkmHdlJeHuOtnvXZtdXuqPHRvMgNX4VjK1MmzhzWBHWaDyXvGn9BxWJkOn1snUb4mFunps
 evLBJQiZJAR39nfFZZShfqX8L0sXJ9BNneiM5OESQOvxgSvPmqSfUgIzIYiUHEUfsQm0up
 NEqboX7ixI4KYZgq8zNsqKkGPa6dwp4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-OYYaGS9DOBuKQOpYxpbU6g-1; Thu, 09 Nov 2023 12:43:20 -0500
X-MC-Unique: OYYaGS9DOBuKQOpYxpbU6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB147821AE8;
 Thu,  9 Nov 2023 17:43:19 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A117A20268F8;
 Thu,  9 Nov 2023 17:43:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v3 08/11] hw/rx/rx62n: Use qdev_prop_set_array()
Date: Thu,  9 Nov 2023 18:42:37 +0100
Message-ID: <20231109174240.72376-9-kwolf@redhat.com>
In-Reply-To: <20231109174240.72376-1-kwolf@redhat.com>
References: <20231109174240.72376-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Instead of manually setting "foo-len" and "foo[i]" properties, build a
QList and use the new qdev_prop_set_array() helper to set the whole
array property with a single call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rx/rx62n.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index d00fcb0ef0..4dc44afd9d 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
+#include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 
 /*
@@ -130,22 +131,22 @@ static void register_icu(RX62NState *s)
 {
     int i;
     SysBusDevice *icu;
+    QList *ipr_map, *trigger_level;
 
     object_initialize_child(OBJECT(s), "icu", &s->icu, TYPE_RX_ICU);
     icu = SYS_BUS_DEVICE(&s->icu);
-    qdev_prop_set_uint32(DEVICE(icu), "len-ipr-map", NR_IRQS);
+
+    ipr_map = qlist_new();
     for (i = 0; i < NR_IRQS; i++) {
-        char propname[32];
-        snprintf(propname, sizeof(propname), "ipr-map[%d]", i);
-        qdev_prop_set_uint32(DEVICE(icu), propname, ipr_table[i]);
+        qlist_append_int(ipr_map, ipr_table[i]);
     }
-    qdev_prop_set_uint32(DEVICE(icu), "len-trigger-level",
-                         ARRAY_SIZE(levelirq));
+    qdev_prop_set_array(DEVICE(icu), "ipr-map", ipr_map);
+
+    trigger_level = qlist_new();
     for (i = 0; i < ARRAY_SIZE(levelirq); i++) {
-        char propname[32];
-        snprintf(propname, sizeof(propname), "trigger-level[%d]", i);
-        qdev_prop_set_uint32(DEVICE(icu), propname, levelirq[i]);
+        qlist_append_int(trigger_level, levelirq[i]);
     }
+    qdev_prop_set_array(DEVICE(icu), "trigger-level", trigger_level);
 
     for (i = 0; i < NR_IRQS; i++) {
         s->irq[i] = qdev_get_gpio_in(DEVICE(icu), i);
-- 
2.41.0


