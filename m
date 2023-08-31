Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BFE78EAE5
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBJ-0003n9-FM; Thu, 31 Aug 2023 06:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAz-0003I0-Th
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAw-00042B-DZ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31c73c21113so485567f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478721; x=1694083521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=L/BROq7YSFk7hTexo83CnJUGJbbaJkyOOUOlHRoJZHE=;
 b=VhMwAOZ88Pzjn7IB0LLuQW4DtuaJ0jEAa2ezxx5LrmyfHY+42hJgN+arJYbD3MRgqK
 oE2CU+Qmkyagml92yTYmGQcNaVNH8u/Q8vJqnM8Beb9Jfsmyu4j3ahxvmFce2JpL1MVD
 xVbpWgNd5gg+vlf+VA+LfKpp/pAUv5/uKBBVJ1JVVKX/yvHwSkAgi/Zx3zJIiiW2xPDl
 TyoMZJ9ECGoI5PIXwBZ953uvIfdWU3DhzcpyDiIcznw+SZVkKYvyl25TNZ0pJqnBwVYS
 dCIR+M4Gt5lCHKBJWVfv+ybmUQn/7Imam7MQraNUbHtq+qWlQYF+LXNVSBDcujBOEjXs
 hDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478721; x=1694083521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/BROq7YSFk7hTexo83CnJUGJbbaJkyOOUOlHRoJZHE=;
 b=dvcerpBeqIneN21qGvO03GXJEGnlJSI/C1X2ioTLff0o0c34Q7jn4MzHNVo14+JwJW
 K2rFDSHW8xQJMb7SPzpsxCaFtsUWEXWtHiocJgvzGt/WtRZBnXJnvUxs2F5RU7kBHcpY
 wfjM2V78tsX3b2hubGaykYuGhSIXC3+l4+hAbSQjf+cUF8c3Gj69N1VVOcwUtprNLgWp
 ylfof7Ya+54SRzgdXKqxgnxcFhB8b7sUpauxhSh461j6axf+FY2CIxbfXRXMyJssyYvg
 2KrT1715/xz6cTVMbuoEiZs4i2Zr3hpwVQYQhU00tkE9KxcZCED4cK2yWmpS0Gwt4U3G
 EmoQ==
X-Gm-Message-State: AOJu0YwIy2Q9B4JjPtyyY1HqzRPUkbS1zqsE8Hx2h7gvTXp44oe0qdFf
 VwTfUvuK845Uzz318h6Mrm2XfyoUCH8Dmg2cCeY=
X-Google-Smtp-Source: AGHT+IHjqmkbTHjT9f4q/EAVi+5w7dTfIKtuz/I+HZWMoEIOohadvC49L+wGh7aPAb/icShZznZ0aA==
X-Received: by 2002:adf:e50e:0:b0:319:7472:f0b6 with SMTP id
 j14-20020adfe50e000000b003197472f0b6mr3407510wrm.15.1693478720602; 
 Thu, 31 Aug 2023 03:45:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] target-arm queue
Date: Thu, 31 Aug 2023 11:44:55 +0100
Message-Id: <20230831104519.3520658-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Hi; here's the latest round of arm patches. I have included also
my patchset for the RTC devices to avoid keeping time_t and
time_t diffs in 32-bit variables.

thanks
-- PMM

The following changes since commit 156618d9ea67f2f2e31d9dedd97f2dcccbe6808c:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-08-30 09:20:27 -0400)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230831

for you to fetch changes up to e73b8bb8a3e9a162f70e9ffbf922d4fafc96bbfb:

  hw/arm: Set number of MPU regions correctly for an505, an521, an524 (2023-08-31 11:07:02 +0100)

----------------------------------------------------------------
target-arm queue:
 * Some of the preliminary patches for Cortex-A710 support
 * i.MX7 and i.MX6UL refactoring
 * Implement SRC device for i.MX7
 * Catch illegal-exception-return from EL3 with bad NSE/NS
 * Use 64-bit offsets for holding time_t differences in RTC devices
 * Model correct number of MPU regions for an505, an521, an524 boards

----------------------------------------------------------------
Alex Bennée (1):
      target/arm: properly document FEAT_CRC32

Jean-Christophe Dubois (6):
      Remove i.MX7 IOMUX GPR device from i.MX6UL
      Refactor i.MX6UL processor code
      Add i.MX6UL missing devices.
      Refactor i.MX7 processor code
      Add i.MX7 missing TZ devices and memory regions
      Add i.MX7 SRC device implementation

Peter Maydell (8):
      target/arm: Catch illegal-exception-return from EL3 with bad NSE/NS
      hw/rtc/m48t59: Use 64-bit arithmetic in set_alarm()
      hw/rtc/twl92230: Use int64_t for sec_offset and alm_sec
      hw/rtc/aspeed_rtc: Use 64-bit offset for holding time_t difference
      rtc: Use time_t for passing and returning time offsets
      target/arm: Do all "ARM_FEATURE_X implies Y" checks in post_init
      hw/arm/armv7m: Add mpu-ns-regions and mpu-s-regions properties
      hw/arm: Set number of MPU regions correctly for an505, an521, an524

Richard Henderson (9):
      target/arm: Reduce dcz_blocksize to uint8_t
      target/arm: Allow cpu to configure GM blocksize
      target/arm: Support more GM blocksizes
      target/arm: When tag memory is not present, set MTE=1
      target/arm: Introduce make_ccsidr64
      target/arm: Apply access checks to neoverse-n1 special registers
      target/arm: Apply access checks to neoverse-v1 special registers
      target/arm: Suppress FEAT_TRBE (Trace Buffer Extension)
      target/arm: Implement FEAT_HPDS2 as a no-op

 docs/system/arm/emulation.rst  |   2 +
 include/hw/arm/armsse.h        |   5 +
 include/hw/arm/armv7m.h        |   8 +
 include/hw/arm/fsl-imx6ul.h    | 158 ++++++++++++++++---
 include/hw/arm/fsl-imx7.h      | 338 ++++++++++++++++++++++++++++++-----------
 include/hw/misc/imx7_src.h     |  66 ++++++++
 include/hw/rtc/aspeed_rtc.h    |   2 +-
 include/sysemu/rtc.h           |   4 +-
 target/arm/cpregs.h            |   2 +
 target/arm/cpu.h               |   5 +-
 target/arm/internals.h         |   6 -
 target/arm/tcg/translate.h     |   2 +
 hw/arm/armsse.c                |  16 ++
 hw/arm/armv7m.c                |  21 +++
 hw/arm/fsl-imx6ul.c            | 174 +++++++++++++--------
 hw/arm/fsl-imx7.c              | 201 +++++++++++++++++++-----
 hw/arm/mps2-tz.c               |  29 ++++
 hw/misc/imx7_src.c             | 276 +++++++++++++++++++++++++++++++++
 hw/rtc/aspeed_rtc.c            |   5 +-
 hw/rtc/m48t59.c                |   2 +-
 hw/rtc/twl92230.c              |   4 +-
 softmmu/rtc.c                  |   4 +-
 target/arm/cpu.c               | 207 ++++++++++++++-----------
 target/arm/helper.c            |  15 +-
 target/arm/tcg/cpu32.c         |   2 +-
 target/arm/tcg/cpu64.c         | 102 +++++++++----
 target/arm/tcg/helper-a64.c    |   9 ++
 target/arm/tcg/mte_helper.c    |  90 ++++++++---
 target/arm/tcg/translate-a64.c |   5 +-
 hw/misc/meson.build            |   1 +
 hw/misc/trace-events           |   4 +
 31 files changed, 1393 insertions(+), 372 deletions(-)
 create mode 100644 include/hw/misc/imx7_src.h
 create mode 100644 hw/misc/imx7_src.c

