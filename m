Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0EF7DF17F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:44:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW6k-0004hu-Ia; Thu, 02 Nov 2023 07:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW5j-00038N-Ls
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW5c-0004pD-SD
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yqe+Kaq0plXmRxAplZP9XMHN9szduKH8tfpA7QWlGA0=;
 b=aAe5vPWwSVHbznaRaQ0762KAHm8mOqKcMlOXfkv1baUIJwKXaGm4MonA1glqvEofc0zO8S
 HKjoEV3Yn3nNdLbcOfBMoN7tDRImWhcOxtkUkIxfD2Xnpg9psc43CD8sordNJ5NgJBHdBp
 NKJ0rom9tjWCAXlXB/ts7cjW8+uzfOE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-Lie9G2bfPmahTVRFwv13kA-1; Thu, 02 Nov 2023 07:42:14 -0400
X-MC-Unique: Lie9G2bfPmahTVRFwv13kA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97BC0831529;
 Thu,  2 Nov 2023 11:42:12 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35FB42026D4C;
 Thu,  2 Nov 2023 11:42:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Corey Minyard <minyard@acm.org>,
 John Snow <jsnow@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Juan Quintela <quintela@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Greg Kurz <groug@kaod.org>
Subject: [PULL 09/40] migration: Hack to maintain backwards compatibility for
 ppc
Date: Thu,  2 Nov 2023 12:40:23 +0100
Message-ID: <20231102114054.44360-10-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index c7835e9c73..c7596c3e9b 100644
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


