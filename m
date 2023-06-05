Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D207D723324
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 00:26:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Icn-0008GM-U0; Mon, 05 Jun 2023 18:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Icm-0008Fc-AF
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:24:28 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Ici-0005tR-UX
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:24:28 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30ae901a9ffso4875114f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686003863; x=1688595863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mqZmZIlPEGAgCzEJ/QPGUj5Qrx06/TdJYR7ockJ5GRY=;
 b=PFIarrJx09Y+DuQcbfhH5vCcGW9I/QaI31BgzaBVf4QHKdX9VIjB41EYoqKn0w4Mae
 F9S4z7PCOfFJPoJe+xlQQ8EPhFya0WWUN/iDkstDDfIdx4dLo2CZJR1r5QdHEl0vs+m+
 lGcIo137qrgLGAGGCujIPQ7J/O6NxkwmKXkMD9E/Z6LVUKafzyO/567A78PC1uEzpmE5
 vjtp0QuGxiOOHmV3O0elK6YtV6yjIfg8XD8UbdTQ2S1WHd5+ieQpDPoH7M2DmSaD+BIq
 em6y+O1REFUGZsnfrv2NNaQNVJc2CcxCwqQ5WYh3nRFmRx/ZVnOYGIe83U1D9jtAJVip
 DFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686003863; x=1688595863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mqZmZIlPEGAgCzEJ/QPGUj5Qrx06/TdJYR7ockJ5GRY=;
 b=czeeyh+o8vjYmx8X9WqZd7ueduTbj91GWgKnjNo5HNxP7IzhBwXRBmJTua8+BU0l05
 LpzbdS2AxeqMCefZMWWBxYziRQgpAQn7OkMT/4xBISLPpdksgk0PdVJTYHY75V65nJWs
 KBE2ixw/PRGnTdYOh7+Gr1wDjds085c9N8fBHdg/KbdnSqT4EzFcxeN1uyHP6IVbgT3l
 ijtaW62HZNGfNfhheA7aqaAElluuylydZlXQu2nSe2y4PhW1YrIpCRss/vhIqeEF5fSV
 jyyUEpddNYv/tt1kNMJ9Vt3AusS7afGRPBNqwmhV4nss0myZXXrzTvmZcHptXQtjkQI3
 CFPA==
X-Gm-Message-State: AC+VfDySMWhQaqHRpluhP993bZup6V7rErWBzJig5vpTSrcHmS1mt8S4
 eNKuNQK6qpgTAy539UY4aV7JaWSfz/d0pcPvsE0=
X-Google-Smtp-Source: ACHHUZ5L/nMJVZSFoW9h3xFVgX7mij28uWcSaOU15MuqJHqT1gS82kH4AYOORQDLFtkJx8cGCA1o8Q==
X-Received: by 2002:a5d:56d2:0:b0:30a:ec6c:913 with SMTP id
 m18-20020a5d56d2000000b0030aec6c0913mr284360wrw.10.1686003862808; 
 Mon, 05 Jun 2023 15:24:22 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 y4-20020adfe6c4000000b00307bc4e39e5sm10756755wrm.117.2023.06.05.15.24.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 15:24:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 0/9] bulk: Replace CONFIG_SOFTMMU by
 !CONFIG_USER_ONLY/CONFIG_SYSTEM_ONLY
Date: Tue,  6 Jun 2023 00:24:11 +0200
Message-Id: <20230605222420.14776-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Richard clarified my confusion with CONFIG_SOFTMMU from v1:
https://lore.kernel.org/qemu-devel/7913570a-8bf6-2ac9-6869-fab87273742c@linaro.org/

This series tries to make it a bit more explicit by removing
mentions of CONFIG_SOFTMMU in non-TCG code.

We replace CONFIG_SOFTMMU by !CONFIG_USER_ONLY in C code and
by CONFIG_SYSTEM_ONLY in meson config files.

Philippe Mathieu-Daudé (9):
  target/tricore: Remove pointless CONFIG_SOFTMMU guard
  target/i386: Check for USER_ONLY definition instead of SOFTMMU one
  target/m68k: Check for USER_ONLY definition instead of SOFTMMU one
  target/ppc: Check for USER_ONLY definition instead of SOFTMMU one
  hw/core/cpu: Check for USER_ONLY definition instead of SOFTMMU one
  accel/tcg: Check for USER_ONLY definition instead of SOFTMMU one
  meson: Alias CONFIG_SOFTMMU -> CONFIG_SYSTEM_ONLY
  meson: Replace CONFIG_SOFTMMU -> CONFIG_SYSTEM_ONLY
  meson: Replace softmmu_ss -> system_ss

 docs/devel/build-system.rst        |  14 +--
 meson.build                        |  15 +--
 accel/tcg/internal.h               |   6 +-
 include/hw/core/cpu.h              |   4 +-
 include/hw/core/tcg-cpu-ops.h      | 102 ++++++++++-----------
 target/m68k/helper.h               |   2 +-
 accel/tcg/cpu-exec.c               |   4 +-
 target/i386/tcg/translate.c        |   2 +-
 target/m68k/cpu.c                  |  14 ++-
 target/m68k/helper.c               |   4 +-
 target/m68k/translate.c            |  28 +++---
 target/ppc/cpu_init.c              |  20 ++--
 target/ppc/helper_regs.c           |   6 +-
 target/tricore/helper.c            |   2 -
 accel/meson.build                  |   4 +-
 accel/qtest/meson.build            |   2 +-
 accel/stubs/meson.build            |   2 +-
 accel/tcg/meson.build              |   6 +-
 audio/meson.build                  |   8 +-
 backends/meson.build               |  20 ++--
 backends/tpm/meson.build           |   8 +-
 block/meson.build                  |   6 +-
 block/monitor/meson.build          |   2 +-
 chardev/meson.build                |   2 +-
 disas/meson.build                  |   2 +-
 dump/meson.build                   |   4 +-
 ebpf/meson.build                   |   2 +-
 fsdev/meson.build                  |   4 +-
 gdbstub/meson.build                |  10 +-
 hw/9pfs/meson.build                |   2 +-
 hw/acpi/meson.build                |  10 +-
 hw/adc/meson.build                 |  10 +-
 hw/arm/meson.build                 |   8 +-
 hw/audio/meson.build               |  28 +++---
 hw/block/meson.build               |  28 +++---
 hw/char/meson.build                |  70 +++++++-------
 hw/core/meson.build                |  22 ++---
 hw/cpu/meson.build                 |   6 +-
 hw/cxl/meson.build                 |   4 +-
 hw/display/meson.build             |  76 +++++++--------
 hw/dma/meson.build                 |  32 +++----
 hw/gpio/meson.build                |  26 +++---
 hw/i2c/meson.build                 |   2 +-
 hw/i386/kvm/meson.build            |   2 +-
 hw/ide/meson.build                 |  28 +++---
 hw/input/meson.build               |  32 +++----
 hw/intc/meson.build                |  44 ++++-----
 hw/ipack/meson.build               |   2 +-
 hw/ipmi/meson.build                |   2 +-
 hw/isa/meson.build                 |  18 ++--
 hw/mem/meson.build                 |   8 +-
 hw/misc/macio/meson.build          |   2 +-
 hw/misc/meson.build                | 142 ++++++++++++++---------------
 hw/net/can/meson.build             |  14 +--
 hw/net/meson.build                 |  96 +++++++++----------
 hw/nubus/meson.build               |   2 +-
 hw/nvme/meson.build                |   2 +-
 hw/nvram/meson.build               |  26 +++---
 hw/pci-bridge/meson.build          |   4 +-
 hw/pci-host/meson.build            |   2 +-
 hw/pci/meson.build                 |   8 +-
 hw/pcmcia/meson.build              |   4 +-
 hw/rdma/meson.build                |   2 +-
 hw/remote/meson.build              |   2 +-
 hw/rtc/meson.build                 |  28 +++---
 hw/scsi/meson.build                |   2 +-
 hw/sd/meson.build                  |  24 ++---
 hw/sensor/meson.build              |  18 ++--
 hw/smbios/meson.build              |   6 +-
 hw/ssi/meson.build                 |  26 +++---
 hw/timer/meson.build               |  74 +++++++--------
 hw/tpm/meson.build                 |  14 +--
 hw/usb/meson.build                 |  74 +++++++--------
 hw/virtio/meson.build              |  12 +--
 hw/watchdog/meson.build            |  18 ++--
 hw/xen/meson.build                 |   4 +-
 migration/meson.build              |  12 +--
 monitor/meson.build                |   6 +-
 net/can/meson.build                |   2 +-
 net/meson.build                    |  38 ++++----
 qapi/meson.build                   |   2 +-
 qom/meson.build                    |   2 +-
 replay/meson.build                 |   2 +-
 semihosting/meson.build            |   2 +-
 softmmu/meson.build                |  12 +--
 stats/meson.build                  |   2 +-
 target/alpha/meson.build           |   6 +-
 target/arm/hvf/meson.build         |   2 +-
 target/arm/meson.build             |   6 +-
 target/arm/tcg/meson.build         |   2 +-
 target/avr/meson.build             |   6 +-
 target/cris/meson.build            |   6 +-
 target/hppa/meson.build            |   6 +-
 target/i386/hax/meson.build        |   6 +-
 target/i386/hvf/meson.build        |   2 +-
 target/i386/kvm/meson.build        |   4 +-
 target/i386/meson.build            |   8 +-
 target/i386/nvmm/meson.build       |   4 +-
 target/i386/tcg/sysemu/meson.build |   2 +-
 target/i386/whpx/meson.build       |   2 +-
 target/loongarch/meson.build       |   6 +-
 target/m68k/meson.build            |   6 +-
 target/microblaze/meson.build      |   6 +-
 target/mips/meson.build            |   4 +-
 target/mips/sysemu/meson.build     |   2 +-
 target/mips/tcg/sysemu/meson.build |   2 +-
 target/nios2/meson.build           |   6 +-
 target/openrisc/meson.build        |   6 +-
 target/ppc/meson.build             |  10 +-
 target/riscv/meson.build           |   6 +-
 target/s390x/kvm/meson.build       |   2 +-
 target/s390x/meson.build           |   6 +-
 target/sh4/meson.build             |   6 +-
 target/sparc/meson.build           |   6 +-
 target/tricore/meson.build         |   4 +-
 target/xtensa/meson.build          |   6 +-
 tcg/meson.build                    |   2 +-
 trace/meson.build                  |   2 +-
 ui/meson.build                     |  30 +++---
 119 files changed, 813 insertions(+), 818 deletions(-)

-- 
2.38.1


