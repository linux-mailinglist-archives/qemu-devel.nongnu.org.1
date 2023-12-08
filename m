Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C63B80975A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 01:39:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBOsi-0003eq-BZ; Thu, 07 Dec 2023 19:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rBOsf-0003eZ-Vu
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 19:38:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rBOsd-0000eV-Rq
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 19:38:13 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B80BKQh027665; Fri, 8 Dec 2023 00:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=K/K6OtE9x25QUKdxB4V7r8qn/CTih/Ys8Q6HysvEuOI=;
 b=NdOefONhMEl6WwaYIomaavQRW0Oaoo/GA2LYAG3I1keb4Wqd85uLyawGKb515JPmE5NV
 A91EwUI8JzJkalz50GS/12Egw0cAmyUFTrO7xYjFHWlOH8YiapqQ4hT63IzXrxoXoYB0
 e6+nv8qTu0c/hJg5iw8G2xf06yLMUy4hV0e1pydawwMPse8s5AcRLU5fLNabKamDYGvq
 CtHcRYlAOe6TwLuilALVlzLWLgklxhEnWKR1z/CqAnciy2oT6jKVgXpv80RHXdwRrBq+
 fPRe2nqRwcuHXCM/qmN7ut9VHdZiyD0HgQbJ4JXPIsUwkkYeXB9r3X22sKDOweL9DvjM eg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uurcggkrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:09 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B80K7RH021365;
 Fri, 8 Dec 2023 00:38:09 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uurcggkrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:08 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7MtGfW027013; Fri, 8 Dec 2023 00:38:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav36k0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B80c6D354264096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Dec 2023 00:38:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B9002004D;
 Fri,  8 Dec 2023 00:38:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D531520040;
 Fri,  8 Dec 2023 00:38:05 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.26])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Dec 2023 00:38:05 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 4/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Fri,  8 Dec 2023 01:35:36 +0100
Message-ID: <20231208003754.3688038-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208003754.3688038-1-iii@linux.ibm.com>
References: <20231208003754.3688038-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MdQ-qPv9AeiMt2a4_eXzQk4VwiaNTcnM
X-Proofpoint-ORIG-GUID: QiPZEDXS_Z9gCLiuaITMgzZ9WxG4ZDtH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_19,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080003
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
---
 accel/tcg/meson.build          | 2 --
 accel/tcg/translate-all.c      | 2 +-
 hw/core/loader.c               | 2 +-
 linux-user/elfload.c           | 2 +-
 linux-user/exit.c              | 2 +-
 linux-user/main.c              | 2 +-
 system/vl.c                    | 2 +-
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
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cf9e74468b1..62120c76151 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -21,7 +21,7 @@
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
index 0cdaf30d346..2e075ae1e69 100644
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
index 68a46b1b524..de34248d92d 100644
--- a/accel/tcg/perf.c
+++ b/tcg/perf.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "elf.h"
 #include "exec/target_page.h"
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


