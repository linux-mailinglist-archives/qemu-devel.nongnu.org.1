Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1B762AD6
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 07:33:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOX7n-0008F3-9n; Wed, 26 Jul 2023 01:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qOX7j-0008El-3a; Wed, 26 Jul 2023 01:31:47 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qOX7h-0007xv-EE; Wed, 26 Jul 2023 01:31:46 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b8b2b60731so34057375ad.2; 
 Tue, 25 Jul 2023 22:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690349502; x=1690954302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lyRT4uTkufJ5L0rblkeJc580yPfR6jqxrzm+8+rnSSY=;
 b=ROLLBAjhRcUAkxrQBFYvcc44i+p0xjdnSU/+iP02tOsrPuPOsHBLMszY07+cst7QD8
 VoSj8Q9EbYgKD3wE5PLZ8p2JlfTumv7kKuk8MBrzaI0ADcEwZ1h+gFuEXU2T18LnkXrP
 ynen2XOXJipUrKwoDEAQxQXO7thBBrRlXQL963QrGzW8hJiQlRfb88UubCFiziAu/V3K
 jsp2CVpwTFiSMAg6NvLkN+zta+ZPENLXx4MwGwNnwmVsvsBGk5fFVq6nDmjXXzQnmzUh
 e4ZWtT8sF/g6DaV2dtPX0cAhbbAg+f28A6+eLtQKnFrYa7wedzdiJW48gRUKj3EESkIr
 8pGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690349502; x=1690954302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lyRT4uTkufJ5L0rblkeJc580yPfR6jqxrzm+8+rnSSY=;
 b=VQBnCNc02qlVhQvAYJnQyRugG94vP8L1x2e7xKAWD8zJnPgcfhPQtIgAVny/ju4qQh
 f1G0pvV86+TF5sZ5LWWyPjJTRLUO0HUJZ2bs+eJ0wAFgqjb3y95DwuCPQI1pq/8mwcxx
 F6IUOuNGCKGR7Yo/X3qZxSw2qx0Z6xckIAQiLiPvLRmpBkVsu8ll40KX/GStsGo5a0mh
 P9jtqN1XeoKfHoqbH3qKRPKn4srQWXjO9j1bNcuPVUrd4dmdhuyK65zGrqLL1nUU5QNx
 dYbnmT1LIsriCtyfv+/r9G6pgO407PRuj3rkUq2UUPLMdrb2U1bGIdAZZp/qXY8oo2Ti
 p1mA==
X-Gm-Message-State: ABy/qLbAYahKrQzuHGH4B++iaB0jzeVm5BzVIHOLkIQMSmLGPQwQYv/7
 WQq58brK6cmYxqcGsJnMaCUYXmFSQpP3Zw==
X-Google-Smtp-Source: APBJJlGI521iBDwTWIvhZc3eIhoxbbHrIcRiESuxyPHYXzaTAdNXVms123zkorv2bUEZjNErYZCjhA==
X-Received: by 2002:a17:903:22c9:b0:1b9:e1d6:7c7d with SMTP id
 y9-20020a17090322c900b001b9e1d67c7dmr977098plg.47.1690349502520; 
 Tue, 25 Jul 2023 22:31:42 -0700 (PDT)
Received: from localhost.localdomain ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a170902b09100b001b8c689060dsm12016349plr.28.2023.07.25.22.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 22:31:42 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, hreitz@redhat.com, k.jensen@samsung.com, kwolf@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com, lvivier@redhat.com, jeuk20.kim@samsung.com
Subject: [PATCH v7 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
Date: Wed, 26 Jul 2023 14:30:49 +0900
Message-Id: <cover.1690348453.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x634.google.com
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

Since v6:
- Add tests/qtest/ufs-test.c to test ufs initialisation and I/O
- Add struct UtpTaskReqDesc to include/block/ufs.h
- Fix ufs_log2() logic
- Fix ufs-lu to use 4K as default block size to match the ufs spec

Since I created a new file, tests/qtest/ufs-test.c, I added Laurent Vivier to the cc list.
Thank you.

Since v5:
- Fix to print an error message instead of a segmentation fault
  when no drive property is specified for a ufs-lu device

Since v4:
Addressed review comment from Stefan Hajnoczi. The fixes are as
follows.
- Keep u->reg fields in host endian (Removed little-endian helper 
  functions from MemoryRegionOps)
- Remove unnecessary NULL checks for g_new and g_malloc0
- Replace DEFINE_PROP_DRIVE_IOTHREAD -> DEFINE_PROP_DRIVE

In case you were wondering, ufs and ufs-lu have been tested for the
following behaviours.
1. Checked ufs device recognition in Windows10 environment
2. Verified ufs device recognition in Ubuntu 22.04 environment
3. Verified io behaviour via fio in Ubuntu 22.04 environment
4. Verified query request via ufs-tools in Ubuntu 22.04 environment

Since v3:
- Replace softmmu_ss -> system_ss in meson

Since v2:
Addressed review comment from Stefan Hajnoczi. The main fixes are as
follows.
- Use of SPDX licence identifiers
- fixed endianness error
- removed memory leak
- fixed DMA error handling logic

Since v1:
- use macros of "hw/registerfields.h" (Addressed Philippe's review
  comments)

This patch series adds support for a new PCI-based UFS device.

The UFS pci device id (PCI_DEVICE_ID_REDHAT_UFS) is not registered
in the Linux kernel yet, so it does not work right away, but I confirmed
that it works with Linux when the UFS pci device id is registered.

I have also verified that it works with Windows 10.

Jeuk Kim (4):
  hw/ufs: Initial commit for emulated Universal-Flash-Storage
  hw/ufs: Support for Query Transfer Requests
  hw/ufs: Support for UFS logical unit
  tests/qtest: Introduce tests for UFS

 MAINTAINERS              |    7 +
 docs/specs/pci-ids.rst   |    2 +
 hw/Kconfig               |    1 +
 hw/meson.build           |    1 +
 hw/ufs/Kconfig           |    4 +
 hw/ufs/lu.c              | 1445 ++++++++++++++++++++++++++++++++++++
 hw/ufs/meson.build       |    1 +
 hw/ufs/trace-events      |   58 ++
 hw/ufs/trace.h           |    1 +
 hw/ufs/ufs.c             | 1494 ++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h             |  131 ++++
 include/block/ufs.h      | 1090 +++++++++++++++++++++++++++
 include/hw/pci/pci.h     |    1 +
 include/hw/pci/pci_ids.h |    1 +
 include/scsi/constants.h |    1 +
 meson.build              |    1 +
 tests/qtest/meson.build  |    1 +
 tests/qtest/ufs-test.c   |  575 +++++++++++++++
 18 files changed, 4815 insertions(+)
 create mode 100644 hw/ufs/Kconfig
 create mode 100644 hw/ufs/lu.c
 create mode 100644 hw/ufs/meson.build
 create mode 100644 hw/ufs/trace-events
 create mode 100644 hw/ufs/trace.h
 create mode 100644 hw/ufs/ufs.c
 create mode 100644 hw/ufs/ufs.h
 create mode 100644 include/block/ufs.h
 create mode 100644 tests/qtest/ufs-test.c

-- 
2.34.1


