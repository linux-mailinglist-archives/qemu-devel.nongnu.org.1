Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC23F70BC28
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1413-0003xD-2y; Mon, 22 May 2023 07:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q140x-0003wj-V2
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:47:48 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q140w-00073O-8F
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:47:47 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-52c30fbccd4so5299380a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 04:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684756064; x=1687348064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M4Dl1h0jo+m8UUuvwugjWjif9pBMRWgnAljl+9/hZvY=;
 b=dlkYW4VKHDiU41nqFFs9piZtbhj9vvJk+G+Tf4c0gNQz/OnwUdNxSkemGfoKFC2o/q
 ijtVLeUAk0BRmKOzXkxGoUyn8sVx6eknQeYKHyXpRDhTHpKVm93M0OgbQqsO1dZIFSCq
 1NiyNWvPc5y575W2XY7gdHJa7IAH8TqslAdPvV3NVUF53ct7PCUhFb0ial/lxxBHFvEm
 GuZUPgD6jqTEoQiojPmzrcVTgw+qCPXawveILV2kSdOWDj00WTBnBA2QOgTYbr87RiNq
 8bqTZgoXG2ZUL9LbA9sVBdGRXEESaaPdqaHwhry4zr0PBtTULYKAI1fQ9cIyQs5xEPwL
 uL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684756064; x=1687348064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M4Dl1h0jo+m8UUuvwugjWjif9pBMRWgnAljl+9/hZvY=;
 b=Q5ABcFKQUkl2BOuJzhP2Rh7mHW8nt3W6unTZ/X6tRkTFBwR0+LTk/8I+LX9/l6bCzO
 ToxLPhRi1B9Zg/MuZpXdyxHVlISMpSVlH9qbbu4bTPqyXDGJeTSWyKjmNTWrflcuWUED
 WZZLMCnZKVxbJqXIF6A7ZGGXaIf0cFcu2LHmXzSsYPENjTcKcudFPZOksGrx9Euph+Q3
 czJJJHfhX7dHcoTvT8lwcBgGpU25fwrbr//03ndscTe1TRgKxjBUNKAlCcqP+Jy7LNJB
 U97r0YXTsUhPgZ2bRS+J6nX6M6wyLDNDiU6lJ2KvXsIp2TkDodVXirXa/wBORJZzqqNd
 toZA==
X-Gm-Message-State: AC+VfDyiWTqYGX4R2oAZdXA2EMAQgu0MsiicsHQ/JeAVvbCKmcDRQg7K
 eKvwYBqXVvPv/xvQv9XB5/1k6BriyhCmMq1amIY=
X-Google-Smtp-Source: ACHHUZ4XQjPSNIRiOkS/Um6PiwLqoOtNr/WufvsqobxN4H8HAkIF0SSNeZ4MtGd01tQgWBBibmZAVw==
X-Received: by 2002:a17:902:748c:b0:1a9:21bc:65f8 with SMTP id
 h12-20020a170902748c00b001a921bc65f8mr9783096pll.11.1684756064318; 
 Mon, 22 May 2023 04:47:44 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jb4-20020a170903258400b001ac4e316b51sm4710108plb.109.2023.05.22.04.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 04:47:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] crypto: Always initialize splitkeylen
Date: Mon, 22 May 2023 20:47:37 +0900
Message-Id: <20230522114737.32686-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
2.40.1


