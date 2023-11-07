Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A46E37E3FB5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:08:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lmw-0002j4-Iw; Tue, 07 Nov 2023 08:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkq-0008Pc-Fa
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:30 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkg-0005rX-DK
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:28 -0500
Received: (qmail 31007 invoked by uid 484); 7 Nov 2023 13:03:45 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.272829 secs); 07 Nov 2023 13:03:45 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:38 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 04/20] mcdstub: added header with defines specific to the
 mcd tcp packet communication
Date: Tue,  7 Nov 2023 14:03:07 +0100
Message-Id: <20231107130323.4126-5-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
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

---
 include/mcdstub/mcd_shared_defines.h | 108 +++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 include/mcdstub/mcd_shared_defines.h

diff --git a/include/mcdstub/mcd_shared_defines.h b/include/mcdstub/mcd_shared_defines.h
new file mode 100644
index 0000000000..fa1adb5c77
--- /dev/null
+++ b/include/mcdstub/mcd_shared_defines.h
@@ -0,0 +1,108 @@
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
-- 
2.34.1


