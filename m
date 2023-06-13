Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D0D72E154
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:22:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90U9-00056H-Pm; Tue, 13 Jun 2023 05:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90U7-000557-In
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:43 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Tr-0005UW-LO
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5183101690cso5398174a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649104; x=1689241104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bTx1+a/WyWm6ROpIJLozu97iOXWSdU3hqQyQmP+ZqJE=;
 b=alPIJsBlgQro50KI2S5lmoYoSXy7bmftQD5+mTlTM0EXSKmAjzF+vfSfDVTn0WT0hA
 nq/i8wE4b0gK7als3aiwrK3zjGbU4zKYD0ZpFrecDn8WAX3IrgT48Mywg8gVCC8NoqMF
 8+gwqYBYimcmD/j7cYahBsTD/wUard4HrljAbDb+crcObtPRWa8xZuW89mhK7vFz5yHm
 6lTPEgVKmzFC6v9MyBZwYZUulx1NW1ZIJRe2gAQiil8vRp3U15Nd7bB72tIvDdrlOzoA
 KB67oIU7ML0mANnAuDp0cgmn+ITx76w2pcV5xLeJLr7fqZ4Wz33zt72D5f8ya7IG7VLR
 qxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649104; x=1689241104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bTx1+a/WyWm6ROpIJLozu97iOXWSdU3hqQyQmP+ZqJE=;
 b=EF5yYCQeQ181pBVXwULwGj7cO1vSxHTUEyJ0mFL69J6mWf8FRbA5t2d7uswPae/t0X
 I5PVwjeuUgM5OmbPBxRkm+T9JE0Uz79Azq4knJQ5LsVBuE654uhtHERTf46aSdL56s1h
 3x98LZYCqOxG3tzMBk3AXvA5rcRPZdZbixld1OwIazQEuhk8yzdz9PyOrr9c1zc5jMV4
 tZGji+W78r2QvYE9jHaOHvJkv8qKgLkW51crnhUOM6Vmj1NPF4Clju7E03hJjpn6xGnp
 1f59eWC2+3rBXytBC8z0kReirn6yEmrNKmC/SlhhSn/KCLtnO8YInaxfd7QUWWJJiTg4
 vUvQ==
X-Gm-Message-State: AC+VfDz76/EPi/PGeLtRz6+lzDuPT0FGZrSWP+qFkFwAZ0eZnO3Yy6uI
 yU6JClFr55KBZ25Ol3XljO3UOFWJ2G4tw/a2pP5piw==
X-Google-Smtp-Source: ACHHUZ6RF61YWbXdM+8i8DCGoOwFs0MgcwN9coPV2Vf/Aash1IA7l3/7k3QNy5RUmqZfxEiMODiCKQ==
X-Received: by 2002:aa7:d89a:0:b0:518:741e:9314 with SMTP id
 u26-20020aa7d89a000000b00518741e9314mr1236648edq.11.1686649104389; 
 Tue, 13 Jun 2023 02:38:24 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 m7-20020aa7d347000000b005149461b1e0sm6144012edr.25.2023.06.13.02.38.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:38:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/17] Misc patches for 2023-06-13
Date: Tue, 13 Jun 2023 11:38:05 +0200
Message-Id: <20230613093822.63750-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Misc patches, some accumulated since too long.

The following changes since commit fdd0df5340a8ebc8de88078387ebc85c5af7b40f:

  Merge tag 'pull-ppc-20230610' of https://gitlab.com/danielhb/qemu into staging (2023-06-10 07:25:00 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/misc-20230613

for you to fetch changes up to b0182e537e5aba38031a5009cb16d5e924342458:

  exec/memory: Introduce RAM_NAMED_FILE flag (2023-06-13 11:28:58 +0200)

----------------------------------------------------------------
Misc patches queue

- user emulation: Preserve environment variable order
- macos/darwin/hvf: Fix build warnings, slighly optimize DCache flush
- target/i386: Minor cleanups, rename  template headers with '.inc' suffix
- target/hppa: Avoid building int_helper.o on user emulation
- hw: Add 'name' property to pca954x, export ISAParallelState, silent warnings
- hw/vfio: Trace number of bitmap dirty pages
- exec/memory: Introduce RAM_NAMED_FILE to distinct block without named backing store

----------------------------------------------------------------

Andreas Schwab (1):
  linux-user, bsd-user: Preserve incoming order of environment variables
    in the target

Antonio Caggiano (1):
  accel/hvf: Report HV_DENIED error

Bernhard Beschow (2):
  hw/char/parallel: Export struct ParallelState
  hw/char/parallel-isa: Export struct ISAParallelState

Joao Martins (2):
  exec/ram_addr: Return number of dirty pages in
    cpu_physical_memory_set_dirty_lebitmap()
  hw/vfio: Add number of dirty pages to vfio_get_dirty_bitmap tracepoint

Niklas Cassel (1):
  hw/ide/ahci: Remove stray backslash

Patrick Venture (1):
  hw/i2c: Enable an id for the pca954x devices

Philippe Mathieu-Daudé (8):
  cocoa: Fix warnings about invalid prototype declarations
  util/cacheflush: Use declarations from <OSCacheControl.h> on Darwin
  util/cacheflush: Avoid possible redundant dcache flush on Darwin
  target/hppa/meson: Only build int_helper.o with system emulation
  target/i386/helper: Remove do_cpu_sipi() stub for user-mode emulation
  target/i386/helper: Shuffle do_cpu_init()
  target/i386: Rename helper template headers as '.h.inc'
  hw/scsi/megasas: Silent GCC duplicated-cond warning

Steve Sistare (1):
  exec/memory: Introduce RAM_NAMED_FILE flag

 MAINTAINERS                                   |  2 +-
 qapi/migration.json                           |  4 +--
 include/exec/cpu-common.h                     |  1 +
 include/exec/memory.h                         |  3 ++
 include/exec/ram_addr.h                       | 28 ++++++++++++----
 include/hw/char/parallel-isa.h                | 30 +++++++++++++++++
 include/hw/char/parallel.h                    | 21 +++++++++++-
 target/i386/cpu.h                             |  3 +-
 target/i386/helper.h                          |  6 ++--
 ...er_template.h => cc_helper_template.h.inc} |  0
 .../ops_sse_header.h.inc}                     |  0
 .../shift_helper_template.h.inc}              |  0
 accel/hvf/hvf-all.c                           |  6 ++++
 backends/hostmem-file.c                       |  1 +
 bsd-user/main.c                               | 10 +++++-
 hw/char/parallel-isa.c                        |  1 +
 hw/char/parallel.c                            | 32 +------------------
 hw/i2c/i2c_mux_pca954x.c                      | 22 +++++++++++++
 hw/i386/pc_piix.c                             |  2 +-
 hw/i386/pc_q35.c                              |  2 +-
 hw/ide/ahci.c                                 |  2 +-
 hw/isa/isa-superio.c                          |  1 +
 hw/scsi/megasas.c                             | 16 ++++++----
 hw/sparc64/sun4u.c                            |  2 +-
 hw/vfio/common.c                              |  7 ++--
 linux-user/main.c                             | 10 +++++-
 migration/ram.c                               |  3 +-
 softmmu/physmem.c                             |  7 +++-
 target/hppa/int_helper.c                      |  3 --
 target/i386/helper.c                          | 15 +++------
 target/i386/tcg/cc_helper.c                   |  8 ++---
 target/i386/tcg/int_helper.c                  |  8 ++---
 util/cacheflush.c                             | 13 ++++++--
 hw/vfio/trace-events                          |  2 +-
 net/vmnet-bridged.m                           |  2 +-
 target/hppa/meson.build                       |  2 +-
 ui/cocoa.m                                    |  2 +-
 37 files changed, 186 insertions(+), 91 deletions(-)
 create mode 100644 include/hw/char/parallel-isa.h
 rename target/i386/tcg/{cc_helper_template.h => cc_helper_template.h.inc} (100%)
 rename target/i386/{ops_sse_header.h => tcg/ops_sse_header.h.inc} (100%)
 rename target/i386/{shift_helper_template.h => tcg/shift_helper_template.h.inc} (100%)

-- 
2.38.1


