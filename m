Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B677081E0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6P-0004BN-0q; Thu, 18 May 2023 08:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd68-00048O-Dl
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:12 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd66-0007v5-Ha
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:12 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-307d20548adso1319360f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414268; x=1687006268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xyZ+yRLKxPu8d42gJ+4VmG2lBQR5ijzJ4kZJMeAftsA=;
 b=w6uzSn7CcSpe8ska8CSD1QSGoTru7yIJcoCLJ0Vs01S7GDQjB1M6hBEhuxFfJpBH/7
 j3lEzVzvwy9yEk6q5mCPV67K8pW+J3mqohrIZhV2Fc8NUWQ5bFG+7hBps9CGGdUL5EA6
 0GXGbfBMha0upFYBf/cvHXY4NqmZVltycKUAyOfWZNhkZR1/MPyGRMm/eDn3wMeE7eUc
 t9UXKkDze0TiXFit4tcv1OxLaA8bEmZ7bkbGD2e7+/irYij1JvvSHXAzbMutiDGuhJa2
 AXuKWGS19gvW6TuqJHL+hJg10oJPAJbVWnWYEBVvOXLjKGYE+JL0CrF6c3+5PWXsMd0Z
 XQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414268; x=1687006268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xyZ+yRLKxPu8d42gJ+4VmG2lBQR5ijzJ4kZJMeAftsA=;
 b=T7WVOvOud9HfIVmOI6MSZFplHrJhUF+37cqLbkqRZgc57XAVkhkx6wskf8Xxu3Q7XY
 67FhNPfZKSJzlaRbhy8Jj1PRU3SH3gF2CqTE2N381gVGvzHqK5eKBy50DHWHGi/CUWsz
 sdIDCdn6h88Isl+7sszWji8rsbRljyWH/alrrswwKv0kg3/gO8qVolyv028Dz0hR5Hdu
 vvpTC8PRCcBw29+EJF1b+liFRhQMzwRmr1ak7vN64TbGufzE8BT1ZBta/rF1Y8V49kDY
 ADctvqgk9LrD6YgkC3hIjgPY2o8wBLoogytIz+AizYUl693BafrKhwYvew7qsQR8/nU0
 9H4A==
X-Gm-Message-State: AC+VfDxYE6GQVEmQ6hzu+8HRZgxYbjBWoGqD6zhG7MSQLU+HL3/nhOMt
 4/MuEcADYqrnSgrZCY9E9dNrFl6IxY1Rj1QqkFA=
X-Google-Smtp-Source: ACHHUZ4T+yO2Tfk6E53c3vxYLHL00Ch+2cLxFOdDVndQmKn2LHQeA3cXKvBgtFJ8Tv4DqGtCIQhNbg==
X-Received: by 2002:adf:edc4:0:b0:306:3b5f:45e2 with SMTP id
 v4-20020adfedc4000000b003063b5f45e2mr1300571wro.69.1684414268641; 
 Thu, 18 May 2023 05:51:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] target-arm queue
Date: Thu, 18 May 2023 13:50:38 +0100
Message-Id: <20230518125107.146421-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi; this mostly contains the first slice of A64 decodetree
patches, plus some other minor pieces. It also has the
enablement of MTE for KVM guests.

thanks
-- PMM

The following changes since commit d27e7c359330ba7020bdbed7ed2316cb4cf6ffc1:

  qapi/parser: Drop two bad type hints for now (2023-05-17 10:18:33 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230518

for you to fetch changes up to 91608e2a44f36e79cb83f863b8a7bb57d2c98061:

  docs: Convert u2f.txt to rST (2023-05-18 11:40:32 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix vd == vm overlap in sve_ldff1_z
 * Add support for MTE with KVM guests
 * Add RAZ/WI handling for DBGDTR[TX|RX]
 * Start of conversion of A64 decoder to decodetree
 * Saturate L2CTLR_EL1 core count field rather than overflowing
 * vexpress: Avoid trivial memory leak of 'flashalias'
 * sbsa-ref: switch default cpu core to Neoverse-N1
 * sbsa-ref: use Bochs graphics card instead of VGA
 * MAINTAINERS: Add Marcin Juszkiewicz to sbsa-ref reviewer list
 * docs: Convert u2f.txt to rST

----------------------------------------------------------------
Alex Bennée (1):
      target/arm: add RAZ/WI handling for DBGDTR[TX|RX]

Cornelia Huck (1):
      arm/kvm: add support for MTE

Marcin Juszkiewicz (3):
      sbsa-ref: switch default cpu core to Neoverse-N1
      Maintainers: add myself as reviewer for sbsa-ref
      sbsa-ref: use Bochs graphics card instead of VGA

Peter Maydell (14):
      target/arm: Create decodetree skeleton for A64
      target/arm: Pull calls to disas_sve() and disas_sme() out of legacy decoder
      target/arm: Convert Extract instructions to decodetree
      target/arm: Convert unconditional branch immediate to decodetree
      target/arm: Convert CBZ, CBNZ to decodetree
      target/arm: Convert TBZ, TBNZ to decodetree
      target/arm: Convert conditional branch insns to decodetree
      target/arm: Convert BR, BLR, RET to decodetree
      target/arm: Convert BRA[AB]Z, BLR[AB]Z, RETA[AB] to decodetree
      target/arm: Convert BRAA, BRAB, BLRAA, BLRAB to decodetree
      target/arm: Convert ERET, ERETAA, ERETAB to decodetree
      target/arm: Saturate L2CTLR_EL1 core count field rather than overflowing
      hw/arm/vexpress: Avoid trivial memory leak of 'flashalias'
      docs: Convert u2f.txt to rST

Richard Henderson (10):
      target/arm: Fix vd == vm overlap in sve_ldff1_z
      target/arm: Split out disas_a64_legacy
      target/arm: Convert PC-rel addressing to decodetree
      target/arm: Split gen_add_CC and gen_sub_CC
      target/arm: Convert Add/subtract (immediate) to decodetree
      target/arm: Convert Add/subtract (immediate with tags) to decodetree
      target/arm: Replace bitmask64 with MAKE_64BIT_MASK
      target/arm: Convert Logical (immediate) to decodetree
      target/arm: Convert Move wide (immediate) to decodetree
      target/arm: Convert Bitfield to decodetree

 MAINTAINERS                      |    1 +
 docs/system/device-emulation.rst |    1 +
 docs/system/devices/usb-u2f.rst  |   93 +++
 docs/system/devices/usb.rst      |    2 +-
 docs/u2f.txt                     |  110 ----
 target/arm/cpu.h                 |    4 +
 target/arm/kvm_arm.h             |   19 +
 target/arm/tcg/translate.h       |    5 +
 target/arm/tcg/a64.decode        |  152 +++++
 hw/arm/sbsa-ref.c                |    4 +-
 hw/arm/vexpress.c                |   40 +-
 hw/arm/virt.c                    |   73 ++-
 target/arm/cortex-regs.c         |   11 +-
 target/arm/cpu.c                 |    9 +-
 target/arm/debug_helper.c        |   11 +-
 target/arm/kvm.c                 |   35 +
 target/arm/kvm64.c               |    5 +
 target/arm/tcg/sve_helper.c      |    6 +
 target/arm/tcg/translate-a64.c   | 1321 ++++++++++++++++----------------------
 target/arm/tcg/meson.build       |    1 +
 20 files changed, 979 insertions(+), 924 deletions(-)
 create mode 100644 docs/system/devices/usb-u2f.rst
 delete mode 100644 docs/u2f.txt
 create mode 100644 target/arm/tcg/a64.decode

