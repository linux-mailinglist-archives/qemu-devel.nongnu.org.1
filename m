Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B106B2B398
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Aug 2025 23:45:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7dk-0001ch-O4; Mon, 18 Aug 2025 17:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7df-0001bY-97; Mon, 18 Aug 2025 17:43:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7dd-0003jX-6V; Mon, 18 Aug 2025 17:43:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ICNIX6002290;
 Mon, 18 Aug 2025 21:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7apvQ9A/kJ8ERMN9s
 azt0thpVm2noENtPYQXJDPP/6w=; b=IkNdieHcl8UMGxrmCYu1+jV2QNmR9ljdv
 1yU5sEkPo2QBgaslUhqyR+X28apOK9yli6VuKusxTFgygnf9lx+qMLIRNv8Ipx7Q
 IlPNedbMZfhUXDckscpRELVB6fMGckIohM8fmOeDp8MHKNs0K6pLcHRJ3FaMlS4y
 Ti/+2IM+pjj/a3xZvJs6Ig4Z4gTd4MRATQnbk5/ZFwHmL2AZQskDSEyPI/9YNRsi
 J/avhYUN1PEsKJQ8yUJ0PhIjcEdY6np86rDEw4gx0QO8OG/OS1V6Af9u1VNlEkVx
 hU8O4/llvWg2PsnkBiqZwQqx2kTzbCiUMiov4VQDKUhc48/OeTNGg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jge3uces-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IJs2f0002762;
 Mon, 18 Aug 2025 21:43:28 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k6hm7cv9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:28 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57ILhPRK27722262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Aug 2025 21:43:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE7E658058;
 Mon, 18 Aug 2025 21:43:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B42D958057;
 Mon, 18 Aug 2025 21:43:24 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.98.172])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Aug 2025 21:43:24 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 01/29] Add boot-certs to s390-ccw-virtio machine type option
Date: Mon, 18 Aug 2025 17:42:54 -0400
Message-ID: <20250818214323.529501-2-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818214323.529501-1-zycai@linux.ibm.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FcM3xI+6 c=1 sm=1 tr=0 ts=68a39e81 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=51CbwtZII9I6y_JNZ0sA:9
X-Proofpoint-GUID: QY2j_QagQ5pEoA6AvBvmXFj_CNw2-zoT
X-Proofpoint-ORIG-GUID: QY2j_QagQ5pEoA6AvBvmXFj_CNw2-zoT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMSBTYWx0ZWRfXwYnvvY0iu5X/
 QBxPPWaz8auK2hYRoGrw87SOlKMYiepMgeVd+t3kZiZKYC0INvhIWNu57dbKE9i+qCfurdGfG7K
 LRQKt9+dW46RrmCYUvw9DaIAp4uAgiGd+YJPqQxVyGDAHJBm1gyQeSGNM2aHWrZCGTDmrMfPI1F
 to6hd/va5kxfEXIM1mMc86q2mYW52Clb6Tjt/B2+gCtgVSa+v4MS0/qB1jdv2tEiW6Qm41F/CPE
 8rfJWPMrc5npY/PP974mv+5hzzM37hpO9yAA0MWs2mzG4JinGrq+7ywLrytk9iJmP139AfCnQ2e
 Mt6of1Es43PwD5/frOrRdlXmPSpT2BxfdgLIk3tdwIqQtimHaxwqF5X+pJ0ESENwaEpVdguqFSu
 8/cVdxhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160011
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
machine. This allows users to specify one or more certificate file paths
or directories to be used during secure boot.

Each entry is specified using the syntax:
	boot-certs.<index>.path=/path/to/cert.pem

Multiple paths can be specify using array properties:
	boot-certs.0.path=/path/to/cert.pem,
	boot-certs.1.path=/path/to/cert-dir,
	boot-certs.2.path=/path/to/another-dir...

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 docs/system/s390x/secure-ipl.rst   | 20 ++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  2 ++
 qapi/machine-s390x.json            | 24 ++++++++++++++++++++++++
 qemu-options.hx                    |  6 +++++-
 5 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/s390x/secure-ipl.rst

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
new file mode 100644
index 0000000000..9b3fd25cc4
--- /dev/null
+++ b/docs/system/s390x/secure-ipl.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Secure IPL Command Line Options
+===============================
+
+New parameters have been introduced to s390-ccw-virtio machine type option
+to support secure IPL. These parameters allow users to provide certificates
+and enable secure IPL directly via the command line.
+
+Providing Certificates
+----------------------
+
+The certificate store can be populated by supplying a list of certificate file
+paths or directories on the command-line:
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio, \
+                               boot-certs.0.path=/.../qemu/certs, \
+                               boot-certs.1.path=/another/path/cert.pem ...
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c294106a74..9ac425c695 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -45,6 +45,7 @@
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
+#include "qapi/qapi-visit-machine-s390x.h"
 #include "hw/s390x/cpu-topology.h"
 #include "kvm/kvm_s390x.h"
 #include "hw/virtio/virtio-md-pci.h"
@@ -798,6 +799,30 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     g_free(val);
 }
 
+static void machine_get_boot_certs(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+    BootCertPathList **certs = &ms->boot_certs;
+
+    visit_type_BootCertPathList(v, name, certs, errp);
+}
+
+static void machine_set_boot_certs(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+    BootCertPathList *cert_list = NULL;
+
+    visit_type_BootCertPathList(v, name, &cert_list, errp);
+    if (!cert_list) {
+        return;
+    }
+
+    ms->boot_certs = cert_list;
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -851,6 +876,11 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
             "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
             " to upper case) to pass to machine loader, boot manager,"
             " and guest kernel");
+
+    object_class_property_add(oc, "boot-certs", "BootCertPath",
+                              machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
+    object_class_property_set_description(oc, "boot-certs",
+            "provide paths to a directory and/or a certificate file for secure boot");
 }
 
 static inline void s390_machine_initfn(Object *obj)
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 526078a4e2..b90949355c 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -14,6 +14,7 @@
 #include "hw/boards.h"
 #include "qom/object.h"
 #include "hw/s390x/sclp.h"
+#include "qapi/qapi-types-machine-s390x.h"
 
 #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
 
@@ -31,6 +32,7 @@ struct S390CcwMachineState {
     uint8_t loadparm[8];
     uint64_t memory_limit;
     uint64_t max_pagesize;
+    BootCertPathList *boot_certs;
 
     SCLPDevice *sclp;
 };
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index 966dbd61d2..3e89ef8320 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -119,3 +119,27 @@
 { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
   'features': [ 'unstable' ]
 }
+
+##
+# @BootCertPath:
+#
+# Boot certificate path.
+#
+# @path: path of certificate(s)
+#
+# Since: 10.1
+##
+{ 'struct': 'BootCertPath',
+  'data': {'path': 'str'} }
+
+##
+# @BootCerts:
+#
+# List of boot certificate paths.
+#
+# @boot-certs: List of BootCertPath
+#
+# Since: 10.1
+##
+{ 'struct': 'BootCerts',
+  'data': {'boot-certs': ['BootCertPath'] } }
diff --git a/qemu-options.hx b/qemu-options.hx
index ab23f14d21..ac497eb3a0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -44,7 +44,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
 #endif
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
-    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
+    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
+    "                boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file provides paths to a directory and/or a certificate file\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -205,6 +206,9 @@ SRST
         ::
 
             -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
+
+    ``boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file``
+        Provide paths to a directory and/or a certificate file on the host [s390x only].
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.50.1


