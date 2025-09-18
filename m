Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 382CEB47970
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Sep 2025 09:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv9Qv-0008Nd-An; Sun, 07 Sep 2025 03:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9Qt-0008MH-7u; Sun, 07 Sep 2025 03:03:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9Qj-0004Ne-Jg; Sun, 07 Sep 2025 03:03:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ABF43151053;
 Sun, 07 Sep 2025 10:02:04 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AEC8A2793C0;
 Sun,  7 Sep 2025 10:02:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 69/81] qga-vss: Write hex value of error in log
Date: Sun,  7 Sep 2025 10:01:48 +0300
Message-ID: <20250907070205.135289-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

QGA-VSS writes error using error_setg_win32_internal,
which call g_win32_error_message.

g_win32_error_message - translate a Win32 error code
(as returned by GetLastError()) into the corresponding message.

In the same time, we call error_setg_win32_internal with
error codes from different Windows componets like VSS or
Performance monitor that provides different codes and
can't be converted with g_win32_error_message. In this
case, the empty suffix will be returned so error will be
masked.

This commit directly add hex value of error code.

Reproduce:
 - Run QGA command: {"execute": "guest-fsfreeze-freeze-list", "arguments": {"mountpoints": ["D:"]}}

QGA error example:
 - before changes:
  {"error": {"class": "GenericError", "desc": "failed to add D: to snapshot set: "}}
 - after changes:
  {"error": {"class": "GenericError", "desc": "failed to add D: to snapshot set: Windows error 0x8004230e: "}}

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250825135311.138330-1-kkostiuk@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit edf3780a7dad4658ab7b72ea37e310a2be9b16d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 4401d55e3a..644514fb95 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -28,8 +28,9 @@
 
 #define err_set(e, err, fmt, ...) {                                         \
     (e)->error_setg_win32_wrapper((e)->errp, __FILE__, __LINE__, __func__,  \
-                                   err, fmt, ## __VA_ARGS__);               \
-    qga_debug(fmt, ## __VA_ARGS__);                                         \
+                                   err, fmt ": Windows error 0x%lx",        \
+                                   ## __VA_ARGS__, err);                    \
+    qga_debug(fmt ": Windows error 0x%lx", ## __VA_ARGS__, err);            \
 }
 /* Bad idea, works only when (e)->errp != NULL: */
 #define err_is_set(e) ((e)->errp && *(e)->errp)
-- 
2.47.3


