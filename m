Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA637745D87
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:34:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJZ8-0000CT-1i; Mon, 03 Jul 2023 09:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZ6-0000Br-1p
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:04 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZ3-0000nL-4d
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qvms42TRbz4wqZ;
 Mon,  3 Jul 2023 23:26:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvms16R0Dz4wqX;
 Mon,  3 Jul 2023 23:25:57 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 14/32] hw/sd: Basis for eMMC support
Date: Mon,  3 Jul 2023 15:24:51 +0200
Message-ID: <20230703132509.2474225-15-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703132509.2474225-1-clg@kaod.org>
References: <20230703132509.2474225-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mKPa=CV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The initial eMMC support from Vincent Palatin was largely reworked to
match the current SD framework.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/sd/sd.h |  3 +++
 hw/sd/sd.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 2c8748fb9b97..da97400469a0 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -96,6 +96,9 @@ OBJECT_DECLARE_TYPE(SDState, SDCardClass, SD_CARD)
 #define TYPE_SD_CARD_SPI "sd-card-spi"
 DECLARE_INSTANCE_CHECKER(SDState, SD_CARD_SPI, TYPE_SD_CARD_SPI)
 
+#define TYPE_EMMC "emmc"
+DECLARE_INSTANCE_CHECKER(SDState, EMMC, TYPE_EMMC)
+
 struct SDCardClass {
     /*< private >*/
     DeviceClass parent_class;
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 03fdb3addc38..409fbbcbd8d7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2171,6 +2171,20 @@ static const SDProto sd_proto_sd = {
     },
 };
 
+static const SDProto sd_proto_emmc = {
+    .name = "eMMC",
+    .cmd = {
+        [0]         = sd_cmd_GO_IDLE_STATE,
+        [5]         = sd_cmd_illegal,
+        [19]        = sd_cmd_SEND_TUNING_BLOCK,
+        [23]        = sd_cmd_SET_BLOCK_COUNT,
+        [41]        = sd_cmd_illegal,
+        [52 ... 54] = sd_cmd_illegal,
+        [58]        = sd_cmd_illegal,
+        [59]        = sd_cmd_illegal,
+    },
+};
+
 static void sd_instance_init(Object *obj)
 {
     SDState *sd = SD_CARD(obj);
@@ -2307,10 +2321,40 @@ static const TypeInfo sd_spi_info = {
     .class_init = sd_spi_class_init,
 };
 
+static void emmc_realize(DeviceState *dev, Error **errp)
+{
+    SDState *sd = SD_CARD(dev);
+
+    if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
+            error_setg(errp, "Minimum spec for eMMC is v3.01");
+            return;
+    }
+
+    sd_realize(dev, errp);
+}
+
+static void emmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SDCardClass *sc = SD_CARD_CLASS(klass);
+
+    dc->desc = "eMMC";
+    dc->realize = emmc_realize;
+    sc->proto = &sd_proto_emmc;
+}
+
+static const TypeInfo emmc_info = {
+    .name = TYPE_EMMC,
+    .parent = TYPE_SD_CARD,
+    .class_init = emmc_class_init,
+ };
+
+
 static void sd_register_types(void)
 {
     type_register_static(&sd_info);
     type_register_static(&sd_spi_info);
+    type_register_static(&emmc_info);
 }
 
 type_init(sd_register_types)
-- 
2.41.0


