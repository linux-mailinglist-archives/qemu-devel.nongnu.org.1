Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3056177B4F1
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 11:00:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVTPD-0001ps-V4; Mon, 14 Aug 2023 04:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qVTPB-0001pR-Mu; Mon, 14 Aug 2023 04:58:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qVTPA-0007As-3l; Mon, 14 Aug 2023 04:58:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686ba29ccb1so2696361b3a.1; 
 Mon, 14 Aug 2023 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692003505; x=1692608305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jey+y3ycpm8vB5JJEKbq1korWN2nBcJzXvlyd91Vtlc=;
 b=KXUX6evPHGk5lJSUOoaNLR6Rp9n2Mna5iYuSSdoU6SaS3XTwSmyQkIfaDDX6rjrWfA
 87yCH1Pc4T1Zp8gubYvoBpnRT247kgmZjO6hO3Zdj8Ms1dvDdIHbMsa+KbOXgh+8hf6K
 IUpz4agiOtrKqv6MDdy/DVr/NleVyUPOqYVJAN9i5D/ZCeVfgd1vzyAdNlQA6yblZFfa
 kfA3VhxxwITM0aMbIYyL6J+chPf7AJczglXZZeooWmwUMDc5vyd3GNrH6IeSKjJHQGJS
 LjM/pUx+Gimxg20q5NOo7omZP6CJWb9Hl4ZLUWs7NHqufB0Lq4c8hKBX7fFYDy2D6dyy
 4/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692003505; x=1692608305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jey+y3ycpm8vB5JJEKbq1korWN2nBcJzXvlyd91Vtlc=;
 b=jWVC4GXtmv9FfQoztq6wHHgIcQO2kmpmGVsU0pWB8p+0Ks6/uTvtf5pSIz/xEqzXlM
 BDCHGMy+YaQLnctceeweq/9RZq0Iu/rLXNYFNPDi6aZwjGDm1eGKFJMia2K7SprzxOz/
 uPEb3rFbRgP56kMCvc5uTXXtoCsmr96030tRiNnxUfN09gZ0xci1XiOlfC07t5Y9EbDO
 CY//fVX/9uqWtMKpu8Io/28/n4H9L5PCstxreBGE3maSROFNsMw9gSlH57Dh3kMzMLBk
 Rqtogxp8a0/6sLky+DK8heuhbdFtFqZH4FsHqLrLCgoTIQAMs45rwgSD00bznmSLuaRj
 hnPA==
X-Gm-Message-State: AOJu0Yzg0xcGJAlpEVvbi1obpGErsn6EvPaCXZcX9vNUpMcGX2Ssh83m
 B6BKgYyaMpqu3yKVIPK4OBkJAxh3XLRh3PFetPA=
X-Google-Smtp-Source: AGHT+IGGP4CT2uAVzZ7RNX/sTgL9nrSOWNqvGqH+EMLUKrw7IEbz8hUwO106ZYnhycSX087IibdF0w==
X-Received: by 2002:a05:6a20:7351:b0:140:2ec5:2bd3 with SMTP id
 v17-20020a056a20735100b001402ec52bd3mr14473543pzc.27.1692003505018; 
 Mon, 14 Aug 2023 01:58:25 -0700 (PDT)
Received: from fedlinux.. ([106.84.134.250]) by smtp.gmail.com with ESMTPSA id
 bt24-20020a632918000000b00528db73ed70sm8238890pgb.3.2023.08.14.01.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 01:58:24 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: hare@suse.de, Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 stefanha@redhat.com, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v2 0/4] Add full zoned storage emulation to qcow2 driver
Date: Mon, 14 Aug 2023 16:57:58 +0800
Message-Id: <20230814085802.61459-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x42f.google.com
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

To create a qcow2 file with zoned format, use command like this:
$ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
zone_size=64M -o zone_capacity=64M -o zone_nr_conv=0 -o
max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
-o zoned_profile=zbc

Then add it to the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,file.driver=file,file.filename=../qemu/test.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

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

 block/qcow2.c                            | 799 ++++++++++++++++++++++-
 block/qcow2.h                            |  23 +
 docs/interop/qcow2.txt                   |  26 +
 docs/system/qemu-block-drivers.rst.inc   |  39 ++
 include/block/block-common.h             |   5 +
 include/block/block_int-common.h         |  16 +
 qapi/block-core.json                     |  46 +-
 tests/qemu-iotests/tests/zoned-qcow2     | 135 ++++
 tests/qemu-iotests/tests/zoned-qcow2.out | 140 ++++
 9 files changed, 1214 insertions(+), 15 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.40.1


