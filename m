Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B48A801044
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 17:37:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r96VB-0005hG-1v; Fri, 01 Dec 2023 11:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r96V8-0005gs-3x
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:36:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r96V5-00063l-Lc
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701448581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xp17A7CZj1O+np6YyFQtFhiqMlCO8qoY8CRDrwu7ak0=;
 b=Kq3avL+GniaLVy+5/ICx3xsSOSuD11GSKe5jwBdleKRfew20tXbLNbAOJDHCh7S7tf/wA0
 Jc45v8N+9jNSYOmKxp2O7TXXNvnmSq8EMK3mWRNtRfP3R0ATwNknOqK8orhF5wPzP7pIe8
 kCrVPQdKzntTzM2On2xh2l/L3ASiCAg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-chTdR6RNNrGwnNWCTisJNg-1; Fri, 01 Dec 2023 11:36:17 -0500
X-MC-Unique: chTdR6RNNrGwnNWCTisJNg-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-7b35d293a41so61584539f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 08:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701448577; x=1702053377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xp17A7CZj1O+np6YyFQtFhiqMlCO8qoY8CRDrwu7ak0=;
 b=HUTmOwe5Bm2NBqjHcKAQHl/KDxNOOJ7JLlKGbdfDUXb99YZsQhafb1TRSIAZRi9T3S
 CUYetpHz2u0sw03VEdkHQEg5BGBTNAqasult8GyOevnYGE8LYAQAhk3XOAmp2NgiaFA8
 PTq5E9MGZbl7QQ6RCLW7RvCles7nTuKis2JlIku83sw/rKSmYM69viHyC2mcw9go6w2q
 I4/3bqkI0AFQo3RhA8gJzuWkLlDxeUI7/P0hsLaWz+QFCYXPVlKXZURkkOXCovd2d6RK
 eMEUMY8QJ1qFcSs9xBqc0b0PbX4d6ot+zUiJyYuJiKDje8BWw/cWVfNb3BZbQWAmedQ0
 qkIQ==
X-Gm-Message-State: AOJu0YyS8xS04gSae5834Ax9FJiO2fMfj7fjg9kvTlBM/rc0z+bVzNbz
 GIypDjZkYG8tQxc/1mnbNzeF6gFSFKF5h/CCy3Qw0zSZ6dLhzrMgr6xlM+gStpYtA7seDtfDDt/
 0ntPJtw7CjlmGVXLKSXCtdgTgq0iO68Id3oJxBAVHO5qppQP864xEXNn1X4txkfi7Tx05cV0Q
X-Received: by 2002:a05:6602:2bd2:b0:7b3:e4a6:45d4 with SMTP id
 s18-20020a0566022bd200b007b3e4a645d4mr10238087iov.0.1701448576881; 
 Fri, 01 Dec 2023 08:36:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIJmt9tjAgbg/jI7Q3w7jCN9GNodjqcp61VnFANZkff+GXNrT3Kxj91ezqfVgxiPyna2ab8Q==
X-Received: by 2002:a05:6602:2bd2:b0:7b3:e4a6:45d4 with SMTP id
 s18-20020a0566022bd200b007b3e4a645d4mr10238059iov.0.1701448576553; 
 Fri, 01 Dec 2023 08:36:16 -0800 (PST)
Received: from x1n.redhat.com
 (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a02a808000000b0046675345998sm932421jaj.96.2023.12.01.08.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 08:36:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Het Gala <het.gala@nutanix.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: [PULL 1/1] migration: Plug memory leak with migration URIs
Date: Fri,  1 Dec 2023 11:36:13 -0500
Message-ID: <20231201163613.1371497-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201163613.1371497-1-peterx@redhat.com>
References: <20231201163613.1371497-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Het Gala <het.gala@nutanix.com>

migrate_uri_parse() allocates memory to 'channel' if the user
opts for old syntax - uri, which is leaked because there is no
code for freeing 'channel'.
So, free channel to avoid memory leak in case where 'channels'
is empty and uri parsing is required.

Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp migration flow")
Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20231129204301.131228-1-het.gala@nutanix.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9068..34340f3440 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -515,7 +515,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    MigrationChannel *channel = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -533,18 +533,18 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             error_setg(errp, "Channel list has more than one entries");
             return;
         }
-        channel = channels->value;
+        addr = channels->value->addr;
     } else if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &channel, errp)) {
             return;
         }
+        addr = channel->addr;
     } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate-incoming' qmp command ");
         return;
     }
-    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
     if (!migration_channels_and_transport_compatible(addr, errp)) {
@@ -1932,7 +1932,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    MigrationChannel *channel = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
 
     /*
@@ -1949,18 +1949,18 @@ void qmp_migrate(const char *uri, bool has_channels,
             error_setg(errp, "Channel list has more than one entries");
             return;
         }
-        channel = channels->value;
+        addr = channels->value->addr;
     } else if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &channel, errp)) {
             return;
         }
+        addr = channel->addr;
     } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate' qmp command ");
         return;
     }
-    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
     if (!migration_channels_and_transport_compatible(addr, errp)) {
-- 
2.41.0


