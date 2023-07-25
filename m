Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC3761E6A
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:24:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOKp1-0003PH-6k; Tue, 25 Jul 2023 12:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOKov-0003On-6X
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOKot-0003nf-Ma
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690302210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3BYkvu3CmlSAsiJPiY7vF77Ls3eEu0PFo6xuXl4dhE=;
 b=K95flJRlAHMflPkHOBTUEka0lAlF97cGIj1jJ0bI4xdfSzvYXb8IJ1NIxNiePiwdKDR3qZ
 L3igKh83X5sNqeb45TH04JZZ1AS50Nsu7NhlAvZy7klfO906HKIpWE6fyMpracrQ7q3OrZ
 QLopmtCFGUn1A/p16gFq+r9E1CHZKG8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-TOa_g036O9GWVKNKhAoTBw-1; Tue, 25 Jul 2023 12:23:27 -0400
X-MC-Unique: TOa_g036O9GWVKNKhAoTBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5DF0800CAC;
 Tue, 25 Jul 2023 16:23:26 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F36DF145414A;
 Tue, 25 Jul 2023 16:23:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Canokeys.org" <contact@canokeys.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Hongren (Zenithal) Zheng" <i@zenithal.me>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 1/2] crypto: Always initialize splitkeylen
Date: Tue, 25 Jul 2023 17:23:01 +0100
Message-ID: <20230725162304.156157-2-berrange@redhat.com>
In-Reply-To: <20230725162304.156157-1-berrange@redhat.com>
References: <20230725162304.156157-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

When _FORTIFY_SOURCE=2, glibc version is 2.35, and GCC version is
12.1.0, the compiler complains as follows:

In file included from /usr/include/string.h:535,
                 from /home/alarm/q/var/qemu/include/qemu/osdep.h:99,
                 from ../crypto/block-luks.c:21:
In function 'memset',
    inlined from 'qcrypto_block_luks_store_key' at ../crypto/block-luks.c:843:9:
/usr/include/bits/string_fortified.h:59:10: error: 'splitkeylen' may be used uninitialized [-Werror=maybe-uninitialized]
   59 |   return __builtin___memset_chk (__dest, __ch, __len,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   60 |                                  __glibc_objsize0 (__dest));
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
../crypto/block-luks.c: In function 'qcrypto_block_luks_store_key':
../crypto/block-luks.c:699:12: note: 'splitkeylen' was declared here
  699 |     size_t splitkeylen;
      |            ^~~~~~~~~~~

It seems the compiler cannot see that splitkeylen will not be used
when splitkey is NULL. Suppress the warning by initializing splitkeylen
even when splitkey stays NULL.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/block-luks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 5688783ab1..2f59c3a625 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -706,14 +706,14 @@ qcrypto_block_luks_store_key(QCryptoBlock *block,
 
     assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
     slot = &luks->header.key_slots[slot_idx];
+    splitkeylen = luks->header.master_key_len * slot->stripes;
+
     if (qcrypto_random_bytes(slot->salt,
                              QCRYPTO_BLOCK_LUKS_SALT_LEN,
                              errp) < 0) {
         goto cleanup;
     }
 
-    splitkeylen = luks->header.master_key_len * slot->stripes;
-
     /*
      * Determine how many iterations are required to
      * hash the user password while consuming 1 second of compute
-- 
2.41.0


