Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D175B415
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:24:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWQ3-0005Nj-55; Thu, 20 Jul 2023 12:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qMWPr-0005Ml-Jq
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:22:11 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qMWPq-0001wZ-5k
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:22:11 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 993E711EF44;
 Thu, 20 Jul 2023 16:22:06 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Wed, 07 Jun 2023 23:32:51 +0800
Subject: [PATCH QEMU v9 5/9] migration: Refactor auto-converge capability logic
MIME-Version: 1.0
Message-ID: <168987012554.14797.8679831725383645706-5@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168987012554.14797.8679831725383645706-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

Check if block migration is running before throttling
guest down in auto-converge way.

Note that this modification is kind of like code clean,
because block migration does not depend on auto-converge
capability, so the order of checks can be adjusted.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 0ada6477e8..f31de47a47 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -995,7 +995,11 @@ static void migration_trigger_throttle(RAMState *rs)
     /* During block migration the auto-converge logic incorrectly detects
      * that ram migration makes no progress. Avoid this by disabling the
      * throttling logic during the bulk phase of block migration. */
-    if (migrate_auto_converge() && !blk_mig_bulk_active()) {
+    if (blk_mig_bulk_active()) {
+        return;
+    }
+
+    if (migrate_auto_converge()) {
         /* The following detection logic can be refined later. For now:
            Check to see if the ratio between dirtied bytes and the approx.
            amount of bytes that just got transferred since the last time
--=20
2.38.5


