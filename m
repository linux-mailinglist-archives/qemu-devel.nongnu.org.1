Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6E2809757
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 01:39:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBOse-0003eA-Tz; Thu, 07 Dec 2023 19:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rBOsb-0003dK-Vx
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 19:38:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rBOsa-0000Tp-3H
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 19:38:09 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B80bbCT013812; Fri, 8 Dec 2023 00:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=my8IegMkKWlcQ92p93pdywwAXnzi/vZ26iWduq+C6BU=;
 b=fiuNsQGx6WtziPOqHyCYQ9aw3FDSD6Y7eHtgsZF4KMjGyhDcCZBnLgDzLwUYrV5Zc3Wm
 QouSdtngvT/KJgykN/SGELSNG+nmK6h2Z6+goJXKSuvLfT+x4Eaw7vsZV7jiDwNJPaYa
 mbA3/bxd0AOpSDCesosqdiuBsXcrQeNAXFhtmVBzXCbr4rCFyhPyvr5LzE+KYGe5bek4
 xp+BuZqzhhFnXf/b2Cxk1+YtnStKnax97pQ59RrHcSNKg9FoYQBpQzkgTqh1zH8OK8HP
 V7BnvV28RcMSZ8wJM6hC+pRd1PKJ3i+E1axXASI7LoG0fdNWlStjXzixzpBzx6HtAmKM QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uurrsr07b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:04 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B80c4cY016038;
 Fri, 8 Dec 2023 00:38:04 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uurrsr073-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:04 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7Mp3Eu004735; Fri, 8 Dec 2023 00:38:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav4pn6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B80c1hX16712320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Dec 2023 00:38:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7796620040;
 Fri,  8 Dec 2023 00:38:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8C1920043;
 Fri,  8 Dec 2023 00:37:59 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.26])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Dec 2023 00:37:59 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 1/4] target: Make qemu_target_page_mask() available for
 *-user
Date: Fri,  8 Dec 2023 01:35:33 +0100
Message-ID: <20231208003754.3688038-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208003754.3688038-1-iii@linux.ibm.com>
References: <20231208003754.3688038-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8zjH0HAcorgonSV8gXSlMHDnOIfuApNL
X-Proofpoint-ORIG-GUID: 2hyfbq1bFmGVysX8Osfa9mrg1mOdfihf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_19,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080003
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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
 accel/tcg/perf.c       |  3 ++-
 system/physmem.c       |  5 -----
 target/meson.build     |  2 ++
 target/target-common.c | 10 ++++++++++
 4 files changed, 14 insertions(+), 6 deletions(-)
 create mode 100644 target/target-common.c

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index cd1aa99a7ee..ba75c1bbe45 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "elf.h"
+#include "exec/target_page.h"
 #include "exec/exec-all.h"
 #include "qemu/timer.h"
 #include "tcg/tcg.h"
@@ -335,7 +336,7 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         /* FIXME: This replicates the restore_state_to_opc() logic. */
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
-            q[insn].address |= (guest_pc & TARGET_PAGE_MASK);
+            q[insn].address |= (guest_pc & qemu_target_page_mask());
         } else {
 #if defined(TARGET_I386)
             q[insn].address -= tb->cs_base;
diff --git a/system/physmem.c b/system/physmem.c
index a63853a7bc9..7cf4a735c3b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3431,11 +3431,6 @@ size_t qemu_target_page_size(void)
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
index 00000000000..903b10cfe4b
--- /dev/null
+++ b/target/target-common.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "exec/target_page.h"
+
+int qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
-- 
2.43.0


