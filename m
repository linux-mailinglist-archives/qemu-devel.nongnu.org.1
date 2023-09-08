Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6267988F9
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeccd-0005sr-Te; Fri, 08 Sep 2023 10:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccL-0005ie-TV
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccJ-00078H-Jj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694183870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXqGEMBIzhUEnijGoV5TEpk1X/j23KZWYFtOHXVuOpQ=;
 b=FVt+HGr9eNgop+v7fXfUw6dH6ltOHoViIX89A7tlLaqtP6y8IFqQXs2AWd3HmHvph/cRJm
 4j7cNhYVeehic6o4NJQ399rTHXLm1R8djpzHGkoNApAZCqYRt5pFNsYNV6e7yKklRiTI8B
 a2hLtZpnutLwUW28gfaZbHFeZ9Jbonk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-2ad4dDm5Mxu6Dkmgn3oC_w-1; Fri, 08 Sep 2023 10:37:49 -0400
X-MC-Unique: 2ad4dDm5Mxu6Dkmgn3oC_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AAF3948FEE;
 Fri,  8 Sep 2023 14:37:49 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15664140E962;
 Fri,  8 Sep 2023 14:37:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
Subject: [PATCH 05/11] hw/arm/sbsa-ref: Use qdev_prop_set_array()
Date: Fri,  8 Sep 2023 16:36:56 +0200
Message-ID: <20230908143703.172758-6-kwolf@redhat.com>
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
 hw/arm/sbsa-ref.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index bc89eb4806..354c1a037d 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -46,6 +46,7 @@
 #include "hw/char/pl011.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "net/net.h"
+#include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 
 #define RAMLIMIT_GB 8192
@@ -441,6 +442,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
     SysBusDevice *gicbusdev;
     const char *gictype;
     uint32_t redist0_capacity, redist0_count;
+    QList *redist_region_count;
     int i;
 
     gictype = gicv3_class_name();
@@ -459,8 +461,9 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
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


