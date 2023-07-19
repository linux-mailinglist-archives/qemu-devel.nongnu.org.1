Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3357758B6D
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 04:41:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLx6t-0005wd-R0; Tue, 18 Jul 2023 22:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qLx6p-0005wJ-J6; Tue, 18 Jul 2023 22:40:14 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qLx6n-0004KT-Kn; Tue, 18 Jul 2023 22:40:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bb119be881so44236085ad.3; 
 Tue, 18 Jul 2023 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689734406; x=1692326406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PrMM08HDdLfQiEN1FY78BsICjtGdeIp0DngDVA98E5Y=;
 b=hx9TmiyS6jclv0+DNPCYvj4eX7s3fcrpp+f905M9u4A4GV/72Vjh5lXiYB7WW/NfE7
 dVd27rDhGmW0Lyf75cTpjN4e++fywBkKZ2lKpyH0lZnJzw3h8RxvTDO5ZP3d8KorpT5P
 yCKaJzZu9lBsxfrCdFs72Ckr9V0UKI4wtO7cSaVwhja9PBA4y2nB/iiCc59vn3+gtTs4
 4u7Ishy6CX4EIRh+hcaQz+4ZCq/PW/IbCjNp6pAC4YKiH9fakhJWXLpgBvIxRKrp2cOq
 YIFrPBHCpBHe9HXjRtnH7Kb5MvL8zSSIm40HzOZzjIhfL+3xHTJIiolLSLhKiyDfMWFS
 o6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689734406; x=1692326406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PrMM08HDdLfQiEN1FY78BsICjtGdeIp0DngDVA98E5Y=;
 b=RCWWfBy0J2dsycF2ZTKi1eOvC6uW3lQhD0w3vh2EcYe2qPjWtXplcmFP/RlGunwkk3
 TBvsqT1BGPbORoBOo6PmXg4/aeC85TF7Bi+DAtPEvutV+dVKY/QYkSEwMIXMef2opBmR
 tAS3QR8Su+8vHkK/tQ+aS417STWkPZJUC51SbLIOxhqfnNyuEVh4vulwrK3g6SIwhTkD
 N9etksIJfUieOjH/DosrYsvP/73A2I+x7gpZKlQIRgizCWyyFNpZ1vvJsZPr96sxgmSx
 CTUrcwf4Rm3p0GbICJ167wKb8xfS4Tz4OYtHo0dBf/WQfXC1dDhUiCelVt9cuQoF1U1U
 52nA==
X-Gm-Message-State: ABy/qLYwbjGdLg/3HpzkxuqA+JALNf50DmuP5qYLpplF4YQO2mSF89zZ
 sKQxlRlti8MAUQF4gnhMs5VKmldugirPJg==
X-Google-Smtp-Source: APBJJlESuO8F3GXjQIec1qDVmkqtdZTLd1deRpjDA/ewnV6IPhUrn5/cAFs/lyTZ2DUIW46WIN63WQ==
X-Received: by 2002:a17:902:9a83:b0:1b8:b285:ec96 with SMTP id
 w3-20020a1709029a8300b001b8b285ec96mr15062500plp.23.1689734406526; 
 Tue, 18 Jul 2023 19:40:06 -0700 (PDT)
Received: from localhost.localdomain ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a170902bcc100b001a183ade911sm2579037pls.56.2023.07.18.19.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 19:40:06 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, hreitz@redhat.com, k.jensen@samsung.com, kwolf@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com, Jeuk Kim <jeuk20.kim@gmail.com>
Subject: [PATCH v5 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
Date: Wed, 19 Jul 2023 11:39:42 +0900
Message-Id: <cover.1689731819.git.jeuk20.kim@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x633.google.com
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


