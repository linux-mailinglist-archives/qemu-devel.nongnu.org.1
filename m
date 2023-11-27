Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6EC7FA8C6
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 19:18:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7gBJ-0001Zp-2D; Mon, 27 Nov 2023 13:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r7gBF-0001Yj-Kp; Mon, 27 Nov 2023 13:18:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r7gBD-000196-Up; Mon, 27 Nov 2023 13:18:01 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARIEGGx026620; Mon, 27 Nov 2023 18:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NKRYJONPAudISIxtAkocTvv6CRyILtTAJ9DEqUHH4Vk=;
 b=rCnYl6QMJpDhdRT7Y2rwZAdLx0x84HsN3blQuPVLr+x4m24/Jxf3tFFe98GKZyJl3fb6
 iK4bx/UCAEyaqOiWdBibOgerrFvInoeZBao6FcgWWwbYgoQGHJDV4sgNAtU6x+cRODR5
 uHdqfXCNaycCSoCzdhyrgqnveZIJfgDr3PYlVbeHhwNDEu/aQxtzgLL8owA+wyHCe5Pb
 phd78UZyliJ9UFHcoZ4k2/G5rQUGcAHI99A4vVyf6Hca3KrY4vxkPff1ibQlRVd4trOy
 8iKp3dnetOvXRKCMhCfWqIUtJBskqMbofbYl/UESIM4SEqQ4Q4GA0xnMbI/L+ptIXKFl uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un074r37m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:53 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARIFEGd029421;
 Mon, 27 Nov 2023 18:17:51 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un074r2xq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:51 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARGqWWO001733; Mon, 27 Nov 2023 18:17:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1j0gp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:23 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ARIHLER23593646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 18:17:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9366258058;
 Mon, 27 Nov 2023 18:17:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6297958057;
 Mon, 27 Nov 2023 18:17:21 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 18:17:21 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH v6 2/9] misc/pca9552: Let external devices set pca9552 inputs
Date: Mon, 27 Nov 2023 12:16:48 -0600
Message-Id: <20231127181655.1997496-3-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231127181655.1997496-1-milesg@linux.vnet.ibm.com>
References: <20231127181655.1997496-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NSc2qzYL9prgVQ_bDIyC5RWbHAsFRfXV
X-Proofpoint-ORIG-GUID: skJzE9_ymemtTxLl6C5AU8OaaMDAJYTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270126
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Allow external devices to drive pca9552 input pins by adding
input GPIO's to the model.  This allows a device to connect
its output GPIO's to the pca9552 input GPIO's.

In order for an external device to set the state of a pca9552
pin, the pin must first be configured for high impedance (LED
is off).  If the pca9552 pin is configured to drive the pin low
(LED is on), then external input will be ignored.

Here is a table describing the logical state of a pca9552 pin
given the state being driven by the pca9552 and an external device:

                   PCA9552
                   Configured
                   State

                  | Hi-Z | Low |
            ------+------+-----+
  External   Hi-Z |  Hi  | Low |
  Device    ------+------+-----+
  State      Low  |  Low | Low |
            ------+------+-----+

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

No change from previous version

 hw/misc/pca9552.c         | 50 +++++++++++++++++++++++++++++++++------
 include/hw/misc/pca9552.h |  3 ++-
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 445f56a9e8..fe876471c8 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -44,6 +44,8 @@ DECLARE_CLASS_CHECKERS(PCA955xClass, PCA955X,
 #define PCA9552_LED_OFF  0x1
 #define PCA9552_LED_PWM0 0x2
 #define PCA9552_LED_PWM1 0x3
+#define PCA9552_PIN_LOW  0x0
+#define PCA9552_PIN_HIZ  0x1
 
 static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
 
@@ -110,22 +112,27 @@ static void pca955x_update_pin_input(PCA955xState *s)
 
     for (i = 0; i < k->pin_count; i++) {
         uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
-        uint8_t input_shift = (i % 8);
+        uint8_t bit_mask = 1 << (i % 8);
         uint8_t config = pca955x_pin_get_config(s, i);
+        uint8_t old_value = s->regs[input_reg] & bit_mask;
+        uint8_t new_value;
 
         switch (config) {
         case PCA9552_LED_ON:
             /* Pin is set to 0V to turn on LED */
-            qemu_set_irq(s->gpio[i], 0);
-            s->regs[input_reg] &= ~(1 << input_shift);
+            s->regs[input_reg] &= ~bit_mask;
             break;
         case PCA9552_LED_OFF:
             /*
              * Pin is set to Hi-Z to turn off LED and
-             * pullup sets it to a logical 1.
+             * pullup sets it to a logical 1 unless
+             * external device drives it low.
              */
-            qemu_set_irq(s->gpio[i], 1);
-            s->regs[input_reg] |= 1 << input_shift;
+            if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                s->regs[input_reg] &= ~bit_mask;
+            } else {
+                s->regs[input_reg] |=  bit_mask;
+            }
             break;
         case PCA9552_LED_PWM0:
         case PCA9552_LED_PWM1:
@@ -133,6 +140,12 @@ static void pca955x_update_pin_input(PCA955xState *s)
         default:
             break;
         }
+
+        /* update irq state only if pin state changed */
+        new_value = s->regs[input_reg] & bit_mask;
+        if (new_value != old_value) {
+            qemu_set_irq(s->gpio_out[i], !!new_value);
+        }
     }
 }
 
@@ -340,6 +353,7 @@ static const VMStateDescription pca9552_vmstate = {
         VMSTATE_UINT8(len, PCA955xState),
         VMSTATE_UINT8(pointer, PCA955xState),
         VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
+        VMSTATE_UINT8_ARRAY(ext_state, PCA955xState, PCA955X_PIN_COUNT_MAX),
         VMSTATE_I2C_SLAVE(i2c, PCA955xState),
         VMSTATE_END_OF_LIST()
     }
@@ -358,6 +372,7 @@ static void pca9552_reset(DeviceState *dev)
     s->regs[PCA9552_LS2] = 0x55;
     s->regs[PCA9552_LS3] = 0x55;
 
+    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
     pca955x_update_pin_input(s);
 
     s->pointer = 0xFF;
@@ -380,6 +395,26 @@ static void pca955x_initfn(Object *obj)
     }
 }
 
+static void pca955x_set_ext_state(PCA955xState *s, int pin, int level)
+{
+    if (s->ext_state[pin] != level) {
+        uint16_t pins_status = pca955x_pins_get_status(s);
+        s->ext_state[pin] = level;
+        pca955x_update_pin_input(s);
+        pca955x_display_pins_status(s, pins_status);
+    }
+}
+
+static void pca955x_gpio_in_handler(void *opaque, int pin, int level)
+{
+
+    PCA955xState *s = PCA955X(opaque);
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
+
+    assert((pin >= 0) && (pin < k->pin_count));
+    pca955x_set_ext_state(s, pin, level);
+}
+
 static void pca955x_realize(DeviceState *dev, Error **errp)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(dev);
@@ -389,7 +424,8 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
         s->description = g_strdup("pca-unspecified");
     }
 
-    qdev_init_gpio_out(dev, s->gpio, k->pin_count);
+    qdev_init_gpio_out(dev, s->gpio_out, k->pin_count);
+    qdev_init_gpio_in(dev, pca955x_gpio_in_handler, k->pin_count);
 }
 
 static Property pca955x_properties[] = {
diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index b6f4e264fe..c36525f0c3 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -30,7 +30,8 @@ struct PCA955xState {
     uint8_t pointer;
 
     uint8_t regs[PCA955X_NR_REGS];
-    qemu_irq gpio[PCA955X_PIN_COUNT_MAX];
+    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];
+    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];
     char *description; /* For debugging purpose only */
 };
 
-- 
2.31.1


