Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 425447E1D62
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:42:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzw7K-00026i-S0; Mon, 06 Nov 2023 04:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzw73-00025Q-VY; Mon, 06 Nov 2023 04:41:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzw6o-0005zW-SM; Mon, 06 Nov 2023 04:41:40 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A69ewhd024839; Mon, 6 Nov 2023 09:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yOIUhHzI9nzDh2Hm0kTcVeqra+o9mo20Grsi+CAGyks=;
 b=FZ4ieTdiBC9T3Qaz41eXm3teNWCNKWsuMIbLXkL0U9IRSPP9eaHz8QVfyDBBiZeZPes0
 /vLflvXZWXU7gBT0L/oJVZsqVDcY/oWpR+iO9kMZx8iYA9pupxonPbX7k91mNxRc7vJQ
 q4t6r6cyjce6mrQzEc+uexNd1cZ4WjPEoePlsKawIvzY3kN9uFL13K1UG+OozaZ0neHR
 5O78P4YdFV3a16lvbYCNK7c9echJPx5iNYxQeynFDbpCw2n/RJnEdEN+XW5MQRIz0A3e
 rqRiOfvQrMk4P7j14eICwZcmjUjOFbyCe0h8S+5VNmXqmwK8bVC6JmR6Uzf28Cc57Lhc 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6v2caym4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:41:19 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A69fGkn025807;
 Mon, 6 Nov 2023 09:41:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6v2caxtr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:41:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A67kXVk007908; Mon, 6 Nov 2023 09:36:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u60ny8evn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:36:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A69aMYH43909536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Nov 2023 09:36:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B781820043;
 Mon,  6 Nov 2023 09:36:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36F2B20040;
 Mon,  6 Nov 2023 09:36:22 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.47.192])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Nov 2023 09:36:22 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 5/5] tests/tcg/s390x: Test ADD LOGICAL WITH CARRY
Date: Mon,  6 Nov 2023 10:31:26 +0100
Message-ID: <20231106093605.1349201-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106093605.1349201-1-iii@linux.ibm.com>
References: <20231106093605.1349201-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k-Yf5doqPBw_WMXLyanVVvgFeeb-on5r
X-Proofpoint-ORIG-GUID: LAnIbMAnXiXglLAI-Ht__SWBZxG0e6M6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add a test that tries different combinations of ADD LOGICAL WITH
CARRY instructions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target          |   1 +
 tests/tcg/s390x/add-logical-with-carry.c | 156 +++++++++++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 tests/tcg/s390x/add-logical-with-carry.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index a476547b659..0e670f3f8b9 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -43,6 +43,7 @@ TESTS+=cgebra
 TESTS+=clgebr
 TESTS+=clc
 TESTS+=laalg
+TESTS+=add-logical-with-carry
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/add-logical-with-carry.c b/tests/tcg/s390x/add-logical-with-carry.c
new file mode 100644
index 00000000000..d982f8a651b
--- /dev/null
+++ b/tests/tcg/s390x/add-logical-with-carry.c
@@ -0,0 +1,156 @@
+/*
+ * Test ADD LOGICAL WITH CARRY instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdio.h>
+#include <stdlib.h>
+
+static const struct test {
+    const char *name;
+    unsigned long values[3];
+    unsigned long exp_sum;
+    int exp_cc;
+} tests[] = {
+    /*
+     * Each test starts with CC 0 and executes two chained ADD LOGICAL WITH
+     * CARRY instructions on three input values. The values must be compatible
+     * with both 32- and 64-bit test functions.
+     */
+
+    /* NAME       VALUES       EXP_SUM EXP_CC */
+    { "cc0->cc0", {0, 0, 0},   0,      0, },
+    { "cc0->cc1", {0, 0, 42},  42,     1, },
+    /* cc0->cc2 is not possible */
+    /* cc0->cc3 is not possible */
+    /* cc1->cc0 is not possible */
+    { "cc1->cc1", {-3, 1, 1},  -1,     1, },
+    { "cc1->cc2", {-3, 1, 2},  0,      2, },
+    { "cc1->cc3", {-3, 1, -1}, -3,     3, },
+    /* cc2->cc0 is not possible */
+    { "cc2->cc1", {-1, 1, 1},  2,      1, },
+    { "cc2->cc2", {-1, 1, -1}, 0,      2, },
+    /* cc2->cc3 is not possible */
+    /* cc3->cc0 is not possible */
+    { "cc3->cc1", {-1, 2, 1},  3,      1, },
+    { "cc3->cc2", {-1, 2, -2}, 0,      2, },
+    { "cc3->cc3", {-1, 2, -1}, 1,      3, },
+};
+
+/* Test ALCR (register variant) followed by ALC (memory variant). */
+static unsigned long test32rm(unsigned long a, unsigned long b,
+                              unsigned long c, int *cc)
+{
+    unsigned int a32 = a, b32 = b, c32 = c;
+
+    asm("xr %[cc],%[cc]\n"
+        "alcr %[a],%[b]\n"
+        "alc %[a],%[c]\n"
+        "ipm %[cc]"
+        : [a] "+&r" (a32), [cc] "+&r" (*cc)
+        : [b] "r" (b32), [c] "T" (c32)
+        : "cc");
+    *cc >>= 28;
+
+    return (int)a32;
+}
+
+/* Test ALC (memory variant) followed by ALCR (register variant). */
+static unsigned long test32mr(unsigned long a, unsigned long b,
+                              unsigned long c, int *cc)
+{
+    unsigned int a32 = a, b32 = b, c32 = c;
+
+    asm("xr %[cc],%[cc]\n"
+        "alc %[a],%[b]\n"
+        "alcr %[c],%[a]\n"
+        "ipm %[cc]"
+        : [a] "+&r" (a32), [c] "+&r" (c32), [cc] "+&r" (*cc)
+        : [b] "T" (b32)
+        : "cc");
+    *cc >>= 28;
+
+    return (int)c32;
+}
+
+/* Test ALCGR (register variant) followed by ALCG (memory variant). */
+static unsigned long test64rm(unsigned long a, unsigned long b,
+                              unsigned long c, int *cc)
+{
+    asm("xr %[cc],%[cc]\n"
+        "alcgr %[a],%[b]\n"
+        "alcg %[a],%[c]\n"
+        "ipm %[cc]"
+        : [a] "+&r" (a), [cc] "+&r" (*cc)
+        : [b] "r" (b), [c] "T" (c)
+        : "cc");
+    *cc >>= 28;
+    return a;
+}
+
+/* Test ALCG (memory variant) followed by ALCGR (register variant). */
+static unsigned long test64mr(unsigned long a, unsigned long b,
+                              unsigned long c, int *cc)
+{
+    asm("xr %[cc],%[cc]\n"
+        "alcg %[a],%[b]\n"
+        "alcgr %[c],%[a]\n"
+        "ipm %[cc]"
+        : [a] "+&r" (a), [c] "+&r" (c), [cc] "+&r" (*cc)
+        : [b] "T" (b)
+        : "cc");
+    *cc >>= 28;
+    return c;
+}
+
+static const struct test_func {
+    const char *name;
+    unsigned long (*ptr)(unsigned long, unsigned long, unsigned long, int *);
+} test_funcs[] = {
+    { "test32rm", test32rm },
+    { "test32mr", test32mr },
+    { "test64rm", test64rm },
+    { "test64mr", test64mr },
+};
+
+static const struct test_perm {
+    const char *name;
+    size_t a_idx, b_idx, c_idx;
+} test_perms[] = {
+    { "a, b, c", 0, 1, 2 },
+    { "b, a, c", 1, 0, 2 },
+};
+
+int main(void)
+{
+    unsigned long a, b, c, sum;
+    int result = EXIT_SUCCESS;
+    const struct test_func *f;
+    const struct test_perm *p;
+    size_t i, j, k;
+    const struct test *t;
+    int cc;
+
+    for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+        t = &tests[i];
+        for (j = 0; j < sizeof(test_funcs) / sizeof(test_funcs[0]); j++) {
+            f = &test_funcs[j];
+            for (k = 0; k < sizeof(test_perms) / sizeof(test_perms[0]); k++) {
+                p = &test_perms[k];
+                a = t->values[p->a_idx];
+                b = t->values[p->b_idx];
+                c = t->values[p->c_idx];
+                sum = f->ptr(a, b, c, &cc);
+                if (sum != t->exp_sum || cc != t->exp_cc) {
+                    fprintf(stderr,
+                            "[  FAILED  ] %s %s(0x%lx, 0x%lx, 0x%lx) returned 0x%lx cc %d, expected 0x%lx cc %d\n",
+                            t->name, f->name, a, b, c, sum, cc,
+                            t->exp_sum, t->exp_cc);
+                    result = EXIT_FAILURE;
+                }
+            }
+        }
+    }
+
+    return result;
+}
-- 
2.41.0


