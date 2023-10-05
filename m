Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F27C7BA7D5
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:22:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoS2g-0004lI-Dh; Thu, 05 Oct 2023 13:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoS2e-0004kq-Sn; Thu, 05 Oct 2023 13:21:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoS2d-0007HR-Eh; Thu, 05 Oct 2023 13:21:40 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395HHKWs029203; Thu, 5 Oct 2023 17:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=S1kZzCE+MqCyHvoHHaQChEgUxia3+OkWWmfw2hYFiIg=;
 b=tcSAkPA1EA2kmCviplMcyr+7oOm/ZAhHLVSCbfZsdasMWHlVo4PyeYmdyv0KGAePaGqu
 VhGfkyKlIjG7dcVIF721Wtx6oVorPzZCi2D3u9z+p2SVBk2QgdJtOW9j31cRn5B9YyHS
 Of89UACEJ1DUFV2tRBS8fMtDI6YfFkeZnWHc0LDaE1sKgesKeKrEwSuFkBT0uAQa1JbW
 LBED38L4ieEPgne0zdWu7rsmhwH36K5oRXWT/lIjGqJJc2THWNftj2eTc2iql99CaclQ
 bAXGU0ASgvU4HOIqiK0pflbtvhWpiheWvyA14gY3QiEZxztkVNZeY91LxZivSzwtjOVb 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj1dqr29j-90
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 17:21:28 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395G1oB1010017;
 Thu, 5 Oct 2023 16:03:16 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj09s82tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:03:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 395FhXcs005870; Thu, 5 Oct 2023 16:02:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0tdqk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:02:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 395G23Va19202722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Oct 2023 16:02:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB81A2005A;
 Thu,  5 Oct 2023 16:02:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A40BE2004F;
 Thu,  5 Oct 2023 16:02:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Oct 2023 16:02:02 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v25 19/21] tests/avocado: s390x cpu topology test socket full
Date: Thu,  5 Oct 2023 18:01:53 +0200
Message-Id: <20231005160155.1945588-20-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231005160155.1945588-1-nsg@linux.ibm.com>
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1zvblMpcF_9hYa-1hzIoT0HIqX3Zfl5q
X-Proofpoint-GUID: qeYagwJ72BYx6EAYJ6P2uQAkGv9fCSk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_12,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierre Morel <pmorel@linux.ibm.com>

This test verifies that QMP set-cpu-topology does not accept
to overload a socket.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/s390_topology.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
index 3661048f4c..a63c2b2923 100644
--- a/tests/avocado/s390_topology.py
+++ b/tests/avocado/s390_topology.py
@@ -338,3 +338,29 @@ def test_dedicated(self):
         self.guest_set_dispatching('0');
         self.check_topology(0, 0, 0, 0, 'high', True)
         self.check_polarization("horizontal")
+
+
+    def test_socket_full(self):
+        """
+        This test verifies that QEMU does not accept to overload a socket.
+        The socket-id 0 on book-id 0 already contains CPUs 0 and 1 and can
+        not accept any new CPU while socket-id 0 on book-id 1 is free.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.add_args('-smp',
+                         '3,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
+        self.vm.launch()
+        self.wait_until_booted()
+
+        self.system_init()
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 2, 'socket-id': 0, 'book-id': 0})
+        self.assertEqual(res['error']['class'], 'GenericError')
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 2, 'socket-id': 0, 'book-id': 1})
+        self.assertEqual(res['return'], {})
-- 
2.39.2


