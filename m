Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC179F530
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 00:48:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgYdf-00079x-Ib; Wed, 13 Sep 2023 18:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qgYdd-00079h-He
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:47:13 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qgYdb-0007k1-JY
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:47:13 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-502e0b7875dso537228e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694645228; x=1695250028;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R5tYR3X4kFZz81gQPxxutq/UZL83Zktm55Inljahw6Q=;
 b=kScP8af5QWjcUrHzH+JDNt0HDFlbKBqsCXhwO4QxLTFGBTj7qyNvZmMRRKVDIvn1qD
 q6hPvJ/ggKppYmJup2Va2mmoRhxmKfY3bx0rbZrTJ/ggHeMxLLZ/JDGEHVUk2JLgF/mX
 +GcpDRhfoOEg8/s7XWKOBXcmZwgrOSCHXeineESY3RwI8t66c0k84pHYsQp5pn/DJ+BK
 w2s/Sm9uLON9ou8Lur6t0u6Zio0lApjwghL/WnpObJPByMBvYbnu/MzmMuhJaFI2ZT/I
 DI7VVsYNiv6Wy1dc1NMrsP1/YByR5TkmjVZz9exN5oBERrEjL3ZePIn8QMnyfSCb7m4k
 vYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694645228; x=1695250028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R5tYR3X4kFZz81gQPxxutq/UZL83Zktm55Inljahw6Q=;
 b=It8V8gWvMABPgPgd+OFGENrVTVil9+HwaWZvRiEtP8oG4HtVlt91p+/52AAJ48UJbE
 zIqyVTZMBvaDxURtPbuHg91UECAAoSx3CL2pbeZIo9t6+9P4Hbz2OEH72O1/ur8DkS1k
 ohE0UFlJXhno1/LQzGPTH+f17EP8SDZqEy4qkCQGpuebLuSA0DiJljBIsiYcr/KV8KYD
 TszZ9Q0KOufyAS5IVRS42D0Y9DLec8V3Ymgm1JBdNaN1PjC03VfxdnpcLzY2bNFbrpZw
 MSUmPvFsEZmbPPtUf19qEheRMEDCS/TaPgUC6/xPm982IRZOIDjD61YZg3M0vdp3B1Wl
 U27w==
X-Gm-Message-State: AOJu0YzdQMzKw9T7RbEY9v1gFWhEDCPlU4mQLwftHUIuJHV68vnwaWhx
 ZFcpLxDz9ftqGLU/1+G5zaUKvkHjuDfjsZYq0kY=
X-Google-Smtp-Source: AGHT+IG06+CvSqOuUT8s/madXKzU3r+ttcolqEFAGC4v5h1NSchRZJ/r9ywo1ILLhYH56NelPSXwtw==
X-Received: by 2002:a05:6512:3e26:b0:500:9524:f733 with SMTP id
 i38-20020a0565123e2600b005009524f733mr3314661lfv.20.1694645227640; 
 Wed, 13 Sep 2023 15:47:07 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.8])
 by smtp.gmail.com with ESMTPSA id
 u28-20020a056512041c00b004fdba93b92asm25020lfk.252.2023.09.13.15.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:47:07 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: annie.li@oracle.com,
	akihiko.odaki@daynix.com,
	kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH 0/5] elf2dmp: improve Win2022, Win11 and large dumps
Date: Thu, 14 Sep 2023 01:46:52 +0300
Message-Id: <20230913224657.11606-1-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::12a;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Windows Server 2022 and Windows 11 require more careful kernel PE image
search and handling of PDB than previous Windows versions.
Also, improve support of large ELF dump files, dumps with unaligned
memory ranges and with big number of ranges.

Viktor Prutyanov (5):
  elf2dmp: replace PE export name check with PDB name check
  elf2dmp: introduce physical block alignment
  elf2dmp: introduce merging of physical memory runs
  elf2dmp: use Linux mmap with MAP_NORESERVE when possible
  elf2dmp: rework PDB_STREAM_INDEXES::segments obtaining

 contrib/elf2dmp/addrspace.c |  31 +++++++-
 contrib/elf2dmp/addrspace.h |   1 +
 contrib/elf2dmp/main.c      | 154 ++++++++++++++++++++----------------
 contrib/elf2dmp/pdb.c       |  10 +--
 contrib/elf2dmp/qemu_elf.c  |  66 +++++++++++++---
 contrib/elf2dmp/qemu_elf.h  |   4 +
 6 files changed, 175 insertions(+), 91 deletions(-)

-- 
2.21.0


