Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1947CB2E2
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 20:45:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsSX3-0007rU-B9; Mon, 16 Oct 2023 14:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qsSWm-0007io-86; Mon, 16 Oct 2023 14:41:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qsSWd-0006GV-6s; Mon, 16 Oct 2023 14:41:18 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GICO5A025681; Mon, 16 Oct 2023 18:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cxbIdimHutyrYFdhup7FBL7EV8c/EOx9NvvaotHgjgA=;
 b=IxgmW9OUYBBzOWM/k7QOM714IzEghQDy7Lm5cel3yfk3xNnjBzABwDkYwaJl2doPOmiz
 2KZHb1/TFesU+anH2D9pnXGGY2D+l+Byqo07okDG7L5Lq+gn07zmEuEJ2MFkiIapyFbx
 Gd0lsMtDMaXfQYbUg7LesdQPhnbZY2KpY6fodrkz4dW8fG0B3YcK8lE272dY7Bu1cpqn
 LCz357WL6jqb298dt7D5cD5nTmHKao+XPUqaWWeigsd0CpRpM0UAclwRw4KOy6sgNsXX
 ccibpKHWU3JfmyIMifR65myvVMlqo5i6Mprjf8wQKHXxlsfR1ZGjZmZVHmH2eYlKFUnB Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsa8cs3jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:40:29 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GIEjTH000630;
 Mon, 16 Oct 2023 18:40:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsa8cs1kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:40:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GHL4Wh012871; Mon, 16 Oct 2023 18:39:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5py2yuv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:39:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39GIdURu656078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 18:39:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DA2C20040;
 Mon, 16 Oct 2023 18:39:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 353692004E;
 Mon, 16 Oct 2023 18:39:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:39:30 +0000 (GMT)
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
Subject: [PATCH v26 08/21] target/s390x/cpu topology: activate CPU topology
Date: Mon, 16 Oct 2023 20:39:12 +0200
Message-Id: <20231016183925.2384704-9-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016183925.2384704-1-nsg@linux.ibm.com>
References: <20231016183925.2384704-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jMNI9iDg7V4NynjjOJrNwt-nSHIoitLw
X-Proofpoint-ORIG-GUID: 7luMI82WxHKw2NRafqXMfVtxKJ-U9vxR
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

The KVM capability KVM_CAP_S390_CPU_TOPOLOGY is used to
activate the S390_FEAT_CONFIGURATION_TOPOLOGY feature and
the topology facility in the host CPU model for the guest
in the case the topology is available in QEMU and in KVM.

The feature is disabled by default and fenced for SE
(secure execution).

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/cpu-topology.c   | 2 +-
 target/s390x/cpu_models.c | 1 +
 target/s390x/kvm/kvm.c    | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index a00a4ce4df..4e4c35f6da 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -69,7 +69,7 @@ static int s390_socket_nb(S390CPU *cpu)
  */
 bool s390_has_topology(void)
 {
-    return false;
+    return s390_has_feat(S390_FEAT_CONFIGURATION_TOPOLOGY);
 }
 
 /**
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 98f14c09c2..4dead48650 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -255,6 +255,7 @@ bool s390_has_feat(S390Feat feat)
         case S390_FEAT_SIE_CMMA:
         case S390_FEAT_SIE_PFMFI:
         case S390_FEAT_SIE_IBS:
+        case S390_FEAT_CONFIGURATION_TOPOLOGY:
             return false;
             break;
         default:
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 4d84dcc018..2e43dc746f 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -366,6 +366,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     kvm_vm_enable_cap(s, KVM_CAP_S390_USER_SIGP, 0);
     kvm_vm_enable_cap(s, KVM_CAP_S390_VECTOR_REGISTERS, 0);
     kvm_vm_enable_cap(s, KVM_CAP_S390_USER_STSI, 0);
+    kvm_vm_enable_cap(s, KVM_CAP_S390_CPU_TOPOLOGY, 0);
     if (ri_allowed()) {
         if (kvm_vm_enable_cap(s, KVM_CAP_S390_RI, 0) == 0) {
             cap_ri = 1;
@@ -2509,6 +2510,14 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         set_bit(S390_FEAT_UNPACK, model->features);
     }
 
+    /*
+     * If we have kernel support for CPU Topology indicate the
+     * configuration-topology facility.
+     */
+    if (kvm_check_extension(kvm_state, KVM_CAP_S390_CPU_TOPOLOGY)) {
+        set_bit(S390_FEAT_CONFIGURATION_TOPOLOGY, model->features);
+    }
+
     /* We emulate a zPCI bus and AEN, therefore we don't need HW support */
     set_bit(S390_FEAT_ZPCI, model->features);
     set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
-- 
2.39.2


