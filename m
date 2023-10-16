Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EAF7CB2BB
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 20:43:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsSWN-0007Yk-Sa; Mon, 16 Oct 2023 14:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qsSWC-0007XT-HD; Mon, 16 Oct 2023 14:40:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qsSVy-00069x-3r; Mon, 16 Oct 2023 14:40:42 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GICPko025694; Mon, 16 Oct 2023 18:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QOg7zx0lpBTiEEWKbWZHlYNPbysvWMCGBIq+vC2s/hw=;
 b=mxhn2acWSYqTmIQQx8AUUI9qSJ4hdX8LcXLU4muC9tOj4kk1rw4AGYPRJ6g+C25SEhRT
 jGzPz4PTFdwe+/muSX+l94u3hDcvV3ESQQU+JKezvBTsWe3ln15qN/7DBajX/R2V9h8s
 7uGgO8fBF9A8iF7IZUp3wvSGylM/LGwei8rHf3vnDvSY+uTc9WQaGnCIeUGt425HivLg
 vpAdA01OyG2+nltXDpab3ASWc4Vb6g65JkpSdrdqLsyNxoX49Te9mI0xNMfnpbzU1UdL
 7C9g2R/ApDMIa3MXHXQs+fuJeWuLGxYyAD6nxvkoQWDBC+Iw9kVKd/R8Cu8g62bTZRY8 iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsa8cs2j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:40:11 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GIDHJr027600;
 Mon, 16 Oct 2023 18:40:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsa8cs1qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:40:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GGhoLB019884; Mon, 16 Oct 2023 18:39:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr811aabw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:39:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39GIdZq229229406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 18:39:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E53312004B;
 Mon, 16 Oct 2023 18:39:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C83020043;
 Mon, 16 Oct 2023 18:39:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:39:34 +0000 (GMT)
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
Subject: [PATCH v26 17/21] tests/avocado: s390x cpu topology entitlement tests
Date: Mon, 16 Oct 2023 20:39:21 +0200
Message-Id: <20231016183925.2384704-18-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016183925.2384704-1-nsg@linux.ibm.com>
References: <20231016183925.2384704-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4h39rDLFE4tS-l2VabEgUeD8yp9yGnNW
X-Proofpoint-ORIG-GUID: c0oVcINoaUO2iknSyftR0Mx7vJvN48T_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160162
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Test changes in the entitlement from both a guest and a host point of
view, depending on the polarization.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 tests/avocado/s390_topology.py | 62 ++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
index 8166cee134..24fac9a54d 100644
--- a/tests/avocado/s390_topology.py
+++ b/tests/avocado/s390_topology.py
@@ -243,3 +243,65 @@ def test_polarization(self):
         res = self.vm.qmp('query-s390x-cpu-polarization')
         self.assertEqual(res['return']['polarization'], 'horizontal')
         self.check_topology(0, 0, 0, 0, 'medium', False)
+
+
+    def check_polarization(self, polarization):
+        #We need to wait for the change to have been propagated to the kernel
+        exec_command_and_wait_for_pattern(self,
+            "\n".join([
+                "timeout 1 sh -c 'while true",
+                'do',
+                '    syspath="/sys/devices/system/cpu/cpu0/polarization"',
+                '    polarization="$(cat "$syspath")" || exit',
+               f'    if [ "$polarization" = "{polarization}" ]; then',
+                '        exit 0',
+                '    fi',
+                '    sleep 0.01',
+                #searched for strings mustn't show up in command, '' to obfuscate
+                "done' && echo succ''ess || echo fail''ure",
+            ]),
+            "success", "failure")
+
+
+    def test_entitlement(self):
+        """
+        This test verifies that QEMU modifies the entitlement
+        after a guest request and that the guest sees the change.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.launch()
+        self.wait_until_booted()
+
+        self.system_init()
+
+        self.check_polarization('horizontal')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+        self.guest_set_dispatching('1')
+        self.check_polarization('vertical:medium')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 0, 'entitlement': 'low'})
+        self.assertEqual(res['return'], {})
+        self.check_polarization('vertical:low')
+        self.check_topology(0, 0, 0, 0, 'low', False)
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 0, 'entitlement': 'medium'})
+        self.assertEqual(res['return'], {})
+        self.check_polarization('vertical:medium')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 0, 'entitlement': 'high'})
+        self.assertEqual(res['return'], {})
+        self.check_polarization('vertical:high')
+        self.check_topology(0, 0, 0, 0, 'high', False)
+
+        self.guest_set_dispatching('0');
+        self.check_polarization("horizontal")
+        self.check_topology(0, 0, 0, 0, 'high', False)
-- 
2.39.2


