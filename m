Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E275F743DC6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFFKy-0006QQ-NU; Fri, 30 Jun 2023 10:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qFFKr-0006Pg-Qk; Fri, 30 Jun 2023 10:42:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qFFKp-0005cC-Qi; Fri, 30 Jun 2023 10:42:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UEgcpO027976; Fri, 30 Jun 2023 14:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NM7RsgnUxSCKd0/QYuOZxG7n+W45hzqaufO+wee3gtY=;
 b=bu1nxd222yqBAJhI7oBEt2rqcWIbXxPnjVlFteRQHo9wT3dr7nSiUTAWGMjnCJXlQkZ4
 YpCJP8wG+ILZO2TAPHMkn+LYEdI9SDV2jHPmhMuMAFgdzOiIonH6QJ4Ox+QotjxZotxT
 0YGvQjgvqYAVUDaJhEQp3++5Eq6QXhQ4Uld/k876+nPTmMJmZrHDpocvrFIzGTGDyquI
 HR5DRtOtG4alKZYfMfLkjUt/zZWZkmEnwU4K5BQlhH9B9Bljrz7Y9sxheFZ3Ep7njq+Q
 eQkG6JbTyROCNqeOHubm8ceLoohK4bu2mnrBCkxt/309JKJkql239orbFYDB6biZUii1 Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj11yr098-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 14:42:51 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UEgnhs028427;
 Fri, 30 Jun 2023 14:42:49 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj11yr086-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 14:42:49 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UBqS8C021221;
 Fri, 30 Jun 2023 14:42:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rdr4533p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 14:42:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UEgiso19464948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 14:42:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4313720043;
 Fri, 30 Jun 2023 14:42:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D940820040;
 Fri, 30 Jun 2023 14:42:43 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.74.60])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 14:42:43 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] pnv/xive: Add property on xive sources to define PQ state
 on reset
Date: Fri, 30 Jun 2023 16:42:41 +0200
Message-ID: <20230630144243.214976-2-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630144243.214976-1-fbarrat@linux.ibm.com>
References: <20230630144243.214976-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hA9b-BZMR2oeJzIJw5IgM8W25N45E7Oo
X-Proofpoint-GUID: sEtTJHuuQ65FreOcHM0PZX6AzCxZT7hz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The PQ state of a xive interrupt is always initialized to Q=1, which
means the interrupt is disabled. Since a xive source can be embedded
in many objects, this patch adds a property to allow that behavior to
be refined if needed.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/xive.c        | 8 ++++++--
 include/hw/ppc/xive.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 84c079b034..c553b32638 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1232,8 +1232,7 @@ static void xive_source_reset(void *dev)
 
     /* Do not clear the LSI bitmap */
 
-    /* PQs are initialized to 0b01 (Q=1) which corresponds to "ints off" */
-    memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
+    memset(xsrc->status, xsrc->pq_init, xsrc->nr_irqs);
 }
 
 static void xive_source_realize(DeviceState *dev, Error **errp)
@@ -1287,6 +1286,11 @@ static Property xive_source_properties[] = {
     DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
     DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
     DEFINE_PROP_UINT32("shift", XiveSource, esb_shift, XIVE_ESB_64K_2PAGE),
+    /*
+     * By default, PQs are initialized to 0b01 (Q=1) which corresponds
+     * to "ints off"
+     */
+    DEFINE_PROP_UINT8("pq-init", XiveSource, pq_init, XIVE_ESB_OFF),
     DEFINE_PROP_LINK("xive", XiveSource, xive, TYPE_XIVE_NOTIFIER,
                      XiveNotifier *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 3dfb06e002..7969f06bcf 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -187,6 +187,7 @@ struct XiveSource {
 
     /* PQ bits and LSI assertion bit */
     uint8_t         *status;
+    uint8_t         pq_init; /* PQ state on reset */
 
     /* ESB memory region */
     uint64_t        esb_flags;
-- 
2.41.0


