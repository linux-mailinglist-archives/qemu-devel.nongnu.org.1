Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A67E4129
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:51:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MS9-0007vU-G0; Tue, 07 Nov 2023 08:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0MRp-0007rP-HH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0MRn-0007KZ-PX
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7y0cNDsqHl5M2QoqjYfqz/hZPdY3sTuJi8yDXOn4l0=;
 b=VH9FJ0B74nBgYj1cmYOKI+0ftl7YRYh5n+EpVenjzvJSrjp1Sn9FeJe3UmwUF5w5Tfeabn
 6WN1AwTT9XNBcbZJ1I0scSUmkHvuXkzwm/LtZsqcLQnor3W4hWEmpVEmlp+u5/S+22Rmrw
 N0ZDpWNLe5xLmHOfT9Q2sLRIJiM+778=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-5FTqEhmiMN6jcT9WPtp4kg-1; Tue, 07 Nov 2023 08:48:49 -0500
X-MC-Unique: 5FTqEhmiMN6jcT9WPtp4kg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8207410138B0
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 13:48:48 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5ED01C008C3;
 Tue,  7 Nov 2023 13:48:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 04/11] hw/arm/sbsa-ref: Use qdev_prop_set_array()
Date: Tue,  7 Nov 2023 14:48:21 +0100
Message-ID: <20231107134828.35909-5-kwolf@redhat.com>
In-Reply-To: <20231107134828.35909-1-kwolf@redhat.com>
References: <20231107134828.35909-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-ID: <20231030142658.182193-6-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/arm/sbsa-ref.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index bce44690e5..f3c9704693 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -48,6 +48,7 @@
 #include "hw/char/pl011.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "net/net.h"
+#include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 
 #define RAMLIMIT_GB 8192
@@ -437,6 +438,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
     SysBusDevice *gicbusdev;
     const char *gictype;
     uint32_t redist0_capacity, redist0_count;
+    QList *redist_region_count;
     int i;
 
     gictype = gicv3_class_name();
@@ -455,8 +457,9 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
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


