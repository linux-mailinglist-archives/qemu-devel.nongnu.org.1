Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1D297678A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Sep 2024 13:21:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sohrZ-0006F3-Cj; Thu, 12 Sep 2024 07:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sohrT-00065o-TR
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:19:44 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sohrN-00081M-Ay
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:19:39 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so609090a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1726139969; x=1726744769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XSeUzm1kgJeizuUjnlapgalEdMkN8ZDYH0E/GmJkeBo=;
 b=WICsNX/94Hi+CUJG9pbqgKG/fNEUw5Nng/Sw6XiErZwd5ANZ3gYAnY16x0Er5MiYJ9
 wtiGDX0ciOT5tBXIyX42WR7ztIJz4IYIRNpRi4Ba9CzXBchHNWU0ti/So3rEPBBQybUP
 53QCTGf98x3WGbFbDsK01jTmo58IecH24nVjC7/Y3M36nF0UjYprLnsC8YoPAhHN57TX
 NrtiJGuuyWOakkWwagmZEKWZkNNwK6HD3JCY3AXS5eY526rLShVpvIiiW2NFHK9HQD5V
 fgWFn5y+Vt/mn2oC2oYGQUzgO8Ka2XMMR6GeEDhoKvTlD49jv+iT+K+2Ffe7l+QwjhTK
 Aubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726139969; x=1726744769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XSeUzm1kgJeizuUjnlapgalEdMkN8ZDYH0E/GmJkeBo=;
 b=caEmnCLRbd8zkTOzSPxmISFuGfN/kpQRgC9PPj6R9tQZ+qeTIbkCObNG1ByK7STn7j
 7viC+csom0jmwXHXd1AlvxvoruUKhdBkUFFCBUFIqCj3nvAptFt0zsOlIKYmftJbmBSv
 aW8pDj7/zBhs9w73Xsu5gD9WdbrN27eqGz2fjg2NwOrWJiUWt2QATiURCLkHYCOZwdNo
 hsysmNVVCNTQYHisZoN7qtuHikSYQiInPjEC0nQxO/Hopa53ZFuSeTNpKp1AHNx5RZs5
 6QiW5YOjo87Tx2XB3Jw0o7z8lojl1uW/NatfDyRf2UMUbKR2+Pq07aZjZroTXQw6FsqI
 cqLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGZDfyK/uUH1ezoppzqOw9XLMnTLtkER4J2g84wfLuo8L/tzJPZQKDp0qa+3CS4qsPuB0TgTCe9Nho@nongnu.org
X-Gm-Message-State: AOJu0YxOxE5LUqhv5spUcwyy1uNxV5gIxkrFDK1Qw9NUPgxDKvqtG+yx
 RrxaGXVkoBYOIyG/mU1C2DHBVX7nvs8ioza3hPSVCLY0U+VcH5w9BvMVbXqIBH4=
X-Google-Smtp-Source: AGHT+IFXV50/bmCoIlel2CmxHGWD2lL+WBHtsRIWZM0BY4vbR5Mk1ELi+dTTowNXoMJjcPIZeRzbEg==
X-Received: by 2002:a05:6a20:c703:b0:1cf:52fe:38ff with SMTP id
 adf61e73a8af0-1cf75e79de6mr3175724637.8.1726139969245; 
 Thu, 12 Sep 2024 04:19:29 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090afadasm4552072b3a.177.2024.09.12.04.19.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Sep 2024 04:19:28 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v12 00/10] Support persistent reservation operations
Date: Thu, 12 Sep 2024 19:19:07 +0800
Message-Id: <20240912111917.81477-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

Patch v12 has been modified, thanks to Stefan for the code review.

v11->v12:
- Fixed endian conversion during command parsing;
- Add the maximum number of keys, currently limited to 128.

v10->v11:
- Before executing the pr operation, check whether it is supported.
  If it is not supported, return NVME_INVALID_OPCODE directly.

v9->v10:
- When the driver does not support the pr operation, the error
  code returned by nvme changes to Invalid Command Opcode.

v8->v9:
- Fix double-free and remove persistent reservation operations at nvme_is_write().

v7->v8:
- Fix num_keys may be less than 0 at scsi_pr_read_keys_complete().
- Fix buf memory leak at iscsi driver.

v6->v7:
- Add buferlen size check at SCSI layer.
- Add pr_cap calculation in bdrv_merge_limits() function at block layer,
  so the ugly bs->file->bs->bl.pr_cap in scsi and nvme layers was
  changed to bs->bl.pr_cap.
- Fix memory leak at iscsi driver, and some other spelling errors.

v5->v6:
- Add relevant comments in the io layer.

v4->v5:
- Fixed a memory leak bug at hw/nvme/ctrl.c.

v3->v4:
- At the nvme layer, the two patches of enabling the ONCS
  function and enabling rescap are combined into one.
- At the nvme layer, add helper functions for pr capacity
  conversion between the block layer and the nvme layer.

v2->v3:
In v2 Persist Through Power Loss(PTPL) is enable default.
In v3 PTPL is supported, which is passed as a parameter.

v1->v2:
- Add sg_persist --report-capabilities for SCSI protocol and enable
  oncs and rescap for NVMe protocol.
- Add persistent reservation capabilities constants and helper functions for
  SCSI and NVMe protocol.
- Add comments for necessary APIs.

v1:
- Add seven APIs about persistent reservation command for block layer.
  These APIs including reading keys, reading reservations, registering,
  reserving, releasing, clearing and preempting.
- Add the necessary pr-related operation APIs for both the
  SCSI protocol and NVMe protocol at the device layer.
- Add scsi driver at the driver layer to verify the functions


Changqi Lu (10):
  block: add persistent reservation in/out api
  block/raw: add persistent reservation in/out driver
  scsi/constant: add persistent reservation in/out protocol constants
  scsi/util: add helper functions for persistent reservation types
    conversion
  hw/scsi: add persistent reservation in/out api for scsi device
  block/nvme: add reservation command protocol constants
  hw/nvme: add helper functions for converting reservation types
  hw/nvme: enable ONCS and rescap function
  hw/nvme: add reservation protocal command
  block/iscsi: add persistent reservation in/out driver

 block/block-backend.c             | 403 +++++++++++++++++++++++++++
 block/io.c                        | 164 +++++++++++
 block/iscsi.c                     | 433 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 361 ++++++++++++++++++++++++-
 hw/nvme/ns.c                      |  11 +
 hw/nvme/nvme.h                    |  94 +++++++
 hw/scsi/scsi-disk.c               | 374 ++++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              | 107 +++++++-
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2310 insertions(+), 2 deletions(-)

-- 
2.20.1


