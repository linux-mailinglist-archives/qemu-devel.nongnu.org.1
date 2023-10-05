Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81C7BA62C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:29:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRDa-0007wH-NL; Thu, 05 Oct 2023 12:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoRDF-0007pD-6b; Thu, 05 Oct 2023 12:28:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoRDD-0007IL-GB; Thu, 05 Oct 2023 12:28:32 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395GL5Af006955; Thu, 5 Oct 2023 16:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z5thTqTzj8mpKA3dC17IXFxpVm2NBV7EmYtSi9WZSVw=;
 b=A/qRFXWo2fdxHnRvKUfJbqtH5ORU+Szrp5y/4TTutUmSH7SDoQXZIx+zHuYWySZ+nXM7
 bC+41BQKkJJVz0cmc6WPz3Jho+x9gI6kHZJj7wRJ6XDHKu37gXuYJKS3QFheCvtwX24Z
 KSpDQzpLhTnkJzJcz41oOSgc0z7C4ifk899VE57mOx+lZ9H7uyF8QyNU90lM8LrJp856
 9ph61zOTC4oEalodihNEu+sOHH+FH4CTs2808SA47OoT3UUy/ORbtxsDKyVBg2H9WEAn
 qqwpsSRWVP/lCdmmB/jIInfaRX4qAs4IyJ1TuvkDiXKSLgLGNfEbI29mIoNp1cdVWHtv jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj0kb8gyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:28:24 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395GMVnZ016467;
 Thu, 5 Oct 2023 16:28:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj0kb8fw5-43
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:28:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 395FN0TM017649; Thu, 5 Oct 2023 16:02:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tey0nwcjd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:02:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 395G22Ko25428510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Oct 2023 16:02:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0419B2004E;
 Thu,  5 Oct 2023 16:02:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B13E020040;
 Thu,  5 Oct 2023 16:02:01 +0000 (GMT)
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
Subject: [PATCH v25 16/21] tests/avocado: s390x cpu topology polarization
Date: Thu,  5 Oct 2023 18:01:50 +0200
Message-Id: <20231005160155.1945588-17-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231005160155.1945588-1-nsg@linux.ibm.com>
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: deRcns-G47X1h2UjqDIbNoHK8gDWLeRG
X-Proofpoint-ORIG-GUID: 0gVT4N40NLhuhMlSX8ycTHNvZqu362zc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_11,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 priorityscore=1501 mlxscore=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050128
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


