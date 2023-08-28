Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D551B78B416
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qadso-0007Cs-V5; Mon, 28 Aug 2023 11:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qadsg-00071t-VE; Mon, 28 Aug 2023 11:10:19 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qadse-0003uv-Jj; Mon, 28 Aug 2023 11:10:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c06f6f98c0so25812495ad.3; 
 Mon, 28 Aug 2023 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693235414; x=1693840214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yg5fqQnol8ZnQ7hPzm8UXg7wav/IWic7jdV5z3Lnk1U=;
 b=WYk39tP4nY82Xi9sk1JgR4sUKbFLh2asUu3hsMfY/wPlGzWuz7mNFKyOD5d7V8dFTy
 pCp81p3KiDXOmNAoH10Lrg9Pm9UHNC0ziEaG+hIbBp31i5QJyknmI29btPYq0Dx6yrOz
 /CD7xxrSFOc7X7Jj8nqzB9S1UMbgi2pfpM0WUs1DfSQtPAd1OQ/zlert+4J+p0ed5Gey
 kgQrUXfbZSaEw8TWIaYPnrRsBJNQiupmVRIh/YWwTxiWg8dgtI3hoMdV0T55XqJCAnlW
 TeygFhHiFvxyqEwW8u3XABl9ISXJJ3LfRJYZ1DDlk4GWdJ413cNkbXtJ1P0l2ZXM+Jev
 q1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693235414; x=1693840214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yg5fqQnol8ZnQ7hPzm8UXg7wav/IWic7jdV5z3Lnk1U=;
 b=asR3RPcX4FHTVkgxADTxFKz3FV77YVqQlP15EfsGIEMEEi6IBBCGaOQFDPkH9yYODY
 uwlO4hOGCyORTz4bMHPJLny7ctJtoc755UbLwN8zkXNObdHjCikjWc+E8KyM4pGvJUNi
 QXEc0XhgbgSvEKAMP87MKPuEgewt3cRDh6KgYi9MncYqsHG88LuDV5APnZColPzlKUbz
 vTcXBjtIPk+8+R924Rqb9fP+UPV33wXtwgGpMnZ4ytj6KTdukrUhm8mIYUIVCT8PJcx2
 4AMOIs9et2+JCsZq9PPjGtSADJbXhtAV1zkH3hH3xo7F/1t4sJZDZRrxWjZXJw2nnKhn
 Pb9A==
X-Gm-Message-State: AOJu0YzB7JQWd4J/yWe6D5cJj1592OvGaBFWeQvvqW33W4Z7+v0bp+G5
 9BBSNDh3ZLW4e2gwOti8ItImTGHSiKAiMqku8vo=
X-Google-Smtp-Source: AGHT+IFnGBZOtYLvxiHkE3dy8xKN0n2XMiU1/PfQfc6fpkipwdc2+br1lizMopQloZTeSaAksJp0BQ==
X-Received: by 2002:a17:903:2450:b0:1c0:ec66:f2b2 with SMTP id
 l16-20020a170903245000b001c0ec66f2b2mr7715990pls.27.1693235413163; 
 Mon, 28 Aug 2023 08:10:13 -0700 (PDT)
Received: from fedlinux.. ([106.84.130.225]) by smtp.gmail.com with ESMTPSA id
 i19-20020a170902eb5300b001b8b26fa6c1sm7427456pli.115.2023.08.28.08.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:10:12 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, dmitry.fomichev@wdc.com,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, hare@suse.de, qemu-block@nongnu.org,
 stefanha@redhat.com, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v3 0/4] Add full zoned storage emulation to qcow2 driver
Date: Mon, 28 Aug 2023 23:09:51 +0800
Message-Id: <20230828150955.3481-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x633.google.com
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
zone_size=64M -o zone_capacity=64M -o nr_conv_zones=0 -o
max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
-o zone_model=1

Then add it to the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,file.driver=file,file.filename=../qemu/test.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

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

 block/qcow2.c                            | 831 ++++++++++++++++++++++-
 block/qcow2.h                            |  22 +
 block/trace-events                       |   1 +
 docs/interop/qcow2.txt                   |  42 ++
 docs/system/qemu-block-drivers.rst.inc   |  39 ++
 include/block/block_int-common.h         |  13 +
 qapi/block-core.json                     |  30 +-
 tests/qemu-iotests/tests/zoned-qcow2     | 135 ++++
 tests/qemu-iotests/tests/zoned-qcow2.out | 140 ++++
 9 files changed, 1250 insertions(+), 3 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.40.1


