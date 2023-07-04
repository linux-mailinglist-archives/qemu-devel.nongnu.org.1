Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D27747278
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:16:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGftC-0006xb-OI; Tue, 04 Jul 2023 09:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qGbUe-0008Md-AK; Tue, 04 Jul 2023 04:34:40 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qGbUb-0006rs-B2; Tue, 04 Jul 2023 04:34:39 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b7e1875cc1so30201535ad.1; 
 Tue, 04 Jul 2023 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688459674; x=1691051674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JxdDCc6HdBD2ooMfss3EhVWf921bsW4ykEC0D25WTns=;
 b=qcbL2dJStUTMvAgCXDbktfL1LSD0bHMa6f2V/QaYpP1SURu3xFmE9xb2QU6TJI1OIU
 naL2t6f9cTfIr+ze5YXCuYUAnB75sj8YuVbRHxL148ctvh/bcIXq70GZgUANcfXfJVBV
 Mcv/WoRJPw5BQTTAcQA3x9YGh8/hQM3vbi7XoYLoD9rJpVvkkt5KA/JdelbNpoL409iv
 xzqTiCaqWDVG4a6CKTlgE11CUUSFouhmaLA1V/4tEGLDg5AUcgQSkJmaZ+buoa7jRMs9
 pi/bMtFMwFig5CUjBuZ+D6o/fVjhK8D0Cb4otb5CcE8OEaxzlLrHxspki+umBhWHQ+MR
 UniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688459674; x=1691051674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JxdDCc6HdBD2ooMfss3EhVWf921bsW4ykEC0D25WTns=;
 b=KJ8zlzBVRsQESv2RNiAqhhfTekiDUvx0sfgAtWVYPmW0Si528C6OjCY9zJjJmI5xs5
 ijP+E7z/D1TYLhYOG4B4XRhpqr2rjuP80WQjyxHmf1u7eMjqbULvO/yTIcx/6W0CDEE1
 LOKHznKSzREPAss6Glykg86tqhFcIJhGT/D1KEEEHWT7/1VfMCEsqVk21CoBYagUXBoT
 GX4pELVbmebq3E8iP2ojQ+xXQfguPcFJa2K+JH/3JXS/MaHGvrRdqdoaFigB9e7cIdZ7
 zIqGzC9V2rE1jMjQZcXONOKcnNy77nGO+U3ktPGxYmegBG/tpHtdRpluRHuWcNZIqxOO
 ExFQ==
X-Gm-Message-State: ABy/qLZ6j75g4Enyf3SLioMxBdC7DqiCWsNREjDIHmEGTlFIommSGZSa
 fQSNgfxDNRcozlJhAr+TfXrsPlgAC8brpg==
X-Google-Smtp-Source: APBJJlGaw/dSnfzU9Jq87WmZf3mYP7OfJbtmhtakSFKJ21TgJZ9Hj0sFSBZ0oXgGi5LRUQHcnZUwnQ==
X-Received: by 2002:a17:902:ce84:b0:1b8:7625:3042 with SMTP id
 f4-20020a170902ce8400b001b876253042mr7582194plg.10.1688459674681; 
 Tue, 04 Jul 2023 01:34:34 -0700 (PDT)
Received: from localhost.localdomain ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 jg10-20020a17090326ca00b001b7fabe8b0asm14943527plb.2.2023.07.04.01.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 01:34:34 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, hreitz@redhat.com, k.jensen@samsung.com, kwolf@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com, Jeuk Kim <jeuk20.kim@gmail.com>
Subject: [PATCH v4 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
Date: Tue,  4 Jul 2023 17:33:56 +0900
Message-Id: <cover.1688459061.git.jeuk20.kim@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Jul 2023 09:16:13 -0400
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

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
 hw/ufs/lu.c              | 1441 +++++++++++++++++++++++++++++++++++
 hw/ufs/meson.build       |    1 +
 hw/ufs/trace-events      |   59 ++
 hw/ufs/trace.h           |    1 +
 hw/ufs/ufs.c             | 1545 ++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h             |  131 ++++
 include/block/ufs.h      | 1048 ++++++++++++++++++++++++++
 include/hw/pci/pci.h     |    1 +
 include/hw/pci/pci_ids.h |    1 +
 include/scsi/constants.h |    1 +
 meson.build              |    1 +
 16 files changed, 4244 insertions(+)
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


