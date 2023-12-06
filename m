Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1230807562
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:41:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAuwO-0006yz-Sx; Wed, 06 Dec 2023 11:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAuwM-0006yd-FZ
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:40:02 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAuwJ-0003li-EX
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:40:02 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d06d42a58aso42437085ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701880674; x=1702485474;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l58I2QJUtWOGWXjRD29t6mmy2AkwM2q8lCd0Wroamoo=;
 b=K+/K8+ByKK7vtjWQ0vAN5Qa0GAVvf/CbkSGzL+KGA1ergEh/IW2Dnhmo8xT8U0dZB3
 2PMM1w89NudTZXmSNEQh/6ZHSLb8Kj57kdLnHVXivGwRZK2lir0saT+CE/QAMSq+dBOr
 M+eIvMhRS/Phdx9XG5mlr80XZu/FjI2LIJ05UVfPbH9yvqwDjxnq+OBq/6JD7Vt/gihs
 /ve6hQ0qpqANjodxFMNu9v3vImyV2t0pn6plnyjeNmQtpYDn6pRnHRPoyFgdtLL5xyCH
 jNs5hPm0ZJgxAjn6JIv/890jxDofmfKtG/+R9PHi/ixih+OwZ5xeyeytWhbAYhdD3SvL
 Dl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701880674; x=1702485474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l58I2QJUtWOGWXjRD29t6mmy2AkwM2q8lCd0Wroamoo=;
 b=v6+vwGLxkvHE6Sp+v7ryzZtHSbjW9m2Y4shFkuRHIi15pryEOn1La/ZVPjvvrwzpp7
 VO5q8lNzo7x1bMRccMhM3VeUfxSdD4/q+M6rImsXbJhG+L/195KW636c+drDun+SkO7F
 3GvXz0zdTP2x33xZ4XdbQbtXiCoOHWgMyyql8wEWsO74DLLPlgzn+KPzn8WMULZCHLWG
 plJa5Xpxuff58rGsnEYFtpmoEBP5cD+ZpyuzDbBrWzMQM9E5T0d/RjE/JSHnjPdOUZMH
 kVHUuel1hIlYlLBTm8Q4KTHqTfDAg5ifkKKbsXpqN8mxdOy5TMXDnjC63jS7QG2T5zvz
 sD1A==
X-Gm-Message-State: AOJu0YyVjb5utQCL5FOI9ZAdupKFtBzfGN1Ef5lwmJndFtrU7ALMbjHA
 wTKFq9s7wwH+LOpY0NkeUromhxx8SPoDVpilJULfD2xn
X-Google-Smtp-Source: AGHT+IGHzHphG0QO1qfQONft3dKD7jwIe+H6pUDPQtesMu6g1xP6xpR2gb9lqlJXX80Xi8mOWfuxZg==
X-Received: by 2002:a17:902:ab98:b0:1d0:6ffd:e2e9 with SMTP id
 f24-20020a170902ab9800b001d06ffde2e9mr1154316plr.131.1701880673544; 
 Wed, 06 Dec 2023 08:37:53 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a170902bb8e00b001d04d730687sm42570pls.103.2023.12.06.08.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 08:37:53 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [v2 0/4] Support generic Luks encryption
Date: Thu,  7 Dec 2023 00:37:41 +0800
Message-Id: <cover.1701879996.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x629.google.com
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

Please review, thanks

Best regared,

Yong

Hyman Huang (4):
  crypto: Introduce option and structure for detached LUKS header
  crypto: Introduce payload offset set function
  crypto: Support generic LUKS encryption
  block: Support detached LUKS header creation for blockdev-create

 block/crypto.c         | 47 ++++++++++++++++++++++++++++++++++++++++--
 crypto/block.c         |  4 ++++
 include/crypto/block.h |  1 +
 qapi/block-core.json   | 11 ++++++++--
 4 files changed, 59 insertions(+), 4 deletions(-)

-- 
2.39.1


