Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF137DBBBF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:28:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTEn-0006Se-0k; Mon, 30 Oct 2023 10:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTEk-0006S5-NM
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTEj-0007Rs-7m
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698676044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Nh7LRVfsl9YAjGff1groILXBi4cvNuGdRdclQstIG8=;
 b=PxuRZJjShBEI8k2654hMOBcmK4RDrOLQpk9Ekorxgs/6oX0XDwK4Wp7z6fm7QNG/IZI3gN
 KLNiUNqZC/MUvawI7g4NwRl5CKjN7qyhgcUfM2YM6P0Cgv99JHakvwee93QxgaaSX38bSf
 xiPM7ENG76qlrPtxyEykV3PPj0AokEM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-TEY_0i9fNLamqfxM8ksgNg-1; Mon, 30 Oct 2023 10:27:12 -0400
X-MC-Unique: TEY_0i9fNLamqfxM8ksgNg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70EC2101A52D;
 Mon, 30 Oct 2023 14:27:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A1DA492BE0;
 Mon, 30 Oct 2023 14:27:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 05/12] hw/arm/sbsa-ref: Use qdev_prop_set_array()
Date: Mon, 30 Oct 2023 15:26:51 +0100
Message-ID: <20231030142658.182193-6-kwolf@redhat.com>
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
 hw/arm/sbsa-ref.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e8a82618f0..6cf913300d 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -48,6 +48,7 @@
 #include "hw/char/pl011.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "net/net.h"
+#include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 
 #define RAMLIMIT_GB 8192
@@ -436,6 +437,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
     SysBusDevice *gicbusdev;
     const char *gictype;
     uint32_t redist0_capacity, redist0_count;
+    QList *redist_region_count;
     int i;
 
     gictype = gicv3_class_name();
@@ -454,8 +456,9 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
                 sbsa_ref_memmap[SBSA_GIC_REDIST].size / GICV3_REDIST_SIZE;
     redist0_count = MIN(smp_cpus, redist0_capacity);
 
-    qdev_prop_set_uint32(sms->gic, "len-redist-region-count", 1);
-    qdev_prop_set_uint32(sms->gic, "redist-region-count[0]", redist0_count);
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, redist0_count);
+    qdev_prop_set_array(sms->gic, "redist-region-count", redist_region_count);
 
     object_property_set_link(OBJECT(sms->gic), "sysmem",
                              OBJECT(mem), &error_fatal);
-- 
2.41.0


