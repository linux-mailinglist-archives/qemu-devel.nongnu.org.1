Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C3F731B43
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 16:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9ntn-0003BV-Hd; Thu, 15 Jun 2023 10:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <postmaster@kaiser.cx>)
 id 1q9nti-0003Aw-4g; Thu, 15 Jun 2023 10:24:26 -0400
Received: from viti.kaiser.cx ([2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <postmaster@kaiser.cx>)
 id 1q9ntg-00086e-JY; Thu, 15 Jun 2023 10:24:25 -0400
Received: from [94.118.66.68] (helo=martin-debian-2.paytec.ch)
 by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <martin@kaiser.cx>)
 id 1q9ntX-0001T5-QI; Thu, 15 Jun 2023 16:24:16 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v3] imx_serial: set wake bit when we receive a data byte
Date: Thu, 15 Jun 2023 15:22:56 +0100
Message-Id: <20230615142256.1142849-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230608154129.133169-1-martin@kaiser.cx>
References: <20230608154129.133169-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f;
 envelope-from=postmaster@kaiser.cx; helo=viti.kaiser.cx
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Linux kernel added a flood check for RX data recently in commit
496a4471b7c3 ("serial: imx: work-around for hardware RX flood"). This
check uses the wake bit in the UART status register 2. The wake bit
indicates that the receiver detected a start bit on the RX line. If the
kernel sees a number of RX interrupts without the wake bit being set, it
treats this as spurious data and resets the UART port. imx_serial does
never set the wake bit and triggers the kernel's flood check.

This patch adds support for the wake bit. wake is set when we receive a
new character (it's not set for break events). It seems that wake is
cleared by the kernel driver, the hardware does not have to clear it
automatically after data was read.

The wake bit can be configured as an interrupt source. Support this
mechanism as well.

Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v3:
 - fix some spelling mistakes in the commit message
 - add Philippe's Reviewed-by

v2:
 - support interrupts from wake
 - clean up the commit message

 hw/char/imx_serial.c         | 5 ++++-
 include/hw/char/imx_serial.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index ee1375e26d..1b75a89588 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -80,7 +80,7 @@ static void imx_update(IMXSerialState *s)
      * TCEN and TXDC are both bit 3
      * RDR and DREN are both bit 0
      */
-    mask |= s->ucr4 & (UCR4_TCEN | UCR4_DREN);
+    mask |= s->ucr4 & (UCR4_WKEN | UCR4_TCEN | UCR4_DREN);
 
     usr2 = s->usr2 & mask;
 
@@ -321,6 +321,9 @@ static void imx_put_data(void *opaque, uint32_t value)
 
 static void imx_receive(void *opaque, const uint8_t *buf, int size)
 {
+    IMXSerialState *s = (IMXSerialState *)opaque;
+
+    s->usr2 |= USR2_WAKE;
     imx_put_data(opaque, *buf);
 }
 
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 91c9894ad5..b823f94519 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -71,6 +71,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
 
 #define UCR4_DREN       BIT(0)    /* Receive Data Ready interrupt enable */
 #define UCR4_TCEN       BIT(3)    /* TX complete interrupt enable */
+#define UCR4_WKEN       BIT(7)    /* WAKE interrupt enable */
 
 #define UTS1_TXEMPTY    (1<<6)
 #define UTS1_RXEMPTY    (1<<5)
-- 
2.30.2


