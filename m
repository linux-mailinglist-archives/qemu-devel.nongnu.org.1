Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F727459E9
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:14:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRd-00032f-Kx; Mon, 03 Jul 2023 06:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRR-0002qL-8R
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:01 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRG-0005gQ-CR
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:56 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f8735ac3e3so6573085e87.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378722; x=1690970722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rls68f00SWeRuza9ZKAO8yZ/AGYqIMDybNYbvKECu1g=;
 b=nkSjumVicdzC27SRTZEB3AtImBAFO1+BYfXFCvS7pGcGEC8X1k/gavfjnZ6VUerCVZ
 KMTg6dIQmO4N4g7h6dk1cM+chaveZ3QSNd9zSwiG4eIZkK/7MsC746zzgpoKzLJBFiJS
 laxOApUcsVimSi7t3fdVhdCM+uRhJYVu6Xu1WfHx2rNTlZPxWET61t8cd8T4Mc7vaEzq
 eRTtx28RPyBkuqRrgj3GfaOkxNpIQTNycYKNQOkfS5gUO0V0qyF5FQ3iSxhfunbjehCx
 n9fbkTUT4y/trTEcmCaZNw0N+kAMIkv/S7V2QyaTRDIXu/NTdMcefOliXF1YOHfaChtC
 B+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378722; x=1690970722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rls68f00SWeRuza9ZKAO8yZ/AGYqIMDybNYbvKECu1g=;
 b=KI92Jdo1OjkaZ1ZQxc6Xy4ie6qrJRgNnjAFQoXZ8dpIUfVkCfEeXiw6Hv2w5FeznZY
 oioBYDm5caxPjv0GTHE7VlrgjStgur7aybGh6yF9hR5F1Qzy3XzrqwrBez6ig1ehczGr
 kjIKSJLLHV4fNoNUXs7bozP43eflrT5tL2uZ5kQqT2RMSkX1NOw2smFf9neersX18lMi
 rmjdZmK7UcM6pKpJd8fTBztztxD3P5NEHH2GZHNl5Wd0sjl+KQWaVTyg0HJxcp74F06q
 4G1Q8lGZ94/tTXavQkgUUVZlJ3fL9b3UcWECnE/8/AyakA7dbyGD1O1mWC3ZE+zDmSpf
 N3Qw==
X-Gm-Message-State: ABy/qLYAHb/UXFJBBDQNh/hqvKlkN2L7Pb+TOJl4cJFQyF8KCvX6JVQN
 +JwZO5ek5P/B+ApRHgp6rR9THGBi2lUVinyAAV/N0w==
X-Google-Smtp-Source: APBJJlFbm2c1wdv68Rx7DIZdWH8M68O7qsfMzHEqalQtbX33cPJgwXpTJWcCXVXytBlshylWrdy/5w==
X-Received: by 2002:a05:6512:3b9c:b0:4f8:5960:49a9 with SMTP id
 g28-20020a0565123b9c00b004f8596049a9mr8221404lfv.23.1688378722546; 
 Mon, 03 Jul 2023 03:05:22 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
Subject: [PATCH v4 00/37] crypto: Provide aes-round.h and host accel
Date: Mon,  3 Jul 2023 12:04:43 +0200
Message-Id: <20230703100520.68224-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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

Inspired by Ard Biesheuvel's RFC patches for accelerating AES
under emulation, provide a set of primitives that maps between
the guest and host fragments.

Changes for v4:
  * Fix typo in AESState (Max Chou)
  * Define AES_SH/ISH as macros (Ard Biesheuvel)
  * Group patches by subsystem.

Patches lacking review:
  12-host-include-i386-Implement-aes-round.h.patch
  13-host-include-aarch64-Implement-aes-round.h.patch
  21-target-i386-Use-aesdec_IMC.patch
  22-target-i386-Use-aesenc_SB_SR_MC_AK.patch
  23-target-i386-Use-aesdec_ISB_ISR_IMC_AK.patch
  25-target-arm-Use-aesenc_SB_SR_AK.patch
  26-target-arm-Use-aesdec_ISB_ISR_AK.patch
  27-target-arm-Use-aesenc_MC.patch
  28-target-arm-Use-aesdec_IMC.patch
  29-target-riscv-Use-aesenc_SB_SR_AK.patch
  30-target-riscv-Use-aesdec_ISB_ISR_AK.patch
  31-target-riscv-Use-aesdec_IMC.patch
  32-target-riscv-Use-aesenc_SB_SR_MC_AK.patch
  33-target-riscv-Use-aesdec_ISB_ISR_IMC_AK.patch

Daniel(s), I could push the set that has been reviewed
(crypto/, DPB; target/ppc/, DHB) through tcg-next if you like,
just to reduce the outstanding set.  Perhaps smaller patch sets
would help getting the other targets reviewed...


r~


Richard Henderson (37):
  util: Add cpuinfo-ppc.c
  tests/multiarch: Add test-aes
  target/arm: Move aesmc and aesimc tables to crypto/aes.c
  crypto/aes: Add AES_SH, AES_ISH macros
  crypto: Add aesenc_SB_SR_AK
  crypto: Add aesdec_ISB_ISR_AK
  crypto: Add aesenc_MC
  crypto: Add aesdec_IMC
  crypto: Add aesenc_SB_SR_MC_AK
  crypto: Add aesdec_ISB_ISR_IMC_AK
  crypto: Add aesdec_ISB_ISR_AK_IMC
  host/include/i386: Implement aes-round.h
  host/include/aarch64: Implement aes-round.h
  host/include/ppc: Implement aes-round.h
  target/ppc: Use aesenc_SB_SR_AK
  target/ppc: Use aesdec_ISB_ISR_AK
  target/ppc: Use aesenc_SB_SR_MC_AK
  target/ppc: Use aesdec_ISB_ISR_AK_IMC
  target/i386: Use aesenc_SB_SR_AK
  target/i386: Use aesdec_ISB_ISR_AK
  target/i386: Use aesdec_IMC
  target/i386: Use aesenc_SB_SR_MC_AK
  target/i386: Use aesdec_ISB_ISR_IMC_AK
  target/arm: Demultiplex AESE and AESMC
  target/arm: Use aesenc_SB_SR_AK
  target/arm: Use aesdec_ISB_ISR_AK
  target/arm: Use aesenc_MC
  target/arm: Use aesdec_IMC
  target/riscv: Use aesenc_SB_SR_AK
  target/riscv: Use aesdec_ISB_ISR_AK
  target/riscv: Use aesdec_IMC
  target/riscv: Use aesenc_SB_SR_MC_AK
  target/riscv: Use aesdec_ISB_ISR_IMC_AK
  crypto: Remove AES_shifts, AES_ishifts
  crypto: Implement aesdec_IMC with AES_imc_rot
  crypto: Remove AES_imc
  crypto: Unexport AES_*_rot, AES_TeN, AES_TdN

 MAINTAINERS                                  |   1 +
 meson.build                                  |   9 +
 host/include/aarch64/host/cpuinfo.h          |   1 +
 host/include/aarch64/host/crypto/aes-round.h | 205 +++++
 host/include/generic/host/crypto/aes-round.h |  33 +
 host/include/i386/host/cpuinfo.h             |   1 +
 host/include/i386/host/crypto/aes-round.h    | 152 ++++
 host/include/ppc/host/cpuinfo.h              |  30 +
 host/include/ppc/host/crypto/aes-round.h     | 182 +++++
 host/include/ppc64/host/cpuinfo.h            |   1 +
 host/include/ppc64/host/crypto/aes-round.h   |   1 +
 host/include/x86_64/host/crypto/aes-round.h  |   1 +
 include/crypto/aes-round.h                   | 164 ++++
 include/crypto/aes.h                         |  30 -
 target/arm/helper.h                          |   2 +
 target/i386/ops_sse.h                        |  60 +-
 tcg/ppc/tcg-target.h                         |  16 +-
 target/arm/tcg/sve.decode                    |   4 +-
 crypto/aes.c                                 | 780 ++++++++++++-------
 target/arm/tcg/crypto_helper.c               | 249 ++----
 target/arm/tcg/translate-a64.c               |  13 +-
 target/arm/tcg/translate-neon.c              |   4 +-
 target/arm/tcg/translate-sve.c               |   8 +-
 target/ppc/int_helper.c                      |  50 +-
 target/riscv/crypto_helper.c                 | 138 +---
 tests/tcg/aarch64/test-aes.c                 |  58 ++
 tests/tcg/i386/test-aes.c                    |  68 ++
 tests/tcg/ppc64/test-aes.c                   | 116 +++
 tests/tcg/riscv64/test-aes.c                 |  76 ++
 util/cpuinfo-aarch64.c                       |   2 +
 util/cpuinfo-i386.c                          |   3 +
 util/cpuinfo-ppc.c                           |  64 ++
 tcg/ppc/tcg-target.c.inc                     |  44 +-
 tests/tcg/multiarch/test-aes-main.c.inc      | 183 +++++
 tests/tcg/aarch64/Makefile.target            |   4 +
 tests/tcg/i386/Makefile.target               |   4 +
 tests/tcg/ppc64/Makefile.target              |   1 +
 tests/tcg/riscv64/Makefile.target            |  13 +
 util/meson.build                             |   2 +
 39 files changed, 2049 insertions(+), 724 deletions(-)
 create mode 100644 host/include/aarch64/host/crypto/aes-round.h
 create mode 100644 host/include/generic/host/crypto/aes-round.h
 create mode 100644 host/include/i386/host/crypto/aes-round.h
 create mode 100644 host/include/ppc/host/cpuinfo.h
 create mode 100644 host/include/ppc/host/crypto/aes-round.h
 create mode 100644 host/include/ppc64/host/cpuinfo.h
 create mode 100644 host/include/ppc64/host/crypto/aes-round.h
 create mode 100644 host/include/x86_64/host/crypto/aes-round.h
 create mode 100644 include/crypto/aes-round.h
 create mode 100644 tests/tcg/aarch64/test-aes.c
 create mode 100644 tests/tcg/i386/test-aes.c
 create mode 100644 tests/tcg/ppc64/test-aes.c
 create mode 100644 tests/tcg/riscv64/test-aes.c
 create mode 100644 util/cpuinfo-ppc.c
 create mode 100644 tests/tcg/multiarch/test-aes-main.c.inc

-- 
2.34.1


