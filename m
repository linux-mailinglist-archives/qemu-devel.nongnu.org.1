Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 133C5B0061B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Jul 2025 17:12:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsvl-0004Vk-Uj; Thu, 10 Jul 2025 11:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZsnP-0004xB-FN
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZsnK-0004Lr-Dr
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752159760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PM8ens6wZiZHRK96EPP1/mQYMBfWUxKWG/+qPNVY3rw=;
 b=fzYyoMPuQriSCwD88g9AG6YwDEWWRYb+KRf3G01z9It1bLSb3FZKCOH0d1KS4nfxjoThjU
 L1lr/fFXuFJcgfnqA3zYhu7uzcpfn7snHPeiJ29JvottKHav8pIahmfFE3IQddcX2I4+R7
 V/VBXiaY+ktNE8goU6DVW9m1OrU/QjU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-50_lcVgkPZuKPRB2IX1XZw-1; Thu,
 10 Jul 2025 11:02:38 -0400
X-MC-Unique: 50_lcVgkPZuKPRB2IX1XZw-1
X-Mimecast-MFC-AGG-ID: 50_lcVgkPZuKPRB2IX1XZw_1752159758
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08F191955F2C
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 15:02:38 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.76])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0669319560A3; Thu, 10 Jul 2025 15:02:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] crypto: stop requiring "key encipherment" usage in x509 certs
Date: Thu, 10 Jul 2025 16:02:35 +0100
Message-ID: <20250710150235.836976-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This usage flag was deprecated by RFC8813, such that it is
forbidden to be present for certs using ECDSA/ECDH algorithms,
and in TLS 1.3 is is conceptually obsolete.

As such many valid certs will no longer have this key usage
flag set, and QEMU should not be rejecting them.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c                 | 10 +-------
 docs/system/tls.rst                   | 13 +++-------
 tests/unit/crypto-tls-x509-helpers.h  |  6 ++---
 tests/unit/test-crypto-tlscredsx509.c | 36 +++++++++++++--------------
 tests/unit/test-crypto-tlssession.c   | 14 +++++------
 tests/unit/test-io-channel-tls.c      |  4 +--
 6 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 63a72fe47c..997602ec6b 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -144,7 +144,7 @@ qcrypto_tls_creds_check_cert_key_usage(QCryptoTLSCredsX509 *creds,
     if (status < 0) {
         if (status == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
             usage = isCA ? GNUTLS_KEY_KEY_CERT_SIGN :
-                GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT;
+                GNUTLS_KEY_DIGITAL_SIGNATURE;
         } else {
             error_setg(errp,
                        "Unable to query certificate %s key usage: %s",
@@ -171,14 +171,6 @@ qcrypto_tls_creds_check_cert_key_usage(QCryptoTLSCredsX509 *creds,
                 return -1;
             }
         }
-        if (!(usage & GNUTLS_KEY_KEY_ENCIPHERMENT)) {
-            if (critical) {
-                error_setg(errp,
-                           "Certificate %s usage does not permit key "
-                           "encipherment", certFile);
-                return -1;
-            }
-        }
     }
 
     return 0;
diff --git a/docs/system/tls.rst b/docs/system/tls.rst
index e284c82801..a4f6781d62 100644
--- a/docs/system/tls.rst
+++ b/docs/system/tls.rst
@@ -118,7 +118,6 @@ information for each server, and use it to issue server certificates.
    ip_address = 2620:0:cafe::87
    ip_address = 2001:24::92
    tls_www_server
-   encryption_key
    signing_key
    EOF
    # certtool --generate-privkey > server-hostNNN-key.pem
@@ -134,9 +133,8 @@ the subject alt name extension data. The ``tls_www_server`` keyword is
 the key purpose extension to indicate this certificate is intended for
 usage in a web server. Although QEMU network services are not in fact
 HTTP servers (except for VNC websockets), setting this key purpose is
-still recommended. The ``encryption_key`` and ``signing_key`` keyword is
-the key usage extension to indicate this certificate is intended for
-usage in the data session.
+still recommended. The ``signing_key`` keyword is the key usage extension
+to indicate this certificate is intended for usage in the data session.
 
 The ``server-hostNNN-key.pem`` and ``server-hostNNN-cert.pem`` files
 should now be securely copied to the server for which they were
@@ -171,7 +169,6 @@ certificates.
    organization = Name of your organization
    cn = hostNNN.foo.example.com
    tls_www_client
-   encryption_key
    signing_key
    EOF
    # certtool --generate-privkey > client-hostNNN-key.pem
@@ -187,9 +184,8 @@ the ``dns_name`` and ``ip_address`` fields are not included. The
 ``tls_www_client`` keyword is the key purpose extension to indicate this
 certificate is intended for usage in a web client. Although QEMU network
 clients are not in fact HTTP clients, setting this key purpose is still
-recommended. The ``encryption_key`` and ``signing_key`` keyword is the
-key usage extension to indicate this certificate is intended for usage
-in the data session.
+recommended. The ``signing_key`` keyword is the key usage extension to
+indicate this certificate is intended for usage in the data session.
 
 The ``client-hostNNN-key.pem`` and ``client-hostNNN-cert.pem`` files
 should now be securely copied to the client for which they were
@@ -222,7 +218,6 @@ client and server instructions in one.
    ip_address = 2001:24::92
    tls_www_server
    tls_www_client
-   encryption_key
    signing_key
    EOF
    # certtool --generate-privkey > both-hostNNN-key.pem
diff --git a/tests/unit/crypto-tls-x509-helpers.h b/tests/unit/crypto-tls-x509-helpers.h
index 2a0f7c04fd..7e9a508ad6 100644
--- a/tests/unit/crypto-tls-x509-helpers.h
+++ b/tests/unit/crypto-tls-x509-helpers.h
@@ -148,8 +148,7 @@ void test_tls_cleanup(const char *keyfile);
         .basicConstraintsIsCA = false,                                  \
         .keyUsageEnable = true,                                         \
         .keyUsageCritical = true,                                       \
-        .keyUsageValue =                                                \
-        GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,     \
+        .keyUsageValue = GNUTLS_KEY_DIGITAL_SIGNATURE,                  \
         .keyPurposeEnable = true,                                       \
         .keyPurposeCritical = true,                                     \
         .keyPurposeOID1 = GNUTLS_KP_TLS_WWW_CLIENT,                     \
@@ -168,8 +167,7 @@ void test_tls_cleanup(const char *keyfile);
         .basicConstraintsIsCA = false,                                  \
         .keyUsageEnable = true,                                         \
         .keyUsageCritical = true,                                       \
-        .keyUsageValue =                                                \
-        GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,     \
+        .keyUsageValue = GNUTLS_KEY_DIGITAL_SIGNATURE,                  \
         .keyPurposeEnable = true,                                       \
         .keyPurposeCritical = true,                                     \
         .keyPurposeOID1 = GNUTLS_KP_TLS_WWW_SERVER,                     \
diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
index 3c25d75ca1..2025d75365 100644
--- a/tests/unit/test-crypto-tlscredsx509.c
+++ b/tests/unit/test-crypto-tlscredsx509.c
@@ -166,14 +166,14 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(clientcertreq, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
@@ -196,7 +196,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
 
@@ -211,7 +211,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
 
@@ -226,7 +226,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
 
@@ -250,7 +250,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     /* no-basic */
@@ -264,7 +264,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     /* Key usage:dig-sig:critical */
@@ -278,7 +278,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
 
@@ -303,7 +303,7 @@ int main(int argc, char **argv)
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT |
+                 GNUTLS_KEY_DIGITAL_SIGNATURE |
                  GNUTLS_KEY_KEY_CERT_SIGN,
                  false, false, NULL, NULL,
                  0, 0);
@@ -406,7 +406,7 @@ int main(int argc, char **argv)
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT |
+                 GNUTLS_KEY_DIGITAL_SIGNATURE |
                  GNUTLS_KEY_KEY_CERT_SIGN,
                  false, false, NULL, NULL,
                  0, 0);
@@ -508,21 +508,21 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(servercertexp1req, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, -1);
     TLS_CERT_REQ(clientcertexp1req, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, -1);
 
@@ -546,21 +546,21 @@ int main(int argc, char **argv)
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(servercertnew1req, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  1, 2);
     TLS_CERT_REQ(clientcertnew1req, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  1, 2);
 
@@ -599,14 +599,14 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(clientcertlevel2breq, cacertlevel1breq,
                  "UK", "qemu client level 2b", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index 554054e934..e8b2e0201c 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -472,14 +472,14 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(clientcertreq, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
@@ -487,7 +487,7 @@ int main(int argc, char **argv)
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
@@ -506,7 +506,7 @@ int main(int argc, char **argv)
                  "192.168.122.1", "fec0::dead:beaf",
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     /* This intentionally doesn't replicate */
@@ -515,7 +515,7 @@ int main(int argc, char **argv)
                  "192.168.122.1", "fec0::dead:beaf",
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
 
@@ -619,14 +619,14 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(clientcertlevel2breq, cacertlevel1breq,
                  "UK", "qemu client level 2b", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
diff --git a/tests/unit/test-io-channel-tls.c b/tests/unit/test-io-channel-tls.c
index e036ac5df4..c2115d45fe 100644
--- a/tests/unit/test-io-channel-tls.c
+++ b/tests/unit/test-io-channel-tls.c
@@ -302,14 +302,14 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(clientcertreq, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
-- 
2.49.0


