Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 459FC8B03D6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXby-0006oR-1K; Wed, 24 Apr 2024 04:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbU-0005pl-0W
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbR-0003n7-CV
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tBjyp0E/07wS0Jc5eeRlzA54hufibhGrggWJ/rIYtA=;
 b=RH8bNaLJRr8KBpVt9w5Do+6Q1lQZKAxSaXI7X9z6dYw3u1OXocW5V7Ly+FCSV5VrVPsLLo
 wrR+r7WL28vyuSrlE3K8gXOsaC7fVLgzvsRwZRUwdMHP1Whze86DviRnQjg7hZrQBHPre6
 c/W6SbM0cqsAnyohqJJ65hfMbfC+0CY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-AWiPDqQrNY-2h2qAoeFYiA-1; Wed,
 24 Apr 2024 04:03:38 -0400
X-MC-Unique: AWiPDqQrNY-2h2qAoeFYiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4745A1C03151;
 Wed, 24 Apr 2024 08:03:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 281A5C01595;
 Wed, 24 Apr 2024 08:03:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B15021E6690; Wed, 24 Apr 2024 10:03:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 02/10] qapi: Inline and remove QERR_BUS_NO_HOTPLUG definition
Date: Wed, 24 Apr 2024 10:03:29 +0200
Message-ID: <20240424080337.2782594-3-armbru@redhat.com>
In-Reply-To: <20240424080337.2782594-1-armbru@redhat.com>
References: <20240424080337.2782594-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using sed, and manual cleanup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240312141343.3168265-3-armbru@redhat.com>
---
 include/qapi/qmp/qerror.h | 3 ---
 hw/ppc/spapr_pci.c        | 5 ++---
 system/qdev-monitor.c     | 8 +++++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 0c2689cf8a..06a1d2248e 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_BUS_NO_HOTPLUG \
-    "Bus '%s' does not support hotplugging"
-
 #define QERR_DEVICE_HAS_NO_MEDIUM \
     "Device '%s' has no medium"
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 25e0295d6f..72cfba419a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -39,7 +39,6 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "qapi/qmp/qerror.h"
 #include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
@@ -1554,7 +1553,7 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
          * we need to let them know it's not enabled
          */
         if (plugged_dev->hotplugged) {
-            error_setg(errp, QERR_BUS_NO_HOTPLUG,
+            error_setg(errp, "Bus '%s' does not support hotplugging",
                        phb->parent_obj.bus->qbus.name);
             return;
         }
@@ -1675,7 +1674,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
 
     if (!phb->dr_enabled) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG,
+        error_setg(errp, "Bus '%s' does not support hotplugging",
                    phb->parent_obj.bus->qbus.name);
         return;
     }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 840177d19f..2ae1460e21 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -660,7 +660,8 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
 
     if (qdev_should_hide_device(opts, from_json, errp)) {
         if (bus && !qbus_is_hotpluggable(bus)) {
-            error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
+            error_setg(errp, "Bus '%s' does not support hotplugging",
+                       bus->name);
         }
         return NULL;
     } else if (*errp) {
@@ -668,7 +669,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     if (phase_check(PHASE_MACHINE_READY) && bus && !qbus_is_hotpluggable(bus)) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
+        error_setg(errp, "Bus '%s' does not support hotplugging", bus->name);
         return NULL;
     }
 
@@ -910,7 +911,8 @@ void qdev_unplug(DeviceState *dev, Error **errp)
     }
 
     if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
+        error_setg(errp, "Bus '%s' does not support hotplugging",
+                   dev->parent_bus->name);
         return;
     }
 
-- 
2.44.0


