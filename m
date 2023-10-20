Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6FC7D11F6
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 16:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtqvD-00084x-IC; Fri, 20 Oct 2023 10:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtqvB-00084i-5n
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 10:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtqv9-0006Zd-EN
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 10:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697813774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fm6ZfqtbcPQ64q/GdVK1WReohKuqyxsC2CxRMCoZxMA=;
 b=aLN0AImniWmHE8DRkp/b9wZfGUr6LZaR3p9Lu7X2Nt/R1mccgMb+16QBK/97BumKSJ3xbK
 QWG7XmbYnibdqp3BeQsFiYePVvXMyMC0K81a1YfJTW2D7dXVvlkZhghBiuFPYbVtktXGOY
 98PEgxFi5zBMk7alfDvWLS1Y8Xeu8g0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-yAgHaNamNkSBRozkZCdsvQ-1; Fri,
 20 Oct 2023 10:55:57 -0400
X-MC-Unique: yAgHaNamNkSBRozkZCdsvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AFD51C0515F;
 Fri, 20 Oct 2023 14:55:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67CCB2166B26;
 Fri, 20 Oct 2023 14:55:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <minyard@acm.org>,
	Juan Quintela <quintela@redhat.com>
Subject: [PATCH] hw/ipmi: Don't call vmstate_register() from instance_init()
 functions
Date: Fri, 20 Oct 2023 16:55:54 +0200
Message-ID: <20231020145554.662751-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

instance_init() can be called multiple times, e.g. during introspection
of the device. We should not install the vmstate handlers here. Do it
in the realize() function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 29 +++++++++++------------
 hw/ipmi/isa_ipmi_bt.c     | 34 +++++++++++++--------------
 hw/ipmi/isa_ipmi_kcs.c    | 48 +++++++++++++++++++--------------------
 3 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index e232d35ba2..2117dad35a 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -453,19 +453,6 @@ static void ipmi_bmc_extern_handle_reset(IPMIBmc *b)
     continue_send(ibe);
 }
 
-static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
-{
-    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(dev);
-
-    if (!qemu_chr_fe_backend_connected(&ibe->chr)) {
-        error_setg(errp, "IPMI external bmc requires chardev attribute");
-        return;
-    }
-
-    qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
-                             chr_event, NULL, ibe, NULL, true);
-}
-
 static int ipmi_bmc_extern_post_migrate(void *opaque, int version_id)
 {
     IPMIBmcExtern *ibe = opaque;
@@ -499,12 +486,26 @@ static const VMStateDescription vmstate_ipmi_bmc_extern = {
     }
 };
 
+static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
+{
+    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(dev);
+
+    if (!qemu_chr_fe_backend_connected(&ibe->chr)) {
+        error_setg(errp, "IPMI external bmc requires chardev attribute");
+        return;
+    }
+
+    qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
+                             chr_event, NULL, ibe, NULL, true);
+
+    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
+}
+
 static void ipmi_bmc_extern_init(Object *obj)
 {
     IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(obj);
 
     ibe->extern_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeout, ibe);
-    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
 }
 
 static void ipmi_bmc_extern_finalize(Object *obj)
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index a83e7243d6..aec064d3cd 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -68,6 +68,21 @@ static void isa_ipmi_bt_lower_irq(IPMIBT *ib)
     qemu_irq_lower(iib->irq);
 }
 
+static const VMStateDescription vmstate_ISAIPMIBTDevice = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-bt",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    /*
+     * Version 1 had messed up the array transfer, it's not even usable
+     * because it used VMSTATE_VBUFFER_UINT32, but it did not transfer
+     * the buffer length, so random things would happen.
+     */
+    .fields      = (VMStateField[]) {
+        VMSTATE_STRUCT(bt, ISAIPMIBTDevice, 1, vmstate_IPMIBT, IPMIBT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
 {
     Error *err = NULL;
@@ -102,30 +117,15 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, iib->bt.io_base, iib->bt.io_length);
 
     isa_register_ioport(isadev, &iib->bt.io, iib->bt.io_base);
-}
 
-static const VMStateDescription vmstate_ISAIPMIBTDevice = {
-    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-bt",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    /*
-     * Version 1 had messed up the array transfer, it's not even usable
-     * because it used VMSTATE_VBUFFER_UINT32, but it did not transfer
-     * the buffer length, so random things would happen.
-     */
-    .fields      = (VMStateField[]) {
-        VMSTATE_STRUCT(bt, ISAIPMIBTDevice, 1, vmstate_IPMIBT, IPMIBT),
-        VMSTATE_END_OF_LIST()
-    }
-};
+    vmstate_register(NULL, 0, &vmstate_ISAIPMIBTDevice, dev);
+}
 
 static void isa_ipmi_bt_init(Object *obj)
 {
     ISAIPMIBTDevice *iib = ISA_IPMI_BT(obj);
 
     ipmi_bmc_find_and_link(obj, (Object **) &iib->bt.bmc);
-
-    vmstate_register(NULL, 0, &vmstate_ISAIPMIBTDevice, iib);
 }
 
 static void *isa_ipmi_bt_get_backend_data(IPMIInterface *ii)
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index b2ed70b9da..b5dcb64616 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -67,6 +67,24 @@ static void isa_ipmi_kcs_lower_irq(IPMIKCS *ik)
     qemu_irq_lower(iik->irq);
 }
 
+static bool vmstate_kcs_before_version2(void *opaque, int version)
+{
+    return version <= 1;
+}
+
+static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
+    .name = TYPE_IPMI_INTERFACE,
+    .version_id = 2,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_VSTRUCT_TEST(kcs, ISAIPMIKCSDevice, vmstate_kcs_before_version2,
+                             0, vmstate_IPMIKCS, IPMIKCS, 1),
+        VMSTATE_VSTRUCT_V(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS,
+                          IPMIKCS, 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void ipmi_isa_realize(DeviceState *dev, Error **errp)
 {
     Error *err = NULL;
@@ -101,38 +119,20 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, iik->kcs.io_base, iik->kcs.io_length);
 
     isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
-}
 
-static bool vmstate_kcs_before_version2(void *opaque, int version)
-{
-    return version <= 1;
+    /*
+     * Version 1 had an incorrect name, it clashed with the BT
+     * IPMI device, so receive it, but transmit a different
+     * version.
+     */
+    vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
 }
 
-static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
-    .name = TYPE_IPMI_INTERFACE,
-    .version_id = 2,
-    .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
-        VMSTATE_VSTRUCT_TEST(kcs, ISAIPMIKCSDevice, vmstate_kcs_before_version2,
-                             0, vmstate_IPMIKCS, IPMIKCS, 1),
-        VMSTATE_VSTRUCT_V(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS,
-                          IPMIKCS, 2),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static void isa_ipmi_kcs_init(Object *obj)
 {
     ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(obj);
 
     ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
-
-    /*
-     * Version 1 had an incorrect name, it clashed with the BT
-     * IPMI device, so receive it, but transmit a different
-     * version.
-     */
-    vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
 }
 
 static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
-- 
2.41.0


