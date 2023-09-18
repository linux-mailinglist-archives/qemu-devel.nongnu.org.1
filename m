Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 760657A466A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAwc-0002Hn-NS; Mon, 18 Sep 2023 05:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiAwa-0002HZ-RZ; Mon, 18 Sep 2023 05:53:28 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiAwZ-0002Gv-A7; Mon, 18 Sep 2023 05:53:28 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c0f4ad9eb1so2871246a34.1; 
 Mon, 18 Sep 2023 02:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695030805; x=1695635605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F52iVA4/pwtKP1imOkQN9p60M2GpcJUjawlN/CsbuVM=;
 b=ZMHCVVkcIy9kqlM5O1ZxbtPjqqVuBjm+FKEKsQ3Y0j4XefIf3/fgjuNz0/aRjix9T0
 Kwm9+jYAoLBEm8UZvvKN6vCjwpDyS7q/cOpCRN5IhnACmOrw7hxbQTow1gcpzHs59lYK
 PZZ3ZYmNOMBJX+MeWgOQBV114l40jS4Y/fSNHNwH3C30qR5oOOI3Lcjgw2pp7QZ9YmyC
 zF54EcsIlViFnEIHAfPiqUIBWUHloHgkZXRXXNpjO4BekZInZQZMXbwAwa93Uo3SdB9z
 rP1KgA+b0HobWzda3NmZhM7WZcfNm/22dm6iH4AnRM+Assy7M9iSAyMwCg2P0xM4S3zC
 CKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695030805; x=1695635605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F52iVA4/pwtKP1imOkQN9p60M2GpcJUjawlN/CsbuVM=;
 b=s2lioUCQlQHC1lz/VHf/sWG+MwrHwMOvmXiVCnWvDALJk53pulGyr+DCDFVrJyHBtn
 qX7w/YybqVhDED6qvHyN5hUiN4TEv+us+RJsRs7F7rWNNzd3563oQvT09NwKhG26mug1
 W9P7J5Y/esJ5iaO56krgJAOWWp4PB2oySbd0wqJUsQ1nWKunG3/+UMhFct2+65TH8i3i
 3tHUtNoDX4Zu1GCUsfkXc5OfzBAO/ImLOs5CtO92uulsICqpiLYsP9H+ZOv01lXDxonI
 720sjd9MNlSQotPnrJpnd8OFKDz0TVikR3MnJbnUGB3Bcu67DHyZzUWViM+XAJYJtDY1
 oESg==
X-Gm-Message-State: AOJu0YwPd0rRiwh88qqdvPPBiTJ9oQOUznIDPNVFfDu6v/tAY8mEl1C0
 RE+A9zrkw1FwmfMBPS7x+9S7DcJtTRb47pRb8gY=
X-Google-Smtp-Source: AGHT+IF8FBagb0VcyRZDf1SFgAZwFfBF9+ZTPHaUHIUYNATDy4wlMe4mmCjW+qpIyDqoPx0Uxh5Prw==
X-Received: by 2002:a05:6359:668d:b0:143:1063:d1f4 with SMTP id
 so13-20020a056359668d00b001431063d1f4mr5755295rwb.13.1695030804731; 
 Mon, 18 Sep 2023 02:53:24 -0700 (PDT)
Received: from fedlinux.. ([106.84.131.213]) by smtp.gmail.com with ESMTPSA id
 y24-20020aa78558000000b0068fb8080939sm6780553pfn.65.2023.09.18.02.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 02:53:24 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dmitry.fomichev@wdc.com, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v4 0/4] Add full zoned storage emulation to qcow2 driver
Date: Mon, 18 Sep 2023 17:53:09 +0800
Message-Id: <20230918095313.5492-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=faithilikerun@gmail.com; helo=mail-ot1-x32f.google.com
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

 block/qcow2.c                            | 893 ++++++++++++++++++++++-
 block/qcow2.h                            |  30 +
 block/trace-events                       |   2 +
 docs/interop/qcow2.txt                   |  42 ++
 docs/system/qemu-block-drivers.rst.inc   |  33 +
 include/block/block_int-common.h         |  13 +
 qapi/block-core.json                     |  30 +-
 tests/qemu-iotests/tests/zoned-qcow2     | 129 ++++
 tests/qemu-iotests/tests/zoned-qcow2.out | 133 ++++
 9 files changed, 1302 insertions(+), 3 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.40.1


