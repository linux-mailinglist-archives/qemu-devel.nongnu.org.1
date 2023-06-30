Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A86374434F
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 22:38:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFKs9-0008RD-Ox; Fri, 30 Jun 2023 16:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFKs2-0008QD-Qf
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 16:37:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFKrz-0006J1-DK
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 16:37:33 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UKWlKI022943; Fri, 30 Jun 2023 20:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9/m69YA6tsH4LPx4k8XYv1WB8IOJfs+3yhdBZmaA/tQ=;
 b=Q70W4yX2G8rx5TXOZ6HxHGyOVlGZyGnYfOtPvcBWw0ZP6poVZg4SDERlSZuzv0mFyAeJ
 ZqK+JcciAJg9MtKukjWEVyPIn/eoBHELcTwkrahTOq9SupFsxJCzL7xGPsBdJe0DYi0S
 tT4dNJcRuNLcQ5wmmbFKhO9dsI8UIYvmIJkRhTq75ggff5u8MatrH+jteI1QYoj+nJo8
 EbE1ET4dvXHbS2V0JLitHl7CqAdIYhyBUCH3PKKKtc5RJEYvE3mtGGCEf5uVxQyG0QWm
 uvraW7p/hEkZfEB4LnXAY0b5rVpWR/N0g9ZsyLSd8soa9uEX8tcUs/BqekrCprr0X4oB yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj66b83hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:29 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UKWn0j022957;
 Fri, 30 Jun 2023 20:37:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj66b83hb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UJGgI1019375;
 Fri, 30 Jun 2023 20:37:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre4e4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UKbOlj22676060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 20:37:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C58BB20043;
 Fri, 30 Jun 2023 20:37:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3082B20040;
 Fri, 30 Jun 2023 20:37:24 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.8.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 20:37:24 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/4] target: Make qemu_softmmu_page_mask() available for *-user
Date: Fri, 30 Jun 2023 22:36:38 +0200
Message-ID: <20230630203720.528552-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630203720.528552-1-iii@linux.ibm.com>
References: <20230630203720.528552-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H-fSV6UJK-5dXxzFY6MWNr4YavwGVD7_
X-Proofpoint-ORIG-GUID: 65rlFil5-teaY4OSP7UHw8l9WYUeUA12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300179
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Currently qemu_softmmu_page_mask() is usable only from the softmmu
code. Make it possible to use it from the *-user code as wel.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 softmmu/physmem.c      | 5 -----
 target/meson.build     | 2 ++
 target/target-common.c | 9 +++++++++
 3 files changed, 11 insertions(+), 5 deletions(-)
 create mode 100644 target/target-common.c

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index bda475a719d..6bdd944fe88 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3359,11 +3359,6 @@ size_t qemu_target_page_size(void)
     return TARGET_PAGE_SIZE;
 }
 
-int qemu_target_page_mask(void)
-{
-    return TARGET_PAGE_MASK;
-}
-
 int qemu_target_page_bits(void)
 {
     return TARGET_PAGE_BITS;
diff --git a/target/meson.build b/target/meson.build
index a53a60486fc..dee2ac47e02 100644
--- a/target/meson.build
+++ b/target/meson.build
@@ -19,3 +19,5 @@ subdir('sh4')
 subdir('sparc')
 subdir('tricore')
 subdir('xtensa')
+
+specific_ss.add(files('target-common.c'))
diff --git a/target/target-common.c b/target/target-common.c
new file mode 100644
index 00000000000..6868a1f490f
--- /dev/null
+++ b/target/target-common.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+
+#include "exec/exec-all.h"
+
+int qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
-- 
2.41.0


