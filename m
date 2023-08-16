Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB36D77DAA1
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 08:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWAIx-0000kB-0m; Wed, 16 Aug 2023 02:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWAIs-0000gl-Tc; Wed, 16 Aug 2023 02:46:50 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWAIp-00083t-Ni; Wed, 16 Aug 2023 02:46:50 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bda9207132so49016465ad.0; 
 Tue, 15 Aug 2023 23:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692168405; x=1692773205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EHKHaLOQ6zHwoB5ZzqIIAtLvoV1KhstU3zykBSVObaY=;
 b=sUeJ/9+gvg6xxNOIR0qaEwKPBtEMFYkIaoaoOn7xSe5G1fV/bDEhAOikYjQKLGte1y
 b0L8IQmZLcK1w/4RPyXqcwglv7U6BByYFKYdB4TPh1Zs/uw5K6Izrmb7v7dBWYAr49S4
 3xo1dWgjbr6VVjLBaqC2rYO8V7FP/VsTdt6r+fUBpcHqd6u93Lxih0UHT4hV8FW67/99
 g9JKTSjSyoIviZA/F/rZZW7WOd1cBLI3sCv/GvxJP1MaWs5jRBhP88k8wJh6K3dbeLYw
 HzWOyTu88YN+GmJfp/Zq90QDbYOK2wc+kX98shOwBmmang58P7BoF6OmC6znNQnvvRdY
 aP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692168405; x=1692773205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHKHaLOQ6zHwoB5ZzqIIAtLvoV1KhstU3zykBSVObaY=;
 b=gK/hbDrpNS5KbSJpV/J/hppggWlz94YVjdwHmlp+hSDf7Foz5sX1jF20Y/PwaHUfiY
 SjcldQVZ1Nd0rm279AXRLVtOJW96ncE9OxKMyUC9hCZ93Hy9Lv8x+ZJv/IjZ+xALXaRV
 UVIBbnFnKVxAnH0FEmreRxLdCWxZaJX3CFWiYi9DkQ7PlI8sjLcLjvH++WPRvvMA2HOq
 h1rwctTUlCVLevB+F91Swbc0Kgc4f8ulZUwHWRXuW0Beqa1HGG1FwFTQDeU14NtKjxYL
 6nEukP4I0zypq2Fy3lMqzcbieY0cDnHs8TEVzgpV+4nYxUkdEhfQI+3I4iG72axzYkKk
 GHdg==
X-Gm-Message-State: AOJu0Ywa/5L/Serp0IxEkEnRJ/E2kz93bHmLI7zzfm81pUyRwE3qBSg1
 QmQVNadu9AApDlrd4YL3TJ7/oXubLLT+ee9hi6I=
X-Google-Smtp-Source: AGHT+IHZibAjmb2yeJimSq1NZN1MN76nYK8c6zajUyWly+rcJMewYr2tE2nvPwasMO8e8tM1tTPhiw==
X-Received: by 2002:a17:903:1208:b0:1b6:6625:d3a8 with SMTP id
 l8-20020a170903120800b001b66625d3a8mr1489334plh.16.1692168404385; 
 Tue, 15 Aug 2023 23:46:44 -0700 (PDT)
Received: from fedlinux.. ([106.84.130.68]) by smtp.gmail.com with ESMTPSA id
 c6-20020a170902c1c600b001bee782a1desm1329363plc.181.2023.08.15.23.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 23:46:43 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 Eric Blake <eblake@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 dlemoal@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, hare@suse.de,
 qemu-block@nongnu.org, Sam Li <faithilikerun@gmail.com>
Subject: [RFC 0/5] Add persistence to NVMe ZNS emulation
Date: Wed, 16 Aug 2023 14:46:12 +0800
Message-Id: <20230816064617.3310-1-faithilikerun@gmail.com>
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

ZNS emulation follows NVMe ZNS spec but the state of namespace
zones does not persist accross restarts of QEMU. This patch makes the
metadata of ZNS emulation persistent by using new block layer APIs and
the qcow2 img as backing file. It is the second part after the patches
- adding full zoned storage emulation to qcow2 driver.

The metadata of ZNS emulation divides into two parts, zone metadata and
zone descriptor extension data. The zone metadata is composed of zone
states, zone type, wp and zone attributes. The zone information can be
stored at an uint64_t wp to save space and easy access. The structure of
wp of each zone is as follows:
|| zone state (4)| zone type (1)| zone attr (8)| wp (51) ||

The zone descriptor extension data is relatively small comparing to the
overall size therefore we adopt the option that store zded of all zones
in an array regardless of the valid bit set.

To create a zns format qcow2 image file, use:
$ ./build/qemu-img create -f qcow2 zns.qcow2 -o size=768M
-o zone_size=64M -o zone_capacity=64M -o zone_nr_conv=0
-o max_append_sectors=512 -o max_open_zones=0 -o
max_active_zones=0 -o zoned_profile=zns

To attach this file as emulated zns drive in the command line of QEMU, use:
  -drive file=${znsimg},id=nvmezns0,format=qcow2,if=none \
  -device nvme-ns,drive=nvmezns0,bus=nvme0,nsid=1,uuid=xxx \

Sam Li (5):
  hw/nvme: use blk_get_*() to access zone info in the block layer
  qcow2: add zone device metadata with zd_extension
  hw/nvme: make the metadata of ZNS emulation persistent
  hw/nvme: refactor zone append writes using block layer APIs
  hw/nvme: make ZDED persistent

 block/block-backend.c             |   94 +++
 block/qcow2.c                     |  160 +++-
 block/qcow2.h                     |    3 +
 docs/interop/qcow2.txt            |    2 +
 hw/nvme/ctrl.c                    | 1256 ++++++++---------------------
 hw/nvme/ns.c                      |  163 +---
 hw/nvme/nvme.h                    |   95 +--
 include/block/block-common.h      |    9 +
 include/block/block_int-common.h  |    8 +
 include/sysemu/block-backend-io.h |   12 +
 include/sysemu/dma.h              |    3 +
 qapi/block-core.json              |    3 +
 softmmu/dma-helpers.c             |   17 +
 13 files changed, 686 insertions(+), 1139 deletions(-)

-- 
2.40.1


