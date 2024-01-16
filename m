Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9366782E54D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 01:37:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPXRH-0005h9-Ef; Mon, 15 Jan 2024 19:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rPXR9-0005ce-EG; Mon, 15 Jan 2024 19:36:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rPXR5-00085T-46; Mon, 15 Jan 2024 19:36:13 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FNTxSX010544; Tue, 16 Jan 2024 00:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=t1SC+zmPpc1Y0OU/FyOVQC5ZJl78RtELoSmL2Pk8z88=;
 b=XkdbvgHpx16Bcpshp6weSMupdHX1W/SQwCNSXDoaSWO/jmuHj588U6Xm5iMUS2++IPY7
 C+J+l3qjxhPDaI+/CdqGdMyUtkvkWQfkeEMd5tfcrknsouwpAJLJdPtkz+X5a/kAvWzg
 6ZoK6DBudP0yQ+xxXTRpXatADrQw7yW2qK2WYcJSXbj6gC2K/z83Sw7PMiT1OCCuCHSQ
 FEb5nm+w/FpXKMl4FW8kp0UQth6A3EkGoi0Xi5KIs4I/sP7/6Df5zjzaFJnlT8QiDmzl
 gMWAXyKVlslCOIAs8+0MjaF2aSFu4pMalvGZ7wcKfU/2+ib1AC1LjjTekSISP3mMoR6i 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vncnekb2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:36:02 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40FNsO3H002689;
 Tue, 16 Jan 2024 00:36:02 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vncnekb27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:36:02 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FNHk50014890; Tue, 16 Jan 2024 00:36:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm4uskph7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:36:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40G0ZwAw4063896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 00:35:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D886820043;
 Tue, 16 Jan 2024 00:35:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 366C620040;
 Tue, 16 Jan 2024 00:35:58 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.64])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 00:35:58 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 1/3] linux-user: Allow gdbstub to ignore page protection
Date: Tue, 16 Jan 2024 01:31:40 +0100
Message-ID: <20240116003551.75168-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116003551.75168-1-iii@linux.ibm.com>
References: <20240116003551.75168-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: khQyEJLnj7dh6oK_bGSa1nhVrz2kALtF
X-Proofpoint-GUID: cIivWzxTHXKmxZHgbYsOs1hIISBdEjJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_17,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=961
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160002
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


