Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D57074455F
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 01:44:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFNlI-0008EF-E2; Fri, 30 Jun 2023 19:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFNlF-0008Dy-SM
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:42:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFNlD-0006hQ-TO
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:42:45 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UNburU025602; Fri, 30 Jun 2023 23:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N1f81vTAGdQ+xQzJx6Y2oqYSZDYwGudfqc/bY/V/JEE=;
 b=HdM9R85LL0LQ8zHfvpyqxJ5V9A2DvTWR+k9V3a7VZLO+lzoJHAMojIGt0k2GzOEHjwds
 kDLbE/21rBXDI87G3swKLQNYrRGZQAmRHzmEOG/RSvbfCe51+NuOp/6z62rX12QopvFW
 4XnMFk2WCtjxUlp/wTesAl5iqGn6in0fBTamPUBMrwgiqvBRT5d11bS+0fA/4HBYttuU
 oMIosZ2I8GSLCRHDAdxZ7ag3/gBRDV2WgzkUvRBfoRoaWSad/at8DYBXIyxYm90sMBDx
 xC+YColo8cs+ehW7VifwvN/90qZJZ9IhIdyDZ+soUrNbV7P1oGQ3fuY8ZeYZjWb6mbN8 tA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj8k58cfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:40 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UNcPif027074;
 Fri, 30 Jun 2023 23:42:40 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj8k58cey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:40 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UJPOxt009577;
 Fri, 30 Jun 2023 23:42:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rdr4538x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UNgZrD40239794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 23:42:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A0E320043;
 Fri, 30 Jun 2023 23:42:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63D8620040;
 Fri, 30 Jun 2023 23:42:34 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.8.31])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 23:42:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/4] target: Make qemu_target_page_mask() available for
 *-user
Date: Sat,  1 Jul 2023 01:40:54 +0200
Message-ID: <20230630234230.596193-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630234230.596193-1-iii@linux.ibm.com>
References: <20230630234230.596193-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bXTlLqS2nkdrsKsMiXVDpfQuE6xBHGE6
X-Proofpoint-ORIG-GUID: rLgSxvKsBD8dq7_-AC8-eaBbMYBO50Ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300206
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

Currently qemu_target_page_mask() is usable only from the softmmu
code. Make it possible to use it from the *-user code as well.

Make use of it in perf.c.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/perf.c       | 2 +-
 softmmu/physmem.c      | 5 -----
 target/meson.build     | 2 ++
 target/target-common.c | 9 +++++++++
 4 files changed, 12 insertions(+), 6 deletions(-)
 create mode 100644 target/target-common.c

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index cd1aa99a7ee..b42742c4c0d 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -335,7 +335,7 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         /* FIXME: This replicates the restore_state_to_opc() logic. */
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
-            q[insn].address |= (guest_pc & TARGET_PAGE_MASK);
+            q[insn].address |= (guest_pc & qemu_target_page_mask());
         } else {
 #if defined(TARGET_I386)
             q[insn].address -= tb->cs_base;
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


