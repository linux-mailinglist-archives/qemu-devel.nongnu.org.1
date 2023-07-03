Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00340746037
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:59:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLwo-0002ri-8X; Mon, 03 Jul 2023 11:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwm-0002rT-Tz; Mon, 03 Jul 2023 11:58:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwl-0004rR-87; Mon, 03 Jul 2023 11:58:40 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363FqHRT012841; Mon, 3 Jul 2023 15:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xKlBYuKMPE8cgZzyV/OsYFXhtjzUlLpDDS46g7oiTsk=;
 b=hgi0hBzksP2ngJb1x75PBOSc0xOiUnYreYGcC/srMAySkNWOiaHFPY7B1QDu24Qp/EgU
 KC1y5PkFsc6WauSJuM00ODWoev37rVZhwlkhmSKY1MhEIm0UwNlsIfynGuopOMgsusbh
 8yCzK5+jkYF2SGhASJRvU1gBm/1OAgpWUHFR/h2UB65Lz5BCFJ7TsZeeMg9C9JuQw5zQ
 vWoazHdHa88uRnUv//kBdJYQDIi4U5kWAMf6zvBoNclQhN3msNOpeLI6hbFN0o8swNTS
 ZYJ+lYFEWtldFG6Myi3Nrv+GRZ1LDO9PsXTs6TR7vLw4cS1tp4k2j8NimrGKi8NbV2IO EA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1bm03k5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:36 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363FqI3i012927;
 Mon, 3 Jul 2023 15:58:35 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1bm03jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:35 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3633xTVE009085;
 Mon, 3 Jul 2023 15:58:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4sddb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 363FwU1d13697786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 15:58:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF3F920043;
 Mon,  3 Jul 2023 15:58:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 870F220040;
 Mon,  3 Jul 2023 15:58:30 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 15:58:30 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 12/12] tests/tcg/s390x: Test MVCRL with a large value in R0
Date: Mon,  3 Jul 2023 17:50:38 +0200
Message-ID: <20230703155801.179167-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703155801.179167-1-iii@linux.ibm.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ghOqyc-wvexD1zbhk6MgtinB0JRugpc-
X-Proofpoint-GUID: Sm9KgzPpdBdSy0hI6olnHvcPIzH8ake_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=867
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030141
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/mie3-mvcrl.c | 46 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/tests/tcg/s390x/mie3-mvcrl.c b/tests/tcg/s390x/mie3-mvcrl.c
index 93c7b0a2903..ec78dd1d493 100644
--- a/tests/tcg/s390x/mie3-mvcrl.c
+++ b/tests/tcg/s390x/mie3-mvcrl.c
@@ -1,29 +1,55 @@
+#include <stdbool.h>
 #include <stdint.h>
+#include <stdlib.h>
 #include <string.h>
 
-
-static inline void mvcrl_8(const char *dst, const char *src)
+static void mvcrl(const char *dst, const char *src, size_t len)
 {
+    register long r0 asm("r0") = len;
+
     asm volatile (
-        "llill %%r0, 8\n"
         ".insn sse, 0xE50A00000000, 0(%[dst]), 0(%[src])"
-        : : [dst] "d" (dst), [src] "d" (src)
-        : "r0", "memory");
+        : : [dst] "d" (dst), [src] "d" (src), "r" (r0)
+        : "memory");
 }
 
-
-int main(int argc, char *argv[])
+static bool test(void)
 {
     const char *alpha = "abcdefghijklmnop";
 
     /* array missing 'i' */
-    char tstr[17] = "abcdefghjklmnop\0" ;
+    char tstr[17] = "abcdefghjklmnop\0";
 
     /* mvcrl reference use: 'open a hole in an array' */
-    mvcrl_8(tstr + 9, tstr + 8);
+    mvcrl(tstr + 9, tstr + 8, 8);
 
     /* place missing 'i' */
     tstr[8] = 'i';
 
-    return strncmp(alpha, tstr, 16ul);
+    return strncmp(alpha, tstr, 16ul) == 0;
+}
+
+static bool test_bad_r0(void)
+{
+    char src[256];
+
+    /*
+     * PoP says: Bits 32-55 of general register 0 should contain zeros;
+     * otherwise, the program may not operate compatibly in the future.
+     *
+     * Try it anyway in order to check whether this would crash QEMU itself.
+     */
+    mvcrl(src, src, (size_t)-1);
+
+    return true;
+}
+
+int main(void)
+{
+    bool ok = true;
+
+    ok &= test();
+    ok &= test_bad_r0();
+
+    return ok ? EXIT_SUCCESS : EXIT_FAILURE;
 }
-- 
2.41.0


