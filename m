Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ADA81A514
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:29:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzP3-0000Ol-EP; Wed, 20 Dec 2023 11:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOx-0000Mu-Es
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:31 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOr-0004Wi-LI
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:30 -0500
Received: (qmail 15097 invoked by uid 484); 20 Dec 2023 16:26:04 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.074878 secs); 20 Dec 2023 16:26:04 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:03 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 02/18] gdbstub: hex conversion functions moved to cutils.h
Date: Wed, 20 Dec 2023 17:25:39 +0100
Message-Id: <20231220162555.19545-3-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
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
 debug/gdbstub/gdbstub.c   | 19 ++++++++++---------
 debug/gdbstub/internals.h | 26 --------------------------
 include/qemu/cutils.h     | 30 ++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/debug/gdbstub/gdbstub.c b/debug/gdbstub/gdbstub.c
index 46d752bbc2..f43d4355c0 100644
--- a/debug/gdbstub/gdbstub.c
+++ b/debug/gdbstub/gdbstub.c
@@ -80,8 +80,8 @@ void gdb_memtohex(GString *buf, const uint8_t *mem, int len)
     int i, c;
     for(i = 0; i < len; i++) {
         c = mem[i];
-        g_string_append_c(buf, tohex(c >> 4));
-        g_string_append_c(buf, tohex(c & 0xf));
+        g_string_append_c(buf, nibble_to_hexchar(c >> 4));
+        g_string_append_c(buf, nibble_to_hexchar(c & 0xf));
     }
     g_string_append_c(buf, '\0');
 }
@@ -91,7 +91,8 @@ void gdb_hextomem(GByteArray *mem, const char *buf, int len)
     int i;
 
     for(i = 0; i < len; i++) {
-        guint8 byte = fromhex(buf[0]) << 4 | fromhex(buf[1]);
+        guint8 byte = hexchar_to_nibble(buf[0]) << 4 |
+                      hexchar_to_nibble(buf[1]);
         g_byte_array_append(mem, &byte, 1);
         buf += 2;
     }
@@ -118,8 +119,8 @@ static void hexdump(const char *buf, int len,
         if (i < len) {
             char value = buf[i];
 
-            line_buffer[hex_col + 0] = tohex((value >> 4) & 0xF);
-            line_buffer[hex_col + 1] = tohex((value >> 0) & 0xF);
+            line_buffer[hex_col + 0] = nibble_to_hexchar((value >> 4) & 0xF);
+            line_buffer[hex_col + 1] = nibble_to_hexchar((value >> 0) & 0xF);
             line_buffer[txt_col + 0] = (value >= ' ' && value < 127)
                     ? value
                     : '.';
@@ -151,8 +152,8 @@ int gdb_put_packet_binary(const char *buf, int len, bool dump)
             csum += buf[i];
         }
         footer[0] = '#';
-        footer[1] = tohex((csum >> 4) & 0xf);
-        footer[2] = tohex((csum) & 0xf);
+        footer[1] = nibble_to_hexchar((csum >> 4) & 0xf);
+        footer[2] = nibble_to_hexchar((csum) & 0xf);
         g_byte_array_append(gdbserver_state.last_packet, footer, 3);
 
         gdb_put_buffer(gdbserver_state.last_packet->data,
@@ -2267,7 +2268,7 @@ void gdb_read_byte(uint8_t ch)
                 break;
             }
             gdbserver_state.line_buf[gdbserver_state.line_buf_index] = '\0';
-            gdbserver_state.line_csum = fromhex(ch) << 4;
+            gdbserver_state.line_csum = hexchar_to_nibble(ch) << 4;
             gdbserver_state.state = RS_CHKSUM2;
             break;
         case RS_CHKSUM2:
@@ -2277,7 +2278,7 @@ void gdb_read_byte(uint8_t ch)
                 gdbserver_state.state = RS_GETLINE;
                 break;
             }
-            gdbserver_state.line_csum |= fromhex(ch);
+            gdbserver_state.line_csum |= hexchar_to_nibble(ch);
 
             if (gdbserver_state.line_csum != (gdbserver_state.line_sum & 0xff)) {
                 trace_gdbstub_err_checksum_incorrect(gdbserver_state.line_sum, gdbserver_state.line_csum);
diff --git a/debug/gdbstub/internals.h b/debug/gdbstub/internals.h
index 5c0c725e54..4b67adfeda 100644
--- a/debug/gdbstub/internals.h
+++ b/debug/gdbstub/internals.h
@@ -75,32 +75,6 @@ typedef struct GDBState {
 /* lives in main gdbstub.c */
 extern GDBState gdbserver_state;
 
-/*
- * Inline utility function, convert from int to hex and back
- */
-
-static inline int fromhex(int v)
-{
-    if (v >= '0' && v <= '9') {
-        return v - '0';
-    } else if (v >= 'A' && v <= 'F') {
-        return v - 'A' + 10;
-    } else if (v >= 'a' && v <= 'f') {
-        return v - 'a' + 10;
-    } else {
-        return 0;
-    }
-}
-
-static inline int tohex(int v)
-{
-    if (v < 10) {
-        return v + '0';
-    } else {
-        return v - 10 + 'a';
-    }
-}
-
 /*
  * Connection helpers for both system and user backends
  */
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 92c927a6a3..5ab1a4ffb0 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -267,4 +267,34 @@ void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
 void qemu_hexdump(FILE *fp, const char *prefix,
                   const void *bufptr, size_t size);
 
+
+/**
+ * hexchar_to_nibble() - Converts hex character to nibble.
+ */
+static inline int hexchar_to_nibble(int v)
+{
+    if (v >= '0' && v <= '9') {
+        return v - '0';
+    } else if (v >= 'A' && v <= 'F') {
+        return v - 'A' + 10;
+    } else if (v >= 'a' && v <= 'f') {
+        return v - 'a' + 10;
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+/**
+ * nibble_to_hexchar() - Converts nibble to hex character.
+ */
+static inline int nibble_to_hexchar(int v)
+{
+    g_assert(v <= 0xf);
+    if (v < 10) {
+        return v + '0';
+    } else {
+        return v - 10 + 'a';
+    }
+}
+
 #endif
-- 
2.34.1


