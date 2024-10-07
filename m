Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C7B993731
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Oct 2024 21:22:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtEI-0004M2-MX; Mon, 07 Oct 2024 15:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtEB-00049T-1J; Mon, 07 Oct 2024 15:17:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtE9-00043f-Ka; Mon, 07 Oct 2024 15:17:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1D26E96240;
 Mon,  7 Oct 2024 22:16:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EBF4814F721;
 Mon,  7 Oct 2024 22:16:54 +0300 (MSK)
Received: (nullmailer pid 2592712 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 04/32] crypto: check gnutls & gcrypt support the
 requested pbkdf hash
Date: Mon,  7 Oct 2024 22:16:21 +0300
Message-Id: <20241007191654.2592616-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Both gnutls and gcrypt can be configured to exclude support for certain
algorithms via a runtime check against system crypto policies. Thus it
is not sufficient to have a compile time test for hash support in their
pbkdf implementations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit e6c09ea4f9e5f8af92a6453642b84b9efd52892f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c
index a8d8e64f4d..bc0719c831 100644
--- a/crypto/pbkdf-gcrypt.c
+++ b/crypto/pbkdf-gcrypt.c
@@ -33,7 +33,7 @@ bool qcrypto_pbkdf2_supports(QCryptoHashAlgorithm hash)
     case QCRYPTO_HASH_ALG_SHA384:
     case QCRYPTO_HASH_ALG_SHA512:
     case QCRYPTO_HASH_ALG_RIPEMD160:
-        return true;
+        return qcrypto_hash_supports(hash);
     default:
         return false;
     }
diff --git a/crypto/pbkdf-gnutls.c b/crypto/pbkdf-gnutls.c
index 2dfbbd382c..911b565bea 100644
--- a/crypto/pbkdf-gnutls.c
+++ b/crypto/pbkdf-gnutls.c
@@ -33,7 +33,7 @@ bool qcrypto_pbkdf2_supports(QCryptoHashAlgorithm hash)
     case QCRYPTO_HASH_ALG_SHA384:
     case QCRYPTO_HASH_ALG_SHA512:
     case QCRYPTO_HASH_ALG_RIPEMD160:
-        return true;
+        return qcrypto_hash_supports(hash);
     default:
         return false;
     }
-- 
2.39.5


