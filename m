Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 214BB94AF2A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Aug 2024 19:51:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbknT-00076s-4d; Wed, 07 Aug 2024 13:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknP-000724-R7
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknO-0000RV-0M
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723052997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xrc1r3NaGmUxA1XHAispy7DXme7ap+ScyWyMJR1bS8=;
 b=eg38c6MANajuhv1oQ93VqZDzQcKeaUdfEqCXrl3Z1AhtAlE0o1axYt+BRsBRT6SJfTwR5i
 YKDCiXBh7FC8VWpWjg+uc0ww3Kp5HZr8l0nhmM7bo0LbRlOL/T6g0+KTLtRNSMp6l09WxW
 8mVogx6zuCi/oQf2LeTKLGxlD7W5/Dk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-UCfuqWf9MRSlIyAqQChiKA-1; Wed,
 07 Aug 2024 13:49:56 -0400
X-MC-Unique: UCfuqWf9MRSlIyAqQChiKA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE06C1955F38; Wed,  7 Aug 2024 17:49:54 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2AD2300018D; Wed,  7 Aug 2024 17:49:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH v4 2/7] nbd/server: Plumb in new args to nbd_client_add()
Date: Wed,  7 Aug 2024 12:43:28 -0500
Message-ID: <20240807174943.771624-11-eblake@redhat.com>
In-Reply-To: <20240807174943.771624-9-eblake@redhat.com>
References: <20240807174943.771624-9-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Upcoming patches to fix a CVE need to track an opaque pointer passed
in by the owner of a client object, as well as reequest for a time
limit on how fast negotiation must complete.  Prepare for that by
changing the signature of nbd_client_new() and adding an accessor to
get at the opaque pointer, although for now the two servers
(qemu-nbd.c and blockdev-nbd.c) do not change behavior.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h | 11 ++++++++++-
 blockdev-nbd.c      |  6 ++++--
 nbd/server.c        | 20 +++++++++++++++++---
 qemu-nbd.c          |  4 +++-
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4e7bd6342f9..5fe14786414 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -33,6 +33,12 @@ typedef struct NBDMetaContexts NBDMetaContexts;

 extern const BlockExportDriver blk_exp_nbd;

+/*
+ * NBD_DEFAULT_HANDSHAKE_LIMIT: Number of seconds in which client must
+ * succeed at NBD_OPT_GO before being forcefully dropped as too slow.
+ */
+#define NBD_DEFAULT_HANDSHAKE_LIMIT 10
+
 /* Handshake phase structs - this struct is passed on the wire */

 typedef struct NBDOption {
@@ -403,9 +409,12 @@ AioContext *nbd_export_aio_context(NBDExport *exp);
 NBDExport *nbd_export_find(const char *name);

 void nbd_client_new(QIOChannelSocket *sioc,
+                    uint32_t handshake_limit,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsauthz,
-                    void (*close_fn)(NBDClient *, bool));
+                    void (*close_fn)(NBDClient *, bool),
+                    void *owner);
+void *nbd_client_owner(NBDClient *client);
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 213012435f4..11f878b6db3 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -64,8 +64,10 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
     nbd_update_server_watch(nbd_server);

     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
-    nbd_client_new(cioc, nbd_server->tlscreds, nbd_server->tlsauthz,
-                   nbd_blockdev_client_closed);
+    /* TODO - expose handshake limit as QMP option */
+    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_LIMIT,
+                   nbd_server->tlscreds, nbd_server->tlsauthz,
+                   nbd_blockdev_client_closed, NULL);
 }

 static void nbd_update_server_watch(NBDServerData *s)
diff --git a/nbd/server.c b/nbd/server.c
index ecd9366ba64..31b77bf0d4f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -124,12 +124,14 @@ struct NBDMetaContexts {
 struct NBDClient {
     int refcount; /* atomic */
     void (*close_fn)(NBDClient *client, bool negotiated);
+    void *owner;

     QemuMutex lock;

     NBDExport *exp;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthz;
+    uint32_t handshake_limit;
     QIOChannelSocket *sioc; /* The underlying data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */

@@ -3191,6 +3193,7 @@ static coroutine_fn void nbd_co_client_start(void *opaque)

     qemu_co_mutex_init(&client->send_lock);

+    /* TODO - utilize client->handshake_limit */
     if (nbd_negotiate(client, &local_err)) {
         if (local_err) {
             error_report_err(local_err);
@@ -3205,14 +3208,17 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 }

 /*
- * Create a new client listener using the given channel @sioc.
+ * Create a new client listener using the given channel @sioc and @owner.
  * Begin servicing it in a coroutine.  When the connection closes, call
- * @close_fn with an indication of whether the client completed negotiation.
+ * @close_fn with an indication of whether the client completed negotiation
+ * within @handshake_limit seconds (0 for unbounded).
  */
 void nbd_client_new(QIOChannelSocket *sioc,
+                    uint32_t handshake_limit,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsauthz,
-                    void (*close_fn)(NBDClient *, bool))
+                    void (*close_fn)(NBDClient *, bool),
+                    void *owner)
 {
     NBDClient *client;
     Coroutine *co;
@@ -3225,13 +3231,21 @@ void nbd_client_new(QIOChannelSocket *sioc,
         object_ref(OBJECT(client->tlscreds));
     }
     client->tlsauthz = g_strdup(tlsauthz);
+    client->handshake_limit = handshake_limit;
     client->sioc = sioc;
     qio_channel_set_delay(QIO_CHANNEL(sioc), false);
     object_ref(OBJECT(client->sioc));
     client->ioc = QIO_CHANNEL(sioc);
     object_ref(OBJECT(client->ioc));
     client->close_fn = close_fn;
+    client->owner = owner;

     co = qemu_coroutine_create(nbd_co_client_start, client);
     qemu_coroutine_enter(co);
 }
+
+void *
+nbd_client_owner(NBDClient *client)
+{
+    return client->owner;
+}
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 8e104ef22c3..7bf86a6566b 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -390,7 +390,9 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,

     nb_fds++;
     nbd_update_server_watch();
-    nbd_client_new(cioc, tlscreds, tlsauthz, nbd_client_closed);
+    /* TODO - expose handshake limit as command line option */
+    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_LIMIT,
+                   tlscreds, tlsauthz, nbd_client_closed, NULL);
 }

 static void nbd_update_server_watch(void)
-- 
2.45.2


