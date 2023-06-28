Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19D740D11
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERbl-0007LG-B8; Wed, 28 Jun 2023 05:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1qERbi-0007Jc-L5; Wed, 28 Jun 2023 05:37:02 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1qERbg-0008Qw-AB; Wed, 28 Jun 2023 05:37:02 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 0E26211EECC;
 Wed, 28 Jun 2023 09:36:58 +0000 (UTC)
From: ~ssinprem <ssinprem@git.sr.ht>
Date: Wed, 28 Jun 2023 16:09:23 +0700
Subject: [PATCH qemu] aspeed add montblanc bmc reference from fuji
Message-ID: <168794501779.28884.3336012012258765799-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: ssinprem@celestica.com, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.a, qemu-stable@nongnu.org,
 srikanth@celestica.com, ssumet@celestica.com, thangavelu.v@celestica.com,
 kgengan@celestica.com, anandaramanv@celestica.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-To: ~ssinprem <ssinprem@celestica.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Sittisak Sinprem <ssinprem@celestica.com>

- I2C list follow I2C Tree v1.6 20230320
- fru eeprom data use FB FRU format version 4

Signed-off-by: Sittisak Sinprem <ssinprem@celestica.com>
---
 hw/arm/aspeed.c        | 67 ++++++++++++++++++++++++++++++++++++++++++
 hw/arm/aspeed_eeprom.c | 50 +++++++++++++++++++++++++++++++
 hw/arm/aspeed_eeprom.h |  7 +++++
 3 files changed, 124 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6880998484..df154cbf52 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -182,6 +182,10 @@ struct AspeedMachineState {
 #define FUJI_BMC_HW_STRAP1    0x00000000
 #define FUJI_BMC_HW_STRAP2    0x00000000
=20
+/* Montblanc hardware value */
+#define MONTBLANC_BMC_HW_STRAP1    0x00000000
+#define MONTBLANC_BMC_HW_STRAP2    0x00000000
+
 /* Bletchley hardware value */
 /* TODO: Leave same as EVB for now. */
 #define BLETCHLEY_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
@@ -918,6 +922,39 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
     }
 }
=20
+static void montblanc_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc =3D &bmc->soc;
+    I2CBus *i2c[16] =3D {};
+
+    for (int i =3D 0; i < 16; i++) {
+        i2c[i] =3D aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    /* Ref from Minipack3_I2C_Tree_V1.6 20230320 */
+    at24c_eeprom_init(i2c[3], 0x56, montblanc_scm_fruid, 8192, true);
+    at24c_eeprom_init(i2c[6], 0x53, montblanc_fcm_fruid, 8192, true);
+
+    /* CPLD and FPGA */
+    aspeed_eeprom_init(i2c[1], 0x35, 256);  /* SCM CPLD */
+    aspeed_eeprom_init(i2c[5], 0x35, 256);  /* COMe CPLD TODO: need to updat=
e */
+    aspeed_eeprom_init(i2c[12], 0x60, 256); /* MCB PWR CPLD */
+    aspeed_eeprom_init(i2c[13], 0x35, 256); /* IOB FPGA */
+
+    /* on BMC board */
+    at24c_eeprom_init(i2c[8], 0x51, montblanc_bmc_fruid, 8192, true);
+                                                      /* BMC EEPROM */
+    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x48); /* Thermal Sensor */
+
+    /* COMe Sensor/EEPROM */
+    aspeed_eeprom_init(i2c[0], 0x56, 16384);          /* FRU EEPROM */
+    i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x48); /* INLET Sensor */
+    i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x4A); /* OUTLET Sensor */
+
+    /* It expects a pca9555 but a pca9552 is compatible */
+    create_pca9552(soc, 4, 0x27);
+}
+
 #define TYPE_TMP421 "tmp421"
=20
 static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
@@ -1450,6 +1487,32 @@ static void aspeed_machine_fuji_class_init(ObjectClass=
 *oc, void *data)
         aspeed_soc_num_cpus(amc->soc_name);
 };
=20
+/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
+#if HOST_LONG_BITS =3D=3D 32
+#define MONTBLANC_BMC_RAM_SIZE (1 * GiB)
+#else
+#define MONTBLANC_BMC_RAM_SIZE (2 * GiB)
+#endif
+static void aspeed_machine_montblanc_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc =3D "Facebook Montblanc BMC (Cortex-A7)";
+    amc->soc_name =3D "ast2600-a3";
+    amc->hw_strap1 =3D MONTBLANC_BMC_HW_STRAP1;
+    amc->hw_strap2 =3D MONTBLANC_BMC_HW_STRAP2;
+    amc->fmc_model =3D "mx66l1g45g";
+    amc->spi_model =3D "mx66l1g45g";
+    amc->num_cs =3D 2;
+    amc->macs_mask =3D ASPEED_MAC3_ON;
+    amc->i2c_init =3D montblanc_bmc_i2c_init;
+    amc->uart_default =3D ASPEED_DEV_UART1;
+    mc->default_ram_size =3D MONTBLANC_BMC_RAM_SIZE;
+    mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D
+        aspeed_soc_num_cpus(amc->soc_name);
+};
+
 /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
 #if HOST_LONG_BITS =3D=3D 32
 #define BLETCHLEY_BMC_RAM_SIZE (1 * GiB)
@@ -1706,6 +1769,10 @@ static const TypeInfo aspeed_machine_types[] =3D {
         .name          =3D MACHINE_TYPE_NAME("fuji-bmc"),
         .parent        =3D TYPE_ASPEED_MACHINE,
         .class_init    =3D aspeed_machine_fuji_class_init,
+    }, {
+        .name          =3D MACHINE_TYPE_NAME("montblanc-bmc"),
+        .parent        =3D TYPE_ASPEED_MACHINE,
+        .class_init    =3D aspeed_machine_montblanc_class_init,
     }, {
         .name          =3D MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        =3D TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
index ace5266cec..bcde346e9b 100644
--- a/hw/arm/aspeed_eeprom.c
+++ b/hw/arm/aspeed_eeprom.c
@@ -161,6 +161,53 @@ const uint8_t rainier_bmc_fruid[] =3D {
     0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
=20
+/* Montblanc BMC FRU */
+const uint8_t montblanc_scm_fruid[8192] =3D {
+    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,
+    0x43, 0x4b, 0x33, 0x5f, 0x53, 0x43, 0x4d, 0x02, 0x08, 0x32, 0x30, 0x30,
+    0x30, 0x32, 0x39, 0x34, 0x35, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30, 0x30,
+    0x30, 0x31, 0x36, 0x34, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33, 0x31,
+    0x30, 0x30, 0x30, 0x31, 0x32, 0x37, 0x30, 0x31, 0x20, 0x06, 0x0c, 0x52,
+    0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x30, 0x33, 0x30, 0x31, 0x07,
+    0x0d, 0x41, 0x30, 0x33, 0x31, 0x33, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,
+    0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00, 0x0b,
+    0x0d, 0x4d, 0x32, 0x32, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30, 0x30,
+    0x30, 0x32, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32,
+    0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03,
+    0x43, 0x54, 0x48, 0x10, 0x06, 0xb4, 0xbd, 0x00, 0x00, 0x00, 0x01, 0x13,
+    0x03, 0x53, 0x43, 0x4d, 0xfa, 0x02, 0x11, 0x07,
+};
+
+const uint8_t montblanc_fcm_fruid[8192] =3D {
+    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,
+    0x43, 0x4b, 0x33, 0x5f, 0x46, 0x43, 0x42, 0x02, 0x08, 0x33, 0x30, 0x30,
+    0x30, 0x30, 0x31, 0x36, 0x31, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30, 0x30,
+    0x30, 0x31, 0x36, 0x33, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33, 0x31,
+    0x30, 0x30, 0x30, 0x31, 0x33, 0x30, 0x30, 0x31, 0x20, 0x06, 0x0c, 0x52,
+    0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x31, 0x32, 0x30, 0x31, 0x07,
+    0x0d, 0x41, 0x31, 0x32, 0x31, 0x32, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,
+    0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00, 0x0b,
+    0x0d, 0x46, 0x35, 0x30, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30, 0x30,
+    0x30, 0x35, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32,
+    0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03,
+    0x43, 0x54, 0x48, 0x10, 0x06, 0xb4, 0xbd, 0x00, 0x00, 0x00, 0x02, 0x11,
+    0x06, 0xb4, 0xbd, 0x00, 0x00, 0x00, 0x03, 0x12, 0x02, 0x8a, 0x00, 0x13,
+    0x03, 0x46, 0x43, 0x42, 0xfa, 0x02, 0x0e, 0x61,
+};
+
+const uint8_t montblanc_bmc_fruid[8192] =3D {
+    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,
+    0x43, 0x4b, 0x33, 0x5f, 0x42, 0x4d, 0x43, 0x04, 0x0c, 0x31, 0x33, 0x32,
+    0x30, 0x30, 0x30, 0x31, 0x33, 0x36, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31,
+    0x33, 0x31, 0x30, 0x30, 0x30, 0x30, 0x38, 0x36, 0x30, 0x35, 0x20, 0x06,
+    0x0c, 0x52, 0x33, 0x30, 0x39, 0x37, 0x47, 0x30, 0x30, 0x30, 0x32, 0x30,
+    0x37, 0x07, 0x0d, 0x42, 0x30, 0x32, 0x37, 0x34, 0x58, 0x58, 0x58, 0x58,
+    0x58, 0x58, 0x58, 0x58, 0x08, 0x01, 0x04, 0x09, 0x01, 0x00, 0x0a, 0x01,
+    0x00, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32, 0x33,
+    0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03, 0x43,
+    0x54, 0x48, 0x13, 0x03, 0x42, 0x4d, 0x43, 0xfa, 0x02, 0xef, 0xba,
+};
+
 const size_t tiogapass_bmc_fruid_len =3D sizeof(tiogapass_bmc_fruid);
 const size_t fby35_nic_fruid_len =3D sizeof(fby35_nic_fruid);
 const size_t fby35_bb_fruid_len =3D sizeof(fby35_bb_fruid);
@@ -168,3 +215,6 @@ const size_t fby35_bmc_fruid_len =3D sizeof(fby35_bmc_fru=
id);
 const size_t yosemitev2_bmc_fruid_len =3D sizeof(yosemitev2_bmc_fruid);
 const size_t rainier_bb_fruid_len =3D sizeof(rainier_bb_fruid);
 const size_t rainier_bmc_fruid_len =3D sizeof(rainier_bmc_fruid);
+const size_t montblanc_scm_fruid_len =3D sizeof(montblanc_scm_fruid);
+const size_t montblanc_fcm_fruid_len =3D sizeof(montblanc_fcm_fruid);
+const size_t montblanc_bmc_fruid_len =3D sizeof(montblanc_bmc_fruid);
diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
index bbf9e54365..b8fbdd0734 100644
--- a/hw/arm/aspeed_eeprom.h
+++ b/hw/arm/aspeed_eeprom.h
@@ -27,4 +27,11 @@ extern const size_t rainier_bb_fruid_len;
 extern const uint8_t rainier_bmc_fruid[];
 extern const size_t rainier_bmc_fruid_len;
=20
+extern const uint8_t montblanc_scm_fruid[];
+extern const uint8_t montblanc_fcm_fruid[];
+extern const uint8_t montblanc_bmc_fruid[];
+extern const size_t montblanc_scm_fruid_len;
+extern const size_t montblanc_fcm_fruid_len;
+extern const size_t montblanc_bmc_fruid_len;
+
 #endif
--=20
2.38.5

