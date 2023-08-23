Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3897853C3
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:23:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYk4D-0005Q3-8i; Wed, 23 Aug 2023 05:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qYk4B-0005P7-5u; Wed, 23 Aug 2023 05:22:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qYk48-0005M3-U7; Wed, 23 Aug 2023 05:22:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id D8B825C0172;
 Wed, 23 Aug 2023 05:22:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 23 Aug 2023 05:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1692782535; x=1692868935; bh=7glaXVaoAMls38G1n3rfWgwmY
 uCkgcrj52R7D8xj+IA=; b=vxFxee+Sm3AWV0j26j2uUH2LuvtWuBveBXSePK6GW
 QcgWEpeuqEyloLQgquh/bR+Qa/FFPcZ1E9c2DMlLgePsv5BkcQMPFhttfPcyGYr9
 Gh0Y2SxvpMtCxHNEh5I/P69pzIfBHc0dBgk3XbpNyHT8hI3fLfuTYjOUNNki2HJ4
 J65M5qHF8U+2XNhaMCtFCyYZYRr/TX4//nty6s1FfrnnX2gMjmyfBm+URjFFwj1F
 iIZ34dMf6Y6ll/7w55gW85+IKs3afczZ3q0yNHAo7Vz98EtyVsvzqwAaRlT64Er6
 uqtqpofs/vzjQVh13s2TEbpMyRRXaY6pdlrqTC1xGGULQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1692782535; x=1692868935; bh=7glaXVaoAMls38G1n3rfWgwmYuCkgcrj52R
 7D8xj+IA=; b=gTtxM1HTSgEYkOHvSFHq+9Ka7mYBu2KDBJrqt68nj31ZWTep9pI
 7zxhCFAy61IIruYYYAP80kVKCuKensqFkV0VYYGl9F05EwKqKBw83U0r/CXsluCd
 6RRRBFN6Ln6cdh2fiiq7MDFVEfchJdSNruvB6RPQo/EvHd1PuLEIWSKZkkF419N8
 kW7R5B9sW24+vHb57LTJMfbpgWufl1wWqr7ymMEq5fnSUAKl/3Gkh+nKarMMAIAt
 JhU1wzchgatLXz3u1elJaIZHIUL8kQ/SpIVKFzb+mI5pe6lqfC8okEGA5yDhcetI
 ktm6lK1sUc6F+inLu/ud7NGIslnuQvZaC1Q==
X-ME-Sender: <xms:x8_lZDE5dp-vRXYWxQNFmxmpfXnC7Zn5hxH8Jb6HLTdlwCcMYTTd5A>
 <xme:x8_lZAV82pv-oWWqCn_uNZ7zu-GPQ9eZg0eAzbDZ1dzKcFHKwI36wwKF-jEw62qYJ
 hkNYvcC6Vsog1VpcJ8>
X-ME-Received: <xmr:x8_lZFKkb0mWA_jO2iaHN8cP26bHYS2zzIYo1rlX6rLDtSY1buYb_ettgribqRR34iX5xGuTGL0WsUaA7YSV76WFXkrcb9D_Tt6FxTHlyCun_XhFpUy7gDz9c5gS_CtWp0deF4ZBogms3WmLTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudevgefgffeiteevfffhhefg
 gefhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:x8_lZBEPpm45okovtsS4ispnKD6PZBEjKw6kT-eTytuIOcKcv5w0mQ>
 <xmx:x8_lZJV0LSweCpDq_14lkspHZ-Xme4kupFqy4NEu50ZCHKjqN0C3cA>
 <xmx:x8_lZMMdW9YC2s-XFy9UKF-HqDXza-igcG962E8NYTbJTigwoKBA-w>
 <xmx:x8_lZOWYmVMreNk4su_SVAR5SkpmDbW--nqoT77VRrHgOrDMDMD4Uw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 05:22:13 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 23 Aug 2023 11:22:00 +0200
Subject: [PATCH v4 3/3] hw/nvme: add nvme management interface model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-nmi-i2c-v4-3-2b0f86e5be25@samsung.com>
References: <20230823-nmi-i2c-v4-0-2b0f86e5be25@samsung.com>
In-Reply-To: <20230823-nmi-i2c-v4-0-2b0f86e5be25@samsung.com>
To: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 Keith Busch <kbusch@kernel.org>
Cc: Lior Weintraub <liorw@pliops.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, Peter Delevoryas <peter@pjd.dev>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13194; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=mernA+RE3iSkd5we3CxZxEqWGX2CATOsesxQakE+F/s=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTlz71eui3jzGkzKK8I9Lqnq5b7TSEmuwTXs
 Rq1f+Z5VkH1ookBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk5c+9AAoJEE3hrzFt
 Tw3pJS0H/jOTN80SWgxR0y40e/ciKmzONCQnLnkzI1/Em6yso6cT5LXwZyx7DIWQP8IiLKdRKHj
 tWZyxIh6yoVIaXd/eHfMEk9Rlc+zTw28GdXYdJcEA8wZtymiCNKLPL1CPqKOaR8OTYxz/hK4HIv
 f4aCWnkbPGKp9XK0sFBPlttF29vZXXdlPgBmvVJJLTUBzxcJIa6ml7TYT8uoeRvf1214AGqOfXa
 n23q6+GU5EcER/0jz5JwC+xYVF6ErIfOcKiQ5zsfgI6lf02THbuqlpXwCVl5wg1SE/DJGXGwcuO
 Z3cKlTw6Uj7BwNpz2ImRrZfiPeRAQPkNSep3jZ1hOu4wLFuM1cOzdaht
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=66.111.4.25; envelope-from=its@irrelevant.dk;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Add the 'nmi-i2c' device that emulates an NVMe Management Interface
controller.

Initial support is very basic (Read NMI DS, Configuration Get).

This is based on previously posted code by Padmakar Kalghatgi, Arun
Kumar Agasar and Saurav Kumar.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/Kconfig      |   4 +
 hw/nvme/meson.build  |   1 +
 hw/nvme/nmi-i2c.c    | 418 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/trace-events |   6 +
 4 files changed, 429 insertions(+)

diff --git a/hw/nvme/Kconfig b/hw/nvme/Kconfig
index 8ac90942e55e..1d89a4f4ecea 100644
--- a/hw/nvme/Kconfig
+++ b/hw/nvme/Kconfig
@@ -2,3 +2,7 @@ config NVME_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+
+config NVME_NMI_I2C
+    bool
+    default y if I2C_MCTP
diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
index 1a6a2ca2f307..7bc85f31c149 100644
--- a/hw/nvme/meson.build
+++ b/hw/nvme/meson.build
@@ -1 +1,2 @@
 system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c'))
+system_ss.add(when: 'CONFIG_NVME_NMI_I2C', if_true: files('nmi-i2c.c'))
diff --git a/hw/nvme/nmi-i2c.c b/hw/nvme/nmi-i2c.c
new file mode 100644
index 000000000000..9040ba28a87c
--- /dev/null
+++ b/hw/nvme/nmi-i2c.c
@@ -0,0 +1,418 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * SPDX-FileCopyrightText: Copyright (c) 2023 Samsung Electronics Co., Ltd.
+ *
+ * SPDX-FileContributor: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
+ * SPDX-FileContributor: Arun Kumar Agasar <arun.kka@samsung.com>
+ * SPDX-FileContributor: Saurav Kumar <saurav.29@partner.samsung.com>
+ * SPDX-FileContributor: Klaus Jensen <k.jensen@samsung.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/crc32c.h"
+#include "hw/registerfields.h"
+#include "hw/i2c/i2c.h"
+#include "hw/i2c/mctp.h"
+#include "net/mctp.h"
+#include "trace.h"
+
+#define NMI_MAX_MESSAGE_LENGTH 4224
+
+#define TYPE_NMI_I2C_DEVICE "nmi-i2c"
+OBJECT_DECLARE_SIMPLE_TYPE(NMIDevice, NMI_I2C_DEVICE)
+
+typedef struct NMIDevice {
+    MCTPI2CEndpoint mctp;
+
+    uint8_t buffer[NMI_MAX_MESSAGE_LENGTH];
+    uint8_t scratch[NMI_MAX_MESSAGE_LENGTH];
+
+    size_t  len;
+    int64_t pos;
+} NMIDevice;
+
+FIELD(NMI_MCTPD, MT, 0, 7)
+FIELD(NMI_MCTPD, IC, 7, 1)
+
+#define NMI_MCTPD_MT_NMI 0x4
+#define NMI_MCTPD_IC_ENABLED 0x1
+
+FIELD(NMI_NMP, ROR, 7, 1)
+FIELD(NMI_NMP, NMIMT, 3, 4)
+
+#define NMI_NMP_NMIMT_NVME_MI 0x1
+#define NMI_NMP_NMIMT_NVME_ADMIN 0x2
+
+typedef struct NMIMessage {
+    uint8_t mctpd;
+    uint8_t nmp;
+    uint8_t rsvd2[2];
+    uint8_t payload[]; /* includes the Message Integrity Check */
+} NMIMessage;
+
+typedef struct NMIRequest {
+   uint8_t opc;
+   uint8_t rsvd1[3];
+   uint32_t dw0;
+   uint32_t dw1;
+   uint32_t mic;
+} NMIRequest;
+
+typedef enum NMIReadDSType {
+    NMI_CMD_READ_NMI_DS_SUBSYSTEM       = 0x0,
+    NMI_CMD_READ_NMI_DS_PORTS           = 0x1,
+    NMI_CMD_READ_NMI_DS_CTRL_LIST       = 0x2,
+    NMI_CMD_READ_NMI_DS_CTRL_INFO       = 0x3,
+    NMI_CMD_READ_NMI_DS_OPT_CMD_SUPPORT = 0x4,
+    NMI_CMD_READ_NMI_DS_MEB_CMD_SUPPORT = 0x5,
+} NMIReadDSType;
+
+#define NMI_STATUS_INVALID_PARAMETER 0x4
+
+static void nmi_set_parameter_error(NMIDevice *nmi, uint8_t bit, uint16_t byte)
+{
+    /* NVM Express Management Interface 1.2c, Figure 30 */
+    struct resp {
+        uint8_t  status;
+        uint8_t  bit;
+        uint16_t byte;
+    };
+
+    struct resp *buf = (struct resp *)(nmi->scratch + nmi->pos);
+
+    buf->status = NMI_STATUS_INVALID_PARAMETER;
+    buf->bit = bit & 0x3;
+    buf->byte = byte;
+
+    nmi->pos += sizeof(struct resp);
+}
+
+static void nmi_set_error(NMIDevice *nmi, uint8_t status)
+{
+    uint8_t buf[4] = {};
+
+    buf[0] = status;
+
+    memcpy(nmi->scratch + nmi->pos, buf, 4);
+    nmi->pos += 4;
+}
+
+static void nmi_handle_mi_read_nmi_ds(NMIDevice *nmi, NMIRequest *request)
+{
+    I2CSlave *i2c = I2C_SLAVE(nmi);
+
+    uint32_t dw0 = le32_to_cpu(request->dw0);
+    uint8_t dtyp = (dw0 >> 24) & 0xf;
+    uint8_t *buf;
+    size_t len;
+
+    trace_nmi_handle_mi_read_nmi_ds(dtyp);
+
+    static uint8_t nmi_ds_subsystem[36] = {
+        0x00,       /* success */
+        0x20, 0x00, /* response data length */
+        0x00,       /* reserved */
+        0x00,       /* number of ports */
+        0x01,       /* major version */
+        0x01,       /* minor version */
+    };
+
+    /* cannot be static since we need to patch in the i2c address */
+    uint8_t nmi_ds_ports[36] = {
+        0x00,       /* success */
+        0x20, 0x00, /* response data length */
+        0x00,       /* reserved */
+        0x02,       /* port type (smbus) */
+        0x00,       /* reserved */
+        0x40, 0x00, /* maximum mctp transission unit size (64 bytes) */
+        0x00, 0x00, 0x00, 0x00, /* management endpoint buffer size */
+        0x00,       /* vpd i2c address */
+        0x00,       /* vpd i2c frequency */
+        0x00,       /* management endpoint i2c address */
+        0x01,       /* management endpoint i2c frequency */
+        0x00,       /* nvme basic management command NOT supported */
+    };
+
+    /**
+     * Controller Information is zeroed, since there are no associated
+     * controllers at this point.
+     */
+    static uint8_t nmi_ds_ctrl[36] = {};
+
+    /**
+     * For the Controller List, Optionally Supported Command List and
+     * Management Endpoint Buffer Supported Command List data structures.
+     *
+     * The Controller List data structure is defined in the NVM Express Base
+     * Specification, revision 2.0b, Figure 134.
+     */
+    static uint8_t nmi_ds_empty[6] = {
+        0x00,       /* success */
+        0x02,       /* response data length */
+        0x00, 0x00, /* reserved */
+        0x00, 0x00, /* number of entries (zero) */
+    };
+
+    switch (dtyp) {
+    case NMI_CMD_READ_NMI_DS_SUBSYSTEM:
+        len = sizeof(nmi_ds_subsystem);
+        buf = nmi_ds_subsystem;
+
+        break;
+
+    case NMI_CMD_READ_NMI_DS_PORTS:
+        len = sizeof(nmi_ds_ports);
+        buf = nmi_ds_ports;
+
+        /* patch in the i2c address of the endpoint */
+        buf[14] = i2c->address;
+
+        break;
+
+    case NMI_CMD_READ_NMI_DS_CTRL_INFO:
+        len = sizeof(nmi_ds_ctrl);
+        buf = nmi_ds_ctrl;
+
+        break;
+
+    case NMI_CMD_READ_NMI_DS_CTRL_LIST:
+    case NMI_CMD_READ_NMI_DS_OPT_CMD_SUPPORT:
+    case NMI_CMD_READ_NMI_DS_MEB_CMD_SUPPORT:
+        len = sizeof(nmi_ds_empty);
+        buf = nmi_ds_empty;
+
+        break;
+
+    default:
+        nmi_set_parameter_error(nmi, offsetof(NMIRequest, dw0) + 4, 0);
+
+        return;
+    }
+
+    memcpy(nmi->scratch + nmi->pos, buf, len);
+    nmi->pos += len;
+}
+
+enum {
+    NMI_CMD_CONFIGURATION_GET_SMBUS_FREQ                = 0x1,
+    NMI_CMD_CONFIGURATION_GET_HEALTH_STATUS_CHANGE      = 0x2,
+    NMI_CMD_CONFIGURATION_GET_MCTP_TRANSMISSION_UNIT    = 0x3,
+};
+
+static void nmi_handle_mi_config_get(NMIDevice *nmi, NMIRequest *request)
+{
+    uint32_t dw0 = le32_to_cpu(request->dw0);
+    uint8_t identifier = dw0 & 0xff;
+    uint8_t *buf;
+
+    static uint8_t smbus_freq[4] = {
+        0x00,               /* success */
+        0x01, 0x00, 0x00,   /* 100 kHz */
+    };
+
+    static uint8_t mtu[4] = {
+        0x00,       /* success */
+        0x40, 0x00, /* 64 */
+        0x00,       /* reserved */
+    };
+
+    trace_nmi_handle_mi_config_get(identifier);
+
+    switch (identifier) {
+    case NMI_CMD_CONFIGURATION_GET_SMBUS_FREQ:
+        buf = smbus_freq;
+        break;
+
+    case NMI_CMD_CONFIGURATION_GET_MCTP_TRANSMISSION_UNIT:
+        buf = mtu;
+        break;
+
+    default:
+        nmi_set_parameter_error(nmi, 0x0, offsetof(NMIRequest, dw0));
+        return;
+    }
+
+    memcpy(nmi->scratch + nmi->pos, buf, 4);
+    nmi->pos += 4;
+}
+
+enum {
+    NMI_CMD_READ_NMI_DS         = 0x0,
+    NMI_CMD_CONFIGURATION_GET   = 0x4,
+};
+
+static void nmi_handle_mi(NMIDevice *nmi, NMIMessage *msg)
+{
+    NMIRequest *request = (NMIRequest *)msg->payload;
+
+    trace_nmi_handle_mi(request->opc);
+
+    switch (request->opc) {
+    case NMI_CMD_READ_NMI_DS:
+        nmi_handle_mi_read_nmi_ds(nmi, request);
+        break;
+
+    case NMI_CMD_CONFIGURATION_GET:
+        nmi_handle_mi_config_get(nmi, request);
+        break;
+
+    default:
+        nmi_set_parameter_error(nmi, 0x0, 0x0);
+        fprintf(stderr, "nmi command 0x%x not handled\n", request->opc);
+
+        break;
+    }
+}
+
+static void nmi_reset(MCTPI2CEndpoint *mctp)
+{
+    NMIDevice *nmi = NMI_I2C_DEVICE(mctp);
+    nmi->len = 0;
+}
+
+static void nmi_handle(MCTPI2CEndpoint *mctp)
+{
+    NMIDevice *nmi = NMI_I2C_DEVICE(mctp);
+    NMIMessage *msg = (NMIMessage *)nmi->buffer;
+    uint32_t crc;
+    uint8_t nmimt;
+
+    uint8_t buf[] = {
+        msg->mctpd,
+        FIELD_DP8(msg->nmp, NMI_NMP, ROR, 1),
+        0x0, 0x0,
+    };
+
+    if (FIELD_EX8(msg->mctpd, NMI_MCTPD, MT) != NMI_MCTPD_MT_NMI) {
+        goto drop;
+    }
+
+    if (FIELD_EX8(msg->mctpd, NMI_MCTPD, IC) != NMI_MCTPD_IC_ENABLED) {
+        goto drop;
+    }
+
+    memcpy(nmi->scratch, buf, sizeof(buf));
+    nmi->pos = sizeof(buf);
+
+    nmimt = FIELD_EX8(msg->nmp, NMI_NMP, NMIMT);
+
+    trace_nmi_handle_msg(nmimt);
+
+    switch (nmimt) {
+    case NMI_NMP_NMIMT_NVME_MI:
+        nmi_handle_mi(nmi, msg);
+        break;
+
+    default:
+        fprintf(stderr, "nmi message type 0x%x not handled\n", nmimt);
+
+        nmi_set_error(nmi, 0x3);
+
+        break;
+    }
+
+    /* add message integrity check */
+    memset(nmi->scratch + nmi->pos, 0x0, sizeof(crc));
+
+    crc = crc32c(0xffffffff, nmi->scratch, nmi->pos);
+    memcpy(nmi->scratch + nmi->pos, &crc, sizeof(crc));
+
+    nmi->len = nmi->pos + sizeof(crc);
+    nmi->pos = 0;
+
+    i2c_mctp_schedule_send(mctp);
+
+    return;
+
+drop:
+    nmi_reset(mctp);
+}
+
+static size_t nmi_get_buf(MCTPI2CEndpoint *mctp, const uint8_t **buf,
+                          size_t maxlen, uint8_t *mctp_flags)
+{
+    NMIDevice *nmi = NMI_I2C_DEVICE(mctp);
+    size_t len;
+
+    len = MIN(maxlen, nmi->len - nmi->pos);
+
+    if (len == 0) {
+        return 0;
+    }
+
+    if (nmi->pos == 0) {
+        *mctp_flags = FIELD_DP8(*mctp_flags, MCTP_H_FLAGS, SOM, 1);
+    }
+
+    *buf = nmi->scratch + nmi->pos;
+    nmi->pos += len;
+
+    if (nmi->pos == nmi->len) {
+        *mctp_flags = FIELD_DP8(*mctp_flags, MCTP_H_FLAGS, EOM, 1);
+
+        nmi->pos = nmi->len = 0;
+    }
+
+    return len;
+}
+
+static int nmi_put_buf(MCTPI2CEndpoint *mctp, uint8_t *buf, size_t len)
+{
+    NMIDevice *nmi = NMI_I2C_DEVICE(mctp);
+
+    if (nmi->len + len > NMI_MAX_MESSAGE_LENGTH) {
+        return -1;
+    }
+
+    memcpy(nmi->buffer + nmi->len, buf, len);
+    nmi->len += len;
+
+    return 0;
+}
+
+static size_t nmi_get_types(MCTPI2CEndpoint *mctp, const uint8_t **data)
+{
+    /**
+     * DSP0236 1.3.0, Table 19.
+     *
+     * This only includes message types that are supported *in addition* to the
+     * MCTP control message type.
+     */
+    static const uint8_t buf[] = {
+        0x0,                /* success */
+        0x1,                /* number of message types in list (supported) */
+        NMI_MCTPD_MT_NMI,
+    };
+
+    *data = buf;
+
+    return sizeof(buf);
+}
+
+static void nvme_mi_class_init(ObjectClass *oc, void *data)
+{
+    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_CLASS(oc);
+
+    mc->get_types = nmi_get_types;
+
+    mc->get_buf = nmi_get_buf;
+    mc->put_buf = nmi_put_buf;
+
+    mc->handle = nmi_handle;
+    mc->reset = nmi_reset;
+}
+
+static const TypeInfo nvme_mi = {
+    .name = TYPE_NMI_I2C_DEVICE,
+    .parent = TYPE_MCTP_I2C_ENDPOINT,
+    .instance_size = sizeof(NMIDevice),
+    .class_init = nvme_mi_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&nvme_mi);
+}
+
+type_init(register_types);
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 3a67680c6ad1..41e2c540dcf2 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -216,3 +216,9 @@ pci_nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for
 pci_nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
 pci_nvme_ub_unknown_css_value(void) "unknown value in cc.css field"
 pci_nvme_ub_too_many_mappings(void) "too many prp/sgl mappings"
+
+# nmi-i2c
+nmi_handle_mi_read_nmi_ds(uint8_t dtyp) "dtyp 0x%"PRIx8""
+nmi_handle_mi_config_get(uint8_t identifier) "identifier 0x%"PRIx8""
+nmi_handle_mi(uint8_t opc) "opc 0x%"PRIx8""
+nmi_handle_msg(uint8_t nmint) "nmint 0x%"PRIx8""

-- 
2.42.0


