Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2AB7CCAFC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:46:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsp4L-00060V-S4; Tue, 17 Oct 2023 14:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsp45-0005pf-5s; Tue, 17 Oct 2023 14:45:14 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsp3v-0004sd-Gz; Tue, 17 Oct 2023 14:45:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 41A9362366;
 Tue, 17 Oct 2023 21:45:00 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jipbAUIOliE0-avmLuGzw; Tue, 17 Oct 2023 21:44:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697568299;
 bh=Swbe2puPhj7f4i6yWAywP7KloB3s1bhKV+rXDxt3trk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=UWY/mbMbsfn07L+UwWvSAg2fOTazsQDYFAEwShaHy6Cu0+m8iHPouSQLQpd6AWmZz
 fLSKzUFDjkwNBym/4qYuMAuMJqzo6JyoD+FwsrST74lkqa+hZ/7ZR4YJgnoBYXrb22
 Cg8KIodO4zMzdp5BfjD3Etg84kkterRSzMInh1Aw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH v8 5/7] block: bdrv_get_xdbg_block_graph(): report export ids
Date: Tue, 17 Oct 2023 21:44:42 +0300
Message-Id: <20231017184444.932733-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017184444.932733-1-vsementsov@yandex-team.ru>
References: <20231017184444.932733-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently for block exports we report empty blk names. That's not good.
Let's try to find corresponding block export and report its id.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block.c                     |  4 ++++
 block/export/export.c       | 13 +++++++++++++
 include/block/export.h      |  1 +
 stubs/blk-exp-find-by-blk.c |  9 +++++++++
 stubs/meson.build           |  1 +
 5 files changed, 28 insertions(+)
 create mode 100644 stubs/blk-exp-find-by-blk.c

diff --git a/block.c b/block.c
index 6215ee9f28..e0b83e6181 100644
--- a/block.c
+++ b/block.c
@@ -6429,7 +6429,11 @@ XDbgBlockGraph *bdrv_get_xdbg_block_graph(Error **errp)
     for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
         char *allocated_name = NULL;
         const char *name = blk_name(blk);
+        BlockExport *exp = blk_exp_find_by_blk(blk);
 
+        if (!*name && exp) {
+            name = exp->id;
+        }
         if (!*name) {
             name = allocated_name = blk_get_attached_dev_id(blk);
         }
diff --git a/block/export/export.c b/block/export/export.c
index d68c5d78ca..192ae79a24 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -60,6 +60,19 @@ BlockExport *blk_exp_find(const char *id)
     return NULL;
 }
 
+BlockExport *blk_exp_find_by_blk(BlockBackend *blk)
+{
+    BlockExport *exp;
+
+    QLIST_FOREACH(exp, &block_exports, next) {
+        if (exp->blk == blk) {
+            return exp;
+        }
+    }
+
+    return NULL;
+}
+
 static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
 {
     int i;
diff --git a/include/block/export.h b/include/block/export.h
index f2fe0f8078..16863d37cf 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -82,6 +82,7 @@ struct BlockExport {
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
 BlockExport *blk_exp_find(const char *id);
+BlockExport *blk_exp_find_by_blk(BlockBackend *blk);
 void blk_exp_ref(BlockExport *exp);
 void blk_exp_unref(BlockExport *exp);
 void blk_exp_request_shutdown(BlockExport *exp);
diff --git a/stubs/blk-exp-find-by-blk.c b/stubs/blk-exp-find-by-blk.c
new file mode 100644
index 0000000000..2fc1da953b
--- /dev/null
+++ b/stubs/blk-exp-find-by-blk.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "sysemu/block-backend.h"
+#include "block/export.h"
+
+BlockExport *blk_exp_find_by_blk(BlockBackend *blk)
+{
+    return NULL;
+}
+
diff --git a/stubs/meson.build b/stubs/meson.build
index 6ff8db71f9..7524a8f90e 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -2,6 +2,7 @@ stub_ss.add(files('bdrv-next-monitor-owned.c'))
 stub_ss.add(files('blk-commit-all.c'))
 stub_ss.add(files('blk-exp-close-all.c'))
 stub_ss.add(files('blk-by-qdev-id.c'))
+stub_ss.add(files('blk-exp-find-by-blk.c'))
 stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
 stub_ss.add(files('change-state-handler.c'))
 stub_ss.add(files('cmos.c'))
-- 
2.34.1


