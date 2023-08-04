Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47776770BAB
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2qs-0004dF-6B; Fri, 04 Aug 2023 18:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qe-0004Uq-HK
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:42 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qZ-0001ZZ-SL
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso18065145ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186434; x=1691791234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tb9XyHKOb5SGU7mqtfGRTryvUz9tdCg6gmgA7xMrpnU=;
 b=Dw6r8sSCIX7Ipg79t7ZqI5+gmxRvwt6jdWdrIGHN3jdSCswQFLgo8SwifvhODK5ULV
 9cvp2s64b4SWLF2SOCvKiqwdwKjCOLS85smzWjXr6nSEmNl6B+wVNCYiWHtaQD6mk/Xu
 1mU/PoDIfj+5CD/V/Auymu+PFVsx8GRPu95Qn2IlsDX3XnOvyIUxjVOLK8DOh8Q6/bU2
 cuywip03JHr/ZnhYCxka+13UXvva7+9wrV/9+zKQ0lUJzBRacAffTBOC6/2E0/eJTGas
 5S7JojFWeIohzbU1j7HBg8+twgNcV7e/LHgmhkmjUDNF4VX3kuhsSvsuqw/4oX8CJV/U
 zYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186434; x=1691791234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tb9XyHKOb5SGU7mqtfGRTryvUz9tdCg6gmgA7xMrpnU=;
 b=J9KVLOe/LkZ0XYjWKmoYyiPLLOSXeb+WOwuYjHbFPPqWQ//i5CPwr0MY9BUAxctrvn
 JmN9+P7VWN7I+CnfMhATjn9yyDQKg5jJnPNFTXn3NE2Lw/9KtwnsgLpYtamE77GxUSDZ
 +1ZG7zBIBs1cdGg6sHCjkkPe64VBY6HaLPtS+CNvB4F6rEywf9eTYcCX7Wp0ucOM+Cti
 shFpwHmkR25UjX/TlfPh4cTfzaFpwqniVVxI/n62sj2suGRuquwresX+JW3BMz5KIIHj
 vV/5KUktfcSzNwc+zBVXrmV95tQe9rriG4x6D3/mjHD5ttvh0TneQXaAP2Rp7NjMi/aj
 FoHA==
X-Gm-Message-State: AOJu0YzdB0+APyiV2gM6I2MgLGSnTQLHy1dLTxZy7YhCOwdIz6m4oMyo
 dpxv4Mcv+KvkK/btCfAy8uNq7+3M5OnNYO1YZNE=
X-Google-Smtp-Source: AGHT+IGYpn+EXsX7WWvItja+zCV65HvsBG3HzTIATFoe6GItFEX7C92/+aW2S18w/LfunhVtcuIBJA==
X-Received: by 2002:a17:902:ea0b:b0:1b8:4ec2:5200 with SMTP id
 s11-20020a170902ea0b00b001b84ec25200mr2621505plg.2.1691186434090; 
 Fri, 04 Aug 2023 15:00:34 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 for-8.1 00/24] linux-user + tcg patch queue
Date: Fri,  4 Aug 2023 15:00:08 -0700
Message-Id: <20230804220032.295411-1-richard.henderson@linaro.org>
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

Supercedes: 20230804014517.6361-1-richard.henderson@linaro.org
("[PATCH for-8.1 v8 00/17] linux-user: brk fixes")

Changes for linux-user brk v9:
  Recover some changes that should have been in v8, had I
  generated the patches from the correct tree:
    - bsd-user: Remove last_brk
    - Fix typos in patch 15 ("Define ELF_ET_DYN_BASE...")
    - Disable -Werror=type-limits in patch 13
      ("linux-user: Adjust task_unmapped_base")


r~


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
 linux-user/alpha/target_mman.h       |  11 +
 linux-user/arm/target_mman.h         |  11 +
 linux-user/cris/target_mman.h        |  12 ++
 linux-user/hexagon/target_mman.h     |  13 ++
 linux-user/hppa/target_mman.h        |   6 +
 linux-user/i386/target_mman.h        |  16 ++
 linux-user/loongarch64/target_mman.h |  11 +
 linux-user/m68k/target_mman.h        |   5 +
 linux-user/microblaze/target_mman.h  |  11 +
 linux-user/mips/target_mman.h        |  10 +
 linux-user/nios2/target_mman.h       |  10 +
 linux-user/openrisc/target_mman.h    |  10 +
 linux-user/ppc/target_mman.h         |  20 ++
 linux-user/qemu.h                    |   2 -
 linux-user/riscv/target_mman.h       |  10 +
 linux-user/s390x/target_mman.h       |  20 ++
 linux-user/sh4/target_mman.h         |   7 +
 linux-user/sparc/target_mman.h       |  25 +++
 linux-user/user-mmap.h               |   6 +-
 linux-user/x86_64/target_mman.h      |  15 ++
 linux-user/xtensa/target_mman.h      |  10 +
 accel/tcg/cputlb.c                   | 289 ++++++++++++++++++---------
 bsd-user/mmap.c                      |   2 -
 gdbstub/gdbstub.c                    |   2 +-
 linux-user/elfload.c                 | 184 ++++++++---------
 linux-user/flatload.c                |   2 +-
 linux-user/main.c                    |  45 ++++-
 linux-user/mmap.c                    |  68 ++++---
 linux-user/syscall.c                 |  69 ++-----
 31 files changed, 622 insertions(+), 294 deletions(-)

-- 
2.34.1


