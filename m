Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3781DE60
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:49:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdoZ-0004jw-Em; Mon, 25 Dec 2023 00:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoX-0004jL-Hw
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:45 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoW-00025p-1v
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:45 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d099d316a8so3432203b3a.0
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703483142; x=1704087942;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPxH7gFNnh+/q7MXVJgutLRfldlr/zL58xbkQj7lR5Y=;
 b=FLESyh+3qQSeaa6L/ZXztT+iDFEtprc8HcKwyw8JGIAN5dkqTnvGwQZvaS++p6p3Xi
 LCFcHiH7BEiwcoTpfW3BFYotDbaeq0Pqt6zvqumdnCAZCEht1A1Yp+vtgCemmPZgwyLH
 XJKNkwp2VSuU3Qd5v++/gbHPwCHZ7GAnilEMeTPYOVNkfbKy6DM8kT2d8xPC0820lLKl
 uKDIT4oR5jmkHA+1YWjWnD1TSM9SzBVzUlyDVjX9YqmAMePSEc7ehbEJEYro81g3s0aQ
 iv6d4LY7dEOeFDmUu/RJslRCJIBqV9dI4cMzO1+VBb858Ys23atJgNW6RhkQO2V47f9n
 tPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703483142; x=1704087942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPxH7gFNnh+/q7MXVJgutLRfldlr/zL58xbkQj7lR5Y=;
 b=nJiE84MvhMAzI2yLoddp00l+57/b/puNnn4n0sNE+S3XSU1WsllCo3O/v6rNtNsIkA
 QKwtU6QZaeuttEFy74R4uD02dEhYz526l8etgwlzkvvGuYATFWr9bAoOtPqFS4RjXVTN
 3W/HNqIKHsifoxxdcZ4x5X7LNgx2t5GKm2iLXEzEsD+eA+NLk01JzXOwxCZhps2ccZdr
 mHnG1T1NCTBFxQ9U/Ouhao0uKtyxQaZakfXn0ktAyEiZcTqkpYid9e8ZicKBkMmC7shn
 3H4zcEf+dnIhrcGoyIL7CSZ41OxTAo3Q5JfejMFcBPvhb6bZck2deetS0vs858qadQM+
 gRRQ==
X-Gm-Message-State: AOJu0YxZZ1daNBNrGUKed6GEdGvo8GokZWrfgOuMlnhe1+em+Eh+44sK
 fv/wGcPfWo3M+S9TLNMU+wh8juBbiES/YDcM6DM3JGsUzDOijg==
X-Google-Smtp-Source: AGHT+IFdvD2jk9uSWxK/xaJVOqlgKswFU+mHLmgBZLZnMUueowRIod2KPjq1PSD2Xl2qgkFzq87qjA==
X-Received: by 2002:a05:6a00:2147:b0:6d9:9447:5f2d with SMTP id
 o7-20020a056a00214700b006d994475f2dmr4299503pfk.33.1703483141957; 
 Sun, 24 Dec 2023 21:45:41 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a056a00191600b006cef521b151sm7342415pfi.168.2023.12.24.21.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:45:41 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH RESEND v3 05/10] crypto: Mark the payload_offset_sector
 invalid for detached LUKS header
Date: Mon, 25 Dec 2023 13:45:07 +0800
Message-Id: <02d08ca67a4ec88cee61446d6b330c2945b5588f.1703482349.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703482349.git.yong.huang@smartx.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42d.google.com
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


