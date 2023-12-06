Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DB180756B
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:41:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAux8-0007DE-RB; Wed, 06 Dec 2023 11:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAuwb-00073Q-FN
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:40:18 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAuwW-0003oq-Db
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:40:15 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d04c097e34so137845ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701880691; x=1702485491;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhMhC1dRCAzfDuzYgcsG+53k26v66QjFrETHi98zfg4=;
 b=NK+BzmYla6ksZeyMBHdP4k25UTJOgsAIFaMJPg6yDYRQzz1AO3a6NAzUESX/KkyqUV
 Hz0Of38/KKtUsHMj39YKV5U7OhAgvg/4RGfykfn0YdmuSkDG+ocQsVkmScJoUenQ+gZX
 el+MLLl+VwGtXA1laH9BEnPIqjVv9pSicBbzti9fZNTjm8CxA08vVvBZ4IMTH+LeBQIR
 dwHXiFw8ZRnBjt9iZhwUxCZ4L2JPnK4XLDMAStCxKTTsaWEOaZEPiNoCNdxKYCRNgyQ9
 icBJPNkaqow+6K71RJyEi1iGxrmSOIerkWxftB5y5VR6VHjZHqnoxAxAigBtxbyzBuYQ
 /p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701880691; x=1702485491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhMhC1dRCAzfDuzYgcsG+53k26v66QjFrETHi98zfg4=;
 b=HUmOjOtyNL9favrfo/1wx3RE89yaDeZ2wp1XlVi8k9ccRhNqICaaL3xN6JRdoMeIkI
 1EZ1OKR++06SpoXty4hVKbw3aMwlCBiSvYiH/nn5aAqibRpZdUOHW/FgnSgR0bVAGeLa
 tM16lO/SBjYBmv1b4ld9OAlsrnalQmr1w/sJDAERKc/GYO7O6bFcXDD+TwXo6M4ouLw8
 HxGeqwQfoM0XY1aRyKIqQ1cHbpMq7PFejG6v+X6/HWPK/G0lD5mu94C0UEvjQQ5uQ5CA
 aG4lYzIygn2zVEi4wml86fe7TsUZDckeZaXqvMjFSVpgO5Sy7ly/SjJQf/mUTWsmMHsY
 rKXw==
X-Gm-Message-State: AOJu0Yz604vUhXM6gfqvxT/DZcwZtt938hKXAcvf5aSS8A/6smB3jKgB
 rsbhG06On7+v25cHMotAGC8OtQdigPwKufS9/OKN1bEn
X-Google-Smtp-Source: AGHT+IEXyGEuBvgs5pBKRgZaStL31ffR79X1CEOuNwkByP/zqRwAhbS7l/A9QjyOEjY5EdXcfjmN8A==
X-Received: by 2002:a17:902:ff01:b0:1cf:fc91:e4d0 with SMTP id
 f1-20020a170902ff0100b001cffc91e4d0mr4275488plj.16.1701880690497; 
 Wed, 06 Dec 2023 08:38:10 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a170902bb8e00b001d04d730687sm42570pls.103.2023.12.06.08.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 08:38:10 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [v2 4/4] block: Support detached LUKS header creation for
 blockdev-create
Date: Thu,  7 Dec 2023 00:37:45 +0800
Message-Id: <5ca4a43ea0795d9fb6ea3649eead10017df69b1c.1701879996.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701879996.git.yong.huang@smartx.com>
References: <cover.1701879996.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62b.google.com
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

Provide the "detached-mode" option for detached LUKS header
formatting.

To format the LUKS header on the pre-creating disk, example
as follows:

1. add a protocol blockdev node of LUKS header
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-1-storage", "driver":"file",
> "filename":"/path/to/cipher.gluks" }}'

2. add the secret for encrypting the cipher stored in LUKS
   header above
$ virsh qemu-monitor-command vm '{"execute":"object-add",
> "arguments":{"qom-type": "secret", "id":
> "libvirt-1-storage-secret0", "data": "abc123"}}'

3. format the disk node
$ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> "arguments":{"job-id":"job0", "options":{"driver":"luks",
> "size":0, "file":"libvirt-1-storage", "detached-mode":true,
> "cipher-alg":"aes-256",
> "key-secret":"libvirt-3-storage-encryption-secret0"}}}'

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block/crypto.c       | 8 +++++++-
 qapi/block-core.json | 5 ++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 7d70349463..e77c49bd0c 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -667,10 +667,12 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
     BlockDriverState *bs = NULL;
     QCryptoBlockCreateOptions create_opts;
     PreallocMode preallocation = PREALLOC_MODE_OFF;
+    int64_t size;
     int ret;
 
     assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
     luks_opts = &create_options->u.luks;
+    size = luks_opts->size;
 
     bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
     if (bs == NULL) {
@@ -686,7 +688,11 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
         preallocation = luks_opts->preallocation;
     }
 
-    ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
+    if (luks_opts->detached_mode) {
+        size = 0;
+    }
+
+    ret = block_crypto_co_create_generic(bs, size, &create_opts,
                                          preallocation, errp);
     if (ret < 0) {
         goto fail;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 10be08d08f..1e7a7e1b05 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4952,13 +4952,16 @@
 # @preallocation: Preallocation mode for the new image (since: 4.2)
 #     (default: off; allowed values: off, metadata, falloc, full)
 #
+# @detached-mode: create a detached LUKS header. (since 9.0)
+#
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
   'data': { 'file':             'BlockdevRef',
             'size':             'size',
-            '*preallocation':   'PreallocMode' } }
+            '*preallocation':   'PreallocMode',
+            '*detached-mode':   'bool'}}
 
 ##
 # @BlockdevCreateOptionsNfs:
-- 
2.39.1


