Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7163E78FB55
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 11:46:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc0fp-0001UF-Iw; Fri, 01 Sep 2023 05:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc0fn-0001OA-LZ; Fri, 01 Sep 2023 05:42:39 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc0fl-0002tv-9R; Fri, 01 Sep 2023 05:42:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RcY3Z5r3Sz4x3k;
 Fri,  1 Sep 2023 19:42:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RcY3X5h8Cz4x3H;
 Fri,  1 Sep 2023 19:42:32 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PULL 06/26] hw/ssi: Add a "cs" property to SSIPeripheral
Date: Fri,  1 Sep 2023 11:41:54 +0200
Message-ID: <20230901094214.296918-7-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901094214.296918-1-clg@kaod.org>
References: <20230901094214.296918-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=SnXb=ER=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

Boards will use this new property to identify the device CS line and
wire the SPI controllers accordingly.

Cc: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ssi/ssi.h | 3 +++
 hw/ssi/ssi.c         | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 6950f86810d3..c5bdf1f2165f 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -64,6 +64,9 @@ struct SSIPeripheral {
 
     /* Chip select state */
     bool cs;
+
+    /* Chip select index */
+    uint8_t cs_index;
 };
 
 extern const VMStateDescription vmstate_ssi_peripheral;
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index d54a109beeb5..4e33e0ea5bc2 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -71,6 +72,11 @@ static void ssi_peripheral_realize(DeviceState *dev, Error **errp)
     ssc->realize(s, errp);
 }
 
+static Property ssi_peripheral_properties[] = {
+    DEFINE_PROP_UINT8("cs", SSIPeripheral, cs_index, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void ssi_peripheral_class_init(ObjectClass *klass, void *data)
 {
     SSIPeripheralClass *ssc = SSI_PERIPHERAL_CLASS(klass);
@@ -81,6 +87,7 @@ static void ssi_peripheral_class_init(ObjectClass *klass, void *data)
     if (!ssc->transfer_raw) {
         ssc->transfer_raw = ssi_transfer_raw_default;
     }
+    device_class_set_props(dc, ssi_peripheral_properties);
 }
 
 static const TypeInfo ssi_peripheral_info = {
-- 
2.41.0


