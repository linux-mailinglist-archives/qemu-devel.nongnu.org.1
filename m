Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F107AEC4A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6zv-0000pz-4Q; Tue, 26 Sep 2023 08:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6zD-0000aQ-UB; Tue, 26 Sep 2023 08:16:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6z9-0001Ui-NN; Tue, 26 Sep 2023 08:16:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QC6DYC011107; Tue, 26 Sep 2023 12:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z5thTqTzj8mpKA3dC17IXFxpVm2NBV7EmYtSi9WZSVw=;
 b=KD6i/WP4cAVI+quDxe9sH1pZ/Vz+0wbXHF12zGvAqk0Ge+M3cLdXvwgk/DcTmuB+cnFx
 BHlbw2K1afBkai7yTPp25LxZvAePkEFFhaksOPYD0Onz+ukMXuJov9R/zUJ47XHHxI0t
 qBh26wJXrYlb9O5ZaQ3ggXiF69rQWJWNbIuegi0QR7+cV03FHJozNnEl/n/DdmsoOYfs
 8aemGT87WykVgdQHlyWeFz5xTkF+gw/ebUGGQj1fj7vu6lKiuYBIyU+HaFkTQqcqqAnP
 sn2lH5Dzgsy+Bxsv13UGcyUezrHrIAL670Og7VPyhv3BlC5luLk9g+3EsttQ7WktidCs ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxw1rae6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:16:00 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QC6P5Q015860;
 Tue, 26 Sep 2023 12:16:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxw1radj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QAbxB5030404; Tue, 26 Sep 2023 12:15:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad21js7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38QCFtdF23659028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 12:15:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1AFC20040;
 Tue, 26 Sep 2023 12:15:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6741B20043;
 Tue, 26 Sep 2023 12:15:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Sep 2023 12:15:55 +0000 (GMT)
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
Subject: [PATCH v24 16/21] tests/avocado: s390x cpu topology polarization
Date: Tue, 26 Sep 2023 14:15:29 +0200
Message-Id: <20230926121534.406035-17-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926121534.406035-1-nsg@linux.ibm.com>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Em0x2wfBiCJX2qvs6Fo-xSu0yAxBsXl9
X-Proofpoint-ORIG-GUID: mz4JO0e3qNSICxwd9OovjIwp9YlfMmCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Polarization is changed on a request from the guest.
Let's verify the polarization is accordingly set by QEMU.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 tests/avocado/s390_topology.py | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
index 9078b45281..8166cee134 100644
--- a/tests/avocado/s390_topology.py
+++ b/tests/avocado/s390_topology.py
@@ -41,6 +41,7 @@ class S390CPUTopology(QemuSystemTest):
     The polarization is changed on a request from the guest.
     """
     timeout = 90
+    event_timeout = 10
 
     KERNEL_COMMON_COMMAND_LINE = ('printk.time=0 '
                                   'root=/dev/ram '
@@ -103,6 +104,14 @@ def kernel_init(self):
                          '-initrd', initrd_path,
                          '-append', kernel_command_line)
 
+    def system_init(self):
+        self.log.info("System init")
+        exec_command_and_wait_for_pattern(self,
+                """ mount proc -t proc /proc;
+                    mount sys -t sysfs /sys;
+                    cat /sys/devices/system/cpu/dispatching """,
+                    '0')
+
     def test_single(self):
         """
         This test checks the simplest topology with a single CPU.
@@ -198,3 +207,39 @@ def test_dash_device(self):
         self.check_topology(3, 1, 1, 1, 'high', False)
         self.check_topology(4, 1, 1, 1, 'medium', False)
         self.check_topology(5, 2, 1, 1, 'high', True)
+
+
+    def guest_set_dispatching(self, dispatching):
+        exec_command(self,
+                f'echo {dispatching} > /sys/devices/system/cpu/dispatching')
+        self.vm.event_wait('CPU_POLARIZATION_CHANGE', self.event_timeout)
+        exec_command_and_wait_for_pattern(self,
+                'cat /sys/devices/system/cpu/dispatching', dispatching)
+
+
+    def test_polarization(self):
+        """
+        This test verifies that QEMU modifies the entitlement change after
+        several guest polarization change requests.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.launch()
+        self.wait_until_booted()
+
+        self.system_init()
+        res = self.vm.qmp('query-s390x-cpu-polarization')
+        self.assertEqual(res['return']['polarization'], 'horizontal')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+        self.guest_set_dispatching('1');
+        res = self.vm.qmp('query-s390x-cpu-polarization')
+        self.assertEqual(res['return']['polarization'], 'vertical')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+        self.guest_set_dispatching('0');
+        res = self.vm.qmp('query-s390x-cpu-polarization')
+        self.assertEqual(res['return']['polarization'], 'horizontal')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
-- 
2.39.2


