Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 257097390DA
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 22:37:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC4ZS-0006wU-KW; Wed, 21 Jun 2023 16:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qC4ZP-0006us-Rw; Wed, 21 Jun 2023 16:36:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qC4ZO-0008CA-5Q; Wed, 21 Jun 2023 16:36:51 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LKEDLL021604; Wed, 21 Jun 2023 20:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=G84DodHSsx2+R+Uh0++Gk9hlTeuuUerf2U/DEhm8Zo4=;
 b=Cx/8I7lDkQQIxY9fnDxISARjoJ9ivzxcaXssnlBUHRvu6h+1vZbl8FjRwISEW0wKZXb4
 Co0FLjb0oGoJuvUYNdFvtoejWLIdW0is4GmGKQAZ12Sn+stQZ5C/b41Zjk/6Uv6gcvfO
 rhu3zdbaDkJp9E8RnKdZw7OEVBMBQ7yJsFX59wDh4MrTDewLj1wAMqOxtJGQ5sbrf9kh
 BNBa7mFRB6JbVg3zAkcE/GLFva6Izt/e4aySGitUYUDhx4NcjKbNPFSCHOC7K1oGwGdS
 6bX4iy1p/TU1sEeY9JBRig6X+dWilE/vIbATncUbhKxQvMY69z+De9AmX8LyeKQ3r8nb XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc82g8ey4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 20:36:47 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LKG2g4026347;
 Wed, 21 Jun 2023 20:36:46 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc82g8ex9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 20:36:46 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L97hCO017775;
 Wed, 21 Jun 2023 20:36:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r94f5aa8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 20:36:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35LKafqB28771026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 20:36:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91ECE20043;
 Wed, 21 Jun 2023 20:36:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13EFC20040;
 Wed, 21 Jun 2023 20:36:41 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.1.208])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jun 2023 20:36:40 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 2/8] linux-user: Add "safe" parameter to do_guest_openat()
Date: Wed, 21 Jun 2023 22:36:21 +0200
Message-Id: <20230621203627.1808446-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621203627.1808446-1-iii@linux.ibm.com>
References: <20230621203627.1808446-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AnmY8nIrlpyf3LdtNm26o4fsnvza8g7L
X-Proofpoint-GUID: z2hYohVPCc6hFoa50qdsB8JZ59pYEEFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306210172
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

gdbstub cannot meaningfully handle QEMU_ERESTARTSYS, and it doesn't
need to. Add a parameter to do_guest_openat() that makes it use
openat() instead of safe_openat(), so that it becomes usable from
gdbstub.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    |  2 +-
 linux-user/syscall.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index a5830ec239..9b8e0860d7 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -166,7 +166,7 @@ typedef struct TaskState {
 
 abi_long do_brk(abi_ulong new_brk);
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
-                    int flags, mode_t mode);
+                    int flags, mode_t mode, bool safe);
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz);
 
 /* user access */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fa83737192..ecd9f5e23d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8449,7 +8449,7 @@ static int open_hardware(CPUArchState *cpu_env, int fd)
 #endif
 
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
-                    int flags, mode_t mode)
+                    int flags, mode_t mode, bool safe)
 {
     struct fake_open {
         const char *filename;
@@ -8476,7 +8476,11 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
     };
 
     if (is_proc_myself(pathname, "exe")) {
-        return safe_openat(dirfd, exec_path, flags, mode);
+        if (safe) {
+            return safe_openat(dirfd, exec_path, flags, mode);
+        } else {
+            return openat(dirfd, exec_path, flags, mode);
+        }
     }
 
     for (fake_open = fakes; fake_open->filename; fake_open++) {
@@ -8518,7 +8522,11 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
         return fd;
     }
 
-    return safe_openat(dirfd, path(pathname), flags, mode);
+    if (safe) {
+        return safe_openat(dirfd, path(pathname), flags, mode);
+    } else {
+        return openat(dirfd, path(pathname), flags, mode);
+    }
 }
 
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
@@ -9027,7 +9035,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             return -TARGET_EFAULT;
         ret = get_errno(do_guest_openat(cpu_env, AT_FDCWD, p,
                                   target_to_host_bitmask(arg2, fcntl_flags_tbl),
-                                  arg3));
+                                  arg3, true));
         fd_trans_unregister(ret);
         unlock_user(p, arg1, 0);
         return ret;
@@ -9037,7 +9045,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             return -TARGET_EFAULT;
         ret = get_errno(do_guest_openat(cpu_env, arg1, p,
                                   target_to_host_bitmask(arg3, fcntl_flags_tbl),
-                                  arg4));
+                                  arg4, true));
         fd_trans_unregister(ret);
         unlock_user(p, arg2, 0);
         return ret;
-- 
2.40.1


