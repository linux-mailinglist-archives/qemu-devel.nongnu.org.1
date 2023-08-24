Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C8786466
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:04:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykK-00006e-4G; Wed, 23 Aug 2023 21:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykF-0008Vy-Sf
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykC-0000Q9-Ud
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:43 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a6f6a66e1so1797109b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838959; x=1693443759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vy6zeVyiozYGNcTjMnBFyYJaWmyQZQbdfRH+76l3XWc=;
 b=BDBBFhkqHldw/SyC0Nu5fXAvcWAQ2UI115tnXiXs25KzXstQ1DPy5JtZ/OnBypIkVN
 6KZMhTaXNb0L58ZGB1FVPpwAHF3lSWIHZhDAY2gHz4qmpqVrfExgP4fGFBRimPqcadsa
 YUHgTegwn/wKLx+/B+LwXhYFQAnPt8uCFMWvy7XdMWmu3qviSzGhfGY5XylcSvPSJCce
 SCtQ51xqOOlWk06IChSFHDH/2PByBUtbQ0/hT7+u4Al9jliMBn/oF0BCHovaGXLKvYTX
 B4PAMpJyzE5N72XgZQ78KAjmuzb5GqZlqWrWuRnyN197/24O1TBfebnXzdYlEHwStNmh
 Mnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838959; x=1693443759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vy6zeVyiozYGNcTjMnBFyYJaWmyQZQbdfRH+76l3XWc=;
 b=CnwBR0cCzJRmg8kyFz4pnSLLBQjiSeJHVHOBxlI/yc/kuo4CH1qQmIAx6/FBDhSHtC
 vPgs4aP3gdIGrsdsqSxZySlaaP3anApqpHokFA50bDdSoVdQHKv/O18zv0hMeYF8ZHQK
 ozaUt7bkYyKMFghNwqg24UQNYvYSlZIpLghB8SK/wCAtPnZWnRIFLIoyeDy/IGveVxoB
 3EF2qH2xkGIj5paQ5VdPo274DfaA3ST9ivC0Tafin4g6jPE23PPofHlb87NVMky3hJgO
 N3wgCPpK/ILWHmUCACK8Bm8SbY7ugmNeZjLv62AsO4LWtFwX1r/CAqcDXTwh7bdu8g1l
 Iudg==
X-Gm-Message-State: AOJu0Yxp3GLWW+I3OOUCZBWFwzNTDGVLgA0Em0+W0h19blCcdh6TG9sU
 aK0OFxjn6IHlI6a/N+LpnK8sxn6K2/kmXQTT9yE=
X-Google-Smtp-Source: AGHT+IEaTufiZ3xKNu5gz0HkXmMnAygjRmbDkyTbQg4acPXpyK2/0TxYgEP3itV3njjBaaiXDt5OxQ==
X-Received: by 2002:a05:6a20:7486:b0:13d:ee19:7727 with SMTP id
 p6-20020a056a20748600b0013dee197727mr14377843pzd.18.1692838959039; 
 Wed, 23 Aug 2023 18:02:39 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/13] linux-user patch queue
Date: Wed, 23 Aug 2023 18:02:24 -0700
Message-Id: <20230824010237.1379735-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Combine a bunch of smaller linux-user patches:

Supercedes: 20230801230842.414421-1-deller@gmx.de
("[PATCH v2 0/3] linux-user: /proc/cpuinfo fix and content emulation for arm")
Supercedes: 20230807122206.655701-1-iii@linux.ibm.com
("[PATCH v2] linux-user: Emulate the Anonymous: keyword in /proc/self/smaps")
Supercedes: 20230816181437.572997-1-richard.henderson@linaro.org
("[PATCH 0/6] linux-user: Rewrite open_self_maps")
Supercedes: 20230820204408.327348-1-richard.henderson@linaro.org
("[PATCH 0/4] linux-user: shmat/shmdt improvements")

with some additions.  Patches needing review:

  01-linux-user-Split-out-cpu-target_proc.h.patch
  11-linux-user-Use-WITH_MMAP_LOCK_GUARD-in-target_-shmat.patch
  12-linux-user-Fix-shmdt.patch
  13-linux-user-Track-shm-regions-with-an-interval-tree.patch


r~


Helge Deller (2):
  linux-user: Emulate /proc/cpuinfo on aarch64 and arm
  linux-user: Emulate /proc/cpuinfo for Alpha

Ilya Leoshkevich (1):
  linux-user: Emulate the Anonymous: keyword in /proc/self/smaps

Richard Henderson (10):
  linux-user: Split out cpu/target_proc.h
  util/selfmap: Use dev_t and ino_t in MapInfo
  linux-user: Use walk_memory_regions for open_self_maps
  linux-user: Adjust brk for load_bias
  linux-user: Show heap address in /proc/pid/maps
  linux-user: Remove ELF_START_MMAP and image_info.start_mmap
  linux-user: Move shmat and shmdt implementations to mmap.c
  linux-user: Use WITH_MMAP_LOCK_GUARD in target_{shmat,shmdt}
  linux-user: Fix shmdt
  linux-user: Track shm regions with an interval tree

 include/qemu/selfmap.h               |   4 +-
 linux-user/aarch64/target_proc.h     |   1 +
 linux-user/alpha/target_proc.h       |  67 ++++
 linux-user/arm/target_proc.h         | 101 ++++++
 linux-user/cris/target_proc.h        |   1 +
 linux-user/hexagon/target_proc.h     |   1 +
 linux-user/hppa/target_proc.h        |  26 ++
 linux-user/i386/target_proc.h        |   1 +
 linux-user/loader.h                  |   6 +-
 linux-user/loongarch64/target_proc.h |   1 +
 linux-user/m68k/target_proc.h        |  16 +
 linux-user/microblaze/target_proc.h  |   1 +
 linux-user/mips/target_proc.h        |   1 +
 linux-user/mips64/target_proc.h      |   1 +
 linux-user/nios2/target_proc.h       |   1 +
 linux-user/openrisc/target_proc.h    |   1 +
 linux-user/ppc/target_proc.h         |   1 +
 linux-user/qemu.h                    |   1 -
 linux-user/riscv/target_proc.h       |  37 ++
 linux-user/s390x/target_proc.h       | 109 ++++++
 linux-user/sh4/target_proc.h         |   1 +
 linux-user/sparc/target_proc.h       |  16 +
 linux-user/user-mmap.h               |   4 +
 linux-user/x86_64/target_proc.h      |   1 +
 linux-user/xtensa/target_proc.h      |   1 +
 linux-user/elfload.c                 | 170 ++++++---
 linux-user/mmap.c                    | 168 +++++++++
 linux-user/syscall.c                 | 514 +++++++--------------------
 util/selfmap.c                       |  12 +-
 29 files changed, 828 insertions(+), 437 deletions(-)
 create mode 100644 linux-user/aarch64/target_proc.h
 create mode 100644 linux-user/alpha/target_proc.h
 create mode 100644 linux-user/arm/target_proc.h
 create mode 100644 linux-user/cris/target_proc.h
 create mode 100644 linux-user/hexagon/target_proc.h
 create mode 100644 linux-user/hppa/target_proc.h
 create mode 100644 linux-user/i386/target_proc.h
 create mode 100644 linux-user/loongarch64/target_proc.h
 create mode 100644 linux-user/m68k/target_proc.h
 create mode 100644 linux-user/microblaze/target_proc.h
 create mode 100644 linux-user/mips/target_proc.h
 create mode 100644 linux-user/mips64/target_proc.h
 create mode 100644 linux-user/nios2/target_proc.h
 create mode 100644 linux-user/openrisc/target_proc.h
 create mode 100644 linux-user/ppc/target_proc.h
 create mode 100644 linux-user/riscv/target_proc.h
 create mode 100644 linux-user/s390x/target_proc.h
 create mode 100644 linux-user/sh4/target_proc.h
 create mode 100644 linux-user/sparc/target_proc.h
 create mode 100644 linux-user/x86_64/target_proc.h
 create mode 100644 linux-user/xtensa/target_proc.h

-- 
2.34.1


