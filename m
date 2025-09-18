Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 480E9B479D7
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Sep 2025 10:45:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv9Qx-0008S8-VM; Sun, 07 Sep 2025 03:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9Qu-0008NK-G5; Sun, 07 Sep 2025 03:03:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9Qq-0004OV-RR; Sun, 07 Sep 2025 03:03:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BB85D151054;
 Sun, 07 Sep 2025 10:02:04 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BC3662793C1;
 Sun,  7 Sep 2025 10:02:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "minglei.liu" <minglei.liu@smartx.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 70/81] qga: Fix truncated output handling in
 guest-exec status reporting
Date: Sun,  7 Sep 2025 10:01:49 +0300
Message-ID: <20250907070205.135289-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: "minglei.liu" <minglei.liu@smartx.com>

Signed-off-by: minglei.liu <minglei.liu@smartx.com>
Fixes: a1853dca743
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250711021714.91258-1-minglei.liu@smartx.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit 28c5d27dd4dc4100a96ff4c9e5871dd23c6b02ec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/commands.c b/qga/commands.c
index 5a5fad31f8..5f20af25d3 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -205,13 +205,15 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
 #endif
         if (gei->out.length > 0) {
             ges->out_data = g_base64_encode(gei->out.data, gei->out.length);
-            ges->has_out_truncated = gei->out.truncated;
+            ges->has_out_truncated = true;
+            ges->out_truncated = gei->out.truncated;
         }
         g_free(gei->out.data);
 
         if (gei->err.length > 0) {
             ges->err_data = g_base64_encode(gei->err.data, gei->err.length);
-            ges->has_err_truncated = gei->err.truncated;
+            ges->has_err_truncated = true;
+            ges->err_truncated = gei->err.truncated;
         }
         g_free(gei->err.data);
 
-- 
2.47.3


