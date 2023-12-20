Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFDC81A4FB
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:27:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzP6-0000RN-5z; Wed, 20 Dec 2023 11:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOx-0000Mr-EP
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:31 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOr-0004Ur-LI
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:30 -0500
Received: (qmail 15075 invoked by uid 484); 20 Dec 2023 16:26:03 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.35455 secs); 20 Dec 2023 16:26:03 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:02 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 01/18] gdbstub,
 mcdstub: file and build structure adapted to accomodate for the
 mcdstub
Date: Wed, 20 Dec 2023 17:25:38 +0100
Message-Id: <20231220162555.19545-2-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

mcdstub files created including the shared header between the mcd shared library and the mcdstub.
MAINTAINERS file updated
---
 MAINTAINERS                              |  11 +-
 debug/common/debug.c                     |  18 ++++
 debug/common/meson.build                 |   0
 {gdbstub => debug/gdbstub}/gdbstub.c     |   0
 {gdbstub => debug/gdbstub}/internals.h   |   0
 {gdbstub => debug/gdbstub}/meson.build   |   0
 {gdbstub => debug/gdbstub}/syscalls.c    |   0
 {gdbstub => debug/gdbstub}/system.c      |   0
 {gdbstub => debug/gdbstub}/trace-events  |   0
 debug/gdbstub/trace.h                    |   1 +
 {gdbstub => debug/gdbstub}/user-target.c |   0
 {gdbstub => debug/gdbstub}/user.c        |   0
 debug/mcdstub/arm_mcdstub.c              |  18 ++++
 debug/mcdstub/mcdstub.c                  |  18 ++++
 debug/mcdstub/meson.build                |   0
 debug/meson.build                        |   1 +
 gdbstub/trace.h                          |   1 -
 include/mcdstub/arm_mcdstub.h            |  18 ++++
 include/mcdstub/mcd_shared_defines.h     | 132 +++++++++++++++++++++++
 include/mcdstub/mcdstub.h                |  18 ++++
 include/mcdstub/mcdstub_common.h         |  18 ++++
 include/qemu/debug.h                     |  18 ++++
 meson.build                              |   4 +-
 23 files changed, 272 insertions(+), 4 deletions(-)
 create mode 100644 debug/common/debug.c
 create mode 100644 debug/common/meson.build
 rename {gdbstub => debug/gdbstub}/gdbstub.c (100%)
 rename {gdbstub => debug/gdbstub}/internals.h (100%)
 rename {gdbstub => debug/gdbstub}/meson.build (100%)
 rename {gdbstub => debug/gdbstub}/syscalls.c (100%)
 rename {gdbstub => debug/gdbstub}/system.c (100%)
 rename {gdbstub => debug/gdbstub}/trace-events (100%)
 create mode 100644 debug/gdbstub/trace.h
 rename {gdbstub => debug/gdbstub}/user-target.c (100%)
 rename {gdbstub => debug/gdbstub}/user.c (100%)
 create mode 100644 debug/mcdstub/arm_mcdstub.c
 create mode 100644 debug/mcdstub/mcdstub.c
 create mode 100644 debug/mcdstub/meson.build
 create mode 100644 debug/meson.build
 delete mode 100644 gdbstub/trace.h
 create mode 100644 include/mcdstub/arm_mcdstub.h
 create mode 100644 include/mcdstub/mcd_shared_defines.h
 create mode 100644 include/mcdstub/mcdstub.h
 create mode 100644 include/mcdstub/mcdstub_common.h
 create mode 100644 include/qemu/debug.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 695e0bd34f..467da56a38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2955,7 +2955,7 @@ M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: docs/system/gdb.rst
-F: gdbstub/*
+F: debug/gdbstub/*
 F: include/exec/gdbstub.h
 F: include/gdbstub/*
 F: gdb-xml/
@@ -2963,6 +2963,15 @@ F: tests/tcg/multiarch/gdbstub/*
 F: scripts/feature_to_c.py
 F: scripts/probe-gdb-support.py
 
+MCD stub
+M: Nicolas Eder <nicolas.eder@lauterbach.com>
+R: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
+F: debug/mcdstub/*
+F: debug/common/*
+F: include/mcdstub/*
+F: include/qemu/debug.h
+
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Xu <peterx@redhat.com>
diff --git a/debug/common/debug.c b/debug/common/debug.c
new file mode 100644
index 0000000000..c24aaf1202
--- /dev/null
+++ b/debug/common/debug.c
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2023 Nicolas Eder
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.0+
+ */
diff --git a/debug/common/meson.build b/debug/common/meson.build
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/gdbstub/gdbstub.c b/debug/gdbstub/gdbstub.c
similarity index 100%
rename from gdbstub/gdbstub.c
rename to debug/gdbstub/gdbstub.c
diff --git a/gdbstub/internals.h b/debug/gdbstub/internals.h
similarity index 100%
rename from gdbstub/internals.h
rename to debug/gdbstub/internals.h
diff --git a/gdbstub/meson.build b/debug/gdbstub/meson.build
similarity index 100%
rename from gdbstub/meson.build
rename to debug/gdbstub/meson.build
diff --git a/gdbstub/syscalls.c b/debug/gdbstub/syscalls.c
similarity index 100%
rename from gdbstub/syscalls.c
rename to debug/gdbstub/syscalls.c
diff --git a/gdbstub/system.c b/debug/gdbstub/system.c
similarity index 100%
rename from gdbstub/system.c
rename to debug/gdbstub/system.c
diff --git a/gdbstub/trace-events b/debug/gdbstub/trace-events
similarity index 100%
rename from gdbstub/trace-events
rename to debug/gdbstub/trace-events
diff --git a/debug/gdbstub/trace.h b/debug/gdbstub/trace.h
new file mode 100644
index 0000000000..ca6f0e8d29
--- /dev/null
+++ b/debug/gdbstub/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-debug_gdbstub.h"
diff --git a/gdbstub/user-target.c b/debug/gdbstub/user-target.c
similarity index 100%
rename from gdbstub/user-target.c
rename to debug/gdbstub/user-target.c
diff --git a/gdbstub/user.c b/debug/gdbstub/user.c
similarity index 100%
rename from gdbstub/user.c
rename to debug/gdbstub/user.c
diff --git a/debug/mcdstub/arm_mcdstub.c b/debug/mcdstub/arm_mcdstub.c
new file mode 100644
index 0000000000..c24aaf1202
--- /dev/null
+++ b/debug/mcdstub/arm_mcdstub.c
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2023 Nicolas Eder
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.0+
+ */
diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
new file mode 100644
index 0000000000..c24aaf1202
--- /dev/null
+++ b/debug/mcdstub/mcdstub.c
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2023 Nicolas Eder
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.0+
+ */
diff --git a/debug/mcdstub/meson.build b/debug/mcdstub/meson.build
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/debug/meson.build b/debug/meson.build
new file mode 100644
index 0000000000..a5b093f31e
--- /dev/null
+++ b/debug/meson.build
@@ -0,0 +1 @@
+subdir('gdbstub')
diff --git a/gdbstub/trace.h b/gdbstub/trace.h
deleted file mode 100644
index dee87b1238..0000000000
--- a/gdbstub/trace.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "trace/trace-gdbstub.h"
diff --git a/include/mcdstub/arm_mcdstub.h b/include/mcdstub/arm_mcdstub.h
new file mode 100644
index 0000000000..c24aaf1202
--- /dev/null
+++ b/include/mcdstub/arm_mcdstub.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2023 Nicolas Eder
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.0+
+ */
diff --git a/include/mcdstub/mcd_shared_defines.h b/include/mcdstub/mcd_shared_defines.h
new file mode 100644
index 0000000000..b6f2d81c34
--- /dev/null
+++ b/include/mcdstub/mcd_shared_defines.h
@@ -0,0 +1,132 @@
+/*
+ * MIT License
+ *
+ * Copyright (c) 2023 Lauterbach GmbH, Nicolas Eder
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+/*
+ *this file is shared between the mcd dll and the mcd stub.
+ *it has to be kept exectly the same!
+ */
+
+#ifndef MCD_SHARED_DEFINES
+#define MCD_SHARED_DEFINES
+
+/* default tcp port */
+#define MCD_DEFAULT_TCP_PORT "1235"
+
+/* tcp data characters */
+#define TCP_CHAR_OPEN_SERVER 'I'
+#define TCP_CHAR_OPEN_CORE 'i'
+#define TCP_CHAR_GO 'C'
+#define TCP_CHAR_STEP 'c'
+#define TCP_CHAR_BREAK 'b'
+#define TCP_CHAR_QUERY 'q'
+#define TCP_CHAR_CLOSE_SERVER 'D'
+#define TCP_CHAR_CLOSE_CORE 'd'
+#define TCP_CHAR_KILLQEMU 'k'
+#define TCP_CHAR_RESET 'r'
+#define TCP_CHAR_READ_REGISTER 'p'
+#define TCP_CHAR_WRITE_REGISTER 'P'
+#define TCP_CHAR_READ_MEMORY 'm'
+#define TCP_CHAR_WRITE_MEMORY 'M'
+#define TCP_CHAR_BREAKPOINT_INSERT 't'
+#define TCP_CHAR_BREAKPOINT_REMOVE 'T'
+
+/* tcp protocol chars */
+#define TCP_ACKNOWLEDGED '+'
+#define TCP_NOT_ACKNOWLEDGED '-'
+#define TCP_COMMAND_START '$'
+#define TCP_COMMAND_END '#'
+#define TCP_WAS_LAST '|'
+#define TCP_WAS_NOT_LAST '~'
+#define TCP_HANDSHAKE_SUCCESS "shaking your hand"
+#define TCP_EXECUTION_SUCCESS "success"
+#define TCP_EXECUTION_ERROR "error"
+
+/* tcp query arguments */
+#define QUERY_FIRST "f"
+#define QUERY_CONSEQUTIVE "c"
+#define QUERY_END_INDEX "!"
+
+#define QUERY_ARG_SYSTEM "system"
+#define QUERY_ARG_CORES "cores"
+#define QUERY_ARG_RESET "reset"
+#define QUERY_ARG_TRIGGER "trigger"
+#define QUERY_ARG_MEMORY "memory"
+#define QUERY_ARG_REGGROUP "reggroup"
+#define QUERY_ARG_REG "reg"
+#define QUERY_ARG_STATE "state"
+
+/* tcp query packet argument list */
+#define TCP_ARGUMENT_NAME "name"
+#define TCP_ARGUMENT_DATA "data"
+#define TCP_ARGUMENT_ID "id"
+#define TCP_ARGUMENT_TYPE "type"
+#define TCP_ARGUMENT_BITS_PER_MAU "bpm"
+#define TCP_ARGUMENT_INVARIANCE "i"
+#define TCP_ARGUMENT_ENDIAN "e"
+#define TCP_ARGUMENT_MIN "min"
+#define TCP_ARGUMENT_MAX "max"
+#define TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS "sao"
+#define TCP_ARGUMENT_REGGROUPID "reggroupid"
+#define TCP_ARGUMENT_MEMSPACEID "memspaceid"
+#define TCP_ARGUMENT_SIZE "size"
+#define TCP_ARGUMENT_THREAD "thread"
+#define TCP_ARGUMENT_ADDRESS "address"
+#define TCP_ARGUMENT_STOP_STRING "stop_str"
+#define TCP_ARGUMENT_INFO_STRING "info_str"
+#define TCP_ARGUMENT_STATE "state"
+#define TCP_ARGUMENT_EVENT "event"
+#define TCP_ARGUMENT_DEVICE "device"
+#define TCP_ARGUMENT_CORE "core"
+#define TCP_ARGUMENT_AMOUNT_CORE "nr_cores"
+#define TCP_ARGUMENT_AMOUNT_TRIGGER "nr_trigger"
+#define TCP_ARGUMENT_OPTION "option"
+#define TCP_ARGUMENT_ACTION "action"
+#define TCP_ARGUMENT_OPCODE "opcode"
+
+/* for packets sent to qemu */
+#define ARGUMENT_SEPARATOR ';'
+#define NEGATIVE_FLAG 0
+#define POSITIVE_FLAG 1
+
+/* core states */
+#define CORE_STATE_RUNNING "running"
+#define CORE_STATE_HALTED "halted"
+#define CORE_STATE_DEBUG "debug"
+#define CORE_STATE_UNKNOWN "unknown"
+
+/* breakpoint types */
+#define MCD_BREAKPOINT_HW 1
+#define MCD_BREAKPOINT_READ 2
+#define MCD_BREAKPOINT_WRITE 3
+#define MCD_BREAKPOINT_RW 4
+
+/* trigger data */
+#define MCD_TRIG_ACT_BREAK "check_data_value"
+#define MCD_TRIG_OPT_VALUE "break_on_trigger"
+
+/* register mem space key words */
+#define MCD_GRP_KEYWORD "GPR"
+#define MCD_CP_KEYWORD "CP"
+
+#endif
diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
new file mode 100644
index 0000000000..c24aaf1202
--- /dev/null
+++ b/include/mcdstub/mcdstub.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2023 Nicolas Eder
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.0+
+ */
diff --git a/include/mcdstub/mcdstub_common.h b/include/mcdstub/mcdstub_common.h
new file mode 100644
index 0000000000..c24aaf1202
--- /dev/null
+++ b/include/mcdstub/mcdstub_common.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2023 Nicolas Eder
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.0+
+ */
diff --git a/include/qemu/debug.h b/include/qemu/debug.h
new file mode 100644
index 0000000000..c24aaf1202
--- /dev/null
+++ b/include/qemu/debug.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2023 Nicolas Eder
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.0+
+ */
diff --git a/meson.build b/meson.build
index d2c4c2adb3..2e1a7048e9 100644
--- a/meson.build
+++ b/meson.build
@@ -3263,7 +3263,7 @@ trace_events_subdirs = [
   'qom',
   'monitor',
   'util',
-  'gdbstub',
+  'debug/gdbstub',
 ]
 if have_linux_user
   trace_events_subdirs += [ 'linux-user' ]
@@ -3389,7 +3389,7 @@ subdir('authz')
 subdir('crypto')
 subdir('ui')
 subdir('hw')
-subdir('gdbstub')
+subdir('debug')
 
 if enable_modules
   libmodulecommon = static_library('module-common', files('module-common.c') + genh, pic: true, c_args: '-DBUILD_DSO')
-- 
2.34.1


