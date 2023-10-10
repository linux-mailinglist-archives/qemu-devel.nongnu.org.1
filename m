Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D22167C4066
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 21:53:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqImo-0005Cd-8C; Tue, 10 Oct 2023 15:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qqIml-0005Bv-Q5; Tue, 10 Oct 2023 15:52:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qqImk-00046G-0o; Tue, 10 Oct 2023 15:52:55 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39AJo8RM025247; Tue, 10 Oct 2023 19:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Gknwb3v7ZSal6XeHXKAJUHKxL4uVIJm7A2aR+70E0cU=;
 b=Zgc586Aut+HhmdiMQjBhFInFL+YweNFgKncZJND5DLS+ryGr32mYSnCLNowncv1tWZhg
 YnvEQUJe5ojQu6slP1KwjGelmJDbe+JHAtrNY5gGjFnifYWGu6Ohy7jmHKZhPP91epN+
 QUx1OY2jtW/SUdeHokGMEvF2QT7TRK2b7K8J3ZgEVZ6hI/K/k1N4svEZv62pMiSGCeWj
 PMxqO80UHKn0WBI080O97P1MFoKT4kQinIUA7WnsXiCw9HoHwnkLlRnKAPZI0ezcyqy9
 Mt2dNlfu286nQR2NLdrzYHf6busqIStu7d/a9JeVjkEz2K7YNfT8CVNas5SaRz+Sm/Hm Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnd45g2ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 19:52:20 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39AJp715027870;
 Tue, 10 Oct 2023 19:52:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnd45g29x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 19:52:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39AJ8tL1028188; Tue, 10 Oct 2023 19:52:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1y2uqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 19:52:19 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39AJqJlI36897086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Oct 2023 19:52:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21ED35804E;
 Tue, 10 Oct 2023 19:52:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09A185803F;
 Tue, 10 Oct 2023 19:52:19 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Oct 2023 19:52:18 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id 3872A16A07CE;
 Tue, 10 Oct 2023 14:52:18 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 39AJqHPr264806;
 Tue, 10 Oct 2023 14:52:17 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-arm@nongnu.org, clg@kaod.org,
 clegoate@redhat.com, andrew@codeconstruct.com.au, joel@jms.id.au
Subject: [PATCH v3] misc/pca9552: Fix for pca9552 not getting reset
Date: Tue, 10 Oct 2023 14:52:09 -0500
Message-Id: <20231010195209.264757-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ybTqAcxyE_H8TJ4m5i6rLLftxnuW_L7b
X-Proofpoint-GUID: kuspBBMIxnBfxXHTgSUkIImSMaZKQ6YD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100153
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
 hw/misc/pca9552.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index fff19e369a..4e183cc554 100644
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
@@ -417,6 +423,7 @@ static void pca9552_class_init(ObjectClass *oc, void *data)
     PCA955xClass *pc = PCA955X_CLASS(oc);
 
     dc->reset = pca9552_reset;
+    dc->realize = pca9552_realize;
     dc->vmsd = &pca9552_vmstate;
     pc->max_reg = PCA9552_LS3;
     pc->pin_count = 16;
-- 
2.31.1


