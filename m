Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4997E70A2
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:44:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r193u-0003Zp-BD; Thu, 09 Nov 2023 12:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r193r-0003Vf-5R
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r193o-0004pY-K5
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699551799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jGv7DS2LHokUiH6THWx3W7sjEWwoWUbt6/lYpfDoxeE=;
 b=L20lHm9Ua3oI/EOPVnC/NXpawougkIMOxdxIi+jRlQoYG5+hUKgDsPdQs3LHSX0uehXHz4
 8NUlWMAJZmwr+LBeUgaFUPUWzrV3Lat0j0VC/FKbHvFo0QTDAmZc9LB9KmxUy5xKBahsje
 rjd7ryV5/XZFlUflC9PmC1FCvrR+hX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-IgATwmZSM0mQQwEwTxWlYw-1; Thu, 09 Nov 2023 12:43:16 -0500
X-MC-Unique: IgATwmZSM0mQQwEwTxWlYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E26BA811E7E;
 Thu,  9 Nov 2023 17:43:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D762A20268F8;
 Thu,  9 Nov 2023 17:43:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v3 05/11] hw/arm/vexpress: Use qdev_prop_set_array()
Date: Thu,  9 Nov 2023 18:42:34 +0100
Message-ID: <20231109174240.72376-6-kwolf@redhat.com>
In-Reply-To: <20231109174240.72376-1-kwolf@redhat.com>
References: <20231109174240.72376-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/arm/vexpress.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index c08ea34e92..fd981f4c33 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -43,6 +43,7 @@
 #include "hw/cpu/a15mpcore.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
+#include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 #include "audio/audio.h"
 
@@ -544,6 +545,7 @@ static void vexpress_common_init(MachineState *machine)
     ram_addr_t vram_size, sram_size;
     MemoryRegion *sysmem = get_system_memory();
     const hwaddr *map = daughterboard->motherboard_map;
+    QList *db_voltage, *db_clock;
     int i;
 
     daughterboard->init(vms, machine->ram_size, machine->cpu_type, pic);
@@ -584,20 +586,19 @@ static void vexpress_common_init(MachineState *machine)
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


