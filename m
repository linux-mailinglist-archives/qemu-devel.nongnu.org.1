Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B3997B3E7
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Sep 2024 20:10:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqcdN-0004MU-MH; Tue, 17 Sep 2024 14:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqcdJ-0004BM-LC; Tue, 17 Sep 2024 14:09:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqcdH-0002NW-RM; Tue, 17 Sep 2024 14:09:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6F7778FBC4;
 Tue, 17 Sep 2024 21:08:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F32E413E746;
 Tue, 17 Sep 2024 21:08:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 44/47] crypto: check gnutls & gcrypt support the
 requested pbkdf hash
Date: Tue, 17 Sep 2024 21:08:33 +0300
Message-Id: <20240917180836.633380-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.14-20240917210634@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240917210634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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


