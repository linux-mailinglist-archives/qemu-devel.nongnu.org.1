Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 427F4B88C58
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Sep 2025 12:12:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzY4e-0002gJ-Tc; Fri, 19 Sep 2025 06:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzY4c-0002f3-0V
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzY4Z-0007PZ-Pz
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758276633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6o8AdnpvSOYyiNoi2F0wZnoPvnTju5K0FpVbmUqYKjE=;
 b=Fqt3PlC/oTXM5F7zZjqiCGZ5nkSeQ+Bv9xMYFATIKjE15GJLDG6qGmnl+Bwfj3svENiK+1
 6rETI/jz4GNF/4ZXNMZCBke+ucb4saZPGmPwGjNTCDSENdnqwFLJVIiB+EcaD8c9Uw2cdo
 TOwcKOWoWB6xbKux2wj3q+QqnsI2i9M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-c-o6BCK0MrW8DVnnd2ByEw-1; Fri,
 19 Sep 2025 06:10:30 -0400
X-MC-Unique: c-o6BCK0MrW8DVnnd2ByEw-1
X-Mimecast-MFC-AGG-ID: c-o6BCK0MrW8DVnnd2ByEw_1758276629
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DDF81800366; Fri, 19 Sep 2025 10:10:28 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE8C418004A3; Fri, 19 Sep 2025 10:10:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/6] crypto: remove extraneous pointer usage in gnutls certs
Date: Fri, 19 Sep 2025 11:10:18 +0100
Message-ID: <20250919101022.1491007-3-berrange@redhat.com>
In-Reply-To: <20250919101022.1491007-1-berrange@redhat.com>
References: <20250919101022.1491007-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The 'gnutls_x509_crt_t' type is already a pointer, not a struct,
so the extra level of pointer indirection is not needed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 797854ac89..91d8dde633 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -325,25 +325,25 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
                                         bool isCA,
                                         Error **errp)
 {
-    gnutls_x509_crt_t *cert_to_check = &cert;
+    gnutls_x509_crt_t cert_to_check = cert;
     int checking_issuer = 1;
     int retval = 0;
 
     while (checking_issuer) {
         checking_issuer = 0;
 
-        if (gnutls_x509_crt_check_issuer(*cert_to_check,
-                                         *cert_to_check)) {
+        if (gnutls_x509_crt_check_issuer(cert_to_check,
+                                         cert_to_check)) {
             /*
              * The cert is self-signed indicating we have
              * reached the root of trust.
              */
             return qcrypto_tls_creds_check_cert(
-                creds, *cert_to_check, cacertFile,
+                creds, cert_to_check, cacertFile,
                 isServer, isCA, errp);
         }
         for (int i = 0; i < ncacerts; i++) {
-            if (gnutls_x509_crt_check_issuer(*cert_to_check,
+            if (gnutls_x509_crt_check_issuer(cert_to_check,
                                              cacerts[i])) {
                 retval = qcrypto_tls_creds_check_cert(
                     creds, cacerts[i], cacertFile,
@@ -351,7 +351,7 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
                 if (retval < 0) {
                     return retval;
                 }
-                cert_to_check = &cacerts[i];
+                cert_to_check = cacerts[i];
                 checking_issuer = 1;
                 break;
             }
-- 
2.50.1


