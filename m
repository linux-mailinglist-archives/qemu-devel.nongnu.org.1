Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 305F1A06615
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Jan 2025 21:28:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVcdn-0007Go-JH; Wed, 08 Jan 2025 15:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVcda-0007DO-4P
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:26:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVcdY-0006ru-96
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:26:45 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Ew0eH008979;
 Wed, 8 Jan 2025 20:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LB53lNjHAZiWLw1xx
 c6MqJeZMlE8LD1UM0ceFdsZtp8=; b=LsKDabL7zU1W50841FAbFToeSXQYToyoL
 wEHNvk2pYCy/yTRZQhggZB5lzk0y5HOS9NxZJULhn7HKldc8ErwcZs318Rb3mMiP
 s5yjHtfdcgSxY5It3TBW4xLzvtYaBQlP3WzTDvySTVRwKsHvWYRJiCR3jvwGdEz4
 ZpsvLsg8I6z4CpX3cQ3Z2aA/0wegTjPfXW3rM0dx58Bg0DvrhmhXq6nsdhaRNK8+
 ozcg4N7J5hjmzeWjPPoaDiMlDs1qRcSSoQ/inIpGTd1rX6EBEwtavHshcpXYijwW
 PGufUiAy7YKGIe+MeLc003df7gQCdWCojApSAtkus4P9+FqT9h6HA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupvcp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 20:26:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508I6fBw026183;
 Wed, 8 Jan 2025 20:26:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj129a9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 20:26:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 508KQUSJ55771634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2025 20:26:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C4532004B;
 Wed,  8 Jan 2025 20:26:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB53120040;
 Wed,  8 Jan 2025 20:26:29 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.127])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2025 20:26:29 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 4/9] user: Introduce user/signal.h
Date: Wed,  8 Jan 2025 21:04:59 +0100
Message-ID: <20250108202625.149869-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108202625.149869-1-iii@linux.ibm.com>
References: <20250108202625.149869-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _xifJ3LcUSkDDy4jUQAbNXXWu6SWozEa
X-Proofpoint-GUID: _xifJ3LcUSkDDy4jUQAbNXXWu6SWozEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=967
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080163
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

gdbstub needs target_to_host_signal(), so move its declaration to a
public header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/signal-common.h   |  1 -
 bsd-user/signal.c          |  1 +
 include/user/signal.h      | 23 +++++++++++++++++++++++
 linux-user/signal-common.h |  1 -
 linux-user/signal.c        |  1 +
 linux-user/syscall.c       |  1 +
 6 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 include/user/signal.h

diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h
index 77d7c7a78b7..4e634e04a30 100644
--- a/bsd-user/signal-common.h
+++ b/bsd-user/signal-common.h
@@ -42,7 +42,6 @@ void process_pending_signals(CPUArchState *env);
 void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info);
 void signal_init(void);
-int target_to_host_signal(int sig);
 void target_to_host_sigset(sigset_t *d, const target_sigset_t *s);
 
 /*
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index b4e1458237a..8c51f6ce653 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -24,6 +24,7 @@
 #include "user/cpu_loop.h"
 #include "exec/page-protection.h"
 #include "user/page-protection.h"
+#include "user/signal.h"
 #include "user/tswap-target.h"
 #include "gdbstub/user.h"
 #include "signal-common.h"
diff --git a/include/user/signal.h b/include/user/signal.h
new file mode 100644
index 00000000000..19b6b9e5ddc
--- /dev/null
+++ b/include/user/signal.h
@@ -0,0 +1,23 @@
+/*
+ * Signal-related declarations.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef USER_SIGNAL_H
+#define USER_SIGNAL_H
+
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
+/**
+ * target_to_host_signal:
+ * @sig: target signal.
+ *
+ * On success, return the host signal between 0 (inclusive) and NSIG
+ * (exclusive) corresponding to the target signal @sig. Return any other value
+ * on failure.
+ */
+int target_to_host_signal(int sig);
+
+#endif
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 8584d9ecc2a..196d2406f86 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -61,7 +61,6 @@ void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info);
 void host_to_target_siginfo(target_siginfo_t *tinfo, const siginfo_t *info);
 void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t *tinfo);
-int target_to_host_signal(int sig);
 int host_to_target_signal(int sig);
 long do_sigreturn(CPUArchState *env);
 long do_rt_sigreturn(CPUArchState *env);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 087c4d270e4..bffbef235cd 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -36,6 +36,7 @@
 #include "user/cpu_loop.h"
 #include "user/page-protection.h"
 #include "user/safe-syscall.h"
+#include "user/signal.h"
 #include "tcg/tcg.h"
 
 /* target_siginfo_t must fit in gdbstub's siginfo save area. */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 78c7c0b34ef..53837113c4a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -138,6 +138,7 @@
 #include "user-mmap.h"
 #include "user/page-protection.h"
 #include "user/safe-syscall.h"
+#include "user/signal.h"
 #include "qemu/guest-random.h"
 #include "qemu/selfmap.h"
 #include "user/syscall-trace.h"
-- 
2.47.1


