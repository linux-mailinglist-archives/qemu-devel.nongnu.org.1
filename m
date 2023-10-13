Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 887AD7C83A9
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFjD-0006Rh-Ba; Fri, 13 Oct 2023 06:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFjA-0006Dr-6y
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFj8-0007NA-44
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697194145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2srnfIEd6HZcjaGH/dirb96uUcIXi9Ipdq+jApTvj8=;
 b=BrOB/mkcbiwwQfA25qhMv8PDe31B/l7Xma/7Hv8dDaZfDTfULd/9R0Sjojj2+ANnrdICP3
 v+7OctdoGoZlzVdKN8FKIr9r0nqpcupE2iHWeEq4GbqcARMgtrGzIju/jtM5NaWAAmw1RW
 qH38CVxjhBr1idRiwIjJya4QdbNBzoo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-32pSErC9Nua0jZ_iqIXs-Q-1; Fri, 13 Oct 2023 06:48:07 -0400
X-MC-Unique: 32pSErC9Nua0jZ_iqIXs-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85DC081DA87;
 Fri, 13 Oct 2023 10:48:06 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2ED32156701;
 Fri, 13 Oct 2023 10:48:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 08/10] [RFC] migration: Remove helpers needed for -i/-b
 migrate options
Date: Fri, 13 Oct 2023 12:47:34 +0200
Message-ID: <20231013104736.31722-9-quintela@redhat.com>
In-Reply-To: <20231013104736.31722-1-quintela@redhat.com>
References: <20231013104736.31722-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

[DON'T MERGE]

We were abusing capabilities and parameters to implement -i/-b.
Previous patch convert that options into one error.  Remove all the
helpers needed to implement them.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.h |  4 ----
 migration/options.h   |  6 ------
 migration/migration.c |  2 --
 migration/options.c   | 41 -----------------------------------------
 4 files changed, 53 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index cd5534337c..ae53d9b26a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -382,10 +382,6 @@ struct MigrationState {
     /* mutex to protect errp */
     QemuMutex error_mutex;
 
-    /* Do we have to clean up -b/-i from old migrate parameters */
-    /* This feature is deprecated and will be removed */
-    bool must_remove_block_options;
-
     /*
      * Global switch on whether we need to store the global state
      * during migration.
diff --git a/migration/options.h b/migration/options.h
index 045e2a41a2..4e8c0b9223 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -61,7 +61,6 @@ bool migrate_tls(void);
 /* capabilities helpers */
 
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
-bool migrate_cap_set(int cap, bool value, Error **errp);
 
 /* parameters */
 
@@ -91,14 +90,9 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 
-/* parameters setters */
-
-void migrate_set_block_incremental(bool value);
-
 /* parameters helpers */
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
-void block_cleanup_parameters(void);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 50fc112e98..ceeb2e6cb2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1205,7 +1205,6 @@ static void migrate_fd_cleanup(MigrationState *s)
         error_report_err(error_copy(s->error));
     }
     notifier_list_notify(&migration_state_notifiers, s);
-    block_cleanup_parameters();
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
@@ -1714,7 +1713,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
-        block_cleanup_parameters();
     }
 
     if (local_err) {
diff --git a/migration/options.c b/migration/options.c
index e46d847de2..ecb34a3bbd 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -622,26 +622,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     return true;
 }
 
-bool migrate_cap_set(int cap, bool value, Error **errp)
-{
-    MigrationState *s = migrate_get_current();
-    bool new_caps[MIGRATION_CAPABILITY__MAX];
-
-    if (migration_is_running(s->state)) {
-        error_setg(errp, QERR_MIGRATION_ACTIVE);
-        return false;
-    }
-
-    memcpy(new_caps, s->capabilities, sizeof(new_caps));
-    new_caps[cap] = value;
-
-    if (!migrate_caps_check(s->capabilities, new_caps, errp)) {
-        return false;
-    }
-    s->capabilities[cap] = value;
-    return true;
-}
-
 MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
 {
     MigrationCapabilityStatusList *head = NULL, **tail = &head;
@@ -861,29 +841,8 @@ uint64_t migrate_xbzrle_cache_size(void)
     return s->parameters.xbzrle_cache_size;
 }
 
-/* parameter setters */
-
-void migrate_set_block_incremental(bool value)
-{
-    MigrationState *s = migrate_get_current();
-
-    s->parameters.block_incremental = value;
-}
-
 /* parameters helpers */
 
-void block_cleanup_parameters(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    if (s->must_remove_block_options) {
-        /* setting to false can never fail */
-        migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, false, &error_abort);
-        migrate_set_block_incremental(false);
-        s->must_remove_block_options = false;
-    }
-}
-
 AnnounceParameters *migrate_announce_params(void)
 {
     static AnnounceParameters ap;
-- 
2.41.0


