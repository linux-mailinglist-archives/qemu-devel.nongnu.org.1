Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3347125FB
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VyP-000225-Ps; Fri, 26 May 2023 07:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q2VyM-00021C-4f
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:51:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q2VyI-00089f-Vu
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:51:05 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QBIJhk031411; Fri, 26 May 2023 11:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=As/OwrM6AGVrt1G+7JDahiULqovgkUhFm9nIHze/+Zw=;
 b=XGUzDKi3YmaAc6//T1Xud4A/43nQZKw7j9BK4OH2tKwqZbtUpXzSbHIWpYRipDfRGAFh
 7vlEjMvwqWGaC8MyJjYQ7F0aa8bgEWWjr+/2FS8jqIWYrjIdl6JLxSuI+MSr9UX9MhsW
 NrPy8/bFaaiWJtkyP+9hVGlJS+nR5ZgwZf3SUNc3M3iq/sQC5i/EQU7dWoaC2q+i+7lt
 KzUjHyZNrICATgqm+Wfkx/xBdaDGQXFAhPyHazVAMhHeXTmYrskZgdNo+fsr7fsnNSN3
 NqvfPYxT/9dHnrJwpeczhdUYRdf0K4D8A/23W0Qgb7c2cms7b5xHqJDY7serBOyGQSX9 CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtuse0m26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:51:00 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QBn8GY024837;
 Fri, 26 May 2023 11:51:00 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtuse0m1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:51:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q4vnWA011872;
 Fri, 26 May 2023 11:50:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qppc3jwet-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:50:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34QBosK145613778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 11:50:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 413E520043;
 Fri, 26 May 2023 11:50:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A145C20040;
 Fri, 26 May 2023 11:50:53 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.55.92])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 11:50:53 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: "Dominik 'Disconnect3d' Czarnota" <dominik.b.czarnota@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Andreas Arnez <arnez@linux.ibm.com>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 4/6] gdbstub: Add support for info proc mappings
Date: Fri, 26 May 2023 13:50:39 +0200
Message-Id: <20230526115041.1362009-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526115041.1362009-1-iii@linux.ibm.com>
References: <20230526115041.1362009-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3GaHMaNiSsfG4UI973VU4DKufDSTfOrv
X-Proofpoint-ORIG-GUID: DFLZp5w9_A0ao_RStvRMdhZ6H-T7kzEc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260099
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

Currently the GDB's generate-core-file command doesn't work well with
qemu-user: the resulting dumps are huge [1] and at the same time
incomplete (argv and envp are missing). The reason is that GDB has no
access to proc mappings and therefore has to fall back to using
heuristics for discovering them. This is, in turn, because qemu-user
does not implement the Host I/O feature of the GDB Remote Serial
Protocol.

Implement vFile:{open,close,pread,readlink} and also
qXfer:exec-file:read+.

With that, generate-core-file begins to work on aarch64 and s390x,
albeit with two deficiencies:

* GDB still tries to dump the host mappings, because QEMU does not fake
  /proc/$PID/smaps (as opposed to /proc/$PID/maps). The user-visible
  effect is only a bunch of warnings.
* PT_LOAD segments lack PF_X flags (I have not debugged this).

The impact of these issues on usability is fairly low, so they can be
resolved later.

[1] https://sourceware.org/pipermail/gdb-patches/2023-May/199432.html

Co-developed-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c     |  45 +++++++++++++-
 gdbstub/internals.h   |   5 ++
 gdbstub/user-target.c | 139 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index c7e3ee71f2f..d2efefd3528 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1337,6 +1337,36 @@ static const GdbCmdParseEntry gdb_v_commands_table[] = {
         .cmd = "Kill;",
         .cmd_startswith = 1
     },
+#ifdef CONFIG_USER_ONLY
+    /*
+     * Host I/O Packets. See [1] for details.
+     * [1] https://sourceware.org/gdb/onlinedocs/gdb/Host-I_002fO-Packets.html
+     */
+    {
+        .handler = gdb_handle_v_file_open,
+        .cmd = "File:open:",
+        .cmd_startswith = 1,
+        .schema = "s,L,L0"
+    },
+    {
+        .handler = gdb_handle_v_file_close,
+        .cmd = "File:close:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+    {
+        .handler = gdb_handle_v_file_pread,
+        .cmd = "File:pread:",
+        .cmd_startswith = 1,
+        .schema = "l,L,L0"
+    },
+    {
+        .handler = gdb_handle_v_file_readlink,
+        .cmd = "File:readlink:",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+#endif
 };
 
 static void handle_v_commands(GArray *params, void *user_ctx)
@@ -1482,11 +1512,14 @@ static void handle_query_supported(GArray *params, void *user_ctx)
             ";ReverseStep+;ReverseContinue+");
     }
 
-#if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
+#if defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_LINUX)
     if (gdbserver_state.c_cpu->opaque) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
     }
 #endif
+    g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
+#endif
 
     if (params->len &&
         strstr(get_param(params, 0)->data, "multiprocess+")) {
@@ -1625,13 +1658,21 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
         .cmd_startswith = 1,
         .schema = "s:l,l0"
     },
-#if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
+#if defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_LINUX)
     {
         .handler = gdb_handle_query_xfer_auxv,
         .cmd = "Xfer:auxv:read::",
         .cmd_startswith = 1,
         .schema = "l,l0"
     },
+#endif
+    {
+        .handler = gdb_handle_query_xfer_exec_file,
+        .cmd = "Xfer:exec-file:read:",
+        .cmd_startswith = 1,
+        .schema = "l:l,l0"
+    },
 #endif
     {
         .handler = gdb_handle_query_attached,
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 25e4d5eeaa6..f2b46cce412 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -189,6 +189,11 @@ typedef union GdbCmdVariant {
 void gdb_handle_query_rcmd(GArray *params, void *user_ctx); /* softmmu */
 void gdb_handle_query_offsets(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx); /*user */
+void gdb_handle_v_file_open(GArray *params, void *user_ctx); /* user */
+void gdb_handle_v_file_close(GArray *params, void *user_ctx); /* user */
+void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
+void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
+void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index fa0e59ec9a5..09df05b5526 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -11,6 +11,10 @@
 #include "exec/gdbstub.h"
 #include "qemu.h"
 #include "internals.h"
+#ifdef CONFIG_LINUX
+#include "linux-user/loader.h"
+#include "linux-user/qemu.h"
+#endif
 
 /*
  * Map target signal numbers to GDB protocol signal numbers and vice
@@ -281,3 +285,138 @@ void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx)
                       gdbserver_state.str_buf->len, true);
 }
 #endif
+
+static const char *get_filename_param(GArray *params, int i)
+{
+    const char *hex_filename = get_param(params, i)->data;
+    gdb_hextomem(gdbserver_state.mem_buf, hex_filename,
+                 strlen(hex_filename) / 2);
+    g_byte_array_append(gdbserver_state.mem_buf, (const guint8 *)"", 1);
+    return (const char *)gdbserver_state.mem_buf->data;
+}
+
+static void hostio_reply_with_data(const void *buf, size_t n)
+{
+    g_string_printf(gdbserver_state.str_buf, "F%lx;", n);
+    gdb_memtox(gdbserver_state.str_buf, buf, n);
+    gdb_put_packet_binary(gdbserver_state.str_buf->str,
+                          gdbserver_state.str_buf->len, true);
+}
+
+void gdb_handle_v_file_open(GArray *params, void *user_ctx)
+{
+    const char *filename = get_filename_param(params, 0);
+    uint64_t flags = get_param(params, 1)->val_ull;
+    uint64_t mode = get_param(params, 2)->val_ull;
+
+#ifdef CONFIG_LINUX
+    int fd = do_guest_openat(gdbserver_state.g_cpu->env_ptr, 0, filename,
+                             flags, mode);
+#else
+    int fd = open(filename, flags, mode);
+#endif
+    if (fd < 0) {
+        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+    } else {
+        g_string_printf(gdbserver_state.str_buf, "F%d", fd);
+    }
+    gdb_put_strbuf();
+}
+
+void gdb_handle_v_file_close(GArray *params, void *user_ctx)
+{
+    int fd = get_param(params, 0)->val_ul;
+
+    if (close(fd) == -1) {
+        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        gdb_put_strbuf();
+        return;
+    }
+
+    gdb_put_packet("F00");
+}
+
+#define BUFSIZ 8192
+
+void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
+{
+    int fd = get_param(params, 0)->val_ul;
+    size_t count = get_param(params, 1)->val_ull;
+    off_t offset = get_param(params, 2)->val_ull;
+
+    size_t bufsiz = MIN(count, BUFSIZ);
+    g_autofree char *buf = g_try_malloc(bufsiz);
+    if (buf == NULL) {
+        gdb_put_packet("E12");
+        return;
+    }
+
+    ssize_t n = pread(fd, buf, bufsiz, offset);
+    if (n < 0) {
+        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        gdb_put_strbuf();
+        return;
+    }
+    hostio_reply_with_data(buf, n);
+}
+
+void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
+{
+    const char *filename = get_filename_param(params, 0);
+
+    g_autofree char *buf = g_try_malloc(BUFSIZ);
+    if (buf == NULL) {
+        gdb_put_packet("E12");
+        return;
+    }
+
+#ifdef CONFIG_LINUX
+    ssize_t n = do_guest_readlink(filename, buf, BUFSIZ);
+#else
+    ssize_t n = readlink(filename, buf, BUFSIZ);
+#endif
+    if (n < 0) {
+        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        gdb_put_strbuf();
+        return;
+    }
+    hostio_reply_with_data(buf, n);
+}
+
+void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx)
+{
+    uint32_t pid = get_param(params, 0)->val_ul;
+    uint32_t offset = get_param(params, 1)->val_ul;
+    uint32_t length = get_param(params, 2)->val_ul;
+
+    GDBProcess *process = gdb_get_process(pid);
+    if (!process) {
+        gdb_put_packet("E00");
+        return;
+    }
+
+    CPUState *cpu = gdb_get_first_cpu_in_process(process);
+    if (!cpu) {
+        gdb_put_packet("E00");
+        return;
+    }
+
+    TaskState *ts = cpu->opaque;
+    if (!ts || !ts->bprm || !ts->bprm->filename) {
+        gdb_put_packet("E00");
+        return;
+    }
+
+    size_t total_length = strlen(ts->bprm->filename);
+    if (offset > total_length) {
+        gdb_put_packet("E00");
+        return;
+    }
+    if (offset + length > total_length) {
+        length = total_length - offset;
+    }
+
+    g_string_printf(gdbserver_state.str_buf, "l%.*s", length,
+                    ts->bprm->filename + offset);
+    gdb_put_strbuf();
+}
-- 
2.40.1


