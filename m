Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 073DFC20B72
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Oct 2025 15:50:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETxE-0008VW-G9; Thu, 30 Oct 2025 10:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETx5-0008St-E9
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETwy-0001Ke-SV
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSnnNfVNIJzHqlsNlJyg3a8mhruvQnJerkqtoff8Uj8=;
 b=bjMPwDL3moXPxUcJctiWO0KrpM2QhXIdHpf6w/WCbJoOBdOK+4HcMU5lsnlM+PdKzXohRk
 6JHnNtms3kR7w557MMFh64nQRmx6mf/ifEI0/l7aQVeglc3xpPZOMX+FQ4EfHIJWvQubQX
 SZbCo8EXBkFUWvDx3qQW4p/BHglDy+g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-wjISHLXlPMaesdJ5eZ4w_g-1; Thu,
 30 Oct 2025 10:48:20 -0400
X-MC-Unique: wjISHLXlPMaesdJ5eZ4w_g-1
X-Mimecast-MFC-AGG-ID: wjISHLXlPMaesdJ5eZ4w_g_1761835699
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B89EB1956089; Thu, 30 Oct 2025 14:48:19 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77091180035A; Thu, 30 Oct 2025 14:48:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 06/21] crypto: use g_autofree when loading x509 credentials
Date: Thu, 30 Oct 2025 14:47:50 +0000
Message-ID: <20251030144805.2239954-7-berrange@redhat.com>
In-Reply-To: <20251030144805.2239954-1-berrange@redhat.com>
References: <20251030144805.2239954-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This allows removal of goto jumps during loading of the credentials
and will simplify the diff in following commits.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 8fe6cc8e93..e5b869a35f 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -562,10 +562,12 @@ static int
 qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
                             Error **errp)
 {
-    char *cacert = NULL, *cacrl = NULL, *cert = NULL,
-        *key = NULL, *dhparams = NULL;
+    g_autofree char *cacert = NULL;
+    g_autofree char *cacrl = NULL;
+    g_autofree char *cert = NULL;
+    g_autofree char *key = NULL;
+    g_autofree char *dhparams = NULL;
     int ret;
-    int rv = -1;
 
     if (!creds->parent_obj.dir) {
         error_setg(errp, "Missing 'dir' property value");
@@ -590,7 +592,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
             qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
                                        false, &dhparams, errp) < 0) {
-            goto cleanup;
+            return -1;
         }
     } else {
         if (qcrypto_tls_creds_get_path(&creds->parent_obj,
@@ -602,7 +604,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
             qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
                                        false, &key, errp) < 0) {
-            goto cleanup;
+            return -1;
         }
     }
 
@@ -610,14 +612,14 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         qcrypto_tls_creds_x509_sanity_check(creds,
             creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
             cacert, cert, errp) < 0) {
-        goto cleanup;
+        return -1;
     }
 
     ret = gnutls_certificate_allocate_credentials(&creds->data);
     if (ret < 0) {
         error_setg(errp, "Cannot allocate credentials: '%s'",
                    gnutls_strerror(ret));
-        goto cleanup;
+        return -1;
     }
 
     ret = gnutls_certificate_set_x509_trust_file(creds->data,
@@ -626,7 +628,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
     if (ret < 0) {
         error_setg(errp, "Cannot load CA certificate '%s': %s",
                    cacert, gnutls_strerror(ret));
-        goto cleanup;
+        return -1;
     }
 
     if (cert != NULL && key != NULL) {
@@ -635,7 +637,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
             password = qcrypto_secret_lookup_as_utf8(creds->passwordid,
                                                      errp);
             if (!password) {
-                goto cleanup;
+                return -1;
             }
         }
         ret = gnutls_certificate_set_x509_key_file2(creds->data,
@@ -647,7 +649,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         if (ret < 0) {
             error_setg(errp, "Cannot load certificate '%s' & key '%s': %s",
                        cert, key, gnutls_strerror(ret));
-            goto cleanup;
+            return -1;
         }
     }
 
@@ -658,7 +660,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         if (ret < 0) {
             error_setg(errp, "Cannot load CRL '%s': %s",
                        cacrl, gnutls_strerror(ret));
-            goto cleanup;
+            return -1;
         }
     }
 
@@ -666,20 +668,13 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
                                                  &creds->parent_obj.dh_params,
                                                  errp) < 0) {
-            goto cleanup;
+            return -1;
         }
         gnutls_certificate_set_dh_params(creds->data,
                                          creds->parent_obj.dh_params);
     }
 
-    rv = 0;
- cleanup:
-    g_free(cacert);
-    g_free(cacrl);
-    g_free(cert);
-    g_free(key);
-    g_free(dhparams);
-    return rv;
+    return 0;
 }
 
 
-- 
2.51.1


