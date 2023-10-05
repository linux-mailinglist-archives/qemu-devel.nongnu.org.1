Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06F7BA746
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRmV-0006ba-Jj; Thu, 05 Oct 2023 13:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoRmM-0006TF-AO; Thu, 05 Oct 2023 13:04:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoRmK-0001md-QE; Thu, 05 Oct 2023 13:04:50 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395GoSIg002952; Thu, 5 Oct 2023 17:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/ppLSgZA+DDLbRQlDgnGxo9Uf0CYfDp2ArLptTlgkf0=;
 b=nA/eYsOq/1zM+3jqlYWeU+5vk8jy1Tf2azsghUnWBghzcwrWwJYzhi5iAjcIJZZXMHCY
 fUHF1e2aXECd6eiVo8mjelBetLEuI6bKORGy0qyfoLorhy0yX/xU6WunwXOx6kUr2kaw
 eWNaL4KRxKAxOdSumzNejfRJxwG8NxDLzWmpMxPkucn7hOKKF1KvP4qV+CzM4uHuQ4hx
 lj+dWfmJkrj1YqssnKSp9m8O0XpWIHhCj1/Tw5F/9KJhx/FqxRVQDqfucQqTBb8dqoRY
 eaW3WrYPH4XafjCo+Oeow8RZAhT8SU7KvxZVt2hNvtl42sk6m++wsp/vV8orDqCBdtgd lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj1110u6u-27
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 17:04:40 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395G21UF011552;
 Thu, 5 Oct 2023 16:03:16 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj09s82cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:03:14 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 395FtiYJ010901; Thu, 5 Oct 2023 16:02:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q2cv0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:01:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 395G1v2M38863484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Oct 2023 16:01:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0557920040;
 Thu,  5 Oct 2023 16:01:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B46542004F;
 Thu,  5 Oct 2023 16:01:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Oct 2023 16:01:56 +0000 (GMT)
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
Subject: [PATCH v25 01/21] qapi: machine.json: change docs regarding
 CpuInstanceProperties
Date: Thu,  5 Oct 2023 18:01:35 +0200
Message-Id: <20231005160155.1945588-2-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231005160155.1945588-1-nsg@linux.ibm.com>
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Iw1NbRqmRqa5QnZil2pDS6KPS4Nz_Spi
X-Proofpoint-ORIG-GUID: CbQUGcnATEcuVk8WC8_TxDxdORWIUFnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_12,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050132
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
 qapi/machine.json | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a08b6576ca..40b835e28e 100644
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


