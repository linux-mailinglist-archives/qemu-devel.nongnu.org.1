Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 194527902F5
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAyq-0006wz-NR; Fri, 01 Sep 2023 16:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyp-0006wf-Bp
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:42:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyl-0001wQ-Ck
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:42:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68c3b9f83f4so2058422b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600973; x=1694205773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wZWpJ03Z9eDSw/KqR9tATJV7QN6dmFf4hk1P937SZZk=;
 b=R5dhx1NIt0ynwJIDj4xuNRMh5WSQ30imXPytM8+yvir7+7ogv+KkR9H7rWawWFPc/W
 Dm/gcgfDvKXKhH6/M0JubOz4fN0j0nDKFbADladYEju+Cb2IBn7iAcCGb5e4cThxf2ap
 MD3XTih7qRCu5gV0mTPkdFBVxovUZPSRDjm9E0SE/1cGGSDGh6PFcO1L2061pL2T9RLU
 Zd5Y0ewPc6XvGy6FvWXTfuuweOSRUHai2ixbeRrHL+hQdZ0eCOan45asZ2xuCmDj13x6
 G6SbOXxiQWhYztYydT3MXV6kYgrIlHXs+W5D4eINaWE24V6EAzjBDcp+7GN6WQbURM6z
 iNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600973; x=1694205773;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wZWpJ03Z9eDSw/KqR9tATJV7QN6dmFf4hk1P937SZZk=;
 b=BDx4MweW5NeQup5veL1EHOCdfmz6S3BtkwKTyBU9rDK8OFGpwGfa10YXFa8rhPs665
 XNdLt3pedOWPtpauklfAHFfgzyx01D48gja4cSNFzpoHM6TQH3jM2+um2xXNeHBL304M
 Dpx/poBaqTeaL3yXQruDIx+B/TJwv60VqXvz5A7gDAVT4TouFK7Pv3ySXnDWML0Z9bfH
 g3EyojyCyZvfhh1lns6VxLcP7hb0KuLo3EsduCA/MRhpZl0bwf9yXdJasm0HwA0gyyeQ
 Gzsxl597tZSiX93HXkpEKx22AdWq9P+QCcGHh4tdfX0eb/Of2kbOpsWpimk+MNVk7z8L
 ha1Q==
X-Gm-Message-State: AOJu0YydvDiz5ke/Z6pQ9LAXpV5CA8MHpsKw+jMRjUl9ltVlkfiY6eGk
 I0FlJ8rxd7lj+pBUsx2eXyHclQ1uViCA07Yf1fg=
X-Google-Smtp-Source: AGHT+IG06cLVupWsg1ifAFCH7p8nVLKPirioxUq7QZQdF5mz21HS0jBKgMwUDws8IMQnUbNWftXRAw==
X-Received: by 2002:a05:6a21:7983:b0:133:bbe0:2ff1 with SMTP id
 bh3-20020a056a21798300b00133bbe02ff1mr4015232pzc.44.1693600972555; 
 Fri, 01 Sep 2023 13:42:52 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b0068c97a4eb0dsm3320666pfe.191.2023.09.01.13.42.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:42:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] linux-user patch queue
Date: Fri,  1 Sep 2023 13:42:38 -0700
Message-Id: <20230901204251.137307-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The following changes since commit 17780edd81d27fcfdb7a802efc870a99788bd2fc:

  Merge tag 'quick-fix-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-31 10:06:29 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20230901

for you to fetch changes up to 044e95c81e750a0605deb12a20ee23bfde7dc9c8:

  linux-user: Track shm regions with an interval tree (2023-09-01 13:35:57 -0700)

----------------------------------------------------------------
linux-user: Rewrite and improve /proc/pid/maps
linux-user: Fix shmdt and improve shm region tracking
linux-user: Remove ELF_START_MMAP and image_info.start_mmap

----------------------------------------------------------------
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
 linux-user/alpha/target_proc.h       |  67 +++++
 linux-user/arm/target_proc.h         | 101 +++++++
 linux-user/cris/target_proc.h        |   1 +
 linux-user/hexagon/target_proc.h     |   1 +
 linux-user/hppa/target_proc.h        |  26 ++
 linux-user/i386/target_proc.h        |   1 +
 linux-user/loader.h                  |   6 +-
 linux-user/loongarch64/target_proc.h |   1 +
 linux-user/m68k/target_proc.h        |  16 ++
 linux-user/microblaze/target_proc.h  |   1 +
 linux-user/mips/target_proc.h        |   1 +
 linux-user/mips64/target_proc.h      |   1 +
 linux-user/nios2/target_proc.h       |   1 +
 linux-user/openrisc/target_proc.h    |   1 +
 linux-user/ppc/target_proc.h         |   1 +
 linux-user/qemu.h                    |   1 -
 linux-user/riscv/target_proc.h       |  37 +++
 linux-user/s390x/target_proc.h       | 109 ++++++++
 linux-user/sh4/target_proc.h         |   1 +
 linux-user/sparc/target_proc.h       |  16 ++
 linux-user/user-mmap.h               |   4 +
 linux-user/x86_64/target_proc.h      |   1 +
 linux-user/xtensa/target_proc.h      |   1 +
 linux-user/elfload.c                 | 170 +++++++++---
 linux-user/mmap.c                    | 168 ++++++++++++
 linux-user/syscall.c                 | 514 +++++++++--------------------------
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

