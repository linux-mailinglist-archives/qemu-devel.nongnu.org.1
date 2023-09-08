Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 187987988F8
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:39:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeccf-0005vS-AR; Fri, 08 Sep 2023 10:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccP-0005kj-TT
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccN-00079M-OC
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694183874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vlbOC4oGOGeEU2j2KiZMeSRmOxWKk8y7VJU+mcI9Dc=;
 b=Z1JhnrUzsMraRoSVT4NLaYPhonBdhq2/9nMYw1vPAupg/JA/OGXyQtXUWX6dLI1Yp2NLdJ
 LDnYlPWPiSHsu6prBbYvLM+SvK3tTzbZn8Ap3kWqsdd/mXqLnfDsmzLL5aV3rWNYn5Hr/4
 OaFEei7AnhtpgDVP9UbKcZhONVwSqck=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-X4rgFHUeOCu_t3DuUoZINw-1; Fri, 08 Sep 2023 10:37:50 -0400
X-MC-Unique: X4rgFHUeOCu_t3DuUoZINw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 513AD281CC20;
 Fri,  8 Sep 2023 14:37:50 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CD6F140E962;
 Fri,  8 Sep 2023 14:37:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
Subject: [PATCH 06/11] hw/arm/vexpress: Use qdev_prop_set_array()
Date: Fri,  8 Sep 2023 16:36:57 +0200
Message-ID: <20230908143703.172758-7-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-1-kwolf@redhat.com>
References: <20230908143703.172758-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of manually setting "foo-len" and "foo[i]" properties, build a
QList and use the new qdev_prop_set_array() helper to set the whole
array property with a single call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/arm/vexpress.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 56abadd9b8..7c7af0a9cb 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -43,6 +43,7 @@
 #include "hw/cpu/a15mpcore.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
+#include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
@@ -551,6 +552,7 @@ static void vexpress_common_init(MachineState *machine)
     ram_addr_t vram_size, sram_size;
     MemoryRegion *sysmem = get_system_memory();
     const hwaddr *map = daughterboard->motherboard_map;
+    QList *db_voltage, *db_clock;
     int i;
 
     daughterboard->init(vms, machine->ram_size, machine->cpu_type, pic);
@@ -591,20 +593,19 @@ static void vexpress_common_init(MachineState *machine)
     sysctl = qdev_new("realview_sysctl");
     qdev_prop_set_uint32(sysctl, "sys_id", sys_id);
     qdev_prop_set_uint32(sysctl, "proc_id", daughterboard->proc_id);
-    qdev_prop_set_uint32(sysctl, "len-db-voltage",
-                         daughterboard->num_voltage_sensors);
+
+    db_voltage = qlist_new();
     for (i = 0; i < daughterboard->num_voltage_sensors; i++) {
-        char *propname = g_strdup_printf("db-voltage[%d]", i);
-        qdev_prop_set_uint32(sysctl, propname, daughterboard->voltages[i]);
-        g_free(propname);
+        qlist_append_int(db_voltage, daughterboard->voltages[i]);
     }
-    qdev_prop_set_uint32(sysctl, "len-db-clock",
-                         daughterboard->num_clocks);
+    qdev_prop_set_array(sysctl, "db-voltage", db_voltage);
+
+    db_clock = qlist_new();
     for (i = 0; i < daughterboard->num_clocks; i++) {
-        char *propname = g_strdup_printf("db-clock[%d]", i);
-        qdev_prop_set_uint32(sysctl, propname, daughterboard->clocks[i]);
-        g_free(propname);
+        qlist_append_int(db_clock, daughterboard->clocks[i]);
     }
+    qdev_prop_set_array(sysctl, "db-clock", db_clock);
+
     sysbus_realize_and_unref(SYS_BUS_DEVICE(sysctl), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, map[VE_SYSREGS]);
 
-- 
2.41.0


