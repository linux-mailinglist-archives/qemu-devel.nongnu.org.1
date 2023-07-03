Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA0F745D38
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:27:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJYd-0008Pi-QJ; Mon, 03 Jul 2023 09:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJYZ-0008P5-68
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:25:31 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJYW-0000j2-Tu
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:25:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QvmrQ18tNz4wxS;
 Mon,  3 Jul 2023 23:25:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvmrM3B7Vz4wb1;
 Mon,  3 Jul 2023 23:25:23 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 03/32] hw/sd: Move proto_name to SDProto structure
Date: Mon,  3 Jul 2023 15:24:40 +0200
Message-ID: <20230703132509.2474225-4-clg@kaod.org>
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

Introduce a new structure to hold the bus protocol specific
fields: SDProto. The first field is the protocol name.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Message-Id: <20210624142209.1193073-4-f4bug@amsat.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/sd/sd.h |  2 ++
 hw/sd/sd.c         | 35 +++++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 3047adb2fc86..b322d8f19b17 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -124,6 +124,8 @@ struct SDCardClass {
     void (*enable)(SDState *sd, bool enable);
     bool (*get_inserted)(SDState *sd);
     bool (*get_readonly)(SDState *sd);
+
+    const struct SDProto *proto;
 };
 
 #define TYPE_SD_BUS "sd-bus"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 20e62aff70b6..f6aa3b0a80bf 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -87,6 +87,10 @@ enum SDCardStates {
     sd_disconnect_state,
 };
 
+typedef struct SDProto {
+    const char *name;
+} SDProto;
+
 struct SDState {
     DeviceState parent_obj;
 
@@ -137,7 +141,6 @@ struct SDState {
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
-    const char *proto_name;
     bool enable;
     uint8_t dat_lines;
     bool cmd_line;
@@ -145,6 +148,13 @@ struct SDState {
 
 static void sd_realize(DeviceState *dev, Error **errp);
 
+static const struct SDProto *sd_proto(SDState *sd)
+{
+    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
+
+    return sc->proto;
+}
+
 static const char *sd_version_str(enum SDPhySpecificationVersion version)
 {
     static const char *sdphy_version[] = {
@@ -981,8 +991,8 @@ static bool address_in_range(SDState *sd, const char *desc,
 
 static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 {
-    qemu_log_mask(LOG_GUEST_ERROR, "SD: CMD%i in a wrong state: %s (spec %s)\n",
-                  req.cmd, sd_state_name(sd->state),
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong state: %s (spec %s)\n",
+                  sd_proto(sd)->name, req.cmd, sd_state_name(sd->state),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -997,7 +1007,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
      * However there is no ACMD55, so we want to trace this particular case.
      */
     if (req.cmd != 55 || sd->expecting_acmd) {
-        trace_sdcard_normal_command(sd->proto_name,
+        trace_sdcard_normal_command(sd_proto(sd)->name,
                                     sd_cmd_name(req.cmd), req.cmd,
                                     req.arg, sd_state_name(sd->state));
     }
@@ -1562,7 +1572,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    trace_sdcard_app_command(sd->proto_name, sd_acmd_name(req.cmd),
+    trace_sdcard_app_command(sd_proto(sd)->name, sd_acmd_name(req.cmd),
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
@@ -1856,7 +1866,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return;
 
-    trace_sdcard_write_data(sd->proto_name,
+    trace_sdcard_write_data(sd_proto(sd)->name,
                             sd_acmd_name(sd->current_cmd),
                             sd->current_cmd, value);
     switch (sd->current_cmd) {
@@ -2012,7 +2022,7 @@ uint8_t sd_read_byte(SDState *sd)
 
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
-    trace_sdcard_read_data(sd->proto_name,
+    trace_sdcard_read_data(sd_proto(sd)->name,
                            sd_acmd_name(sd->current_cmd),
                            sd->current_cmd, io_len);
     switch (sd->current_cmd) {
@@ -2131,6 +2141,14 @@ void sd_enable(SDState *sd, bool enable)
     sd->enable = enable;
 }
 
+static const SDProto sd_proto_spi = {
+    .name = "SPI",
+};
+
+static const SDProto sd_proto_sd = {
+    .name = "SD",
+};
+
 static void sd_instance_init(Object *obj)
 {
     SDState *sd = SD_CARD(obj);
@@ -2149,9 +2167,10 @@ static void sd_instance_finalize(Object *obj)
 static void sd_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SD_CARD(dev);
+    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
     int ret;
 
-    sd->proto_name = sd->spi ? "SPI" : "SD";
+    sc->proto = sd->spi ? &sd_proto_spi : &sd_proto_sd;
 
     switch (sd->spec_version) {
     case SD_PHY_SPECv1_10_VERS
-- 
2.41.0


