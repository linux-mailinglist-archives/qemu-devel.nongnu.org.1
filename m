Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E917F36AA
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 20:12:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5W8n-0008Ft-NK; Tue, 21 Nov 2023 14:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5W8c-0008Ca-IU; Tue, 21 Nov 2023 14:10:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5W8X-00042W-I6; Tue, 21 Nov 2023 14:10:19 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALJ7NZT027911; Tue, 21 Nov 2023 19:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BgjDTCoIx+y9Zc2qMSrwigZ2m9wFUK438n4TkTz6H+g=;
 b=gwMOakGOCb6fuQHnDDlzzPSKD4E8zEMLT/imZbM9EyuSFtcw+uwR1iYQxcteCBv/f+G9
 OT96+VRfwkTVuXCPnewo2zXiT/b91Kn1lAXP5RhgQoMvfYjRS9fwEPW8Xqn349jeA8Hh
 I29riONWcH48RZxIjlQzLuX5FUeLkB8+D/OsT1JeXjtYD8jlDtn5vNJ4Oa1nrXldbIs6
 7FoIq6XDKEaiMLzWM0lSViuKsqtZxHNJmF6LRRv8+ce3/+lQydhpWQzOBLYLeO+ULTN3
 8X2yIbKYIl3XaR1dY9P/lN1PyMlNekWNGGeBHojf/A1nuMRYlGTxEyL2yNt8B/hG6ZS6 ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh11wagvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:03 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALJ7lgZ031110;
 Tue, 21 Nov 2023 19:10:03 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh11wagv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:03 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALIYKFU007848; Tue, 21 Nov 2023 19:10:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa22bpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:02 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ALJA1jG9503366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 19:10:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EFE958060;
 Tue, 21 Nov 2023 19:10:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18BB958062;
 Tue, 21 Nov 2023 19:10:01 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Nov 2023 19:10:01 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH v5 1/9] misc/pca9552: Fix inverted input status
Date: Tue, 21 Nov 2023 13:09:37 -0600
Message-Id: <20231121190945.3140221-2-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
References: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RgjyTqk3kPiindu1oWZWNCL4cyuB7ltP
X-Proofpoint-ORIG-GUID: 0-FuQ9kOY2zlGqfnC5G-QCe4VOBr9uU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210150
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

The pca9552 INPUT0 and INPUT1 registers are supposed to
hold the logical values of the LED pins.  A logical 0
should be seen in the INPUT0/1 registers for a pin when
its corresponding LSn bits are set to 0, which is also
the state needed for turning on an LED in a typical
usage scenario.  Existing code was doing the opposite
and setting INPUT0/1 bit to a 1 when the LSn bit was
set to 0, so this commit fixes that.

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

No change from previous version

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


