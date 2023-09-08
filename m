Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E887988FA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeccd-0005sw-VD; Fri, 08 Sep 2023 10:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccK-0005ex-Jl
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccI-00078A-BR
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694183869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bOvMM4Dv9HP2GSEX/cl5xEIAhUooEA8Y3WJZMe/UxN4=;
 b=K13bOe2xT1dzGuFEK93NMxp7BtnQNYZVDvqZlq4bqy28XSi4A2Lw6NKVdMkecnQ/rs/uYO
 Bicj+yszPtUto6lFAETV01jVQgpj9bSLm8JFK/6quoOeUWoa7AdUVJjQzEvWOXcGV9jBwy
 FclRbOfB7PdQgz1BkS+SlyaUaZCn2ZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-B21O53XHNeGXQ-V6gvr9XA-1; Fri, 08 Sep 2023 10:37:48 -0400
X-MC-Unique: B21O53XHNeGXQ-V6gvr9XA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2A6B800969;
 Fri,  8 Sep 2023 14:37:47 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAA22140E962;
 Fri,  8 Sep 2023 14:37:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
Subject: [PATCH 04/11] hw/arm/mps2: Use qdev_prop_set_array()
Date: Fri,  8 Sep 2023 16:36:55 +0200
Message-ID: <20230908143703.172758-5-kwolf@redhat.com>
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
 hw/arm/mps2.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index d92fd60684..292a180ad2 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -48,6 +48,7 @@
 #include "net/net.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "hw/qdev-clock.h"
+#include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 
 typedef enum MPS2FPGAType {
@@ -138,6 +139,7 @@ static void mps2_common_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     DeviceState *armv7m, *sccdev;
+    QList *oscclk;
     int i;
 
     if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
@@ -402,10 +404,12 @@ static void mps2_common_init(MachineState *machine)
     qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
     /* All these FPGA images have the same OSCCLK configuration */
-    qdev_prop_set_uint32(sccdev, "len-oscclk", 3);
-    qdev_prop_set_uint32(sccdev, "oscclk[0]", 50000000);
-    qdev_prop_set_uint32(sccdev, "oscclk[1]", 24576000);
-    qdev_prop_set_uint32(sccdev, "oscclk[2]", 25000000);
+    oscclk = qlist_new();
+    qlist_append_int(oscclk, 50000000);
+    qlist_append_int(oscclk, 24576000);
+    qlist_append_int(oscclk, 25000000);
+    qdev_prop_set_array(sccdev, "oscclk", oscclk);
+
     sysbus_realize(SYS_BUS_DEVICE(&mms->scc), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sccdev), 0, 0x4002f000);
     object_initialize_child(OBJECT(mms), "fpgaio",
-- 
2.41.0


