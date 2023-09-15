Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 040247A2422
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:02:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCCp-0003NO-GF; Fri, 15 Sep 2023 13:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qhCCm-0003Jo-69
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:02:08 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qhCCj-0000Kx-LI
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:02:07 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so4055780e87.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694797323; x=1695402123;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XvVsOHT9PZxVCvF2QA+KHENTVul0O7/hfKI8B3nYATE=;
 b=LQw2BMNvhhmDIKhkV2acjLNFFoYrKPgTd0h9WuEY7/BPxU75x8DRGoWspFOUfjIklU
 5S11RFM0+qfZAR6Lj3LZGVgRF9sebrVf9MbLyQrjRi3A3PsArwxmgSGUiBczX75pPMKS
 nmg/BZAZDiOyeMKS70ryiBLDbkE/4p34KcBZfnuQCpkxTBQT10gXzaNf8BMRMlsQAGJV
 I6/9skx/HDoSq5fKCMR1fGT1+q/EjsQvCqDBJjRnjN+huvFUGdVbyP2bLWtg2OwSSoGT
 G3IOy87JD0rPw9TmHz3AKDpxz/ffFqulJr3ncHUlquVLhaSakJXNZVcywkXr+LO9K8ob
 n8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694797323; x=1695402123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XvVsOHT9PZxVCvF2QA+KHENTVul0O7/hfKI8B3nYATE=;
 b=Ak3olFnC1H/lJudgqfdWRZgbC7oieLpFPEsnHz94z8HCSPnlze+UKTwBDdvv7P2q0L
 8gsNvVBWrMiV/5WYRSQGvcBq5qFtu5/VezY/iMFE6Xd8IduT6M7lIlrinWHx5UXoPWiS
 wCJF+6IDgtcFFywKOGG44O7HTuTLBmCRFvcC/+2tX2V3agmoZin/+jvC7ed1vaUgW8rc
 7rHnqeOAtFOARLF4x77IGAY577PQwIw7muLBhiqv4Btyf6oAgIbU8B2dVL9rGe9NPPK/
 LqNnxt2jUGYAQ8eMV/ig9CgfxkL2ClimBjqGuVO8Jsrcj6tPRnqqrOFuboOJXTXzo2U/
 d7vA==
X-Gm-Message-State: AOJu0YzqAXlYrMNs1V91yBA7Og/vcqNT7QRUDSDx1FCL2K2tW8GgxdcR
 1ElpHGK9cJBzgGanYPWQWuyCQyRTh6Q7PklUrCZsWg==
X-Google-Smtp-Source: AGHT+IH064z8QJj8uushT53jp0zUwV8uq9MToSwv34Ge5FjhwkZbPuecaSsxjyOw5Q+mvDNG/q0ARw==
X-Received: by 2002:a19:910c:0:b0:500:9796:fb6 with SMTP id
 t12-20020a19910c000000b0050097960fb6mr2064880lfd.40.1694797322814; 
 Fri, 15 Sep 2023 10:02:02 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-8.nat.spd-mgts.ru.
 [109.252.90.8]) by smtp.gmail.com with ESMTPSA id
 u7-20020a056512040700b005009ab1992esm690431lfk.154.2023.09.15.10.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 10:02:02 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: annie.li@oracle.com,
	akihiko.odaki@daynix.com,
	kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH v2 0/5] elf2dmp: improve Win2022, Win11 and large dumps
Date: Fri, 15 Sep 2023 20:01:48 +0300
Message-Id: <20230915170153.10959-1-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::132;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x132.google.com
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
 contrib/elf2dmp/pdb.c       |  15 +---
 contrib/elf2dmp/pdb.h       |   2 +-
 contrib/elf2dmp/qemu_elf.c  |  68 +++++++++++++---
 contrib/elf2dmp/qemu_elf.h  |   2 +
 7 files changed, 177 insertions(+), 96 deletions(-)

-- 
2.21.0


