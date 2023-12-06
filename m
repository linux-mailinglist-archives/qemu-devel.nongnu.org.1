Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D0807563
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:41:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAux4-000740-7c; Wed, 06 Dec 2023 11:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAuwW-00070I-N8
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:40:14 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAuwS-0003oY-R1
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:40:12 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d0a7b72203so31270205ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701880687; x=1702485487;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2TeQm179WJYabh6QIsHuX0i02sIiWoRD0LrOlPmpos=;
 b=G+QNJgcAo/XLnLtuPFTgMzXb8kd8V+cYq6nv8dWOeG1oXB2LFGJcvI5EnkCnIxd64O
 rT7Gb9/q18qHXp8IjDi/GsID+FAyCsLyIGeQuTLeXGo072BMWK0rLMANdGGtcfPureNo
 TtG/lrztcUjBWf989oHV1yaYlHcNFpRshgAJpmCnQS8TcbCacRWnrwUJO+/hieg0MpFT
 D3i6nerjyW3cPOMnTmfPXhZn4pg8Zbu5yaAHHZa14BNAvhsEno/GhEheSrIlAHy5qnGi
 lL3F6zhLqFMr00Dw0Oz5eFFao0wrUFTP0X55qiD6bo2/F/eMdbuGZ7TjgDEJr2s4cMSc
 EexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701880687; x=1702485487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2TeQm179WJYabh6QIsHuX0i02sIiWoRD0LrOlPmpos=;
 b=GUcSlNJ/f5sBFzGxnvH2jEMbjbBoo02b9DnvAqJG/fQEdAcNa+2QENDp2+ZCn+48JF
 1/oNdIOVFr1ZiVKiUyh93j9DEnS42GK7BDYpDBz7ko6AUXR4I9anJMUQTQxrPob0aPVG
 Ak1odVgtxU/Ok/dq5cWh4bVZZqyzJHHoKgKLNSsY1Gzf8GhB5O2ofJ9KH9XhmszlTqym
 5Fvltlp0mVw9zz9b+mxEtcMcljO6OmAV8Hq+oXlFBNqM4ePJl7+4i2Y/uBJW0+qt2gI2
 Xe89PtOAcN876SxpsV71OBKBeuWgvPiTpqtC0kZvR2Mr2JF4Z7bfyUQmtCFHUguuZUUr
 KJjw==
X-Gm-Message-State: AOJu0Ywj+EmNryy3qYc3FPFBtw84mPIDkIghSlEEozU/W2Whd0lpdAax
 y73TVB3M6voP5S7BYOcY/PBR5XDWgN+f4TesPlpN5nL3
X-Google-Smtp-Source: AGHT+IHoEKtpi/q+qffwIGy4ZAt0Z7829OqDaOTFNctp5zoGm/roNr8yFDAFTpj+tmtwMAltuFcyDg==
X-Received: by 2002:a17:903:32d0:b0:1c9:cc88:502c with SMTP id
 i16-20020a17090332d000b001c9cc88502cmr1381760plr.69.1701880686716; 
 Wed, 06 Dec 2023 08:38:06 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a170902bb8e00b001d04d730687sm42570pls.103.2023.12.06.08.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 08:38:06 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [v2 3/4] crypto: Support generic LUKS encryption
Date: Thu,  7 Dec 2023 00:37:44 +0800
Message-Id: <910801f303da1601051479d3b7e5c2c6b4e01eb7.1701879996.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701879996.git.yong.huang@smartx.com>
References: <cover.1701879996.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x630.google.com
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

By enhancing the LUKS driver, it is possible to enable
the detachable LUKS header and, as a result, achieve
general encryption for any disk format that QEMU has
supported.

Take the qcow2 as an example, the usage of the generic
LUKS encryption as follows:

1. add a protocol blockdev node of data disk
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-1-storage", "driver":"file",
> "filename":"/path/to/test_disk.qcow2"}}'

2. add a protocol blockdev node of LUKS header as above.
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-2-storage", "driver":"file",
> "filename": "/path/to/cipher.gluks" }}'

3. add the secret for decrypting the cipher stored in LUKS
   header above
$ virsh qemu-monitor-command vm '{"execute":"object-add",
> "arguments":{"qom-type":"secret", "id":
> "libvirt-2-storage-secret0", "data":"abc123"}}'

4. add the qcow2-drived blockdev format node
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-1-format", "driver":"qcow2",
> "file":"libvirt-1-storage"}}'

5. add the luks-drived blockdev to link the qcow2 disk with
   LUKS header by specifying the field "header"
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-2-format", "driver":"luks",
> "file":"libvirt-1-format", "header":"libvirt-2-storage",
> "key-secret":"libvirt-2-format-secret0"}}'

6. add the virtio-blk device finally
$ virsh qemu-monitor-command vm '{"execute":"device_add",
> "arguments": {"num-queues":"1", "driver":"virtio-blk-pci",
> "drive": "libvirt-2-format", "id":"virtio-disk2"}}'

The generic LUKS encryption method of starting a virtual
machine (VM) is somewhat similar to hot-plug in that both
maintaining the same json command while the starting VM
changes the "blockdev-add/device_add" parameters to
"blockdev/device".

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block/crypto.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index f82b13d32b..7d70349463 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -40,6 +40,7 @@ struct BlockCrypto {
     QCryptoBlock *block;
     bool updating_keys;
     BdrvChild *header;  /* Reference to the detached LUKS header */
+    bool detached_mode; /* If true, LUKS plays a detached header role */
 };
 
 
@@ -64,12 +65,16 @@ static int block_crypto_read_func(QCryptoBlock *block,
                                   Error **errp)
 {
     BlockDriverState *bs = opaque;
+    BlockCrypto *crypto = bs->opaque;
     ssize_t ret;
 
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    ret = bdrv_pread(bs->file, offset, buflen, buf, 0);
+    if (crypto->detached_mode)
+        ret = bdrv_pread(crypto->header, offset, buflen, buf, 0);
+    else
+        ret = bdrv_pread(bs->file, offset, buflen, buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read encryption header");
         return ret;
@@ -269,6 +274,8 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     QCryptoBlockOpenOptions *open_opts = NULL;
     unsigned int cflags = 0;
     QDict *cryptoopts = NULL;
+    const char *header_bdref =
+        qdict_get_try_str(options, "header");
 
     GLOBAL_STATE_CODE();
 
@@ -277,6 +284,16 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
         return ret;
     }
 
+    if (header_bdref) {
+        crypto->detached_mode = true;
+        crypto->header = bdrv_open_child(NULL, options, "header", bs,
+                                         &child_of_bds, BDRV_CHILD_METADATA,
+                                         false, errp);
+        if (!crypto->header) {
+            return -EINVAL;
+        }
+    }
+
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     bs->supported_write_flags = BDRV_REQ_FUA &
@@ -312,6 +329,14 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
         goto cleanup;
     }
 
+    if (crypto->detached_mode) {
+        /*
+         * Set payload offset to zero as the file bdref has no LUKS
+         * header under detached mode.
+         */
+        qcrypto_block_set_payload_offset(crypto->block, 0);
+    }
+
     bs->encrypted = true;
 
     ret = 0;
@@ -903,6 +928,17 @@ block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
 
     BlockCrypto *crypto = bs->opaque;
 
+    if (role == (role & BDRV_CHILD_METADATA)) {
+        /* Assign read permission only */
+        perm |= BLK_PERM_CONSISTENT_READ;
+        /* Share all permissions */
+        shared |= BLK_PERM_ALL;
+
+        *nperm = perm;
+        *nshared = shared;
+        return;
+    }
+
     bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
 
     /*
-- 
2.39.1


