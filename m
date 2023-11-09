Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF717E6B5B
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:45:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Ka-0008KD-Rj; Thu, 09 Nov 2023 08:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15KU-00081b-0S; Thu, 09 Nov 2023 08:44:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15KN-00014x-NL; Thu, 09 Nov 2023 08:44:14 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7315231B00;
 Thu,  9 Nov 2023 16:43:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 80E3E344A7;
 Thu,  9 Nov 2023 16:43:03 +0300 (MSK)
Received: (nullmailer pid 1461788 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 09/55] tests/vm: avoid invalid escape in Python string
Date: Thu,  9 Nov 2023 16:42:13 +0300
Message-Id: <20231109134300.1461632-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

This is an error in Python 3.12; fix it by using a raw string literal
or by double-escaping the backslash.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 86a8989d4557a09b68f8b78b6c3fb6ad3f23ca6f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index a97e23b0ce..6e31698906 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -331,8 +331,8 @@ def console_init(self, timeout = None):
     def console_log(self, text):
         for line in re.split("[\r\n]", text):
             # filter out terminal escape sequences
-            line = re.sub("\x1b\[[0-9;?]*[a-zA-Z]", "", line)
-            line = re.sub("\x1b\([0-9;?]*[a-zA-Z]", "", line)
+            line = re.sub("\x1b\\[[0-9;?]*[a-zA-Z]", "", line)
+            line = re.sub("\x1b\\([0-9;?]*[a-zA-Z]", "", line)
             # replace unprintable chars
             line = re.sub("\x1b", "<esc>", line)
             line = re.sub("[\x00-\x1f]", ".", line)
@@ -530,7 +530,7 @@ def get_qemu_version(qemu_path):
        and return the major number."""
     output = subprocess.check_output([qemu_path, '--version'])
     version_line = output.decode("utf-8")
-    version_num = re.split(' |\(', version_line)[3].split('.')[0]
+    version_num = re.split(r' |\(', version_line)[3].split('.')[0]
     return int(version_num)
 
 def parse_config(config, args):
-- 
2.39.2


