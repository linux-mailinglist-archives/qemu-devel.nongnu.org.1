Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B9ACB93C
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Jun 2025 18:03:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM7cn-0007nh-Ny; Mon, 02 Jun 2025 12:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uM7ck-0007ml-Mu
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:02:54 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uM7ci-0006BB-3X
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:02:54 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250602160249epoutp04df86d71da88b2c6af361422b5d246cd1~FRT_bk-n52225722257epoutp04r
 for <qemu-devel@nongnu.org>; Mon,  2 Jun 2025 16:02:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250602160249epoutp04df86d71da88b2c6af361422b5d246cd1~FRT_bk-n52225722257epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1748880169;
 bh=KrYuxyakbnI0aUfKV8KahEPEuvW90FgrJ3GbYGPxDR8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kUDtR3THaBC4NJE0/6pNiN/jRpdMQ/5TvZ7OCB8xtcJ43gKJuZQnYKLrgEDNoRrtB
 tOhlKlUTBVjJG6wYeQkXyBTUrAThBrRayx20RLI1sUSQZB4e8oL4T0A1J9FYaGGyvY
 IUjZNDsjTd7GUc1kFnFe0vQ4p/BTaiqs9DYHY2iM=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20250602160249epcas5p39b32dd1fa7f27c0d116a0a07bb260e18~FRT9t4Fzl2563625636epcas5p3s;
 Mon,  2 Jun 2025 16:02:49 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.181]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4b9zBv69dqz6B9m4; Mon,  2 Jun
 2025 16:02:47 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35~FPpYy0aSU1197711977epcas5p2J;
 Mon,  2 Jun 2025 14:00:45 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250602140043epsmtip2ad0bbef41f87f43164c52b5da210d4e0~FPpXfr8kp2232922329epsmtip2e;
 Mon,  2 Jun 2025 14:00:43 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
 <arpit1.kumar@samsung.com>
Subject: [PATCH 3/3] hw/cxl: Add Physical Port Control (Opcode 5102h)
Date: Mon,  2 Jun 2025 19:29:42 +0530
Message-Id: <20250602135942.2773823-4-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
 <CGME20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

added assert-deassert PERST implementation, reset PPB
for physical port.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 128 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |   8 +++
 2 files changed, 136 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b2fa79a721..4f09692713 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -118,12 +118,16 @@ enum {
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
+        #define PHYSICAL_PORT_CONTROL       0X2
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
     MHD = 0x55,
         #define GET_MHD_INFO 0x0
 };
 
+/* Assert - Deassert PERST */
+#define ASSERT_WAIT_TIME_MS 100
+
 /* link state flags */
 #define LINK_STATE_FLAG_LANE_REVERSED    (1 << 0)
 #define LINK_STATE_FLAG_PERST_ASSERTED   (1 << 1)
@@ -662,6 +666,114 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static struct PCIDevice *cxl_find_port_dev(uint8_t ppb_id, PCIBus *bus)
+{
+    PCIDevice *d;
+    int devfn;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        d = bus->devices[devfn];
+        if (d) {
+            if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
+                uint8_t port = PCIE_PORT(d)->port;
+                if (port == ppb_id) {
+                    return d;
+                }
+            }
+        }
+    }
+    return NULL;
+}
+
+static CXLRetCode deassert_PERST(Object *obj, ResetType type, uint8_t pn, CXLCCI *cci)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
+    ResettableState *s = rc->get_state(obj);
+
+    if (cci->pports.perst[pn].issued_assert_PERST) {
+        if (cci->pports.perst[pn].asrt_time == -1 && !s->hold_phase_pending) {
+            qemu_mutex_lock(&cci->pports.perst[pn].lock);
+            resettable_release_reset(obj, type);
+            cci->pports.perst[pn].issued_assert_PERST = false;
+            cci->pports.pport_info[pn].link_state_flags &=
+                ~LINK_STATE_FLAG_PERST_ASSERTED;
+            cci->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
+            qemu_mutex_unlock(&cci->pports.perst[pn].lock);
+        } else {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+    } else {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode assert_PERST(Object *obj, ResetType type, uint8_t pn, CXLCCI *cci)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
+    ResettableState *s = rc->get_state(obj);
+
+    if (cci->pports.perst[pn].issued_assert_PERST || s->exit_phase_in_progress) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    qemu_mutex_lock(&cci->pports.perst[pn].lock);
+    cci->pports.perst[pn].issued_assert_PERST = true;
+    cci->pports.pport_info[pn].link_state_flags |=
+        LINK_STATE_FLAG_PERST_ASSERTED;
+    resettable_assert_reset(obj, type);
+    qemu_mutex_unlock(&cci->pports.perst[pn].lock);
+
+    /* holding reset phase for 100ms */
+    while (cci->pports.perst[pn].asrt_time--) {
+        usleep(1000);
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
+/*CXL r3.2 Section 7.6.7.1.3: Get Physical Port Control (Opcode 5102h)*/
+static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    PCIDevice *dev;
+    struct cxl_fmapi_get_physical_port_control_req_pl {
+        uint8_t PPB_ID;
+        uint8_t Ports_Op;
+    } QEMU_PACKED *in;
+
+    in = (struct cxl_fmapi_get_physical_port_control_req_pl *)payload_in;
+
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    uint8_t pn = in->PPB_ID;
+    dev = cxl_find_port_dev(pn, bus);
+    if (!dev) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    switch (in->Ports_Op) {
+    case 0:
+        assert_PERST(OBJECT(&dev->qdev), RESET_TYPE_COLD, pn, cci);
+        break;
+    case 1:
+        deassert_PERST(OBJECT(&dev->qdev), RESET_TYPE_COLD, pn, cci);
+        break;
+    case 2:
+        device_cold_reset(&dev->qdev);
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
 static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
@@ -3637,6 +3749,9 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 void cxl_destroy_cci(CXLCCI *cci)
 {
     qemu_mutex_destroy(&cci->bg.lock);
+    for (int i = 0; i < PCI_DEVFN_MAX; i++) {
+        qemu_mutex_destroy(&cci->pports.perst[i].lock);
+    }
     cci->initialized = false;
 }
 
@@ -3866,6 +3981,8 @@ static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
         cmd_identify_switch_device, 0, 0 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, 0 },
+    [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
+        cmd_physical_port_control, 2, 0 },
     [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
@@ -3878,4 +3995,15 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
     cxl_set_phy_port_info(cci); /* store port info */
+    /* physical port control */
+    for (int i = 0; i < PCI_DEVFN_MAX; i++) {
+        qemu_mutex_init(&cci->pports.perst[i].lock);
+        cci->pports.perst[i].issued_assert_PERST = false;
+        /* Assert PERST involves physical port to be in
+         * hold reset phase for minimum 100ms. No other calls
+         * are entertained until Deassert PERST command.
+         * https://patchwork.ozlabs.org/project/linux-pci/patch/20190523194409.17718-1-niklas.cassel@linaro.org/#2178369
+         */
+        cci->pports.perst[i].asrt_time = ASSERT_WAIT_TIME_MS;
+    }
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9eb128a1e8..f877d60b39 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -146,10 +146,18 @@ struct cxl_phy_port_info {
     uint8_t supported_ld_count;
 } QEMU_PACKED;
 
+/* assert-deassert PERST */
+struct pperst {
+    bool issued_assert_PERST;
+    int asrt_time;
+    QemuMutex lock;
+};
+
 struct phy_port {
     uint8_t num_ports;
     uint8_t active_port_bitmask[0x20];
     struct cxl_phy_port_info pport_info[PCI_DEVFN_MAX];
+    struct pperst perst[PCI_DEVFN_MAX];
 };
 
 /* CXL r3.1 Table 8-34: Command Return Codes */
-- 
2.34.1


