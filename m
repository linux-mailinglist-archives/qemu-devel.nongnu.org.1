Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2A292A281
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jul 2024 14:21:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQnL5-0001gc-3Y; Mon, 08 Jul 2024 08:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sQnKu-0001d1-VS
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 08:19:18 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sQnKp-0001Tn-8I
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 08:19:14 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-707040e3017so2534041a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720441144; x=1721045944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tSEhHjiskCQhJXGxGcGe0FFAr/6d1dYEoUj2mKF099s=;
 b=WzNGCHW26MiRlgcS9AIMf6f6TS3ZUS8THS+JpYhj5sCV+7Tm2slvGvo1JQhtJKdRE5
 RGLOT28ruyaf4F+fF6bjarASmYldj+eqZ4EJJxkvr5nIzZcXKfEVUOQ4WF2IQ7NRdluA
 2oUj5SbQ4I29rl5J+0TS6RWvqnqrkMEJFGemR/DsIQauayRWTgWLLHasv8V4HSzMMC6Q
 0NYhHQQMnUgclSNvivMIJCpr4Y3nvG3QbUqKIb0KK7HbuRGj23+h4iOb3esnpwggcOJe
 o+4gTzMZjlsY11SngJ6DFNYc9d+V9xJGQQtddvGPZRaDowxdfVyuo9Gw7tVT17rPGiQK
 OdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720441144; x=1721045944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tSEhHjiskCQhJXGxGcGe0FFAr/6d1dYEoUj2mKF099s=;
 b=jLNtbD/7WYJZGHIHWRkwPNoBn0DZyJaj1NKfcjpAfLMn/sdw7fT3/a5B0ArkPerzFj
 C7OfY4tgXrkl1KR+uPHR76O6Di9HAPlVkPwLtdm0sc/gGBcRWpK5dIIOypPhQ7TXsuMm
 FXNk762zde5sy5nVXZSS0goOnl8Szbewz5B7tA4S4H/q48YSYtAyn+WoUAlAcNehJ0WK
 oQX7ud9mq0Pu90t9UeiEX6fgSHVNK3TQ5C1qEaCXUe+ekj1AbwFAFVtaZ9XvMK5WUx6e
 POScVkBvDSdYMa8YO1cF3CqZHvqJ6ehIBqOvHyK8AqS2iAP6Dqti0SA7QuK1z5lok/HQ
 ET1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7r9VODyTk76nFsxpUbXmQpntDQd9kMPdd7dIbcBLF3jjlB/IBNndoVvdnsvAxflW6M79d34t9QcmZ+N8eZ35Ka+xzS8M=
X-Gm-Message-State: AOJu0Yxp3r6COTH47j/Ct7JR4/8Oln/Dfl/KzExloxiyhz6IP97/eROK
 JM3gXw5WEa1lVhYbYserEYK+g0Pn28PzUM7yGJEFxn9zjqBE6oEd/J3kkKwPz4Q=
X-Google-Smtp-Source: AGHT+IHt06xSizbOFVqsq5KMqUQ5cxHsJi9C26b8mKjUJdIhVloQd0edLBll3CHtbismJpNaYMxsLQ==
X-Received: by 2002:a05:6a20:3d87:b0:1c2:93a7:2557 with SMTP id
 adf61e73a8af0-1c293a727b5mr92640637.48.1720441144248; 
 Mon, 08 Jul 2024 05:19:04 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.49.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb4fa258f7sm56587195ad.169.2024.07.08.05.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 05:19:03 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v8 00/10] Support persistent reservation operations
Date: Mon,  8 Jul 2024 20:18:44 +0800
Message-Id: <20240708121854.1318876-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x52e.google.com
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

Stefan, the issue you mentioned has been fixed.

Almost all patches have been reviewed, thank you very much
to Stefan and Klaus.


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

 block/block-backend.c             | 403 ++++++++++++++++++++++++++++
 block/io.c                        | 164 ++++++++++++
 block/iscsi.c                     | 425 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 326 ++++++++++++++++++++++-
 hw/nvme/ns.c                      |   5 +
 hw/nvme/nvme.h                    |  88 +++++++
 hw/scsi/scsi-disk.c               | 368 ++++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              | 100 ++++++-
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2241 insertions(+), 3 deletions(-)

-- 
2.20.1


