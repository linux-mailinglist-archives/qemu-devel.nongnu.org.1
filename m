Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEAD793687
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 09:46:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdnDI-0007F6-Lr; Wed, 06 Sep 2023 03:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qdnDG-0007Eo-Ur; Wed, 06 Sep 2023 03:44:34 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qdnDE-0004yS-DU; Wed, 06 Sep 2023 03:44:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-26d5970cd28so2152803a91.2; 
 Wed, 06 Sep 2023 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693986269; x=1694591069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uYe3JpGv3DS/leLTf38uiC88c/NzFFnw4a2ZbG+UeOI=;
 b=c2BPfxGi6vFTBtC9e3YsvPVR0kC/tUI2KkeCydPQhY2mMjdT2MC2yY0ddlxjDhVCFp
 tRskczdXu2JQdX1KZ+7IuRzS23sVCQuWFOr4cDDozXF594qiL9txXqkcfCXS/D7UIyjL
 N2Bhl3z5qu7ZI4GH60j/kLSZ1v+zA/YpH1NLDEMR4Mm7jcrqEICgW99FjA19HJHwYHvR
 SxmuggKNGT6gr/sr6KwKZERzBJEKVW8QKc66RaGCtEyTky0ixn/6jQqTko6XjUd+Ve7x
 ykBj3foKpXIRwCDWsLxlMRg+lG7921U5HdvQq7LHTzpRkBptMv0VBAl2if3BB8vq19PC
 Psrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693986269; x=1694591069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uYe3JpGv3DS/leLTf38uiC88c/NzFFnw4a2ZbG+UeOI=;
 b=XvLZDQr/AlxwL8+W9QHnrUC+RMXJNP83V6TMu38Q4hKhwvhwxYk5LCcRnFTDzDCftK
 JMdEtXmdUuFDnRpaEcze2i6ABMxQRKmUlnCBKfmZAA9Fu5LgFDqbc0OquE8JUE8m9PJx
 Ob7NtIQrQnwBi0NVOtP3ULG1X29eNH0qIvpvj/EF6MoacFhBHDk0t0ce5xW6kPiEZrfa
 Gi0fGEdi5rTP9seosQUJGhPsHjCaZ5+9XlsFC7L4joAb3G0B/9zKBXzIs6KJzWPj4wAF
 lBZJ9myjWedjoUBt+tW1j4924G0WLsypKzFYhRlcQPttrYUTkVao5DWt1cMqeHeaEEEd
 oJ9g==
X-Gm-Message-State: AOJu0YxmkuLY8hoC58Z/v2Q5LTa3rn7KC2KBHRCnzM6Z/0r6qsvZ2fuE
 wen+9XITzm66GsXTR8OepKlsw0hQZcvOkQ==
X-Google-Smtp-Source: AGHT+IFnmVc3eaBRmcfno61OgGLU8sUmsWefvajZnj9UH+G27+WT0ZKJ2+kUXEPcjSlUgU6WSHQAlA==
X-Received: by 2002:a17:90a:1784:b0:26b:4d4d:bd6 with SMTP id
 q4-20020a17090a178400b0026b4d4d0bd6mr11759434pja.33.1693986268731; 
 Wed, 06 Sep 2023 00:44:28 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 ck1-20020a17090afe0100b00262eb0d141esm10434901pjb.28.2023.09.06.00.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 00:44:28 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@gmail.com, berrange@redhat.com, fam@euphon.net,
 hreitz@redhat.com, jeuk20.kim@samsung.com, k.jensen@samsung.com,
 kwolf@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com,
 philmd@linaro.org, qemu-block@nongnu.org, stefanha@redhat.com,
 thuth@redhat.com
Subject: [PATCH v10 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
Date: Wed,  6 Sep 2023 16:43:47 +0900
Message-Id: <cover.1693980783.git.jeuk20.kim@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102b.google.com
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

Since v9:
- Added the "UFS_" prefix to all define and enum defined in block/ufs.h.
This fixes
https://gitlab.com/qemu-project/qemu/-/jobs/4977255992
which is a win32 build error.

- Fixed not to use pointer type casting (uint32_t * -> unsigned long *).
It causes the bug in the find_first_bit() function on big endian host pc.
This fixes
https://gitlab.com/qemu-project/qemu/-/jobs/4977256030
which is qos-test failure on s390x hosts.

Please let me know if there are any problems.
Thank you very much!

Jeuk

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
 hw/ufs/ufs.c             | 1502 ++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h             |  131 ++++
 include/block/ufs.h      | 1090 +++++++++++++++++++++++++++
 include/hw/pci/pci.h     |    1 +
 include/hw/pci/pci_ids.h |    1 +
 include/scsi/constants.h |    1 +
 meson.build              |    1 +
 tests/qtest/meson.build  |    1 +
 tests/qtest/ufs-test.c   |  587 +++++++++++++++
 18 files changed, 4835 insertions(+)
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


