Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D038039BA
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABV1-0006ga-9l; Mon, 04 Dec 2023 11:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABUy-0006fq-E3
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:08:44 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABUv-0005Gu-5u
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:08:44 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ce47909313so692369b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701705996; x=1702310796;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3M0DS6b6jQp9VBTYqAfl5mjd7il15W+Sq0+VP+RPvsg=;
 b=YNWvKpDqsUH0DUw7thpy8aKmcGwyPhZr4FTWGN37xs9FVVcYiP2IsYQ+uOXs4EKXQi
 hUenUKMfmqmWoxdy5LOY7+ACaajlzW7EzzLpGcj/I3lNbPjj3gVAKIARW6g+LyPppnMm
 JXcevRik61ZWTdb6AuT1OMP6hqzb5CCQVEW5+890u69wGVou3grPDtNvTJXfI3uw8EzE
 01Lgh9y14eP7pf7PWcXR3HrDuGHKK7yKG3gquuKww4oSPPikZ5CCKP+0eQv8/JaTyjMK
 gq1+VEk2Fd+7mXj2pzButHBqYje87IuKt0HoAHSoxVlMhXWcVCT9GdGA7H26Rg7VGdR5
 4ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701705996; x=1702310796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3M0DS6b6jQp9VBTYqAfl5mjd7il15W+Sq0+VP+RPvsg=;
 b=ju9rPEwI98MPbl29XgLG79QmBv91bziw/NVEXmhB+p5m4KdOInz8Z1e+inuVeVl7se
 JqHsaQ0fJaDr/1yuzuEB/irx4odPjfBdpqeL+jmC8PHTuUc0PNlhSSMTjGGBsPYOOiuE
 kDbEbyv756jpfF2HA5RnarsGMQ1qEDu4yyPjpEF3SokeB7Tfdso+X740rPBhNWqPNj0B
 TfiMBz4Dcy19/0hpMK3dI7U+/0VhSrYjbS6UsJgMHDJpe/LB5RIfheTlY7XRZ5NKWf8h
 rRzE0H8nCPSIVDVofrokbvMoywWBkhyni7B3DiHp6JspZlCSPcXb/Moo2eSMhWijlwS7
 IHBg==
X-Gm-Message-State: AOJu0Yyu35Eg5sqmYBXrQiz+va9YWiTU/ccALzCxcj1rS9/SEEOx7AwG
 GgQSLyYT4jseH02bbD+hjgO26/2aVjBxg6Hu9WM9QZv6
X-Google-Smtp-Source: AGHT+IGqnvTQqqmT8ZLS12TRGTR9th4384Jy2RldrDQA0YT2oJiEytawINso1J0lYs3KMmSF8lmv6Q==
X-Received: by 2002:a05:6a20:1444:b0:18f:97c:5b77 with SMTP id
 a4-20020a056a20144400b0018f097c5b77mr1765753pzi.69.1701705995398; 
 Mon, 04 Dec 2023 08:06:35 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m17-20020aa78a11000000b006be4bb0d2dcsm7993064pfa.149.2023.12.04.08.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 08:06:34 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [RFC 0/8] Support generic Luks encryption
Date: Tue,  5 Dec 2023 00:06:17 +0800
Message-Id: <cover.1701705003.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42a.google.com
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

This functionality was motivated by the following to-do list seen
in crypto documents:
https://wiki.qemu.org/Features/Block/Crypto 

The last chapter says we should "separate header volume": 

The LUKS format has ability to store the header in a separate volume
from the payload. We should extend the LUKS driver in QEMU to support
this use case.

As a proof-of-concept, I've created this patchset, which I've named
the Gluks: generic luks. As their name suggests, they offer encryption
for any format that QEMU theoretically supports.

As you can see below, the Gluks format block layer driver's design is
quite simple.

         virtio-blk/vhost-user-blk...(front-end device)
              ^            
              |            
             Gluks   (format-like disk node) 
          /         \         
       file       header (blockdev reference)
        /             \        
     file            file (protocol node)
       |               |
   disk data       Luks data 

We don't need to create a new disk format in order to use the Gluks
to encrypt the disk; all we need to do is construct a Luks header, which
we will refer to as the "Gluk" because it only contains Luks header data
and no user data. The creation command, for instance, is nearly
identical to Luks image:

$ qemu-img create --object secret,id=sec0,data=abc123 -f gluks
  -o cipher-alg=aes-256,cipher-mode=xts -o key-secret=sec0
  cipher.gluks

As previously mentioned, the "size" option is not accepted during the
generation of the Gluks format because it only contains the Luks header
data.

To hot-add a raw disk with Gluks encryption, see the following steps:

1. add a protocol blockdev node of data disk 
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
  "arguments":{"node-name": "libvirt-1-storage", "driver": "file",
  "filename": "/path/to/test_disk.raw"}}'

2. add a protocol blockdev node of Luks header
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
  "arguments":{"node-name": "libvirt-2-storage", "driver": "file",
  "filename": "/path/to/cipher.gluks" }}'

3. add the secret for decrypting the cipher stored in Gluks header
$ virsh qemu-monitor-command c81_node1 '{"execute":"object-add",
  "arguments":{"qom-type": "secret", "id":
  "libvirt-2-storage-secret0", "data": "abc123"}}'

4. add the Gluks-drived blockdev to connect the user disk with Luks
   header, QEMU will use the cipher in the Luks header to
   encrypt/decrypt the disk data
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
  "arguments":{"node-name": "libvirt-1-format", "driver": "gluks", "file":
  "libvirt-1-storage", "header": "libvirt-2-storage", "key-secret":
  "libvirt-2-storage-secret0"}}' 

5. add the device finally
$ virsh qemu-monitor-command vm '{"execute":"device_add",
  "arguments": {"num-queues": "1", "driver": "virtio-blk-pci", "scsi":
  "off", "drive": "libvirt-1-format", "id": "virtio-disk1"}}'

Do the reverse to hot-del the raw disk.

To hot-add a qcow2 disk with Gluks encryption:

1. add a protocol blockdev node of data disk
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
  "arguments":{"node-name": "libvirt-1-storage", "driver": "file",
  "filename": "/path/to/test_disk.qcow2"}}'

2. add a protocol blockdev node of Luks header as above.
   block ref: libvirt-2-storage

3. add the secret for decrypting the cipher stored in Gluks header as
   above too 
   secret ref: libvirt-2-storage-secret0

4. add the qcow2-drived blockdev format node:
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
  "arguments":{"node-name": "libvirt-1-format", "driver": "qcow2",
  "file": "libvirt-1-storage"}}'

5. add the Gluks-drived blockdev to connect the qcow2 disk with Luks
   header 
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
  "arguments":{"node-name": "libvirt-2-format", "driver": "gluks",
  "file": "libvirt-1-format", "header": "libvirt-2-storage",
  "key-secret": "libvirt-2-format-secret0"}}'

6. add the device finally
$ virsh qemu-monitor-command vm '{"execute":"device_add",
  "arguments": {"num-queues": "1", "driver": "virtio-blk-pci", "scsi":
  "off", "drive": "libvirt-2-format", "id": "virtio-disk2"}}'

In a virtual machine, several disk nodes are allowed to share a single
Gluks header.

This patchset, as previously said, is a proof-of-concept; additional
work may be required before productization. As the title suggests, we
have uploaded it solely for comments. Additionally, a thorough test
would be performed on the following version.

Any ideas and comments about this feature would be appreciated.

Thanks,

Yong

Best regared !

Hyman Huang (8):
  crypto: Export util functions and structures
  crypto: Introduce payload offset set function
  Gluks: Add the basic framework
  Gluks: Introduce Gluks options
  qapi: Introduce Gluks types to qapi
  crypto: Provide the Luks crypto driver to Gluks
  Gluks: Implement the fundamental block layer driver hooks.
  block: Support Gluks format image creation using qemu-img

 block.c                |   5 +
 block/crypto.c         |  20 +---
 block/crypto.h         |  23 ++++
 block/generic-luks.c   | 250 +++++++++++++++++++++++++++++++++++++++++
 block/generic-luks.h   |  29 +++++
 block/meson.build      |   1 +
 crypto/block.c         |   5 +
 include/crypto/block.h |   1 +
 qapi/block-core.json   |  22 +++-
 qapi/crypto.json       |  10 +-
 10 files changed, 348 insertions(+), 18 deletions(-)
 create mode 100644 block/generic-luks.c
 create mode 100644 block/generic-luks.h

-- 
2.39.1


