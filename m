Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F41A67A00F8
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 11:56:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgj3D-0001B9-Hh; Thu, 14 Sep 2023 05:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qgj39-00019g-QZ; Thu, 14 Sep 2023 05:54:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qgj37-0003KY-Ai; Thu, 14 Sep 2023 05:54:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 4641C5C075B;
 Thu, 14 Sep 2023 05:54:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 14 Sep 2023 05:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm1; t=1694685252; x=1694771652; bh=qpnACPKjx8FlLuHg7ar9nlBCy
 d2qZX8CR7bnETh4KzI=; b=wu766Yx8srsimGUItL7aw2QmXQ7E5QpQ12Mgz3sUI
 lvlzzRuAggMUH3TDMbaS8bUiTq6J+1floDeh4yD4Ue+y11N5B8mHmmT/mrHyxUru
 /6ohsVFajq4+1HrBeG5XbZ8G+z1AxVl+kX7YwSmARmRfbtYc0LQxnMlqisVPHi4h
 bjBq7xdryT/PpHj96vFPbk/CutMYDvnTwI32AJkPZw2mjf0B7VTkG/BeRp98gnwb
 Wm1zuziTkJKjvisiRU61OCmVTBI8t+M0p3L9WzN0TsOU96ygNTcSxuWCUMMXzt7T
 xQ2UsC+FwSWsfAUEt1eEWxXh6tfQ62f5pwxm4LD4AskFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1694685252; x=1694771652; bh=qpnACPKjx8FlLuHg7ar9nlBCyd2qZX8CR7b
 nETh4KzI=; b=XF62ybUbBiw7weMS6i+jbsdgk3vNMAzI9ZoSFqmWuzSa3mFVZaY
 BFO2oFE2O0Ky8Pt/v0cafjU48hUhyzTAy3BIlqjBKR4t84g1Ha9xSoR2pK3K4tDp
 fN6BRt88wiPLsE2v1SX/alocjDqhTRDEazm8PshPjinF519r869b4ME6Dt4581xQ
 gPRkYc86LNcaOz9rVAAXCkODCz6QOP2QRigoWSrousqU30S/SaKK9cuF+mqGlQto
 qNrW7y6vIyH9OOu5kQo9dDFOmR9yc+i2HRQaHCbusHBv3aoMYSt6biVM3opSWmge
 gEbFwsqKgTSqJqxY0P49EmBRNuGuYl5u8YA==
X-ME-Sender: <xms:RNgCZbkCJdnUh-T34lqCq010Zi4qh3PyS1V1ENUkCiDYY-sD5U3KNg>
 <xme:RNgCZe16tu1nqaMfAQoO-yNfCnikftb49yjvuAj3EPesViaHZJlm1iwe6peKcZ6jF
 LgJ6dXoFnfeYA6VAxg>
X-ME-Received: <xmr:RNgCZRqd__iaMGMg-xO7VcCHOg8rUxStrx1U3qtPDSXH1LPx7aIZ90_4Lslvzc85XEKRvTU4izpF5jQdQID2WVukhYGGvjGrfcQnGgZFoeCWRCLnxoPVdfZuZBH8bUKPXaKRTLFafXYYm9Dp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejtddgvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudevgefgffeiteevfffhhefg
 gefhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:RNgCZTms1lBRLo4dypFZIsiy4qpvvFPz6deih3Vov-lmK0Wq-_tR9w>
 <xmx:RNgCZZ1O8rj0ZlFq6me2lYv1Khrj3ZXLOCeHomhP-Ii6oHy8YXrhgg>
 <xmx:RNgCZSsjb5Ho0Vjs_y0DE-dkTqW1XX6RVtAHECOM_mmSefOxNga2aw>
 <xmx:RNgCZTN9LjbA_Hx30wNZmg-tNJEJ8c06WuZ2IYGCgj3s-ZZccdMewQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Sep 2023 05:54:10 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 14 Sep 2023 11:53:41 +0200
Subject: [PATCH v6 1/3] hw/i2c: add smbus pec utility function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-nmi-i2c-v6-1-11bbb4f74d18@samsung.com>
References: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
In-Reply-To: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
To: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 Keith Busch <kbusch@kernel.org>
Cc: Lior Weintraub <liorw@pliops.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, Peter Delevoryas <peter@pjd.dev>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=IESKvosDnCV2lesmuDXJATWi4RhD+1Qnj529Hd0bnqM=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGUC2D7xDqo6QNBe//UAp5GyFuY5se1jEWQeW
 mBlKoA/ewyZlYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJlAtg+AAoJEE3hrzFt
 Tw3pzvwH/3Apaz03lYk7I14B1DBRCrcrVII5OQUpQRP0woTVn+evdx5uLggphJqP+P7VnGyOv1X
 Ecx+qqyeQmQjzs3BtVZXc0fLjWBJM1Sjp5q6J+Pwj60RhInUywvG1PgdqKhYykhHHPStYp/NoCe
 1BwwGtZUMXepGtEXzBmtELZ4Cblb4xAHQrWq9oa7/uTFcX2smqQGgo1qWrX5Dryn1tPNfskUe63
 ecG7A83j6qer0ybcd+VnzN58iSN6NLxAZDYFpfYbfdgFXt4AbCr66V+KxXlYrsLWWB+hiBBPcGw
 6PRmMmvV08vp4T1yiMC2tq8qj6d/C9cRt8hGfdhK01MBZnmFq83MlKk6
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


