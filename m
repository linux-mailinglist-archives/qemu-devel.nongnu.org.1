Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66784743814
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAHK-0002up-QI; Fri, 30 Jun 2023 05:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qFAHD-0002fg-Me; Fri, 30 Jun 2023 05:18:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qFAH8-0003B2-1a; Fri, 30 Jun 2023 05:18:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35U9I8L9012015; Fri, 30 Jun 2023 09:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+FZ9TXTay6jOBYDcFdzv2FKEjfRMUjf/AsOTTzukO9Y=;
 b=AZGGdmYwOVUBWYxPywmlCwiofg+azfC9H6LhH5TtwYf8f0obWopEBtvvSUZ2VCftWzJW
 QrYyQtx5t/tebaos6pEgwS5b0t3Jzuv9FxjnzmV864yD2l+cmmxm4O5ty9fkexkUEiU0
 qIX5PwxXqnSjZKXvZwnGRn9x4aimWH5NObltlYgwgHW/svpT4BC5NMpmG9Skgsxew9tr
 qCQAAIPSYiOysyX6JEHQ7j+Pf4EisrQ7Mju5VPM9WFWFwMczkArokK4MfxZqa9/RVbJi
 WRptnGisCuNfYSabFn57y8r3k+TtUzMml0B7f05i3aPPlQi2ibHx4mB1ABNu4Hj1b3r3 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhv9vg1r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:33 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U9IT5g014272;
 Fri, 30 Jun 2023 09:18:29 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhv9vg19q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:29 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U4GViA029773;
 Fri, 30 Jun 2023 09:18:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rdr452yf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35U9IH2F38535596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 09:18:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E2A320043;
 Fri, 30 Jun 2023 09:18:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2774C20040;
 Fri, 30 Jun 2023 09:18:16 +0000 (GMT)
Received: from li-c6ac47cc-293c-11b2-a85c-d421c8e4747b.ibm.com.com (unknown
 [9.171.38.86]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 09:18:16 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, nsg@linux.ibm.com, frankja@linux.ibm.com,
 berrange@redhat.com, clg@kaod.org
Subject: [PATCH v21 16/20] tests/avocado: s390x cpu topology entitlement tests
Date: Fri, 30 Jun 2023 11:17:48 +0200
Message-Id: <20230630091752.67190-17-pmorel@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230630091752.67190-1-pmorel@linux.ibm.com>
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z64GFIrYuIIrj_auUAXo2Nb6XWCJjDty
X-Proofpoint-ORIG-GUID: kczaCzaHtGE2C8vJAPJVsr4Nrxx4th2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pmorel@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

This test takes care to check the changes on different entitlements
when the guest requests a polarization change.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 tests/avocado/s390_topology.py | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
index 2cf731cb1d..4855e5d7e4 100644
--- a/tests/avocado/s390_topology.py
+++ b/tests/avocado/s390_topology.py
@@ -240,3 +240,50 @@ def test_polarisation(self):
         res = self.vm.qmp('query-cpu-polarization')
         self.assertEqual(res['return']['polarization'], 'horizontal')
         self.check_topology(0, 0, 0, 0, 'medium', False)
+
+    def test_entitlement(self):
+        """
+        This test verifies that QEMU modifies the polarization
+        after a guest request.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.add_args('-smp',
+                         '4,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
+        self.vm.launch()
+        self.wait_until_booted()
+
+        self.system_init()
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 0, 'entitlement': 'low'})
+        self.assertEqual(res['return'], {})
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 1, 'entitlement': 'medium'})
+        self.assertEqual(res['return'], {})
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 2, 'entitlement': 'high'})
+        self.assertEqual(res['return'], {})
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 3, 'entitlement': 'high'})
+        self.assertEqual(res['return'], {})
+        self.check_topology(0, 0, 0, 0, 'low', False)
+        self.check_topology(1, 0, 0, 0, 'medium', False)
+        self.check_topology(2, 1, 0, 0, 'high', False)
+        self.check_topology(3, 1, 0, 0, 'high', False)
+
+        self.guest_set_dispatching('1');
+
+        self.check_topology(0, 0, 0, 0, 'low', False)
+        self.check_topology(1, 0, 0, 0, 'medium', False)
+        self.check_topology(2, 1, 0, 0, 'high', False)
+        self.check_topology(3, 1, 0, 0, 'high', False)
+
+        self.guest_set_dispatching('0');
+
+        self.check_topology(0, 0, 0, 0, 'low', False)
+        self.check_topology(1, 0, 0, 0, 'medium', False)
+        self.check_topology(2, 1, 0, 0, 'high', False)
+        self.check_topology(3, 1, 0, 0, 'high', False)
-- 
2.31.1


