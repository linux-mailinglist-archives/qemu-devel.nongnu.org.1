Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 827227390D6
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 22:37:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC4ZP-0006tf-3X; Wed, 21 Jun 2023 16:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qC4ZM-0006sF-QJ; Wed, 21 Jun 2023 16:36:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qC4ZL-0008B7-1R; Wed, 21 Jun 2023 16:36:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LKYBBq008265; Wed, 21 Jun 2023 20:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=0ZY8vwmLmzLOcX/i4g/GVyWuQ3vKveULuVZbaYah6LM=;
 b=CE5MhzPsfTAe+VrJmJllk5B+h0kfc+AfCy3C1dxQKzOHcES20th9uCS2KM94VY+JeCn4
 Jk8/hmxlNzkwLUyAT4Eix1qnKsAC9gxpJ/tkUpWa4VGhrclsJ/PUFXHWs+D1wsKbSje0
 EGzGhiaq9gL5jGq0JIDW2zxdCZFpEBEYcgdQCmtv3LLQr5czMcXaSIUF7xhpCEYPg/bc
 asxrJywPhr2ErA3uF4HW5Zl5vjCYk9JBCfYssLMaXAH6et+eqbv0flyQyCK9dazWkiHK
 Jc8K721y9ABbSKd/Kntb7z7r3efN5b3234HwNGqJ4w6yYwMJ134SH5LP6s6sZwdQJH0b QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc7u98swg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 20:36:44 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LKZpp5016957;
 Wed, 21 Jun 2023 20:36:43 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc7u98svf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 20:36:43 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L9XXCA020019;
 Wed, 21 Jun 2023 20:36:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3r94f5aasu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 20:36:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35LKad7n43778462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 20:36:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BA9520043;
 Wed, 21 Jun 2023 20:36:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8690320040;
 Wed, 21 Jun 2023 20:36:38 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.1.208])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jun 2023 20:36:38 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 1/8] linux-user: Expose do_guest_openat() and
 do_guest_readlink()
Date: Wed, 21 Jun 2023 22:36:20 +0200
Message-Id: <20230621203627.1808446-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621203627.1808446-1-iii@linux.ibm.com>
References: <20230621203627.1808446-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5wwq5GsQgq0d-PeOp3VgETPDji-NKcQf
X-Proofpoint-ORIG-GUID: Zznn1hGS_qkxvr3L-giXXSRTelF_OFPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210172
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

These functions will be required by the GDB stub in order to provide
the guest view of /proc to GDB.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    |  3 +++
 linux-user/syscall.c | 54 ++++++++++++++++++++++++++++----------------
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 92f9f5af41..a5830ec239 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -165,6 +165,9 @@ typedef struct TaskState {
 } TaskState;
 
 abi_long do_brk(abi_ulong new_brk);
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
+                    int flags, mode_t mode);
+ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz);
 
 /* user access */
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f2cb101d83..fa83737192 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8448,7 +8448,8 @@ static int open_hardware(CPUArchState *cpu_env, int fd)
 }
 #endif
 
-static int do_openat(CPUArchState *cpu_env, int dirfd, const char *pathname, int flags, mode_t mode)
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
+                    int flags, mode_t mode)
 {
     struct fake_open {
         const char *filename;
@@ -8520,6 +8521,36 @@ static int do_openat(CPUArchState *cpu_env, int dirfd, const char *pathname, int
     return safe_openat(dirfd, path(pathname), flags, mode);
 }
 
+ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
+{
+    ssize_t ret;
+
+    if (!pathname || !buf) {
+        errno = EFAULT;
+        return -1;
+    }
+
+    if (!bufsiz) {
+        /* Short circuit this for the magic exe check. */
+        errno = EINVAL;
+        return -1;
+    }
+
+    if (is_proc_myself((const char *)pathname, "exe")) {
+        /*
+         * Don't worry about sign mismatch as earlier mapping
+         * logic would have thrown a bad address error.
+         */
+        ret = MIN(strlen(exec_path), bufsiz);
+        /* We cannot NUL terminate the string. */
+        memcpy(buf, exec_path, ret);
+    } else {
+        ret = readlink(path(pathname), buf, bufsiz);
+    }
+
+    return ret;
+}
+
 static int do_execveat(CPUArchState *cpu_env, int dirfd,
                        abi_long pathname, abi_long guest_argp,
                        abi_long guest_envp, int flags)
@@ -8994,7 +9025,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_open:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
-        ret = get_errno(do_openat(cpu_env, AT_FDCWD, p,
+        ret = get_errno(do_guest_openat(cpu_env, AT_FDCWD, p,
                                   target_to_host_bitmask(arg2, fcntl_flags_tbl),
                                   arg3));
         fd_trans_unregister(ret);
@@ -9004,7 +9035,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_openat:
         if (!(p = lock_user_string(arg2)))
             return -TARGET_EFAULT;
-        ret = get_errno(do_openat(cpu_env, arg1, p,
+        ret = get_errno(do_guest_openat(cpu_env, arg1, p,
                                   target_to_host_bitmask(arg3, fcntl_flags_tbl),
                                   arg4));
         fd_trans_unregister(ret);
@@ -10229,22 +10260,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             void *p2;
             p = lock_user_string(arg1);
             p2 = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else if (!arg3) {
-                /* Short circuit this for the magic exe check. */
-                ret = -TARGET_EINVAL;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                /*
-                 * Don't worry about sign mismatch as earlier mapping
-                 * logic would have thrown a bad address error.
-                 */
-                ret = MIN(strlen(exec_path), arg3);
-                /* We cannot NUL terminate the string. */
-                memcpy(p2, exec_path, ret);
-            } else {
-                ret = get_errno(readlink(path(p), p2, arg3));
-            }
+            ret = get_errno(do_guest_readlink(p, p2, arg3));
             unlock_user(p2, arg2, ret);
             unlock_user(p, arg1, 0);
         }
-- 
2.40.1


