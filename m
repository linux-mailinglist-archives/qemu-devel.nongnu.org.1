Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BAF774C72
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:09:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTwt-0007en-M0; Tue, 08 Aug 2023 17:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwr-0007eI-PJ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:01 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwq-0005vB-14
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:01 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc65360648so27872525ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528938; x=1692133738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+7DYztTQ7UfexO5CIxZ6qx3WddTtGCcsFw3POdoiibk=;
 b=s1yFzo2OKr2ia0XWhVro6huPWGH7ZID5O+Agf6pWNUD1vgWkFwL653+DMY0PVUEd1P
 VaH2rmus7CL5gKJ60zziFdc8FP0sjsfLUK5NZ7cyjNVG7cwU0kyCAQyNtJzTXj40UWbp
 LmXalet8/64OcJreRVZo7mtTIQtu1LOYs0ExK3HJPZTQxPpsHqU5y/p6r0iBQAtIuEEk
 sSz+YNeNZLIPG86bHE1R/BoaNG82xr0/8r2nXHu/6tAUz8cpyS659xa4sNALgj/PcI4g
 VNhDI5DSU0ijRfsKjtye4KesEZjir4uNa8dAPNCEArXUcE8buAIROyyGMXGC12U6hUPx
 73Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528938; x=1692133738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+7DYztTQ7UfexO5CIxZ6qx3WddTtGCcsFw3POdoiibk=;
 b=jObUu2M1hN43xXeiiO0im6NgQr/3Ni2+5d3VKu5M7XoqFljGghO+BN/eMj6PNGHUdH
 cZsv70no0RMHsCLKLxcGrorAHOxME06pW9fhfhY3witNI/+pkrLgejnrCWqS+g+w5oh6
 eBOazX+AqkcFw71+yOPkMWr+LKrBHC4LqAcymp+xGdxpFs+MVC3/PYtkTFrbVCJ7GiOw
 w2TE72EAJPCzhJxu4ISeQvQP88Wx3+uOcLK00wQtbiNg5hUNfRugGqIZ8l1W3yNRlUBF
 BDv9xUJEW+5Ufvny7ALj4MKN3f0YbnKyRXPlGlfZoeqRrf6HCO5Swf7RgTUZVOCOJu+k
 hqbA==
X-Gm-Message-State: AOJu0YyhGWaCPJia1hBkDf9k75SYYTz17REhPCAbw09XXqoRQNxOty2f
 0olNDXlW6N8waXVA5Y5vTvJ/ijkts909Ls+VWjM=
X-Google-Smtp-Source: AGHT+IHlu57FIT1pz78WHtYgxX65uNpHwkD3BdyPQtlV4y+3lAF6P+TlBvDAOF2ajnssFBpZUay+sA==
X-Received: by 2002:a17:902:b70e:b0:1bc:1e03:3cbe with SMTP id
 d14-20020a170902b70e00b001bc1e033cbemr794448pls.18.1691528938036; 
 Tue, 08 Aug 2023 14:08:58 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.08.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:08:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] linux-user image mapping fixes
Date: Tue,  8 Aug 2023 14:08:42 -0700
Message-Id: <20230808210856.95568-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The following changes since commit 0450cf08976f9036feaded438031b4cba94f6452:

  Merge tag 'fixes-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-08-07 13:55:00 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20230808

for you to fetch changes up to dd55885516f42f718d0d121c59a5f7be5fdae3e6:

  linux-user: Rewrite non-fixed probe_guest_base (2023-08-08 13:41:55 -0700)

----------------------------------------------------------------
linux-user: Adjust guest image layout vs reserved_va
linux-user: Do not adjust image mapping for host page size
linux-user: Adjust initial brk when interpreter is close to executable
util/selfmap: Rewrite using qemu/interval-tree.h
linux-user: Rewrite probe_guest_base

----------------------------------------------------------------
Helge Deller (1):
      linux-user: Adjust initial brk when interpreter is close to executable

Richard Henderson (13):
      linux-user: Adjust task_unmapped_base for reserved_va
      linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h
      linux-user: Define ELF_ET_DYN_BASE in $guest/target_mman.h
      linux-user: Use MAP_FIXED_NOREPLACE for initial image mmap
      linux-user: Use elf_et_dyn_base for ET_DYN with interpreter
      linux-user: Do not adjust image mapping for host page size
      linux-user: Do not adjust zero_bss for host page size
      linux-user: Use zero_bss for PT_LOAD with no file contents too
      util/selfmap: Rewrite using qemu/interval-tree.h
      linux-user: Remove duplicate CPU_LOG_PAGE from probe_guest_base
      linux-user: Consolidate guest bounds check in probe_guest_base
      linux-user: Rewrite fixed probe_guest_base
      linux-user: Rewrite non-fixed probe_guest_base

 include/qemu/selfmap.h               |  22 +-
 linux-user/aarch64/target_mman.h     |  13 +
 linux-user/alpha/target_mman.h       |  11 +
 linux-user/arm/target_mman.h         |  11 +
 linux-user/cris/target_mman.h        |  12 +
 linux-user/hexagon/target_mman.h     |  13 +
 linux-user/hppa/target_mman.h        |   6 +
 linux-user/i386/target_mman.h        |  16 +
 linux-user/loongarch64/target_mman.h |  11 +
 linux-user/m68k/target_mman.h        |   5 +
 linux-user/microblaze/target_mman.h  |  11 +
 linux-user/mips/target_mman.h        |  10 +
 linux-user/nios2/target_mman.h       |  10 +
 linux-user/openrisc/target_mman.h    |  10 +
 linux-user/ppc/target_mman.h         |  20 +
 linux-user/qemu.h                    |   1 -
 linux-user/riscv/target_mman.h       |  10 +
 linux-user/s390x/target_mman.h       |  20 +
 linux-user/sh4/target_mman.h         |   7 +
 linux-user/sparc/target_mman.h       |  25 ++
 linux-user/user-mmap.h               |  29 +-
 linux-user/x86_64/target_mman.h      |  15 +
 linux-user/xtensa/target_mman.h      |  10 +
 linux-user/elfload.c                 | 792 +++++++++++++++++------------------
 linux-user/main.c                    |  43 ++
 linux-user/mmap.c                    |  19 +-
 linux-user/syscall.c                 |  15 +-
 util/selfmap.c                       | 114 +++--
 28 files changed, 803 insertions(+), 478 deletions(-)

