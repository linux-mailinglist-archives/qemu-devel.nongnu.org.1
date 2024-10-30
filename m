Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD29B5FC3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Oct 2024 11:13:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t65gU-0004Fj-Fz; Wed, 30 Oct 2024 06:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t65gP-0004Ex-NG
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t65gM-0004C6-Cc
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730283125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5TCNaEd+j7wAtXxqyMyUlUmafiCl4lFp6wdNk9FZx4=;
 b=SScBAe4aIsKWJ7GaVfqtkgB+ZOpceJj337qvSjYIMi6Kukm/RoE+RGPgXGXr1B2XMGRZ1/
 8CYx+haGSeW7gILK5rQVF2R9/N7znQG1/kofWTLxaiPhHgM+Y6wKeMLFEnOGktV9dIx9Um
 wRq/AtC2JHWEVQAl0tcFC/hVMFHovNI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-O-mQItuIMaiRM1sfUcs5sg-1; Wed,
 30 Oct 2024 06:12:01 -0400
X-MC-Unique: O-mQItuIMaiRM1sfUcs5sg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB2C919560A3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 10:11:59 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7911119560A2; Wed, 30 Oct 2024 10:11:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] crypto: fix error check on gcry_md_open
Date: Wed, 30 Oct 2024 10:11:49 +0000
Message-ID: <20241030101150.3023300-2-berrange@redhat.com>
In-Reply-To: <20241030101150.3023300-1-berrange@redhat.com>
References: <20241030101150.3023300-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

Gcrypt does not return negative values on error, it returns non-zero
values. This caused QEMU not to detect failure to open an unsupported
hash, resulting in a later crash trying to use a NULL context.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-gcrypt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 73533a4949..22ddf394ec 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -49,7 +49,7 @@ static
 QCryptoHash *qcrypto_gcrypt_hash_new(QCryptoHashAlgo alg, Error **errp)
 {
     QCryptoHash *hash;
-    int ret;
+    gcry_error_t ret;
 
     hash = g_new(QCryptoHash, 1);
     hash->alg = alg;
@@ -57,7 +57,7 @@ QCryptoHash *qcrypto_gcrypt_hash_new(QCryptoHashAlgo alg, Error **errp)
 
     ret = gcry_md_open((gcry_md_hd_t *) hash->opaque,
                        qcrypto_hash_alg_map[alg], 0);
-    if (ret < 0) {
+    if (ret != 0) {
         error_setg(errp,
                    "Unable to initialize hash algorithm: %s",
                    gcry_strerror(ret));
-- 
2.46.0


