Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 342D8A2CD47
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Feb 2025 20:55:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgUQc-0003CB-MD; Fri, 07 Feb 2025 14:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgUQX-0003Br-P2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:54:13 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgUQV-0000Mm-Or
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:54:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4BA2E21167;
 Fri,  7 Feb 2025 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738958050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovO6qHrkAr+/7+/bqOCxyc94bJK8F+uq54Jb3uQHc4Q=;
 b=Ge70JvE1n42rSEAaQSizYCaErh7dnurTnDMwpPY6eUKmoSvne2Jrk2oNzIly77X3Ed8bPi
 v4btP4Vl/phVFAytm0YD8aNRobK5VNU+saZLe/Xs+wmcQa7B96vSig1fPVUEJb1VZfy0rM
 brNTrRc7J9p1mXOrfJYHHd33d4DFvKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738958050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovO6qHrkAr+/7+/bqOCxyc94bJK8F+uq54Jb3uQHc4Q=;
 b=yuy9dz+343jKmqig+Z6G/y7iDLkQ4dDRaIiOS9BSRwzlmlvKxe+6bPYm1w/YF158q9GF5Z
 rWP4L7wTxwFePWBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ge70JvE1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yuy9dz+3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738958050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovO6qHrkAr+/7+/bqOCxyc94bJK8F+uq54Jb3uQHc4Q=;
 b=Ge70JvE1n42rSEAaQSizYCaErh7dnurTnDMwpPY6eUKmoSvne2Jrk2oNzIly77X3Ed8bPi
 v4btP4Vl/phVFAytm0YD8aNRobK5VNU+saZLe/Xs+wmcQa7B96vSig1fPVUEJb1VZfy0rM
 brNTrRc7J9p1mXOrfJYHHd33d4DFvKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738958050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovO6qHrkAr+/7+/bqOCxyc94bJK8F+uq54Jb3uQHc4Q=;
 b=yuy9dz+343jKmqig+Z6G/y7iDLkQ4dDRaIiOS9BSRwzlmlvKxe+6bPYm1w/YF158q9GF5Z
 rWP4L7wTxwFePWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A69AD13694;
 Fri,  7 Feb 2025 19:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6CSjGOBkpme1GQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 19:54:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH v3 3/8] crypto: Remove
 qcrypto_tls_session_get_handshake_status
Date: Fri,  7 Feb 2025 16:53:54 -0300
Message-Id: <20250207195359.17443-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250207195359.17443-1-farosas@suse.de>
References: <20250207195359.17443-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4BA2E21167
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The correct way of calling qcrypto_tls_session_handshake() requires
calling qcrypto_tls_session_get_handshake_status() right after it so
there's no reason to have a separate method.

Refactor qcrypto_tls_session_handshake() to inform the status in its
own return value and alter the callers accordingly.

No functional change.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 crypto/tlssession.c                 | 63 +++++++++++------------------
 include/crypto/tlssession.h         | 32 ++++-----------
 io/channel-tls.c                    |  7 ++--
 tests/unit/test-crypto-tlssession.c | 12 ++----
 4 files changed, 39 insertions(+), 75 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index d769d7a304..6d8f8df623 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -546,45 +546,35 @@ qcrypto_tls_session_handshake(QCryptoTLSSession *session,
                               Error **errp)
 {
     int ret = gnutls_handshake(session->handle);
-    if (ret == 0) {
+    if (!ret) {
         session->handshakeComplete = true;
-    } else {
-        if (ret == GNUTLS_E_INTERRUPTED ||
-            ret == GNUTLS_E_AGAIN) {
-            ret = 1;
-        } else {
-            if (session->rerr || session->werr) {
-                error_setg(errp, "TLS handshake failed: %s: %s",
-                           gnutls_strerror(ret),
-                           error_get_pretty(session->rerr ?
-                                            session->rerr : session->werr));
-            } else {
-                error_setg(errp, "TLS handshake failed: %s",
-                           gnutls_strerror(ret));
-            }
-            ret = -1;
-        }
-    }
-    error_free(session->rerr);
-    error_free(session->werr);
-    session->rerr = session->werr = NULL;
-
-    return ret;
-}
-
-
-QCryptoTLSSessionHandshakeStatus
-qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *session)
-{
-    if (session->handshakeComplete) {
         return QCRYPTO_TLS_HANDSHAKE_COMPLETE;
-    } else if (gnutls_record_get_direction(session->handle) == 0) {
-        return QCRYPTO_TLS_HANDSHAKE_RECVING;
+    }
+
+    if (ret == GNUTLS_E_INTERRUPTED || ret == GNUTLS_E_AGAIN) {
+        int direction = gnutls_record_get_direction(session->handle);
+        return direction ? QCRYPTO_TLS_HANDSHAKE_SENDING :
+            QCRYPTO_TLS_HANDSHAKE_RECVING;
+    }
+
+    if (session->rerr || session->werr) {
+        error_setg(errp, "TLS handshake failed: %s: %s",
+                   gnutls_strerror(ret),
+                   error_get_pretty(session->rerr ?
+                                    session->rerr : session->werr));
     } else {
-        return QCRYPTO_TLS_HANDSHAKE_SENDING;
+        error_setg(errp, "TLS handshake failed: %s",
+                   gnutls_strerror(ret));
     }
+
+    error_free(session->rerr);
+    error_free(session->werr);
+    session->rerr = session->werr = NULL;
+
+    return -1;
 }
 
+
 int
 qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp)
 {
@@ -726,13 +716,6 @@ qcrypto_tls_session_handshake(QCryptoTLSSession *sess,
 }
 
 
-QCryptoTLSSessionHandshakeStatus
-qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *sess)
-{
-    return QCRYPTO_TLS_HANDSHAKE_COMPLETE;
-}
-
-
 int
 qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp)
 {
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index c0f64ce989..d77ae0d423 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -75,12 +75,14 @@
  *                                      GINT_TO_POINTER(fd));
  *
  *    while (1) {
- *       if (qcrypto_tls_session_handshake(sess, errp) < 0) {
+ *       int ret = qcrypto_tls_session_handshake(sess, errp);
+ *
+ *       if (ret < 0) {
  *           qcrypto_tls_session_free(sess);
  *           return -1;
  *       }
  *
- *       switch(qcrypto_tls_session_get_handshake_status(sess)) {
+ *       switch(ret) {
  *       case QCRYPTO_TLS_HANDSHAKE_COMPLETE:
  *           if (qcrypto_tls_session_check_credentials(sess, errp) < )) {
  *               qcrypto_tls_session_free(sess);
@@ -170,7 +172,7 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSSession, qcrypto_tls_session_free)
  *
  * Validate the peer's credentials after a successful
  * TLS handshake. It is an error to call this before
- * qcrypto_tls_session_get_handshake_status() returns
+ * qcrypto_tls_session_handshake() returns
  * QCRYPTO_TLS_HANDSHAKE_COMPLETE
  *
  * Returns 0 if the credentials validated, -1 on error
@@ -226,7 +228,7 @@ void qcrypto_tls_session_set_callbacks(QCryptoTLSSession *sess,
  * registered with qcrypto_tls_session_set_callbacks()
  *
  * It is an error to call this before
- * qcrypto_tls_session_get_handshake_status() returns
+ * qcrypto_tls_session_handshake() returns
  * QCRYPTO_TLS_HANDSHAKE_COMPLETE
  *
  * Returns: the number of bytes sent,
@@ -256,7 +258,7 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
  * opposed to an error.
  *
  * It is an error to call this before
- * qcrypto_tls_session_get_handshake_status() returns
+ * qcrypto_tls_session_handshake() returns
  * QCRYPTO_TLS_HANDSHAKE_COMPLETE
  *
  * Returns: the number of bytes received,
@@ -289,8 +291,7 @@ size_t qcrypto_tls_session_check_pending(QCryptoTLSSession *sess);
  * the underlying data channel is non-blocking, then
  * this method may return control before the handshake
  * is complete. On non-blocking channels the
- * qcrypto_tls_session_get_handshake_status() method
- * should be used to determine whether the handshake
+ * return value determines whether the handshake
  * has completed, or is waiting to send or receive
  * data. In the latter cases, the caller should setup
  * an event loop watch and call this method again
@@ -306,23 +307,6 @@ typedef enum {
     QCRYPTO_TLS_HANDSHAKE_RECVING,
 } QCryptoTLSSessionHandshakeStatus;
 
-/**
- * qcrypto_tls_session_get_handshake_status:
- * @sess: the TLS session object
- *
- * Check the status of the TLS handshake. This
- * is used with non-blocking data channels to
- * determine whether the handshake is waiting
- * to send or receive further data to/from the
- * remote peer.
- *
- * Once this returns QCRYPTO_TLS_HANDSHAKE_COMPLETE
- * it is permitted to send/receive payload data on
- * the channel
- */
-QCryptoTLSSessionHandshakeStatus
-qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *sess);
-
 typedef enum {
     QCRYPTO_TLS_BYE_COMPLETE,
     QCRYPTO_TLS_BYE_SENDING,
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 517ce190a4..ecde6b57bf 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -162,16 +162,17 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
                                            GMainContext *context)
 {
     Error *err = NULL;
-    QCryptoTLSSessionHandshakeStatus status;
+    int status;
 
-    if (qcrypto_tls_session_handshake(ioc->session, &err) < 0) {
+    status = qcrypto_tls_session_handshake(ioc->session, &err);
+
+    if (status < 0) {
         trace_qio_channel_tls_handshake_fail(ioc);
         qio_task_set_error(task, err);
         qio_task_complete(task);
         return;
     }
 
-    status = qcrypto_tls_session_get_handshake_status(ioc->session);
     if (status == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
         trace_qio_channel_tls_handshake_complete(ioc);
         if (qcrypto_tls_session_check_credentials(ioc->session,
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index 3395f73560..554054e934 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -158,8 +158,7 @@ static void test_crypto_tls_session_psk(void)
             rv = qcrypto_tls_session_handshake(serverSess,
                                                &error_abort);
             g_assert(rv >= 0);
-            if (qcrypto_tls_session_get_handshake_status(serverSess) ==
-                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+            if (rv == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
                 serverShake = true;
             }
         }
@@ -167,8 +166,7 @@ static void test_crypto_tls_session_psk(void)
             rv = qcrypto_tls_session_handshake(clientSess,
                                                &error_abort);
             g_assert(rv >= 0);
-            if (qcrypto_tls_session_get_handshake_status(clientSess) ==
-                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+            if (rv == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
                 clientShake = true;
             }
         }
@@ -352,8 +350,7 @@ static void test_crypto_tls_session_x509(const void *opaque)
             rv = qcrypto_tls_session_handshake(serverSess,
                                                &error_abort);
             g_assert(rv >= 0);
-            if (qcrypto_tls_session_get_handshake_status(serverSess) ==
-                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+            if (rv == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
                 serverShake = true;
             }
         }
@@ -361,8 +358,7 @@ static void test_crypto_tls_session_x509(const void *opaque)
             rv = qcrypto_tls_session_handshake(clientSess,
                                                &error_abort);
             g_assert(rv >= 0);
-            if (qcrypto_tls_session_get_handshake_status(clientSess) ==
-                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+            if (rv == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
                 clientShake = true;
             }
         }
-- 
2.35.3


