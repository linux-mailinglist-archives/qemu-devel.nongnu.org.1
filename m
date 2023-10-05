Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C907BA62A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRDe-0008M1-EM; Thu, 05 Oct 2023 12:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoRDS-00086h-Rq; Thu, 05 Oct 2023 12:28:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoRDO-0007JF-Ry; Thu, 05 Oct 2023 12:28:46 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395GKWAp026605; Thu, 5 Oct 2023 16:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QOg7zx0lpBTiEEWKbWZHlYNPbysvWMCGBIq+vC2s/hw=;
 b=oNiOfMcnUfqwQE75BKU7HHibsdcf/Tq88ojWPwE+nkLuHxE2y/hiubrTT24byabo6wDo
 HgUt5DnKoZVCEWvr4Cve3FakqNy5q5LLhgevVVwVq6Wb88/PR5jdyORnsAIlGqHRSdcX
 Li4WrrtpN5p6TtCVkWQbn616PgonFasugoIZ6p+b8DyhGXkSypN20cE9WpVoppWKlq8d
 cOSt/93s8ejNJpMzhwljeYCjYbzIDKcdKp7wvm2UxuaB8w5M+BTm2TmKJ7/5cPC4toGo
 RgtQj1U+HS4QhrJuTmkZnaMHBSPpgzWZiUJ/I/iEYQ/Z/L/6c0NcSuAfYOElFbGNwmtF wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj0ju8kvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:28:27 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395GKepF027925;
 Thu, 5 Oct 2023 16:28:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj0ju8hen-26
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:28:21 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 395FuHOE025094; Thu, 5 Oct 2023 16:02:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcywp8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:02:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 395G22eS26542636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Oct 2023 16:02:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47B162004E;
 Thu,  5 Oct 2023 16:02:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A00F2005A;
 Thu,  5 Oct 2023 16:02:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Oct 2023 16:02:01 +0000 (GMT)
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
Subject: [PATCH v25 17/21] tests/avocado: s390x cpu topology entitlement tests
Date: Thu,  5 Oct 2023 18:01:51 +0200
Message-Id: <20231005160155.1945588-18-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231005160155.1945588-1-nsg@linux.ibm.com>
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aEmS4uVRKUiyopxsC2eljnhEftIzhaVp
X-Proofpoint-GUID: eUtFAc1U6p2229aXGIJaoWODrkKQ1bS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_11,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050128
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


