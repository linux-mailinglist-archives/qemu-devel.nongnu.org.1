Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84109790072
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 18:04:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc6YG-0004ZH-Gk; Fri, 01 Sep 2023 11:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qc6YE-0004X5-HI; Fri, 01 Sep 2023 11:59:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qc6YC-0000iq-5C; Fri, 01 Sep 2023 11:59:14 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 381Fb1R1005889; Fri, 1 Sep 2023 15:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OcI09yUUeru5KcE2ngL4V4Cr6/vzPKC0RNYJMGHsJlg=;
 b=ZiHhdK4a57sbjnSHGyw5hotk7jUPJQyw0IPgWffe9YEB3PlXAn8DSXrtP4wwjN/1J3HJ
 uelPuplRQydSoaT08rop/Bj+A4r3spxKrCsPKOegcpwxFknK7VGJcuXWSn3y8ug97RM8
 haR2aEvSM2NolPmF4sw98n+qLgbNIEgA8ib7Qe+75EdWbLfN5VLVh+9TFQx+Vrzg9vxE
 cusAX/w612qVR0W9Qyi36zq4P81P32wZ/NUIRPGeg/BeUX9qsE2rmXBL47WChoeANH/P
 1VI6auhL7kt3qbJECGeVd2qPSZiACw5NFGJl5OuKU8X5h92L+tTxQCWNC5HsidJiu4ZU 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sujnj0v2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 15:59:00 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381FbCCV007043;
 Fri, 1 Sep 2023 15:59:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sujnj0v1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 15:58:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 381EG56d019258; Fri, 1 Sep 2023 15:58:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe2deet-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 15:58:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 381Fwtsr19202794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Sep 2023 15:58:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D62A620040;
 Fri,  1 Sep 2023 15:58:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D5FF2004D;
 Fri,  1 Sep 2023 15:58:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Sep 2023 15:58:55 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v22 11/20] qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE
 qapi event
Date: Fri,  1 Sep 2023 17:58:03 +0200
Message-Id: <20230901155812.2696560-12-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230901155812.2696560-1-nsg@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZFP4erUo9jOGoxyxE5iwaKZM-xsdNmCR
X-Proofpoint-ORIG-GUID: -8i2dKX1uAGqBxYpuuW2-0bRmmb9wPgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_13,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010145
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

When the guest asks to change the polarization this change
is forwarded to the upper layer using QAPI.
The upper layer is supposed to take according decisions concerning
CPU provisioning.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 qapi/machine-target.json | 33 +++++++++++++++++++++++++++++++++
 hw/s390x/cpu-topology.c  |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 1e7f512477..5c7a34c25f 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -412,3 +412,36 @@
   'features': [ 'unstable' ],
   'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
 }
+
+##
+# @CPU_POLARIZATION_CHANGE:
+#
+# Emitted when the guest asks to change the polarization.
+#
+# @polarization: polarization specified by the guest
+#
+# Features:
+# @unstable: This command may still be modified.
+#
+# The guest can tell the host (via the PTF instruction) whether the
+# CPUs should be provisioned using horizontal or vertical polarization.
+#
+# On horizontal polarization the host is expected to provision all vCPUs
+# equally.
+# On vertical polarization the host can provision each vCPU differently.
+# The guest will get information on the details of the provisioning
+# the next time it uses the STSI(15) instruction.
+#
+# Since: 8.2
+#
+# Example:
+#
+# <- { "event": "CPU_POLARIZATION_CHANGE",
+#      "data": { "polarization": "horizontal" },
+#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+##
+{ 'event': 'CPU_POLARIZATION_CHANGE',
+  'data': { 'polarization': 'CpuS390Polarization' },
+  'features': [ 'unstable' ],
+  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+}
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index c828538f2a..92513cb027 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -24,6 +24,7 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/cpu-topology.h"
 #include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qapi-events-machine-target.h"
 
 /*
  * s390_topology is used to keep the topology information.
@@ -136,6 +137,7 @@ void s390_handle_ptf(S390CPU *cpu, uint8_t r1, uintptr_t ra)
         } else {
             s390_topology.polarization = polarization;
             s390_cpu_topology_set_changed(true);
+            qapi_event_send_cpu_polarization_change(polarization);
             setcc(cpu, 0);
         }
         break;
-- 
2.39.2


