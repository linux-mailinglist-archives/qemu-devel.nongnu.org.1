Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A44FF81DE3E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:30:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdXJ-00056c-N9; Mon, 25 Dec 2023 00:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdXH-00056O-HI
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:55 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdXF-0007Kj-LB
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:54 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-28c075ad8e7so1974738a91.2
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703482072; x=1704086872;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V41DNB1pjZ9O5cZD/tszsVFWwnvqdC0t0assc5W46WI=;
 b=USWchmyVYlvVGG4SMKTjuZmgT/AXGROI8eZ6WtWNx3iL3PB3gIAwFQqo4s6H9EsLhU
 PXTosMi9t301odffVJbS0N9GOXk1DOiRp7qCxYR0BJOUQaVy/WLNgDx+9V3DrP280euh
 5+DWB3TxAevnsrjNoGFYghmS/QGYqJK0ZWqNAR/sWmxusPM+2wkK2m5a1lodbnRE23CT
 nX22anJ0+jO2+Ks9WQk9yG5CT8l15RTNUDnOZZ8njfaP2QtIyZkIsWFO2tAHQsDyjMpm
 WBDL4WowiNBfjkmdgNlchl+4SUUYoS4cjBC7Ig/1FCGH3h4M5HOunPBVY2+mVbIkCVl8
 0h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703482072; x=1704086872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V41DNB1pjZ9O5cZD/tszsVFWwnvqdC0t0assc5W46WI=;
 b=cwsPVRo8lTsZZj/QAu0tIuSCFMIf26Hs1trIMxjMUCLhEckGzKkRj+PNVajEoOzR3M
 dFASUBUuEdW1we+0BYnWYRVdZe1ID9k3VQnCMSMTjm+2fhEfLpUrHgszuGpriw5rjeUO
 w6fChNw9Rwdhv+kFl7mo8575EiDHdPKyRcIzSKqU7s1Oc79RY08tyPBEmTZvhAsVlJOK
 vbuLRbjznIhTKfJs3XLLQa7xp32LcIM0PZ9v1gcnSj93K6HtgZ//+rIowvnROylhN9zr
 z4tM9C7IUjE10c891SMTnlEBGTxTVJeGelJClgz3hb1ySvTmnAlAdCh9H6W5RCUeoJtY
 Hwww==
X-Gm-Message-State: AOJu0YyQuMgzMCKV72FCTIoD8L/KVrN/5TlLWX4+OGD8Tudzu/WfrNnP
 bFEqkZI9eKC07xSK6/TTabzBV+wRBJxS++sETgvz9y8kQuKdgg==
X-Google-Smtp-Source: AGHT+IERiULVmCpklvA/U7zcUjZBziGoQXLEjY2XXwB5PTb7k47EsJ/AeKSGZjEB53Ny4k3MugNxag==
X-Received: by 2002:a05:6a20:9185:b0:195:a3d1:bf6 with SMTP id
 v5-20020a056a20918500b00195a3d10bf6mr1584685pzd.101.1703482071729; 
 Sun, 24 Dec 2023 21:27:51 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa79d87000000b006d991505b4csm4555800pfq.76.2023.12.24.21.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:27:51 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 08/10] crypto: Introduce 'detached-header' field in
 QCryptoBlockInfoLUKS
Date: Mon, 25 Dec 2023 13:26:58 +0800
Message-Id: <0866d2a1e7011831570a377e02cddb5db4b7d855.1703481380.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703481378.git.yong.huang@smartx.com>
References: <cover.1703481378.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102a.google.com
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

When querying the LUKS disk with the qemu-img tool or other APIs,
add information about whether the LUKS header is detached.

Additionally, update the test case with the appropriate
modification.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 crypto/block-luks.c        | 2 ++
 qapi/crypto.json           | 3 +++
 tests/qemu-iotests/210.out | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 474c7aee2e..c5e53b4ee4 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1266,6 +1266,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
     block->payload_offset =
         qcrypto_block_luks_payload_offset(luks->header.payload_offset_sector);
+    block->detached_header = (block->payload_offset == 0) ? true : false;
 
     return 0;
 
@@ -1892,6 +1893,7 @@ static int qcrypto_block_luks_get_info(QCryptoBlock *block,
     info->u.luks.master_key_iters = luks->header.master_key_iterations;
     info->u.luks.uuid = g_strndup((const char *)luks->header.uuid,
                                   sizeof(luks->header.uuid));
+    info->u.luks.detached_header = block->detached_header;
 
     for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
         slot = g_new0(QCryptoBlockInfoLUKSSlot, 1);
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 8e81aa8454..336c880b5d 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -317,6 +317,8 @@
 #
 # @hash-alg: the master key hash algorithm
 #
+# @detached-header: whether the LUKS header is detached (Since 9.0)
+#
 # @payload-offset: offset to the payload data in bytes
 #
 # @master-key-iters: number of PBKDF2 iterations for key material
@@ -333,6 +335,7 @@
            'ivgen-alg': 'QCryptoIVGenAlgorithm',
            '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
            'hash-alg': 'QCryptoHashAlgorithm',
+           'detached-header': 'bool',
            'payload-offset': 'int',
            'master-key-iters': 'int',
            'uuid': 'str',
diff --git a/tests/qemu-iotests/210.out b/tests/qemu-iotests/210.out
index 96d9f749dd..94b29b2120 100644
--- a/tests/qemu-iotests/210.out
+++ b/tests/qemu-iotests/210.out
@@ -18,6 +18,7 @@ virtual size: 128 MiB (134217728 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha256
     cipher alg: aes-256
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
@@ -70,6 +71,7 @@ virtual size: 64 MiB (67108864 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha1
     cipher alg: aes-128
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
@@ -125,6 +127,7 @@ virtual size: 0 B (0 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha256
     cipher alg: aes-256
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
@@ -195,6 +198,7 @@ virtual size: 0 B (0 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha256
     cipher alg: aes-256
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
-- 
2.39.1


