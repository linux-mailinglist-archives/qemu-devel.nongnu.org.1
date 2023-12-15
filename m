Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F4E81548B
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 00:31:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEHdF-0001Cx-23; Fri, 15 Dec 2023 18:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rEHd1-0001CL-2J
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 18:29:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rEHcy-0003VV-OX
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 18:29:58 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BFLfw74015597; Fri, 15 Dec 2023 23:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KVwJZrEPFTvQjCUJS2Xpvk1vp2SMON2ekQaSiHxXdwU=;
 b=pmLbnmgLV586z6fRjh98a8l8cbXTRAs6OAQts+YgafoX3PTdZ0CUQwNMk0LNN2OMzIi2
 mpIrGyUFOEAl1yvPG+QeejzF8VGdZscXguRaLXYrYkb7I5/DiuKjpqIzmgkjd+BSZzhM
 pPcpJXtiiQyUSKkZVpBc0VCXl7vM8o2/6XZdasEfYlvlDMx2sukbl10SwwCQx2awxYaG
 r3TXqT1IUcmp02jObDrcbcHem/5sl+BuFlVYFZQRXUyGZzBD5KDxsf24FFyHhB6UsKmF
 KRBkZ7Kw7Ik8tlLVbzsFz6man8PwZ5XErN8RuSsj/r6eHqqQg7hAJjhUXM2V5sRIRHqR Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0x30km5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 23:29:52 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFNLFri004634;
 Fri, 15 Dec 2023 23:29:51 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0x30km5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 23:29:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BFN1AgS008544; Fri, 15 Dec 2023 23:29:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw2ju3tgf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 23:29:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3BFNTnGd9634518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Dec 2023 23:29:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48F4C20043;
 Fri, 15 Dec 2023 23:29:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC65F20040;
 Fri, 15 Dec 2023 23:29:48 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.156])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Dec 2023 23:29:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, philmd@linaro.org
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC] linux-user: Allow gdbstub to ignore page protection
Date: Sat, 16 Dec 2023 00:24:00 +0100
Message-ID: <20231215232908.1040209-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0fIiaY1pIan_j6dWf7F5AITOsKXM1BNV
X-Proofpoint-ORIG-GUID: 0ArJk0ZDH5VCb35iTBfGdxWMd3W-Ge1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150165
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Hi,

I've noticed that gdbstub behaves differently from gdbserver in that it
doesn't allow reading non-readable pages. The below patch works for me,
but I'm not sure if I haven't introduced layering violations or race
conditions here, so I'm sending this as an RFC. Please let me know if
the code can be improved.

Best regards,
Ilya



gdbserver ignores page protection (by virtue of using /proc/$pid/mem),
so qemu gdbstub should too. One option would be to use the same
mechanism, but this will not work if /proc is not mounted. So
temporarily set the necessary protection bits instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 cpu-target.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 508013e23d2..8dd7342705b 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -27,6 +27,7 @@
 #include "migration/vmstate.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
+#include "user-mmap.h"
 #else
 #include "hw/core/sysemu-cpu-ops.h"
 #include "exec/address-spaces.h"
@@ -368,6 +369,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     vaddr l, page;
     void * p;
     uint8_t *buf = ptr;
+    int prot;
 
     while (len > 0) {
         page = addr & TARGET_PAGE_MASK;
@@ -377,22 +379,42 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         flags = page_get_flags(page);
         if (!(flags & PAGE_VALID))
             return -1;
+        prot = ((flags & PAGE_READ) ? PROT_READ : 0) |
+               ((flags & PAGE_WRITE) ? PROT_WRITE : 0) |
+               ((flags & PAGE_EXEC) ? PROT_EXEC : 0);
         if (is_write) {
-            if (!(flags & PAGE_WRITE))
-                return -1;
+            if (!(prot & PROT_WRITE)) {
+                if (target_mprotect(page, TARGET_PAGE_SIZE,
+                                    prot | PROT_WRITE)) {
+                    return -1;
+                }
+            }
             /* XXX: this code should not depend on lock_user */
-            if (!(p = lock_user(VERIFY_WRITE, addr, l, 0)))
+            if (!(p = lock_user(VERIFY_NONE, addr, l, 0)))
                 return -1;
             memcpy(p, buf, l);
             unlock_user(p, addr, l);
+            if (!(prot & PROT_WRITE)) {
+                if (target_mprotect(page, TARGET_PAGE_SIZE, prot)) {
+                    return -1;
+                }
+            }
         } else {
-            if (!(flags & PAGE_READ))
-                return -1;
+            if (!(prot & PROT_READ)) {
+                if (target_mprotect(page, TARGET_PAGE_SIZE, prot | PROT_READ)) {
+                    return -1;
+                }
+            }
             /* XXX: this code should not depend on lock_user */
-            if (!(p = lock_user(VERIFY_READ, addr, l, 1)))
+            if (!(p = lock_user(VERIFY_NONE, addr, l, 1)))
                 return -1;
             memcpy(buf, p, l);
             unlock_user(p, addr, 0);
+            if (!(prot & PROT_READ)) {
+                if (target_mprotect(page, TARGET_PAGE_SIZE, prot)) {
+                    return -1;
+                }
+            }
         }
         len -= l;
         buf += l;
-- 
2.43.0


