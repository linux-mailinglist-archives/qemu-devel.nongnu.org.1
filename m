Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF7082C096
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:12:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHDy-0007TC-Le; Fri, 12 Jan 2024 08:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHDs-0006qE-NE
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:05:20 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHDq-0003e3-Qq
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ob+mF+Q+ybuW/aQQDHwJ6hST/S85cmCXIzfHssHpc0c=; b=oPS5vSYbVL4OLFbcLgZsWaKNNy
 j49l/jJjY9KygSmy1pJhSnlyw7r2hynaFQxhw9ZkygGwO/wnYEex4Kvchg8GlrgaaUmfMhmrHmovg
 zLblkNHx4Homm4rRwNeKLJdjh0VGMRu6NkkQVGJeJBnoqpME4ciStkNE56VvziSU1XGJRCBwoTVQ6
 kxxqj16dAPg3U4YpopVAUubE90r64FrTz91Qg2bHjmU5OTio96p0lzK2hZGiUGUMikVtsNjKNvtYz
 ENwQNoZSftNRaPGYbZYdj7mgfPSBc5uAwPNn3NqvWdgoa51yoblYeEVEA4KP1zdZ6o3+y3fAHgzCd
 zLIM9rmh07eYAiIiJxPTE8X1A+l4Xl5P8FyxtCh2z85fGwpqC+GQau6xRkPSy4mlploT1dnCiPYrX
 GbHVNQyAQQH56eeXTksMiPOlZiz2Aw2o9qfXQsfy/oEFYEmOHanPQKGlhkyzSyINA7mHJkf2JRaqt
 heZ42Iae4SzLdvmmGQay7h8ZylcTO7zJXSl4I5QX0+4mgYHJ9jjej5GEtj7xyGc42NWQP4Go8Q6jo
 P8a8zt80KJ5xVDFDW0VhCdv43i8A7Q0MkaVB/IExaSrLbgphz20hvYAbpxoQ5ze23ZBTx5yamEtYb
 cCBbiGDE8hdIUISJPcLdkN80fH+bXShvJ3ER5do2Y=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH7Q-0008jM-C2; Fri, 12 Jan 2024 12:58:40 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:19 +0000
Message-Id: <20240112125420.514425-88-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 87/88] esp.c: switch TypeInfo registration to use
 DEFINE_TYPES() macro
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The use of the DEFINE_TYPES() macro will soon be recommended over the use of
calling type_init() directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 04615d8b5f..b8762d5ee0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1549,14 +1549,6 @@ static void sysbus_esp_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
-static const TypeInfo sysbus_esp_info = {
-    .name          = TYPE_SYSBUS_ESP,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_init = sysbus_esp_init,
-    .instance_size = sizeof(SysBusESPState),
-    .class_init    = sysbus_esp_class_init,
-};
-
 static void esp_finalize(Object *obj)
 {
     ESPState *s = ESP(obj);
@@ -1582,19 +1574,22 @@ static void esp_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
-static const TypeInfo esp_info = {
-    .name = TYPE_ESP,
-    .parent = TYPE_DEVICE,
-    .instance_init = esp_init,
-    .instance_finalize = esp_finalize,
-    .instance_size = sizeof(ESPState),
-    .class_init = esp_class_init,
+static const TypeInfo esp_info_types[] = {
+    {
+        .name          = TYPE_SYSBUS_ESP,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_init = sysbus_esp_init,
+        .instance_size = sizeof(SysBusESPState),
+        .class_init    = sysbus_esp_class_init,
+    },
+    {
+        .name = TYPE_ESP,
+        .parent = TYPE_DEVICE,
+        .instance_init = esp_init,
+        .instance_finalize = esp_finalize,
+        .instance_size = sizeof(ESPState),
+        .class_init = esp_class_init,
+    },
 };
 
-static void esp_register_types(void)
-{
-    type_register_static(&sysbus_esp_info);
-    type_register_static(&esp_info);
-}
-
-type_init(esp_register_types)
+DEFINE_TYPES(esp_info_types)
-- 
2.39.2


