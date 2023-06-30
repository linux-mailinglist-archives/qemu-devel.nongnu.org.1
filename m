Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4526743811
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:19:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAGr-0002KV-Py; Fri, 30 Jun 2023 05:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qFAGq-0002JZ-Db; Fri, 30 Jun 2023 05:18:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qFAGn-0002Kn-U4; Fri, 30 Jun 2023 05:18:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35U9C0cx027068; Fri, 30 Jun 2023 09:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eaqBbYc9OuxUEUgL1yFTHAtAOUTitq+XgR0fDgvmGBo=;
 b=oUrhQq66k0RkfYbBGAZxA/8NeOijLVt7aZ2BJy+DgxyUqNhoCfHzKEMbEO/Tmh89YczS
 8bku9X1TR6NIy7+cEcFa5AvHkQWGQxeRreK1AaNt4Twg9BTEdxpf4IFXHaGEeohYRcEC
 CdEm+B7a4WAC6rsuDfcZUokTbhgfaZzegrmMyhcKWfRC/Bn1GT/R/nz80p9hcXpgr5X3
 9RyBxDrLVxT7+is837Exj981g1wHDuzyRFOCKS+RDbLmAVNwGw5YlLbLbefjbgbEdKxx
 nLssWiaLo6PSjHX1iEUibJ21pEF+mxeUsJSQr9P48Ricz3j7pRgRQGW+U8ZJYv0N+5pS 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhv72g8cn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:21 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U9FQV4011530;
 Fri, 30 Jun 2023 09:18:20 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhv72g8b0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:20 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U98sEu002456;
 Fri, 30 Jun 2023 09:18:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rdr452yf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35U9IBK261538606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 09:18:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAF4B20043;
 Fri, 30 Jun 2023 09:18:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 843F320040;
 Fri, 30 Jun 2023 09:18:10 +0000 (GMT)
Received: from li-c6ac47cc-293c-11b2-a85c-d421c8e4747b.ibm.com.com (unknown
 [9.171.38.86]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 09:18:10 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, nsg@linux.ibm.com, frankja@linux.ibm.com,
 berrange@redhat.com, clg@kaod.org
Subject: [PATCH v21 12/20] qapi/s390x/cpu topology: query-cpu-polarization qmp
 command
Date: Fri, 30 Jun 2023 11:17:44 +0200
Message-Id: <20230630091752.67190-13-pmorel@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230630091752.67190-1-pmorel@linux.ibm.com>
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KgRQeVnA9l0rLF8osDJpFF4076jBtQ6u
X-Proofpoint-GUID: o5bV3w8MaEZxXz2XcF7GKT2nm-zedxPN
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

The query-cpu-polarization qmp command returns the current
CPU polarization of the machine.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 qapi/machine-target.json | 29 +++++++++++++++++++++++++++++
 hw/s390x/cpu-topology.c  |  8 ++++++++
 2 files changed, 37 insertions(+)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 1362e43983..1e4b8976aa 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -445,3 +445,32 @@
   'features': [ 'unstable' ],
   'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
 }
+
+##
+# @CpuPolarizationInfo:
+#
+# The result of a cpu polarization
+#
+# @polarization: the CPU polarization
+#
+# Since: 8.1
+##
+{ 'struct': 'CpuPolarizationInfo',
+  'data': { 'polarization': 'CpuS390Polarization' },
+  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+}
+
+##
+# @query-cpu-polarization:
+#
+# Features:
+# @unstable: This command may still be modified.
+#
+# Returns: the machine polarization
+#
+# Since: 8.1
+##
+{ 'command': 'query-cpu-polarization', 'returns': 'CpuPolarizationInfo',
+  'features': [ 'unstable' ],
+  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+}
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index 69f31db4af..4f08bdeb2f 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -465,3 +465,11 @@ void qmp_set_cpu_topology(uint16_t core,
                          has_drawer, drawer, has_entitlement, entitlement,
                          has_dedicated, dedicated, errp);
 }
+
+CpuPolarizationInfo *qmp_query_cpu_polarization(Error **errp)
+{
+    CpuPolarizationInfo *info = g_new0(CpuPolarizationInfo, 1);
+
+    info->polarization = s390_topology.polarization;
+    return info;
+}
-- 
2.31.1


