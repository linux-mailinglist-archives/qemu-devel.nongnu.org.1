Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16072A2AF92
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 18:59:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg69e-00060Y-U4; Thu, 06 Feb 2025 12:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg69b-0005zB-Ct
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:59:07 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg69Z-0001Iq-B0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:59:07 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 313FB21160;
 Thu,  6 Feb 2025 17:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738864743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U22VqVoz6225v8/16Ad9BJuXC9qjJ9L4yLcwFdwf+8A=;
 b=b/iOedrvd7HlmKsbji7dRd6LebD8emt1cDJ0CU5L49Jm7R+UkgZwW6u/eg02yi57iuKFh8
 VizQMRHHaUOV2doYpYsxkmjdO3ZoByDXM3pliG3Fy2Muk6ek295kBD2lrEKi975Zj43h8x
 Iv5S2NFrDgZY8Q2sYNBs113zWvU/5dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738864743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U22VqVoz6225v8/16Ad9BJuXC9qjJ9L4yLcwFdwf+8A=;
 b=D1lpjVJYE4U6uKGGn+7zTWDmAXJlFrA9R6hvOd/unJzxQt/5vR7jXn7vQV0A5zxkWv+wV4
 q2lQ7PVYUGKsB3Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738864743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U22VqVoz6225v8/16Ad9BJuXC9qjJ9L4yLcwFdwf+8A=;
 b=b/iOedrvd7HlmKsbji7dRd6LebD8emt1cDJ0CU5L49Jm7R+UkgZwW6u/eg02yi57iuKFh8
 VizQMRHHaUOV2doYpYsxkmjdO3ZoByDXM3pliG3Fy2Muk6ek295kBD2lrEKi975Zj43h8x
 Iv5S2NFrDgZY8Q2sYNBs113zWvU/5dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738864743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U22VqVoz6225v8/16Ad9BJuXC9qjJ9L4yLcwFdwf+8A=;
 b=D1lpjVJYE4U6uKGGn+7zTWDmAXJlFrA9R6hvOd/unJzxQt/5vR7jXn7vQV0A5zxkWv+wV4
 q2lQ7PVYUGKsB3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8608413697;
 Thu,  6 Feb 2025 17:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8DiKEGX4pGeVZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 06 Feb 2025 17:59:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 1/4] crypto: Allow gracefully ending the TLS session
Date: Thu,  6 Feb 2025 14:58:21 -0300
Message-Id: <20250206175824.22664-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250206175824.22664-1-farosas@suse.de>
References: <20250206175824.22664-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

QEMU's TLS session code provides no way to call gnutls_bye() to
terminate a TLS session. Callers of qcrypto_tls_session_read() can
choose to ignore a GNUTLS_E_PREMATURE_TERMINATION error by setting the
gracefulTermination argument.

The QIOChannelTLS ignores the premature termination error whenever
shutdown() has already been issued. This is not enough anymore for the
migration code due to changes [1] in the synchronization between
migration source and destination.

Add support for calling gnutls_bye() in the tlssession layer so users
of QIOChannelTLS can clearly identify the end of a TLS session.

1- 1d457daf86 ("migration/multifd: Further remove the SYNC on complete")

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 crypto/tlssession.c         | 40 +++++++++++++++++++++++++++++++++++++
 include/crypto/tlssession.h | 22 ++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 77286e23f4..d52714a3f3 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -585,6 +585,40 @@ qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *session)
     }
 }
 
+int
+qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp)
+{
+    int ret;
+
+    if (!session->handshakeComplete) {
+        return 0;
+    }
+
+    ret = gnutls_bye(session->handle, GNUTLS_SHUT_WR);
+
+    if (!ret) {
+        return QCRYPTO_TLS_BYE_COMPLETE;
+    }
+
+    if (ret == GNUTLS_E_INTERRUPTED || ret == GNUTLS_E_AGAIN) {
+        int direction = gnutls_record_get_direction(session->handle);
+        return direction ? QCRYPTO_TLS_BYE_SENDING : QCRYPTO_TLS_BYE_RECVING;
+    }
+
+    if (session->rerr || session->werr) {
+        error_setg(errp, "TLS termination failed: %s: %s", gnutls_strerror(ret),
+                   error_get_pretty(session->rerr ?
+                                    session->rerr : session->werr));
+    } else {
+        error_setg(errp, "TLS termination failed: %s", gnutls_strerror(ret));
+    }
+
+    error_free(session->rerr);
+    error_free(session->werr);
+    session->rerr = session->werr = NULL;
+
+    return -1;
+}
 
 int
 qcrypto_tls_session_get_key_size(QCryptoTLSSession *session,
@@ -699,6 +733,12 @@ qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *sess)
 }
 
 
+int
+qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp)
+{
+    return QCRYPTO_TLS_BYE_COMPLETE;
+}
+
 int
 qcrypto_tls_session_get_key_size(QCryptoTLSSession *sess,
                                  Error **errp)
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index f694a5c3c5..c0f64ce989 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -323,6 +323,28 @@ typedef enum {
 QCryptoTLSSessionHandshakeStatus
 qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *sess);
 
+typedef enum {
+    QCRYPTO_TLS_BYE_COMPLETE,
+    QCRYPTO_TLS_BYE_SENDING,
+    QCRYPTO_TLS_BYE_RECVING,
+} QCryptoTLSSessionByeStatus;
+
+/**
+ * qcrypto_tls_session_bye:
+ * @session: the TLS session object
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Start, or continue, a TLS termination sequence. If the underlying
+ * data channel is non-blocking, then this method may return control
+ * before the termination is complete. The return value will indicate
+ * whether the termination has completed, or is waiting to send or
+ * receive data. In the latter cases, the caller should setup an event
+ * loop watch and call this method again once the underlying data
+ * channel is ready to read or write again.
+ */
+int
+qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp);
+
 /**
  * qcrypto_tls_session_get_key_size:
  * @sess: the TLS session object
-- 
2.35.3


