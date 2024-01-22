Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9883719E
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:02:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzX6-0005d7-8E; Mon, 22 Jan 2024 14:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX3-0005ZZ-Pt; Mon, 22 Jan 2024 14:00:29 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX0-00023Z-OM; Mon, 22 Jan 2024 14:00:29 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e67e37661so4805153e87.0; 
 Mon, 22 Jan 2024 11:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705950023; x=1706554823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D+gJv0gQQxHsTc+J4PVKiHUv4H+4beTI8KPdWlmhLm0=;
 b=WnqRxjFsWkS8kEK53iS60kcUpZmrEaeHcULMn8R3xRr7IWMFsYuvMnglcl+7YKBUOh
 FVZz7Mfj0oQjfuUk9hqy1VrFh0QZ1PQLdhPsMq9JAi2kkC5NhUe8Emqs30ZwE4ucdGfB
 S8xcJeke8hjOtrf6+8O+06Yn++/X4Cayuc243tmUULI5hEaSUYytYNdvj9G2Gau3r99F
 FAExUwMElC2Sgdkj8kYc5J6Ke5+QVlw2tZGfAOIJG7cBzq8FR1JciaOIezEpKUciWr60
 qNRdi3LEn4t8sjjjmdezrNJGfeDc0o0cKNLZSMWSi5j45S+wG8e1+L+yn7tAtOd3vjH6
 FWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705950023; x=1706554823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D+gJv0gQQxHsTc+J4PVKiHUv4H+4beTI8KPdWlmhLm0=;
 b=ndwOmHIfQxeynJDiewGY5Jbi/AS94aS8VMqBv46U08x9UJSztAwYhdnxcjnphl5ld0
 5tAS5jYti4j0GRIyFyEVSs6C32jKOyC1TRT29DDOj+5UyFpcL5uEApD8WTDnbcdjLQhA
 jhsTOSfhFNZ87awXrd8fO7HPorAClmj/wNCqgpnckfwGwwdjFuVVL5RN8C2IJJn7euK3
 k+RLNbgXxdmrruzRZzpa7bmLcnoUMQN+ajTMQm/ePQN9etbqnpvcusEKN39T/Nm2lLYt
 ibrGTe1z74Zn4GwN5CurDDUsrj4e/SzjVly09FzjHaIAXmi1kTqkQ4HtmclQfOpuUI5/
 kTuw==
X-Gm-Message-State: AOJu0YwYP0FXuuNNilHtoZqkr3QIVofLYyHoHWfD/1MOxPPtOFYQfkN9
 ZYcoFOEZ/Qzcwwaxw6r80y0JB2cR8g9uBTC+7z/UptwrUAO3UX05pzYTOcfB8+U=
X-Google-Smtp-Source: AGHT+IFYv5G+avIQR14NApgO/ti3ZXC9gXWBGGU3EZYkI9eSJF04ZQXg4xVqZdY/7Oky5yv+A+wzsw==
X-Received: by 2002:a19:f516:0:b0:50e:9356:86e1 with SMTP id
 j22-20020a19f516000000b0050e935686e1mr1875346lfb.69.1705950022819; 
 Mon, 22 Jan 2024 11:00:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:367:1500:fa08:d4d:b569:ac2d])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a170906a38300b00a298d735a1bsm13842413ejz.149.2024.01.22.11.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 11:00:22 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 dmitry.fomichev@wdc.com, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [RFC v3 0/7] Add persistence to NVMe ZNS emulation
Date: Mon, 22 Jan 2024 20:00:06 +0100
Message-Id: <20240122190013.41302-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x136.google.com
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
- adding full zoned storage emulation to qcow2 driver [v7]

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

For a closer look, you can apply the zns patches on this branch:
https://github.com/sgzerolc/qemu/tree/dev-qcow2-v7
Or use the local zns branch directly:
https://github.com/sgzerolc/qemu/tree/dev-zns-v7

To attach this file as emulated zns drive in the command line of QEMU, use:
  -drive file=${znsimg},id=nvmezns0,format=qcow2,if=none \
  -device nvme-ns,drive=nvmezns0,bus=nvme0,nsid=1,uuid=xxx \

Acked-by: Klaus Jensen <k.jensen@samsung.com>

---

v2->v3:
- fix compatability issue with the qcow2 patch series [Markus]
- address review comments [Markus]

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
 block/qcow2.c                     |  120 ++-
 block/qcow2.h                     |    2 +
 docs/interop/qcow2.txt            |    9 +
 hw/nvme/ctrl.c                    | 1246 ++++++++---------------------
 hw/nvme/ns.c                      |  162 +---
 hw/nvme/nvme.h                    |   95 +--
 include/block/block-common.h      |    9 +
 include/block/block_int-common.h  |    8 +
 include/sysemu/block-backend-io.h |   11 +
 include/sysemu/dma.h              |    3 +
 qapi/block-core.json              |    4 +
 system/dma-helpers.c              |   17 +
 13 files changed, 648 insertions(+), 1126 deletions(-)

-- 
2.40.1


