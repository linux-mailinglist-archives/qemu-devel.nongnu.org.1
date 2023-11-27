Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D177F9C32
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 09:59:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7XRO-0002g1-Bn; Mon, 27 Nov 2023 03:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRH-0002dO-Fv; Mon, 27 Nov 2023 03:57:59 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XR5-0000J3-WA; Mon, 27 Nov 2023 03:57:53 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2855b3d9a9bso2601181a91.2; 
 Mon, 27 Nov 2023 00:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701075445; x=1701680245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JU6tjSc8soxdVv49hj1o98fftZyeF8wp2Y5hcTTYSXM=;
 b=iPJYeUgrhDVy+/qOLq1uDiPLaIp4EYuc80Y6QlRE2LSxGyPgtooAjRT6djKEDy1cW5
 9ahrCurDaPE+P83mTuCDWI0KMOl1I7R/Sb6PtNdwULCbA15Ar7zZAPqGfHberEVBdPGV
 ZNI2XdT8dRzgWRDrjeEyjNYGc7VUPfG4LmfvB+gvh10cao5soRm4xuTz6ErfnJc9s+Gt
 n62csWqIIqQz5bNOdDNeznEcbJkKT/Bl5rpEzVrYCmIgp5dP/2iRXtBPzp3Rie6ci+fR
 cB8V18VIrQa+/1DU0EfWfd5/X0KIY0/IKDGG54IwdSHQ9n6VtmDboN3aLiRECnrh9/l6
 V8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701075445; x=1701680245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JU6tjSc8soxdVv49hj1o98fftZyeF8wp2Y5hcTTYSXM=;
 b=skMarOwxLUSBV7Ce4dBGsa/zuH3p0YSD9e7lfSYDlkhLWFG5W/V1sxthiYUQFY5EtF
 M/P1EOio40EsiioKL02rofTRpQODucGCq9cj5PLRGMVwM+GSlfhGoD2CeLMiBiMVWbQP
 RVDyk1PrKpo4xE/YG8IZORdO01gfgrWKJhodQDcS1GyZGSQmWclu/AD9WXSQgbXjWK1v
 /UiUQrce/2s7wN9MxS0wWZw4ca1LK3dBPi6OKqJ2M0apnc3lL4I4+h0iDI3Dj/9bsKiB
 qyO9oThZ9XWk6+5KxSa5UXE6k+9FaglXxygBnV+z2ScjAe703R0zMaH9kdto6pxwQN6/
 RhCg==
X-Gm-Message-State: AOJu0YwQJeLjp/pDx7qzyMMHpbRrGTBed4wpAUIjNtUV5U/PWGA6Egpk
 fnfBg+MRXQX30wQLRHH0BkgVATRM96fZrg==
X-Google-Smtp-Source: AGHT+IEawCpHoqs+q2JJQY1zIO0QCS4sTBv8zatmLCFuRYrb6HbCGyViqOWEuf7LQUv4XgaMFJT5Aw==
X-Received: by 2002:a17:90b:4d8b:b0:27d:c36:e12c with SMTP id
 oj11-20020a17090b4d8b00b0027d0c36e12cmr10109668pjb.9.1701075444759; 
 Mon, 27 Nov 2023 00:57:24 -0800 (PST)
Received: from fedlinux.. ([106.84.128.244]) by smtp.gmail.com with ESMTPSA id
 ci8-20020a17090afc8800b0027d0adf653bsm6906901pjb.7.2023.11.27.00.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 00:57:24 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org, hare@suse.de, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [RFC v2 0/7] Add persistence to NVMe ZNS emulation
Date: Mon, 27 Nov 2023 16:56:34 +0800
Message-Id: <20231127085641.3729-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x102d.google.com
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
- adding full zoned storage emulation to qcow2 driver.
https://patchwork.kernel.org/project/qemu-devel/cover/20231127043703.49489-1-faithilikerun@gmail.com/

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

To attach this file as emulated zns drive in the command line of QEMU, use:
  -drive file=${znsimg},id=nvmezns0,format=qcow2,if=none \
  -device nvme-ns,drive=nvmezns0,bus=nvme0,nsid=1,uuid=xxx \

Sorry, send this one more time due to network problems.

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
 block/qcow2.c                     |  119 ++-
 block/qcow2.h                     |    2 +
 docs/interop/qcow2.txt            |    3 +
 hw/nvme/ctrl.c                    | 1247 ++++++++---------------------
 hw/nvme/ns.c                      |  162 +---
 hw/nvme/nvme.h                    |   95 +--
 include/block/block-common.h      |    9 +
 include/block/block_int-common.h  |    8 +
 include/sysemu/block-backend-io.h |   11 +
 include/sysemu/dma.h              |    3 +
 qapi/block-core.json              |    4 +
 system/dma-helpers.c              |   17 +
 13 files changed, 647 insertions(+), 1121 deletions(-)

-- 
2.40.1


