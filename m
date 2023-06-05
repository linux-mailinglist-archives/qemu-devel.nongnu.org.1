Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B67224D5
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:43:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68bs-0002R5-F7; Mon, 05 Jun 2023 07:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q68am-000293-7b
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:41:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q68ak-0001w9-BA
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:41:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 355B5Bso029643; Mon, 5 Jun 2023 11:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9J0STkllkCKubMz8qToQoNAhrz6iFSS4N2n+CRq2jnQ=;
 b=jWjn6CAFuednjq5/Dm5aaPnTC4LmOxrzXXOJAz6fAjIbYaJRdaPdMEPexSAPzPWlbWs/
 4apRSYF4SJVvXLAZSGQN+YDiBesqDjdNnws/YvU1FvHz9dZhlbXEvJk9i9Nn0/5XGLYt
 UrT9VoNnpjEHuzVs6qqczNkeBoYtrIHX4EXePP3OXNe8rGSs1vBF1IT73vS6nmxR6u6z
 oe6ZFyc86GoE4ZQfsw63AANQ3Dwto4BWB8SwXImgwwcWpouNDm6TK2uVocUERD6P0rAK
 e2kRSQ0IpUdKnqCHDJqiXfbulmab3pNi3qbKdLI/PhaCkFkJ8AvDszZFr9IHr894Ylig bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1ear8yfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:41:40 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355BP0HX008114;
 Mon, 5 Jun 2023 11:41:40 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1ear8yf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:41:40 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 355AgCaj027548;
 Mon, 5 Jun 2023 11:41:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qyxdf91jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:41:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 355BfaIw8651430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jun 2023 11:41:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4392120043;
 Mon,  5 Jun 2023 11:41:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1197C20040;
 Mon,  5 Jun 2023 11:41:36 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.184])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jun 2023 11:41:36 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] accel/tcg: Unmap perf_marker
Date: Mon,  5 Jun 2023 13:41:34 +0200
Message-Id: <20230605114134.1169974-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tNat5HzhOq9c4qj_l9Za5xKt_OIDqpex
X-Proofpoint-ORIG-GUID: d4tp8cIGGJ0ooOnb5i_ugymwba25TsxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=978 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306050103
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

Coverity complains that perf_marker is never unmapped. Fix by unmapping
it in perf_exit().

Fixes: Coverity CID 1507929
Fixes: 5584e2dbe8c9 ("tcg: add perfmap and jitdump")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/perf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index 65e35ea3b93..d1c3db10eda 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -111,6 +111,8 @@ static void write_perfmap_entry(const void *start, size_t insn,
 }
 
 static FILE *jitdump;
+static size_t perf_marker_size;
+static void *perf_marker = MAP_FAILED;
 
 #define JITHEADER_MAGIC 0x4A695444
 #define JITHEADER_VERSION 1
@@ -190,7 +192,6 @@ void perf_enable_jitdump(void)
 {
     struct jitheader header;
     char jitdump_file[32];
-    void *perf_marker;
 
     if (!use_rt_clock) {
         warn_report("CLOCK_MONOTONIC is not available, proceeding without jitdump");
@@ -210,7 +211,8 @@ void perf_enable_jitdump(void)
      * PERF_RECORD_MMAP or PERF_RECORD_MMAP2 event is of the form jit-%d.dump
      * and will process it as a jitdump file.
      */
-    perf_marker = mmap(NULL, qemu_real_host_page_size(), PROT_READ | PROT_EXEC,
+    perf_marker_size = qemu_real_host_page_size();
+    perf_marker = mmap(NULL, perf_marker_size, PROT_READ | PROT_EXEC,
                        MAP_PRIVATE, fileno(jitdump), 0);
     if (perf_marker == MAP_FAILED) {
         warn_report("Could not map %s: %s, proceeding without jitdump",
@@ -368,6 +370,11 @@ void perf_exit(void)
         perfmap = NULL;
     }
 
+    if (perf_marker != MAP_FAILED) {
+        munmap(perf_marker, perf_marker_size);
+        perf_marker = MAP_FAILED;
+    }
+
     if (jitdump) {
         fclose(jitdump);
         jitdump = NULL;
-- 
2.40.1


