Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725574382E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:21:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAGr-0002JY-43; Fri, 30 Jun 2023 05:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qFAGp-0002IU-9k; Fri, 30 Jun 2023 05:18:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qFAGn-0002JG-Em; Fri, 30 Jun 2023 05:18:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35U9C0kG027099; Fri, 30 Jun 2023 09:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Pg3iXj/t8By02xcxLVJwBgIN/XQNQAF6si1pmiLZlnA=;
 b=f+fB+UvfkPSU4i6uFafg+4LLVg14Gzk7K2c9vM9V1dqe5PZt4oxnPQc5B5O7woEBfrZ/
 Bgq6MJAWjvC2qr/aDTi6zNb7h4sAiNZXyo+aTkX+N36qAai9at+iAEuyRdNhlXWgqonZ
 ymFPELSum8myLEgbSgcDLwrbxDtwdgYx0859DQgyBpo25cT81FGTXDHU7C+iI+vFSIe8
 YzL4czvuwA7jrs0CKWIlJbOkyAqT4PFChcO/UJkkuZKDULEzKSSm3JQQ7GZzheB81NXA
 jDvYXfkoeLl3pBhoY/Tovb8TgBUNLJdFSAJv42y3qT5PrxaltGRuzjRIQO4lhKw2zxyl 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhv72g8ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:19 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U9CqND030132;
 Fri, 30 Jun 2023 09:18:19 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhv72g899-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:18 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2pB0Q004394;
 Fri, 30 Jun 2023 09:18:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr4542qx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35U9IAS538928878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 09:18:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A87620049;
 Fri, 30 Jun 2023 09:18:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 234B220040;
 Fri, 30 Jun 2023 09:18:09 +0000 (GMT)
Received: from li-c6ac47cc-293c-11b2-a85c-d421c8e4747b.ibm.com.com (unknown
 [9.171.38.86]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 09:18:09 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, nsg@linux.ibm.com, frankja@linux.ibm.com,
 berrange@redhat.com, clg@kaod.org
Subject: [PATCH v21 11/20] qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE
 qapi event
Date: Fri, 30 Jun 2023 11:17:43 +0200
Message-Id: <20230630091752.67190-12-pmorel@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230630091752.67190-1-pmorel@linux.ibm.com>
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Cdj95oAa7lTzVXXsh_jTLumUCpgHGUPv
X-Proofpoint-GUID: PXdohUjvfYgpIcTxMowF9AogAqWNuGFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pmorel@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

When the guest asks to change the polarization this change
is forwarded to the upper layer using QAPI.
The upper layer is supposed to take according decisions concerning
CPU provisioning.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 qapi/machine-target.json | 33 +++++++++++++++++++++++++++++++++
 hw/s390x/cpu-topology.c  |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index bff4d50f0e..1362e43983 100644
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
+# Since: 8.1
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
index dfc4cb42a4..69f31db4af 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -24,6 +24,7 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/cpu-topology.h"
 #include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qapi-events-machine-target.h"
 
 /*
  * s390_topology is used to keep the topology information.
@@ -137,6 +138,7 @@ void s390_handle_ptf(S390CPU *cpu, uint8_t r1, uintptr_t ra)
         } else {
             s390_topology.polarization = polarization;
             s390_cpu_topology_set_changed(true);
+            qapi_event_send_cpu_polarization_change(polarization);
             setcc(cpu, 0);
         }
         break;
-- 
2.31.1


