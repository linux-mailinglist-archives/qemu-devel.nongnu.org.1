Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D82BD768684
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 18:49:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ9aq-00061i-3S; Sun, 30 Jul 2023 12:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qQ9an-00060g-OH
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:48:29 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qQ9al-0005zU-HE
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:48:29 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 3825911EF32;
 Sun, 30 Jul 2023 16:48:26 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Fri, 28 Jul 2023 23:10:40 +0800
Subject: [PATCH QEMU v3 2/3] qapi: Craft the dirty-limit capability comment
MIME-Version: 1.0
Message-ID: <169073570563.19893.2928364761104733482-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <169073570563.19893.2928364761104733482-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
---
 qapi/migration.json | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index a74ade4d72..62ab151da2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -519,14 +519,11 @@
 #     are present.  'return-path' capability must be enabled to use
 #     it.  (since 8.1)
 #
-# @dirty-limit: If enabled, migration will use the dirty-limit
-#     algorithim to throttle down guest instead of auto-converge
-#     algorithim. Throttle algorithim only works when vCPU's dirtyrate
-#     greater than 'vcpu-dirty-limit', read processes in guest os
-#     aren't penalized any more, so this algorithim can improve
-#     performance of vCPU during live migration. This is an optional
-#     performance feature and should not affect the correctness of the
-#     existing auto-converge algorithim.  (Since 8.1)
+# @dirty-limit: If enabled, migration will throttle vCPUs as needed to
+#     keep their dirty page rate within @vcpu-dirty-limit.  This can
+#     improve responsiveness of large guests during live migration,
+#     and can result in more stable read performance.  Requires KVM
+#     with accelerator property "dirty-ring-size" set.  (Since 8.1)
 #
 # Features:
 #
--=20
2.38.5


