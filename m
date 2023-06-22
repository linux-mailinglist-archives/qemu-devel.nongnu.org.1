Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF326739567
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:16:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9rC-0000zx-I7; Wed, 21 Jun 2023 22:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qS-0007RX-KF
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qQ-00057o-VI
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+awb8Ji3T505TOieoRQAmSUv6J3qZyUkjLapOert/H8=;
 b=cYALmv9hqSM1vlF96ZnDW9B7fKomd8gVEUmB3Irzqb1c4QfRdn8joUlvZkQV7/V5yEIIzy
 TuFYlPPOMrgvzSm5/3hy58jvzHA3P9EkiT42kaNSOtZUrXNzoJN/kku4awKONnDVXhbg+1
 +nVWvyGZCz0ZfxTR/iIqasC63+nprao=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-Cfuu3GcdO7ucc2wUqNPfvg-1; Wed, 21 Jun 2023 22:14:42 -0400
X-MC-Unique: Cfuu3GcdO7ucc2wUqNPfvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65FB98C586A;
 Thu, 22 Jun 2023 02:14:42 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0E57112132E;
 Thu, 22 Jun 2023 02:14:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, Tejus GK <tejus.gk@nutanix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 21/30] migration: Refactor repeated call of
 yank_unregister_instance
Date: Thu, 22 Jun 2023 04:13:11 +0200
Message-Id: <20230622021320.66124-22-quintela@redhat.com>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

From: Tejus GK <tejus.gk@nutanix.com>

In the function qmp_migrate(), yank_unregister_instance() gets called
twice which isn't required. Hence, refactoring it so that it gets called
during the local_error cleanup.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
Message-ID: <20230621130940.178659-3-tejus.gk@nutanix.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e6bff2e848..7a4ba2e846 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1676,15 +1676,11 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
-        if (!(has_resume && resume)) {
-            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-        }
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
         block_cleanup_parameters();
-        return;
     }
 
     if (local_err) {
-- 
2.40.1


