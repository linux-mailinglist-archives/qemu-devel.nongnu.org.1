Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B009C07050
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Oct 2025 17:42:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCJua-0008Jw-NH; Fri, 24 Oct 2025 11:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCJuX-0008JI-P9
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCJuV-0003PS-I7
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761320458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fgzo4ksGz0Ip8L/XAjnt655h1h1Bh2ciF0Js++tR7Fo=;
 b=K5PpsogPMc5YAp086YEywT+haH6QeaLjVmbjebPpkejjd+xMS7gyEO7WcOl7iaS2UiObh1
 mBkKcpgnT2kFm/+aIe8NiTOqvLEyOkzv5xI7bgWGAvmHzbxv/PqiYYs48o2u/KizzLQMXA
 +knrPSA4AlAeBXscVDyUkkX7iqJINiQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-dsrNz3g2NHC5eWlJyyJwAw-1; Fri,
 24 Oct 2025 11:40:57 -0400
X-MC-Unique: dsrNz3g2NHC5eWlJyyJwAw-1
X-Mimecast-MFC-AGG-ID: dsrNz3g2NHC5eWlJyyJwAw_1761320456
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13DD81955F56; Fri, 24 Oct 2025 15:40:56 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2334719540EB; Fri, 24 Oct 2025 15:40:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 matoro <matoro_mailinglist_qemu@matoro.tk>
Subject: [PULL 11/13] crypto: allow client/server cert chains
Date: Fri, 24 Oct 2025 16:40:22 +0100
Message-ID: <20251024154024.227978-12-berrange@redhat.com>
In-Reply-To: <20251024154024.227978-1-berrange@redhat.com>
References: <20251024154024.227978-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

From: matoro <matoro@users.noreply.github.com>

The existing implementation assumes that client/server certificates are
single individual certificates.  If using publicly-issued certificates,
or internal CAs that use an intermediate issuer, this is unlikely to be
the case, and they will instead be certificate chains.  While this can
be worked around by moving the intermediate certificates to the CA
certificate, which DOES currently support multiple certificates, this
instead allows the issued certificate chains to be used as-is, without
requiring the overhead of shuffling certificates around.

Corresponding libvirt change is available here:
https://gitlab.com/libvirt/libvirt/-/merge_requests/222

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: matoro <matoro_mailinglist_qemu@matoro.tk>
[DB: adapted for code conflicts with multi-CA patch]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c                 | 157 ++++++++++++--------------
 tests/unit/test-crypto-tlscredsx509.c |  77 +++++++++++++
 2 files changed, 147 insertions(+), 87 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 2eccd71b3c..86fdfce886 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -317,7 +317,8 @@ qcrypto_tls_creds_check_cert(QCryptoTLSCredsX509 *creds,
 
 static int
 qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
-                                        gnutls_x509_crt_t cert,
+                                        gnutls_x509_crt_t *certs,
+                                        unsigned int ncerts,
                                         gnutls_x509_crt_t *cacerts,
                                         unsigned int ncacerts,
                                         const char *cacertFile,
@@ -325,9 +326,32 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
                                         bool isCA,
                                         Error **errp)
 {
-    gnutls_x509_crt_t cert_to_check = cert;
+    gnutls_x509_crt_t cert_to_check = certs[ncerts - 1];
     int retval = 0;
-    gnutls_datum_t dn = {};
+    gnutls_datum_t dn = {}, dnissuer = {};
+
+    for (int i = 0; i < (ncerts - 1); i++) {
+        if (!gnutls_x509_crt_check_issuer(certs[i], certs[i + 1])) {
+            retval = gnutls_x509_crt_get_dn2(certs[i], &dn);
+            if (retval < 0) {
+                error_setg(errp, "Unable to fetch cert DN: %s",
+                           gnutls_strerror(retval));
+                return -1;
+            }
+            retval = gnutls_x509_crt_get_dn2(certs[i + 1], &dnissuer);
+            if (retval < 0) {
+                g_free(dn.data);
+                error_setg(errp, "Unable to fetch cert DN: %s",
+                           gnutls_strerror(retval));
+                return -1;
+            }
+            error_setg(errp, "Cert '%s' does not match issuer of cert '%s'",
+                       dnissuer.data, dn.data);
+            g_free(dn.data);
+            g_free(dnissuer.data);
+            return -1;
+        }
+    }
 
     for (;;) {
         gnutls_x509_crt_t cert_issuer = NULL;
@@ -373,7 +397,8 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
 }
 
 static int
-qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t cert,
+qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t *certs,
+                                  size_t ncerts,
                                   const char *certFile,
                                   gnutls_x509_crt_t *cacerts,
                                   size_t ncacerts,
@@ -383,7 +408,7 @@ qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t cert,
 {
     unsigned int status;
 
-    if (gnutls_x509_crt_list_verify(&cert, 1,
+    if (gnutls_x509_crt_list_verify(certs, ncerts,
                                     cacerts, ncacerts,
                                     NULL, 0,
                                     0, &status) < 0) {
@@ -425,66 +450,14 @@ qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t cert,
 }
 
 
-static gnutls_x509_crt_t
-qcrypto_tls_creds_load_cert(QCryptoTLSCredsX509 *creds,
-                            const char *certFile,
-                            bool isServer,
-                            Error **errp)
-{
-    gnutls_datum_t data;
-    gnutls_x509_crt_t cert = NULL;
-    g_autofree char *buf = NULL;
-    gsize buflen;
-    GError *gerr = NULL;
-    int ret = -1;
-    int err;
-
-    trace_qcrypto_tls_creds_x509_load_cert(creds, isServer, certFile);
-
-    err = gnutls_x509_crt_init(&cert);
-    if (err < 0) {
-        error_setg(errp, "Unable to initialize certificate: %s",
-                   gnutls_strerror(err));
-        goto cleanup;
-    }
-
-    if (!g_file_get_contents(certFile, &buf, &buflen, &gerr)) {
-        error_setg(errp, "Cannot load CA cert list %s: %s",
-                   certFile, gerr->message);
-        g_error_free(gerr);
-        goto cleanup;
-    }
-
-    data.data = (unsigned char *)buf;
-    data.size = strlen(buf);
-
-    err = gnutls_x509_crt_import(cert, &data, GNUTLS_X509_FMT_PEM);
-    if (err < 0) {
-        error_setg(errp, isServer ?
-                   "Unable to import server certificate %s: %s" :
-                   "Unable to import client certificate %s: %s",
-                   certFile,
-                   gnutls_strerror(err));
-        goto cleanup;
-    }
-
-    ret = 0;
-
- cleanup:
-    if (ret != 0) {
-        gnutls_x509_crt_deinit(cert);
-        cert = NULL;
-    }
-    return cert;
-}
-
-
 static int
-qcrypto_tls_creds_load_ca_cert_list(QCryptoTLSCredsX509 *creds,
-                                    const char *certFile,
-                                    gnutls_x509_crt_t **certs,
-                                    unsigned int *ncerts,
-                                    Error **errp)
+qcrypto_tls_creds_load_cert_list(QCryptoTLSCredsX509 *creds,
+                                 const char *certFile,
+                                 gnutls_x509_crt_t **certs,
+                                 unsigned int *ncerts,
+                                 bool isServer,
+                                 bool isCA,
+                                 Error **errp)
 {
     gnutls_datum_t data;
     g_autofree char *buf = NULL;
@@ -507,7 +480,9 @@ qcrypto_tls_creds_load_ca_cert_list(QCryptoTLSCredsX509 *creds,
     if (gnutls_x509_crt_list_import2(certs, ncerts, &data,
                                      GNUTLS_X509_FMT_PEM, 0) < 0) {
         error_setg(errp,
-                   "Unable to import CA certificate list %s",
+                   isCA ? "Unable to import CA certificate list %s" :
+                   (isServer ? "Unable to import server certificate %s" :
+                    "Unable to import client certificate %s"),
                    certFile);
         return -1;
     }
@@ -523,7 +498,8 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
                                     const char *certFile,
                                     Error **errp)
 {
-    gnutls_x509_crt_t cert = NULL;
+    gnutls_x509_crt_t *certs = NULL;
+    unsigned int ncerts = 0;
     gnutls_x509_crt_t *cacerts = NULL;
     unsigned int ncacerts = 0;
     size_t i;
@@ -531,41 +507,48 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
 
     if (certFile &&
         access(certFile, R_OK) == 0) {
-        cert = qcrypto_tls_creds_load_cert(creds,
-                                           certFile, isServer,
-                                           errp);
-        if (!cert) {
+        if (qcrypto_tls_creds_load_cert_list(creds,
+                                             certFile,
+                                             &certs,
+                                             &ncerts,
+                                             isServer,
+                                             false,
+                                             errp) < 0) {
             goto cleanup;
         }
     }
     if (access(cacertFile, R_OK) == 0) {
-        if (qcrypto_tls_creds_load_ca_cert_list(creds,
-                                                cacertFile,
-                                                &cacerts,
-                                                &ncacerts,
-                                                errp) < 0) {
+        if (qcrypto_tls_creds_load_cert_list(creds,
+                                             cacertFile,
+                                             &cacerts,
+                                             &ncacerts,
+                                             isServer,
+                                             true,
+                                             errp) < 0) {
             goto cleanup;
         }
     }
 
-    if (cert &&
-        qcrypto_tls_creds_check_cert(creds,
-                                     cert, certFile, isServer,
-                                     false, errp) < 0) {
-        goto cleanup;
+    for (i = 0; i < ncerts; i++) {
+        if (qcrypto_tls_creds_check_cert(creds,
+                                         certs[i], certFile,
+                                         isServer, i != 0, errp) < 0) {
+            goto cleanup;
+        }
     }
 
-    if (cert &&
-        qcrypto_tls_creds_check_authority_chain(creds, cert,
+    if (ncerts &&
+        qcrypto_tls_creds_check_authority_chain(creds,
+                                                certs, ncerts,
                                                 cacerts, ncacerts,
                                                 cacertFile, isServer,
                                                 true, errp) < 0) {
         goto cleanup;
     }
 
-    if (cert && ncacerts &&
-        qcrypto_tls_creds_check_cert_pair(cert, certFile, cacerts,
-                                          ncacerts, cacertFile,
+    if (ncerts && ncacerts &&
+        qcrypto_tls_creds_check_cert_pair(certs, ncerts, certFile,
+                                          cacerts, ncacerts, cacertFile,
                                           isServer, errp) < 0) {
         goto cleanup;
     }
@@ -573,8 +556,8 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
     ret = 0;
 
  cleanup:
-    if (cert) {
-        gnutls_x509_crt_deinit(cert);
+    for (i = 0; i < ncerts; i++) {
+        gnutls_x509_crt_deinit(certs[i]);
     }
     for (i = 0; i < ncacerts; i++) {
         gnutls_x509_crt_deinit(cacerts[i]);
diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
index 7c5df32bcc..96ad4e741b 100644
--- a/tests/unit/test-crypto-tlscredsx509.c
+++ b/tests/unit/test-crypto-tlscredsx509.c
@@ -580,6 +580,12 @@ int main(int argc, char **argv)
                  true, true, GNUTLS_KEY_KEY_CERT_SIGN,
                  false, false, NULL, NULL,
                  0, 0);
+    TLS_ROOT_REQ(someotherrootreq,
+                 "UK", "some other random CA", NULL, NULL, NULL, NULL,
+                 true, true, true,
+                 true, true, GNUTLS_KEY_KEY_CERT_SIGN,
+                 false, false, NULL, NULL,
+                 0, 0);
     TLS_CERT_REQ(cacertlevel1areq, cacertrootreq,
                  "UK", "qemu level 1a", NULL, NULL, NULL, NULL,
                  true, true, true,
@@ -626,6 +632,32 @@ int main(int argc, char **argv)
         cacertlevel2areq.crt,
     };
 
+    gnutls_x509_crt_t cabundle[] = {
+        someotherrootreq.crt,
+        cacertrootreq.crt,
+    };
+
+    gnutls_x509_crt_t servercertchain[] = {
+        servercertlevel3areq.crt,
+        cacertlevel2areq.crt,
+        cacertlevel1areq.crt,
+    };
+
+    gnutls_x509_crt_t servercertchain_incomplete[] = {
+        servercertlevel3areq.crt,
+        cacertlevel2areq.crt,
+    };
+
+    gnutls_x509_crt_t servercertchain_unsorted[] = {
+        servercertlevel3areq.crt,
+        cacertlevel1areq.crt,
+        cacertlevel2areq.crt,
+    };
+
+    gnutls_x509_crt_t clientcertchain[] = {
+        clientcertlevel2breq.crt,
+        cacertlevel1breq.crt,
+    };
 
     test_tls_write_cert_chain(WORKDIR "cacertchain-ctx.pem",
                               certchain,
@@ -665,6 +697,46 @@ int main(int argc, char **argv)
                  WORKDIR "cacertchain-incomplete-ctx.pem",
                  servercertlevel3areq.filename, true);
 
+    test_tls_write_cert_chain(WORKDIR "servercertchain-ctx.pem",
+                              servercertchain,
+                              G_N_ELEMENTS(servercertchain));
+
+    TLS_TEST_REG(serverchain, true,
+                 cacertrootreq.filename,
+                 WORKDIR "servercertchain-ctx.pem", false);
+
+    test_tls_write_cert_chain(WORKDIR "cabundle-ctx.pem",
+                              cabundle,
+                              G_N_ELEMENTS(cabundle));
+
+    TLS_TEST_REG(multiplecaswithchain, true,
+                 WORKDIR "cabundle-ctx.pem",
+                 WORKDIR "servercertchain-ctx.pem", false);
+
+    test_tls_write_cert_chain(WORKDIR "servercertchain_incomplete-ctx.pem",
+                              servercertchain_incomplete,
+                              G_N_ELEMENTS(servercertchain_incomplete));
+
+    TLS_TEST_REG(incompleteserverchain, true,
+                 cacertrootreq.filename,
+                 WORKDIR "servercertchain_incomplete-ctx.pem", true);
+
+    test_tls_write_cert_chain(WORKDIR "servercertchain_unsorted-ctx.pem",
+                              servercertchain_unsorted,
+                              G_N_ELEMENTS(servercertchain_unsorted));
+
+    TLS_TEST_REG(unsortedserverchain, true,
+                 cacertrootreq.filename,
+                 WORKDIR "servercertchain_unsorted-ctx.pem", true);
+
+    test_tls_write_cert_chain(WORKDIR "clientcertchain-ctx.pem",
+                              clientcertchain,
+                              G_N_ELEMENTS(clientcertchain));
+
+    TLS_TEST_REG(clientchain, false,
+                 cacertrootreq.filename,
+                 WORKDIR "clientcertchain-ctx.pem", false);
+
     /* Some missing certs - first two are fatal, the last
      * is ok
      */
@@ -734,8 +806,13 @@ int main(int argc, char **argv)
     test_tls_discard_cert(&cacertlevel2areq);
     test_tls_discard_cert(&servercertlevel3areq);
     test_tls_discard_cert(&clientcertlevel2breq);
+    test_tls_discard_cert(&someotherrootreq);
     unlink(WORKDIR "cacertchain-ctx.pem");
     unlink(WORKDIR "cacertchain-with-invalid-ctx.pem");
+    unlink(WORKDIR "servercertchain-ctx.pem");
+    unlink(WORKDIR "servercertchain_incomplete-ctx.pem");
+    unlink(WORKDIR "servercertchain_unsorted-ctx.pem");
+    unlink(WORKDIR "clientcertchain-ctx.pem");
 
     test_tls_cleanup(KEYFILE);
     rmdir(WORKDIR);
-- 
2.50.1


