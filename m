Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA907B2E90
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Do-0005Jb-AZ; Fri, 29 Sep 2023 04:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Dc-0005C8-S3
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DC-0005cN-U2
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyEEDeIM4t46x5VE8Yy+9CWu9nyYvBCMyGW0Sl7OzfA=;
 b=NkL4Gb+HNf48faffJgbpJo2MboXWLCLcLZCqpdJ11yx2pUf7sJgrmLhMJxnkIfYykquikZ
 i4kNpS0GpWEadjHiOT6X0hzh0AO9qj6CqY/etrHZgOBzn46YwvWpawGN7Bksj03HQ35OFD
 fIeGqADm5QPHTY6BK1+MieBxxsMR4Hc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-a41chQclPAaxLWACUwuhyw-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: a41chQclPAaxLWACUwuhyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4B8F185A78E;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81D362026D68;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C3E121E6885; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 21/56] crypto/cipher-gnutls.c: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:18 +0200
Message-ID: <20230929085053.2789105-22-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  In file included from crypto/cipher.c:140:
  crypto/cipher-gnutls.c.inc: In function ‘qcrypto_gnutls_cipher_encrypt’:
  crypto/cipher-gnutls.c.inc:116:17: warning: declaration of ‘err’ shadows a previous local [-Wshadow=compatible-local]
    116 |             int err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
        |                 ^~~
  crypto/cipher-gnutls.c.inc:94:9: note: shadowed declaration is here
     94 |     int err;
        |         ^~~
       ---

  crypto/cipher-gnutls.c.inc: In function ‘qcrypto_gnutls_cipher_decrypt’:
  crypto/cipher-gnutls.c.inc:177:17: warning: declaration of ‘err’ shadows a previous local [-Wshadow=compatible-local]
    177 |             int err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
        |                 ^~~
  crypto/cipher-gnutls.c.inc:154:9: note: shadowed declaration is here
    154 |     int err;
        |         ^~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-17-philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 crypto/cipher-gnutls.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/cipher-gnutls.c.inc b/crypto/cipher-gnutls.c.inc
index 501e4e07a5..d3e231c13c 100644
--- a/crypto/cipher-gnutls.c.inc
+++ b/crypto/cipher-gnutls.c.inc
@@ -113,7 +113,7 @@ qcrypto_gnutls_cipher_encrypt(QCryptoCipher *cipher,
         while (len) {
             gnutls_cipher_hd_t handle;
             gnutls_datum_t gkey = { (unsigned char *)ctx->key, ctx->nkey };
-            int err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
+            err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
             if (err != 0) {
                 error_setg(errp, "Cannot initialize cipher: %s",
                            gnutls_strerror(err));
@@ -174,7 +174,7 @@ qcrypto_gnutls_cipher_decrypt(QCryptoCipher *cipher,
         while (len) {
             gnutls_cipher_hd_t handle;
             gnutls_datum_t gkey = { (unsigned char *)ctx->key, ctx->nkey };
-            int err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
+            err = gnutls_cipher_init(&handle, ctx->galg, &gkey, NULL);
             if (err != 0) {
                 error_setg(errp, "Cannot initialize cipher: %s",
                            gnutls_strerror(err));
-- 
2.41.0


