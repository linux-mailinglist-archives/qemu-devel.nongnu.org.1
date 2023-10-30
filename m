Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D97DBBC0
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:28:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTEw-0006XX-W8; Mon, 30 Oct 2023 10:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTEt-0006W3-Kr
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTEr-0007SN-5d
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698676052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cPSMrQyF+ZfhCod2UAA8jILoDC+1v7SKTGn2Mnzdcko=;
 b=fh9g3QHg1wHAfc+LjJ9G7B/P+c8EWl/tcN1erR39iYVjagL5bZ4QXUc2HAqQIoet/oRf7X
 PbrSoy79CIdXliXUUUqKBai+aQa7TGa73tsVotoYJwcDgodFO9OOMmSJEq3Gg2iQz0qL6M
 ytPmAF70J+U3C/N6qBkT9bgbr1Vr1FE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-kii939R3Mdqe2uZ_btJVTg-1; Mon, 30 Oct 2023 10:27:14 -0400
X-MC-Unique: kii939R3Mdqe2uZ_btJVTg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2D1498D3B2;
 Mon, 30 Oct 2023 14:27:13 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7AB4492BE0;
 Mon, 30 Oct 2023 14:27:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 06/12] hw/arm/vexpress: Use qdev_prop_set_array()
Date: Mon, 30 Oct 2023 15:26:52 +0100
Message-ID: <20231030142658.182193-7-kwolf@redhat.com>
In-Reply-To: <20231030142658.182193-1-kwolf@redhat.com>
References: <20231030142658.182193-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/vexpress.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 8ff37f52ca..eb720f6de7 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -43,6 +43,7 @@
 #include "hw/cpu/a15mpcore.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
+#include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 #include "audio/audio.h"
 
@@ -552,6 +553,7 @@ static void vexpress_common_init(MachineState *machine)
     ram_addr_t vram_size, sram_size;
     MemoryRegion *sysmem = get_system_memory();
     const hwaddr *map = daughterboard->motherboard_map;
+    QList *db_voltage, *db_clock;
     int i;
 
     daughterboard->init(vms, machine->ram_size, machine->cpu_type, pic);
@@ -592,20 +594,19 @@ static void vexpress_common_init(MachineState *machine)
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


