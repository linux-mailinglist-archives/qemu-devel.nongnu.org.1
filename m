Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D707AEC49
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql70F-0001I2-FL; Tue, 26 Sep 2023 08:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6z5-0000Wz-Pa; Tue, 26 Sep 2023 08:16:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6z2-0001Qz-Np; Tue, 26 Sep 2023 08:16:11 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QCC2ox022025; Tue, 26 Sep 2023 12:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SEN/GwjjFnMDU3rlBmts7XCAUziEumSnWOFhDrnIgr8=;
 b=DqpfLG08crSmWgKTx17uHVFDLhLHSio8ODmq36QqpDHQh9g2iEbBpanD3mmDEEJ6j3AE
 lM3tsKURppAzXzf90vfQWMqwAVHSYf0CrH038cC6665u7FAg0Tk0YkKcacBuwQwzI2Oh
 hmHgLc8RBOxSeocM5gMH7Ub8M9WLFQFzGoAnLaLBZ13JKLKufW4bhFyNSJ23ZqXx+MMn
 AiuND7Lw4op8eXa5OIwgJKUdqnGy2C5QkXn2SuxOX8ifFPqIBabYGl8KBx61Kk2DA0zs
 xmO1ZPd97ZkGLLwRMorwYpb/10PFca+Z30V2ni7guMVazwqlrv2I/HliaWchyYYxr/Wv Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxeus5fj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:58 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QC17vc000754;
 Tue, 26 Sep 2023 12:15:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxeus5f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38Q9vEfV011032; Tue, 26 Sep 2023 12:15:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukb4y4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38QCFrn818940664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 12:15:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D83F02004B;
 Tue, 26 Sep 2023 12:15:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DD822004E;
 Tue, 26 Sep 2023 12:15:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Sep 2023 12:15:53 +0000 (GMT)
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
Subject: [PATCH v24 12/21] qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE
 qapi event
Date: Tue, 26 Sep 2023 14:15:25 +0200
Message-Id: <20230926121534.406035-13-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926121534.406035-1-nsg@linux.ibm.com>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2MGh8dQKY8ivj4z_ETMM-7DyB9FsqytP
X-Proofpoint-ORIG-GUID: ES7RpA5R-4lfO_F7_JtG27T5SUI5EbQO
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
 qapi/machine-target.json | 34 ++++++++++++++++++++++++++++++++++
 hw/s390x/cpu-topology.c  |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 3fd8390922..02f1de5d02 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -417,3 +417,37 @@
   'features': [ 'unstable' ],
   'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
 }
+
+##
+# @CPU_POLARIZATION_CHANGE:
+#
+# Emitted when the guest asks to change the polarization.
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
+# @polarization: polarization specified by the guest
+#
+# Features:
+#
+# @unstable: This event is experimental.
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
index 28adfb3f84..18274db74c 100644
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


