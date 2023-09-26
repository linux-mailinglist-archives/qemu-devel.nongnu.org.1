Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC67AEC7E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:21:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql70G-0001Q4-GX; Tue, 26 Sep 2023 08:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6zs-0000qO-Pp; Tue, 26 Sep 2023 08:17:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6zr-0001fJ-5f; Tue, 26 Sep 2023 08:17:00 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QBkTJ4000350; Tue, 26 Sep 2023 12:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KG6WG9U7vSYM5utSLw1CHcL7D3RABYZ5UnyYhJFc8qY=;
 b=qFJH0VBpfyhQWF7a0lHkeEMy89uLiJzmfGDGpJVKkO0bNYeef8PdYjVgoxypkNpfe/fa
 Mgvvc+hRp7FXW68qczpGg2FMdlfTTUlatHsO3+HiAn5h9yR134cBo7KkwEyANQx43Wtl
 1OD6ZKxB81OufXLB+Fyuimq/0MwbhDvzdtY/eNwrp4X/kH1MoEcg6cFk8H535xHcPwF0
 cBOxflQhC/0vouZbl3f47Bi/rVzN+AWM5fHW13MeWBXCHertdntB+mARUxGUD3SJd7x5
 0WVTPVqfjAjVusERuL2MKcXJ2YGmpQN8AMyz4m2N1zG+qkei1ZbHbjcGfLw6LQ+D8BIF PA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbpfrmv10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:16:46 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QBtxKO002155;
 Tue, 26 Sep 2023 12:16:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbpfrmv05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:16:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38Q9vEfR011032; Tue, 26 Sep 2023 12:15:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukb4xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38QCFmSC14221840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 12:15:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76CD02004B;
 Tue, 26 Sep 2023 12:15:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D2972004E;
 Tue, 26 Sep 2023 12:15:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Sep 2023 12:15:47 +0000 (GMT)
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
Subject: [PATCH v24 01/21] qapi: machine.json: change docs regarding
 CpuInstanceProperties
Date: Tue, 26 Sep 2023 14:15:14 +0200
Message-Id: <20230926121534.406035-2-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926121534.406035-1-nsg@linux.ibm.com>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mSUPSHWlWiovai1gDmZWMdEvK45S2oPG
X-Proofpoint-ORIG-GUID: -PzPq1QfJ3ZVCOMZixoWqNKHbfhn421z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309260104
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

Clarify roles of different architectures.
Also change things a bit in anticipation of additional members being
added.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---


Reference to s390x docs added in patch 14


 qapi/machine.json | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a08b6576ca..3c074c9902 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -70,9 +70,9 @@
 # @qom-path: path to the CPU object in the QOM tree
 #
 # @thread-id: ID of the underlying host thread
-#
-# @props: properties describing to which node/socket/core/thread
-#     virtual CPU belongs to, provided if supported by board
+
+# @props: properties of type CpuInstanceProperties associated with a
+#     virtual CPU, e.g. the socket id
 #
 # @target: the QEMU system emulation target, which determines which
 #     additional fields will be listed (since 3.0)
@@ -899,6 +899,9 @@
 # should be passed by management with device_add command when a CPU is
 # being hotplugged.
 #
+# Which members are optional and which mandatory depends on the architecture
+# and board.
+#
 # @node-id: NUMA node ID the CPU belongs to
 #
 # @socket-id: socket number within node/board the CPU belongs to
@@ -912,15 +915,13 @@
 #
 # @thread-id: thread number within core the CPU belongs to
 #
-# Note: currently there are 6 properties that could be present but
-#     management should be prepared to pass through other properties
-#     with device_add command to allow for future interface extension.
-#     This also requires the filed names to be kept in sync with the
-#     properties passed to -device/device_add.
+# Note: management should be prepared to pass through additional
+# properties with device_add.
 #
 # Since: 2.7
 ##
 { 'struct': 'CpuInstanceProperties',
+  # Keep these in sync with the properties device_add accepts
   'data': { '*node-id': 'int',
             '*socket-id': 'int',
             '*die-id': 'int',
-- 
2.39.2


