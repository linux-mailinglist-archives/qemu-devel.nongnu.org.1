Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA1BB373C3
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Aug 2025 22:23:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur0Ax-0004gJ-1l; Tue, 26 Aug 2025 16:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ur0As-0004fQ-TD; Tue, 26 Aug 2025 16:21:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ur0Aq-00052b-FW; Tue, 26 Aug 2025 16:21:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QF4WT8030165;
 Tue, 26 Aug 2025 20:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hfcu2T
 l39xukBTDD+4I3uIcYFrWQ90fZgIAZC+sJ54o=; b=T6W70qQyuVb7oaSRaDFXWW
 YjEtI3yS3NQsQW123f4KnznV0bOQ1+CDgB4rh9W/ysR5jvoou/Awa0rIeh+PI0c8
 kBXmyBXNdLeRiA2htR0PUdvb+ve3HquFaDTQYh05YlcisoVSguRnSiyN3BlZwxEE
 XuaiPVK47GsygQ7x2GYJvF89/r8spvQ5tKjv1IfWGX9XYoVOClpsSRCy0wBoXwyN
 iWH76cUyeBAuUOVr42QTXPrC5wTxjml8452DL3CxQqs4fFbI+pmlPiGq6C7AKqwc
 UJEaAvGT/UWQPy0hoObqA3BI/rRyCDgFFUrRXlwlho9Bjn0U3jNvvNm7r5zaklLQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rvurxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 20:21:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57QKLfoj005387;
 Tue, 26 Aug 2025 20:21:41 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rvurx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 20:21:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57QKIB7h002524;
 Tue, 26 Aug 2025 20:21:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6mccks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 20:21:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57QKLUxM42336532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Aug 2025 20:21:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 353085805F;
 Tue, 26 Aug 2025 20:21:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7ABA758066;
 Tue, 26 Aug 2025 20:21:38 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Aug 2025 20:21:38 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v2 4/4] tests/functional: Add test for IBM PPE42 instructions
Date: Tue, 26 Aug 2025 15:17:51 -0500
Message-ID: <20250826201920.335308-5-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826201920.335308-1-milesg@linux.ibm.com>
References: <20250826201920.335308-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8DFrv1dWtCblFnUf8IMhJlVKTfghq88O
X-Authority-Analysis: v=2.4 cv=fbCty1QF c=1 sm=1 tr=0 ts=68ae1756 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=up-X0YpDAAAA:8 a=WP5zsaevAAAA:8
 a=NUakdCcs51WeiAtREWwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=86FmjZgct7XXK6GGpxvI:22 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-GUID: aydk9VnKKgB1nBPI-qSV3NdSiTJTmNwR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA1NSBTYWx0ZWRfX1T2WVjt3fqbT
 t2esRrWPoTNJocnsTGhVAipN19by9ulaTVRf0h1o/DAs64HgyRKjAjbnREzMEr7sE4cApZbL9E8
 4xbp1MEyccipfjQG1f1BAaWkcs6ofEAgOboUIh2IeZfVQRKgCbjMrJdvFRsvUmcCvq/tirnz43W
 cursFu0ZCV9VNzW+6xUINUpqh2AedsqysjUpD1fibEEu9i4eZPCRLpp6U0uWbLBnrkus3n0Ko0I
 maj7Fh2+7j3GAf9oEKZ+u0PstCbFY/jHJi6iWSxHl3ZylPQCLtdx3GqSAxo8mYLpG+bBBQ2PrBs
 rsHSksIeC+7dGvoocxEUcIhQY5Ut9S911KWujvzuGYMpPDjOAPklaT5Ek5UV3uZ2v+Z0W7MWdg2
 yvRf6dOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260055
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adds a functional test for the IBM PPE42 instructions which
downloads a test image from a public github repo and then
loads and executes the image.
(see https://github.com/milesg-github/ppe42-tests for details)

Test status is checked by periodically issuing 'info register'
commands and checking the NIP value.  If the NIP is 0xFFF80200
then the test successfully executed to completion.  If the
machine stops before the test completes or if a 90 second
timeout is reached, then the test is marked as having failed.

This test does not test any PowerPC instructions as it is
expected that these instructions are well covered in other
tests.  Only instructions that are unique to the IBM PPE42
processor are tested.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
Changes from previous version
- Added test_ppc_ppe42.py file to MAINTAINERS file

 MAINTAINERS                        |  1 +
 tests/functional/meson.build       |  1 +
 tests/functional/test_ppc_ppe42.py | 79 ++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 tests/functional/test_ppc_ppe42.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 52fa303e0a..af412ad0ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1536,6 +1536,7 @@ M: Glenn Miles <milesg@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/ppe42_machine.c
+F: tests/functional/test_ppc_ppe42.py
 
 PReP
 M: Hervé Poussineau <hpoussin@reactos.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 311c6f1806..ddfef55bd2 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -233,6 +233,7 @@ tests_ppc_system_quick = [
 ]
 
 tests_ppc_system_thorough = [
+  'ppc_ppe42',
   'ppc_40p',
   'ppc_amiga',
   'ppc_bamboo',
diff --git a/tests/functional/test_ppc_ppe42.py b/tests/functional/test_ppc_ppe42.py
new file mode 100644
index 0000000000..26bbe11b2d
--- /dev/null
+++ b/tests/functional/test_ppc_ppe42.py
@@ -0,0 +1,79 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the IBM PPE42 processor
+#
+# Copyright (c) 2025, IBM Corporation
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+import asyncio
+
+class Ppe42Machine(QemuSystemTest):
+
+    timeout = 90
+    poll_period = 1.0
+
+    ASSET_PPE42_TEST_IMAGE = Asset(
+        ('https://github.com/milesg-github/ppe42-tests/raw/refs/heads/main/'
+         'images/ppe42-test.out'),
+        '03c1ac0fb7f6c025102a02776a93b35101dae7c14b75e4eab36a337e39042ea8')
+
+    def _test_completed(self):
+        self.log.info("Checking for test completion...")
+        try:
+            output = self.vm.cmd('human-monitor-command',
+                                 command_line='info registers')
+        except Exception as err:
+            self.log.debug(f"'info registers' cmd failed due to {err=},"
+                            " {type(err)=}")
+            raise
+
+        self.log.info(output)
+        if "NIP fff80200" in output:
+            self.log.info("<test completed>")
+            return True
+        else:
+            self.log.info("<test not completed>")
+            return False
+
+    def _wait_pass_fail(self, timeout):
+        while not self._test_completed():
+            if timeout >= self.poll_period:
+                timeout = timeout - self.poll_period
+                self.log.info(f"Waiting {self.poll_period} seconds for test"
+                               " to complete...")
+                e = None
+                try:
+                    e = self.vm.event_wait('STOP', self.poll_period)
+
+                except asyncio.TimeoutError:
+                    self.log.info("Poll period ended.")
+                    pass
+
+                except Exception as err:
+                    self.log.debug(f"event_wait() failed due to {err=},"
+                                    " {type(err)=}")
+                    raise
+
+                if e != None:
+                    self.log.debug(f"Execution stopped: {e}")
+                    self.log.debug("Exiting due to test failure")
+                    self.fail("Failure detected!")
+                    break
+            else:
+                self.fail("Timed out waiting for test completion.")
+
+    def test_ppe42_instructions(self):
+        self.set_machine('ppe42_machine')
+        self.require_accelerator("tcg")
+        image_path = self.ASSET_PPE42_TEST_IMAGE.fetch()
+        self.vm.add_args('-nographic')
+        self.vm.add_args('-device', f'loader,file={image_path}')
+        self.vm.add_args('-device', 'loader,addr=0xfff80040,cpu-num=0')
+        self.vm.add_args('-action', 'panic=pause')
+        self.vm.launch()
+        self._wait_pass_fail(self.timeout)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


