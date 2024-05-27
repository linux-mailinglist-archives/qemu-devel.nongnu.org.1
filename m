Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA58CF983
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 08:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU3L-0003I0-Nb; Mon, 27 May 2024 02:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU2s-00038O-Od; Mon, 27 May 2024 02:41:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU2p-0007JY-6B; Mon, 27 May 2024 02:41:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ADA996A3F3;
 Mon, 27 May 2024 09:41:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0491CD83EB;
 Mon, 27 May 2024 09:40:57 +0300 (MSK)
Received: (nullmailer pid 50273 invoked by uid 1000);
 Mon, 27 May 2024 06:40:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.12 05/19] nbd/server: Mark negotiation functions as
 coroutine_fn
Date: Mon, 27 May 2024 09:40:36 +0300
Message-Id: <20240527064056.50205-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
References: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Eric Blake <eblake@redhat.com>

nbd_negotiate() is already marked coroutine_fn.  And given the fix in
the previous patch to have nbd_negotiate_handle_starttls not create
and wait on a g_main_loop (as that would violate coroutine
constraints), it is worth marking the rest of the related static
functions reachable only during option negotiation as also being
coroutine_fn.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240408160214.1200629-6-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
[eblake: drop one spurious coroutine_fn marking]
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 4fa333e08dd96395a99ea8dd9e4c73a29dd23344)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: fixups in nbd/server.c for v8.1.0-1366-gfd358d83901d
 "nbd/server: Refactor list of negotiated meta contexts")

diff --git a/nbd/server.c b/nbd/server.c
index 4d2061f55c..74edb2815b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -189,8 +189,9 @@ static inline void set_be_option_rep(NBDOptionReply *rep, uint32_t option,
 
 /* Send a reply header, including length, but no payload.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_send_rep_len(NBDClient *client, uint32_t type,
-                                      uint32_t len, Error **errp)
+static coroutine_fn int
+nbd_negotiate_send_rep_len(NBDClient *client, uint32_t type,
+                           uint32_t len, Error **errp)
 {
     NBDOptionReply rep;
 
@@ -205,15 +206,15 @@ static int nbd_negotiate_send_rep_len(NBDClient *client, uint32_t type,
 
 /* Send a reply header with default 0 length.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_send_rep(NBDClient *client, uint32_t type,
-                                  Error **errp)
+static coroutine_fn int
+nbd_negotiate_send_rep(NBDClient *client, uint32_t type, Error **errp)
 {
     return nbd_negotiate_send_rep_len(client, type, 0, errp);
 }
 
 /* Send an error reply.
  * Return -errno on error, 0 on success. */
-static int G_GNUC_PRINTF(4, 0)
+static coroutine_fn int G_GNUC_PRINTF(4, 0)
 nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
                             Error **errp, const char *fmt, va_list va)
 {
@@ -253,7 +254,7 @@ nbd_sanitize_name(const char *name)
 
 /* Send an error reply.
  * Return -errno on error, 0 on success. */
-static int G_GNUC_PRINTF(4, 5)
+static coroutine_fn int G_GNUC_PRINTF(4, 5)
 nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
                            Error **errp, const char *fmt, ...)
 {
@@ -269,7 +270,7 @@ nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
 /* Drop remainder of the current option, and send a reply with the
  * given error type and message. Return -errno on read or write
  * failure; or 0 if connection is still live. */
-static int G_GNUC_PRINTF(4, 0)
+static coroutine_fn int G_GNUC_PRINTF(4, 0)
 nbd_opt_vdrop(NBDClient *client, uint32_t type, Error **errp,
               const char *fmt, va_list va)
 {
@@ -282,7 +283,7 @@ nbd_opt_vdrop(NBDClient *client, uint32_t type, Error **errp,
     return ret;
 }
 
-static int G_GNUC_PRINTF(4, 5)
+static coroutine_fn int G_GNUC_PRINTF(4, 5)
 nbd_opt_drop(NBDClient *client, uint32_t type, Error **errp,
              const char *fmt, ...)
 {
@@ -296,7 +297,7 @@ nbd_opt_drop(NBDClient *client, uint32_t type, Error **errp,
     return ret;
 }
 
-static int G_GNUC_PRINTF(3, 4)
+static coroutine_fn int G_GNUC_PRINTF(3, 4)
 nbd_opt_invalid(NBDClient *client, Error **errp, const char *fmt, ...)
 {
     int ret;
@@ -313,8 +314,9 @@ nbd_opt_invalid(NBDClient *client, Error **errp, const char *fmt, ...)
  * If @check_nul, require that no NUL bytes appear in buffer.
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success. */
-static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
-                        bool check_nul, Error **errp)
+static coroutine_fn int
+nbd_opt_read(NBDClient *client, void *buffer, size_t size,
+             bool check_nul, Error **errp)
 {
     if (size > client->optlen) {
         return nbd_opt_invalid(client, errp,
@@ -337,7 +339,8 @@ static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
 /* Drop size bytes from the unparsed payload of the current option.
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success. */
-static int nbd_opt_skip(NBDClient *client, size_t size, Error **errp)
+static coroutine_fn int
+nbd_opt_skip(NBDClient *client, size_t size, Error **errp)
 {
     if (size > client->optlen) {
         return nbd_opt_invalid(client, errp,
@@ -360,8 +363,9 @@ static int nbd_opt_skip(NBDClient *client, size_t size, Error **errp)
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success.
  */
-static int nbd_opt_read_name(NBDClient *client, char **name, uint32_t *length,
-                             Error **errp)
+static coroutine_fn int
+nbd_opt_read_name(NBDClient *client, char **name, uint32_t *length,
+                  Error **errp)
 {
     int ret;
     uint32_t len;
@@ -396,8 +400,8 @@ static int nbd_opt_read_name(NBDClient *client, char **name, uint32_t *length,
 
 /* Send a single NBD_REP_SERVER reply to NBD_OPT_LIST, including payload.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
-                                       Error **errp)
+static coroutine_fn int
+nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp, Error **errp)
 {
     ERRP_GUARD();
     size_t name_len, desc_len;
@@ -438,7 +442,8 @@ static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
 
 /* Process the NBD_OPT_LIST command, with a potential series of replies.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
+static coroutine_fn int
+nbd_negotiate_handle_list(NBDClient *client, Error **errp)
 {
     NBDExport *exp;
     assert(client->opt == NBD_OPT_LIST);
@@ -453,7 +458,8 @@ static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
     return nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
 }
 
-static void nbd_check_meta_export(NBDClient *client)
+static coroutine_fn void
+nbd_check_meta_export(NBDClient *client)
 {
     if (client->exp != client->export_meta.exp) {
         client->export_meta.count = 0;
@@ -462,8 +468,9 @@ static void nbd_check_meta_export(NBDClient *client)
 
 /* Send a reply to NBD_OPT_EXPORT_NAME.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
-                                            Error **errp)
+static coroutine_fn int
+nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
+                                 Error **errp)
 {
     ERRP_GUARD();
     g_autofree char *name = NULL;
@@ -523,9 +530,9 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
 /* Send a single NBD_REP_INFO, with a buffer @buf of @length bytes.
  * The buffer does NOT include the info type prefix.
  * Return -errno on error, 0 if ready to send more. */
-static int nbd_negotiate_send_info(NBDClient *client,
-                                   uint16_t info, uint32_t length, void *buf,
-                                   Error **errp)
+static coroutine_fn int
+nbd_negotiate_send_info(NBDClient *client, uint16_t info, uint32_t length,
+                        void *buf, Error **errp)
 {
     int rc;
 
@@ -552,7 +559,8 @@ static int nbd_negotiate_send_info(NBDClient *client,
  * -errno  transmission error occurred or @fatal was requested, errp is set
  * 0       error message successfully sent to client, errp is not set
  */
-static int nbd_reject_length(NBDClient *client, bool fatal, Error **errp)
+static coroutine_fn int
+nbd_reject_length(NBDClient *client, bool fatal, Error **errp)
 {
     int ret;
 
@@ -570,7 +578,8 @@ static int nbd_reject_length(NBDClient *client, bool fatal, Error **errp)
 /* Handle NBD_OPT_INFO and NBD_OPT_GO.
  * Return -errno on error, 0 if ready for next option, and 1 to move
  * into transmission phase.  */
-static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
+static coroutine_fn int
+nbd_negotiate_handle_info(NBDClient *client, Error **errp)
 {
     int rc;
     g_autofree char *name = NULL;
@@ -736,7 +745,8 @@ struct NBDTLSServerHandshakeData {
     Coroutine *co;
 };
 
-static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
+static void
+nbd_server_tls_handshake(QIOTask *task, void *opaque)
 {
     struct NBDTLSServerHandshakeData *data = opaque;
 
@@ -749,8 +759,8 @@ static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
 
 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
  * new channel for all further (now-encrypted) communication. */
-static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
-                                                 Error **errp)
+static coroutine_fn QIOChannel *
+nbd_negotiate_handle_starttls(NBDClient *client, Error **errp)
 {
     QIOChannel *ioc;
     QIOChannelTLS *tioc;
@@ -802,10 +812,9 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
  *
  * For NBD_OPT_LIST_META_CONTEXT @context_id is ignored, 0 is used instead.
  */
-static int nbd_negotiate_send_meta_context(NBDClient *client,
-                                           const char *context,
-                                           uint32_t context_id,
-                                           Error **errp)
+static coroutine_fn int
+nbd_negotiate_send_meta_context(NBDClient *client, const char *context,
+                                uint32_t context_id, Error **errp)
 {
     NBDOptionReplyMetaContext opt;
     struct iovec iov[] = {
@@ -830,8 +839,9 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
  * Return true if @query matches @pattern, or if @query is empty when
  * the @client is performing _LIST_.
  */
-static bool nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
-                                      const char *query)
+static coroutine_fn bool
+nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
+                          const char *query)
 {
     if (!*query) {
         trace_nbd_negotiate_meta_query_parse("empty");
@@ -848,7 +858,8 @@ static bool nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
 /*
  * Return true and adjust @str in place if it begins with @prefix.
  */
-static bool nbd_strshift(const char **str, const char *prefix)
+static coroutine_fn bool
+nbd_strshift(const char **str, const char *prefix)
 {
     size_t len = strlen(prefix);
 
@@ -864,8 +875,9 @@ static bool nbd_strshift(const char **str, const char *prefix)
  * Handle queries to 'base' namespace. For now, only the base:allocation
  * context is available.  Return true if @query has been handled.
  */
-static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
-                                const char *query)
+static coroutine_fn bool
+nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
+                    const char *query)
 {
     if (!nbd_strshift(&query, "base:")) {
         return false;
@@ -884,8 +896,9 @@ static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
  * and qemu:allocation-depth contexts are available.  Return true if @query
  * has been handled.
  */
-static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
-                                const char *query)
+static coroutine_fn bool
+nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
+                    const char *query)
 {
     size_t i;
 
@@ -949,8 +962,9 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
  *
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success. */
-static int nbd_negotiate_meta_query(NBDClient *client,
-                                    NBDExportMetaContexts *meta, Error **errp)
+static coroutine_fn int
+nbd_negotiate_meta_query(NBDClient *client,
+                         NBDExportMetaContexts *meta, Error **errp)
 {
     int ret;
     g_autofree char *query = NULL;
@@ -989,8 +1003,9 @@ static int nbd_negotiate_meta_query(NBDClient *client,
  * Handle NBD_OPT_LIST_META_CONTEXT and NBD_OPT_SET_META_CONTEXT
  *
  * Return -errno on I/O error, or 0 if option was completely handled. */
-static int nbd_negotiate_meta_queries(NBDClient *client,
-                                      NBDExportMetaContexts *meta, Error **errp)
+static coroutine_fn int
+nbd_negotiate_meta_queries(NBDClient *client,
+                           NBDExportMetaContexts *meta, Error **errp)
 {
     int ret;
     g_autofree char *export_name = NULL;
@@ -1114,7 +1129,8 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
  * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect,
  *         errp is not set
  */
-static int nbd_negotiate_options(NBDClient *client, Error **errp)
+static coroutine_fn int
+nbd_negotiate_options(NBDClient *client, Error **errp)
 {
     uint32_t flags;
     bool fixedNewstyle = false;
-- 
2.39.2


