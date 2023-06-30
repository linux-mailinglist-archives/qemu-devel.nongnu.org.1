Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D974455B
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 01:43:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFNlQ-0008GC-0v; Fri, 30 Jun 2023 19:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFNlM-0008FR-8T
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:42:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFNlJ-0006js-Vu
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:42:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UNcBds008622; Fri, 30 Jun 2023 23:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cDkKInRLoMYMRaK+Z+S7+xesWG2Mtx2xXGlkPt8TPVw=;
 b=TWDAF/DGCxdeKrqYoJZB1MRaL7miHylvZG8NQtWm88+wdUXVswm/sevJRFXwK+1OzbWT
 3/830NoShr/Ci/t2tMR7sZE93Yh3hhtxyTQJRUcFesgVVCITR9NnhBVLSdAaJ5TG4p1N
 DfrkVj7KeStebDVFb2w6c+cwSGN5xnXkQzACxSW4+YIMWyQVn+eTDcg7PuVN7B5Of2bz
 4q2QV+OcE6jMRTqV/GL315Xe8IBJr37Q4az+7gWLyvcf+6xtIjyXWMVUipqd0FnIU8R6
 wahapphu0QI54bmCAqDnqlylnYGvKzAuwJ1aMAXUS/fBC3FUX61yYYndDozpRhA4lHLm NA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj8k7rcmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:47 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UNdjHV011583;
 Fri, 30 Jun 2023 23:42:46 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj8k7rcmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UNGGET014019;
 Fri, 30 Jun 2023 23:42:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre4fs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UNgfWs24576720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 23:42:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57CC92004B;
 Fri, 30 Jun 2023 23:42:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B63E120040;
 Fri, 30 Jun 2023 23:42:40 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.8.31])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 23:42:40 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 4/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Sat,  1 Jul 2023 01:40:57 +0200
Message-ID: <20230630234230.596193-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630234230.596193-1-iii@linux.ibm.com>
References: <20230630234230.596193-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fL4GuLse3Ihuc0wxLYL9XE-hSmVyRtOW
X-Proofpoint-GUID: NpG-9p11yxV0evY6FUOicTsssxC494Xo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300206
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

tcg/ should not depend on accel/tcg/, but perf and debuginfo
support provided by the latter are being used by tcg/tcg.c.

Since that's the only user, move both to tcg/.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/meson.build          | 2 --
 accel/tcg/translate-all.c      | 2 +-
 hw/core/loader.c               | 2 +-
 linux-user/elfload.c           | 2 +-
 linux-user/exit.c              | 2 +-
 linux-user/main.c              | 2 +-
 softmmu/vl.c                   | 2 +-
 {accel/tcg => tcg}/debuginfo.c | 0
 {accel/tcg => tcg}/debuginfo.h | 4 ++--
 tcg/meson.build                | 3 +++
 {accel/tcg => tcg}/perf.c      | 2 +-
 {accel/tcg => tcg}/perf.h      | 4 ++--
 tcg/tcg.c                      | 2 +-
 13 files changed, 15 insertions(+), 14 deletions(-)
 rename {accel/tcg => tcg}/debuginfo.c (100%)
 rename {accel/tcg => tcg}/debuginfo.h (96%)
 rename {accel/tcg => tcg}/perf.c (99%)
 rename {accel/tcg => tcg}/perf.h (95%)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 166bef173b8..083c9058391 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -12,8 +12,6 @@ tcg_ss.add(files(
 tcg_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
 tcg_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 tcg_ss.add(when: 'CONFIG_PLUGIN', if_true: [files('plugin-gen.c')])
-tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
-tcg_ss.add(when: 'CONFIG_LINUX', if_true: files('perf.c'))
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d3d4fbc1a41..58d9bd5a69e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -62,7 +62,7 @@
 #include "tb-hash.h"
 #include "tb-context.h"
 #include "internal.h"
-#include "perf.h"
+#include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
 
 TBContext tb_ctx;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8b7fd9e9e55..ad8d00440a7 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -62,7 +62,7 @@
 #include "hw/boards.h"
 #include "qemu/cutils.h"
 #include "sysemu/runstate.h"
-#include "accel/tcg/debuginfo.h"
+#include "tcg/debuginfo.h"
 
 #include <zlib.h>
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9a2ec568b09..6900974c373 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "target_signal.h"
-#include "accel/tcg/debuginfo.h"
+#include "tcg/debuginfo.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
diff --git a/linux-user/exit.c b/linux-user/exit.c
index 3017d28a3c3..122b9d904f1 100644
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
index dba67ffa362..3f65ca49db8 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -54,7 +54,7 @@
 #include "signal-common.h"
 #include "loader.h"
 #include "user-mmap.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 
 #ifdef CONFIG_SEMIHOSTING
 #include "semihosting/semihost.h"
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fac..92922377210 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -97,7 +97,7 @@
 #endif
 #include "sysemu/qtest.h"
 #ifdef CONFIG_TCG
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #endif
 
 #include "disas/disas.h"
diff --git a/accel/tcg/debuginfo.c b/tcg/debuginfo.c
similarity index 100%
rename from accel/tcg/debuginfo.c
rename to tcg/debuginfo.c
diff --git a/accel/tcg/debuginfo.h b/tcg/debuginfo.h
similarity index 96%
rename from accel/tcg/debuginfo.h
rename to tcg/debuginfo.h
index f064e1c144b..858535b5da5 100644
--- a/accel/tcg/debuginfo.h
+++ b/tcg/debuginfo.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef ACCEL_TCG_DEBUGINFO_H
-#define ACCEL_TCG_DEBUGINFO_H
+#ifndef TCG_DEBUGINFO_H
+#define TCG_DEBUGINFO_H
 
 #include "qemu/bitops.h"
 
diff --git a/tcg/meson.build b/tcg/meson.build
index c0252c41988..0800e1faae8 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -22,6 +22,9 @@ if get_option('tcg_interpreter')
   tcg_ss.add(files('tci.c'))
 endif
 
+tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
+tcg_ss.add(when: 'CONFIG_LINUX', if_true: files('perf.c'))
+
 tcg_ss = tcg_ss.apply(config_host, strict: false)
 
 libtcg_user = static_library('tcg_user',
diff --git a/accel/tcg/perf.c b/tcg/perf.c
similarity index 99%
rename from accel/tcg/perf.c
rename to tcg/perf.c
index 87583e9d8f2..4a08fd9d259 100644
--- a/accel/tcg/perf.c
+++ b/tcg/perf.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "elf.h"
-#include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "qemu/timer.h"
 #include "tcg/tcg.h"
 
diff --git a/accel/tcg/perf.h b/tcg/perf.h
similarity index 95%
rename from accel/tcg/perf.h
rename to tcg/perf.h
index f92dd52c699..c96b5920a3f 100644
--- a/accel/tcg/perf.h
+++ b/tcg/perf.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef ACCEL_TCG_PERF_H
-#define ACCEL_TCG_PERF_H
+#ifndef TCG_PERF_H
+#define TCG_PERF_H
 
 #if defined(CONFIG_TCG) && defined(CONFIG_LINUX)
 /* Start writing perf-<pid>.map. */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a0628fe4249..2afc5f2d0f7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -54,7 +54,7 @@
 #include "tcg/tcg-ldst.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg-internal.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #ifdef CONFIG_USER_ONLY
 #include "exec/user/guest-base.h"
 #endif
-- 
2.41.0


