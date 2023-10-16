Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76C7CB2D2
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 20:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsSXP-0007zk-JH; Mon, 16 Oct 2023 14:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qsSWp-0007nb-VL; Mon, 16 Oct 2023 14:41:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qsSWh-0006I4-Kb; Mon, 16 Oct 2023 14:41:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GI2Pbe007849; Mon, 16 Oct 2023 18:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bCWJWvWjSSEbanP+ISvj3oSdzpYsYPBc618OCDILuK4=;
 b=TJs5lUbu+J3nl89HxXngm3UsjHrROryQMwYsWhiIuZXIRedrNA/UdVYApig2JfqzbslW
 fczrfgb2TRzk4E9ED0IXHVCMbQ1iir7rMKd1W2boXsyKeyP5BY4fC6Ks/gN4vUjO7WMZ
 Y6O1KBcIRBC4ojTMEPKA8cvlpKDDf7IGYVYqNofiAx4juh38XIW0FNsNkBY11bi2uU02
 qrgJOObYkfdWMeiiPaetrhtiRFhSd543t6sSPmVh4e3PGDoLSeZ/Auv7lZ+8wf5SwTbw
 4QPmTZib3Pk+FkMG3dMKPhW1A5o5mEZjkZr+UKNd4y4OUWkdWtJlEtRDA17Kv0t4KbN9 Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsa3th6jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:40:30 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GIaVds010603;
 Mon, 16 Oct 2023 18:40:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsa3th56a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:40:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GIFDPu027177; Mon, 16 Oct 2023 18:39:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tk2mhx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 18:39:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39GIdRTa8323614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 18:39:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3795320040;
 Mon, 16 Oct 2023 18:39:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C73702004E;
 Mon, 16 Oct 2023 18:39:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:39:26 +0000 (GMT)
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
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v26 01/21] qapi: machine.json: change docs regarding CPU
 topology
Date: Mon, 16 Oct 2023 20:39:05 +0200
Message-Id: <20231016183925.2384704-2-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016183925.2384704-1-nsg@linux.ibm.com>
References: <20231016183925.2384704-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bSnaRR3PNi3w5z6m3WEw5dcHdJp8ZNIJ
X-Proofpoint-GUID: wMpNHVtMMQ64zp9hmAO-biaRllr7EoWL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Clarify roles of different architectures.
Also change things a bit in anticipation of additional members being
added.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 qapi/machine.json | 58 +++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a08b6576ca..058e884fd2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -71,8 +71,8 @@
 #
 # @thread-id: ID of the underlying host thread
 #
-# @props: properties describing to which node/socket/core/thread
-#     virtual CPU belongs to, provided if supported by board
+# @props: properties of type CpuInstanceProperties associated with a
+#     virtual CPU, e.g. the socket id
 #
 # @target: the QEMU system emulation target, which determines which
 #     additional fields will be listed (since 3.0)
@@ -899,28 +899,34 @@
 # should be passed by management with device_add command when a CPU is
 # being hotplugged.
 #
+# Which members are optional and which mandatory depends on the
+# architecture and board.
+#
+# The ids other than the node-id specify the position of the CPU
+# within the CPU topology as defined by @SMPConfiguration.
+#
 # @node-id: NUMA node ID the CPU belongs to
 #
-# @socket-id: socket number within node/board the CPU belongs to
+# @socket-id: socket number within CPU topology the CPU belongs to
 #
-# @die-id: die number within socket the CPU belongs to (since 4.1)
+# @die-id: die number within the parent container the CPU belongs to
+#    (since 4.1)
 #
-# @cluster-id: cluster number within die the CPU belongs to (since
-#     7.1)
+# @cluster-id: cluster number within the parent container the CPU
+#     belongs to (since 7.1)
 #
-# @core-id: core number within cluster the CPU belongs to
+# @core-id: core number within the parent container the CPU
+#     belongs to
 #
-# @thread-id: thread number within core the CPU belongs to
+# @thread-id: thread number within the core the CPU  belongs to
 #
-# Note: currently there are 6 properties that could be present but
-#     management should be prepared to pass through other properties
-#     with device_add command to allow for future interface extension.
-#     This also requires the filed names to be kept in sync with the
-#     properties passed to -device/device_add.
+# Note: management should be prepared to pass through additional
+#     properties with device_add.
 #
 # Since: 2.7
 ##
 { 'struct': 'CpuInstanceProperties',
+  # Keep these in sync with the properties device_add accepts
   'data': { '*node-id': 'int',
             '*socket-id': 'int',
             '*die-id': 'int',
@@ -1478,21 +1484,33 @@
 # Schema for CPU topology configuration.  A missing value lets QEMU
 # figure out a suitable value based on the ones that are provided.
 #
+# The members other than @cpus and @maxcpus define topology
+# containers.
+#
+# The ordering from highest/coarsest to lowest/finest is:
+# @sockets, @dies, @clusters, @cores, @threads.
+#
+# Different architectures support different subsets of topology
+# containers.
+#
+# For examples, s390x does not have clusters and dies, the socket
+# is the parent container of cores.
+#
 # @cpus: number of virtual CPUs in the virtual machine
 #
+# @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
+#     machine
+#
 # @sockets: number of sockets in the CPU topology
 #
-# @dies: number of dies per socket in the CPU topology
+# @dies: number of dies per parent container
 #
-# @clusters: number of clusters per die in the CPU topology (since
+# @clusters: number of clusters per parent container (since
 #     7.0)
 #
-# @cores: number of cores per cluster in the CPU topology
+# @cores: number of cores per parent container
 #
-# @threads: number of threads per core in the CPU topology
-#
-# @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
-#     machine
+# @threads: number of threads per core
 #
 # Since: 6.1
 ##
-- 
2.39.2


