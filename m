Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC47B0F2B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 00:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qldT1-00066I-C2; Wed, 27 Sep 2023 18:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qldSz-000664-LR; Wed, 27 Sep 2023 18:57:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qldSx-0000UE-Cv; Wed, 27 Sep 2023 18:57:13 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38RMclHj027105; Wed, 27 Sep 2023 22:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=c8Fm3zH1YumvTrWZa0590rElzy675nYfMpcOfRUdZFo=;
 b=QKEhxGhP9ria183ZPaIQg+NuDN5cfr/YoM8QQShPlj3nmQuMeCGGXQLUJfD066ZI67fP
 P7ZGW44+4jTXvbHAHMoi/2xNhm2+fwdQ7cfBdDBWO8CBmVK17eyyafMp140L4G29K8GX
 F7G7ZXiJ06Z9css6gtxiFHnILxwU+6QmXq0vsilBv7PdAuxL9COsV268PulXmXBZv4cZ
 S4v0rHnU4R9LgvPLvITtF82TheIXw0LTkYhvcpKwJeuVOET8y4tM89vsIe+utRA69/+v
 07D4PiE9v6um3JsRqPIP9kZRnZTtZ6IVK/otqnqFpGCicYXCnoApN8X0jFkv5yOL8AqS sw== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcuvbk00a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 22:56:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38RLV9lB030706; Wed, 27 Sep 2023 22:56:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjk701a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 22:56:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38RMuhAY66715970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Sep 2023 22:56:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 469F658053;
 Wed, 27 Sep 2023 22:56:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EBEF58043;
 Wed, 27 Sep 2023 22:56:43 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 27 Sep 2023 22:56:43 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id 5A7CA16A05FF;
 Wed, 27 Sep 2023 17:56:42 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38RMufuP3510061;
 Wed, 27 Sep 2023 17:56:41 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 andrew@codeconstruct.com.au, Joel Stanley <joel@jms.id.au>
Subject: [PATCH] misc/pca9552: Let external devices set pca9552 inputs
Date: Wed, 27 Sep 2023 17:56:23 -0500
Message-Id: <20230927225623.3510012-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9c0T1Lp-21aY1HaNnoRbH26eWQ_lBYWM
X-Proofpoint-ORIG-GUID: 9c0T1Lp-21aY1HaNnoRbH26eWQ_lBYWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_15,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270194
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
Based-on: <20230927203221.3286895-1-milesg@linux.vnet.ibm.com>
([PATCH] misc/pca9552: Fix inverted input status)
 hw/misc/pca9552.c         | 39 ++++++++++++++++++++++++++++++++++-----
 include/hw/misc/pca9552.h |  3 ++-
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index ad811fb249..901b5900d2 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -113,16 +113,22 @@ static void pca955x_update_pin_input(PCA955xState *s)
         switch (config) {
         case PCA9552_LED_ON:
             /* Pin is set to 0V to turn on LED */
-            qemu_set_irq(s->gpio[i], 0);
+            qemu_set_irq(s->gpio_out[i], 0);
             s->regs[input_reg] &= ~(1 << input_shift);
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
+            if (s->ext_state[i] == 0) {
+                qemu_set_irq(s->gpio_out[i], 0);
+                s->regs[input_reg] &= ~(1 << input_shift);
+            } else {
+                qemu_set_irq(s->gpio_out[i], 1);
+                s->regs[input_reg] |= 1 << input_shift;
+            }
             break;
         case PCA9552_LED_PWM0:
         case PCA9552_LED_PWM1:
@@ -337,6 +343,7 @@ static const VMStateDescription pca9552_vmstate = {
         VMSTATE_UINT8(len, PCA955xState),
         VMSTATE_UINT8(pointer, PCA955xState),
         VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
+        VMSTATE_UINT8_ARRAY(ext_state, PCA955xState, PCA955X_PIN_COUNT_MAX),
         VMSTATE_I2C_SLAVE(i2c, PCA955xState),
         VMSTATE_END_OF_LIST()
     }
@@ -355,6 +362,7 @@ static void pca9552_reset(DeviceState *dev)
     s->regs[PCA9552_LS2] = 0x55;
     s->regs[PCA9552_LS3] = 0x55;
 
+    memset(s->ext_state, 1, PCA955X_PIN_COUNT_MAX);
     pca955x_update_pin_input(s);
 
     s->pointer = 0xFF;
@@ -377,6 +385,26 @@ static void pca955x_initfn(Object *obj)
     }
 }
 
+static void pca955x_set_ext_state(PCA955xState *s, int pin, int level)
+{
+    s->ext_state[pin] = level;
+}
+
+static void pca955x_gpio_in_handler(void *opaque, int pin, int level)
+{
+    uint16_t pins_status;
+
+    PCA955xState *s = PCA955X(opaque);
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
+
+    assert((pin >= 0) && (pin < k->pin_count));
+
+    pins_status = pca955x_pins_get_status(s);
+    pca955x_set_ext_state(s, pin, level);
+    pca955x_update_pin_input(s);
+    pca955x_display_pins_status(s, pins_status);
+}
+
 static void pca955x_realize(DeviceState *dev, Error **errp)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(dev);
@@ -386,7 +414,8 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
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


