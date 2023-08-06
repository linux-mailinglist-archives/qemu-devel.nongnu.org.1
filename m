Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD877136A
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:39:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUa1-0003ZR-CE; Sat, 05 Aug 2023 23:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUZz-0003Z7-Vv
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:20 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUZy-0007VY-47
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:19 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2680f27b52dso1967327a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293036; x=1691897836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=A86bE9TvpuNQjNQpbQTHQeJJYeQauzA3gx8pUe2972A=;
 b=pdLbNe4aI3k380F6raOv81qVhXHUB5pM8dsMioHBZ1EwcTn+2WbiX/tUgprRQIbEDL
 YizvYf2pWmFXh/XduNZ7FwSrqryHbjJiZIansMZRTfh1upRbwJYLO9YkWFVj+BRqOY+/
 VbtQmBE8uenhZ5szti3NWCj6fAaAiu383OZlFWglecpj5gZ3l7FjXuBzV0NN0mKdGn4t
 Cf+mLDapdlzNHKPtAGBpeAzg49k4cX8+ZGdM+76OklwOTDG6Cdedq5seAeJcGXn0VAxM
 JHjeK+nlwGvyJja17Thv79+7flT3TJaaZP0O+7tC5bWRl48RghgZ2W/gX8mjn7Soaa1v
 7/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293036; x=1691897836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A86bE9TvpuNQjNQpbQTHQeJJYeQauzA3gx8pUe2972A=;
 b=h7ueTqknmhAvJEqriOgZOWNGD7/CikwhmsEFHwdYj8w0oOW4q3/+lpFmnF2v1IaVAb
 VAjhnbjSLNe5xcH7DeZOniSSovBXk84SzbcCp/V4eVQKpt5msZV/ynbAI3zhFncsdokJ
 0vLYIv7gJsrQrXloE27pTHcdI5BGNyf2vZOapSU6Sn24UdFrHGxbygPyb0FvQ4sL6LZZ
 pgUpUrLyl72cub4yQVmRyVmK8eqKSmcFOeKgvIohgiAQ0aAWb/WYzIYC4fbmp38fGF2q
 SwsLKH4m/qj47V6W4sDU0dllkE6tZ2LdZn4IpgKG/0ko8rJafxBCY4FH53TessAHGc8Y
 4WFA==
X-Gm-Message-State: AOJu0YzjJbV1JgMBU+0TKDZSXacX0c/OgTBEet2n8cL8Coh3WPMqk4nl
 YVceNdhTQsXEdPhtbQ0pRamt8j9JjABhb/inmc8=
X-Google-Smtp-Source: AGHT+IHt6fUw5x41qmR9QgYmxOsVSnZbtlmxSwGNfMhvIr0P/oTlp+iwuL5hINGHiwRDo92zMC3UXg==
X-Received: by 2002:a17:90a:7087:b0:268:d716:4b62 with SMTP id
 g7-20020a17090a708700b00268d7164b62mr5517483pjk.0.1691293036163; 
 Sat, 05 Aug 2023 20:37:16 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] tcg + linux-user queue for 8.1-rc3
Date: Sat,  5 Aug 2023 20:36:51 -0700
Message-Id: <20230806033715.244648-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

The following changes since commit 6db03ccc7f4ca33c99debaac290066f4500a2dfb:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-08-04 14:47:00 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230805

for you to fetch changes up to 843246699425adfb6b81f927c16c9c6249b51e1d:

  linux-user/elfload: Set V in ELF_HWCAP for RISC-V (2023-08-05 18:17:20 +0000)

----------------------------------------------------------------
accel/tcg: Do not issue misaligned i/o
accel/tcg: Call save_iotlb_data from io_readx
gdbstub: use 0 ("any process") on packets with no PID
linux-user: Fixes for MAP_FIXED_NOREPLACE
linux-user: Fixes for brk
linux-user: Adjust task_unmapped_base for reserved_va
linux-user: Use ELF_ET_DYN_BASE for ET_DYN with interpreter
linux-user: Remove host != guest page size workarounds in brk and image load
linux-user: Set V in ELF_HWCAP for RISC-V
*-user: Remove last_brk as unused

----------------------------------------------------------------
Akihiko Odaki (6):
      linux-user: Unset MAP_FIXED_NOREPLACE for host
      linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
      linux-user: Do not call get_errno() in do_brk()
      linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
      linux-user: Do nothing if too small brk is specified
      linux-user: Do not align brk with host page size

Helge Deller (1):
      linux-user: Adjust initial brk when interpreter is close to executable

Matheus Tavares Bernardino (1):
      gdbstub: use 0 ("any process") on packets with no PID

Mikhail Tyutin (1):
      accel/tcg: Call save_iotlb_data from io_readx as well.

Nathan Egge (1):
      linux-user/elfload: Set V in ELF_HWCAP for RISC-V

Richard Henderson (14):
      accel/tcg: Adjust parameters and locking with do_{ld,st}_mmio_*
      accel/tcg: Issue wider aligned i/o in do_{ld,st}_mmio_*
      accel/tcg: Do not issue misaligned i/o
      linux-user: Remove last_brk
      bsd-user: Remove last_brk
      linux-user: Adjust task_unmapped_base for reserved_va
      linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h
      linux-user: Define ELF_ET_DYN_BASE in $guest/target_mman.h
      linux-user: Use MAP_FIXED_NOREPLACE for initial image mmap
      linux-user: Use elf_et_dyn_base for ET_DYN with interpreter
      linux-user: Properly set image_info.brk in flatload
      linux-user: Do not adjust image mapping for host page size
      linux-user: Do not adjust zero_bss for host page size
      linux-user: Use zero_bss for PT_LOAD with no file contents too

 bsd-user/qemu.h                      |   1 -
 linux-user/aarch64/target_mman.h     |  13 ++
 linux-user/alpha/target_mman.h       |  11 ++
 linux-user/arm/target_mman.h         |  11 ++
 linux-user/cris/target_mman.h        |  12 ++
 linux-user/hexagon/target_mman.h     |  13 ++
 linux-user/hppa/target_mman.h        |   6 +
 linux-user/i386/target_mman.h        |  16 ++
 linux-user/loongarch64/target_mman.h |  11 ++
 linux-user/m68k/target_mman.h        |   5 +
 linux-user/microblaze/target_mman.h  |  11 ++
 linux-user/mips/target_mman.h        |  10 ++
 linux-user/nios2/target_mman.h       |  10 ++
 linux-user/openrisc/target_mman.h    |  10 ++
 linux-user/ppc/target_mman.h         |  20 +++
 linux-user/qemu.h                    |   2 -
 linux-user/riscv/target_mman.h       |  10 ++
 linux-user/s390x/target_mman.h       |  20 +++
 linux-user/sh4/target_mman.h         |   7 +
 linux-user/sparc/target_mman.h       |  25 +++
 linux-user/user-mmap.h               |   6 +-
 linux-user/x86_64/target_mman.h      |  15 ++
 linux-user/xtensa/target_mman.h      |  10 ++
 accel/tcg/cputlb.c                   | 289 +++++++++++++++++++++++------------
 bsd-user/mmap.c                      |   2 -
 gdbstub/gdbstub.c                    |   2 +-
 linux-user/elfload.c                 | 184 ++++++++++------------
 linux-user/flatload.c                |   2 +-
 linux-user/main.c                    |  45 +++++-
 linux-user/mmap.c                    |  68 +++++----
 linux-user/syscall.c                 |  69 ++-------
 31 files changed, 622 insertions(+), 294 deletions(-)

