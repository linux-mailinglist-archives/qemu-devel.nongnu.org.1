Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51134792115
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 10:40:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRav-000318-W7; Tue, 05 Sep 2023 04:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qdRaH-0002tl-Lx; Tue, 05 Sep 2023 04:38:54 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qdRaF-0002i6-7L; Tue, 05 Sep 2023 04:38:53 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 10659320096D;
 Tue,  5 Sep 2023 04:38:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 05 Sep 2023 04:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1693903126; x=1693989526; bh=qpnACPKjx8FlLuHg7ar9nlBCy
 d2qZX8CR7bnETh4KzI=; b=KKC79wYPGgoKf1ddHB1aohk+2Neq10n+hlZ2OZJSc
 0Yx1abBsWa5ECRxvnvXiL34oSRSo7uBHupX1DRVC8Q7R8jXSsceOOPqGQU2Wv+j4
 2VfyDDJqCadSjDPzu4357MExkSwI1Qxh9Js+Z2Sut5//alud+0Q9lo6zxQREne1q
 YXJnQ3t8MPApDMp6lywICxQCj9QEqRUHQpHu8YRQwMT+UP9rhvdQW3U2OCFtxMIO
 GKFSD5zxXKXF+Dpw1AjoJRoc05tbktGNiQ4K40P2b8QW74HcsyMJr3OERfli8mkF
 HLeElISBcvKiEMZbRd2ft+Pc6XdEEczshftv3cN7i8KpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1693903126; x=1693989526; bh=qpnACPKjx8FlLuHg7ar9nlBCyd2qZX8CR7b
 nETh4KzI=; b=pB5p12QQ91C6IRIexDJMq79TVv4hvwVHvwESWKE7fZOslsGfzTD
 CuLQUFKnIfkznV1S99rtN0i7IrZT3Va/0hvMm40XTCjZSccAiURmlewaOG7LEreV
 A1eYHBKioKMIp2Kn+eLT+8qVlZiHDby0yAReVzx16c4k0GxnQYU489yOlqByGbKL
 dmqQeccMHwq2rSLQZLa6c3lTlxun7bu3XFbxcdbHh8p2Y5qqe8q98prpQzZwMj0+
 2lMfZTswLlaoVb+0NDkpy9KycngDHkVD0lQxFxWHXpPW0T6BQa+FZOc85hMzF1fX
 cno7pVQQzdhthnx0mbr2tyBq3K6EXxR39Sw==
X-ME-Sender: <xms:Fun2ZM_z1MNcJ5uQBcr7dnHM-CLOyOfe626n4coCr2xDuKa89jnIWw>
 <xme:Fun2ZEvlgUFZFWhi1-5ogaf9gIDpNBn7sVb_nPwcreO7p6xXhibrXDDWixQsfigiy
 R0F4QZ8RTMj5IELAd0>
X-ME-Received: <xmr:Fun2ZCBb1PpBtMLLcKEBWyXeVTVJrOZg1WU7eSSVAuIzUltBQaFQ1UaQd37h9S1Isqpa_IS_zd-g2SnZzYfkYALcM9FZQqxK5RXXaUVhFhyr_StCGb5fmnqyNpsTlajszYNJ56kDa6SHCw4Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehtddgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudevgefgffeiteevfffhhefg
 gefhffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Fun2ZMf4rJzZpmHm_UjGvFG2sKbRYMHXceU8Ucb8QpuOHSw4I_IUjQ>
 <xmx:Fun2ZBN74EJrBaQzDwRDvtRHu8DkyeibVS9nB6ebAkLu8XYJmhVL1Q>
 <xmx:Fun2ZGkVkpjA-uOwrWWIYzvyEWPOenVsqSrmiqEK_F345jodgR8QAw>
 <xmx:Fun2ZHuZK9zkLTNc4LIwdllmaULVu7nH3dOD9zixz79GeKWZujgpkg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Sep 2023 04:38:44 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 05 Sep 2023 10:38:32 +0200
Subject: [PATCH v5 1/3] hw/i2c: add smbus pec utility function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-nmi-i2c-v5-1-0001d372a728@samsung.com>
References: <20230905-nmi-i2c-v5-0-0001d372a728@samsung.com>
In-Reply-To: <20230905-nmi-i2c-v5-0-0001d372a728@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=IESKvosDnCV2lesmuDXJATWi4RhD+1Qnj529Hd0bnqM=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGT26Q4+Ar0rlGVmMGzGxYBLAqrMA1b59tbvF
 OjLsuBYtDcOkokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk9ukOAAoJEE3hrzFt
 Tw3pwJ8H/3yPpmfeP7BxAJn32Vfb4yoWjbJX4FoaFUuVmfpJaJFWi2zXEHrISt93T7aQr30060A
 0cINdtIbu5aEL8MWVLzKTRvlyydvTSeOg9+MtmGDqflC/a716POe5SHDKdmEdkx4li02o6XsBYq
 U12JlM6P3wPj9OMjBDARpnkcb1/kuOcdEPB8/N2KAOL8GW+YA7YIxL/yajAzkFHEfdttPIbxJ4u
 dOp7MwCBQ/5vevq0IW8PrP/PSYBRfSQVSx+2/eZ4FGN4uNJ2NhlomafuM99Z2VXWmznNjgOQjaY
 LJD/9eT8aUTpr7CHDdL2ebW+jYitNvGQouYlF4W9WJMr/J/XXvq4x7R7
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=64.147.123.19; envelope-from=its@irrelevant.dk;
 helo=wout3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


