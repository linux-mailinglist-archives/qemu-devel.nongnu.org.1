Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA4773A6BE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNbC-0006nG-Id; Thu, 22 Jun 2023 12:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbB-0006md-2D
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNb9-0008Lv-Kd
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687452955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyGp5tlDuMU4pJ2uo8I+uUxA4U7xysFjVKjI1S8HWyk=;
 b=Lfi7L39SN46wHvBBvHxDQ95/kaFVG2h4yvb9GlH1qvw7lm1jfXhAeYtBTSQ8P7v1tYkeIb
 rdEvY6YXLpyTP+7U+nmVk4PAEKBuwVxKFFx0xpK3gcKrOphehp7Tj/cZJvOezPufdzsysH
 l474J77w6doHbe2DCav3ZFbaDyyyIpc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-ij1VNqi8MqiHutNvcFFnmQ-1; Thu, 22 Jun 2023 12:55:53 -0400
X-MC-Unique: ij1VNqi8MqiHutNvcFFnmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25D0D92CAE2;
 Thu, 22 Jun 2023 16:55:48 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03B5EC00049;
 Thu, 22 Jun 2023 16:55:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>
Subject: [PULL 07/30] migration: Refactor auto-converge capability logic
Date: Thu, 22 Jun 2023 18:55:04 +0200
Message-Id: <20230622165527.2417-8-quintela@redhat.com>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Check if block migration is running before throttling
guest down in auto-converge way.

Note that this modification is kind of like code clean,
because block migration does not depend on auto-converge
capability, so the order of checks can be adjusted.

Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <168618975839.6361.17407633874747688653-5@git.sr.ht>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5283a75f02..78746849b5 100644
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
-- 
2.40.1


