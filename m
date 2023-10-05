Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F6C7B9C2F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 11:31:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoKgB-0007yr-Dd; Thu, 05 Oct 2023 05:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoKg2-0007wr-UN
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:29:52 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoKfz-0005Px-TS
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 05:29:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 55ABE622D6;
 Thu,  5 Oct 2023 12:29:45 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RTUHmS4OouQ0-ieHHcxQo; Thu, 05 Oct 2023 12:29:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696498184;
 bh=1Ekdq811+EjFXBZpXGP43m0dc5f59sGIEcHN1J9mM0M=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=bUu+CqIEbQFQJado5EI3SL3nvZ/UjU4d7WD4jTOFA7avfztiKx4v5GgxJ7pZpRuiv
 D8jzLoqOf/CD959K/TGZqG+5kZdJ1fWdvNbdw6H2yXDvQZBU2Z5ObfshJoB0bfh+m9
 KZnwJJaUFmaJkOS5aUxx8G/8HPhkkCfj8MGNfYbM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, den-plotnikov@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v8 4/4] pcie: implement DEVICE_ON event and query-hotplug
Date: Thu,  5 Oct 2023 12:29:26 +0300
Message-Id: <20231005092926.56231-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005092926.56231-1-vsementsov@yandex-team.ru>
References: <20231005092926.56231-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

At this step implement the prepared infrastructure in PCIe.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/pci/pcie.c         | 83 +++++++++++++++++++++++++++++++++++++++++++
 hw/pci/pcie_port.c    |  1 +
 include/hw/pci/pcie.h |  2 ++
 3 files changed, 86 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6db0cf69cd..8b5c163c25 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -19,7 +19,10 @@
  */
 
 #include "qemu/osdep.h"
+
+#include "monitor/qdev.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-qdev.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/msix.h"
@@ -45,6 +48,30 @@ static bool pcie_sltctl_powered_off(uint16_t sltctl)
         && (sltctl & PCI_EXP_SLTCTL_PIC) == PCI_EXP_SLTCTL_PWR_IND_OFF;
 }
 
+static bool pcie_sltctl_powered_on(uint16_t sltctl)
+{
+    return (sltctl & PCI_EXP_SLTCTL_PCC) == PCI_EXP_SLTCTL_PWR_ON &&
+        (sltctl & PCI_EXP_SLTCTL_PIC) == PCI_EXP_SLTCTL_PWR_IND_ON &&
+        (sltctl & PCI_EXP_SLTCTL_AIC) == PCI_EXP_SLTCTL_ATTN_IND_OFF;
+}
+
+static LedStatus pcie_led_state_to_qapi(uint16_t value)
+{
+    switch (value) {
+    case PCI_EXP_SLTCTL_PWR_IND_ON:
+    case PCI_EXP_SLTCTL_ATTN_IND_ON:
+        return LED_STATUS_ON;
+    case PCI_EXP_SLTCTL_PWR_IND_BLINK:
+    case PCI_EXP_SLTCTL_ATTN_IND_BLINK:
+        return LED_STATUS_BLINKING;
+    case PCI_EXP_SLTCTL_PWR_IND_OFF:
+    case PCI_EXP_SLTCTL_ATTN_IND_OFF:
+        return LED_STATUS_OFF;
+    default:
+        abort();
+    }
+}
+
 /***************************************************************************
  * pci express capability helper functions
  */
@@ -735,6 +762,28 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta)
     *slt_sta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
 }
 
+static void find_child_fn(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    PCIDevice **child = opaque;
+
+    if (!*child) {
+        *child = dev;
+    }
+}
+
+/*
+ * Returns the plugged device or first function of multifunction plugged device
+ */
+static PCIDevice *pcie_cap_slot_find_child(PCIDevice *dev)
+{
+    PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
+    PCIDevice *child = NULL;
+
+    pci_for_each_device(sec_bus, pci_bus_num(sec_bus), find_child_fn, &child);
+
+    return child;
+}
+
 void pcie_cap_slot_write_config(PCIDevice *dev,
                                 uint16_t old_slt_ctl, uint16_t old_slt_sta,
                                 uint32_t addr, uint32_t val, int len)
@@ -742,6 +791,7 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
     uint32_t pos = dev->exp.exp_cap;
     uint8_t *exp_cap = dev->config + pos;
     uint16_t sltsta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
+    DeviceState *child_dev = DEVICE(pcie_cap_slot_find_child(dev));
 
     if (ranges_overlap(addr, len, pos + PCI_EXP_SLTSTA, 2)) {
         /*
@@ -779,6 +829,12 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
                         sltsta);
     }
 
+    if ((sltsta & PCI_EXP_SLTSTA_PDS) && pcie_sltctl_powered_on(val) &&
+        !pcie_sltctl_powered_on(old_slt_ctl) && child_dev)
+    {
+        qdev_hotplug_device_on_event(child_dev);
+    }
+
     /*
      * If the slot is populated, power indicator is off and power
      * controller is off, it is safe to detach the devices.
@@ -1113,3 +1169,30 @@ void pcie_acs_reset(PCIDevice *dev)
         pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
     }
 }
+
+HotplugInfo *pcie_cap_slot_get_hotplug_state(HotplugHandler *hotplug_dev,
+                                             DeviceState *dev, Error **errp)
+{
+    PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
+    uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
+    uint16_t sltctl = pci_get_word(exp_cap + PCI_EXP_SLTCTL);
+    uint16_t power_led = sltctl & PCI_EXP_SLTCTL_PIC;
+    uint16_t attn_led = sltctl & PCI_EXP_SLTCTL_AIC;
+    uint16_t pcc = sltctl & PCI_EXP_SLTCTL_PCC;
+    HotplugInfo *res = g_new(HotplugInfo, 1);
+
+    *res = (HotplugInfo) {
+        .type = HOTPLUG_TYPE_PCIE_NATIVE,
+        .bus = qdev_new_device_and_path(DEVICE(hotplug_pdev)),
+        .child = qdev_new_device_and_path(dev),
+        .device_on = dev->device_on_event_sent,
+        .has_power_led = true,
+        .power_led = pcie_led_state_to_qapi(power_led),
+        .has_attention_led = true,
+        .attention_led = pcie_led_state_to_qapi(attn_led),
+        .u.pcie_native.has_power_on = true,
+        .u.pcie_native.power_on = pcc == PCI_EXP_SLTCTL_PWR_ON,
+    };
+
+    return res;
+}
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index 20ff2b39e8..91e53c269c 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -234,6 +234,7 @@ static void pcie_slot_class_init(ObjectClass *oc, void *data)
     hc->unplug = pcie_cap_slot_unplug_cb;
     hc->unplug_request = pcie_cap_slot_unplug_request_cb;
     hc->is_hotpluggable_bus = pcie_slot_is_hotpluggbale_bus;
+    hc->get_hotplug_state = pcie_cap_slot_get_hotplug_state;
 }
 
 static const TypeInfo pcie_slot_type_info = {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 11f5a91bbb..01fb9e163c 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -147,4 +147,6 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                              Error **errp);
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
+HotplugInfo *pcie_cap_slot_get_hotplug_state(HotplugHandler *hotplug_dev,
+                                             DeviceState *dev, Error **errp);
 #endif /* QEMU_PCIE_H */
-- 
2.34.1


