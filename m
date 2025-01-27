Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA0A1D83A
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Jan 2025 15:24:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ1Y-0000X5-5A; Mon, 27 Jan 2025 09:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ1K-00082i-JW; Mon, 27 Jan 2025 09:23:22 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ1I-0002vD-RP; Mon, 27 Jan 2025 09:23:22 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 04401E0F56;
 Mon, 27 Jan 2025 17:22:48 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 8A75851D8D; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 20/41] migration: Fix parsing of s390 stream
Date: Mon, 27 Jan 2025 17:17:34 +0300
Message-Id: <20250127141803.3514882-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

The parsing for the S390StorageAttributes section is currently leaving
an unconsumed token that is later interpreted by the generic code as
QEMU_VM_EOF, cutting the parsing short.

The migration will issue a STATTR_FLAG_DONE between iterations, which
the script consumes correctly, but there's a final STATTR_FLAG_EOS at
.save_complete that the script is ignoring. Since the EOS flag is a
u64 0x1ULL and the stream is big endian, on little endian hosts a byte
read from it will be 0x0, the same as QEMU_VM_EOF.

Fixes: 81c2c9dd5d ("tests/qtest/migration-test: Fix analyze-migration.py for s390x")
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250109185249.23952-4-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 69d1f784569fdb950f2923c3b6d00d7c1b71acc1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index f2457b1dde..fcda11f31d 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -65,6 +65,9 @@ def readvar(self, size = None):
     def tell(self):
         return self.file.tell()
 
+    def seek(self, a, b):
+        return self.file.seek(a, b)
+
     # The VMSD description is at the end of the file, after EOF. Look for
     # the last NULL byte, then for the beginning brace of JSON.
     def read_migration_debug_json(self):
@@ -272,11 +275,24 @@ def __init__(self, file, version_id, device, section_key):
         self.section_key = section_key
 
     def read(self):
+        pos = 0
         while True:
             addr_flags = self.file.read64()
             flags = addr_flags & 0xfff
-            if (flags & (self.STATTR_FLAG_DONE | self.STATTR_FLAG_EOS)):
+
+            if flags & self.STATTR_FLAG_DONE:
+                pos = self.file.tell()
+                continue
+            elif flags & self.STATTR_FLAG_EOS:
                 return
+            else:
+                # No EOS came after DONE, that's OK, but rewind the
+                # stream because this is not our data.
+                if pos:
+                    self.file.seek(pos, os.SEEK_SET)
+                    return
+                raise Exception("Unknown flags %x", flags)
+
             if (flags & self.STATTR_FLAG_ERROR):
                 raise Exception("Error in migration stream")
             count = self.file.read64()
-- 
2.39.5


