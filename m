Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18037764E4D
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 10:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOwde-0007M9-0H; Thu, 27 Jul 2023 04:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qOwdI-0007J6-9X; Thu, 27 Jul 2023 04:46:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qOwdD-0005nQ-Qm; Thu, 27 Jul 2023 04:46:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b8c81e36c0so4365885ad.0; 
 Thu, 27 Jul 2023 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690447553; x=1691052353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6QkbFIUYi87d/IqeHjR9YCpsuUiKiuvSBn2H/fptwKI=;
 b=L58I/CA5ETjX2eX1Hp6mu1DsjzK/b8xKTqPEBKpA/NJQa+T2fptW9f9yv6oq3RQU2b
 jVD+bfRWmHKTfEsxhbI0uFr2ruaP6iQfsJf2CU7p8vwvyUAWlqI9ujeUZL7OfDTQqNPE
 OCr7tZlvmGtZ+op5Du7em/IyT+VP3eTQKeVYcUYQ1+q1IqvZp6Uu6Id27LWXk12p6AoO
 8+LWeQiSqN46KhpeXlrLg1uzZiyoTzb+FMbB++KKoYzfId0iOkMebqrqUfxJttHRSAxv
 gl+KdNhrB/OHfSx1gFs96gAlQTIEAVWJoYl/Sa8HEHFMZHn0tpZmMO7Y+W2KIG/X5Tju
 s+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690447553; x=1691052353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6QkbFIUYi87d/IqeHjR9YCpsuUiKiuvSBn2H/fptwKI=;
 b=WO2WQZpl322bDN8MLGj/TcnJZMpcj9VhKdFCOXhWHcawJYVcJfv2fVb2w+lsOQRrwP
 /yAclhyNoMa33O7DaMTLNPSHT4dJUPS0NQCyo7Y35plKURLC/e8Zn+Aioc522f2WlvGA
 /T8U+OH+n9UaPLKNteX10LcaZwgorr9+8HKEF9fcac3n1ZtpS398B9xPEGeinMYIqDAB
 B6aiwvCPsDzMNCwCXvFq5nI+yT6wpFuyAf9r0l7nEy+cHFIf2yHhGCZalO6AmnAFASQg
 DOroziqgEPPlagJ+KehorlZ3AKQxUSueyfQsz2vAeD6WO9DTMCTUSo3WSE6gPD294WQc
 xeBw==
X-Gm-Message-State: ABy/qLb+8WLPIb0Fn/7/4TOk2/YWYyuN0IJprmyNM/FDWdSxDEVex+mD
 ozj31UudAIQ/3GfNaTvyWlCE6alH7SEtQw==
X-Google-Smtp-Source: APBJJlFQM9tFAZbWMxb8nN9trM+UyfKwExwnpmF3LBcA9Zxx27rCrERzDnzZrBJlIFX0eiK2cUsmwQ==
X-Received: by 2002:a17:902:ea06:b0:1b8:a67f:1c0f with SMTP id
 s6-20020a170902ea0600b001b8a67f1c0fmr4551219plg.39.1690447553050; 
 Thu, 27 Jul 2023 01:45:53 -0700 (PDT)
Received: from localhost.localdomain ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a170902ed4400b001b7ffca7dbcsm1020451plb.148.2023.07.27.01.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 01:45:52 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, hreitz@redhat.com, k.jensen@samsung.com, kwolf@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com, lvivier@redhat.com, jeuk20.kim@samsung.com
Subject: [PATCH v8 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
Date: Thu, 27 Jul 2023 17:45:17 +0900
Message-Id: <cover.1690446561.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62b.google.com
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

Since v7:
In ufs-test.c, make the following changes
- Change TIMEOUT from 5 to 10 (Thomas's review comment)
- Rename the temporary file to "qemu-ufs.XXXX" (Thomas's review comment)
- Use "-blockdev" instead of "-drive" (Stefan's review comment)

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
 tests/qtest/ufs-test.c   |  573 +++++++++++++++
 18 files changed, 4813 insertions(+)
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


