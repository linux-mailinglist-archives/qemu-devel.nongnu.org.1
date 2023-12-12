Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 299FA80E064
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 01:42:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCqqA-0004aY-Bs; Mon, 11 Dec 2023 19:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rCqq7-0004UI-Ts
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 19:41:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rCqq5-0004ou-21
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 19:41:35 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BBN7v7m020381; Tue, 12 Dec 2023 00:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LGHbGpyE5A31bcbyqPw2gIJOGgFg/SayKuTq5gfT81o=;
 b=N0EpwbLJf5aSz2CWxcTJXx3vf9M6D6VLnPl9zT849m3EAxMfWLY0npn8V29PgCmfwss+
 AjqeihioVr4rMhlekQ8V/APsZr6bv2/acySNrWy5+xLuMAptTKrGSaoA+JnJStwjAnxT
 KDa0Dtg4Q/ayWSRsvdqVpWvWNKPvowBmqU9lH/A55Xop6qxYwuY9izlG6L+BBA6EPAIo
 En88CgjEfsdd1dkcfEYQ5TPngRLbis/vdB/2IEAkd67b/PmOSb07ddlNY0m+4UWGKoyh
 8xl9JfJgGSyPd8Hb6pwan77I05FF522oR4w01pKZ32+rUfHvsvQmdR2QoOEgsk1/OQXw 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxbtxhhqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 00:41:31 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BC0U71g030331;
 Tue, 12 Dec 2023 00:41:31 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxbtxhhq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 00:41:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BBMAh1F004390; Tue, 12 Dec 2023 00:41:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4sk52g8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 00:41:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3BC0fRaX43319806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Dec 2023 00:41:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A75D720043;
 Tue, 12 Dec 2023 00:41:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3050F2004F;
 Tue, 12 Dec 2023 00:41:27 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.76.38])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Dec 2023 00:41:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 4/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Tue, 12 Dec 2023 01:34:50 +0100
Message-ID: <20231212003837.64090-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212003837.64090-1-iii@linux.ibm.com>
References: <20231212003837.64090-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: miAroKEwjGqMQoJuR94HHyvBUxNRKDEF
X-Proofpoint-GUID: DI1m90kUrcYtTzeQ26o293SvXfaYdyPu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_11,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120003
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

tcg/ should not depend on accel/tcg/, but perf and debuginfo
support provided by the latter are being used by tcg/tcg.c.

Since that's the only user, move both to tcg/.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build              | 2 --
 accel/tcg/translate-all.c          | 2 +-
 hw/core/loader.c                   | 2 +-
 {accel => include}/tcg/debuginfo.h | 4 ++--
 {accel => include}/tcg/perf.h      | 4 ++--
 linux-user/elfload.c               | 2 +-
 linux-user/exit.c                  | 2 +-
 linux-user/main.c                  | 2 +-
 system/vl.c                        | 2 +-
 {accel/tcg => tcg}/debuginfo.c     | 3 +--
 tcg/meson.build                    | 3 +++
 {accel/tcg => tcg}/perf.c          | 7 +++----
 tcg/tcg.c                          | 2 +-
 13 files changed, 18 insertions(+), 19 deletions(-)
 rename {accel => include}/tcg/debuginfo.h (96%)
 rename {accel => include}/tcg/perf.h (95%)
 rename {accel/tcg => tcg}/debuginfo.c (98%)
 rename {accel/tcg => tcg}/perf.c (99%)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 8783edd06ee..a7cb724edb2 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -16,8 +16,6 @@ tcg_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
   tcg_ss.add(files('plugin-gen.c'))
 endif
-tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
-tcg_ss.add(when: 'CONFIG_LINUX', if_true: files('perf.c'))
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 79a88f5fb75..3c1ce69ff36 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -63,7 +63,7 @@
 #include "tb-context.h"
 #include "internal-common.h"
 #include "internal-target.h"
-#include "perf.h"
+#include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
 
 TBContext tb_ctx;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index e7a9b3775bb..b8e52f3fb0f 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -62,7 +62,7 @@
 #include "hw/boards.h"
 #include "qemu/cutils.h"
 #include "sysemu/runstate.h"
-#include "accel/tcg/debuginfo.h"
+#include "tcg/debuginfo.h"
 
 #include <zlib.h>
 
diff --git a/accel/tcg/debuginfo.h b/include/tcg/debuginfo.h
similarity index 96%
rename from accel/tcg/debuginfo.h
rename to include/tcg/debuginfo.h
index f064e1c144b..858535b5da5 100644
--- a/accel/tcg/debuginfo.h
+++ b/include/tcg/debuginfo.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef ACCEL_TCG_DEBUGINFO_H
-#define ACCEL_TCG_DEBUGINFO_H
+#ifndef TCG_DEBUGINFO_H
+#define TCG_DEBUGINFO_H
 
 #include "qemu/bitops.h"
 
diff --git a/accel/tcg/perf.h b/include/tcg/perf.h
similarity index 95%
rename from accel/tcg/perf.h
rename to include/tcg/perf.h
index f92dd52c699..c96b5920a3f 100644
--- a/accel/tcg/perf.h
+++ b/include/tcg/perf.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef ACCEL_TCG_PERF_H
-#define ACCEL_TCG_PERF_H
+#ifndef TCG_PERF_H
+#define TCG_PERF_H
 
 #if defined(CONFIG_TCG) && defined(CONFIG_LINUX)
 /* Start writing perf-<pid>.map. */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 11c45ab2934..a43e6114ac4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "target_signal.h"
-#include "accel/tcg/debuginfo.h"
+#include "tcg/debuginfo.h"
 
 #ifdef TARGET_ARM
 #include "target/arm/cpu-features.h"
diff --git a/linux-user/exit.c b/linux-user/exit.c
index 50266314e0a..1ff8fe4f072 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -17,7 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #include "gdbstub/syscalls.h"
 #include "qemu.h"
 #include "user-internals.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index 84691d707b2..b0b270b8be3 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -55,7 +55,7 @@
 #include "signal-common.h"
 #include "loader.h"
 #include "user-mmap.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 
 #ifdef CONFIG_SEMIHOSTING
 #include "semihosting/semihost.h"
diff --git a/system/vl.c b/system/vl.c
index 2bcd9efb9a6..56baa1c81f2 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -96,7 +96,7 @@
 #endif
 #include "sysemu/qtest.h"
 #ifdef CONFIG_TCG
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #endif
 
 #include "disas/disas.h"
diff --git a/accel/tcg/debuginfo.c b/tcg/debuginfo.c
similarity index 98%
rename from accel/tcg/debuginfo.c
rename to tcg/debuginfo.c
index 71c66d04d12..3753f7ef67c 100644
--- a/accel/tcg/debuginfo.c
+++ b/tcg/debuginfo.c
@@ -6,11 +6,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/lockable.h"
+#include "tcg/debuginfo.h"
 
 #include <elfutils/libdwfl.h>
 
-#include "debuginfo.h"
-
 static QemuMutex lock;
 static Dwfl *dwfl;
 static const Dwfl_Callbacks dwfl_callbacks = {
diff --git a/tcg/meson.build b/tcg/meson.build
index 895a11d3fa2..28a699b4228 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -22,6 +22,9 @@ if get_option('tcg_interpreter')
   tcg_ss.add(files('tci.c'))
 endif
 
+tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
+tcg_ss.add(when: 'CONFIG_LINUX', if_true: files('perf.c'))
+
 tcg_ss = tcg_ss.apply(config_targetos, strict: false)
 
 libtcg_user = static_library('tcg_user',
diff --git a/accel/tcg/perf.c b/tcg/perf.c
similarity index 99%
rename from accel/tcg/perf.c
rename to tcg/perf.c
index 68a46b1b524..412a987d956 100644
--- a/accel/tcg/perf.c
+++ b/tcg/perf.c
@@ -11,13 +11,12 @@
 #include "qemu/osdep.h"
 #include "elf.h"
 #include "exec/target_page.h"
-#include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "qemu/timer.h"
+#include "tcg/debuginfo.h"
+#include "tcg/perf.h"
 #include "tcg/tcg.h"
 
-#include "debuginfo.h"
-#include "perf.h"
-
 static FILE *safe_fopen_w(const char *path)
 {
     int saved_errno;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d2ea22b397f..1a15a2a7c52 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -55,7 +55,7 @@
 #include "tcg/tcg-ldst.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg-internal.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #ifdef CONFIG_USER_ONLY
 #include "exec/user/guest-base.h"
 #endif
-- 
2.43.0


