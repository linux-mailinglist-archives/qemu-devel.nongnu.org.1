Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B13BB7E769E
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 02:38:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1GS2-0004r2-3f; Thu, 09 Nov 2023 20:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deniz.eren@outlook.com>)
 id 1r1D5K-0000hL-Vk
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 17:01:16 -0500
Received: from mail-sl2kor01olkn2055.outbound.protection.outlook.com
 ([40.92.243.55] helo=KOR01-SL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deniz.eren@outlook.com>)
 id 1r1D5B-0000bz-Ay
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 17:01:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpUw8d55spnOYD+UiBdBPYSkPkLY/QCi2aByyJOP5IUYLUDWFb/RoFn7/rnfTNEEPkOco69lLQNY30ZMLIXblGyFvzFLwxcJRwC/hhgC9/6xL2kK+cKfK24K9V9GlzKtSKl8G1+t1OhxcwQN0qXj2CNz/1Kgx4/8/s5Y7vRT0FAzIZf0ALg8RN1cLK7SCA4poB6ztMyyneL2A0VjmtWj4EoCKVKKHfmMk9uZ6ZZN5T/DKJFyZ8IRJJMUGoqjw+6f+afI2EyXyyGS2xp5g7l9uYy8p9jYZUIz67xJj13ry9hTPIwNrtUHYhFYwPGL+kGG6llUZofdctLqCSqutgmQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUcspU4QogHhbSnqSI9RVkiCkp026InQj7cY0kqZGzY=;
 b=OA/ny4BpNQhgzSsb7UneE/sm2sGTjIZrEvOqYplkBOQYQ/X/8JDkgAqk0USt/nNtg9hcUWdip97WBaqnxuIC5F60wzE+CnWliCEbf8x+pfFQ2pKocfZqUiJ2NzR2hq2t2VTiMG+0WQxFFzz6pYBOoFiMYMhoqK8ObjGwPSateo4Th3W64UrPHyfOOW2tTsPMdf21iSSz+JrpDRfnY3fbSTy6vtIcuRojrVXeW09okkT/jxLPj5wNsG0iRdmCDPHLoW8CZBgrK+nph9r33NnkgwjCK/Z9HgSNugblo0cTt/nRPzL02hxWY6aUgvkHHXlEBCjdzDAUduHaROQR6xoS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUcspU4QogHhbSnqSI9RVkiCkp026InQj7cY0kqZGzY=;
 b=qMyg/1VO3mWlDyvoaISDOSwlRmXioq0epxO2OmXZfv+rOz6rpZUI42z4OpOPVeUY19eY+EgACQadPHN/ydJgo2QHsyzikb0MnmI6dNMN4bD5+O7FYv5xiH6C9/COryx2MN4hexggF4oGYEuLX7z5gpOI4FDZHiTR6YMoCAL2FYzcCdEnKCSlisKFuggeJ+YuiIGyQSgq6ShuUD3wBAeMScGWh9McQlFSYEsz9sSseDy2plJzbZ7lbJCyGDuaNBiGS6NIDqhrZuj/HCxvzhPX2LmI4Gg8MoPn3lknzD1/bZv4zLDILI6tAyvzahr/h2gv45ahWzyHF4JcqDy+Hvz8iw==
Received: from SL2P216MB1277.KORP216.PROD.OUTLOOK.COM (2603:1096:101:13::11)
 by SE2P216MB2695.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.9; Thu, 9 Nov
 2023 21:55:48 +0000
Received: from SL2P216MB1277.KORP216.PROD.OUTLOOK.COM
 ([fe80::b5a8:b107:9174:731a]) by SL2P216MB1277.KORP216.PROD.OUTLOOK.COM
 ([fe80::b5a8:b107:9174:731a%6]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 21:55:48 +0000
From: Deniz Eren <deniz.eren@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Implementation of SJA1000 CAN-bus devices that support
 MSI (PCI capability 0x05). - Implementation of multiple MSI vector support
 for SJA1000 devices. - Added can_pcm26d2ca_pci.c; support for Advantech iDoor
 Module (PCM-26D2CA): 2-Ports Iso...
Thread-Topic: [PATCH] Implementation of SJA1000 CAN-bus devices that support
 MSI (PCI capability 0x05). - Implementation of multiple MSI vector support
 for SJA1000 devices. - Added can_pcm26d2ca_pci.c; support for Advantech iDoor
 Module (PCM-26D2CA): 2-Ports Iso...
Thread-Index: AQHaE1d/YLhdKVe8Bki5Nbt78Bve4Q==
Date: Thu, 9 Nov 2023 21:55:48 +0000
Message-ID: <SL2P216MB127768FA6920A17C232EFD9292AFA@SL2P216MB1277.KORP216.PROD.OUTLOOK.COM>
References: <20231107052657.64207-1-deniz.eren@outlook.com>
In-Reply-To: <20231107052657.64207-1-deniz.eren@outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [0nCHpo53FE5IxIwKrNQfsSq8CQ490GSC]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1277:EE_|SE2P216MB2695:EE_
x-ms-office365-filtering-correlation-id: 932bf8a9-95d7-49bc-c95a-08dbe16ea1df
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oeFxqTFBPeO8UcwdSkLsvz2kG4OX1Vq60SkRp8Vz7iimkOOyxY5XznmNnfYD0LqvQMF1of6Y5JsdxjVcT5BWipk41gNCkErGVrAdGajtmJdpY0Na0WGHthbmX4j9CIn9+lunrIgvMDOiuzcQZRxQgW2QuhOtIgs7hVRwrAVntJyRS2TjtW7ZBMESwEbBeHITfd9sqSQ21n+sOych6bbXFlBJtvVQUsiN9as0DW7w/iE/snyH+KbAD/SU3g76SEGynVooHAcFAM+0AAv/bKn41ntbtiyB0r8OcO2jc99PjHKQ39wDOhgbH8Z4CjqAfoLqREW2dRt2IEUwuuV54BvFebSLB2K+vF0YY+pJEfkOe+bv+BlVrJh0BDPORv/Y18WPHk8Fio/t+axTytb1QBZa8TwV8mRvc6E2JxrZdqi2M0xw26f9Jq+bT9s6qdCMLi20X8qKEguBKXRD8sJrvSmqLueEYdC2vHrGKvhlGIvzz4FW+g3uEHPK3lkMxLgWlpjfCGY1h0ffhFoID/d7+YgAd/TuHooqBm8IHqjtQtqe2pqNNXgp9xhjCXctgsnq/vfo4+RBP3reHCTNmfBOYdlbQunXySqz8mIFxKcumgDk57Q=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LGMjueSpG5ftvfZb840ON0xnsN01yuUOH7Qrwftp1KcuMI+tBnQmmCKwTse8?=
 =?us-ascii?Q?JFFGGXrB8cdrkel9czH6fiK88wTPcGc0w6s4xSsuMJtatj4xdMkNgxNAXij1?=
 =?us-ascii?Q?Np+aX4ckRmiPyxUbagkMrIxp0ATdi2Kr+vXGrhmOqxSAGJynlLHjIZQHR8MI?=
 =?us-ascii?Q?yV40ggDCu1DhaQ9w2Naxqrd9Qw0oGirP7z+BXUhtGoRnHYaztwLGpqwq8gIK?=
 =?us-ascii?Q?FIpILb2Qcpc6Zb4hHqt6r0kjqEuP08fDFrFbt+L6pBDF8hH1vO+0LBiRhkZh?=
 =?us-ascii?Q?q06sNK/SDmcapgo129TQNLD1oW2DF29y3Z7hOiHJ81Yo38OMXO4i7IsQXwQ4?=
 =?us-ascii?Q?lDBbtTu2LFLFHHsX1+QpUapLG3/IW1A7noJnF/WWmvE3Obw1TExbv8LWnCph?=
 =?us-ascii?Q?6HMhQM3Pq8ELHsBdcauSNR86gxo5irDkb3hL/VfocUZ/5VJWiPuCVpxiG5WZ?=
 =?us-ascii?Q?TCPC+YEp1R/7VwdRvkHFk+93OkWXpuz4LOXcAHnm6RCgErZnm1uwU/ghg2d5?=
 =?us-ascii?Q?10Et34ouqsKpgjVuAU5/xd5/bjdczhQ9v0fk4czeUXlgovG0XnSp3HLhI+j3?=
 =?us-ascii?Q?d29AavTNRWQspM/dxLXivqyf4PkNyJeKpeAwqc0I5sRXYGfCgO1Iattpcc2C?=
 =?us-ascii?Q?gQbtXLaHL22/iFC+PFkIxopAlh9FDYk0RHG2fgy3BRYf6nZBki7+edaK19LI?=
 =?us-ascii?Q?0ZqamWsYcj5YCqZs9HAtzypS2Kx4CWggIWhZVr0a645ojKXToGjDhEGt4HkM?=
 =?us-ascii?Q?pCVTZzQvEyqcvLsLRa6m1RRPYE07g58aIKXvZsXeG6JoqTeiVBr+iQHzAYff?=
 =?us-ascii?Q?/yWmi8SQgFGQMCN6QcNRGlCzvC53xfvo93w1Y8TsMo1IbnlRLMT3jd9q8thD?=
 =?us-ascii?Q?UtvPvUGLTiRgd9rVWhjFQ2abSjN0P2/BH6EkrKQAqHBgmS6nHY5SGexQiygn?=
 =?us-ascii?Q?b3zyxsr01mkZHpMK0DG3REuUOFYZuIzlDYvv0DvuEu+gTcalG+2o95OeWvIi?=
 =?us-ascii?Q?A5XSG8YLJRTmnEI4+a60yQp10OKu6VlWv0RqXEgaOOp7/5BV4D6/dbzzVGDt?=
 =?us-ascii?Q?soW8FK1bjIe2YZ6KwpiUcgkcixnoO6SVzEhjwLMsxfTPjgSxF0fvV5J0QrRH?=
 =?us-ascii?Q?SXZpLDbdqqK7/2GRP3tVe2/DEiVDj0IdbM6+BqVTp02q0kVHZ7l9lBuNCxXo?=
 =?us-ascii?Q?UZdEhe7aeZRUjFshqkCmjZQuTUQPhkhzPmc8m44Dr9CY1AsXqCgpHnVo31A?=
 =?us-ascii?Q?=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SL2P216MB127768FA6920A17C232EFD9292AFASL2P216MB1277KORP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1277.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 932bf8a9-95d7-49bc-c95a-08dbe16ea1df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 21:55:48.1252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB2695
Received-SPF: pass client-ip=40.92.243.55; envelope-from=deniz.eren@outlook.com;
 helo=KOR01-SL2-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Nov 2023 20:36:48 -0500
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

--_000_SL2P216MB127768FA6920A17C232EFD9292AFASL2P216MB1277KORP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Just wondering if I need to do anything else to get this patch across the l=
ine? It's basically support for a new type of CANbus device with PCI MSI ca=
pability, which hasn't been supported before in QEmu CAN stack.



Best regards,
Deniz

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Deniz Eren <deniz.eren314@gmail.com>
Sent: Tuesday, November 7, 2023 4:26:57 PM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: deniz.eren314@gmail.com <deniz.eren314@gmail.com>; Deniz Eren <deniz.er=
en@outlook.com>
Subject: [PATCH] Implementation of SJA1000 CAN-bus devices that support MSI=
 (PCI capability 0x05). - Implementation of multiple MSI vector support for=
 SJA1000 devices. - Added can_pcm26d2ca_pci.c; support for Advantech iDoor =
Module (PCM-26D2CA): 2-Ports Isolate...

Signed-off-by: Deniz Eren <deniz.eren@outlook.com>
---
 hw/net/can/can_pcm26d2ca_pci.c | 281 +++++++++++++++++++++++++++++++++
 hw/net/can/can_sja1000.c       |  91 +++++++++++
 hw/net/can/can_sja1000.h       |  12 ++
 hw/net/can/meson.build         |   1 +
 4 files changed, 385 insertions(+)
 create mode 100644 hw/net/can/can_pcm26d2ca_pci.c

diff --git a/hw/net/can/can_pcm26d2ca_pci.c b/hw/net/can/can_pcm26d2ca_pci.=
c
new file mode 100644
index 0000000000..af1dd4c7bb
--- /dev/null
+++ b/hw/net/can/can_pcm26d2ca_pci.c
@@ -0,0 +1,281 @@
+/*
+ * PCM-26D2CA PCIe CAN device (SJA1000 based) emulation
+ *
+ * Advantech iDoor Module: 2-Ports Isolated CANBus mPCIe, DB9
+ *
+ * Copyright (c) 2023 Deniz Eren (deniz.eren@icloud.com)
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/units.h"
+#include "qemu/osdep.h"
+#include "qemu/event_notifier.h"
+#include "qemu/module.h"
+#include "qemu/thread.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "hw/irq.h"
+#include "hw/pci/pci_device.h"
+#include "hw/qdev-properties.h"
+#include "hw/pci/msi.h"
+#include "migration/vmstate.h"
+#include "net/can_emu.h"
+
+#include "can_sja1000.h"
+#include "qom/object.h"
+
+#define TYPE_CAN_PCI_DEV "pcm26d2ca_pci"
+
+typedef struct Pcm26D2CAPCIeState Pcm26D2CAPCIeState;
+DECLARE_INSTANCE_CHECKER(Pcm26D2CAPCIeState, PCM26D2CA_PCI_DEV,
+                         TYPE_CAN_PCI_DEV)
+
+/* the PCI device and vendor IDs */
+#ifndef PCM26D2CA_PCI_VENDOR_ID1
+#define PCM26D2CA_PCI_VENDOR_ID1    0x13fe
+#endif
+
+#ifndef PCM26D2CA_PCI_DEVICE_ID1
+#define PCM26D2CA_PCI_DEVICE_ID1    0x00d7
+#endif
+
+#define PCM26D2CA_PCI_SJA_COUNT     2
+#define PCM26D2CA_PCI_SJA_RANGE     0x400
+
+#define PCM26D2CA_PCI_BYTES_PER_SJA 0x80
+
+#define PCM26D2CA_IO_IDX            0
+
+#define PCM26D2CA_MSI_VEC_NUM       (8)
+#define PCM26D2CA_MSI_RI_ENTRY      (0) /* Receive interrupt */
+#define PCM26D2CA_MSI_TI_ENTRY      (1) /* Transmit interrupt */
+#define PCM26D2CA_MSI_EI_ENTRY      (2) /* Error warning interrupt */
+#define PCM26D2CA_MSI_DOI_ENTRY     (3) /* Data overrun interrupt */
+#define PCM26D2CA_MSI_WUI_ENTRY     (4) /* Wakeup interrupt */
+#define PCM26D2CA_MSI_EPI_ENTRY     (5) /* Error passive */
+#define PCM26D2CA_MSI_ALI_ENTRY     (6) /* Arbitration lost */
+#define PCM26D2CA_MSI_BEI_ENTRY     (7) /* Bus error interrupt */
+
+struct Pcm26D2CAPCIeState {
+    /*< private >*/
+    PCIDevice       dev;
+    /*< public >*/
+    MemoryRegion    io;
+
+    CanSJA1000State sja_state[PCM26D2CA_PCI_SJA_COUNT];
+    qemu_irq        irq;
+
+    char            *model; /* The model that support, only SJA1000 now. *=
/
+    CanBusState     *canbus[PCM26D2CA_PCI_SJA_COUNT];
+};
+
+static void pcm26d2ca_pci_reset(DeviceState *dev)
+{
+    Pcm26D2CAPCIeState *d =3D PCM26D2CA_PCI_DEV(dev);
+    int i;
+
+    for (i =3D 0 ; i < PCM26D2CA_PCI_SJA_COUNT; i++) {
+        can_sja_hardware_reset(&d->sja_state[i]);
+    }
+}
+
+static uint64_t pcm26d2ca_pci_io_read(void *opaque, hwaddr addr, unsigned =
size)
+{
+    Pcm26D2CAPCIeState *d =3D opaque;
+    CanSJA1000State *s =3D &d->sja_state[0];
+    hwaddr _addr =3D addr;
+
+    if (addr >=3D PCM26D2CA_PCI_SJA_RANGE) {
+        s =3D &d->sja_state[1];
+        _addr -=3D PCM26D2CA_PCI_SJA_RANGE;
+    }
+
+    if (_addr >=3D PCM26D2CA_PCI_BYTES_PER_SJA) {
+        return 0;
+    }
+
+    return can_sja_mem_read(s, _addr >> 2, size);
+}
+
+static void pcm26d2ca_pci_io_write(void *opaque, hwaddr addr, uint64_t dat=
a,
+                                  unsigned size)
+{
+    Pcm26D2CAPCIeState *d =3D opaque;
+    CanSJA1000State *s =3D &d->sja_state[0];
+    hwaddr _addr =3D addr;
+
+    if (addr >=3D PCM26D2CA_PCI_SJA_RANGE) {
+        s =3D &d->sja_state[1];
+        _addr -=3D PCM26D2CA_PCI_SJA_RANGE;
+    }
+
+    if (_addr >=3D PCM26D2CA_PCI_BYTES_PER_SJA) {
+        return;
+    }
+
+    can_sja_mem_write(s, _addr >> 2, data, size);
+}
+
+static const MemoryRegionOps pcm26d2ca_pci_io_ops =3D {
+    .read =3D pcm26d2ca_pci_io_read,
+    .write =3D pcm26d2ca_pci_io_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 1,
+    },
+};
+
+static void pcm26d2ca_pci_realize(PCIDevice *pci_dev, Error **errp)
+{
+    static const uint16_t pcie_offset =3D 0x0E0;
+    Pcm26D2CAPCIeState *d =3D PCM26D2CA_PCI_DEV(pci_dev);
+    uint8_t *pci_conf;
+    Error *err =3D NULL;
+    int i;
+    int ret;
+
+    /* Map MSI and MSI-X vector entries one-to-one for each interrupt */
+    uint8_t msi_map[PCM26D2CA_MSI_VEC_NUM] =3D {
+        PCM26D2CA_MSI_RI_ENTRY,  /* Receive interrupt */
+        PCM26D2CA_MSI_TI_ENTRY,  /* Transmit interrupt */
+        PCM26D2CA_MSI_EI_ENTRY,  /* Error warning interrupt */
+        PCM26D2CA_MSI_DOI_ENTRY, /* Data overrun interrupt */
+        PCM26D2CA_MSI_WUI_ENTRY, /* Wakeup interrupt */
+        PCM26D2CA_MSI_EPI_ENTRY, /* Error passive */
+        PCM26D2CA_MSI_ALI_ENTRY, /* Arbitration lost */
+        PCM26D2CA_MSI_BEI_ENTRY  /* Bus error interrupt */
+    };
+
+    pci_conf =3D pci_dev->config;
+    pci_conf[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin A */
+
+    d->irq =3D pci_allocate_irq(&d->dev);
+
+    for (i =3D 0 ; i < PCM26D2CA_PCI_SJA_COUNT; i++) {
+        can_sja_cap_init(&d->sja_state[i], d->irq, pci_dev, msi_map, msi_m=
ap);
+    }
+
+    for (i =3D 0 ; i < PCM26D2CA_PCI_SJA_COUNT; i++) {
+        if (can_sja_connect_to_bus(&d->sja_state[i], d->canbus[i]) < 0) {
+            error_setg(errp, "can_sja_connect_to_bus failed");
+            return;
+        }
+    }
+
+    memory_region_init_io(&d->io, OBJECT(d), &pcm26d2ca_pci_io_ops,
+                          d, "pcm26d2ca_pci-io", 2*PCM26D2CA_PCI_SJA_RANGE=
);
+    pci_register_bar(&d->dev, PCM26D2CA_IO_IDX,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY, &d->io);
+
+    if (pcie_endpoint_cap_v1_init(pci_dev, pcie_offset) < 0) {
+        error_setg(errp, "Failed to initialize PCIe capability");
+        return;
+    }
+
+    ret =3D msi_init( PCI_DEVICE(d), 0xD0, PCM26D2CA_MSI_VEC_NUM,
+            true, false, NULL );
+
+    if (ret) {
+        error_setg(errp, "msi_init failed (%d)", ret);
+        return;
+    }
+
+    error_free(err);
+}
+
+static void pcm26d2ca_pci_exit(PCIDevice *pci_dev)
+{
+    Pcm26D2CAPCIeState *d =3D PCM26D2CA_PCI_DEV(pci_dev);
+    int i;
+
+    for (i =3D 0 ; i < PCM26D2CA_PCI_SJA_COUNT; i++) {
+        can_sja_disconnect(&d->sja_state[i]);
+    }
+
+    qemu_free_irq(d->irq);
+    msi_uninit(pci_dev);
+}
+
+static const VMStateDescription vmstate_pcm26d2ca_pci =3D {
+    .name =3D TYPE_CAN_PCI_DEV,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, Pcm26D2CAPCIeState),
+        VMSTATE_STRUCT(sja_state[0], Pcm26D2CAPCIeState, 0, vmstate_can_sj=
a,
+                       CanSJA1000State),
+        VMSTATE_STRUCT(sja_state[1], Pcm26D2CAPCIeState, 0, vmstate_can_sj=
a,
+                       CanSJA1000State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pcm26d2ca_pci_instance_init(Object *obj)
+{
+    Pcm26D2CAPCIeState *d =3D PCM26D2CA_PCI_DEV(obj);
+
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[0],
+                             qdev_prop_allow_set_link_before_realize,
+                             0);
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[1],
+                             qdev_prop_allow_set_link_before_realize,
+                             0);
+}
+
+static void pcm26d2ca_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->realize =3D pcm26d2ca_pci_realize;
+    k->exit =3D pcm26d2ca_pci_exit;
+    k->vendor_id =3D PCM26D2CA_PCI_VENDOR_ID1;
+    k->device_id =3D PCM26D2CA_PCI_DEVICE_ID1;
+    k->revision =3D 0x00;
+    k->class_id =3D 0x000c09;
+    k->subsystem_vendor_id =3D PCM26D2CA_PCI_VENDOR_ID1;
+    k->subsystem_id =3D PCM26D2CA_PCI_DEVICE_ID1;
+    dc->desc =3D "PCM-26 series Advantech iDoor";
+    dc->vmsd =3D &vmstate_pcm26d2ca_pci;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->reset =3D pcm26d2ca_pci_reset;
+}
+
+static const TypeInfo pcm26d2ca_pci_info =3D {
+    .name          =3D TYPE_CAN_PCI_DEV,
+    .parent        =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(Pcm26D2CAPCIeState),
+    .class_init    =3D pcm26d2ca_pci_class_init,
+    .instance_init =3D pcm26d2ca_pci_instance_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void pcm26d2ca_pci_register_types(void)
+{
+    type_register_static(&pcm26d2ca_pci_info);
+}
+
+type_init(pcm26d2ca_pci_register_types)
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 73201f9139..ba75e6f35b 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -29,6 +29,8 @@
 #include "qemu/log.h"
 #include "chardev/char.h"
 #include "hw/irq.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"

@@ -401,10 +403,58 @@ static int frame2buff_bas(const qemu_can_frame *frame=
, uint8_t *buff)
     return dlen + 2;
 }

+static void can_sja_update_pcie_msi(CanSJA1000State *s, uint8_t interrupt_=
reg)
+{
+    int i;
+
+    if (s->pci_dev =3D=3D NULL) {
+        return;
+    }
+
+    if (!msi_enabled(s->pci_dev)) {
+        return;
+    }
+
+    /* Trigger MSI vectors associated to interrupts */
+    for (i =3D 0; i < NUM_MSI_IRQ; ++i) {
+        if (interrupt_reg & (1 << i)) {
+            msi_notify(s->pci_dev, s->msi_map[i]);
+        }
+    }
+}
+
+static void can_sja_update_pcie_msix(CanSJA1000State *s, uint8_t interrupt=
_reg)
+{
+    int i;
+
+    if (s->pci_dev =3D=3D NULL) {
+        return;
+    }
+
+    if (!msix_enabled(s->pci_dev)) {
+        return;
+    }
+
+    /* Trigger MSI-X vectors associated to interrupts */
+    for (i =3D 0; i < NUM_MSIX_IRQ; ++i) {
+        if (interrupt_reg & (1 << i)) {
+            msix_notify(s->pci_dev, s->msix_map[i]);
+        }
+    }
+}
+
 static void can_sja_update_pel_irq(CanSJA1000State *s)
 {
     if (s->interrupt_en & s->interrupt_pel) {
         qemu_irq_raise(s->irq);
+
+        if (s->pci_dev && msi_enabled(s->pci_dev)) {
+            can_sja_update_pcie_msi(s, s->interrupt_pel);
+        }
+
+        if (s->pci_dev && msix_enabled(s->pci_dev)) {
+            can_sja_update_pcie_msix(s, s->interrupt_pel);
+        }
     } else {
         qemu_irq_lower(s->irq);
     }
@@ -414,6 +464,14 @@ static void can_sja_update_bas_irq(CanSJA1000State *s)
 {
     if ((s->control >> 1) & s->interrupt_bas) {
         qemu_irq_raise(s->irq);
+
+        if (msi_enabled(s->pci_dev)) {
+            can_sja_update_pcie_msi(s, s->interrupt_pel);
+        }
+
+        if (msix_enabled(s->pci_dev)) {
+            can_sja_update_pcie_msix(s, s->interrupt_pel);
+        }
     } else {
         qemu_irq_lower(s->irq);
     }
@@ -916,8 +974,18 @@ void can_sja_disconnect(CanSJA1000State *s)

 int can_sja_init(CanSJA1000State *s, qemu_irq irq)
 {
+    int i;
     s->irq =3D irq;

+    s->pci_dev =3D NULL;
+    for (i =3D 0; i < NUM_MSI_IRQ; i++) {
+        s->msi_map[i] =3D 0;
+    }
+
+    for (i =3D 0; i < NUM_MSIX_IRQ; i++) {
+        s->msix_map[i] =3D 0;
+    }
+
     qemu_irq_lower(s->irq);

     can_sja_hardware_reset(s);
@@ -925,6 +993,29 @@ int can_sja_init(CanSJA1000State *s, qemu_irq irq)
     return 0;
 }

+int can_sja_cap_init(CanSJA1000State *s, qemu_irq irq, PCIDevice *pci_dev,
+                     uint8_t *msi_map, uint8_t *msix_map)
+{
+    int i;
+    can_sja_init(s, irq); /* Perform base init */
+
+    s->pci_dev =3D pci_dev;
+
+    if (msi_map) {
+        for (i =3D 0; i < NUM_MSI_IRQ; i++) {
+            s->msi_map[i] =3D msi_map[i];
+        }
+    }
+
+    if (msix_map) {
+        for (i =3D 0; i < NUM_MSIX_IRQ; i++) {
+            s->msix_map[i] =3D msix_map[i];
+        }
+    }
+
+    return 0;
+}
+
 const VMStateDescription vmstate_qemu_can_filter =3D {
     .name =3D "qemu_can_filter",
     .version_id =3D 1,
diff --git a/hw/net/can/can_sja1000.h b/hw/net/can/can_sja1000.h
index 7ca9cd681e..f016c37fd8 100644
--- a/hw/net/can/can_sja1000.h
+++ b/hw/net/can/can_sja1000.h
@@ -37,6 +37,10 @@
 /* The receive buffer size. */
 #define SJA_RCV_BUF_LEN       64

+/* Number of MSI/MSI-X interrupt vectors */
+#define NUM_MSI_IRQ           8
+#define NUM_MSIX_IRQ          NUM_MSI_IRQ
+
 typedef struct CanSJA1000State {
     /* PeliCAN state and registers sorted by address */
     uint8_t         mode;          /* 0  .. Mode register, DS-p26 */
@@ -68,6 +72,11 @@ typedef struct CanSJA1000State {

     qemu_irq          irq;
     CanBusClientState bus_client;
+
+    /* PCIe MSI */
+    PCIDevice       *pci_dev;
+    uint8_t         msi_map[NUM_MSI_IRQ];   /* MSI map entry to interrupt =
*/
+    uint8_t         msix_map[NUM_MSIX_IRQ]; /* MSI-X map entry to interrup=
t */
 } CanSJA1000State;

 /* PeliCAN mode */
@@ -137,6 +146,9 @@ void can_sja_disconnect(CanSJA1000State *s);

 int can_sja_init(CanSJA1000State *s, qemu_irq irq);

+int can_sja_cap_init(CanSJA1000State *s, qemu_irq irq, PCIDevice *pci_dev,
+                     uint8_t *msi_map, uint8_t *msix_map);
+
 bool can_sja_can_receive(CanBusClientState *client);

 ssize_t can_sja_receive(CanBusClientState *client,
diff --git a/hw/net/can/meson.build b/hw/net/can/meson.build
index 7382344628..ee9cd692ff 100644
--- a/hw/net/can/meson.build
+++ b/hw/net/can/meson.build
@@ -2,6 +2,7 @@ system_ss.add(when: 'CONFIG_CAN_SJA1000', if_true: files('c=
an_sja1000.c'))
 system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_kvaser_pci.c'))
 system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm3680_pci.c'))
 system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_mioe3680_pci.c')=
)
+system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm26d2ca_pci.c'=
))
 system_ss.add(when: 'CONFIG_CAN_CTUCANFD', if_true: files('ctucan_core.c')=
)
 system_ss.add(when: 'CONFIG_CAN_CTUCANFD_PCI', if_true: files('ctucan_pci.=
c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-can.=
c'))
--
2.34.1


--_000_SL2P216MB127768FA6920A17C232EFD9292AFASL2P216MB1277KORP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"ltr">
<div></div>
<div>
<div dir=3D"ltr">Hi,</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Just wonder<span>ing if I need to do&nbsp;<span>anything e=
lse to get this patch across the line? It's basically support for a new typ=
e of CANbus device with PCI MSI capability, which hasn't been supported bef=
ore in QEmu CAN stack.<span></span></span><span></span></span></div>
<div dir=3D"ltr"><span><span><br>
</span></span></div>
<div dir=3D"ltr"><span><span><br>
</span></span></div>
<div dir=3D"ltr"><span><span><br>
</span></span></div>
<div dir=3D"ltr"><span><span>Best regards,</span></span></div>
<div dir=3D"ltr"><span><span>Deniz</span></span></div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deniz Eren &lt;deniz.=
eren314@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, November 7, 2023 4:26:57 PM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> deniz.eren314@gmail.com &lt;deniz.eren314@gmail.com&gt;; Deniz E=
ren &lt;deniz.eren@outlook.com&gt;<br>
<b>Subject:</b> [PATCH] Implementation of SJA1000 CAN-bus devices that supp=
ort MSI (PCI capability 0x05). - Implementation of multiple MSI vector supp=
ort for SJA1000 devices. - Added can_pcm26d2ca_pci.c; support for Advantech=
 iDoor Module (PCM-26D2CA): 2-Ports
 Isolate...</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: Deniz Eren &lt;deniz.eren@outlook.c=
om&gt;<br>
---<br>
&nbsp;hw/net/can/can_pcm26d2ca_pci.c | 281 ++++++++++++++++++++++++++++++++=
+<br>
&nbsp;hw/net/can/can_sja1000.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; =
91 +++++++++++<br>
&nbsp;hw/net/can/can_sja1000.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; =
12 ++<br>
&nbsp;hw/net/can/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 1 +<br>
&nbsp;4 files changed, 385 insertions(+)<br>
&nbsp;create mode 100644 hw/net/can/can_pcm26d2ca_pci.c<br>
<br>
diff --git a/hw/net/can/can_pcm26d2ca_pci.c b/hw/net/can/can_pcm26d2ca_pci.=
c<br>
new file mode 100644<br>
index 0000000000..af1dd4c7bb<br>
--- /dev/null<br>
+++ b/hw/net/can/can_pcm26d2ca_pci.c<br>
@@ -0,0 +1,281 @@<br>
+/*<br>
+ * PCM-26D2CA PCIe CAN device (SJA1000 based) emulation<br>
+ *<br>
+ * Advantech iDoor Module: 2-Ports Isolated CANBus mPCIe, DB9<br>
+ *<br>
+ * Copyright (c) 2023 Deniz Eren (deniz.eren@icloud.com)<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy<br>
+ * of this software and associated documentation files (the &quot;Software=
&quot;), to deal<br>
+ * in the Software without restriction, including without limitation the r=
ights<br>
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll<br>
+ * copies of the Software, and to permit persons to whom the Software is<b=
r>
+ * furnished to do so, subject to the following conditions:<br>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
<br>
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER<br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,<br>
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN<br>
+ * THE SOFTWARE.<br>
+ */<br>
+<br>
+#include &quot;qemu/units.h&quot;<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/event_notifier.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;qemu/thread.h&quot;<br>
+#include &quot;qemu/sockets.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;chardev/char.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+#include &quot;hw/pci/pci_device.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/pci/msi.h&quot;<br>
+#include &quot;migration/vmstate.h&quot;<br>
+#include &quot;net/can_emu.h&quot;<br>
+<br>
+#include &quot;can_sja1000.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+<br>
+#define TYPE_CAN_PCI_DEV &quot;pcm26d2ca_pci&quot;<br>
+<br>
+typedef struct Pcm26D2CAPCIeState Pcm26D2CAPCIeState;<br>
+DECLARE_INSTANCE_CHECKER(Pcm26D2CAPCIeState, PCM26D2CA_PCI_DEV,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE=
_CAN_PCI_DEV)<br>
+<br>
+/* the PCI device and vendor IDs */<br>
+#ifndef PCM26D2CA_PCI_VENDOR_ID1<br>
+#define PCM26D2CA_PCI_VENDOR_ID1&nbsp;&nbsp;&nbsp; 0x13fe<br>
+#endif<br>
+<br>
+#ifndef PCM26D2CA_PCI_DEVICE_ID1<br>
+#define PCM26D2CA_PCI_DEVICE_ID1&nbsp;&nbsp;&nbsp; 0x00d7<br>
+#endif<br>
+<br>
+#define PCM26D2CA_PCI_SJA_COUNT&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define PCM26D2CA_PCI_SJA_RANGE&nbsp;&nbsp;&nbsp;&nbsp; 0x400<br>
+<br>
+#define PCM26D2CA_PCI_BYTES_PER_SJA 0x80<br>
+<br>
+#define PCM26D2CA_IO_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0<br>
+<br>
+#define PCM26D2CA_MSI_VEC_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (8)<br>
+#define PCM26D2CA_MSI_RI_ENTRY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0) /* Receiv=
e interrupt */<br>
+#define PCM26D2CA_MSI_TI_ENTRY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1) /* Transm=
it interrupt */<br>
+#define PCM26D2CA_MSI_EI_ENTRY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2) /* Error =
warning interrupt */<br>
+#define PCM26D2CA_MSI_DOI_ENTRY&nbsp;&nbsp;&nbsp;&nbsp; (3) /* Data overru=
n interrupt */<br>
+#define PCM26D2CA_MSI_WUI_ENTRY&nbsp;&nbsp;&nbsp;&nbsp; (4) /* Wakeup inte=
rrupt */<br>
+#define PCM26D2CA_MSI_EPI_ENTRY&nbsp;&nbsp;&nbsp;&nbsp; (5) /* Error passi=
ve */<br>
+#define PCM26D2CA_MSI_ALI_ENTRY&nbsp;&nbsp;&nbsp;&nbsp; (6) /* Arbitration=
 lost */<br>
+#define PCM26D2CA_MSI_BEI_ENTRY&nbsp;&nbsp;&nbsp;&nbsp; (7) /* Bus error i=
nterrupt */<br>
+<br>
+struct Pcm26D2CAPCIeState {<br>
+&nbsp;&nbsp;&nbsp; /*&lt; private &gt;*/<br>
+&nbsp;&nbsp;&nbsp; PCIDevice&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev;<br>
+&nbsp;&nbsp;&nbsp; /*&lt; public &gt;*/<br>
+&nbsp;&nbsp;&nbsp; MemoryRegion&nbsp;&nbsp;&nbsp; io;<br>
+<br>
+&nbsp;&nbsp;&nbsp; CanSJA1000State sja_state[PCM26D2CA_PCI_SJA_COUNT];<br>
+&nbsp;&nbsp;&nbsp; qemu_irq&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *model; /* The model that support, only SJA1000 now. */<br>
+&nbsp;&nbsp;&nbsp; CanBusState&nbsp;&nbsp;&nbsp;&nbsp; *canbus[PCM26D2CA_P=
CI_SJA_COUNT];<br>
+};<br>
+<br>
+static void pcm26d2ca_pci_reset(DeviceState *dev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; Pcm26D2CAPCIeState *d =3D PCM26D2CA_PCI_DEV(dev);<br>
+&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp; for (i =3D 0 ; i &lt; PCM26D2CA_PCI_SJA_COUNT; i++) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can_sja_hardware_reset(&amp;d-&=
gt;sja_state[i]);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+static uint64_t pcm26d2ca_pci_io_read(void *opaque, hwaddr addr, unsigned =
size)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; Pcm26D2CAPCIeState *d =3D opaque;<br>
+&nbsp;&nbsp;&nbsp; CanSJA1000State *s =3D &amp;d-&gt;sja_state[0];<br>
+&nbsp;&nbsp;&nbsp; hwaddr _addr =3D addr;<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (addr &gt;=3D PCM26D2CA_PCI_SJA_RANGE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s =3D &amp;d-&gt;sja_state[1];<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _addr -=3D PCM26D2CA_PCI_SJA_RA=
NGE;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (_addr &gt;=3D PCM26D2CA_PCI_BYTES_PER_SJA) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; return can_sja_mem_read(s, _addr &gt;&gt; 2, size);<br>
+}<br>
+<br>
+static void pcm26d2ca_pci_io_write(void *opaque, hwaddr addr, uint64_t dat=
a,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned size)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; Pcm26D2CAPCIeState *d =3D opaque;<br>
+&nbsp;&nbsp;&nbsp; CanSJA1000State *s =3D &amp;d-&gt;sja_state[0];<br>
+&nbsp;&nbsp;&nbsp; hwaddr _addr =3D addr;<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (addr &gt;=3D PCM26D2CA_PCI_SJA_RANGE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s =3D &amp;d-&gt;sja_state[1];<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _addr -=3D PCM26D2CA_PCI_SJA_RA=
NGE;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (_addr &gt;=3D PCM26D2CA_PCI_BYTES_PER_SJA) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; can_sja_mem_write(s, _addr &gt;&gt; 2, data, size);<br>
+}<br>
+<br>
+static const MemoryRegionOps pcm26d2ca_pci_io_ops =3D {<br>
+&nbsp;&nbsp;&nbsp; .read =3D pcm26d2ca_pci_io_read,<br>
+&nbsp;&nbsp;&nbsp; .write =3D pcm26d2ca_pci_io_write,<br>
+&nbsp;&nbsp;&nbsp; .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
+&nbsp;&nbsp;&nbsp; .impl =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_access_size =3D 1,<br>
+&nbsp;&nbsp;&nbsp; },<br>
+};<br>
+<br>
+static void pcm26d2ca_pci_realize(PCIDevice *pci_dev, Error **errp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; static const uint16_t pcie_offset =3D 0x0E0;<br>
+&nbsp;&nbsp;&nbsp; Pcm26D2CAPCIeState *d =3D PCM26D2CA_PCI_DEV(pci_dev);<b=
r>
+&nbsp;&nbsp;&nbsp; uint8_t *pci_conf;<br>
+&nbsp;&nbsp;&nbsp; Error *err =3D NULL;<br>
+&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Map MSI and MSI-X vector entries one-to-one for each=
 interrupt */<br>
+&nbsp;&nbsp;&nbsp; uint8_t msi_map[PCM26D2CA_MSI_VEC_NUM] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCM26D2CA_MSI_RI_ENTRY,&nbsp; /=
* Receive interrupt */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCM26D2CA_MSI_TI_ENTRY,&nbsp; /=
* Transmit interrupt */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCM26D2CA_MSI_EI_ENTRY,&nbsp; /=
* Error warning interrupt */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCM26D2CA_MSI_DOI_ENTRY, /* Dat=
a overrun interrupt */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCM26D2CA_MSI_WUI_ENTRY, /* Wak=
eup interrupt */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCM26D2CA_MSI_EPI_ENTRY, /* Err=
or passive */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCM26D2CA_MSI_ALI_ENTRY, /* Arb=
itration lost */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCM26D2CA_MSI_BEI_ENTRY&nbsp; /=
* Bus error interrupt */<br>
+&nbsp;&nbsp;&nbsp; };<br>
+<br>
+&nbsp;&nbsp;&nbsp; pci_conf =3D pci_dev-&gt;config;<br>
+&nbsp;&nbsp;&nbsp; pci_conf[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin =
A */<br>
+<br>
+&nbsp;&nbsp;&nbsp; d-&gt;irq =3D pci_allocate_irq(&amp;d-&gt;dev);<br>
+<br>
+&nbsp;&nbsp;&nbsp; for (i =3D 0 ; i &lt; PCM26D2CA_PCI_SJA_COUNT; i++) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can_sja_cap_init(&amp;d-&gt;sja=
_state[i], d-&gt;irq, pci_dev, msi_map, msi_map);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; for (i =3D 0 ; i &lt; PCM26D2CA_PCI_SJA_COUNT; i++) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (can_sja_connect_to_bus(&amp=
;d-&gt;sja_state[i], d-&gt;canbus[i]) &lt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_s=
etg(errp, &quot;can_sja_connect_to_bus failed&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; memory_region_init_io(&amp;d-&gt;io, OBJECT(d), &amp;pc=
m26d2ca_pci_io_ops,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; d, &quot;pcm26d2ca_pci-io&quot;, 2*PCM26D2CA_PCI_SJA_RANGE);<br>
+&nbsp;&nbsp;&nbsp; pci_register_bar(&amp;d-&gt;dev, PCM26D2CA_IO_IDX,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI_BASE_ADDRESS_SPACE_MEMOR=
Y, &amp;d-&gt;io);<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (pcie_endpoint_cap_v1_init(pci_dev, pcie_offset) &lt=
; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Failed t=
o initialize PCIe capability&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; ret =3D msi_init( PCI_DEVICE(d), 0xD0, PCM26D2CA_MSI_VE=
C_NUM,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true, f=
alse, NULL );<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;msi_init=
 failed (%d)&quot;, ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; error_free(err);<br>
+}<br>
+<br>
+static void pcm26d2ca_pci_exit(PCIDevice *pci_dev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; Pcm26D2CAPCIeState *d =3D PCM26D2CA_PCI_DEV(pci_dev);<b=
r>
+&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp; for (i =3D 0 ; i &lt; PCM26D2CA_PCI_SJA_COUNT; i++) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can_sja_disconnect(&amp;d-&gt;s=
ja_state[i]);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; qemu_free_irq(d-&gt;irq);<br>
+&nbsp;&nbsp;&nbsp; msi_uninit(pci_dev);<br>
+}<br>
+<br>
+static const VMStateDescription vmstate_pcm26d2ca_pci =3D {<br>
+&nbsp;&nbsp;&nbsp; .name =3D TYPE_CAN_PCI_DEV,<br>
+&nbsp;&nbsp;&nbsp; .version_id =3D 1,<br>
+&nbsp;&nbsp;&nbsp; .minimum_version_id =3D 1,<br>
+&nbsp;&nbsp;&nbsp; .fields =3D (VMStateField[]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_PCI_DEVICE(dev, Pcm26D2=
CAPCIeState),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_STRUCT(sja_state[0], Pc=
m26D2CAPCIeState, 0, vmstate_can_sja,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CanSJA1000State)=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_STRUCT(sja_state[1], Pc=
m26D2CAPCIeState, 0, vmstate_can_sja,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CanSJA1000State)=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_END_OF_LIST()<br>
+&nbsp;&nbsp;&nbsp; }<br>
+};<br>
+<br>
+static void pcm26d2ca_pci_instance_init(Object *obj)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; Pcm26D2CAPCIeState *d =3D PCM26D2CA_PCI_DEV(obj);<br>
+<br>
+&nbsp;&nbsp;&nbsp; object_property_add_link(obj, &quot;canbus0&quot;, TYPE=
_CAN_BUS,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (Object **)&amp;d-&gt;canbus[0],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; qdev_prop_allow_set_link_before_realize,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0);<br>
+&nbsp;&nbsp;&nbsp; object_property_add_link(obj, &quot;canbus1&quot;, TYPE=
_CAN_BUS,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (Object **)&amp;d-&gt;canbus[1],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; qdev_prop_allow_set_link_before_realize,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0);<br>
+}<br>
+<br>
+static void pcm26d2ca_pci_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+&nbsp;&nbsp;&nbsp; PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);<br>
+<br>
+&nbsp;&nbsp;&nbsp; k-&gt;realize =3D pcm26d2ca_pci_realize;<br>
+&nbsp;&nbsp;&nbsp; k-&gt;exit =3D pcm26d2ca_pci_exit;<br>
+&nbsp;&nbsp;&nbsp; k-&gt;vendor_id =3D PCM26D2CA_PCI_VENDOR_ID1;<br>
+&nbsp;&nbsp;&nbsp; k-&gt;device_id =3D PCM26D2CA_PCI_DEVICE_ID1;<br>
+&nbsp;&nbsp;&nbsp; k-&gt;revision =3D 0x00;<br>
+&nbsp;&nbsp;&nbsp; k-&gt;class_id =3D 0x000c09;<br>
+&nbsp;&nbsp;&nbsp; k-&gt;subsystem_vendor_id =3D PCM26D2CA_PCI_VENDOR_ID1;=
<br>
+&nbsp;&nbsp;&nbsp; k-&gt;subsystem_id =3D PCM26D2CA_PCI_DEVICE_ID1;<br>
+&nbsp;&nbsp;&nbsp; dc-&gt;desc =3D &quot;PCM-26 series Advantech iDoor&quo=
t;;<br>
+&nbsp;&nbsp;&nbsp; dc-&gt;vmsd =3D &amp;vmstate_pcm26d2ca_pci;<br>
+&nbsp;&nbsp;&nbsp; set_bit(DEVICE_CATEGORY_MISC, dc-&gt;categories);<br>
+&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D pcm26d2ca_pci_reset;<br>
+}<br>
+<br>
+static const TypeInfo pcm26d2ca_pci_info =3D {<br>
+&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D TYPE_CAN_PCI_DEV,<br>
+&nbsp;&nbsp;&nbsp; .parent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D T=
YPE_PCI_DEVICE,<br>
+&nbsp;&nbsp;&nbsp; .instance_size =3D sizeof(Pcm26D2CAPCIeState),<br>
+&nbsp;&nbsp;&nbsp; .class_init&nbsp;&nbsp;&nbsp; =3D pcm26d2ca_pci_class_i=
nit,<br>
+&nbsp;&nbsp;&nbsp; .instance_init =3D pcm26d2ca_pci_instance_init,<br>
+&nbsp;&nbsp;&nbsp; .interfaces =3D (InterfaceInfo[]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { INTERFACE_PCIE_DEVICE },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { }<br>
+&nbsp;&nbsp;&nbsp; },<br>
+};<br>
+<br>
+static void pcm26d2ca_pci_register_types(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; type_register_static(&amp;pcm26d2ca_pci_info);<br>
+}<br>
+<br>
+type_init(pcm26d2ca_pci_register_types)<br>
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c<br>
index 73201f9139..ba75e6f35b 100644<br>
--- a/hw/net/can/can_sja1000.c<br>
+++ b/hw/net/can/can_sja1000.c<br>
@@ -29,6 +29,8 @@<br>
&nbsp;#include &quot;qemu/log.h&quot;<br>
&nbsp;#include &quot;chardev/char.h&quot;<br>
&nbsp;#include &quot;hw/irq.h&quot;<br>
+#include &quot;hw/pci/msi.h&quot;<br>
+#include &quot;hw/pci/msix.h&quot;<br>
&nbsp;#include &quot;migration/vmstate.h&quot;<br>
&nbsp;#include &quot;net/can_emu.h&quot;<br>
&nbsp;<br>
@@ -401,10 +403,58 @@ static int frame2buff_bas(const qemu_can_frame *frame=
, uint8_t *buff)<br>
&nbsp;&nbsp;&nbsp;&nbsp; return dlen + 2;<br>
&nbsp;}<br>
&nbsp;<br>
+static void can_sja_update_pcie_msi(CanSJA1000State *s, uint8_t interrupt_=
reg)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (s-&gt;pci_dev =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (!msi_enabled(s-&gt;pci_dev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Trigger MSI vectors associated to interrupts */<br>
+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; NUM_MSI_IRQ; ++i) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (interrupt_reg &amp; (1 &lt;=
&lt; i)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msi_not=
ify(s-&gt;pci_dev, s-&gt;msi_map[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+static void can_sja_update_pcie_msix(CanSJA1000State *s, uint8_t interrupt=
_reg)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (s-&gt;pci_dev =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (!msix_enabled(s-&gt;pci_dev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Trigger MSI-X vectors associated to interrupts */<br=
>
+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; NUM_MSIX_IRQ; ++i) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (interrupt_reg &amp; (1 &lt;=
&lt; i)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msix_no=
tify(s-&gt;pci_dev, s-&gt;msix_map[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
&nbsp;static void can_sja_update_pel_irq(CanSJA1000State *s)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;interrupt_en &amp; s-&gt;interrupt_pel) =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_irq_raise(s-&gt;irq);=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;pci_dev &amp;&amp; ms=
i_enabled(s-&gt;pci_dev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can_sja=
_update_pcie_msi(s, s-&gt;interrupt_pel);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;pci_dev &amp;&amp; ms=
ix_enabled(s-&gt;pci_dev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can_sja=
_update_pcie_msix(s, s-&gt;interrupt_pel);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_irq_lower(s-&gt;irq);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -414,6 +464,14 @@ static void can_sja_update_bas_irq(CanSJA1000State *s)=
<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; if ((s-&gt;control &gt;&gt; 1) &amp; s-&gt;interru=
pt_bas) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_irq_raise(s-&gt;irq);=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msi_enabled(s-&gt;pci_dev))=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can_sja=
_update_pcie_msi(s, s-&gt;interrupt_pel);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msix_enabled(s-&gt;pci_dev)=
) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; can_sja=
_update_pcie_msix(s, s-&gt;interrupt_pel);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_irq_lower(s-&gt;irq);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -916,8 +974,18 @@ void can_sja_disconnect(CanSJA1000State *s)<br>
&nbsp;<br>
&nbsp;int can_sja_init(CanSJA1000State *s, qemu_irq irq)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;irq =3D irq;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp; s-&gt;pci_dev =3D NULL;<br>
+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; NUM_MSI_IRQ; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;msi_map[i] =3D 0;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; NUM_MSIX_IRQ; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;msix_map[i] =3D 0;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; qemu_irq_lower(s-&gt;irq);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; can_sja_hardware_reset(s);<br>
@@ -925,6 +993,29 @@ int can_sja_init(CanSJA1000State *s, qemu_irq irq)<br>
&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+int can_sja_cap_init(CanSJA1000State *s, qemu_irq irq, PCIDevice *pci_dev,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *msi_map, uint8_t *m=
six_map)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp; can_sja_init(s, irq); /* Perform base init */<br>
+<br>
+&nbsp;&nbsp;&nbsp; s-&gt;pci_dev =3D pci_dev;<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (msi_map) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; NUM_MSI_IR=
Q; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;m=
si_map[i] =3D msi_map[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (msix_map) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; NUM_MSIX_I=
RQ; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;m=
six_map[i] =3D msix_map[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;const VMStateDescription vmstate_qemu_can_filter =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;qemu_can_filter&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp; .version_id =3D 1,<br>
diff --git a/hw/net/can/can_sja1000.h b/hw/net/can/can_sja1000.h<br>
index 7ca9cd681e..f016c37fd8 100644<br>
--- a/hw/net/can/can_sja1000.h<br>
+++ b/hw/net/can/can_sja1000.h<br>
@@ -37,6 +37,10 @@<br>
&nbsp;/* The receive buffer size. */<br>
&nbsp;#define SJA_RCV_BUF_LEN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64<br>
&nbsp;<br>
+/* Number of MSI/MSI-X interrupt vectors */<br>
+#define NUM_MSI_IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 8<br>
+#define NUM_MSIX_IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 NUM_MSI_IRQ<br>
+<br>
&nbsp;typedef struct CanSJA1000State {<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* PeliCAN state and registers sorted by address *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; mode;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 0&nbsp=
; .. Mode register, DS-p26 */<br>
@@ -68,6 +72,11 @@ typedef struct CanSJA1000State {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; qemu_irq&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; irq;<br>
&nbsp;&nbsp;&nbsp;&nbsp; CanBusClientState bus_client;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* PCIe MSI */<br>
+&nbsp;&nbsp;&nbsp; PCIDevice&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pci_dev;=
<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 msi_map[NUM_MSI_IRQ];&nbsp;&nbsp; /* MSI map entry to interrupt */<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 msix_map[NUM_MSIX_IRQ]; /* MSI-X map entry to interrupt */<br>
&nbsp;} CanSJA1000State;<br>
&nbsp;<br>
&nbsp;/* PeliCAN mode */<br>
@@ -137,6 +146,9 @@ void can_sja_disconnect(CanSJA1000State *s);<br>
&nbsp;<br>
&nbsp;int can_sja_init(CanSJA1000State *s, qemu_irq irq);<br>
&nbsp;<br>
+int can_sja_cap_init(CanSJA1000State *s, qemu_irq irq, PCIDevice *pci_dev,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *msi_map, uint8_t *m=
six_map);<br>
+<br>
&nbsp;bool can_sja_can_receive(CanBusClientState *client);<br>
&nbsp;<br>
&nbsp;ssize_t can_sja_receive(CanBusClientState *client,<br>
diff --git a/hw/net/can/meson.build b/hw/net/can/meson.build<br>
index 7382344628..ee9cd692ff 100644<br>
--- a/hw/net/can/meson.build<br>
+++ b/hw/net/can/meson.build<br>
@@ -2,6 +2,7 @@ system_ss.add(when: 'CONFIG_CAN_SJA1000', if_true: files('c=
an_sja1000.c'))<br>
&nbsp;system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_kvaser_pci.=
c'))<br>
&nbsp;system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm3680_pci=
.c'))<br>
&nbsp;system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_mioe3680_pc=
i.c'))<br>
+system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm26d2ca_pci.c'=
))<br>
&nbsp;system_ss.add(when: 'CONFIG_CAN_CTUCANFD', if_true: files('ctucan_cor=
e.c'))<br>
&nbsp;system_ss.add(when: 'CONFIG_CAN_CTUCANFD_PCI', if_true: files('ctucan=
_pci.c'))<br>
&nbsp;system_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp=
-can.c'))<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SL2P216MB127768FA6920A17C232EFD9292AFASL2P216MB1277KORP_--

