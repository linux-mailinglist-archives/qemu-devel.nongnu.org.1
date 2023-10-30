Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8947DBBD0
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:29:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTF2-0006g2-Tk; Mon, 30 Oct 2023 10:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTF1-0006ey-4r
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTEz-0007T5-N8
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698676061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kauf56gKhhGQOPxh/hOUPnSQ+Nmj1rjCyhwGalKsxHk=;
 b=bBtWOcZ7FFMO15NQjTETuov++DcYRr4nFmLjTvmZG6GhYXBk8gnIFV0e1o/cpGBdEu65YP
 7XQXaXKtN08dxXCKgD5xRIqSMi9VGCohYvutAgRo9KPeq9seCGKSVpT/y+jXIuzbm1bwyd
 NiIjlrxqmzs0GNehU3rjFaaQ7RYRXOQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-0PWm2fSvOfmosIjGk9JcKQ-1; Mon, 30 Oct 2023 10:27:31 -0400
X-MC-Unique: 0PWm2fSvOfmosIjGk9JcKQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42969830968;
 Mon, 30 Oct 2023 14:27:16 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 379F2492BE7;
 Mon, 30 Oct 2023 14:27:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 08/12] hw/arm/xlnx-versal: Use qdev_prop_set_array()
Date: Mon, 30 Oct 2023 15:26:54 +0100
Message-ID: <20231030142658.182193-9-kwolf@redhat.com>
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
 hw/arm/xlnx-versal.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index fa556d8764..d0f6235d4f 100644
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


