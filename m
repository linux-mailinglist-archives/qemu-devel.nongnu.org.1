Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119F82908E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 00:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNLCp-0003Rk-VP; Tue, 09 Jan 2024 18:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rNLCn-0003Q0-DS; Tue, 09 Jan 2024 18:08:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rNLCl-0006RR-AO; Tue, 09 Jan 2024 18:08:21 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409KkfUC015417; Tue, 9 Jan 2024 23:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Epq4/2IrxAEyKNucGP8jLu0j7rl0e55OIlmgNSesLlI=;
 b=LITHvL9GCGDrp5IEtrXjIz9pwA82IHn4d9EaU5N7kAVKOZfNBX+6jYsbR742gLBFgudq
 M7Mmn0l1s4Q3d5YfESIKTNMW9uantX0Cy8zFNDbPAURXczCtohbJPz1nCmLKhFVmzHku
 1eJQD7Zl8Cb9dWjVpoy6gL91gxZD7Cgwle0DsHCahBdMhgEVrU+Qv3HxvO1nC2v8dIS7
 iPVxbwELBeSnVSApD9phj+lzN8eRNorSS09ErCtemV27YHIWsQHz6rdc3EZ0Fr0A16DO
 y/on+evgOLvKPpFphwPMd85PDIIdtx04sj5fL+FTTKWQjfVQlbQxuCcsFgUAw48gnjAz Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhbvnn1n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 23:08:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409N8FMV022099;
 Tue, 9 Jan 2024 23:08:15 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhbvnn1mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 23:08:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 409LLbfC028052; Tue, 9 Jan 2024 23:08:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vgwfsnqmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 23:08:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 409N8Cwh25559460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jan 2024 23:08:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70C322004B;
 Tue,  9 Jan 2024 23:08:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D00AE20040;
 Tue,  9 Jan 2024 23:08:11 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.60.193])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jan 2024 23:08:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/3] linux-user: Allow gdbstub to ignore page protection
Date: Wed, 10 Jan 2024 00:05:53 +0100
Message-ID: <20240109230808.583012-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109230808.583012-1-iii@linux.ibm.com>
References: <20240109230808.583012-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L_cNUuJwUs8NaX2bEdLCCe4J_xJxTo7k
X-Proofpoint-ORIG-GUID: A322wC64wfNUMpPpvhlpJeuMkgJPi93p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_11,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 mlxlogscore=962 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090186
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

gdbserver ignores page protection by virtue of using /proc/$pid/mem.
Teach qemu gdbstub to do this too. This will not work if /proc is not
mounted; accept this limitation.

One alternative is to temporarily grant the missing PROT_* bit, but
this is inherently racy. Another alternative is self-debugging with
ptrace(POKE), which will break if QEMU itself is being debugged - a
much more severe limitation.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 cpu-target.c | 76 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 5eecd7ea2d7..723f6af5fba 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -406,6 +406,9 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     vaddr l, page;
     void * p;
     uint8_t *buf = ptr;
+    ssize_t written;
+    int ret = -1;
+    int fd = -1;
 
     while (len > 0) {
         page = addr & TARGET_PAGE_MASK;
@@ -413,30 +416,73 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
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
-            /* XXX: this code should not depend on lock_user */
-            if (!(p = lock_user(VERIFY_WRITE, addr, l, 0)))
-                return -1;
-            memcpy(p, buf, l);
-            unlock_user(p, addr, l);
-        } else {
-            if (!(flags & PAGE_READ))
-                return -1;
+            if (flags & PAGE_WRITE) {
+                /* XXX: this code should not depend on lock_user */
+                p = lock_user(VERIFY_WRITE, addr, l, 0);
+                if (!p) {
+                    goto out_close;
+                }
+                memcpy(p, buf, l);
+                unlock_user(p, addr, l);
+            } else {
+                /* Bypass the host page protection using ptrace. */
+                if (fd == -1) {
+                    fd = open("/proc/self/mem", O_WRONLY);
+                    if (fd == -1) {
+                        goto out;
+                    }
+                }
+                /*
+                 * If there is a TranslationBlock and we weren't bypassing the
+                 * host page protection, the memcpy() above would SEGV,
+                 * ultimately leading to page_unprotect(). So invalidate the
+                 * translations manually. Both invalidation and pwrite() must
+                 * be under mmap_lock() in order to prevent the creation of
+                 * another TranslationBlock in between.
+                 */
+                mmap_lock();
+                tb_invalidate_phys_range(addr, addr + l - 1);
+                written = pwrite(fd, buf, l, (off_t)g2h_untagged(addr));
+                mmap_unlock();
+                if (written != l) {
+                    goto out_close;
+                }
+            }
+        } else if (flags & PAGE_READ) {
             /* XXX: this code should not depend on lock_user */
-            if (!(p = lock_user(VERIFY_READ, addr, l, 1)))
-                return -1;
+            p = lock_user(VERIFY_READ, addr, l, 1);
+            if (!p) {
+                goto out_close;
+            }
             memcpy(buf, p, l);
             unlock_user(p, addr, 0);
+        } else {
+            /* Bypass the host page protection using ptrace. */
+            if (fd == -1) {
+                fd = open("/proc/self/mem", O_RDONLY);
+                if (fd == -1) {
+                    goto out;
+                }
+            }
+            if (pread(fd, buf, l, (off_t)g2h_untagged(addr)) != l) {
+                goto out_close;
+            }
         }
         len -= l;
         buf += l;
         addr += l;
     }
-    return 0;
+    ret = 0;
+out_close:
+    if (fd != -1) {
+        close(fd);
+    }
+out:
+    return ret;
 }
 #endif
 
-- 
2.43.0


