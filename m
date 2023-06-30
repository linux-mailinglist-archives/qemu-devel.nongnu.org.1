Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3166474434B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 22:38:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFKsC-0008S0-Nd; Fri, 30 Jun 2023 16:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFKs9-0008RT-5P
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 16:37:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFKs7-0006K8-1s
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 16:37:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UKGFem032741; Fri, 30 Jun 2023 20:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=34+aVeyEn69PEMdUZcBdwpxOwEAR6dGjVHWvLTAHTCI=;
 b=Sjc2Gt8dR/1eyy9yzVGNuLoJieYNqbRYj8U7TArPG7g49Q4NOubnuc4bEQuBaNcMunke
 Pooqwq55ZavwegIHx7hQ/wRdds7hvJnI0mt/UupTaXT9zxVrLtvls60/s9dgXIyxaPtR
 nT1InFuWZ5RmpIWh8VpFhXBT2XoG3/KAe9nFlE+uBVScamV5N5Xk1zV9R9n/zMSAl19n
 ST36Igva9GohoqJkDTzXyJWxD0ooWLjotbtL73qnnq3TVbrN2GjQWLi60X63p4u1K3NC
 P1Zw1AdReNSvyip3yb1GJqdDntcmMCwM9hZFJ6gpns+Q3Ma48snjqtP4v9bOcKek1Gb1 +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj5xggh6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:37 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UKVcJZ019632;
 Fri, 30 Jun 2023 20:37:37 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj5xggh5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UJGwna024857;
 Fri, 30 Jun 2023 20:37:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr454dkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UKbWck62194138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 20:37:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0B5C20043;
 Fri, 30 Jun 2023 20:37:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F42820040;
 Fri, 30 Jun 2023 20:37:32 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.8.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 20:37:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 4/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Fri, 30 Jun 2023 22:36:41 +0200
Message-ID: <20230630203720.528552-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630203720.528552-1-iii@linux.ibm.com>
References: <20230630203720.528552-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ToG0MLzO1JYZP47uucTq_Bre_lKD_Mdj
X-Proofpoint-ORIG-GUID: cTG2MCpLmgjWuD0Zrqv8AIpXb7vr_7Lt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300179
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
 {accel/tcg => tcg}/perf.c      | 4 ++--
 {accel/tcg => tcg}/perf.h      | 4 ++--
 tcg/tcg.c                      | 2 +-
 13 files changed, 16 insertions(+), 15 deletions(-)
 rename {accel/tcg => tcg}/debuginfo.c (100%)
 rename {accel/tcg => tcg}/debuginfo.h (96%)
 rename {accel/tcg => tcg}/perf.c (98%)
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
similarity index 98%
rename from accel/tcg/perf.c
rename to tcg/perf.c
index e2813e11806..4a08fd9d259 100644
--- a/accel/tcg/perf.c
+++ b/tcg/perf.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "elf.h"
-#include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "qemu/timer.h"
 #include "tcg/tcg.h"
 
@@ -335,7 +335,7 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         /* FIXME: This replicates the restore_state_to_opc() logic. */
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
-            q[insn].address |= (guest_pc & TARGET_PAGE_MASK);
+            q[insn].address |= (guest_pc & qemu_target_page_mask());
         }
         q[insn].flags = DEBUGINFO_SYMBOL | (jitdump ? DEBUGINFO_LINE : 0);
     }
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


