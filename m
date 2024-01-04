Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D98AB823B85
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:36:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFQL-0002ap-7S; Wed, 03 Jan 2024 23:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQJ-0002LE-3W
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:33:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQH-0006es-J2
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6dD/TMed/X7jmYABUeRfkONtrvV/Qb+PQJm110QTWc=;
 b=Npn8mhSPCGAnVs4YpjM6VLY6eGXSZ95aRL9iOkjOr2fnD/GCZYaMeuu/sm7G6r29JhCb+W
 8X+SiDHAyl0cd2oxcI+dDX38NZCaq0bnfWoka30JUcBpJDPh0ETIRGsPrAZdwjMR7JJO/P
 nt2YEbK6LGl6BGiUnD+UL62AYx3dUts=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-xD047C_9MdKMaSw9jMZA5w-1; Wed, 03 Jan 2024 23:33:34 -0500
X-MC-Unique: xD047C_9MdKMaSw9jMZA5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3842848C0D;
 Thu,  4 Jan 2024 04:33:33 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E35FC159B0;
 Thu,  4 Jan 2024 04:33:29 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 15/26] migration: Remove migrate_max_downtime() declaration
Date: Thu,  4 Jan 2024 12:32:00 +0800
Message-ID: <20240104043213.431566-16-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

migrate_max_downtime() has been removed long ago, but its declaration
was mistakenly left. Remove it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20231231093016.14204-2-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index cf2c9c88e0..b3c9288c38 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -480,8 +480,6 @@ void migration_incoming_process(void);
 
 bool  migration_has_all_channels(void);
 
-uint64_t migrate_max_downtime(void);
-
 void migrate_set_error(MigrationState *s, const Error *error);
 bool migrate_has_error(MigrationState *s);
 
-- 
2.41.0


