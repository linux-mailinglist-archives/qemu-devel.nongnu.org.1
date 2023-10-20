Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7F37D15C5
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 20:25:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtuAd-0004Gh-48; Fri, 20 Oct 2023 14:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qtuAX-0004GN-NH; Fri, 20 Oct 2023 14:24:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qtuAW-00065V-3i; Fri, 20 Oct 2023 14:24:21 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KIHTKl027762; Fri, 20 Oct 2023 18:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=J6oiCSwau7ycdF0spBfg6zNZwcb4KN69nYRNej9Q+ZY=;
 b=queMuNnzCoUArtHNzNYpmcfVlpPNIxf9kHYMgUfWYThzaWo3kapagnC7IKoxA9nHK8OC
 ZQ1TZLOld6VwU+Iox9pN53Iowh6uQtAPEzQnG3BvekrGGQ/LiEwcvupB25i8T/b+2HQV
 QGx+0AhR25RvcB7iq3thCtlprxLDfrTSWkepBX22h7ZqAaPOikc7AAH7PNHrDFt+wkfn
 687D7B1F745YgrBzcLxKSRePgxKgo9NJjyhHAPJR8yhGCVcgyN24g9xAwaZw7ShNT6U6
 KbxiGcRfEkRpQkHv+bYXQxXrlhObLzD+Pu+Zos8W72u1mhAbq4z/oBfkYFW0BD+hKfIZ lg== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuxpt872v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 18:24:10 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KHbqSG019366; Fri, 20 Oct 2023 18:24:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc456e0k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 18:24:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39KIO9cp20185676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 18:24:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7F0F5805E;
 Fri, 20 Oct 2023 18:24:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 735DF58045;
 Fri, 20 Oct 2023 18:24:08 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Oct 2023 18:24:08 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 andrew@codeconstruct.com.au, Joel Stanley <joel@jms.id.au>,
 philmd@linaro.org
Subject: [PATCH v2 3/3] misc/pca9552: Only update output GPIOs if state changed
Date: Fri, 20 Oct 2023 13:23:21 -0500
Message-Id: <20231020182321.163109-4-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231020182321.163109-1-milesg@linux.vnet.ibm.com>
References: <20231020182321.163109-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gxaYhdz3A_leAeMhP6GArqrCL-ES37KT
X-Proofpoint-ORIG-GUID: gxaYhdz3A_leAeMhP6GArqrCL-ES37KT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200154
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

The pca9552 code was updating output GPIO states whenever
the pin state was updated even if the state did not change.
This commit adds a check so that we only update the GPIO
output when the pin state actually changes.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

New commit in v2

 hw/misc/pca9552.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index ed814d1f98..4ed6903404 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -112,14 +112,15 @@ static void pca955x_update_pin_input(PCA955xState *s)
 
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
-            qemu_set_irq(s->gpio_out[i], 0);
-            s->regs[input_reg] &= ~(1 << input_shift);
+            s->regs[input_reg] &= ~bit_mask;
             break;
         case PCA9552_LED_OFF:
             /*
@@ -128,11 +129,9 @@ static void pca955x_update_pin_input(PCA955xState *s)
              * external device drives it low.
              */
             if (s->ext_state[i] == PCA9552_PIN_LOW) {
-                qemu_set_irq(s->gpio_out[i], 0);
-                s->regs[input_reg] &= ~(1 << input_shift);
+                s->regs[input_reg] &= ~bit_mask;
             } else {
-                qemu_set_irq(s->gpio_out[i], 1);
-                s->regs[input_reg] |= 1 << input_shift;
+                s->regs[input_reg] |=  bit_mask;
             }
             break;
         case PCA9552_LED_PWM0:
@@ -141,6 +140,18 @@ static void pca955x_update_pin_input(PCA955xState *s)
         default:
             break;
         }
+
+        /* update irq state only if pin state changed */
+        new_value = s->regs[input_reg] & bit_mask;
+        if (new_value != old_value) {
+            if (new_value) {
+                /* changed from 0 to 1 */
+                qemu_set_irq(s->gpio_out[i], 1);
+            } else {
+                /* changed from 1 to 0 */
+                qemu_set_irq(s->gpio_out[i], 0);
+            }
+        }
     }
 }
 
-- 
2.31.1


