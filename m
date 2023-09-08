Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C66A7988FD
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecce-0005uM-NX; Fri, 08 Sep 2023 10:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccQ-0005l9-Ji
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccN-00079U-Or
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694183874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rbf4uwtAqXl7GsAOLz54dF4jC8RLbokt3ceTEwkS1xA=;
 b=EBoPXKRGi8fN/JNz0eoXwvpLNRfL5jIAyk2Qv0hMmKBcD3A6WwR/5cNF0M3WIY3ZrjFabd
 Ms4uFXbq5rJbXHc8FquS3Sz8OMqPaVcIZnBDmxwMbavOgFvyViIuaNKEGC4xUwLJjC0ELp
 VaM023kUYwnYOSjwfNSZjKe3WVEaVVc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-7Q4VS2wzMTmY_sHutk109Q-1; Fri, 08 Sep 2023 10:37:53 -0400
X-MC-Unique: 7Q4VS2wzMTmY_sHutk109Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFCE0281CC20;
 Fri,  8 Sep 2023 14:37:52 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAB2F140E962;
 Fri,  8 Sep 2023 14:37:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
Subject: [PATCH 08/11] hw/arm/xlnx-versal: Use qdev_prop_set_array()
Date: Fri,  8 Sep 2023 16:36:59 +0200
Message-ID: <20230908143703.172758-9-kwolf@redhat.com>
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

Instead of manually setting "foo-len" and "foo[i]" properties, build a
QList and use the new qdev_prop_set_array() helper to set the whole
array property with a single call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/arm/xlnx-versal.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 60bf5fe657..fe2a810f9f 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
@@ -69,6 +70,7 @@ static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
     };
     SysBusDevice *gicbusdev;
     DeviceState *gicdev;
+    QList *redist_region_count;
     int nr_apu_cpus = ARRAY_SIZE(s->fpd.apu.cpu);
     int i;
 
@@ -79,8 +81,11 @@ static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
     qdev_prop_set_uint32(gicdev, "revision", 3);
     qdev_prop_set_uint32(gicdev, "num-cpu", nr_apu_cpus);
     qdev_prop_set_uint32(gicdev, "num-irq", XLNX_VERSAL_NR_IRQS + 32);
-    qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
-    qdev_prop_set_uint32(gicdev, "redist-region-count[0]", nr_apu_cpus);
+
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, nr_apu_cpus);
+    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+
     qdev_prop_set_bit(gicdev, "has-security-extensions", true);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->fpd.apu.gic), &error_fatal);
-- 
2.41.0


