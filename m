Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC7745D91
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJZa-0001P1-34; Mon, 03 Jul 2023 09:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZV-000132-3g
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:29 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZR-0000sw-Ma
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QvmsW28R8z4wxm;
 Mon,  3 Jul 2023 23:26:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvmsT0wT6z4wqX;
 Mon,  3 Jul 2023 23:26:20 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 22/32] hw/sd: Add emmc_cmd_SEND_EXT_CSD() handler
Date: Mon,  3 Jul 2023 15:24:59 +0200
Message-ID: <20230703132509.2474225-23-clg@kaod.org>
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

The parameters mimick a real 4GB eMMC, but it can be set to various
sizes. Initially from Vincent Palatin <vpalatin@chromium.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/sd/sdmmc-internal.h |  97 ++++++++++++++++++++++++++++++++++++
 include/hw/sd/sd.h     |   1 +
 hw/sd/sd.c             | 109 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index d8bf17d204fc..2b98f117cd8f 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -37,4 +37,101 @@ const char *sd_cmd_name(uint8_t cmd);
  */
 const char *sd_acmd_name(uint8_t cmd);
 
+/*
+ * EXT_CSD fields
+ */
+
+#define EXT_CSD_CMDQ_MODE_EN            15      /* R/W */
+#define EXT_CSD_FLUSH_CACHE             32      /* W */
+#define EXT_CSD_CACHE_CTRL              33      /* R/W */
+#define EXT_CSD_POWER_OFF_NOTIFICATION  34      /* R/W */
+#define EXT_CSD_PACKED_FAILURE_INDEX    35      /* RO */
+#define EXT_CSD_PACKED_CMD_STATUS       36      /* RO */
+#define EXT_CSD_EXP_EVENTS_STATUS       54      /* RO, 2 bytes */
+#define EXT_CSD_EXP_EVENTS_CTRL         56      /* R/W, 2 bytes */
+#define EXT_CSD_DATA_SECTOR_SIZE        61      /* R */
+#define EXT_CSD_GP_SIZE_MULT            143     /* R/W */
+#define EXT_CSD_PARTITION_SETTING_COMPLETED 155 /* R/W */
+#define EXT_CSD_PARTITION_ATTRIBUTE     156     /* R/W */
+#define EXT_CSD_PARTITION_SUPPORT       160     /* RO */
+#define EXT_CSD_HPI_MGMT                161     /* R/W */
+#define EXT_CSD_RST_N_FUNCTION          162     /* R/W */
+#define EXT_CSD_BKOPS_EN                163     /* R/W */
+#define EXT_CSD_BKOPS_START             164     /* W */
+#define EXT_CSD_SANITIZE_START          165     /* W */
+#define EXT_CSD_WR_REL_PARAM            166     /* RO */
+#define EXT_CSD_RPMB_MULT               168     /* RO */
+#define EXT_CSD_FW_CONFIG               169     /* R/W */
+#define EXT_CSD_BOOT_WP                 173     /* R/W */
+#define EXT_CSD_ERASE_GROUP_DEF         175     /* R/W */
+#define EXT_CSD_PART_CONFIG             179     /* R/W */
+#define EXT_CSD_ERASED_MEM_CONT         181     /* RO */
+#define EXT_CSD_BUS_WIDTH               183     /* R/W */
+#define EXT_CSD_STROBE_SUPPORT          184     /* RO */
+#define EXT_CSD_HS_TIMING               185     /* R/W */
+#define EXT_CSD_POWER_CLASS             187     /* R/W */
+#define EXT_CSD_REV                     192     /* RO */
+#define EXT_CSD_STRUCTURE               194     /* RO */
+#define EXT_CSD_CARD_TYPE               196     /* RO */
+#define EXT_CSD_DRIVER_STRENGTH         197     /* RO */
+#define EXT_CSD_OUT_OF_INTERRUPT_TIME   198     /* RO */
+#define EXT_CSD_PART_SWITCH_TIME        199     /* RO */
+#define EXT_CSD_PWR_CL_52_195           200     /* RO */
+#define EXT_CSD_PWR_CL_26_195           201     /* RO */
+#define EXT_CSD_PWR_CL_52_360           202     /* RO */
+#define EXT_CSD_PWR_CL_26_360           203     /* RO */
+#define EXT_CSD_SEC_CNT                 212     /* RO, 4 bytes */
+#define EXT_CSD_S_A_TIMEOUT             217     /* RO */
+#define EXT_CSD_S_C_VCCQ                219     /* RO */
+#define EXT_CSD_S_C_VCC                 220     /* RO */
+#define EXT_CSD_REL_WR_SEC_C            222     /* RO */
+#define EXT_CSD_HC_WP_GRP_SIZE          221     /* RO */
+#define EXT_CSD_ERASE_TIMEOUT_MULT      223     /* RO */
+#define EXT_CSD_HC_ERASE_GRP_SIZE       224     /* RO */
+#define EXT_CSD_ACC_SIZE                225     /* RO */
+#define EXT_CSD_BOOT_MULT               226     /* RO */
+#define EXT_CSD_BOOT_INFO               228     /* RO */
+#define EXT_CSD_SEC_TRIM_MULT           229     /* RO */
+#define EXT_CSD_SEC_ERASE_MULT          230     /* RO */
+#define EXT_CSD_SEC_FEATURE_SUPPORT     231     /* RO */
+#define EXT_CSD_TRIM_MULT               232     /* RO */
+#define EXT_CSD_PWR_CL_200_195          236     /* RO */
+#define EXT_CSD_PWR_CL_200_360          237     /* RO */
+#define EXT_CSD_PWR_CL_DDR_52_195       238     /* RO */
+#define EXT_CSD_PWR_CL_DDR_52_360       239     /* RO */
+#define EXT_CSD_BKOPS_STATUS            246     /* RO */
+#define EXT_CSD_POWER_OFF_LONG_TIME     247     /* RO */
+#define EXT_CSD_GENERIC_CMD6_TIME       248     /* RO */
+#define EXT_CSD_CACHE_SIZE              249     /* RO, 4 bytes */
+#define EXT_CSD_PWR_CL_DDR_200_360      253     /* RO */
+#define EXT_CSD_FIRMWARE_VERSION        254     /* RO, 8 bytes */
+#define EXT_CSD_PRE_EOL_INFO            267     /* RO */
+#define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A      268     /* RO */
+#define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B      269     /* RO */
+#define EXT_CSD_CMDQ_DEPTH              307     /* RO */
+#define EXT_CSD_CMDQ_SUPPORT            308     /* RO */
+#define EXT_CSD_SUPPORTED_MODE          493     /* RO */
+#define EXT_CSD_TAG_UNIT_SIZE           498     /* RO */
+#define EXT_CSD_DATA_TAG_SUPPORT        499     /* RO */
+#define EXT_CSD_MAX_PACKED_WRITES       500     /* RO */
+#define EXT_CSD_MAX_PACKED_READS        501     /* RO */
+#define EXT_CSD_BKOPS_SUPPORT           502     /* RO */
+#define EXT_CSD_HPI_FEATURES            503     /* RO */
+#define EXT_CSD_S_CMD_SET               504     /* RO */
+
+/*
+ * EXT_CSD field definitions
+ */
+
+#define EXT_CSD_WR_REL_PARAM_EN         (1 << 2)
+#define EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR     (1 << 4)
+
+#define EXT_CSD_PART_CONFIG_ACC_MASK    (0x7)
+#define EXT_CSD_PART_CONFIG_ACC_DEFAULT (0x0)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT0   (0x1)
+
+#define EXT_CSD_PART_CONFIG_EN_MASK     (0x7 << 3)
+#define EXT_CSD_PART_CONFIG_EN_BOOT0    (0x1 << 3)
+#define EXT_CSD_PART_CONFIG_EN_USER     (0x7 << 3)
+
 #endif
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index da97400469a0..1565cd2b353c 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -132,6 +132,7 @@ struct SDCardClass {
     bool (*get_readonly)(SDState *sd);
 
     const struct SDProto *proto;
+    void (*set_csd)(SDState *sd, uint64_t size);
 };
 
 #define TYPE_SD_BUS "sd-bus"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 51e2254728a6..212658050441 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -141,6 +141,7 @@ struct SDState {
     uint64_t data_start;
     uint32_t data_offset;
     uint8_t data[512];
+    uint8_t ext_csd[512];
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
@@ -414,8 +415,85 @@ static const uint8_t sd_csd_rw_mask[16] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
 };
 
+static void mmc_set_ext_csd(SDState *sd, uint64_t size)
+{
+    uint32_t sectcount = size >> HWBLOCK_SHIFT;
+
+    memset(sd->ext_csd, 0, sizeof(sd->ext_csd));
+
+    sd->ext_csd[EXT_CSD_S_CMD_SET] = 0x1; /* supported command sets */
+    sd->ext_csd[EXT_CSD_HPI_FEATURES] = 0x3; /* HPI features  */
+    sd->ext_csd[EXT_CSD_BKOPS_SUPPORT] = 0x1; /* Background operations */
+    sd->ext_csd[241] = 0xA; /* 1st initialization time after partitioning */
+    sd->ext_csd[EXT_CSD_TRIM_MULT] = 0x1; /* Trim multiplier */
+    sd->ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] = 0x15; /* Secure feature */
+    sd->ext_csd[EXT_CSD_SEC_ERASE_MULT] = 0x96; /* Secure erase support */
+    sd->ext_csd[EXT_CSD_SEC_TRIM_MULT] = 0x96; /* Secure TRIM multiplier */
+    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x7; /* Boot information */
+    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 128KB unit */
+    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x6; /* Access size */
+    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x4; /* HC Erase unit size */
+    sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x1; /* HC erase timeout */
+    sd->ext_csd[EXT_CSD_REL_WR_SEC_C] = 0x1; /* Reliable write sector count */
+    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x4; /* HC write protect group size */
+    sd->ext_csd[EXT_CSD_S_C_VCC] = 0x8; /* Sleep current VCC  */
+    sd->ext_csd[EXT_CSD_S_C_VCCQ] = 0x7; /* Sleep current VCCQ */
+    sd->ext_csd[EXT_CSD_S_A_TIMEOUT] = 0x11; /* Sleep/Awake timeout */
+    sd->ext_csd[215] = (sectcount >> 24) & 0xff; /* Sector count */
+    sd->ext_csd[214] = (sectcount >> 16) & 0xff; /* ... */
+    sd->ext_csd[213] = (sectcount >> 8) & 0xff;  /* ... */
+    sd->ext_csd[EXT_CSD_SEC_CNT] = (sectcount & 0xff);       /* ... */
+    sd->ext_csd[210] = 0xa; /* Min write perf for 8bit@52Mhz */
+    sd->ext_csd[209] = 0xa; /* Min read perf for 8bit@52Mhz  */
+    sd->ext_csd[208] = 0xa; /* Min write perf for 4bit@52Mhz */
+    sd->ext_csd[207] = 0xa; /* Min read perf for 4bit@52Mhz */
+    sd->ext_csd[206] = 0xa; /* Min write perf for 4bit@26Mhz */
+    sd->ext_csd[205] = 0xa; /* Min read perf for 4bit@26Mhz */
+    sd->ext_csd[EXT_CSD_PART_SWITCH_TIME] = 0x1;
+    sd->ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] = 0x1;
+    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0x7;
+    sd->ext_csd[EXT_CSD_STRUCTURE] = 0x2;
+    sd->ext_csd[EXT_CSD_REV] = 0x5;
+    sd->ext_csd[EXT_CSD_RPMB_MULT] = 0x1; /* RPMB size */
+    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0x3;
+    sd->ext_csd[159] = 0x00; /* Max enhanced area size */
+    sd->ext_csd[158] = 0x00; /* ... */
+    sd->ext_csd[157] = 0xEC; /* ... */
+}
+
+static void sd_emmc_set_csd(SDState *sd, uint64_t size)
+{
+    sd->csd[0] = 0xd0;
+    sd->csd[1] = 0x0f;
+    sd->csd[2] = 0x00;
+    sd->csd[3] = 0x32;
+    sd->csd[4] = 0x0f;
+    if (size <= 2 * GiB) {
+        /* use 1k blocks */
+        uint32_t csize1k = (size >> (CMULT_SHIFT + 10)) - 1;
+        sd->csd[5] = 0x5a;
+        sd->csd[6] = 0x80 | ((csize1k >> 10) & 0xf);
+        sd->csd[7] = (csize1k >> 2) & 0xff;
+    } else { /* >= 2GB : size stored in ext CSD, block addressing */
+        sd->csd[5] = 0x59;
+        sd->csd[6] = 0x8f;
+        sd->csd[7] = 0xff;
+        sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
+    }
+    sd->csd[8] = 0xff;
+    sd->csd[9] = 0xff;
+    sd->csd[10] = 0xf7;
+    sd->csd[11] = 0xfe;
+    sd->csd[12] = 0x49;
+    sd->csd[13] = 0x10;
+    sd->csd[14] = 0x00;
+    sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
+    mmc_set_ext_csd(sd, size);
+}
+
 static void sd_set_csd(SDState *sd, uint64_t size)
 {
+    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
     int hwblock_shift = HWBLOCK_SHIFT;
     uint32_t csize;
     uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
@@ -427,7 +505,9 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     }
     csize = (size >> (CMULT_SHIFT + hwblock_shift)) - 1;
 
-    if (size <= SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
+    if (sc->set_csd) {
+        sc->set_csd(sd, size);
+    } else if (size <= SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
         sd->csd[0] = 0x00;      /* CSD structure */
         sd->csd[1] = 0x26;      /* Data read access-time-1 */
         sd->csd[2] = 0x00;      /* Data read access-time-2 */
@@ -2110,6 +2190,14 @@ uint8_t sd_read_byte(SDState *sd)
             sd->state = sd_transfer_state;
         break;
 
+    case 8:     /* CMD8: SEND_EXT_CSD on MMC */
+        ret = sd->data[sd->data_offset++];
+
+        if (sd->data_offset >= sizeof(sd->ext_csd)) {
+            sd->state = sd_transfer_state;
+        }
+        break;
+
     case 9:  /* CMD9:   SEND_CSD */
     case 10:  /* CMD10:  SEND_CID */
         ret = sd->data[sd->data_offset ++];
@@ -2285,6 +2373,23 @@ static sd_rsp_type_t emmc_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
     return sd_r2_i;
 }
 
+static sd_rsp_type_t emmc_cmd_SEND_EXT_CSD(SDState *sd, SDRequest req)
+{
+    uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
+
+    switch (sd->state) {
+    case sd_transfer_state:
+        /* MMC : Sends the EXT_CSD register as a Block of data */
+        sd->state = sd_sendingdata_state;
+        memcpy(sd->data, sd->ext_csd, sizeof(sd->ext_csd));
+        sd->data_start = addr;
+        sd->data_offset = 0;
+        return sd_r1;
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 static sd_rsp_type_t emmc_cmd_APP_CMD(SDState *sd, SDRequest req)
 {
     return sd_r0;
@@ -2323,6 +2428,7 @@ static const SDProto sd_proto_emmc = {
         [3]         = emmc_cmd_SEND_RELATIVE_ADDR,
         [5]         = sd_cmd_illegal,
         [6]         = emmc_cmd_SWITCH_FUNCTION,
+        [8]         = emmc_cmd_SEND_EXT_CSD,
         [19]        = sd_cmd_SEND_TUNING_BLOCK,
         [23]        = sd_cmd_SET_BLOCK_COUNT,
         [21]        = emmc_cmd_SEND_TUNING_BLOCK,
@@ -2490,6 +2596,7 @@ static void emmc_class_init(ObjectClass *klass, void *data)
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     sc->proto = &sd_proto_emmc;
+    sc->set_csd = sd_emmc_set_csd;
 }
 
 static const TypeInfo emmc_info = {
-- 
2.41.0


