Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB59C7B9C32
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 11:31:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoKgA-0007ye-75; Thu, 05 Oct 2023 05:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoKg4-0007xB-TB
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:29:54 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoKfz-0005Pm-TS
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:29:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 4FAE5605FD;
 Thu,  5 Oct 2023 12:29:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RTUHmS4OouQ0-s8z5Z42t; Thu, 05 Oct 2023 12:29:43 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696498183;
 bh=sVWlS1/0qcLIlddVWR4IuZohwprYsqi9fOTE72G0Smk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LO1KWpvHclMS7bV5pFiWjJ+rqYqiSFWQX3+ZsfCg8Q2U7YWbWk0dCPPHC3a2QYyei
 3Y14kB5v9OhYvVXDiOL6BDQ1dUIu2knh0sJaHef2OXQgxq+IHaTTQ/QVquLxlz1tNP
 IFsqh36mYiQB4/h+Vi/MWauw11RHgSxUCCj7QREU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, den-plotnikov@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v8 3/4] shpc: implement DEVICE_ON event and query-hotplug
Date: Thu,  5 Oct 2023 12:29:25 +0300
Message-Id: <20231005092926.56231-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005092926.56231-1-vsementsov@yandex-team.ru>
References: <20231005092926.56231-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

For PCIe and SHPC hotplug it's important to track led indicators and
"device-on" status.

At this step, implement the prepared infrastructure in SHPC.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/pci-bridge/pci_bridge_dev.c  | 14 ++++++
 hw/pci-bridge/pcie_pci_bridge.c |  1 +
 hw/pci/shpc.c                   | 86 +++++++++++++++++++++++++++++++++
 include/hw/pci/pci_bridge.h     |  2 +
 include/hw/pci/shpc.h           |  2 +
 include/monitor/qdev.h          |  4 ++
 softmmu/qdev-monitor.c          | 17 +++++++
 7 files changed, 126 insertions(+)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 4b2696ea7f..69ffe93e2a 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -241,6 +241,19 @@ void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
     shpc_device_unplug_request_cb(hotplug_dev, dev, errp);
 }
 
+HotplugInfo *pci_bridge_dev_get_hotplug_state(HotplugHandler *hotplug_dev,
+                                              DeviceState *dev, Error **errp)
+{
+    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
+
+    if (!shpc_present(pci_hotplug_dev)) {
+        error_setg(errp, "standard hotplug controller has been disabled for "
+                   "this %s", object_get_typename(OBJECT(hotplug_dev)));
+        return NULL;
+    }
+    return shpc_get_hotplug_state(hotplug_dev, dev, errp);
+}
+
 static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -261,6 +274,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
     hc->plug = pci_bridge_dev_plug_cb;
     hc->unplug = pci_bridge_dev_unplug_cb;
     hc->unplug_request = pci_bridge_dev_unplug_request_cb;
+    hc->get_hotplug_state = pci_bridge_dev_get_hotplug_state;
 }
 
 static const TypeInfo pci_bridge_dev_info = {
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 2301b2ca0b..959b536303 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -157,6 +157,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     hc->plug = pci_bridge_dev_plug_cb;
     hc->unplug = pci_bridge_dev_unplug_cb;
     hc->unplug_request = pci_bridge_dev_unplug_request_cb;
+    hc->get_hotplug_state = pci_bridge_dev_get_hotplug_state;
 }
 
 static const TypeInfo pcie_pci_bridge_info = {
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index df7f370111..0cd44150e5 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -8,6 +8,9 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/msi.h"
+#include "qapi/qapi-types-qdev.h"
+#include "qapi/qapi-events-qdev.h"
+#include "monitor/qdev.h"
 
 /* TODO: model power only and disabled slot states. */
 /* TODO: handle SERR and wakeups */
@@ -123,6 +126,39 @@
 #define SHPC_PCI_TO_IDX(pci_slot) ((pci_slot) - 1)
 #define SHPC_IDX_TO_PHYSICAL(slot) ((slot) + 1)
 
+static char *shpc_idx_to_pci_addr(int slot)
+{
+    return g_strdup_printf("%d", SHPC_IDX_TO_PCI(slot));
+}
+
+static LedStatus shpc_led_state_to_qapi(uint8_t value)
+{
+    switch (value) {
+    case SHPC_LED_ON:
+        return LED_STATUS_ON;
+    case SHPC_LED_BLINK:
+        return LED_STATUS_BLINKING;
+    case SHPC_LED_OFF:
+        return LED_STATUS_OFF;
+    default:
+        abort();
+    }
+}
+
+static HotplugSHPCSlotState shpc_slot_state_to_qapi(uint8_t value)
+{
+    switch (value) {
+    case SHPC_STATE_PWRONLY:
+        return HOTPLUGSHPC_SLOT_STATE_POWER_ONLY;
+    case SHPC_STATE_ENABLED:
+        return HOTPLUGSHPC_SLOT_STATE_ENABLED;
+    case SHPC_STATE_DISABLED:
+        return HOTPLUGSHPC_SLOT_STATE_DISABLED;
+    default:
+        abort();
+    }
+}
+
 static uint8_t shpc_get_status(SHPCDevice *shpc, int slot, uint16_t msk)
 {
     uint8_t *status = shpc->config + SHPC_SLOT_STATUS(slot);
@@ -263,14 +299,23 @@ static bool shpc_slot_is_off(uint8_t state, uint8_t power, uint8_t attn)
     return state == SHPC_STATE_DISABLED && power == SHPC_LED_OFF;
 }
 
+static bool shpc_slot_is_on(uint8_t state, uint8_t power, uint8_t attn)
+{
+    return state == SHPC_STATE_ENABLED && power == SHPC_LED_ON &&
+        attn == SHPC_LED_OFF;
+}
+
 static void shpc_slot_command(PCIDevice *d, uint8_t target,
                               uint8_t state, uint8_t power, uint8_t attn)
 {
     SHPCDevice *shpc = d->shpc;
     int slot = SHPC_LOGICAL_TO_IDX(target);
+    int pci_slot = SHPC_IDX_TO_PCI(slot);
     uint8_t old_state = shpc_get_status(shpc, slot, SHPC_SLOT_STATE_MASK);
     uint8_t old_power = shpc_get_status(shpc, slot, SHPC_SLOT_PWR_LED_MASK);
     uint8_t old_attn = shpc_get_status(shpc, slot, SHPC_SLOT_ATTN_LED_MASK);
+    DeviceState *child_dev =
+        DEVICE(shpc->sec_bus->devices[PCI_DEVFN(pci_slot, 0)]);
 
     if (target < SHPC_CMD_TRGT_MIN || slot >= shpc->nslots) {
         shpc_invalid_command(shpc);
@@ -313,6 +358,12 @@ static void shpc_slot_command(PCIDevice *d, uint8_t target,
             SHPC_SLOT_EVENT_MRL |
             SHPC_SLOT_EVENT_PRESENCE;
     }
+
+    if (!shpc_slot_is_on(old_state, old_power, old_attn) &&
+        shpc_slot_is_on(state, power, attn) && child_dev)
+    {
+        qdev_hotplug_device_on_event(child_dev);
+    }
 }
 
 static void shpc_command(PCIDevice *d)
@@ -713,6 +764,41 @@ void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int l)
     shpc_cap_update_dword(d);
 }
 
+HotplugInfo *shpc_get_hotplug_state(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
+{
+    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
+    SHPCDevice *shpc = pci_hotplug_dev->shpc;
+    int slot;
+    uint8_t state, power, attn;
+    HotplugInfo *res;
+
+    if (!shpc_device_get_slot(PCI_DEVICE(dev), &slot, shpc, errp)) {
+        return NULL;
+    }
+
+    state = shpc_get_status(shpc, slot, SHPC_SLOT_STATE_MASK);
+    power = shpc_get_status(shpc, slot, SHPC_SLOT_PWR_LED_MASK);
+    attn = shpc_get_status(shpc, slot, SHPC_SLOT_ATTN_LED_MASK);
+
+    res = g_new(HotplugInfo, 1);
+    *res = (HotplugInfo) {
+        .bus = qdev_new_device_and_path(DEVICE(pci_hotplug_dev)),
+        .addr = shpc_idx_to_pci_addr(slot),
+        .child = qdev_new_device_and_path(dev),
+        .type = HOTPLUG_TYPE_SHPC,
+        .device_on = dev->device_on_event_sent,
+        .has_power_led = true,
+        .power_led = shpc_led_state_to_qapi(power),
+        .has_attention_led = true,
+        .attention_led = shpc_led_state_to_qapi(attn),
+        .u.shpc.has_slot_state = true,
+        .u.shpc.slot_state = shpc_slot_state_to_qapi(state),
+    };
+
+    return res;
+}
+
 static int shpc_save(QEMUFile *f, void *pv, size_t size,
                      const VMStateField *field, JSONWriter *vmdesc)
 {
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index ea54a81a15..2756c64953 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -139,6 +139,8 @@ void pci_bridge_dev_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp);
 void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp);
+HotplugInfo *pci_bridge_dev_get_hotplug_state(HotplugHandler *hotplug_dev,
+                                              DeviceState *dev, Error **errp);
 
 /*
  * before qdev initialization(qdev_init()), this function sets bus_name and
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index 89c7a3b7fa..bf722ce65d 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -51,6 +51,8 @@ void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp);
 void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp);
+HotplugInfo *shpc_get_hotplug_state(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp);
 
 extern VMStateInfo shpc_vmstate_info;
 #define SHPC_VMSTATE(_field, _type,  _test) \
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index c1c8798e89..949a3672cb 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -1,6 +1,8 @@
 #ifndef MONITOR_QDEV_H
 #define MONITOR_QDEV_H
 
+#include "qapi/qapi-types-qdev.h"
+
 /*** monitor commands ***/
 
 void hmp_info_qtree(Monitor *mon, const QDict *qdict);
@@ -38,4 +40,6 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp);
 
 void qdev_hotplug_device_on_event(DeviceState *dev);
 
+DeviceAndPath *qdev_new_device_and_path(DeviceState *dev);
+
 #endif
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index 483da40cb9..19c31446d8 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -1178,6 +1178,23 @@ bool qmp_command_available(const QmpCommand *cmd, Error **errp)
     return true;
 }
 
+DeviceAndPath *qdev_new_device_and_path(DeviceState *dev)
+{
+    DeviceAndPath *res;
+
+    if (!dev) {
+        return NULL;
+    }
+
+    res = g_new(DeviceAndPath, 1);
+    *res = (DeviceAndPath) {
+        .device = g_strdup(dev->id),
+        .path = g_strdup(dev->canonical_path),
+    };
+
+    return res;
+}
+
 void qdev_hotplug_device_on_event(DeviceState *dev)
 {
     if (dev->device_on_event_sent) {
-- 
2.34.1


