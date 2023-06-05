Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 927697223B8
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:43:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67eL-0001xV-Tr; Mon, 05 Jun 2023 06:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q67eK-0001xI-7g; Mon, 05 Jun 2023 06:41:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q67eI-0006nh-M4; Mon, 05 Jun 2023 06:41:19 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b025d26f4fso40157845ad.1; 
 Mon, 05 Jun 2023 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685961676; x=1688553676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g634lPiI3cRk/85suseMq/Sa3k3jFHOQzq5XuuooB4w=;
 b=ZAiZeoBX/AAzXs8W/DRPqnScbLBkPKAjnUTvDErgkRnu1bhJFTWasspKTHHTbfgJZQ
 8w+25lXCKmGPIDgwgBFzzdQg7UZtd8Iiqj9vJ/rXOlX2tXriLf7ifojWpWpeWLb1TNiD
 NSi3nGFVO1Vhp4PltJY2H8n0jurVEmUeAKSeP62Y4WFKiiiyB6UO0bB6erBvritGTWTo
 zvSYhXRu51wywn86Jr4vWiivt8hxPcBAQd5tJIt7NUg+VTXe/K+r7We588pARTb1UEL6
 DKTTdMN5PT0STPLr15v7zjpTkqKWOP5gZ/5Y4McGVwviVccWWIHzuKqU6olL4NjdUwAp
 sfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685961676; x=1688553676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g634lPiI3cRk/85suseMq/Sa3k3jFHOQzq5XuuooB4w=;
 b=d9RnZpN/v0ebk9YyXqN9zPU1F/h0d7i/4KWDhOx+kTQy3Uc2BGi/P2zoLFWA3iHqmT
 0VAl3/HPRM59P/WE7RGCSpFbTJkMzgFuthcXAHnTiMLGUWXPPBFWpLWu29xVN3Ek+EOC
 xS2N7lJWPnp9sda9XDnENSXQh5oGI+RZgaV0/AtP8N9i+qmLcRExPlz7EOHi0pu39NS+
 AjUptPXSbZp/xD5webMALfDLRyNtquom5B+pgMn2t6Hzl/yvgGGg7/73oHkRtl5jl3X9
 +RDw5b9Y9TpUQiO6TPicf8IamnXoq9A47GJCTER3VZJ9RddsiW1pexa4rVK3Xhx65YkT
 SesA==
X-Gm-Message-State: AC+VfDw578Xem2feCJ627kMpCSVBH6GyhfXPIeUGG1T62cEvyyFnAM7K
 bdczlt76kQlHjpLLGYo3Z8dhV/h1ZGKrIGWD
X-Google-Smtp-Source: ACHHUZ6eXt4dPG2MAheX8fGj0/mYxCULOj7rv/hpCacqyHA3r0rGHnsnzkK5x/3yanXDvdGPo/nq4g==
X-Received: by 2002:a17:902:d2c6:b0:1b0:5304:5b48 with SMTP id
 n6-20020a170902d2c600b001b053045b48mr8337989plc.0.1685961675436; 
 Mon, 05 Jun 2023 03:41:15 -0700 (PDT)
Received: from fedlinux.. ([106.84.132.130]) by smtp.gmail.com with ESMTPSA id
 x4-20020a170902a38400b001b0457705e8sm6340141pla.140.2023.06.05.03.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 03:41:14 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, dmitry.fomichev@wdc.com, hare@suse.de,
 stefanha@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [RFC 0/4] Add full zoned storage emulation to qcow2 driver
Date: Mon,  5 Jun 2023 18:41:04 +0800
Message-Id: <20230605104108.125270-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x629.google.com
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

To create a qcow2 file with zoned format, use command like this:
    $ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
    zone_size=64M -o zone_capacity=64M -o zone_nr_conv=0 -o
    max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
     -o zoned_profile=zbc

Then add it to the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,file.driver=file,file.filename=../qemu/test.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

Sam Li (4):
  docs/qcow2: add the zoned format feature
  qcow2: add configurations for zoned format extension
  qcow2: add zoned emulation capability
  iotests: test the zoned format feature for qcow2 file

 block/qcow2.c                            | 746 ++++++++++++++++++++++-
 block/qcow2.h                            |  23 +
 docs/system/qemu-block-drivers.rst.inc   |  31 +
 include/block/block-common.h             |   5 +
 include/block/block_int-common.h         |   8 +
 qapi/block-core.json                     |  46 +-
 tests/qemu-iotests/tests/zoned-qcow2     | 110 ++++
 tests/qemu-iotests/tests/zoned-qcow2.out |  87 +++
 8 files changed, 1041 insertions(+), 15 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.40.1


