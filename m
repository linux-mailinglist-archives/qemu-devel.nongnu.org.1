Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CE8AC09C9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 12:31:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3BS-000316-Op; Thu, 22 May 2025 06:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3BP-00030P-B1
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3BN-0006NX-KR
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1ru16hW7DCDOwAs0v+4rHKqGbQmXQDtD3+sjoRZxn4=;
 b=jS9QQ5d4J6PtOKlQfZgYrIss6IojsJNxGzgTOHFo7ZdTHpvk9l4aEsmuADksrLOjAFIib6
 g97RRjKV1reTOw7Qr4ihP4dJjRF6b/kH5JrXXAFILCv6PiWC0ghWJGt7rEDlbfxuwhkybx
 L/Py7Rtnr9kQPpGNy1euY4tBRFgamfY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-pWa7CPkuOmelubZhzTze_w-1; Thu,
 22 May 2025 06:29:42 -0400
X-MC-Unique: pWa7CPkuOmelubZhzTze_w-1
X-Mimecast-MFC-AGG-ID: pWa7CPkuOmelubZhzTze_w_1747909782
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0F831800570; Thu, 22 May 2025 10:29:41 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F4661958014; Thu, 22 May 2025 10:29:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/23] tests: skip encrypted secret tests if AES is not
 available
Date: Thu, 22 May 2025 11:29:04 +0100
Message-ID: <20250522102923.309452-5-berrange@redhat.com>
In-Reply-To: <20250522102923.309452-1-berrange@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This avoids test breakage when we drop support for using the
built-in AES impl as a fallback for missing crypto libraries.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-secret.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tests/unit/test-crypto-secret.c b/tests/unit/test-crypto-secret.c
index ffd13ff70e..fc32a01747 100644
--- a/tests/unit/test-crypto-secret.c
+++ b/tests/unit/test-crypto-secret.c
@@ -22,6 +22,7 @@
 
 #include "crypto/init.h"
 #include "crypto/secret.h"
+#include "crypto/cipher.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #if defined(CONFIG_KEYUTILS) && defined(CONFIG_SECRET_KEYRING)
@@ -597,18 +598,21 @@ int main(int argc, char **argv)
     g_test_add_func("/crypto/secret/conv/utf8/base64",
                     test_secret_conv_utf8_base64);
 
-    g_test_add_func("/crypto/secret/crypt/raw",
-                    test_secret_crypt_raw);
-    g_test_add_func("/crypto/secret/crypt/base64",
-                    test_secret_crypt_base64);
-    g_test_add_func("/crypto/secret/crypt/shortkey",
-                    test_secret_crypt_short_key);
-    g_test_add_func("/crypto/secret/crypt/shortiv",
-                    test_secret_crypt_short_iv);
-    g_test_add_func("/crypto/secret/crypt/missingiv",
-                    test_secret_crypt_missing_iv);
-    g_test_add_func("/crypto/secret/crypt/badiv",
-                    test_secret_crypt_bad_iv);
+    if (qcrypto_cipher_supports(QCRYPTO_CIPHER_ALGO_AES_128,
+                                QCRYPTO_CIPHER_MODE_CBC)) {
+        g_test_add_func("/crypto/secret/crypt/raw",
+                        test_secret_crypt_raw);
+        g_test_add_func("/crypto/secret/crypt/base64",
+                        test_secret_crypt_base64);
+        g_test_add_func("/crypto/secret/crypt/shortkey",
+                        test_secret_crypt_short_key);
+        g_test_add_func("/crypto/secret/crypt/shortiv",
+                        test_secret_crypt_short_iv);
+        g_test_add_func("/crypto/secret/crypt/missingiv",
+                        test_secret_crypt_missing_iv);
+        g_test_add_func("/crypto/secret/crypt/badiv",
+                        test_secret_crypt_bad_iv);
+    }
 
     return g_test_run();
 }
-- 
2.49.0


