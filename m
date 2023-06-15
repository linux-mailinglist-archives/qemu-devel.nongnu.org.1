Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B39E7747CAE
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 07:50:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGvOX-0005VX-Oj; Wed, 05 Jul 2023 01:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qGvOJ-0005Sf-87
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:49:27 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qGvOG-00085V-A0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:49:25 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id F2B5E11F0C0;
 Wed,  5 Jul 2023 05:49:20 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Thu, 15 Jun 2023 21:29:44 +0800
Subject: [PATCH QEMU v7 6/9] migration: Put the detection logic before
 auto-converge checking
MIME-Version: 1.0
Message-ID: <168853615963.17240.15832775267134683267-6@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168853615963.17240.15832775267134683267-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hyman =?utf-8?b?SHVhbmco6buE5YuHKQ==?= <yong.huang@smartx.com>
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

This commit is prepared for the implementation of dirty-limit
convergence algo.

The detection logic of throttling condition can apply to both
auto-converge and dirty-limit algo, putting it's position
before the checking logic for auto-converge feature.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 78746849b5..b6559f9312 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -999,17 +999,18 @@ static void migration_trigger_throttle(RAMState *rs)
         return;
     }
=20
-    if (migrate_auto_converge()) {
-        /* The following detection logic can be refined later. For now:
-           Check to see if the ratio between dirtied bytes and the approx.
-           amount of bytes that just got transferred since the last time
-           we were in this routine reaches the threshold. If that happens
-           twice, start or increase throttling. */
-
-        if ((bytes_dirty_period > bytes_dirty_threshold) &&
-            (++rs->dirty_rate_high_cnt >=3D 2)) {
+    /*
+     * The following detection logic can be refined later. For now:
+     * Check to see if the ratio between dirtied bytes and the approx.
+     * amount of bytes that just got transferred since the last time
+     * we were in this routine reaches the threshold. If that happens
+     * twice, start or increase throttling.
+     */
+    if ((bytes_dirty_period > bytes_dirty_threshold) &&
+        (++rs->dirty_rate_high_cnt >=3D 2)) {
+        rs->dirty_rate_high_cnt =3D 0;
+        if (migrate_auto_converge()) {
             trace_migration_throttle();
-            rs->dirty_rate_high_cnt =3D 0;
             mig_throttle_guest_down(bytes_dirty_period,
                                     bytes_dirty_threshold);
         }
--=20
2.38.5


