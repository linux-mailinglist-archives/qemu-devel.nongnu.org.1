Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF1181DE41
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:31:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdX7-00055B-2V; Mon, 25 Dec 2023 00:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdX4-00054i-NA
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:42 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdX3-0007IH-4f
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:42 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ba52d0f9feso2842108b6e.0
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703482059; x=1704086859;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPxH7gFNnh+/q7MXVJgutLRfldlr/zL58xbkQj7lR5Y=;
 b=dLkDzq0+oSiHASpX5dA6Rp/4Oiq204SyDXf1mYDURNUJc1j743oY+G+DfoloI2TEPf
 +VfgJVfr41Sr/3QU8yTDpHcI7YQv2rrAfSx5Hz9nfRgIsoVy/NIKTpSyR6GWRDPrhxy6
 FTbvBM4JKbdFRy4QOoiNz+EOWzr4qGxf1gQYq2rqHspSEZOXrxlA8YjYez/kHzXOV/9l
 uF7EuydwhBN8pGIReXoe7QlBJpGnI534no7M+dD7uN3eP0nZnYr1Po84Ok0Vd+tR1V8Y
 Nlr8RTPxR83BHInZXtv+idddg5dwYb37Ks60qQsIBorKm56BSs3hnajXG6wBkp7UsUTm
 L/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703482059; x=1704086859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPxH7gFNnh+/q7MXVJgutLRfldlr/zL58xbkQj7lR5Y=;
 b=ZvzBXkQeeZdtPP2/HmAsiXO7J7d7iT9PDknE7POMpRpBheCkmtdHAhmarvT0nPOHBj
 I1yPEzQ4lmcHqZvRyx439RYJYbzMCbr716c9IRyWVqEHNnCcXmU2zb0D4tb0PphI+M7U
 9V1+gtpLZVGhEMB7uBzzGqpwttE+NuuXF5NKdNnXFjgQ+3X7lVcVHD9i5UvUBg/pe9sq
 XfrsFuJ3KVu5Jp+Y76Tw9vBTfjq1bUmEYdhaJKex36lW73ySbAjeoTyB/x+R+OhLUnAG
 5qEraU1Dmd/qS+KUEWVgYXqwopOeap0dxofpGj0F6PCjAfQ/OEtAqR1SqPF2yBTfd6jU
 G7MA==
X-Gm-Message-State: AOJu0Yx7kRIGneTRJXh7usCSy79csozdv3fbJ/vhH+ZyvnguucGcQcSl
 L1KSHG26BZzwmCc8EU6MvXBJpErnnnOHz67igQmgxEzSA1jz7w==
X-Google-Smtp-Source: AGHT+IH2tVs/BodH9ExVJOR5ky6B7cY2SPbouZZJKVuyfTBdAXOjtN2lphVWgs2v2S+SVIq6wq0unA==
X-Received: by 2002:a05:6808:1395:b0:3ba:f4a:4310 with SMTP id
 c21-20020a056808139500b003ba0f4a4310mr5992389oiw.11.1703482059064; 
 Sun, 24 Dec 2023 21:27:39 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa79d87000000b006d991505b4csm4555800pfq.76.2023.12.24.21.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:27:38 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 05/10] crypto: Mark the payload_offset_sector invalid for
 detached LUKS header
Date: Mon, 25 Dec 2023 13:26:55 +0800
Message-Id: <02d08ca67a4ec88cee61446d6b330c2945b5588f.1703481380.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703481378.git.yong.huang@smartx.com>
References: <cover.1703481378.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22e.google.com
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

Set the payload_offset_sector to a value that is nearly never reached
in order to mark it as invalid and indicate that 0 should be the offset
of the read/write operation on the 'file' protocol blockdev node.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 crypto/block-luks.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index fb01ec38bb..48443ffcae 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -34,6 +34,8 @@
 
 #include "qemu/bitmap.h"
 
+#define INVALID_SECTOR_OFFSET UINT32_MAX
+
 /*
  * Reference for the LUKS format implemented here is
  *
@@ -136,6 +138,13 @@ struct QCryptoBlockLUKS {
 };
 
 
+static inline uint32_t
+qcrypto_block_luks_payload_offset(uint32_t sector)
+{
+    return sector == INVALID_SECTOR_OFFSET ? 0 :
+        sector * QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
+}
+
 static int qcrypto_block_luks_cipher_name_lookup(const char *name,
                                                  QCryptoCipherMode mode,
                                                  uint32_t key_bytes,
@@ -1255,8 +1264,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     }
 
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
-    block->payload_offset = luks->header.payload_offset_sector *
-        block->sector_size;
+    block->payload_offset =
+        qcrypto_block_luks_payload_offset(luks->header.payload_offset_sector);
 
     return 0;
 
@@ -1529,16 +1538,28 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         slot->stripes = QCRYPTO_BLOCK_LUKS_STRIPES;
     }
 
-    /* The total size of the LUKS headers is the partition header + key
-     * slot headers, rounded up to the nearest sector, combined with
-     * the size of each master key material region, also rounded up
-     * to the nearest sector */
-    luks->header.payload_offset_sector = header_sectors +
-            QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
+    if (block->detached_header) {
+        /*
+         * Set the payload_offset_sector to a value that is nearly never
+         * reached in order to mark it as invalid and indicate that 0 should
+         * be the offset of the read/write operation on the 'file' protocol
+         * blockdev node. Here the UINT32_MAX is choosed
+         */
+        luks->header.payload_offset_sector = INVALID_SECTOR_OFFSET;
+    } else {
+        /*
+         * The total size of the LUKS headers is the partition header + key
+         * slot headers, rounded up to the nearest sector, combined with
+         * the size of each master key material region, also rounded up
+         * to the nearest sector
+         */
+        luks->header.payload_offset_sector = header_sectors +
+                QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS * split_key_sectors;
+    }
 
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
-    block->payload_offset = luks->header.payload_offset_sector *
-        block->sector_size;
+    block->payload_offset =
+        qcrypto_block_luks_payload_offset(luks->header.payload_offset_sector);
 
     /* Reserve header space to match payload offset */
     initfunc(block, block->payload_offset, opaque, &local_err);
-- 
2.39.1


