Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9567B7E4105
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:49:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MSE-0008MB-D5; Tue, 07 Nov 2023 08:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0MS8-00082i-VH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0MS6-0007RA-Pn
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2i2nunhfPHqaGNtnGc+CfAIME4c3JurbLNEsQvtE70k=;
 b=ZTNIce7dRs1BGwHi0nEIzvKFaxMfx+yxby0SJEsLK0tHd2e3+Y0Djt8CwQ9xH9lKq0fVHw
 4+q6pu4r97FknKZuE8SRTt/pQtHWK9ZCxMi9VZOPS3Ho7oXDF5OiPJNLNmumCB6B09Jm+f
 c1/7gjYx+1c6LUffVf5q/Qo49RZkT7s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-QaBcYxeHP_6Vhoqvp_1vzA-1; Tue, 07 Nov 2023 08:48:59 -0500
X-MC-Unique: QaBcYxeHP_6Vhoqvp_1vzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83DE5810F4E
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 13:48:49 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A73071C060C0;
 Tue,  7 Nov 2023 13:48:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 05/11] hw/arm/vexpress: Use qdev_prop_set_array()
Date: Tue,  7 Nov 2023 14:48:22 +0100
Message-ID: <20231107134828.35909-6-kwolf@redhat.com>
In-Reply-To: <20231107134828.35909-1-kwolf@redhat.com>
References: <20231107134828.35909-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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
Message-ID: <20231030142658.182193-7-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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


