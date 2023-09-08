Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FEE7988F7
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeccX-0005kR-Ub; Fri, 08 Sep 2023 10:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccK-0005ew-GY
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccH-000785-V7
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694183869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FV0XJ/1gQlrDEcN3YkpLUuKIvHxKCLAYMZJOOHKSzc0=;
 b=E01lDMrUuDjoGLGPmKu8rh1+9fgn6EXpBT7TWW1QHbh/3UKPCB7SfiIfKjKGH7BESVErSp
 l9hblIXyJd8Az7rnGCUv59P5aqFnfoJWki371S3pjyJWRN/Vvr/CkmL+uhfCh+OOlsnK5Q
 nEX94rHnMO03sX4deIW8SYj6jKI9YLs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-UgOI-6fCOw2uW-u-Rwl0eQ-1; Fri, 08 Sep 2023 10:37:45 -0400
X-MC-Unique: UgOI-6fCOw2uW-u-Rwl0eQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58F47281CC23;
 Fri,  8 Sep 2023 14:37:45 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A509140E962;
 Fri,  8 Sep 2023 14:37:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
Subject: [PATCH 02/11] hw/i386/pc: Use qdev_prop_set_array()
Date: Fri,  8 Sep 2023 16:36:53 +0200
Message-ID: <20230908143703.172758-3-kwolf@redhat.com>
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
 hw/i386/pc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 54838c0c41..0e84e454cb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,6 +81,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/visitor.h"
 #include "hw/core/cpu.h"
 #include "hw/usb.h"
@@ -1508,9 +1509,10 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
                                               VIRTIO_IOMMU_RESV_MEM_T_MSI);
 
-        object_property_set_uint(OBJECT(dev), "len-reserved-regions", 1, errp);
-        object_property_set_str(OBJECT(dev), "reserved-regions[0]",
-                                resv_prop_str, errp);
+        QList *reserved_regions = qlist_new();
+        qlist_append_str(reserved_regions, resv_prop_str);
+        qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
+
         g_free(resv_prop_str);
     }
 
-- 
2.41.0


