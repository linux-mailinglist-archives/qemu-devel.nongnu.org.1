Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638A81DE58
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:49:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdoN-0004gS-Ea; Mon, 25 Dec 2023 00:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoL-0004g9-N1
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:33 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoK-000236-3l
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:33 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28bcc273833so3004580a91.1
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703483130; x=1704087930;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9e2pyacaPTFtXd3fyhslqs/g1BZY38PqvyuZ6SQ0GM=;
 b=zQ4oWMLG8BgBmGbLDtq8CkYIC7WHSnaIi5xtx9fq4yR2xCBxgu03irS80Ydx8OqPIA
 K7bjuUzUSPyZ+vfsXlpfmvqSc7rO7aUcwoLvSQ8r4qz5DhscvMFHXoqwlVCyJgEfsDKr
 PQyu4fT05dor90BR4wK+K83ZskhJqU+i0XZ7/mjCzjbz+vSQffKxwM+YpQeKkza8rt2q
 0Je4yEfehdj6s9N/vyYWv9c5m1zkXnJ+8ii8jhgcc+1CG/jSksv34X1TtcL/pEZy2p52
 suBJTXtOgOj576v2K3t60yMdmq9qGSvGXMg3UWj4bVk0H5POk/nxrhRaMs+gQBjfLwHf
 4vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703483130; x=1704087930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9e2pyacaPTFtXd3fyhslqs/g1BZY38PqvyuZ6SQ0GM=;
 b=awzsuiRnlp3F6r2Lgo0zJACHLPjfDBrYzZAHD/pCG2pm0aQMfgFVu7tKjnpjWbfLOP
 W1IrRH+90pQn7Aeq5ppaRPB5gHZVC/L6L0vMsc3LGlx2+STcKdeN4oE7cVM+v1II80Of
 Yvhrh+KIKCWuanZbkuZfVHFOpTlH9XBrCv6hmLJebf6YjvYZeOSz1L+w6TPK0Gog4VvS
 XIjDjA6vSx0lh/AwbGmDbmdW9aICZWbxEO2ee+oeNFBuewAbwGe2VJqdgQQFpTx7Dc8O
 86jRPRapVWqtiOIo7x5Y/RAPDRuonn/AZmImstCT1ko9jTID2RnxWzis6xvcPKZ/Oezd
 oLCw==
X-Gm-Message-State: AOJu0YznnXVGMng0oswdF3l+qgq9wPADlKZ90zHAUMSFIdUid+Y1H0Si
 9qXHbu7ZnPj2ud45PP8rwE10pPZfUfzwCozhqKjaRjo52DIvXg==
X-Google-Smtp-Source: AGHT+IFCvqg5d1Da4+WNqgWOTPB1N/c9DyrrqZIdTAbaBpLKQxDDS58vDAr4bFD9Zy8SwqMcF6saqA==
X-Received: by 2002:a05:6a20:29b:b0:190:38ef:3a57 with SMTP id
 27-20020a056a20029b00b0019038ef3a57mr5346508pza.28.1703483130073; 
 Sun, 24 Dec 2023 21:45:30 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a056a00191600b006cef521b151sm7342415pfi.168.2023.12.24.21.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:45:29 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH RESEND v3 02/10] crypto: Support generic LUKS encryption
Date: Mon, 25 Dec 2023 13:45:04 +0800
Message-Id: <c55f6e98595c654d17c16a569422bec5c03ddaa0.1703482349.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703482349.git.yong.huang@smartx.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1031.google.com
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
Message-Id: <910801f303da1601051479d3b7e5c2c6b4e01eb7.1701879996.git.yong.huang@smartx.com>
---
 block/crypto.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index f82b13d32b..6063879bac 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -64,12 +64,14 @@ static int block_crypto_read_func(QCryptoBlock *block,
                                   Error **errp)
 {
     BlockDriverState *bs = opaque;
+    BlockCrypto *crypto = bs->opaque;
     ssize_t ret;
 
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    ret = bdrv_pread(bs->file, offset, buflen, buf, 0);
+    ret = bdrv_pread(crypto->header ? crypto->header : bs->file,
+                     offset, buflen, buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read encryption header");
         return ret;
@@ -269,6 +271,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     QCryptoBlockOpenOptions *open_opts = NULL;
     unsigned int cflags = 0;
     QDict *cryptoopts = NULL;
+    const char *hdr_bdref = qdict_get_try_str(options, "header");
 
     GLOBAL_STATE_CODE();
 
@@ -277,6 +280,15 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
         return ret;
     }
 
+    if (hdr_bdref) {
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
-- 
2.39.1


