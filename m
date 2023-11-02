Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A141C7DF169
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:43:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW5J-0002a8-4Y; Thu, 02 Nov 2023 07:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW5I-0002ZT-0V
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW5G-0004KW-8b
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfUpo2AlMCZ8lLl/mdLjVK6hSMfAy8f8E2BfyQcLdTk=;
 b=Yy4uurI+4UuVQ1lPdM5gshE4Yl1MExHbQa4PQu053pK1xvLQQ12SaO8R3DAd2GAqzbRJXB
 EI0oSafEn223zJPShL2BMTpN431NWolCyt86bCPn6CusN6D8E8lRpd21aQ8IjM00+10h7g
 V9E9VdFtbllGVKlcfKz4SBvOtVMEi8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-0NEEcv_5OmmYgTLuk77xWA-1; Thu, 02 Nov 2023 07:41:51 -0400
X-MC-Unique: 0NEEcv_5OmmYgTLuk77xWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A123A85A58B;
 Thu,  2 Nov 2023 11:41:49 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D8422026D4C;
 Thu,  2 Nov 2023 11:41:42 +0000 (UTC)
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
 Fam Zheng <fam@euphon.net>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL 06/40] migration: Use vmstate_register_any()
Date: Thu,  2 Nov 2023 12:40:20 +0100
Message-ID: <20231102114054.44360-7-quintela@redhat.com>
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

This are the easiest cases, where we were already using
VMSTATE_INSTANCE_ID_ANY.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231020090731.28701-3-quintela@redhat.com>
---
 backends/dbus-vmstate.c     | 3 +--
 backends/tpm/tpm_emulator.c | 3 +--
 hw/i2c/core.c               | 2 +-
 hw/input/adb.c              | 2 +-
 hw/input/ads7846.c          | 2 +-
 hw/input/stellaris_input.c  | 3 +--
 hw/net/eepro100.c           | 3 +--
 hw/pci/pci.c                | 2 +-
 hw/ppc/spapr_nvdimm.c       | 3 +--
 hw/timer/arm_timer.c        | 2 +-
 hw/virtio/virtio-mem.c      | 4 ++--
 11 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
index 57369ec0f2..a9d8cb0acd 100644
--- a/backends/dbus-vmstate.c
+++ b/backends/dbus-vmstate.c
@@ -426,8 +426,7 @@ dbus_vmstate_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    if (vmstate_register(VMSTATE_IF(self), VMSTATE_INSTANCE_ID_ANY,
-                         &dbus_vmstate, self) < 0) {
+    if (vmstate_register_any(VMSTATE_IF(self), &dbus_vmstate, self) < 0) {
         error_setg(errp, "Failed to register vmstate");
     }
 }
diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index bf1a90f5d7..f7f1b4ad7a 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -975,8 +975,7 @@ static void tpm_emulator_inst_init(Object *obj)
         qemu_add_vm_change_state_handler(tpm_emulator_vm_state_change,
                                          tpm_emu);
 
-    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
-                     &vmstate_tpm_emulator, obj);
+    vmstate_register_any(NULL, &vmstate_tpm_emulator, obj);
 }
 
 /*
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index bed594fe59..879a1d45cb 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -64,7 +64,7 @@ I2CBus *i2c_init_bus(DeviceState *parent, const char *name)
     bus = I2C_BUS(qbus_new(TYPE_I2C_BUS, parent, name));
     QLIST_INIT(&bus->current_devs);
     QSIMPLEQ_INIT(&bus->pending_masters);
-    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_i2c_bus, bus);
+    vmstate_register_any(NULL, &vmstate_i2c_bus, bus);
     return bus;
 }
 
diff --git a/hw/input/adb.c b/hw/input/adb.c
index 214ae6f42b..8aed0da2cd 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -247,7 +247,7 @@ static void adb_bus_realize(BusState *qbus, Error **errp)
     adb_bus->autopoll_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, adb_autopoll,
                                            adb_bus);
 
-    vmstate_register(NULL, -1, &vmstate_adb_bus, adb_bus);
+    vmstate_register_any(NULL, &vmstate_adb_bus, adb_bus);
 }
 
 static void adb_bus_unrealize(BusState *qbus)
diff --git a/hw/input/ads7846.c b/hw/input/ads7846.c
index dc0998ac79..91116c6bdb 100644
--- a/hw/input/ads7846.c
+++ b/hw/input/ads7846.c
@@ -158,7 +158,7 @@ static void ads7846_realize(SSIPeripheral *d, Error **errp)
 
     ads7846_int_update(s);
 
-    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_ads7846, s);
+    vmstate_register_any(NULL, &vmstate_ads7846, s);
 }
 
 static void ads7846_class_init(ObjectClass *klass, void *data)
diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
index e6ee5e11f1..a58721c8cd 100644
--- a/hw/input/stellaris_input.c
+++ b/hw/input/stellaris_input.c
@@ -88,6 +88,5 @@ void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode)
     }
     s->num_buttons = n;
     qemu_add_kbd_event_handler(stellaris_gamepad_put_key, s);
-    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
-                     &vmstate_stellaris_gamepad, s);
+    vmstate_register_any(NULL, &vmstate_stellaris_gamepad, s);
 }
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index dc07984ae9..94ce9e18ff 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1883,8 +1883,7 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
 
     s->vmstate = g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100));
     s->vmstate->name = qemu_get_queue(s->nic)->model;
-    vmstate_register(VMSTATE_IF(&pci_dev->qdev), VMSTATE_INSTANCE_ID_ANY,
-                     s->vmstate, s);
+    vmstate_register_any(VMSTATE_IF(&pci_dev->qdev), s->vmstate, s);
 }
 
 static void eepro100_instance_init(Object *obj)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 7d09e1a39d..885c04b6f5 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -147,7 +147,7 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
     bus->machine_done.notify = pcibus_machine_done;
     qemu_add_machine_init_done_notifier(&bus->machine_done);
 
-    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_pcibus, bus);
+    vmstate_register_any(NULL, &vmstate_pcibus, bus);
 }
 
 static void pcie_bus_realize(BusState *qbus, Error **errp)
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index b2f009c816..ad7afe7544 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -876,8 +876,7 @@ static void spapr_nvdimm_realize(NVDIMMDevice *dimm, Error **errp)
         s_nvdimm->hcall_flush_required = true;
     }
 
-    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
-                     &vmstate_spapr_nvdimm_states, dimm);
+    vmstate_register_any(NULL, &vmstate_spapr_nvdimm_states, dimm);
 }
 
 static void spapr_nvdimm_unrealize(NVDIMMDevice *dimm)
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 69c8863472..9afe8da831 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -181,7 +181,7 @@ static arm_timer_state *arm_timer_init(uint32_t freq)
     s->control = TIMER_CTRL_IE;
 
     s->timer = ptimer_init(arm_timer_tick, s, PTIMER_POLICY_LEGACY);
-    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_arm_timer, s);
+    vmstate_register_any(NULL, &vmstate_arm_timer, s);
     return s;
 }
 
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 9dc3c61b5a..a5ea3be414 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1119,8 +1119,8 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     host_memory_backend_set_mapped(vmem->memdev, true);
     vmstate_register_ram(&vmem->memdev->mr, DEVICE(vmem));
     if (vmem->early_migration) {
-        vmstate_register(VMSTATE_IF(vmem), VMSTATE_INSTANCE_ID_ANY,
-                         &vmstate_virtio_mem_device_early, vmem);
+        vmstate_register_any(VMSTATE_IF(vmem),
+                             &vmstate_virtio_mem_device_early, vmem);
     }
     qemu_register_reset(virtio_mem_system_reset, vmem);
 
-- 
2.41.0


