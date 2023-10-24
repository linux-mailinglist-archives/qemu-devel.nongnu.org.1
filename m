Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE557D51C2
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHJY-00081l-7T; Tue, 24 Oct 2023 09:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHH1-00048t-2l
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHGs-00020Y-KU
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698153393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLdOgQORj/Nl035a1TnFgLX0gwiYcob+wD6YkWCXdyk=;
 b=EDKPF3oaOIedjQuNGZ9csgnFUlM0sJjsLa/nygbZ8ouG/wnIwXFMeXV/eypLtn7W/jmBo2
 zEDdkaSKTK/NZZogm3Vz3doJlSoHroRNx9ohuiDr5F1lYKpRsCIXXnhrMez2HLrVzl7yUx
 G4/zET3D+iaOvwzIV504y55nYB5L7yA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-C8EIR1PuO1-9ncAmgaL3Hg-1; Tue,
 24 Oct 2023 09:16:30 -0400
X-MC-Unique: C8EIR1PuO1-9ncAmgaL3Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5190F3813F34;
 Tue, 24 Oct 2023 13:16:28 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95BF81C060AE;
 Tue, 24 Oct 2023 13:16:21 +0000 (UTC)
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Greg Kurz <groug@kaod.org>
Subject: [PULL 29/39] migration: Hack to maintain backwards compatibility for
 ppc
Date: Tue, 24 Oct 2023 15:12:55 +0200
Message-ID: <20231024131305.87468-30-quintela@redhat.com>
In-Reply-To: <20231024131305.87468-1-quintela@redhat.com>
References: <20231024131305.87468-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

Current code does:
- register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
  dependinfg on cpu number
- for newer machines, it register vmstate_icp with "icp/server" name
  and instance 0
- now it unregisters "icp/server" for the 1st instance.

This is wrong at many levels:
- we shouldn't have two VMSTATEDescriptions with the same name
- In case this is the only solution that we can came with, it needs to
  be:
  * register pre_2_10_vmstate_dummy_icp
  * unregister pre_2_10_vmstate_dummy_icp
  * register real vmstate_icp

Created vmstate_replace_hack_for_ppc() with warnings left and right
that it is a hack.

CC: Cedric Le Goater <clg@kaod.org>
CC: Daniel Henrique Barboza <danielhb413@gmail.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Greg Kurz <groug@kaod.org>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231020090731.28701-8-quintela@redhat.com>
---
 include/migration/vmstate.h | 11 +++++++++++
 hw/intc/xics.c              | 18 ++++++++++++++++--
 hw/ppc/spapr.c              | 25 +++++++++++++++++++++++--
 migration/savevm.c          | 18 ++++++++++++++++++
 4 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ea97ccf2d..9821918631 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1230,6 +1230,17 @@ static inline int vmstate_register(VMStateIf *obj, int instance_id,
                                           opaque, -1, 0, NULL);
 }
 
+/**
+ * vmstate_replace_hack_for_ppc() - ppc used to abuse vmstate_register
+ *
+ * Don't even think about using this function in new code.
+ *
+ * Returns: 0 on success, -1 on failure
+ */
+int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
+                                 const VMStateDescription *vmsd,
+                                 void *opaque);
+
 /**
  * vmstate_register_any() - legacy function to register state
  * serialisation description and let the function choose the id
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index c7f8abd71e..c77e986136 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -335,8 +335,22 @@ static void icp_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
-
-    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
+    /*
+     * The way that pre_2_10_icp is handling is really, really hacky.
+     * We used to have here this call:
+     *
+     * vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
+     *
+     * But we were doing:
+     *     pre_2_10_vmstate_register_dummy_icp()
+     *     this vmstate_register()
+     *     pre_2_10_vmstate_unregister_dummy_icp()
+     *
+     * So for a short amount of time we had to vmstate entries with
+     * the same name.  This fixes it.
+     */
+    vmstate_replace_hack_for_ppc(NULL, icp->cs->cpu_index,
+                                 &vmstate_icp_server, icp);
 }
 
 static void icp_unrealize(DeviceState *dev)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b25093be28..df09aa9d6a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -143,6 +143,11 @@ static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
 }
 
 static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
+    /*
+     * Hack ahead.  We can't have two devices with the same name and
+     * instance id.  So I rename this to pass make check.
+     * Real help from people who knows the hardware is needed.
+     */
     .name = "icp/server",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -155,16 +160,32 @@ static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
     },
 };
 
+/*
+ * See comment in hw/intc/xics.c:icp_realize()
+ *
+ * You have to remove vmstate_replace_hack_for_ppc() when you remove
+ * the machine types that need the following function.
+ */
 static void pre_2_10_vmstate_register_dummy_icp(int i)
 {
     vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp,
                      (void *)(uintptr_t) i);
 }
 
+/*
+ * See comment in hw/intc/xics.c:icp_realize()
+ *
+ * You have to remove vmstate_replace_hack_for_ppc() when you remove
+ * the machine types that need the following function.
+ */
 static void pre_2_10_vmstate_unregister_dummy_icp(int i)
 {
-    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp,
-                       (void *)(uintptr_t) i);
+    /*
+     * This used to be:
+     *
+     *    vmstate_unregister(NULL, &pre_2_10_vmstate_dummy_icp,
+     *                      (void *)(uintptr_t) i);
+     */
 }
 
 int spapr_max_server_number(SpaprMachineState *spapr)
diff --git a/migration/savevm.c b/migration/savevm.c
index ca5c7cebe0..1d1639c4b6 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -846,6 +846,24 @@ static void vmstate_check(const VMStateDescription *vmsd)
     }
 }
 
+/*
+ * See comment in hw/intc/xics.c:icp_realize()
+ *
+ * This function can be removed when
+ * pre_2_10_vmstate_register_dummy_icp() is removed.
+ */
+int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
+                                 const VMStateDescription *vmsd,
+                                 void *opaque)
+{
+    SaveStateEntry *se = find_se(vmsd->name, instance_id);
+
+    if (se) {
+        savevm_state_handler_remove(se);
+    }
+    return vmstate_register(obj, instance_id, vmsd, opaque);
+}
+
 int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque, int alias_id,
-- 
2.41.0


