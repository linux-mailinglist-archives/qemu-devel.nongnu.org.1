Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2C9BD4FD
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 19:42:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8OUt-0001Xu-Uh; Tue, 05 Nov 2024 13:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8OUa-0001Ur-Qi
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:41:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8OUX-0008GI-Sf
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730832085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/LngSMQlJeEYpc3eJyLSfuVRMc1wQAlW1XQw4yN1t0=;
 b=glUdU5K7542pRsypS9hB9OW/VlAPENSyGdUL57j1ERwkNDC32sSbB8/S/e9l9Kxd6Lsa9y
 LQI2ebfc6YpzvSiv/DIvLjlRF02COjCdcZT91JUTF2goo6Wr+7yAfXAGDbTASLJaKV1ivP
 2MLu/B/o70AZzaTAa2h0K59i/gRApe8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-mUbLf23NNPOft8AIPj_kWg-1; Tue,
 05 Nov 2024 13:41:23 -0500
X-MC-Unique: mUbLf23NNPOft8AIPj_kWg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7313D1955D45; Tue,  5 Nov 2024 18:41:22 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DC6619560A7; Tue,  5 Nov 2024 18:41:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 1/4] crypto: purge 'loaded' property that was not fully removed
Date: Tue,  5 Nov 2024 18:41:12 +0000
Message-ID: <20241105184115.381511-2-berrange@redhat.com>
In-Reply-To: <20241105184115.381511-1-berrange@redhat.com>
References: <20241105184115.381511-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The 'loaded' property on TLS creds and secret objects was marked as
deprecated in 6.0.0. In 7.1.0 the deprecation info was moved into
the 'removed-features.rst' file, but the property was not actually
removed, just made read-only. This was a highly unusual practice,
so finish the long overdue removal job.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/secret_common.c          | 12 --------
 crypto/tlscredsanon.c           | 35 ----------------------
 crypto/tlscredspsk.c            | 34 ----------------------
 crypto/tlscredsx509.c           | 30 -------------------
 docs/about/removed-features.rst |  6 ++--
 qapi/crypto.json                | 51 +++------------------------------
 6 files changed, 7 insertions(+), 161 deletions(-)

diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index 2c141107a5..dbda998940 100644
--- a/crypto/secret_common.c
+++ b/crypto/secret_common.c
@@ -191,15 +191,6 @@ qcrypto_secret_complete(UserCreatable *uc, Error **errp)
 }
 
 
-static bool
-qcrypto_secret_prop_get_loaded(Object *obj,
-                               Error **errp G_GNUC_UNUSED)
-{
-    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
-    return secret->rawdata != NULL;
-}
-
-
 static void
 qcrypto_secret_prop_set_format(Object *obj,
                                int value,
@@ -278,9 +269,6 @@ qcrypto_secret_class_init(ObjectClass *oc, void *data)
 
     ucc->complete = qcrypto_secret_complete;
 
-    object_class_property_add_bool(oc, "loaded",
-                                   qcrypto_secret_prop_get_loaded,
-                                   NULL);
     object_class_property_add_enum(oc, "format",
                                    "QCryptoSecretFormat",
                                    &QCryptoSecretFormat_lookup,
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index c0d23a0ef3..476cf89c96 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -127,37 +127,6 @@ qcrypto_tls_creds_anon_complete(UserCreatable *uc, Error **errp)
 }
 
 
-#ifdef CONFIG_GNUTLS
-
-
-static bool
-qcrypto_tls_creds_anon_prop_get_loaded(Object *obj,
-                                       Error **errp G_GNUC_UNUSED)
-{
-    QCryptoTLSCredsAnon *creds = QCRYPTO_TLS_CREDS_ANON(obj);
-
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        return creds->data.server != NULL;
-    } else {
-        return creds->data.client != NULL;
-    }
-}
-
-
-#else /* ! CONFIG_GNUTLS */
-
-
-static bool
-qcrypto_tls_creds_anon_prop_get_loaded(Object *obj G_GNUC_UNUSED,
-                                       Error **errp G_GNUC_UNUSED)
-{
-    return false;
-}
-
-
-#endif /* ! CONFIG_GNUTLS */
-
-
 static void
 qcrypto_tls_creds_anon_finalize(Object *obj)
 {
@@ -173,10 +142,6 @@ qcrypto_tls_creds_anon_class_init(ObjectClass *oc, void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = qcrypto_tls_creds_anon_complete;
-
-    object_class_property_add_bool(oc, "loaded",
-                                   qcrypto_tls_creds_anon_prop_get_loaded,
-                                   NULL);
 }
 
 
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 0d6b71a37c..aa270d7988 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -206,37 +206,6 @@ qcrypto_tls_creds_psk_complete(UserCreatable *uc, Error **errp)
 }
 
 
-#ifdef CONFIG_GNUTLS
-
-
-static bool
-qcrypto_tls_creds_psk_prop_get_loaded(Object *obj,
-                                      Error **errp G_GNUC_UNUSED)
-{
-    QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
-
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        return creds->data.server != NULL;
-    } else {
-        return creds->data.client != NULL;
-    }
-}
-
-
-#else /* ! CONFIG_GNUTLS */
-
-
-static bool
-qcrypto_tls_creds_psk_prop_get_loaded(Object *obj G_GNUC_UNUSED,
-                                      Error **errp G_GNUC_UNUSED)
-{
-    return false;
-}
-
-
-#endif /* ! CONFIG_GNUTLS */
-
-
 static void
 qcrypto_tls_creds_psk_finalize(Object *obj)
 {
@@ -273,9 +242,6 @@ qcrypto_tls_creds_psk_class_init(ObjectClass *oc, void *data)
 
     ucc->complete = qcrypto_tls_creds_psk_complete;
 
-    object_class_property_add_bool(oc, "loaded",
-                                   qcrypto_tls_creds_psk_prop_get_loaded,
-                                   NULL);
     object_class_property_add_str(oc, "username",
                                   qcrypto_tls_creds_psk_prop_get_username,
                                   qcrypto_tls_creds_psk_prop_set_username);
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index d14313925d..24ec584922 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -695,33 +695,6 @@ qcrypto_tls_creds_x509_complete(UserCreatable *uc, Error **errp)
 }
 
 
-#ifdef CONFIG_GNUTLS
-
-
-static bool
-qcrypto_tls_creds_x509_prop_get_loaded(Object *obj,
-                                       Error **errp G_GNUC_UNUSED)
-{
-    QCryptoTLSCredsX509 *creds = QCRYPTO_TLS_CREDS_X509(obj);
-
-    return creds->data != NULL;
-}
-
-
-#else /* ! CONFIG_GNUTLS */
-
-
-static bool
-qcrypto_tls_creds_x509_prop_get_loaded(Object *obj G_GNUC_UNUSED,
-                                       Error **errp G_GNUC_UNUSED)
-{
-    return false;
-}
-
-
-#endif /* ! CONFIG_GNUTLS */
-
-
 static void
 qcrypto_tls_creds_x509_prop_set_sanity(Object *obj,
                                        bool value,
@@ -838,9 +811,6 @@ qcrypto_tls_creds_x509_class_init(ObjectClass *oc, void *data)
 
     ucc->complete = qcrypto_tls_creds_x509_complete;
 
-    object_class_property_add_bool(oc, "loaded",
-                                   qcrypto_tls_creds_x509_prop_get_loaded,
-                                   NULL);
     object_class_property_add_bool(oc, "sanity-check",
                                    qcrypto_tls_creds_x509_prop_get_sanity,
                                    qcrypto_tls_creds_x509_prop_set_sanity);
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 912e0a1fcf..ee6455aeee 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -355,13 +355,13 @@ The ``-writeconfig`` option was not able to serialize the entire contents
 of the QEMU command line.  It is thus considered a failed experiment
 and removed without a replacement.
 
-``loaded`` property of ``secret`` and ``secret_keyring`` objects (removed in 7.1)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+``loaded`` property of secret and TLS credential objects (removed in 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 The ``loaded=on`` option in the command line or QMP ``object-add`` either had
 no effect (if ``loaded`` was the last option) or caused options to be
 effectively ignored as if they were not given.  The property is therefore
-useless and should simply be removed.
+useless and has been removed.
 
 ``opened`` property of ``rng-*`` objects (removed in 7.1)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 9431522768..7c30df9e31 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -419,11 +419,6 @@
 #
 # Properties for objects of classes derived from secret-common.
 #
-# @loaded: if true, the secret is loaded immediately when applying
-#     this option and will probably fail when processing the next
-#     option.  Don't use; only provided for compatibility.
-#     (default: false)
-#
 # @format: the data format that the secret is provided in
 #     (default: raw)
 #
@@ -436,16 +431,10 @@
 #     16-byte IV.  Mandatory if @keyid is given.  Ignored if @keyid is
 #     absent.
 #
-# Features:
-#
-# @deprecated: Member @loaded is deprecated.  Setting true doesn't
-#     make sense, and false is already the default.
-#
 # Since: 2.6
 ##
 { 'struct': 'SecretCommonProperties',
-  'data': { '*loaded': { 'type': 'bool', 'features': ['deprecated'] },
-            '*format': 'QCryptoSecretFormat',
+  'data': { '*format': 'QCryptoSecretFormat',
             '*keyid': 'str',
             '*iv': 'str' } }
 
@@ -512,58 +501,32 @@
 #
 # Properties for tls-creds-anon objects.
 #
-# @loaded: if true, the credentials are loaded immediately when
-#     applying this option and will ignore options that are processed
-#     later.  Don't use; only provided for compatibility.
-#     (default: false)
-#
-# Features:
-#
-# @deprecated: Member @loaded is deprecated.  Setting true doesn't
-#     make sense, and false is already the default.
-#
 # Since: 2.5
 ##
 { 'struct': 'TlsCredsAnonProperties',
   'base': 'TlsCredsProperties',
-  'data': { '*loaded': { 'type': 'bool', 'features': ['deprecated'] } } }
+  'data': { } }
 
 ##
 # @TlsCredsPskProperties:
 #
 # Properties for tls-creds-psk objects.
 #
-# @loaded: if true, the credentials are loaded immediately when
-#     applying this option and will ignore options that are processed
-#     later.  Don't use; only provided for compatibility.
-#     (default: false)
-#
 # @username: the username which will be sent to the server.  For
 #     clients only.  If absent, "qemu" is sent and the property will
 #     read back as an empty string.
 #
-# Features:
-#
-# @deprecated: Member @loaded is deprecated.  Setting true doesn't
-#     make sense, and false is already the default.
-#
 # Since: 3.0
 ##
 { 'struct': 'TlsCredsPskProperties',
   'base': 'TlsCredsProperties',
-  'data': { '*loaded': { 'type': 'bool', 'features': ['deprecated'] },
-            '*username': 'str' } }
+  'data': { '*username': 'str' } }
 
 ##
 # @TlsCredsX509Properties:
 #
 # Properties for tls-creds-x509 objects.
 #
-# @loaded: if true, the credentials are loaded immediately when
-#     applying this option and will ignore options that are processed
-#     later.  Don't use; only provided for compatibility.
-#     (default: false)
-#
 # @sanity-check: if true, perform some sanity checks before using the
 #     credentials (default: true)
 #
@@ -573,17 +536,11 @@
 #     provides the ID of a previously created secret object containing
 #     the password for decryption.
 #
-# Features:
-#
-# @deprecated: Member @loaded is deprecated.  Setting true doesn't
-#     make sense, and false is already the default.
-#
 # Since: 2.5
 ##
 { 'struct': 'TlsCredsX509Properties',
   'base': 'TlsCredsProperties',
-  'data': { '*loaded': { 'type': 'bool', 'features': ['deprecated'] },
-            '*sanity-check': 'bool',
+  'data': { '*sanity-check': 'bool',
             '*passwordid': 'str' } }
 ##
 # @QCryptoAkCipherAlgo:
-- 
2.46.0


