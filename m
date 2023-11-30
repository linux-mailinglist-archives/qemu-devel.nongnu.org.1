Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 414777FED17
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 11:42:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8eTz-0006Tq-D5; Thu, 30 Nov 2023 05:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r8eTs-0006Rb-PL
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:41:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r8eTr-0005jS-8j
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701340874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+d/EjlEpu5yyJcRIckcsv2nrrrU/VNYzWeDlmKJFT0=;
 b=YFPLHLh8+7zQskLta6ls+/x+MKww/7EaUxC3QExrs2TcQjAE4GaR2O82AhxtRSW1IR9OXK
 u94QlmlSdD5chqq+Gha6GIdQrrAfCkn3ErrUBqh3EZzsTGAnYI0LNuWUnB75vh1nS9dTia
 zrKgAy5u0/6rMXed+/FbB2dq9wXoBEE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-7MHTsFwUN7qapqyUYGRQhw-1; Thu, 30 Nov 2023 05:41:09 -0500
X-MC-Unique: 7MHTsFwUN7qapqyUYGRQhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1885584AC63;
 Thu, 30 Nov 2023 10:41:09 +0000 (UTC)
Received: from secure.mitica1 (unknown [10.39.195.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CEDE2026D4C;
 Thu, 30 Nov 2023 10:41:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Zongmin Zhou <zhouzongmin@kylinos.cn>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/2] migration: free 'saddr' since be no longer used
Date: Thu, 30 Nov 2023 11:41:03 +0100
Message-ID: <20231130104103.28672-3-quintela@redhat.com>
In-Reply-To: <20231130104103.28672-1-quintela@redhat.com>
References: <20231130104103.28672-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

Since socket_parse() will allocate memory for 'saddr',and its value
will pass to 'addr' that allocated by migrate_uri_parse(),
then 'saddr' will no longer used,need to free.
But due to 'saddr->u' is shallow copying the contents of the union,
the members of this union containing allocated strings,and will be used after that.
So just free 'saddr' itself without doing a deep free on the contents of the SocketAddress.

Fixes: 72a8192e225c ("migration: convert migration 'uri' into 'MigrateAddress'")
Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231120031428.908295-1-zhouzongmin@kylinos.cn>
---
 migration/migration.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9068..1832dad618 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -462,7 +462,6 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
 {
     g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
-    SocketAddress *saddr = NULL;
     InetSocketAddress *isock = &addr->u.rdma;
     strList **tail = &addr->u.exec.args;
 
@@ -487,12 +486,14 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
                 strstart(uri, "vsock:", NULL) ||
                 strstart(uri, "fd:", NULL)) {
         addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
-        saddr = socket_parse(uri, errp);
+        SocketAddress *saddr = socket_parse(uri, errp);
         if (!saddr) {
             return false;
         }
         addr->u.socket.type = saddr->type;
         addr->u.socket.u = saddr->u;
+        /* Don't free the objects inside; their ownership moved to "addr" */
+        g_free(saddr);
     } else if (strstart(uri, "file:", NULL)) {
         addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
         addr->u.file.filename = g_strdup(uri + strlen("file:"));
-- 
2.43.0


