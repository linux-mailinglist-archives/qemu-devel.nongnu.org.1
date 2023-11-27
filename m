Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE67F986C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:38:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7TN0-0000aH-Pk; Sun, 26 Nov 2023 23:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7TMy-0000Zu-9p; Sun, 26 Nov 2023 23:37:16 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7TMw-0001GK-Jt; Sun, 26 Nov 2023 23:37:16 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b5714439b3so1736053b6e.3; 
 Sun, 26 Nov 2023 20:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701059831; x=1701664631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XZ8OWMp5aMlD2RIaTogjS+gdRM+E3LKokmEAsbH4ErQ=;
 b=E9wYAWERd1cgLWq8Fhu14aCNkS6EEzbyP0OHfD5q+qb+zRSkNV+XQy2EYEO2NK90EJ
 0noYbe7FuoXiTi0TX7lZVA9+rRDT4gzkbVLKtJKFPcLOVOb1ig77PnyZMbsMSGUJzChn
 g7xueTrxx7E5cEv0Qau/csRi19a43JSwbPAUOLM6LXxDBM1dynEK6/AGXW5RgmhJBXyY
 NSsdnX/f+KFoqjjp1Ek6po2fumsTfNjceNee3VUAEh0Ngrs2w6yaAvphPSq895dFYI5i
 rgJOqdQR8ALQ/XSOUDaJqgq+HlY2lwSGi7dEn+2X8p3WHRwq2wYD8498mYg8sSREJVyk
 MrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059831; x=1701664631;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XZ8OWMp5aMlD2RIaTogjS+gdRM+E3LKokmEAsbH4ErQ=;
 b=Ofvy3hQpKDpxmJKGNoVFA6l68hl3mcDgbMHed7gxURnHVpeFZTOj/ZYfNvfMR3Dxew
 fWxrkAC/ZC9ZiqE2he+EDNsqN7Kr+FE7/910qPM/p7YOoFGNTnU+JOlX0ewvPYlhLbPd
 6HZddXGei7/eq/huBb1ci406GyfU3hdGBWlkQruMUw4O1d1X6cfwfAtq3vGCEPxonNjg
 qPYxa1c1n/TxCKkPGRT+PwWDdKqzEVjWCZTJRXkaaNRU+XY8OOfe6KkRxXW+s0WZxQ6G
 UYLKzI7upT1A1dY6uhyj96woz+OHPcbAG+CqbfA9UI8dL3jQJ4veTjmLnjo+msc5H57R
 Viqw==
X-Gm-Message-State: AOJu0YyaKC5tQ/7SVQ6Tc2PQSs3LE5W0VA6znEoybMrPQvfkbPe0hi1p
 46TUF/3NfRoLelDd/dXKQRsNHYaTdkLhkokt
X-Google-Smtp-Source: AGHT+IEfoXc50tyBsAj1e1Hv7oEvFjdvhc38FEwe4bc4MMtN033Xk7c+bjxZzfu9izRIe1eRNoBb9w==
X-Received: by 2002:a05:6808:b01:b0:3a7:1b28:4bc9 with SMTP id
 s1-20020a0568080b0100b003a71b284bc9mr8924559oij.54.1701059830186; 
 Sun, 26 Nov 2023 20:37:10 -0800 (PST)
Received: from fedlinux.. ([106.84.128.244]) by smtp.gmail.com with ESMTPSA id
 u15-20020a62ed0f000000b006c4d86a259csm6280070pfh.28.2023.11.26.20.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 20:37:09 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v6 0/4] Add full zoned storage emulation to qcow2 driver
Date: Mon, 27 Nov 2023 12:36:59 +0800
Message-Id: <20231127043703.49489-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=faithilikerun@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch series add a new extension - zoned format - to the
qcow2 driver thereby allowing full zoned storage emulation on
the qcow2 img file. Users can attach such a qcow2 file to the
guest as a zoned device.

Write pointer are preserved in the zoned metadata. It will be
recovered after power cycle. Meanwhile, any open (implicit or
explicit) zone will show up as closed.

Zone states are in memory. Read-only and offline states are
device-internal events, which are not considerred in qcow2
emulation for simplicity. The other zone states
(closed, empty, full) can be inferred from write poiner
values, presistent across QEMU reboots. The open states are
kept in memory using open zone lists.

Zoned extension feature is optional. We only set it to host-manged 
when emulating a zoned device. For non-zoned devices, it does not 
need to consider setting this option.

To create a qcow2 image with zoned format feature, use command like
this:
$path/to/qemu-img create -f qcow2 zbc.qcow2 -o size=768M
-o zone.size=64M -o zone.capacity=64M -o zone.conventional_zones=0
-o zone.max_append_bytes=4096 -o zone.max_open_zones=10
-o zone.max_active_zones=12 -o zone.mode=host-managed


Then add it to the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,file.driver=file,file.filename=../qemu/test.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

v5->v6:
- fix docs and specs [Eric, Markus, Stefan]
- add general sanity checks for zoned device configurations while creation and opening [Eric]
- fix LRU when implicitly open a zone for a long time [Stefan]

v4->v5:
- add incompatible bit for zoned format [Eric]
- fix and manage zone resources via LRU [Damien]
- renaming functions and fields, spec changes [Markus, Damien]
- add closed zone list
- make qemu iotests for zoned device consecutive [Stefan]

v3->v4:
- use QLIST for implicit, explicit open zones management [Stefan]
- keep zone states in memory and drop state bits in wp metadata structure [Damien, Stefan]
- change zone resource management and iotests accordingly
- add tracing for number of implicit zones
- address review comments [Stefan, Markus]:
  * documentation, config, style

v2->v3:
- drop zoned_profile option [Klaus]
- reformat doc comments of qcow2 [Markus]
- add input validation and checks for zoned information [Stefan]
- code style: format, comments, documentation, naming [Stefan]
- add tracing function for wp tracking [Stefan]
- reconstruct io path in check_zone_resources [Stefan]

v1->v2:
- add more tests to qemu-io zoned commands
- make zone append change state to full when wp reaches end
- add documentation to qcow2 zoned extension header
- address review comments (Stefan):
  * fix zoned_mata allocation size
  * use bitwise or than addition
  * fix wp index overflow and locking
  * cleanups: comments, naming

Sam Li (4):
  docs/qcow2: add the zoned format feature
  qcow2: add configurations for zoned format extension
  qcow2: add zoned emulation capability
  iotests: test the zoned format feature for qcow2 file

 block/qcow2.c                            | 972 ++++++++++++++++++++++-
 block/qcow2.h                            |  36 +-
 block/trace-events                       |   2 +
 docs/interop/qcow2.txt                   |  99 ++-
 docs/system/qemu-block-drivers.rst.inc   |  35 +
 include/block/block_int-common.h         |  13 +
 include/qemu/queue.h                     |   1 +
 qapi/block-core.json                     |  63 +-
 tests/qemu-iotests/tests/zoned-qcow2     | 126 +++
 tests/qemu-iotests/tests/zoned-qcow2.out | 118 +++
 10 files changed, 1460 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.40.1


