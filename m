Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21EB0738E
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Jul 2025 12:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzTo-0004Ga-AS; Wed, 16 Jul 2025 06:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubzP9-0000GL-OC
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubzP5-0005bv-VX
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752661822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=srjPeL4fPO+OUjPtYdfExNUSdE3G2GNtD7kVnIHeQFc=;
 b=c2OtDwik9AL//o1NUEPYAck45btqU7MC/oKGmIYCoeRZyfFKUElaTEkzua4aCJg1iHBlGh
 oFYcNsJROjqepBVpJUyHZ7MP4Ch0oEPpUczCGxw5KMD4mjbJY2a4CrOJtA/mO8u2r3nFcR
 GIWUNYVLcA6Q9At4A5CUcHUjxdeTtqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-5KOER4fqN2unBz6GN0p-9A-1; Wed,
 16 Jul 2025 06:30:20 -0400
X-MC-Unique: 5KOER4fqN2unBz6GN0p-9A-1
X-Mimecast-MFC-AGG-ID: 5KOER4fqN2unBz6GN0p-9A_1752661820
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8EA51800C31; Wed, 16 Jul 2025 10:30:19 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.68])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CE131954215; Wed, 16 Jul 2025 10:30:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/4] crypto/x509-utils: Check for error from
 gnutls_x509_crt_init()
Date: Wed, 16 Jul 2025 11:30:08 +0100
Message-ID: <20250716103009.2047433-4-berrange@redhat.com>
In-Reply-To: <20250716103009.2047433-1-berrange@redhat.com>
References: <20250716103009.2047433-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Coverity notes that in qcrypto_get_x509_cert_fingerprint() we
call gnutls_x509_crt_init() but don't check for an error return.
Add the missing check.

Coverity: CID 1593155
Fixes: 10a1d34fc0d ("crypto: Introduce x509 utils")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/x509-utils.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 8bad00a51b..39bb6d4d8c 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -46,7 +46,11 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
         return -1;
     }
 
-    gnutls_x509_crt_init(&crt);
+    if (gnutls_x509_crt_init(&crt) < 0) {
+        error_setg(errp, "Unable to initialize certificate: %s",
+                   gnutls_strerror(ret));
+        return -1;
+    }
 
     if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
         error_setg(errp, "Failed to import certificate");
-- 
2.49.0


