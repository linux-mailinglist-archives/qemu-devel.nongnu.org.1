Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95602B18F1B
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Aug 2025 16:23:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiD7k-0008LQ-Ch; Sat, 02 Aug 2025 10:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1uiD78-0007R3-Fz
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 10:21:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1uiD76-0000pD-Tl
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 10:21:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6566213D0C0;
 Sat, 02 Aug 2025 17:21:01 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B8CF92551CD;
 Sat,  2 Aug 2025 17:21:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 2/2] migration/vmstate: remove VMSTATE_BUFFER_POINTER_UNSAFE
 macro
Date: Sat,  2 Aug 2025 17:21:09 +0300
Message-ID: <20250802142115.41638-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250802142115.41638-1-mjt@tls.msk.ru>
References: <20250802142115.41638-1-mjt@tls.msk.ru>
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

The only user of this macro was VirtIONet.vlans, which has been
converted to regular VMSTATE_BUFFER.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/migration/vmstate.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ff7bd9ac4..ec0946c2aa 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -702,15 +702,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = offsetof(_state, _field),                          \
 }
 
-#define VMSTATE_BUFFER_POINTER_UNSAFE(_field, _state, _version, _size) { \
-    .name       = (stringify(_field)),                               \
-    .version_id = (_version),                                        \
-    .size       = (_size),                                           \
-    .info       = &vmstate_info_buffer,                              \
-    .flags      = VMS_BUFFER|VMS_POINTER,                            \
-    .offset     = offsetof(_state, _field),                          \
-}
-
 /* Allocate a temporary of type 'tmp_type', set tmp->parent to _state
  * and execute the vmsd on the temporary.  Note that we're working with
  * the whole of _state here, not a field within it.
-- 
2.47.2


