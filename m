Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 909CA7D15C6
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 20:25:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtuB7-0004Pz-QN; Fri, 20 Oct 2023 14:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qtuB5-0004Pe-E9; Fri, 20 Oct 2023 14:24:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qtuB3-000691-Lf; Fri, 20 Oct 2023 14:24:55 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KIDMOr021767; Fri, 20 Oct 2023 18:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mTWjiUq/3nFxASwmw+0se+dhFx5KYF10w2leeH6ip1w=;
 b=Wj8HhbFmatlJRfjcdPWoINP5MYg7i01WoTgrcI0IV7LkOGkf0MKZncwzeOkxDlY4OzrO
 CAs/fo51eaWieLCdHDNPu5Vyzk5yDGuSa4IMk1LGob7ocKrnwn5s/Jnce3fLcShL2MYH
 s+UzvVI/+86Mivaf+INUPKgJvK6Y7k832IAgNLhMWI9dE5hgWb7gKsjCA//OqTOINUlQ
 0JYU3KIYCvtfI6yyfGPoVOl7ppdqHXd4xPUwCgyR8xhhd18EPVB63swldxP5RXKWNllI
 sWG4YAazsvoBDq6iBpjeY80sBW2gHrNcrF1Ka44qd5+dEco7f10YyHeS9lrd9OJdfnQ5 dA== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tux9hguqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 18:24:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KHT064024169; Fri, 20 Oct 2023 18:24:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc296ean-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 18:24:01 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39KIO18L20841060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 18:24:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EA3658052;
 Fri, 20 Oct 2023 18:24:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EBE958045;
 Fri, 20 Oct 2023 18:24:00 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Oct 2023 18:24:00 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 andrew@codeconstruct.com.au, Joel Stanley <joel@jms.id.au>,
 philmd@linaro.org
Subject: [PATCH v2 1/3] misc/pca9552: Fix inverted input status
Date: Fri, 20 Oct 2023 13:23:19 -0500
Message-Id: <20231020182321.163109-2-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231020182321.163109-1-milesg@linux.vnet.ibm.com>
References: <20231020182321.163109-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x_dZLbBVYEJS_nk_N36zvRn2ARLvICpd
X-Proofpoint-ORIG-GUID: x_dZLbBVYEJS_nk_N36zvRn2ARLvICpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310200154
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

The pca9552 INPUT0 and INPUT1 registers are supposed to
hold the logical values of the LED pins.  A logical 0
should be seen in the INPUT0/1 registers for a pin when
its corresponding LSn bits are set to 0, which is also
the state needed for turning on an LED in a typical
usage scenario.  Existing code was doing the opposite
and setting INPUT0/1 bit to a 1 when the LSn bit was
set to 0, so this commit fixes that.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

No change from v1

 hw/misc/pca9552.c          | 18 +++++++++++++-----
 tests/qtest/pca9552-test.c |  6 +++---
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index fff19e369a..445f56a9e8 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -36,7 +36,10 @@ typedef struct PCA955xClass PCA955xClass;
 
 DECLARE_CLASS_CHECKERS(PCA955xClass, PCA955X,
                        TYPE_PCA955X)
-
+/*
+ * Note:  The LED_ON and LED_OFF configuration values for the PCA955X
+ *        chips are the reverse of the PCA953X family of chips.
+ */
 #define PCA9552_LED_ON   0x0
 #define PCA9552_LED_OFF  0x1
 #define PCA9552_LED_PWM0 0x2
@@ -112,13 +115,18 @@ static void pca955x_update_pin_input(PCA955xState *s)
 
         switch (config) {
         case PCA9552_LED_ON:
-            qemu_set_irq(s->gpio[i], 1);
-            s->regs[input_reg] |= 1 << input_shift;
-            break;
-        case PCA9552_LED_OFF:
+            /* Pin is set to 0V to turn on LED */
             qemu_set_irq(s->gpio[i], 0);
             s->regs[input_reg] &= ~(1 << input_shift);
             break;
+        case PCA9552_LED_OFF:
+            /*
+             * Pin is set to Hi-Z to turn off LED and
+             * pullup sets it to a logical 1.
+             */
+            qemu_set_irq(s->gpio[i], 1);
+            s->regs[input_reg] |= 1 << input_shift;
+            break;
         case PCA9552_LED_PWM0:
         case PCA9552_LED_PWM1:
             /* TODO */
diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
index d80ed93cd3..ccca2b3d91 100644
--- a/tests/qtest/pca9552-test.c
+++ b/tests/qtest/pca9552-test.c
@@ -60,7 +60,7 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(value, ==, 0x55);
 
     value = i2c_get8(i2cdev, PCA9552_INPUT0);
-    g_assert_cmphex(value, ==, 0x0);
+    g_assert_cmphex(value, ==, 0xFF);
 
     pca9552_init(i2cdev);
 
@@ -68,13 +68,13 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(value, ==, 0x54);
 
     value = i2c_get8(i2cdev, PCA9552_INPUT0);
-    g_assert_cmphex(value, ==, 0x01);
+    g_assert_cmphex(value, ==, 0xFE);
 
     value = i2c_get8(i2cdev, PCA9552_LS3);
     g_assert_cmphex(value, ==, 0x54);
 
     value = i2c_get8(i2cdev, PCA9552_INPUT1);
-    g_assert_cmphex(value, ==, 0x10);
+    g_assert_cmphex(value, ==, 0xEF);
 }
 
 static void pca9552_register_nodes(void)
-- 
2.31.1


