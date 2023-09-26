Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 481EE7AEC7D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:21:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql70F-0001J1-VD; Tue, 26 Sep 2023 08:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6zQ-0000ez-1r; Tue, 26 Sep 2023 08:16:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6zO-0001SE-F9; Tue, 26 Sep 2023 08:16:31 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QCDgOV026727; Tue, 26 Sep 2023 12:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4ttcKC1Ox+7dgOZStm1mQiszFmHIvxlalBDBVZXFimA=;
 b=C1fXwv5VMT2VgVG4WhLE8wYu/odiwJtyFn4rGGbs77/yTvbPuGyZdULufwBnLu3HshAW
 6MfyY2mZRn8IdlK8kVeY97okERZUKOfcHV0c+gHoP1fOw0NCoTMJlpK8oRZ9VLyx6xFs
 xV5nqBXOtXWm+LoS1jSq7gPvXbfaEaOVsRdbwfelst3UfPI71g5z+c8BSQr3SLyPF7PD
 GOW6DU5PAbJpSqwmXs/cI4rr+qpTuG9xxo0KveiUFLNZWYxfETlHqzCuFrhBWYDJOdy/
 HPEGLUquObhAbbGKJXkAY/e4OtXptqia04spsezAYuiq1n46HNVqW2utUAOP998w8ilF ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxeus5f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:57 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QCCYd2023674;
 Tue, 26 Sep 2023 12:15:56 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxeus5eq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QAHJdU008394; Tue, 26 Sep 2023 12:15:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabskng5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38QCFr4D58524080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 12:15:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4C0820040;
 Tue, 26 Sep 2023 12:15:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7955B2005A;
 Tue, 26 Sep 2023 12:15:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Sep 2023 12:15:52 +0000 (GMT)
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
Subject: [PATCH v24 10/21] machine: adding s390 topology to query-cpu-fast
Date: Tue, 26 Sep 2023 14:15:23 +0200
Message-Id: <20230926121534.406035-11-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926121534.406035-1-nsg@linux.ibm.com>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VzbH3_WksPPfA4XIH920jSEBexdHRZ7T
X-Proofpoint-ORIG-GUID: yDwci5s5zXsa5gdzQ1nHBlewP-Jhi4Mx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260104
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

S390x provides two more topology attributes, entitlement and dedication.

Let's add these CPU attributes to the QAPI command query-cpu-fast.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 qapi/machine.json  | 11 ++++++++++-
 target/s390x/cpu.c |  9 +++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 8499d40269..eb2de7acc7 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -57,9 +57,18 @@
 #
 # @cpu-state: the virtual CPU's state
 #
+# @dedicated: the virtual CPU's dedication (since 8.2)
+#
+# @entitlement: the virtual CPU's entitlement (since 8.2)
+#
 # Since: 2.12
 ##
-{ 'struct': 'CpuInfoS390', 'data': { 'cpu-state': 'CpuS390State' } }
+{ 'struct': 'CpuInfoS390',
+  'data': { 'cpu-state': 'CpuS390State',
+            '*dedicated': 'bool',
+            '*entitlement': 'CpuS390Entitlement'
+  }
+}
 
 ##
 # @CpuInfoFast:
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 74405beb51..5967e34a85 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -38,6 +38,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
 #endif
+#include "hw/s390x/cpu-topology.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -146,6 +147,14 @@ static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
     S390CPU *s390_cpu = S390_CPU(cpu);
 
     value->u.s390x.cpu_state = s390_cpu->env.cpu_state;
+#if !defined(CONFIG_USER_ONLY)
+    if (s390_has_topology()) {
+        value->u.s390x.has_dedicated = true;
+        value->u.s390x.dedicated = s390_cpu->env.dedicated;
+        value->u.s390x.has_entitlement = true;
+        value->u.s390x.entitlement = s390_cpu->env.entitlement;
+    }
+#endif
 }
 
 /* S390CPUClass::reset() */
-- 
2.39.2


