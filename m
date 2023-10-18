Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2EC7CD8E0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:09:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3SR-0007Nk-Pd; Wed, 18 Oct 2023 06:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SA-0007JI-O7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3S7-0007gr-Tp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697623618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SCQdudatnyGI3PFcpQsCGYuttr/lCxGiua3H8DQmlE=;
 b=hwFCUuFKsED1QUMuhI3ErFdoVq0+K8h0df5Mzve8XbtnKkOKQrqmbevPJb0JIOXnAgIkqZ
 L3t6LICx0EMu4/IcOJhYOkHEy9wr4wX9flxueVOktrdJ+15lRjVz8Nnf4fBhcGNWcG2zAA
 W1GL1gZoV5EvVU0LzoTV/ECcwlE0XUw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-rcW8SklfOY6_KpJInI_I8w-1; Wed, 18 Oct 2023 06:06:55 -0400
X-MC-Unique: rcW8SklfOY6_KpJInI_I8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A704D28AC1E4;
 Wed, 18 Oct 2023 10:06:54 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 865EE2026D4C;
 Wed, 18 Oct 2023 10:06:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 01/11] migration: RDMA is not compatible with anything else
Date: Wed, 18 Oct 2023 12:06:41 +0200
Message-ID: <20231018100651.32674-2-quintela@redhat.com>
In-Reply-To: <20231018100651.32674-1-quintela@redhat.com>
References: <20231018100651.32674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

So give an error instead of just ignoring the other methods.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20230613145757.10131-4-quintela@redhat.com>
---
 migration/migration.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 6ba5e145ac..81862fcaa9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -447,6 +447,18 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
         socket_start_incoming_migration(p ? p : uri, errp);
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
+        if (migrate_compress()) {
+            error_setg(errp, "RDMA and compression can't be used together");
+            return;
+        }
+        if (migrate_xbzrle()) {
+            error_setg(errp, "RDMA and XBZRLE can't be used together");
+            return;
+        }
+        if (migrate_multifd()) {
+            error_setg(errp, "RDMA and multifd can't be used together");
+            return;
+        }
         rdma_start_incoming_migration(p, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
-- 
2.41.0


