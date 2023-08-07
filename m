Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB157723CD
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 14:23:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSzFk-0006de-JM; Mon, 07 Aug 2023 08:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qSzFh-0006cq-RJ
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 08:22:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qSzFf-0005lm-NF
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 08:22:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 377CBGEd012983; Mon, 7 Aug 2023 12:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=7QXR2BYgJtHqQnHIQX/arggfEdx6tPUL0lOOPQZj3Ro=;
 b=fbMoNMohzizEY9FFbwjhk9aD3phchNh9bWENatkoTBceivsSP/0cyjL6n0ZAgKYsCj+A
 NrzRTWW+Z/PKtOJxFR66ati2y3h5QNZvn+RVeVK3Dv+Tiw3WrQBMiGIZoZIcYbGCImcV
 uD8UbHVxN8yfyJ06oprTXoe+ifSTI/DcYYE6WdLNu014lbZ+TldxNDQ7TkW1AlaCy9QV
 gSMuPDyFtTXySw8c1abEt+PwQ7lYguxhQx4yT3KbEQNSrqrL4azxDCnc7wXUNDQs5sPZ
 QBZxsdl2/Uxtn7SXDcoXXAF4aXX7CyhKFwCA/bK2NiTCMzC2biWGAQYvkoQX0YOcSaB9 eg== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb01x8u14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 12:22:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 377BABCv000363; Mon, 7 Aug 2023 12:22:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28k4sgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 12:22:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 377CMHTV15663626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 12:22:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC21520043;
 Mon,  7 Aug 2023 12:22:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A6B820040;
 Mon,  7 Aug 2023 12:22:17 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 12:22:17 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] linux-user: Emulate the Anonymous: keyword in
 /proc/self/smaps
Date: Mon,  7 Aug 2023 14:20:46 +0200
Message-ID: <20230807122206.655701-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 37L8j9V1Bz2C_3Mn7QkBtojt5dT5i-Sj
X-Proofpoint-GUID: 37L8j9V1Bz2C_3Mn7QkBtojt5dT5i-Sj
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_11,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070111
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

Core dumps produced by gdb's gcore when connected to qemu's gdbstub
lack stack. The reason is that gdb includes only anonymous memory in
core dumps, which is distinguished by a non-0 Anonymous: value.

Consider the mappings with PAGE_ANON fully anonymous, and the mappings
without it fully non-anonymous.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00848.html
v1 -> v2: Fix a build issue when TARGET_VSYSCALL_PAGE is set.

 linux-user/syscall.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7c2c2f6e2fa..3dd493486f6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8037,7 +8037,7 @@ static int open_self_cmdline(CPUArchState *cpu_env, int fd)
     return 0;
 }
 
-static void show_smaps(int fd, unsigned long size)
+static void show_smaps(int fd, unsigned long size, int flags)
 {
     unsigned long page_size_kb = TARGET_PAGE_SIZE >> 10;
     unsigned long size_kb = size >> 10;
@@ -8053,7 +8053,7 @@ static void show_smaps(int fd, unsigned long size)
                 "Private_Clean:         0 kB\n"
                 "Private_Dirty:         0 kB\n"
                 "Referenced:            0 kB\n"
-                "Anonymous:             0 kB\n"
+                "Anonymous:             %lu kB\n"
                 "LazyFree:              0 kB\n"
                 "AnonHugePages:         0 kB\n"
                 "ShmemPmdMapped:        0 kB\n"
@@ -8063,7 +8063,9 @@ static void show_smaps(int fd, unsigned long size)
                 "Swap:                  0 kB\n"
                 "SwapPss:               0 kB\n"
                 "Locked:                0 kB\n"
-                "THPeligible:    0\n", size_kb, page_size_kb, page_size_kb);
+                "THPeligible:    0\n",
+            size_kb, page_size_kb, page_size_kb,
+            (flags & PAGE_ANON) ? size_kb : 0);
 }
 
 static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
@@ -8114,7 +8116,7 @@ static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
                 dprintf(fd, "\n");
             }
             if (smaps) {
-                show_smaps(fd, max - min);
+                show_smaps(fd, max - min, flags);
                 dprintf(fd, "VmFlags:%s%s%s%s%s%s%s%s\n",
                         (flags & PAGE_READ) ? " rd" : "",
                         (flags & PAGE_WRITE_ORG) ? " wr" : "",
@@ -8140,7 +8142,7 @@ static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
                     TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
     dprintf(fd, "%*s%s\n", 73 - count, "",  "[vsyscall]");
     if (smaps) {
-        show_smaps(fd, TARGET_PAGE_SIZE);
+        show_smaps(fd, TARGET_PAGE_SIZE, PAGE_EXEC);
         dprintf(fd, "VmFlags: ex\n");
     }
 #endif
-- 
2.41.0


