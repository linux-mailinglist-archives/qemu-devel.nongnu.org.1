Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9833A7D5136
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHGM-0001aO-Ph; Tue, 24 Oct 2023 09:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHFz-0001BF-Us
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHFw-0001ly-OH
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698153335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hrQbpcQmjkjZUwzY0IzeCAEPzEo5tGlkuI99YW2Hnk=;
 b=SE5e4zGH9dHwQ0Dfl2q3BSVS1JVzxpTpHMRmryKDS2NsYEYcygWqup8zfd+B0HxmiA74p3
 9faV/tadSbPUKRofsm4nVn9Sfjt4mUE4egWb5UINKWSqmVwgsCqZu6EkbeFrsCa6KPNmXW
 XCU96BwyqnE5K8uC9yteUqDTUJux3eA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-ruQFYi6AMxypqk9Nu_6TGg-1; Tue, 24 Oct 2023 09:15:16 -0400
X-MC-Unique: ruQFYi6AMxypqk9Nu_6TGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38B4F811E86;
 Tue, 24 Oct 2023 13:15:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB2841C060AE;
 Tue, 24 Oct 2023 13:15:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Corey Minyard <minyard@acm.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 libvir-list@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 18/39] hw/ipmi: Don't call vmstate_register() from
 instance_init() functions
Date: Tue, 24 Oct 2023 15:12:44 +0200
Message-ID: <20231024131305.87468-19-quintela@redhat.com>
In-Reply-To: <20231024131305.87468-1-quintela@redhat.com>
References: <20231024131305.87468-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

instance_init() can be called multiple times, e.g. during introspection
of the device. We should not install the vmstate handlers here. Do it
in the realize() function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231020145554.662751-1-thuth@redhat.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 29 ++++++++++++-----------
 hw/ipmi/isa_ipmi_bt.c     | 34 +++++++++++++-------------
 hw/ipmi/isa_ipmi_kcs.c    | 50 +++++++++++++++++++--------------------
 3 files changed, 57 insertions(+), 56 deletions(-)

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
@@ -101,31 +119,6 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, iik->kcs.io_base, iik->kcs.io_length);
 
     isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
-}
-
-static bool vmstate_kcs_before_version2(void *opaque, int version)
-{
-    return version <= 1;
-}
-
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
-static void isa_ipmi_kcs_init(Object *obj)
-{
-    ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(obj);
-
-    ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
 
     /*
      * Version 1 had an incorrect name, it clashed with the BT
@@ -135,6 +128,13 @@ static void isa_ipmi_kcs_init(Object *obj)
     vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
 }
 
+static void isa_ipmi_kcs_init(Object *obj)
+{
+    ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(obj);
+
+    ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
+}
+
 static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
 {
     ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(ii);
-- 
2.41.0


