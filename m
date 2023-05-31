Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B614717ECF
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4KJq-0001lm-Cy; Wed, 31 May 2023 07:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q4KJ6-0001Oc-AV; Wed, 31 May 2023 07:48:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q4KJ3-0002yM-KP; Wed, 31 May 2023 07:48:00 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id BD9F05C010F;
 Wed, 31 May 2023 07:47:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 31 May 2023 07:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1685533674; x=1685620074; bh=YBKHClj8e75/jTLA+wLKDKQ/U
 z/u2CFFF8l9VE/rAf4=; b=GbyCyyvqTe95xOV4JVdhat9pqyy9WHkWDvpyfxu2Z
 Xtc1eRSICP3eni7B3bd6mMc0ZVIMxpeuaRlJoM+IlYdmNJrw9PyfvpWgJFysHpwV
 GdYWi46hVbCvuQsDzDXnIu/vV1OfIDkaW1cvjFmFTl2eXD6UulwuMpyQbNub9ssN
 JB3VVxHIgcC8XNmLJsgbuVA4QfNqFPeIS4ad6jBZ5W00YVj8b8BuTNRC+XOFl4W4
 Et4STfwPc08x4QcY7zbBXOBGjm+MOmVfVdQk5lJ/QrW6zsxV93X36R3ydPlznNKs
 k9Sq8CLGQyAHegTpnmpKLrMHZ6SYX5O4O80vTi7AiUK+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1685533674; x=1685620074; bh=YBKHClj8e75/jTLA+wLKDKQ/Uz/u2CFFF8l
 9VE/rAf4=; b=vofeO74r3txfs8X7LL/TMZilLABYF9BVJKft/2udrqSu65t8V9O
 g2u6L/KDjHsO6dQqCD3O2A8n52Ig/xZntwt5fSe0LZgJkhCJNI15B1sbj4UYR6hK
 MhH/ur1QqI1nfmsm97PeVE/v1MJjIYBMJRPC86iPoVVbxY5oBoqNoZXyCjOmwog2
 57eEq70Yqp7FUcJflpLcucIZr99ekR7KfJ+eI7OTfexbghnxxOIaAMjRaMwXUKiM
 TcNFUdbohvg6+ltUtgoPhV9RUd/mlKJT4KvXYlGvgagN4ABEuPVgKTRq3EXrgTR2
 McGoN9WFBa6WRKiW5BTDOU6mB//s7GKnx5g==
X-ME-Sender: <xms:6jN3ZB3VPVOHd_piRD40sVVaail1RXkV-jIfNT_7L8IJMnVAudT5Jw>
 <xme:6jN3ZIHnfeNlRH5s0jmOr4xv6tFlA29kDMt2XCuq7SWH3sWs6WxMitDcPiQHSUeCN
 1d8nkmEXnHV9kxnGBY>
X-ME-Received: <xmr:6jN3ZB7Q5Tq1DWFh97ydQM4Q1fLuVCLn6iOg5b5IbdPnP-gOlqqSetUox9G4rbPFk6UdeNjPmd9jBeKcErWyB2U-lJmE7eb3tMlGHN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledggeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeffkefgteeghfduleffteeivdeggfegteegkefgvdevveeiteefkedugeei
 leevffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgu
 kh
X-ME-Proxy: <xmx:6jN3ZO38X7GtEw6euQgXd1dq3LgcOwxGdjgSqfsPBJkWaK6QXK_ZHQ>
 <xmx:6jN3ZEFj268K_GP8JFO8G5-cO7Glm0zqC21drKkFDzKQKWVe09EHgg>
 <xmx:6jN3ZP9EaFoqDjhjHVtYCIifx8SRioiT_slNjTK9a7JWEaJfdFyCLA>
 <xmx:6jN3ZKECyErTgk84GlMg0IUBJH4WfkLh_gEu3aj8Hu1McM2KwdblAA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 07:47:52 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, Keith Busch <kbusch@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Lior Weintraub <liorw@pliops.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 qemu-arm@nongnu.org, Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>, Klaus Jensen <its@irrelevant.dk>,
 gost.dev@samsung.com
Subject: [PATCH v3 2/3] hw/i2c: add mctp core
Date: Wed, 31 May 2023 13:47:43 +0200
Message-Id: <20230531114744.9946-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230531114744.9946-1-its@irrelevant.dk>
References: <20230531114744.9946-1-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20484; i=k.jensen@samsung.com;
 h=from:subject; bh=j8BJiqZvIxdtwmpiTG41QXzqnmLRbAgxO7ZvcGc1I0k=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGR3M90+gf5iGo14Uck22iDBJo801KNxnBj62
 qwJ5tEWCJWE04kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkdzPdAAoJEE3hrzFt
 Tw3pIuAH/j6rZVMBRMEMVPN9UuzmdpqvsEKQeDdvi3LZM6x7et5pmJWzLMylK7mbDPVVB/brF2D
 4Tei8KGNXX9U+ApbLdSIr1Ktgeh42RDFJpSEPBeBNKxPdwkYo2HHuay2Osc0ERQ8MaBLp3nM4cP
 tlmXrs16Sj64JTs0FXZp1ptR/+s6tf3S4P9JJ1gqoMNaNMJ+gMiPH2ZpQ0Vu59CtZuf/6txxCVu
 U1cKWNegbjMeu+ahvCQBsm6Ek4Zow+xDqPDsFORg2n7n5Qwuv9+wtTbGdXSQhDam2nEBiE1QbZ9
 qKRbdQUkf9Brn39SelVU/5fl12ekt5po6inTRhNzP4Ux+JcwZCPx9al7
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Add an abstract MCTP over I2C endpoint model. This implements MCTP
control message handling as well as handling the actual I2C transport
(packetization).

Devices are intended to derive from this and implement the class
methods.

Parts of this implementation is inspired by code[1] previously posted by
Jonathan Cameron.

Squashed a fix[2] from Matt Johnston.

  [1]: https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonathan.Cameron@huawei.com/
  [2]: https://lore.kernel.org/qemu-devel/20221121080445.GA29062@codeconstruct.com.au/

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 MAINTAINERS           |   7 +
 hw/arm/Kconfig        |   1 +
 hw/i2c/Kconfig        |   4 +
 hw/i2c/mctp.c         | 398 ++++++++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build    |   1 +
 hw/i2c/trace-events   |  13 ++
 include/hw/i2c/mctp.h | 137 +++++++++++++++
 include/net/mctp.h    |  28 +++
 8 files changed, 589 insertions(+)
 create mode 100644 hw/i2c/mctp.c
 create mode 100644 include/hw/i2c/mctp.h
 create mode 100644 include/net/mctp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b025a7b63e2..80d440b21ecb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3354,6 +3354,13 @@ F: tests/qtest/adm1272-test.c
 F: tests/qtest/max34451-test.c
 F: tests/qtest/isl_pmbus_vr-test.c
 
+MCTP I2C Transport
+M: Klaus Jensen <k.jensen@samsung.com>
+S: Maintained
+F: hw/i2c/mctp.c
+F: include/hw/i2c/mctp.h
+F: include/net/mctp.h
+
 Firmware schema specifications
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Daniel P. Berrange <berrange@redhat.com>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index acc4371a4ae8..eb4559ef2ba4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -528,6 +528,7 @@ config ASPEED_SOC
     select DS1338
     select FTGMAC100
     select I2C
+    select MCTP_I2C
     select DPS310
     select PCA9552
     select SERIAL
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 14886b35dac2..3415e8421ab1 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -45,3 +45,7 @@ config PCA954X
 config PMBUS
     bool
     select SMBUS
+
+config MCTP_I2C
+    bool
+    select I2C
diff --git a/hw/i2c/mctp.c b/hw/i2c/mctp.c
new file mode 100644
index 000000000000..c0cf2e4806e8
--- /dev/null
+++ b/hw/i2c/mctp.c
@@ -0,0 +1,398 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * SPDX-FileCopyrightText: Copyright (c) 2022 Samsung Electronics Co., Ltd.
+ * SPDX-FileContributor: Klaus Jensen <k.jensen@samsung.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/i2c/i2c.h"
+#include "hw/i2c/smbus_master.h"
+#include "hw/i2c/mctp.h"
+
+#include "trace.h"
+
+/* DSP0237 1.2.0, Figure 1 */
+typedef struct MCTPI2CPacketHeader {
+    uint8_t dest;
+#define MCTP_I2C_COMMAND_CODE 0xf
+    uint8_t command_code;
+    uint8_t byte_count;
+    uint8_t source;
+} MCTPI2CPacketHeader;
+
+typedef struct MCTPI2CPacket {
+    MCTPI2CPacketHeader i2c;
+    MCTPPacket          mctp;
+} MCTPI2CPacket;
+
+#define i2c_mctp_payload(buf) (buf + offsetof(MCTPI2CPacket, mctp.payload))
+
+/* DSP0236 1.3.0, Figure 20 */
+typedef struct MCTPControlMessage {
+#define MCTP_MESSAGE_TYPE_CONTROL 0x0
+    uint8_t type;
+#define MCTP_CONTROL_FLAGS_RQ               (1 << 7)
+#define MCTP_CONTROL_FLAGS_D                (1 << 6)
+    uint8_t flags;
+    uint8_t command_code;
+    uint8_t data[];
+} MCTPControlMessage;
+
+enum MCTPControlCommandCodes {
+    MCTP_CONTROL_SET_EID                    = 0x01,
+    MCTP_CONTROL_GET_EID                    = 0x02,
+    MCTP_CONTROL_GET_VERSION                = 0x04,
+    MCTP_CONTROL_GET_MESSAGE_TYPE_SUPPORT   = 0x05,
+};
+
+#define MCTP_CONTROL_ERROR_UNSUPPORTED_CMD 0x5
+
+#define i2c_mctp_control_data(buf) \
+    (i2c_mctp_payload(buf) + offsetof(MCTPControlMessage, data))
+
+
+void i2c_mctp_schedule_send(MCTPI2CEndpoint *mctp)
+{
+    I2CBus *i2c = I2C_BUS(qdev_get_parent_bus(DEVICE(mctp)));
+
+    mctp->tx.state = I2C_MCTP_STATE_TX_START_SEND;
+
+    i2c_bus_master(i2c, mctp->tx.bh);
+}
+
+static void i2c_mctp_tx(void *opaque)
+{
+    DeviceState *dev = DEVICE(opaque);
+    I2CBus *i2c = I2C_BUS(qdev_get_parent_bus(dev));
+    I2CSlave *slave = I2C_SLAVE(dev);
+    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(dev);
+    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
+    MCTPI2CPacket *pkt = (MCTPI2CPacket *)mctp->buffer;
+    uint8_t flags = 0;
+
+    switch (mctp->tx.state) {
+    case I2C_MCTP_STATE_TX_SEND_BYTE:
+        if (mctp->pos < mctp->len) {
+            uint8_t byte = mctp->buffer[mctp->pos];
+
+            trace_i2c_mctp_tx_send_byte(mctp->pos, byte);
+
+            /* send next byte */
+            i2c_send_async(i2c, byte);
+
+            mctp->pos++;
+
+            break;
+        }
+
+        /* packet sent */
+        i2c_end_transfer(i2c);
+
+        /* end of any control data */
+        mctp->len = 0;
+
+        /* fall through */
+
+    case I2C_MCTP_STATE_TX_START_SEND:
+        if (mctp->tx.is_control) {
+            /* packet payload is already in buffer */
+            flags |= MCTP_H_FLAGS_SOM | MCTP_H_FLAGS_EOM;
+        } else {
+            const uint8_t *payload;
+
+            /* get message bytes from derived device */
+            mctp->len = mc->get_buf(mctp, &payload, I2C_MCTP_MAXMTU, &flags);
+            assert(mctp->len <= I2C_MCTP_MAXMTU);
+
+            memcpy(pkt->mctp.payload, payload, mctp->len);
+        }
+
+        if (!mctp->len) {
+            trace_i2c_mctp_tx_done();
+
+            /* no more packets needed; release the bus */
+            i2c_bus_release(i2c);
+
+            mctp->state = I2C_MCTP_STATE_IDLE;
+            mctp->tx.is_control = false;
+
+            break;
+        }
+
+        mctp->state = I2C_MCTP_STATE_TX;
+
+        pkt->i2c = (MCTPI2CPacketHeader) {
+            .dest = mctp->tx.addr & ~0x1,
+            .command_code = MCTP_I2C_COMMAND_CODE,
+            .byte_count = 5 + mctp->len,
+            .source = slave->address << 1 | 0x1,
+        };
+
+        pkt->mctp.hdr = (MCTPPacketHeader) {
+            .version = 0x1,
+            .eid.dest = mctp->tx.eid,
+            .eid.source = mctp->my_eid,
+            .flags = flags | (mctp->tx.pktseq++ & 0x3) << 4 | mctp->tx.flags,
+        };
+
+        mctp->len += sizeof(MCTPI2CPacket);
+        assert(mctp->len < I2C_MCTP_MAX_LENGTH);
+
+        mctp->buffer[mctp->len] = i2c_smbus_pec(0, mctp->buffer, mctp->len);
+        mctp->len++;
+
+        trace_i2c_mctp_tx_start_send(mctp->len);
+
+        i2c_start_send_async(i2c, pkt->i2c.dest >> 1);
+
+        /* already "sent" the destination slave address */
+        mctp->pos = 1;
+
+        mctp->tx.state = I2C_MCTP_STATE_TX_SEND_BYTE;
+
+        break;
+    }
+}
+
+static void i2c_mctp_handle_control_set_eid(MCTPI2CEndpoint *mctp, uint8_t eid)
+{
+    mctp->my_eid = eid;
+
+    uint8_t buf[] = {
+        0x0, 0x0, eid, 0x0,
+    };
+
+    memcpy(i2c_mctp_control_data(mctp->buffer), buf, sizeof(buf));
+    mctp->len += sizeof(buf);
+}
+
+static void i2c_mctp_handle_control_get_eid(MCTPI2CEndpoint *mctp)
+{
+    uint8_t buf[] = {
+        0x0, mctp->my_eid, 0x0, 0x0,
+    };
+
+    memcpy(i2c_mctp_control_data(mctp->buffer), buf, sizeof(buf));
+    mctp->len += sizeof(buf);
+}
+
+static void i2c_mctp_handle_control_get_version(MCTPI2CEndpoint *mctp)
+{
+    uint8_t buf[] = {
+        0x0, 0x1, 0x0, 0x1, 0x3, 0x1,
+    };
+
+    memcpy(i2c_mctp_control_data(mctp->buffer), buf, sizeof(buf));
+    mctp->len += sizeof(buf);
+}
+
+static void i2c_mctp_handle_get_message_type_support(MCTPI2CEndpoint *mctp)
+{
+    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
+    const uint8_t *types;
+    size_t len;
+
+    len = mc->get_types(mctp, &types);
+    assert(len > 0 && len <= MCTP_BASELINE_MTU - mctp->len);
+
+    memcpy(i2c_mctp_control_data(mctp->buffer), types, len);
+    mctp->len += len;
+}
+
+static void i2c_mctp_handle_control(MCTPI2CEndpoint *mctp)
+{
+    MCTPControlMessage *msg = (MCTPControlMessage *)i2c_mctp_payload(mctp->buffer);
+
+    /* clear Rq/D */
+    msg->flags &= ~(MCTP_CONTROL_FLAGS_RQ | MCTP_CONTROL_FLAGS_D);
+
+    mctp->len = sizeof(MCTPControlMessage);
+
+    trace_i2c_mctp_handle_control(msg->command_code);
+
+    switch (msg->command_code) {
+    case MCTP_CONTROL_SET_EID:
+        i2c_mctp_handle_control_set_eid(mctp, msg->data[1]);
+        break;
+
+    case MCTP_CONTROL_GET_EID:
+        i2c_mctp_handle_control_get_eid(mctp);
+        break;
+
+    case MCTP_CONTROL_GET_VERSION:
+        i2c_mctp_handle_control_get_version(mctp);
+        break;
+
+    case MCTP_CONTROL_GET_MESSAGE_TYPE_SUPPORT:
+        i2c_mctp_handle_get_message_type_support(mctp);
+        break;
+
+    default:
+        trace_i2c_mctp_unhandled_control(msg->command_code);
+
+        msg->data[0] = MCTP_CONTROL_ERROR_UNSUPPORTED_CMD;
+        mctp->len++;
+
+        break;
+    }
+
+    assert(mctp->len <= MCTP_BASELINE_MTU);
+
+    i2c_mctp_schedule_send(mctp);
+}
+
+static int i2c_mctp_event_cb(I2CSlave *i2c, enum i2c_event event)
+{
+    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(i2c);
+    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
+    MCTPI2CPacket *pkt = (MCTPI2CPacket *)mctp->buffer;
+    size_t payload_len;
+    uint8_t pec;
+
+    switch (event) {
+    case I2C_START_SEND:
+        if (mctp->state == I2C_MCTP_STATE_IDLE) {
+            mctp->state = I2C_MCTP_STATE_RX_STARTED;
+        } else if (mctp->state != I2C_MCTP_STATE_RX) {
+            return -1;
+        }
+
+        /* the i2c core eats the slave address, so put it back in */
+        pkt->i2c.dest = i2c->address << 1;
+        mctp->len = 1;
+
+        return 0;
+
+    case I2C_FINISH:
+        if (mctp->len < sizeof(MCTPI2CPacket) + 1) {
+            trace_i2c_mctp_drop_short_packet(mctp->len);
+            goto drop;
+        }
+
+        payload_len = mctp->len - (1 + offsetof(MCTPI2CPacket, mctp.payload));
+
+        if (pkt->i2c.byte_count + 3 != mctp->len - 1) {
+            trace_i2c_mctp_drop_invalid_length(pkt->i2c.byte_count + 3,
+                                               mctp->len - 1);
+            goto drop;
+        }
+
+        pec = i2c_smbus_pec(0, mctp->buffer, mctp->len - 1);
+        if (mctp->buffer[mctp->len - 1] != pec) {
+            trace_i2c_mctp_drop_invalid_pec(mctp->buffer[mctp->len - 1], pec);
+            goto drop;
+        }
+
+        if (!(pkt->mctp.hdr.eid.dest == mctp->my_eid ||
+              pkt->mctp.hdr.eid.dest == 0)) {
+            trace_i2c_mctp_drop_invalid_eid(pkt->mctp.hdr.eid.dest,
+                                            mctp->my_eid);
+            goto drop;
+        }
+
+        if (pkt->mctp.hdr.flags & MCTP_H_FLAGS_SOM) {
+            mctp->tx.is_control = false;
+
+            if (mctp->state == I2C_MCTP_STATE_RX) {
+                mc->reset(mctp);
+            }
+
+            mctp->state = I2C_MCTP_STATE_RX;
+
+            mctp->tx.addr = pkt->i2c.source;
+            mctp->tx.eid = pkt->mctp.hdr.eid.source;
+            mctp->tx.flags = pkt->mctp.hdr.flags & 0x7;
+            mctp->tx.pktseq = (pkt->mctp.hdr.flags >> 4) & 0x3;
+
+            if ((pkt->mctp.payload[0] & 0x7f) == MCTP_MESSAGE_TYPE_CONTROL) {
+                mctp->tx.is_control = true;
+
+                i2c_mctp_handle_control(mctp);
+
+                return 0;
+            }
+        } else if (mctp->state == I2C_MCTP_STATE_RX_STARTED) {
+            trace_i2c_mctp_drop_expected_som();
+            goto drop;
+        } else if (((pkt->mctp.hdr.flags >> 4) & 0x3) != (++mctp->tx.pktseq & 0x3)) {
+            trace_i2c_mctp_drop_invalid_pktseq((pkt->mctp.hdr.flags >> 4) & 0x3,
+                                               mctp->tx.pktseq & 0x3);
+            goto drop;
+        }
+
+        mc->put_buf(mctp, i2c_mctp_payload(mctp->buffer), payload_len);
+
+        if (pkt->mctp.hdr.flags & MCTP_H_FLAGS_EOM) {
+            mc->handle(mctp);
+            mctp->state = I2C_MCTP_STATE_WAIT_TX;
+        }
+
+        return 0;
+
+    default:
+        return -1;
+    }
+
+drop:
+    mc->reset(mctp);
+
+    mctp->state = I2C_MCTP_STATE_IDLE;
+
+    return 0;
+}
+
+static int i2c_mctp_send_cb(I2CSlave *i2c, uint8_t data)
+{
+    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(i2c);
+
+    if (mctp->len < I2C_MCTP_MAX_LENGTH) {
+        mctp->buffer[mctp->len++] = data;
+        return 0;
+    }
+
+    return -1;
+}
+
+static void i2c_mctp_instance_init(Object *obj)
+{
+    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(obj);
+
+    mctp->tx.bh = qemu_bh_new(i2c_mctp_tx, mctp);
+}
+
+static Property mctp_i2c_props[] = {
+    DEFINE_PROP_UINT8("eid", MCTPI2CEndpoint, my_eid, 0x9),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void i2c_mctp_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(oc);
+
+    k->event = i2c_mctp_event_cb;
+    k->send = i2c_mctp_send_cb;
+
+    device_class_set_props(dc, mctp_i2c_props);
+}
+
+static const TypeInfo i2c_mctp_info = {
+    .name = TYPE_MCTP_I2C_ENDPOINT,
+    .parent = TYPE_I2C_SLAVE,
+    .abstract = true,
+    .instance_init = i2c_mctp_instance_init,
+    .instance_size = sizeof(MCTPI2CEndpoint),
+    .class_init = i2c_mctp_class_init,
+    .class_size = sizeof(MCTPI2CEndpointClass),
+};
+
+static void register_types(void)
+{
+    type_register_static(&i2c_mctp_info);
+}
+
+type_init(register_types)
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index 3996564c25c6..fd1f9022fd96 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -1,5 +1,6 @@
 i2c_ss = ss.source_set()
 i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c'))
+i2c_ss.add(when: 'CONFIG_MCTP_I2C', if_true: files('mctp.c'))
 i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('smbus_ich9.c'))
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 8e88aa24c1ac..bc1a7176ef67 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -45,3 +45,16 @@ npcm7xx_smbus_recv_fifo(const char *id, uint8_t received, uint8_t expected) "%s
 
 pca954x_write_bytes(uint8_t value) "PCA954X write data: 0x%02x"
 pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
+
+# mctp.c
+i2c_mctp_tx_start_send(size_t len) "len %zu"
+i2c_mctp_tx_send_byte(size_t pos, uint8_t byte) "pos %zu byte 0x%"PRIx8""
+i2c_mctp_tx_done(void) "packet sent"
+i2c_mctp_handle_control(uint8_t command) "command 0x%"PRIx8""
+i2c_mctp_unhandled_control(uint8_t command) "command 0x%"PRIx8""
+i2c_mctp_drop_invalid_length(unsigned byte_count, size_t expected) "byte_count %u expected %zu"
+i2c_mctp_drop_invalid_pec(uint8_t pec, uint8_t expected) "pec 0x%"PRIx8" expected 0x%"PRIx8""
+i2c_mctp_drop_invalid_eid(uint8_t eid, uint8_t expected) "eid 0x%"PRIx8" expected 0x%"PRIx8""
+i2c_mctp_drop_invalid_pktseq(uint8_t pktseq, uint8_t expected) "pktseq 0x%"PRIx8" expected 0x%"PRIx8""
+i2c_mctp_drop_short_packet(size_t len) "len %zu"
+i2c_mctp_drop_expected_som(void) ""
diff --git a/include/hw/i2c/mctp.h b/include/hw/i2c/mctp.h
new file mode 100644
index 000000000000..ea97792e8d43
--- /dev/null
+++ b/include/hw/i2c/mctp.h
@@ -0,0 +1,137 @@
+#ifndef QEMU_I2C_MCTP_H
+#define QEMU_I2C_MCTP_H
+
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+#include "net/mctp.h"
+
+#define TYPE_MCTP_I2C_ENDPOINT "mctp-i2c-endpoint"
+OBJECT_DECLARE_TYPE(MCTPI2CEndpoint, MCTPI2CEndpointClass, MCTP_I2C_ENDPOINT)
+
+struct MCTPI2CEndpointClass {
+    I2CSlaveClass parent_class;
+
+    /**
+     *
+     * put_buf() - receive incoming message fragment
+     *
+     * Must returns 0 for succes or -1 for error.
+     */
+    int (*put_buf)(MCTPI2CEndpoint *mctp, uint8_t *buf, size_t len);
+
+    /**
+     * get_buf() - provide pointer to message fragment
+     *
+     * Called by the mctp subsystem to request a pointer to the next message
+     * fragment. The implementation must advance its internal position such
+     * that successive calls returns the next fragments.
+     *
+     * Must return the number of bytes available.
+     */
+    size_t (*get_buf)(MCTPI2CEndpoint *mctp, const uint8_t **buf,
+                      size_t maxlen, uint8_t *mctp_flags);
+
+    /**
+     * handle() - handle an MCTP message
+     *
+     * Called by the mctp subsystem when a full message has been delivered and
+     * may be parsed and processed.
+     */
+    void (*handle)(MCTPI2CEndpoint *mctp);
+
+    /**
+     * reset() - reset internal state
+     *
+     * Called by the mctp subsystem in the event of some transport error.
+     * Implementation must reset its internal state and drop any fragments
+     * previously receieved.
+     */
+    void (*reset)(MCTPI2CEndpoint *mctp);
+
+    /**
+     * get_types() - provide supported mctp message types
+     *
+     * Must provide a buffer with a full MCTP supported message types payload
+     * (i.e. `0x0(SUCCESS),0x1(ONE),0x4(NMI)`).
+     *
+     * Returns the size of the response.
+     */
+    size_t (*get_types)(MCTPI2CEndpoint *mctp, const uint8_t **data);
+};
+
+/*
+ * Maximum value of the SMBus Block Write "Byte Count" field (8 bits).
+ *
+ * This is the count of bytes that follow the Byte Count field and up to, but
+ * not including, the PEC byte.
+ */
+#define I2C_MCTP_MAXBLOCK 255
+
+/*
+ * Maximum Transmission Unit under I2C.
+ *
+ * This is for the MCTP Packet Payload (255, subtracting the 4 byte MCTP Packet
+ * Header or the 1 byte MCTP/I2C piggy-backed source address).
+ */
+#define I2C_MCTP_MAXMTU (I2C_MCTP_MAXBLOCK - (sizeof(MCTPPacketHeader) + 1))
+
+/*
+ * Maximum length of an MCTP/I2C packet.
+ *
+ * This is the sum of the three I2C header bytes (Destination target address,
+ * Command Code and Byte Count), the maximum number of bytes in a message (255)
+ * and the 1 byte Packet Error Code.
+ */
+#define I2C_MCTP_MAX_LENGTH (3 + I2C_MCTP_MAXBLOCK + 1)
+
+/*
+ * Maximum length of an MCTP/I2C Control Message.
+ *
+ * This is the 64 byte MCTP Baseline Maximum Transmission Unit, adding the
+ * combined MCTP/I2C headers and the trailing 1 byte PEC.
+ */
+#define I2C_MCTP_CONTROL_MAX_LENGTH \
+    (sizeof(MCTPI2CPacket) + MCTP_BASELINE_MTU + 1)
+
+typedef enum {
+    I2C_MCTP_STATE_IDLE,
+    I2C_MCTP_STATE_RX_STARTED,
+    I2C_MCTP_STATE_RX,
+    I2C_MCTP_STATE_WAIT_TX,
+    I2C_MCTP_STATE_TX,
+} MCTPState;
+
+typedef enum {
+    I2C_MCTP_STATE_TX_START_SEND,
+    I2C_MCTP_STATE_TX_SEND_BYTE,
+} MCTPTxState;
+
+typedef struct MCTPI2CEndpoint {
+    I2CSlave parent_obj;
+    I2CBus *i2c;
+
+    MCTPState state;
+
+    /* mctp endpoint identifier */
+    uint8_t my_eid;
+
+    uint8_t buffer[I2C_MCTP_MAX_LENGTH];
+    uint64_t pos;
+    size_t len;
+
+    struct {
+        MCTPTxState state;
+        bool is_control;
+
+        uint8_t eid;
+        uint8_t addr;
+        uint8_t pktseq;
+        uint8_t flags;
+
+        QEMUBH *bh;
+    } tx;
+} MCTPI2CEndpoint;
+
+void i2c_mctp_schedule_send(MCTPI2CEndpoint *mctp);
+
+#endif /* QEMU_I2C_MCTP_H */
diff --git a/include/net/mctp.h b/include/net/mctp.h
new file mode 100644
index 000000000000..70b49235ddb2
--- /dev/null
+++ b/include/net/mctp.h
@@ -0,0 +1,28 @@
+#ifndef QEMU_MCTP_H
+#define QEMU_MCTP_H
+
+#define MCTP_BASELINE_MTU 64
+
+enum {
+    MCTP_H_FLAGS_EOM = 1 << 6,
+    MCTP_H_FLAGS_SOM = 1 << 7,
+};
+
+#define MCTP_MESSAGE_IC (1 << 7)
+
+/* DSP0236 1.3.0, Figure 4 */
+typedef struct MCTPPacketHeader {
+    uint8_t version;
+    struct {
+        uint8_t dest;
+        uint8_t source;
+    } eid;
+    uint8_t flags;
+} MCTPPacketHeader;
+
+typedef struct MCTPPacket {
+    MCTPPacketHeader hdr;
+    uint8_t          payload[];
+} MCTPPacket;
+
+#endif /* QEMU_MCTP_H */
-- 
2.40.0


