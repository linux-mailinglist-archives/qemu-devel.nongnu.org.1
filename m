Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F9743DC7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFFL7-0006Rg-2b; Fri, 30 Jun 2023 10:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qFFKw-0006QU-Ag; Fri, 30 Jun 2023 10:43:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qFFKt-0005dU-FX; Fri, 30 Jun 2023 10:43:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UEgWXV006365; Fri, 30 Jun 2023 14:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YXq1qz66iASMQmFThwKFdnHngHQMBOeRRZ/vH0iv3ss=;
 b=gm1iGw1gmPPDt5/PnYoyktTkxCdVez41qxNS+1T9HHyhsWCocwrcfSdmmSG5wKoi0u28
 85zMu2ezPYLnB8xqfMIp/3OBoDAT1g+WqGbYBvXGZYy2bh9hdv9nNkqv8h57JIwWeoCo
 rkOtfhKnh0euNbYIA7kbze2HIe9/VmX3tvbPxJQdqcRhhij1sJoHDG+PKUCHntFDDNgs
 DHEQNvi6+np0WKzk3/9IZ3959K9D1Jvi0vbDrskzYg1Fmvt59J58i8bHf+1lNYCG9EC2
 Up/E9YQUrz0JRi2q+F6krkQadTfVe3qKfwwvnC6qC9CBwfjZl4vWwQGIMdYpCVV7Vf3X Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj11y80ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 14:42:50 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UEgnMF007496;
 Fri, 30 Jun 2023 14:42:49 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj11y809r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 14:42:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2qePf027568;
 Fri, 30 Jun 2023 14:42:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr4546gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 14:42:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UEgi7016450170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 14:42:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C63812004F;
 Fri, 30 Jun 2023 14:42:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F4AF20040;
 Fri, 30 Jun 2023 14:42:44 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.74.60])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 14:42:44 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] pnv/psi: Initialize the PSIHB interrupts to match hardware
Date: Fri, 30 Jun 2023 16:42:42 +0200
Message-ID: <20230630144243.214976-3-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630144243.214976-1-fbarrat@linux.ibm.com>
References: <20230630144243.214976-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7ew1q5qmtrH7wV5IGXmXbmO6fzT7cr4R
X-Proofpoint-GUID: DM5DfMA8sTbHNxBofXefHpXO80p9l-3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=844 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300123
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On P9/P10, the PSIHB interrupts are initialized with a PQ state of
0b01, i.e. interrupts are disabled. However the real hardware
initializes them to 0b00 for the PSIHB. This patch updates it, in case
an hypervisor is in the mood of checking it.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/ppc/pnv_psi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 46da58dff8..f232935d27 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -863,6 +863,8 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(xsrc), "nr-irqs", PSIHB9_NUM_IRQS,
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), "xive", OBJECT(psi), &error_abort);
+    object_property_set_int(OBJECT(xsrc), "pq-init", XIVE_ESB_RESET,
+                            &error_abort);
     if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
-- 
2.41.0


