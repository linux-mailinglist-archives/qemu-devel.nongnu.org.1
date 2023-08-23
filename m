Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BAF7853C4
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:23:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYk4C-0005Pj-Cm; Wed, 23 Aug 2023 05:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qYk46-0005Nu-Fn; Wed, 23 Aug 2023 05:22:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qYk44-0005LT-R3; Wed, 23 Aug 2023 05:22:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 719165C0150;
 Wed, 23 Aug 2023 05:22:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 23 Aug 2023 05:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1692782531; x=1692868931; bh=TxT5FJBQFAQKhqwk36E64LI9W
 142sBokm3Pek9uHubI=; b=BY8CmMLBDvJi+xC2oxjFoJdzG+zzr/HxLhqR4m+Hz
 s/GcKuk2sTSfXlnQ6VQQq6fTZN4Bpg/WlGzJlckW3YwpiRhhYpXg8VSO1QWDzbld
 ZHviN0sAh/yQs+ulOuiba53v6W0ye0RTrQ83fyNLYfJWNBPSmd0xJJOBt+VcM595
 y0/MDrOeiLenPZ+AB1SugoZEhm4vNJWEUcCArQ0pgyLYwNfMrDhoqcc3TzDXpUwX
 K0csfxGzm2Sgj6nYWwXyNFAE7NTexLfd9H5aF2YQcMJzGNr/k2Dit6GSTsjIYUQf
 2l0DLTz6ml8prWZN3Z0Rvk90EiRdrz3PYblX8YleuQ+sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1692782531; x=1692868931; bh=TxT5FJBQFAQKhqwk36E64LI9W142sBokm3P
 ek9uHubI=; b=UzgxsjbtkbfMBPxp5d2pRG+zfcn3ZUzdjnPjJsPDZADPDpWAEbn
 W/JblNd1WdLHJ2h9XenWgv8fnkh8AXMSDrb9dVBpdteebOpoPKRRRBrspMZ1aDiz
 spn6D+W8GnueOzSB3NWh4Se43AdBCVE/NhVukLNbovbuX715An3nHHjaLqek/b7A
 DzV38oxCHNwYVKHdPrOG+mLs6CPwZ4tYowuXSLipWpNtLD919CWXkr7QbooVM9j6
 haksXPXrcYvyARNdsxZfEnC3dH0CtmgdjxIOG0sN9WNmwB7jY0e8v3XKgRDia76D
 7La6i4kb+B2HIe33JCYZvIPIEinx3YboNkQ==
X-ME-Sender: <xms:w8_lZDae76XnVe-c_5Yi7_UCw-Q8A5uzohETSD5xPbHsabk-NrFxSg>
 <xme:w8_lZCb96OQlgdpTYXDBXTSwwa4_bMgmVdRm0aheA02-hS4EbXIU1wi64D_S0eP9b
 ZzJFsJu5lxPNRnJnqw>
X-ME-Received: <xmr:w8_lZF9FDBX0mHzSinBjw7N-0WY40D4x1uHjg0tUedXRLenZnz-beQZGuYnxAVt01RaOpV0ktY0C4tRvrAygGwz97jYrs41sOgnzxaek7-emz07HRWjL40Jc3kMHC20I8Jq68cCMDkc2MNlkVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudevgefgffeiteevfffhhefg
 gefhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:w8_lZJpPBJcVYvIBeX14OrsBd0OoAUemwVSmES6n3nAnC3g5Hm-2QQ>
 <xmx:w8_lZOoEllaCGx2MFBLVA9he2D9a6fBwJmem2T6hfbX19EPWAdomEg>
 <xmx:w8_lZPTv6JoqBK6sP9x-wUyASc35ZR0YJ5CVPMct1_EDwtt1YEvKFw>
 <xmx:w8_lZD7xNuAonlSLt5zQsK_Y4nnHmXvA-8oGiuW0m2kYoyufWhXbTQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 05:22:09 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 23 Aug 2023 11:21:58 +0200
Subject: [PATCH v4 1/3] hw/i2c: add smbus pec utility function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-nmi-i2c-v4-1-2b0f86e5be25@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=8bL+r5gcnCGchv7l1z4cPWVJYm8QL5SGL7mTA0JWL9M=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTlz72X3EqVSWHVNHaYNKunrslH55pb9mDC0
 DAhFmxXJGXOXIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk5c+9AAoJEE3hrzFt
 Tw3pCWAIAJrw11uJZod/3DespK3JYZkQEZKLTplG591PlPqYEnHqxSBjTkIw7+q/awzfHlLFxWH
 pgpJm4Z+UwLzDzfwj7MCG3PPnB9spfOU2W4vDuky7Qre/SX6s4hS11CMUWZhyv98f7uoAPeiCIl
 2PJqEQX0kliTMmK6nQbjd16CxPb75dmbOuwuiPDlk24Pyk5hjopb1rxWiRC8mzCYEORz7W4AsDY
 9Kc0/8VZ0Ld2atUcdgKjZOvp4QchN/TSrAaE/f4zztu61Atc6HdYFNCMl6MG6Xv1V0rVUfLcsut
 ABFNeJ+qMWsnnSecqXy9AaKl3DZslm8QfpapH56s0m8JWzaYSEDR4q2u
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

Add i2c_smbus_pec() to calculate the SMBus Packet Error Code for a
message.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/i2c/smbus_master.c         | 26 ++++++++++++++++++++++++++
 include/hw/i2c/smbus_master.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/hw/i2c/smbus_master.c b/hw/i2c/smbus_master.c
index 6a53c34e70b7..01a8e4700222 100644
--- a/hw/i2c/smbus_master.c
+++ b/hw/i2c/smbus_master.c
@@ -15,6 +15,32 @@
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_master.h"
 
+static uint8_t crc8(uint16_t data)
+{
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        if (data & 0x8000) {
+            data ^= 0x1070U << 3;
+        }
+
+        data <<= 1;
+    }
+
+    return (uint8_t)(data >> 8);
+}
+
+uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len)
+{
+    int i;
+
+    for (i = 0; i < len; i++) {
+        crc = crc8((crc ^ buf[i]) << 8);
+    }
+
+    return crc;
+}
+
 /* Master device commands.  */
 int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
 {
diff --git a/include/hw/i2c/smbus_master.h b/include/hw/i2c/smbus_master.h
index bb13bc423c22..d90f81767d86 100644
--- a/include/hw/i2c/smbus_master.h
+++ b/include/hw/i2c/smbus_master.h
@@ -27,6 +27,8 @@
 
 #include "hw/i2c/i2c.h"
 
+uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len);
+
 /* Master device commands.  */
 int smbus_quick_command(I2CBus *bus, uint8_t addr, int read);
 int smbus_receive_byte(I2CBus *bus, uint8_t addr);

-- 
2.42.0


