Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2504AC4969
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 09:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJouT-00044C-L6; Tue, 27 May 2025 03:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouR-00043e-Kp
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouF-0007rB-Hr
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08yDEFBDiwgmtdZkwEVQHfFRvpxAwhlhe48cd1hghso=;
 b=VaoXpO+BRZy6SY215X9349dAuu7Ga7DxvgoksvaOfcTvUR+yhLYPOlNr3Mij+dN2rIXulk
 pbfAwSgGhSq4Al8bRuT0z42cQemST2Op5z3qBJcoFBh+/C9YGO2Skf2cuA2t+icCZSx0cm
 y4SmQ0lbgN3ng8ephb/XGM1l+neBnQc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-npQBJHNNOh6xacjAJ9D8ew-1; Tue,
 27 May 2025 03:39:24 -0400
X-MC-Unique: npQBJHNNOh6xacjAJ9D8ew-1
X-Mimecast-MFC-AGG-ID: npQBJHNNOh6xacjAJ9D8ew_1748331563
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26544180087B; Tue, 27 May 2025 07:39:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 604E7180049D; Tue, 27 May 2025 07:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 401B221E65E7; Tue, 27 May 2025 09:39:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, qemu-block@nongnu.org
Subject: [PATCH 08/13] qapi: Use proper markup instead of CAPS for emphasis in
 doc comments
Date: Tue, 27 May 2025 09:39:11 +0200
Message-ID: <20250527073916.1243024-9-armbru@redhat.com>
In-Reply-To: <20250527073916.1243024-1-armbru@redhat.com>
References: <20250527073916.1243024-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json |  2 +-
 qapi/dump.json       |  6 +++---
 qapi/migration.json  | 26 +++++++++++++-------------
 qapi/misc.json       |  4 ++--
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f0faca1054..7b0548dc2e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1589,7 +1589,7 @@
 #
 # @bitmap-mode: Specifies the type of data the bitmap should contain
 #     after the operation concludes.  Must be present if a bitmap was
-#     provided, must NOT be present otherwise.  (Since 4.2)
+#     provided, must **not** be present otherwise.  (Since 4.2)
 #
 # @compress: true to compress data, if the target format supports it.
 #     (default: false) (since 2.8)
diff --git a/qapi/dump.json b/qapi/dump.json
index d7826c0e32..8ec95ef76b 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -54,9 +54,9 @@
 # @paging: if true, do paging to get guest's memory mapping.  This
 #     allows using gdb to process the core file.
 #
-#     IMPORTANT: this option can make QEMU allocate several gigabytes
-#     of RAM.  This can happen for a large guest, or a malicious guest
-#     pretending to be large.
+#     **Important**: this option can make QEMU allocate several
+#     gigabytes of RAM.  This can happen for a large guest, or a
+#     malicious guest pretending to be large.
 #
 #     Also, paging=true has the following limitations:
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 461f9f0892..f1e6daa58b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -407,7 +407,7 @@
 # @postcopy-ram: Start executing on the migration target before all of
 #     RAM has been migrated, pulling the remaining pages along as
 #     needed.  The capacity must have the same setting on both source
-#     and target or migration will not even start.  NOTE: If the
+#     and target or migration will not even start.  **Note:** if the
 #     migration fails during postcopy the VM will fail.  (since 2.6)
 #
 # @x-colo: If enabled, migration will never end, and the state of the
@@ -801,10 +801,10 @@
 #     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations
-#     when making decisions to switchover.  By default, this value is
-#     zero, which means QEMU will estimate the bandwidth
+#     migration can use during switchover phase.  **Note:** this does
+#     not limit the bandwidth during switchover, but only for
+#     calculations when making decisions to switchover.  By default,
+#     this value is zero, which means QEMU will estimate the bandwidth
 #     automatically.  This can be set when the estimated value is not
 #     accurate, while the user is able to guarantee such bandwidth is
 #     available when switching over.  When specified correctly, this
@@ -982,10 +982,10 @@
 #     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations
-#     when making decisions to switchover.  By default, this value is
-#     zero, which means QEMU will estimate the bandwidth
+#     migration can use during switchover phase.  **Note:** this does
+#     not limit the bandwidth during switchover, but only for
+#     calculations when making decisions to switchover.  By default,
+#     this value is zero, which means QEMU will estimate the bandwidth
 #     automatically.  This can be set when the estimated value is not
 #     accurate, while the user is able to guarantee such bandwidth is
 #     available when switching over.  When specified correctly, this
@@ -1192,10 +1192,10 @@
 #     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations
-#     when making decisions to switchover.  By default, this value is
-#     zero, which means QEMU will estimate the bandwidth
+#     migration can use during switchover phase.  **Note:** this does
+#     not limit the bandwidth during switchover, but only for
+#     calculations when making decisions to switchover.  By default,
+#     this value is zero, which means QEMU will estimate the bandwidth
 #     automatically.  This can be set when the estimated value is not
 #     accurate, while the user is able to guarantee such bandwidth is
 #     available when switching over.  When specified correctly, this
diff --git a/qapi/misc.json b/qapi/misc.json
index 559b66f201..83e5bdadca 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -222,8 +222,8 @@
 # .. note:: This command only exists as a stop-gap.  Its use is highly
 #    discouraged.  The semantics of this command are not guaranteed:
 #    this means that command names, arguments and responses can change
-#    or be removed at ANY time.  Applications that rely on long term
-#    stability guarantees should NOT use this command.
+#    or be removed at **any** time.  Applications that rely on long
+#    term stability guarantees should **not** use this command.
 #
 #    Known limitations:
 #
-- 
2.48.1


