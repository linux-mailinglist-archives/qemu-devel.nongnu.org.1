Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A07E48FB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:09:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RR8-0004WE-F8; Tue, 07 Nov 2023 14:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0RR4-0004Vq-4L
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0RR2-0005oh-IG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699384103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/CluFChsbBL3IuPKXEGp9v93+bN93D23x2uQhxilqA=;
 b=cvPyINxnIvSrKLQ7celc3HAQwX6sFMEbxkgXM26Mc3H/Vjw+PPDt54kX31gYb5eWjq4QWc
 vs/VV9HEjq1ATHfTmCL4gjIwOM6t5yrZ2bKkT61ZZxBPafoqX5KGJUrmvsz1O6k8mTSP7l
 tAtpOYUHmNVHl68lEcwYIv3F9dod0hs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-pTCbF33cP-6s5e-gBPWbiw-1; Tue, 07 Nov 2023 14:08:20 -0500
X-MC-Unique: pTCbF33cP-6s5e-gBPWbiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3626185A781
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 19:08:19 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0C6D25C0;
 Tue,  7 Nov 2023 19:08:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 1/5] crypto/rsakey-builtin.c.inc: Clean up two error paths
Date: Tue,  7 Nov 2023 19:08:13 +0000
Message-ID: <20231107190817.1607710-2-berrange@redhat.com>
In-Reply-To: <20231107190817.1607710-1-berrange@redhat.com>
References: <20231107190817.1607710-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

When qcrypto_builtin_rsa_public_key_parse() is about to fail, but no
error has been set, it makes one up.  Actually, there's just one way
to fail without setting an error.  Set it there instead.

Same for qcrypto_builtin_rsa_private_key_parse().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/rsakey-builtin.c.inc | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/crypto/rsakey-builtin.c.inc b/crypto/rsakey-builtin.c.inc
index aeeacc8f9b..46cc7afe87 100644
--- a/crypto/rsakey-builtin.c.inc
+++ b/crypto/rsakey-builtin.c.inc
@@ -88,15 +88,13 @@ static QCryptoAkCipherRSAKey *qcrypto_builtin_rsa_public_key_parse(
         goto error;
     }
     if (seq_length != 0) {
+        error_setg(errp, "Invalid RSA public key");
         goto error;
     }
 
     return rsa;
 
 error:
-    if (errp && !*errp) {
-        error_setg(errp, "Invalid RSA public key");
-    }
     qcrypto_akcipher_rsakey_free(rsa);
     return NULL;
 }
@@ -169,15 +167,13 @@ static QCryptoAkCipherRSAKey *qcrypto_builtin_rsa_private_key_parse(
         return rsa;
     }
     if (seq_length != 0) {
+        error_setg(errp, "Invalid RSA private key");
         goto error;
     }
 
     return rsa;
 
 error:
-    if (errp && !*errp) {
-        error_setg(errp, "Invalid RSA private key");
-    }
     qcrypto_akcipher_rsakey_free(rsa);
     return NULL;
 }
-- 
2.41.0


