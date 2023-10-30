Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 914EC7DB9C4
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 13:20:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxREr-0005e0-Tt; Mon, 30 Oct 2023 08:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxREa-0005bu-6H; Mon, 30 Oct 2023 08:19:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxREW-00069r-AS; Mon, 30 Oct 2023 08:19:07 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc3bb32b5dso12862785ad.3; 
 Mon, 30 Oct 2023 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698668341; x=1699273141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sEiNzixXK7jh+nccG3foLtztH8JKXpTmBY9awz+9bVk=;
 b=GSTqcKia685kUfbkR3N++t4ysqA+nloCKNQjcwOdgWF7WjI1kP4e8G2BVjYu3dwlA6
 DJhAOfIHgFdBKsbW14J0tUcLB/FzJhJ74z3/yJskDQycIwWVMFqnkC8f9Qy/sP3TeUcg
 wGslZxAfsXq8TFFLLfjp4AFKMlN8YZWssZTrFaZXY11hIb5vkbauwVSt5uQSsSHDthZz
 SgparuV6/IjYYbKRw4HDX8yG8U0Cz4C8KOvtXJf47RHHGgl4lAEpQ9jJHjjt9Y7d+eQ5
 N6e23mzQ4hS1wskFp9fzxWth/RshMnRS1VRCn2K9O3NFPKOPvtMg9AZpOfwIVjNfty2k
 DiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698668341; x=1699273141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sEiNzixXK7jh+nccG3foLtztH8JKXpTmBY9awz+9bVk=;
 b=t2ombLAmnd9QM1inwtTCkUmQUNDvh3vvB9HejTI18nU17hzy4zZmDW1f0E1rcBEgL2
 K6QHNogM3me8qGVXut2J2blF326DYRYqOP6Qivw5YCSGaiHF6Cb/ehbACxH0eK2WJfuv
 5Mg3SX+b3OfQhdAoxdqT779PTta8biQz6Bus2x/7jH78MIZbPggrvXN6gJK3r5p49Xvn
 2DrGJHu2XEU0rJ7LLYLHbMZ8cvXtbq8itRgoXQxdFIiM3XOgOstQIC9GI/6G+dA3u4jL
 vKfMLoWi8y7V5UIfmZt1sCJ1LMssvLYzL2V33n4fTckqTSBpW9RD/pj0Gzq6NEL7kmA7
 8apA==
X-Gm-Message-State: AOJu0Yzw7DF6RWEEDZC5vNEcAfpksyR6Ou3J71inIrQD+jY0rBIqWLEe
 O5RsGVw7JIU1os81NRL6IhpuBkt6okfr4C4b
X-Google-Smtp-Source: AGHT+IEhAZvynwNfsG5hpnD9RCmslDPxIj0OMJSRxtOIo+qjfggTqOsVPOxqYc1Iz1J1tccvI+IRKA==
X-Received: by 2002:a17:902:bd05:b0:1c7:5f03:8562 with SMTP id
 p5-20020a170902bd0500b001c75f038562mr8691657pls.30.1698668340058; 
 Mon, 30 Oct 2023 05:19:00 -0700 (PDT)
Received: from fedlinux.. ([106.84.131.249]) by smtp.gmail.com with ESMTPSA id
 f12-20020a170902684c00b001b9f032bb3dsm6362339pln.3.2023.10.30.05.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 05:18:59 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org, hare@suse.de,
 dmitry.fomichev@wdc.com, stefanha@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v5 0/4] Add full zoned storage emulation to qcow2 driver
Date: Mon, 30 Oct 2023 20:18:43 +0800
Message-Id: <20231030121847.4522-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To create a qcow2 file with zoned format, use command like this:
$ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
zone_size=64M -o zone_capacity=64M -o nr_conv_zones=0 -o
max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
-o zone_model=1

Then add it to the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,file.driver=file,file.filename=../qemu/test.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

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

 block/qcow2.c                            | 934 ++++++++++++++++++++++-
 block/qcow2.h                            |  37 +-
 block/trace-events                       |   2 +
 docs/interop/qcow2.txt                   |  67 +-
 docs/system/qemu-block-drivers.rst.inc   |  33 +
 include/block/block_int-common.h         |  13 +
 include/qemu/queue.h                     |   1 +
 qapi/block-core.json                     |  45 +-
 tests/qemu-iotests/tests/zoned-qcow2     | 126 +++
 tests/qemu-iotests/tests/zoned-qcow2.out | 118 +++
 10 files changed, 1370 insertions(+), 6 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.40.1


