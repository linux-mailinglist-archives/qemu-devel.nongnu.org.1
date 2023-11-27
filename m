Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5277F9BC4
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 09:35:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7X3s-0005qT-Ii; Mon, 27 Nov 2023 03:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7X3q-0005pk-Rt; Mon, 27 Nov 2023 03:33:46 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7X3p-0004lA-5w; Mon, 27 Nov 2023 03:33:46 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6cbda959062so3296061b3a.1; 
 Mon, 27 Nov 2023 00:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701074022; x=1701678822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0OPlID0+e6r5ZfIOS9VPEAJD9fHXZYKk+VSXVpCZmv4=;
 b=aLTXSMvRTJi7GVl7Zkez0GHvCAh+F348gbyonA4B0yBDRUFVQh+wXWZ7lSmpETIo7O
 WRAuWcNok1XRAET0NdgeZw+plUBIB8WR0oMTzcAuBCEyHcrmT952pzBaDKZxQHnul9st
 xikNqILfnVtceICDFzwJA38xkTu4ndKSadOA7gFg/9/9HEhvaD6vXBiQROltL5oeqe99
 6CDSZXLsXCgwSANhtsbdytYSQSs8Ki9EN+rUKGrYnvz/+3kK1BkmJtMvjDYrskTw2aYU
 jgWkTKSR3MqRjXe0l1mrVoDKcZ6GRZR0H1uu+1Pu8ACDS1Zj4O4hNBKP6H1Yw0o7H5LT
 wNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701074022; x=1701678822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0OPlID0+e6r5ZfIOS9VPEAJD9fHXZYKk+VSXVpCZmv4=;
 b=p4OVLymBI41Wd8H4qnJNRlD2/S1fkhDfWGCIQdSqJ79XHOiA4q8bi7IFTLxDWJ777c
 HQmflBxTkby058T+EUlVBPqUH2APjIURBGwDHc+2AyNC7mTrlD6WuhjHrifCiVdD35hx
 N95oRHRb+dIk4dfFfL3eXcc2N6EYbRCGhpcUVXDdr0tOresOxinTuc0BfuR0eCG1r1V1
 dx7H5IujbhtSQScuVbxxd2qR5xu3OU4gtfJ8wjUGB1t6eellH22ChAnLLRBOAFTGgTkG
 P5ydmgw6G/L8VJydN3crGhuV+HTEQxXX3RG96F2aPTePHxp4WdCnLqgwlYCcaY1+CvC1
 6f2Q==
X-Gm-Message-State: AOJu0Yyj0s3VWS8N0lBq9VacBzm+mXeOGODQnn+ut8bFKLnUXIZEgPur
 WrtL4xfL6MXDmOaWaq3ZFoft8nt3eiW3vQ==
X-Google-Smtp-Source: AGHT+IE3ioMwhr9+GJZQP0CFaUIapwoLSM9O1cDwA8JZhV7mwGrTg5FiVfYxpSWjt2W/a2CFadBZtw==
X-Received: by 2002:a05:6a00:b49:b0:6cb:7025:9930 with SMTP id
 p9-20020a056a000b4900b006cb70259930mr11574962pfo.8.1701074021725; 
 Mon, 27 Nov 2023 00:33:41 -0800 (PST)
Received: from fedlinux.. ([106.84.128.244]) by smtp.gmail.com with ESMTPSA id
 a6-20020aa780c6000000b006c5da6411b9sm6701660pfn.101.2023.11.27.00.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 00:33:41 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org, dlemoal@kernel.org, Hanna Reitz <hreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, stefanha@redhat.com, hare@suse.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, dmitry.fomichev@wdc.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [RFC v2 0/7] Add persistence to NVMe ZNS emulation
Date: Mon, 27 Nov 2023 16:33:07 +0800
Message-Id: <20231127083314.75844-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x42d.google.com
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

ZNS emulation follows NVMe ZNS spec but the state of namespace
zones does not persist accross restarts of QEMU. This patch makes the
metadata of ZNS emulation persistent by using new block layer APIs and
the qcow2 img as backing file. It is the second part after the patches
- adding full zoned storage emulation to qcow2 driver.
https://patchwork.kernel.org/project/qemu-devel/cover/20231127043703.49489-1-faithilikerun@gmail.com/

The metadata of ZNS emulation divides into two parts, zone metadata and
zone descriptor extension data. The zone metadata is composed of zone
states, zone type, wp and zone attributes. The zone information can be
stored at an uint64_t wp to save space and easy access. The structure of
wp of each zone is as follows:
|0000(4)| zone type (1)| zone attr (8)| wp (51) ||

The zone descriptor extension data is relatively small comparing to the
overall size therefore we adopt the option that store zded of all zones
in an array regardless of the valid bit set.

Creating a zns format qcow2 image file adds one more option zd_extension_size
to zoned device configurations.

To attach this file as emulated zns drive in the command line of QEMU, use:
  -drive file=${znsimg},id=nvmezns0,format=qcow2,if=none \
  -device nvme-ns,drive=nvmezns0,bus=nvme0,nsid=1,uuid=xxx \

v1->v2:
- split [v1 2/5] patch to three (doc, config, block layer API)
- adapt qcow2 v6

Sam Li (7):
  docs/qcow2: add zd_extension_size option to the zoned format feature
  qcow2: add zd_extension configurations to zoned metadata
  hw/nvme: use blk_get_*() to access zone info in the block layer
  hw/nvme: add blk_get_zone_extension to access zd_extensions
  hw/nvme: make the metadata of ZNS emulation persistent
  hw/nvme: refactor zone append write using block layer APIs
  hw/nvme: make ZDED persistent

 block/block-backend.c             |   88 ++
 block/qcow2.c                     |  119 ++-
 block/qcow2.h                     |    2 +
 docs/interop/qcow2.txt            |    3 +
 hw/nvme/ctrl.c                    | 1247 ++++++++---------------------
 hw/nvme/ns.c                      |  162 +---
 hw/nvme/nvme.h                    |   95 +--
 include/block/block-common.h      |    9 +
 include/block/block_int-common.h  |    8 +
 include/sysemu/block-backend-io.h |   11 +
 include/sysemu/dma.h              |    3 +
 qapi/block-core.json              |    4 +
 system/dma-helpers.c              |   17 +
 13 files changed, 647 insertions(+), 1121 deletions(-)

-- 
2.40.1


