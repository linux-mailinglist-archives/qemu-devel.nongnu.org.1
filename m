Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED55681DE61
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:49:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdoL-0004ft-NN; Mon, 25 Dec 2023 00:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoJ-0004fN-7d
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:31 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoF-000217-VI
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:30 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6dbf0561f8bso72597a34.1
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703483122; x=1704087922;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zNyOHhyxQA66DX2bE8dyow8OFzE+dHv8QVRA4UrEEhE=;
 b=dA2liDx9ac9RbGigtHBelA/T61jbj1erxwdcPZgVjQ2cgfmQOK7jViAHzbZVFBkZw6
 nFfKquc1A9NPnh6meyqDiArV0PomA2DhdYjxB3fwJkCJ5NSFWui9jwhzmSXdMShmBlV7
 HsS3iPhLX4VgRO00aTSV/rGTrSnutuIkJBnEnnPlZVuSFjiPCcQmpgGMYN6LQPh1Z/LF
 VXAvhLkGzhkwPfsDHcT+8cSuL5dem3PRNnwwGKL7NdxfVC/LelxXMt24YlmpR09/26vu
 KmQW8RQ+H+mgUyNEkRZJpUIkVJYmpsacUI2CWx27+J3W32H3RtJrBVcOeOIHcnK72U6D
 8JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703483122; x=1704087922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zNyOHhyxQA66DX2bE8dyow8OFzE+dHv8QVRA4UrEEhE=;
 b=FEPE/qmfNKy5Z7eSPI2iqMXvM4OMwb9Zmz6HCVIdiX5zNzviCJ8UPAEaMPbF1WyahB
 GdnSoQRrMEcyueIpO8Hm3fi6fNrZQtkci/lkDLgFK0w0K3lO0nPiET6fN9D5RkRqposK
 padLCtqGfZLf1Q7GczQEpgESAh507ygCKgJ57mV0921zU8zAjq2ABktAFMnZpmG97TFI
 3A+TGIcCL9Cww2O812T/c8GH66BXwEZobfldnn+CKKkDlwUIVFOIXYu7xG/fOBinmKvH
 v+bMOClTeIHyGocFBc6clZdQxRDma+kJ9aIElFiwSem/EOgIiDBzimtj/lvLHRTWRl45
 XmUg==
X-Gm-Message-State: AOJu0YzYn8IT4ERiiFqawrVI8jqbNZtozddEkRAtYUKuY3lcHOabIsQn
 +mga+LVJkgRwU9HXwRbEB+c94gGn4rfISEDGPsKApyJHZk05mA==
X-Google-Smtp-Source: AGHT+IH2Z1kqP0V9dWiBpOEAwTXxy668SIVy4SZfdbtqmANX1zem3Viw627nSQ/fQRblXQbS9mFCNA==
X-Received: by 2002:a05:6830:107:b0:6db:ac75:9118 with SMTP id
 i7-20020a056830010700b006dbac759118mr3802218otp.25.1703483121831; 
 Sun, 24 Dec 2023 21:45:21 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a056a00191600b006cef521b151sm7342415pfi.168.2023.12.24.21.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:45:21 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH RESEND v3 00/10] Support generic Luks encryption 
Date: Mon, 25 Dec 2023 13:45:02 +0800
Message-Id: <cover.1703482349.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x32b.google.com
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

v3:
- Rebase on master
- Add a test case for detached LUKS header
- Adjust the design to honour preallocation of the payload device
- Adjust the design to honour the payload offset from the header,
  even when detached
- Support detached LUKS header creation using qemu-img
- Support detached LUKS header querying
- Do some code clean

Thanks for commenting on this series, please review.

Best regared,

Yong

v2:
- Simplify the design by reusing the LUKS driver to implement
  the generic Luks encryption, thank Daniel for the insightful 
  advice.
- rebase on master. 

This functionality was motivated by the following to-do list seen
in crypto documents:
https://wiki.qemu.org/Features/Block/Crypto 

The last chapter says we should "separate header volume": 

The LUKS format has ability to store the header in a separate volume
from the payload. We should extend the LUKS driver in QEMU to support
this use case.

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

Hyman Huang (10):
  crypto: Introduce option and structure for detached LUKS header
  crypto: Support generic LUKS encryption
  qapi: Make parameter 'file' optional for BlockdevCreateOptionsLUKS
  crypto: Introduce creation option and structure for detached LUKS
    header
  crypto: Mark the payload_offset_sector invalid for detached LUKS
    header
  block: Support detached LUKS header creation using blockdev-create
  block: Support detached LUKS header creation using qemu-img
  crypto: Introduce 'detached-header' field in QCryptoBlockInfoLUKS
  tests: Add detached LUKS header case
  MAINTAINERS: Add section "Detached LUKS header"

 MAINTAINERS                                   |   5 +
 block.c                                       |   5 +-
 block/crypto.c                                | 146 ++++++++++--
 block/crypto.h                                |   8 +
 crypto/block-luks.c                           |  49 +++-
 crypto/block.c                                |   1 +
 crypto/blockpriv.h                            |   3 +
 qapi/block-core.json                          |  14 +-
 qapi/crypto.json                              |  13 +-
 tests/qemu-iotests/210.out                    |   4 +
 tests/qemu-iotests/tests/luks-detached-header | 214 ++++++++++++++++++
 .../tests/luks-detached-header.out            |   5 +
 12 files changed, 436 insertions(+), 31 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/luks-detached-header
 create mode 100644 tests/qemu-iotests/tests/luks-detached-header.out

-- 
2.39.1


