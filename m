Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8A4827BAC
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 00:41:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMzCi-00024x-LD; Mon, 08 Jan 2024 18:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rMzCd-0001yy-HV; Mon, 08 Jan 2024 18:38:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rMzCZ-0005dX-Rs; Mon, 08 Jan 2024 18:38:43 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 408NOcts014100; Mon, 8 Jan 2024 23:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DlWhMJpGqjL9uitTslKd04vl0P8u4r+24KgdpvpulmI=;
 b=fKnULXztZNcZiVfHhff0x5Los+BQD6MTY3Q4ncF6JzrKUIAMeiUaVhUSC8mNZYMsG65k
 dRtTF4cQ3KQ4/2ZY9JS5svsiLthp0KgdPjW3n9KVbcLgRIx3LOn5DN72gGomQ8nv/UFF
 rr9vDEMYc8rXxkBKH+/XTtVmGFWIW8vbAwLDUD9+B456Dtkm2MZ3b3gIGXmlx3gU7q8M
 n8luThDtiROZKOzCRc1rqCjCS4xoIEqa2X2fr8clBFe8jlO7pOtUzvOIHTHA72UXxsDY
 C5SG2Pg4SB9wJiFJUKKTHP3FGbbdwTAUMmmQvMIZRCdjjMad3Y0r4sqx1CpATxBNsDLU vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgjsrn4mr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jan 2024 23:38:36 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408Msf9Y029601;
 Mon, 8 Jan 2024 23:38:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgjsrn4ky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jan 2024 23:38:35 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 408KXipp022882; Mon, 8 Jan 2024 23:38:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfj6nb8m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jan 2024 23:38:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 408NcWpN39256704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jan 2024 23:38:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AD7720043;
 Mon,  8 Jan 2024 23:38:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAB9820040;
 Mon,  8 Jan 2024 23:38:31 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.15.162])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jan 2024 23:38:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/3] linux-user: Allow gdbstub to ignore page protection
Date: Tue,  9 Jan 2024 00:34:06 +0100
Message-ID: <20240108233821.201325-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108233821.201325-1-iii@linux.ibm.com>
References: <20240108233821.201325-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: roO8yKcvzbqWYBy2jTTNINm-Q8K8OxQV
X-Proofpoint-ORIG-GUID: hIhwzYr58vJeCDyPPrLX89n05gq8cnJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_10,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=890
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080192
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

gdbserver ignores page protection by virtue of using /proc/$pid/mem.
Teach qemu gdbstub to do this too. This will not work if /proc is not
mounted; accept this limitation.

One alternative is to temporarily grant the missing PROT_* bit, but
this is inherently racy. Another alternative is self-debugging with
ptrace(POKE), which will break if QEMU itself is being debugged - a
much more severe limitation.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 cpu-target.c | 55 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 5eecd7ea2d7..69e97f78980 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -406,6 +406,15 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     vaddr l, page;
     void * p;
     uint8_t *buf = ptr;
+    int ret = -1;
+    int mem_fd;
+
+    /*
+     * Try ptrace first. If /proc is not mounted or if there is a different
+     * problem, fall back to the manual page access. Note that, unlike ptrace,
+     * it will not be able to ignore the protection bits.
+     */
+    mem_fd = open("/proc/self/mem", is_write ? O_WRONLY : O_RDONLY);
 
     while (len > 0) {
         page = addr & TARGET_PAGE_MASK;
@@ -413,22 +422,33 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         if (l > len)
             l = len;
         flags = page_get_flags(page);
-        if (!(flags & PAGE_VALID))
-            return -1;
+        if (!(flags & PAGE_VALID)) {
+            goto out_close;
+        }
         if (is_write) {
-            if (!(flags & PAGE_WRITE))
-                return -1;
+            if (mem_fd == -1 ||
+                pwrite(mem_fd, ptr, len, (off_t)g2h_untagged(addr)) != len) {
+                if (!(flags & PAGE_WRITE)) {
+                    goto out_close;
+                }
+                /* XXX: this code should not depend on lock_user */
+                p = lock_user(VERIFY_WRITE, addr, l, 0);
+                if (!p) {
+                    goto out_close;
+                }
+                memcpy(p, buf, l);
+                unlock_user(p, addr, l);
+            }
+        } else if (mem_fd == -1 ||
+                   pread(mem_fd, ptr, len, (off_t)g2h_untagged(addr)) != len) {
+            if (!(flags & PAGE_READ)) {
+                goto out_close;
+            }
             /* XXX: this code should not depend on lock_user */
-            if (!(p = lock_user(VERIFY_WRITE, addr, l, 0)))
-                return -1;
-            memcpy(p, buf, l);
-            unlock_user(p, addr, l);
-        } else {
-            if (!(flags & PAGE_READ))
-                return -1;
-            /* XXX: this code should not depend on lock_user */
-            if (!(p = lock_user(VERIFY_READ, addr, l, 1)))
-                return -1;
+            p = lock_user(VERIFY_READ, addr, l, 1);
+            if (!p) {
+                goto out_close;
+            }
             memcpy(buf, p, l);
             unlock_user(p, addr, 0);
         }
@@ -436,7 +456,12 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         buf += l;
         addr += l;
     }
-    return 0;
+    ret = 0;
+out_close:
+    if (mem_fd != -1) {
+        close(mem_fd);
+    }
+    return ret;
 }
 #endif
 
-- 
2.43.0


