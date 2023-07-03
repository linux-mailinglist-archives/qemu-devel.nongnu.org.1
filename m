Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B188A745D8D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:36:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJZ7-0000CJ-DJ; Mon, 03 Jul 2023 09:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZ4-0000AD-Mo
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:02 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZ1-0000nc-PD
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qvms12cNtz4wxp;
 Mon,  3 Jul 2023 23:25:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvmrz1Pysz4wxS;
 Mon,  3 Jul 2023 23:25:54 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 13/32] hw/sd: Introduce a "sd-card" SPI variant model
Date: Mon,  3 Jul 2023 15:24:50 +0200
Message-ID: <20230703132509.2474225-14-clg@kaod.org>
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

and replace the SDState::spi attribute with a test checking the
SDProto array of commands.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/sd/sd.h  |  3 +++
 hw/arm/stellaris.c  |  3 +--
 hw/riscv/sifive_u.c |  3 +--
 hw/sd/sd.c          | 52 +++++++++++++++++++++++++++++++++------------
 4 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index b322d8f19b17..2c8748fb9b97 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -93,6 +93,9 @@ typedef struct {
 #define TYPE_SD_CARD "sd-card"
 OBJECT_DECLARE_TYPE(SDState, SDCardClass, SD_CARD)
 
+#define TYPE_SD_CARD_SPI "sd-card-spi"
+DECLARE_INSTANCE_CHECKER(SDState, SD_CARD_SPI, TYPE_SD_CARD_SPI)
+
 struct SDCardClass {
     /*< private >*/
     DeviceClass parent_class;
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 5a3106e00939..aa5b0ddfaa5a 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1235,9 +1235,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 
             dinfo = drive_get(IF_SD, 0, 0);
             blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-            carddev = qdev_new(TYPE_SD_CARD);
+            carddev = qdev_new(TYPE_SD_CARD_SPI);
             qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-            qdev_prop_set_bit(carddev, "spi", true);
             qdev_realize_and_unref(carddev,
                                    qdev_get_child_bus(sddev, "sd-bus"),
                                    &error_fatal);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 35a335b8d0ba..ec76dce6c952 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -674,9 +674,8 @@ static void sifive_u_machine_init(MachineState *machine)
 
     dinfo = drive_get(IF_SD, 0, 0);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-    card_dev = qdev_new(TYPE_SD_CARD);
+    card_dev = qdev_new(TYPE_SD_CARD_SPI);
     qdev_prop_set_drive_err(card_dev, "drive", blk, &error_fatal);
-    qdev_prop_set_bit(card_dev, "spi", true);
     qdev_realize_and_unref(card_dev,
                            qdev_get_child_bus(sd_dev, "sd-bus"),
                            &error_fatal);
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d1c0b132c227..03fdb3addc38 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -115,7 +115,6 @@ struct SDState {
 
     uint8_t spec_version;
     BlockBackend *blk;
-    bool spi;
 
     /* Runtime changeables */
 
@@ -159,6 +158,13 @@ static const struct SDProto *sd_proto(SDState *sd)
     return sc->proto;
 }
 
+static const SDProto sd_proto_spi;
+
+static bool sd_is_spi(SDState *sd)
+{
+    return sd_proto(sd) == &sd_proto_spi;
+}
+
 static const char *sd_version_str(enum SDPhySpecificationVersion version)
 {
     static const char *sdphy_version[] = {
@@ -336,7 +342,7 @@ static void sd_set_ocr(SDState *sd)
     /* All voltages OK */
     sd->ocr = R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
 
-    if (sd->spi) {
+    if (sd_is_spi(sd)) {
         /*
          * We don't need to emulate power up sequence in SPI-mode.
          * Thus, the card's power up status bit should be set to 1 when reset.
@@ -741,13 +747,12 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
     SDState *sd;
     Error *err = NULL;
 
-    obj = object_new(TYPE_SD_CARD);
+    obj = object_new(is_spi ? TYPE_SD_CARD_SPI : TYPE_SD_CARD);
     dev = DEVICE(obj);
     if (!qdev_prop_set_drive_err(dev, "drive", blk, &err)) {
         error_reportf_err(err, "sd_init failed: ");
         return NULL;
     }
-    qdev_prop_set_bit(dev, "spi", is_spi);
 
     /*
      * Realizing the device properly would put it into the QOM
@@ -1027,7 +1032,7 @@ static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
         sd_reset(DEVICE(sd));
     }
 
-    return sd->spi ? sd_r1 : sd_r0;
+    return sd_is_spi(sd) ? sd_r1 : sd_r0;
 }
 
 static sd_rsp_type_t sd_cmd_SEND_OP_CMD(SDState *sd, SDRequest req)
@@ -1203,7 +1208,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
         /* No response if not exactly one VHS bit is set.  */
         if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
-            return sd->spi ? sd_r7 : sd_r0;
+            return sd_is_spi(sd) ? sd_r7 : sd_r0;
         }
 
         /* Accept.  */
@@ -1219,7 +1224,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             return sd_r2_s;
 
         case sd_transfer_state:
-            if (!sd->spi)
+            if (!sd_is_spi(sd))
                 break;
             sd->state = sd_sendingdata_state;
             memcpy(sd->data, sd->csd, 16);
@@ -1241,7 +1246,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             return sd_r2_i;
 
         case sd_transfer_state:
-            if (!sd->spi)
+            if (!sd_is_spi(sd))
                 break;
             sd->state = sd_sendingdata_state;
             memcpy(sd->data, sd->cid, 16);
@@ -1274,7 +1279,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 13:  /* CMD13:  SEND_STATUS */
         switch (sd->mode) {
         case sd_data_transfer_mode:
-            if (!sd->spi && sd->rca != rca) {
+            if (!sd_is_spi(sd) && sd->rca != rca) {
                 return sd_r0;
             }
 
@@ -1531,7 +1536,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         default:
             break;
         }
-        if (!sd->spi) {
+        if (!sd_is_spi(sd)) {
             if (sd->rca != rca) {
                 return sd_r0;
             }
@@ -2184,11 +2189,8 @@ static void sd_instance_finalize(Object *obj)
 static void sd_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SD_CARD(dev);
-    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
     int ret;
 
-    sc->proto = sd->spi ? &sd_proto_spi : &sd_proto_sd;
-
     switch (sd->spec_version) {
     case SD_PHY_SPECv1_10_VERS
      ... SD_PHY_SPECv3_01_VERS:
@@ -2245,7 +2247,6 @@ static Property sd_properties[] = {
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
-    DEFINE_PROP_BOOL("spi", SDState, spi, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -2272,6 +2273,7 @@ static void sd_class_init(ObjectClass *klass, void *data)
     sc->enable = sd_enable;
     sc->get_inserted = sd_get_inserted;
     sc->get_readonly = sd_get_readonly;
+    sc->proto = &sd_proto_sd;
 }
 
 static const TypeInfo sd_info = {
@@ -2284,9 +2286,31 @@ static const TypeInfo sd_info = {
     .instance_finalize = sd_instance_finalize,
 };
 
+/*
+ * We do not model the chip select pin, so allow the board to select
+ * whether card should be in SSI or MMC/SD mode.  It is also up to the
+ * board to ensure that ssi transfers only occur when the chip select
+ * is asserted.
+ */
+static void sd_spi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SDCardClass *sc = SD_CARD_CLASS(klass);
+
+    dc->desc = "SD SPI";
+    sc->proto = &sd_proto_spi;
+}
+
+static const TypeInfo sd_spi_info = {
+    .name = TYPE_SD_CARD_SPI,
+    .parent = TYPE_SD_CARD,
+    .class_init = sd_spi_class_init,
+};
+
 static void sd_register_types(void)
 {
     type_register_static(&sd_info);
+    type_register_static(&sd_spi_info);
 }
 
 type_init(sd_register_types)
-- 
2.41.0


