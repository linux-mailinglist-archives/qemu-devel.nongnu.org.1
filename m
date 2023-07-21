Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6925075BB9E
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 02:48:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMeIa-0004z1-Df; Thu, 20 Jul 2023 20:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qMeIY-0004yZ-CH; Thu, 20 Jul 2023 20:47:10 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qMeIW-0000KR-Mr; Thu, 20 Jul 2023 20:47:10 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6687096c6ddso960639b3a.0; 
 Thu, 20 Jul 2023 17:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689900426; x=1690505226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UMBilFCGQrK6uNwTsoqXYG0SEde5dF3nd7ZTlTriQes=;
 b=CAH00ex75hhzHI+gXMk3RulpFpLOTXgvPHRzOulr/oEkLakuN4wVH5OBXsrdXQWD1E
 AQ6MzCkW4PM7Fnfk5d3m697KwxjCMUa/SHGz+yqK7Bg3kODL2zfWAQ/gLHGVUxkB/MsL
 1OJNn68tDm8vMPloZB96pQluX+Jc95x6t04ZcOrkBd+puKIljWqEXZntuSjfovqQdsKT
 GDheXgACB9R0YFu6dzBetKCipeT4FkxYPT1yAZeav32fThBtUSxUlL2eKmbRhyL5G4OH
 u9GeYLhcubG98RrPqoTgnxb4sviwnPS3m375HYOmxrykwgXeNPyYS97VAP3I9zzkcZi0
 Oh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689900426; x=1690505226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UMBilFCGQrK6uNwTsoqXYG0SEde5dF3nd7ZTlTriQes=;
 b=Ae4uXfdZPvRzEH8Z9zR6+WCms5KD2sasu/ckJzazQh7Y4GSTz6vqh0m2dCEdgRpFtZ
 noTrs9FHOXZ9WyGLNgOuwp8Az9q9rv7ijDQcj+h+/gBf376LSSl9Ivg/Sm93rydZNkje
 ++f+9Eewn1Hnt4H7ZMFz037q1BcG7rNPypU6GicILlotLTbyeNzdPQ+9eaQubimBSIzc
 m5UEBAE94Mr951TKbDRfyU4At8SfPQH/1YM4932u3hhs4ul02W5d50g3KNghW3a/Vrkr
 j1UhiEuB8oABNdMnypHYj7UUBcADnObo/lCy4mDy9dwoifB1/ecqdxkJvUBmHnr0mNkS
 XS6A==
X-Gm-Message-State: ABy/qLbWtsk8QVyQmBm13T8n4WwKEd78L7kwQyifi+lJBvqlG9MpsaOS
 72rixg0iuKgYWrcOc6IOMAW2DHVnqM6sMA==
X-Google-Smtp-Source: APBJJlEnBMJbmUzsw4STMb36KUfB5/t8zeQGZvzo4zjO/yk9MYkIDYERfDXJRhui5NEGrbyig7xfIw==
X-Received: by 2002:a05:6a00:2290:b0:686:25fe:d575 with SMTP id
 f16-20020a056a00229000b0068625fed575mr453042pfe.11.1689900426279; 
 Thu, 20 Jul 2023 17:47:06 -0700 (PDT)
Received: from localhost.localdomain ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 g8-20020aa78748000000b00668738796b6sm1782240pfo.52.2023.07.20.17.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 17:47:05 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, hreitz@redhat.com, k.jensen@samsung.com, kwolf@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com, Jeuk Kim <jeuk20.kim@samsung.com>
Subject: [PATCH v6 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
Date: Fri, 21 Jul 2023 09:46:31 +0900
Message-Id: <cover.1689899435.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42c.google.com
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


Jeuk Kim (3):
  hw/ufs: Initial commit for emulated Universal-Flash-Storage
  hw/ufs: Support for Query Transfer Requests
  hw/ufs: Support for UFS logical unit

 MAINTAINERS              |    6 +
 docs/specs/pci-ids.rst   |    2 +
 hw/Kconfig               |    1 +
 hw/meson.build           |    1 +
 hw/ufs/Kconfig           |    4 +
 hw/ufs/lu.c              | 1439 ++++++++++++++++++++++++++++++++++++
 hw/ufs/meson.build       |    1 +
 hw/ufs/trace-events      |   58 ++
 hw/ufs/trace.h           |    1 +
 hw/ufs/ufs.c             | 1494 ++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h             |  131 ++++
 include/block/ufs.h      | 1048 ++++++++++++++++++++++++++
 include/hw/pci/pci.h     |    1 +
 include/hw/pci/pci_ids.h |    1 +
 include/scsi/constants.h |    1 +
 meson.build              |    1 +
 16 files changed, 4190 insertions(+)
 create mode 100644 hw/ufs/Kconfig
 create mode 100644 hw/ufs/lu.c
 create mode 100644 hw/ufs/meson.build
 create mode 100644 hw/ufs/trace-events
 create mode 100644 hw/ufs/trace.h
 create mode 100644 hw/ufs/ufs.c
 create mode 100644 hw/ufs/ufs.h
 create mode 100644 include/block/ufs.h

-- 
2.34.1


