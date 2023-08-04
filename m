Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 310BD770C7E
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 01:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS4UE-000660-OE; Fri, 04 Aug 2023 19:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qS4U3-00065k-9o
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 19:45:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qS4Tz-00018I-EL
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 19:45:25 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 374NgB0g003922; Fri, 4 Aug 2023 23:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qqC73/oapSfUdwgMeWYP2Ek44eO+iMucpgGB25X6t+c=;
 b=PcKA5mzDzp38vZ4t0c0mATv0SXN2sy38HzfD0sISCnB4++jue3Z6jxX1wxzBYfDvoSHY
 542c1/VbrYeqooC6mLnNBkWA+KG/kof+ZMfqI7VcJ0E0Vrr/PwjP1CgXBvo04ztmFhZm
 ISpNjsKudUEkldCdsP1ZiBs/e7HFSpOvSLXFKkY+JwoNFsXEfNz/x9od0Tke4HruQIEc
 xMSDGZuVrssd3N3MSm3MuZTaqHGVjLFv1nSB9LueXflvUBxXi4RJGu3crzXsync1CkGw
 AXloxWXWdO9hyHfR3GMt1fcTW/WhiCHIO78JVfjQIxWuXf+5fMx7vy8nmAK7UxTTc3ii wg== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9b83019k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:45:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 374Msi4M015771; Fri, 4 Aug 2023 23:45:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8kn79yky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:45:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 374NjGik60621090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Aug 2023 23:45:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5E3820043;
 Fri,  4 Aug 2023 23:45:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6419A20040;
 Fri,  4 Aug 2023 23:45:16 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.122])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  4 Aug 2023 23:45:16 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] linux-user: Emulate the Anonymous: keyword in /proc/self/smaps
Date: Sat,  5 Aug 2023 01:44:40 +0200
Message-ID: <20230804234514.252056-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QwpED7kEuV6y2Xq-5xMDHQDQyzTyvNnD
X-Proofpoint-ORIG-GUID: QwpED7kEuV6y2Xq-5xMDHQDQyzTyvNnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040213
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
 linux-user/syscall.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95727a816ad..150be661dba 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8078,7 +8078,7 @@ static int open_self_cmdline(CPUArchState *cpu_env, int fd)
     return 0;
 }
 
-static void show_smaps(int fd, unsigned long size)
+static void show_smaps(int fd, unsigned long size, int flags)
 {
     unsigned long page_size_kb = TARGET_PAGE_SIZE >> 10;
     unsigned long size_kb = size >> 10;
@@ -8094,7 +8094,7 @@ static void show_smaps(int fd, unsigned long size)
                 "Private_Clean:         0 kB\n"
                 "Private_Dirty:         0 kB\n"
                 "Referenced:            0 kB\n"
-                "Anonymous:             0 kB\n"
+                "Anonymous:             %lu kB\n"
                 "LazyFree:              0 kB\n"
                 "AnonHugePages:         0 kB\n"
                 "ShmemPmdMapped:        0 kB\n"
@@ -8104,7 +8104,9 @@ static void show_smaps(int fd, unsigned long size)
                 "Swap:                  0 kB\n"
                 "SwapPss:               0 kB\n"
                 "Locked:                0 kB\n"
-                "THPeligible:    0\n", size_kb, page_size_kb, page_size_kb);
+                "THPeligible:    0\n",
+            size_kb, page_size_kb, page_size_kb,
+            (flags & PAGE_ANON) ? size_kb : 0);
 }
 
 static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
@@ -8155,7 +8157,7 @@ static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
                 dprintf(fd, "\n");
             }
             if (smaps) {
-                show_smaps(fd, max - min);
+                show_smaps(fd, max - min, flags);
                 dprintf(fd, "VmFlags:%s%s%s%s%s%s%s%s\n",
                         (flags & PAGE_READ) ? " rd" : "",
                         (flags & PAGE_WRITE_ORG) ? " wr" : "",
-- 
2.41.0


