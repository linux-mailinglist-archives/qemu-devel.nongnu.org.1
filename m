Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F28248370B1
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 19:49:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzLx-00084i-Gh; Mon, 22 Jan 2024 13:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzLk-000849-0M; Mon, 22 Jan 2024 13:48:49 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzLh-0007sB-V5; Mon, 22 Jan 2024 13:48:47 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a349cf29cso4004875a12.0; 
 Mon, 22 Jan 2024 10:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705949321; x=1706554121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ElsHSHK2gmIsRVWyBMaYb/nkitCXO7t+PuaLRo8lkA=;
 b=hlS6VBkit6Yjwr+rJUDusaoBnMFNe3IZ3zSDiwhJXN2jbWICWxCJAe3C3WMFBIZCze
 rxJ7+2eEgM/RnKuMkeYrdasEEaXHi8OUwMYFWAFxNU8V2MufnWBjY89OzTeAHF4lXeB6
 wmB2PRYPSq5mdP3H2gjQNwLSes4gzbqI2Qy3lO50NLk+R9e45wMpTNbJjTkPGKhEiHT+
 NdsJR/Jv/yv+Kb4I1ZsdudELgjLgyMrtFNTzUbhd2EK9StKhnrXvSFtwFUreXrPznVWh
 UNTIgJzkEnmQ+l4gxXP02xFSiFyMEviHQ5tb7iG9fjkb+jneItybfDOXgA3Sj9ljUeO0
 7rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705949321; x=1706554121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ElsHSHK2gmIsRVWyBMaYb/nkitCXO7t+PuaLRo8lkA=;
 b=GmzVqcLLYByUnXMM3fkVJKXWH/48QxzcFlP7eLanWSaca/4Kwcq9qswAam/IdA7WOi
 5yF/3U/quS6r1hc9nHrLKOyFi8da/Z+08BjL2YVyy4OQEynqc0bsnfEVpHjDVNMTu1jv
 vi4yZofOKk5UtDCS/gK06lKk4pCgUKmt9STa+5H74CY5yC5WdnKbLnYwmjeVWeC9pJMx
 lx+DDSxroZN91zeKw1rB71RHCxRFRRasOW6k7AC8+vaY1yYMGw1rWKslLXH6WxQFdNHf
 sMH+SlaUjnRWO65qMy1M9gKDQdu4TZdNo+3Cb/PSZy0vJ5vQ7xIiuiQNGvMdPdPDMW2N
 L1aA==
X-Gm-Message-State: AOJu0YylSiz2Syj2RIuOssC4ZboybMhktH7Mi78iaeY0v69xdJLMX6i2
 tzcxHmsThAqidMjAY8z3AyRO8hx5WO8K8+Cp10iO1JZRo+4Ep7zzsJkEcGA15ps=
X-Google-Smtp-Source: AGHT+IF/9+KWy7nb7duxAb2T5+pVgnhu1tiV1z0kCx3UUUgTzC8MaUR7i7fcb8rS83ZHyk3+q1UNOQ==
X-Received: by 2002:a17:907:cb87:b0:a27:f6aa:c7b0 with SMTP id
 un7-20020a170907cb8700b00a27f6aac7b0mr2987969ejc.11.1705949320547; 
 Mon, 22 Jan 2024 10:48:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:367:1500:fa08:d4d:b569:ac2d])
 by smtp.gmail.com with ESMTPSA id
 en4-20020a17090728c400b00a282c5a3143sm13686908ejc.88.2024.01.22.10.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 10:48:40 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v7 0/4] Add full zoned storage emulation to qcow2 driver
Date: Mon, 22 Jan 2024 19:48:26 +0100
Message-Id: <20240122184830.40094-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x533.google.com
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

To create a qcow2 file with zoned format, use command like this:

Then add it to the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,file.driver=file,file.filename=../qemu/test.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

v6->v7:
- modify zone resource managemant (style) [Damien]
- fix accessing list with negative index err
- add some tests for zrm in iotests
- address review comments [Markus]

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

 block/qcow2.c                            | 1041 +++++++++++++++++++++-
 block/qcow2.h                            |   36 +-
 block/trace-events                       |    2 +
 docs/interop/qcow2.txt                   |  107 ++-
 docs/system/qemu-block-drivers.rst.inc   |   42 +
 include/block/block_int-common.h         |   13 +
 include/qemu/queue.h                     |    1 +
 qapi/block-core.json                     |   67 +-
 tests/qemu-iotests/tests/zoned-qcow2     |  147 +++
 tests/qemu-iotests/tests/zoned-qcow2.out |  172 ++++
 10 files changed, 1621 insertions(+), 7 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.40.1


