Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFA97BABD8
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 23:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoVdI-0004Zr-At; Thu, 05 Oct 2023 17:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qoVdF-0004YE-69; Thu, 05 Oct 2023 17:11:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qoVdC-0005hy-26; Thu, 05 Oct 2023 17:11:40 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395KKZr1017939; Thu, 5 Oct 2023 21:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lwu3eN0Rpykt3SD/z0yvog3s4BNg5OcSN1ci1NjJI20=;
 b=shFhpRKOQDvVH/tt1NrLrhZfUnx9xSqGN98Uogdj4tTSltIWiX9SvyJVjLskVHUs9Gi/
 2l6wIjMTXx5uj8mdY2BXD9Yi6WRi1hnhKRgw8HQ2ZYlkTk2aX519zbdg0xpJnjP02cgz
 cO42ZgC2zEamwFt/I3Zdjrr2bIsasREqZbqac0X46DbJ7vrInOmz7XMJHyHYFinurDBC
 Opvm2WlMqGj7MDhDpK/6UYhAUBkAiRpp5KT/klIQommhIOWrsbbkSgDFvBJSkFRujHWz
 jV55oljSmP5I46Uohawod9uXcOjZIo/JIluZD82lzbRVsCuaW4H/d2bgGRk464uP8QA2 ZA== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj43d1g3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 21:11:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 395KugRW025087; Thu, 5 Oct 2023 21:11:06 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texd0496p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 21:11:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 395LB5Oo63570340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Oct 2023 21:11:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 805BA58059;
 Thu,  5 Oct 2023 21:11:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72FE258061;
 Thu,  5 Oct 2023 21:11:05 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  5 Oct 2023 21:11:05 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id A1B0616A0848;
 Thu,  5 Oct 2023 16:11:04 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 395LB37Q3609625;
 Thu, 5 Oct 2023 16:11:03 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 andrew@codeconstruct.com.au, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2] misc/pca9552: Fix for pca9552 not getting reset
Date: Thu,  5 Oct 2023 16:10:46 -0500
Message-Id: <20231005211046.3609577-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kmHr3jzMgs6_0LPyleF9upy2lHInkDzB
X-Proofpoint-ORIG-GUID: kmHr3jzMgs6_0LPyleF9upy2lHInkDzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_15,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050160
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Testing of the pca9552 device on the powernv platform
showed that the reset method was not being called when
an instance of the device was realized.  This was causing
the INPUT0/INPUT1 POR values to be incorrect.

Fixed by overriding the parent pca955x_realize method with a
new pca9552_realize method which first calls
the parent pca955x_realize method followed by the
pca9552_reset function.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 hw/misc/pca9552.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index fff19e369a..bc12dced7f 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -384,6 +384,12 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, s->gpio, k->pin_count);
 }
 
+static void pca9552_realize(DeviceState *dev, Error **errp)
+{
+    pca955x_realize(dev, errp);
+    pca9552_reset(dev);
+}
+
 static Property pca955x_properties[] = {
     DEFINE_PROP_STRING("description", PCA955xState, description),
     DEFINE_PROP_END_OF_LIST(),
@@ -416,7 +422,7 @@ static void pca9552_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCA955xClass *pc = PCA955X_CLASS(oc);
 
-    dc->reset = pca9552_reset;
+    dc->realize = pca9552_realize;
     dc->vmsd = &pca9552_vmstate;
     pc->max_reg = PCA9552_LS3;
     pc->pin_count = 16;
-- 
2.31.1


