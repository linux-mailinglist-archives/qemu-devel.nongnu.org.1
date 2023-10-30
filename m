Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB847DBBC7
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:28:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTEc-0006PM-45; Mon, 30 Oct 2023 10:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTEa-0006O9-3Q
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTEY-0007Q5-2T
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698676033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OciqrmI4PMIefAHi47Le2UsALowmiqepzrCHCJbie00=;
 b=VilDi34p8qNDOQHRx7uOu7k02Hf35+EeeqtL65OH8xqiA+5UYAoTok99TPd9iZDR/7oaU8
 I1YJc/hSdqxGrp6RaGx0htb4rRy90Y6oqUOG652fa3olVvs+68UjfGGAiXaC4jbcEbh7ds
 zhSl/QwCSjYtvk5aOJjgu+eEtjdMuig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-D-o934IMM--3GxP-HZ7wUQ-1; Mon, 30 Oct 2023 10:27:10 -0400
X-MC-Unique: D-o934IMM--3GxP-HZ7wUQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5746185A782;
 Mon, 30 Oct 2023 14:27:09 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCA32492BE0;
 Mon, 30 Oct 2023 14:27:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 03/12] hw/arm/mps2-tz: Use qdev_prop_set_array()
Date: Mon, 30 Oct 2023 15:26:49 +0100
Message-ID: <20231030142658.182193-4-kwolf@redhat.com>
In-Reply-To: <20231030142658.182193-1-kwolf@redhat.com>
References: <20231030142658.182193-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Instead of manually setting "foo-len" and "foo[i]" properties, build a
QList and use the new qdev_prop_set_array() helper to set the whole
array property with a single call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index eae3639da2..668db5ed61 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -48,6 +48,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
@@ -461,6 +462,7 @@ static MemoryRegion *make_scc(MPS2TZMachineState *mms, void *opaque,
     MPS2SCC *scc = opaque;
     DeviceState *sccdev;
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_GET_CLASS(mms);
+    QList *oscclk;
     uint32_t i;
 
     object_initialize_child(OBJECT(mms), "scc", scc, TYPE_MPS2_SCC);
@@ -469,11 +471,13 @@ static MemoryRegion *make_scc(MPS2TZMachineState *mms, void *opaque,
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
     qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
-    qdev_prop_set_uint32(sccdev, "len-oscclk", mmc->len_oscclk);
+
+    oscclk = qlist_new();
     for (i = 0; i < mmc->len_oscclk; i++) {
-        g_autofree char *propname = g_strdup_printf("oscclk[%u]", i);
-        qdev_prop_set_uint32(sccdev, propname, mmc->oscclk[i]);
+        qlist_append_int(oscclk, mmc->oscclk[i]);
     }
+    qdev_prop_set_array(sccdev, "oscclk", oscclk);
+
     sysbus_realize(SYS_BUS_DEVICE(scc), &error_fatal);
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(sccdev), 0);
 }
-- 
2.41.0


