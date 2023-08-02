Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B8F76C732
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR6TW-0005Xd-Nx; Wed, 02 Aug 2023 03:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qR6TR-0005WC-SR
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qR6TP-000245-0l
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690962046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHGIBvyI71pEDYrYkMQvIXEfHIvs3P71kefmtbODzU8=;
 b=DWDddkk3qPxRln5fYw16SO0S2ugW4KmTx9flrB1ESlWGTxTWHyB4sN/Ed1YCKWo/K2ewSe
 RRFW6Y64i+Q3SaGnB6QXW9vy2zwZ5prmvBrgZCWW+Y2WC5CTHxYrVwDDfjlZADmXsrV+WT
 Wf0k+Zhr/uSR9aPIR5XlCpCR07USKGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-686-ak5Ssox8MoWOeS2cheIo9g-1; Wed, 02 Aug 2023 03:40:43 -0400
X-MC-Unique: ak5Ssox8MoWOeS2cheIo9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6E3A803FDF;
 Wed,  2 Aug 2023 07:40:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA15F1401C2E;
 Wed,  2 Aug 2023 07:40:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B80221E6930; Wed,  2 Aug 2023 09:40:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>
Subject: [PULL 2/3] qapi: Craft the dirty-limit capability comment
Date: Wed,  2 Aug 2023 09:40:40 +0200
Message-ID: <20230802074041.418954-3-armbru@redhat.com>
In-Reply-To: <20230802074041.418954-1-armbru@redhat.com>
References: <20230802074041.418954-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hyman Huang(黄勇) <yong.huang@smartx.com>

Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>
Message-ID: <169073570563.19893.2928364761104733482-2@git.sr.ht>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index dffa60fd91..8843e74b59 100644
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
-- 
2.41.0


