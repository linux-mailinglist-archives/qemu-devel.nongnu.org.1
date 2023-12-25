Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E581DE3A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:30:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdWu-00051O-Dy; Mon, 25 Dec 2023 00:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdWs-000519-In
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:30 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdWq-0007Hh-W6
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:30 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dbde06ae70so167711a34.1
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703482047; x=1704086847;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9e2pyacaPTFtXd3fyhslqs/g1BZY38PqvyuZ6SQ0GM=;
 b=m9XEnKZxbjQVcQmFc/I/yVsr14IGuxw3KIFDvZVo0yld80sdmSfd4ubTQBkn9tHYdJ
 WCERZkfNKDW9LDSZbJVFyogf6V1AdlEg67gceNMzTT3gZi16p0huXElDJmFYt/3BtRXY
 3KEI9JaSMA1vpTq7jf73UhB71npRqtjuo6Vcnsy5DVIQEpRNbwW20S0veq6qYPhb1h54
 aeV3Jd7Smh6turKJ43SqihS6Z6te/fCY4e1Qktxm7Ern/ppjEwsQmV1VBpnQhztNlAo3
 fFt5M3y0S+hseRFhONfDYQgwMUsDbeZ3gZZkjNC8LAdBLMg3TUbf8z2CCzF7CNGH9cew
 9fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703482047; x=1704086847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9e2pyacaPTFtXd3fyhslqs/g1BZY38PqvyuZ6SQ0GM=;
 b=ZOz6RmCUGNuo0/xrFdRSbkzjcHVMvYNJRToI2d8+DRTwXfegrk1X94R73okuT+AD2a
 X0asmbT54KZSocXtZucHISRYQixA0zm5vUQYjuEKiZRE/8gm7qxnOq42FMqmn7p8+liE
 wg1EUTU5Zen/MHiei7FrUa9PmarmPi2AWa5jpM7BVEvkLXMkaYszMuZzMpzOvsGAKhPM
 owkcKpHpODyH2mkIUAHo6urK0I/eAyVgyLof6CFqLLIcqyiRxNjHkc0oB8hG2kkrxtCf
 soBRe4J8Ff9t461KdBvIXwpf0Ztq+YAyTlX/1CCoYY10oY3JYaXSM4fnjNYWaKxXNYFH
 n31w==
X-Gm-Message-State: AOJu0YwWQ7WpVzequg6/HoIG5k4KIic3mb3k3j5FUrmfDafi6Ed42ddU
 +9Bera9Juz/GElYTZZiVuj8SM3kYMLN1ZccXe4SNBS/R0a36MQ==
X-Google-Smtp-Source: AGHT+IF8C0aj6X5pWfu2ElLRfMh3oxephGI/WjzQACieJKVQSKwRvgRZujoRGO8omWvEHVR9E9kJVw==
X-Received: by 2002:a05:6830:615:b0:6db:f26a:9734 with SMTP id
 w21-20020a056830061500b006dbf26a9734mr15222oti.46.1703482046428; 
 Sun, 24 Dec 2023 21:27:26 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa79d87000000b006d991505b4csm4555800pfq.76.2023.12.24.21.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:27:26 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 02/10] crypto: Support generic LUKS encryption
Date: Mon, 25 Dec 2023 13:26:52 +0800
Message-Id: <c55f6e98595c654d17c16a569422bec5c03ddaa0.1703481379.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703481378.git.yong.huang@smartx.com>
References: <cover.1703481378.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x331.google.com
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


