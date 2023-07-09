Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC86874C47C
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxA-0000H2-Aq; Sun, 09 Jul 2023 09:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUx7-00007k-WE
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUx5-0000MJ-Ni
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:53 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so4314030f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911187; x=1691503187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cxG60pRRht55mXW+HQDNPBtKaxqTVIhFVmkAt3gQrCg=;
 b=G8ElWCq3n1DnPj3c+XLQlJuwzKnxB6oB1duLn6GkfEV77bZuqTDo9prcxNvy2gkydP
 mNh+sdpKEsgIHMYw4/dyJKfeDQ5WOZUHj9tECpZU/s4f278fEeRLxnxM5l4umBxDarfQ
 b5zuUV8E4T2fDqCcY1b6OKjuCj8unVi0btOlI37I5Jds3gzu8+DqZKcW8Nn6FSsy7yVz
 zMDdiOkQoeieeJ4Fm+DwztyWDQr1oIl+5yaBbtyLCzbWjPajsDxNwVbQFXV/ykiiSvp7
 1YdF/UN6SSUw8jdtcQ2cvWJq1ZMpmAssPptjr9vSLFJTi7vUq35/zei2MjEoEN5aAPck
 zf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911187; x=1691503187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cxG60pRRht55mXW+HQDNPBtKaxqTVIhFVmkAt3gQrCg=;
 b=IPsLY8JZgm+Yc5PLj8g6E3tCO9JSQS+BBDlZYtdL+oFkxQH9Sz+mE0cL+MaOHVSkGp
 0lp3BcsGEHcUoV8loxSQ4Wpl6cQ/wfCTkk6qFW0ehH0b+kj7VU30BmPX5UjQhuqxquvK
 snEcp/wueRzI6UC5IMxoFBqqTXaxfuqoPzFMQEV1d8vwEnDbpFw0PC3hpwnuVPazu1fV
 Plrnk+MBILh/cx2L8xt3IgWp+XbJeghkuNDqKjLHrxGcrV7TsC08VGAoj9obQwJzH8ry
 oXWm1wgPQD8K3FX9OX3y/mQzNSjU3nIm7/l5Vc5/E8zga2hvgg47pXCU8Hy8BLyjYZxk
 rXdA==
X-Gm-Message-State: ABy/qLZEuMhJOFb9pO9wTItdq5bh+sygLtmrelxlMIWnojOyKjRjpWmq
 6xVA7JEDQSBtDAbTeXBl6wkQBQqHv+NjvDCgoV7Zjg==
X-Google-Smtp-Source: APBJJlF4h4/R/3D9+9bq+nZ5BZDh7RTZftTZNCK0u1etdtKwaPINWs6ndjx2hA4S+MI/T1gmH+jULg==
X-Received: by 2002:adf:e309:0:b0:313:f957:bf29 with SMTP id
 b9-20020adfe309000000b00313f957bf29mr12010713wrj.65.1688911187283; 
 Sun, 09 Jul 2023 06:59:47 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.06.59.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 06:59:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/37] crypto: Provide aes-round.h and host accel
Date: Sun,  9 Jul 2023 14:59:08 +0100
Message-Id: <20230709135945.250311-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

The following changes since commit 276d72ca1b9017916cadc7c170d0d6b31633a9e5:

  Merge tag 'pull-ppc-20230707-1' of https://gitlab.com/danielhb/qemu into staging (2023-07-07 22:23:17 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230709

for you to fetch changes up to ff494c8e2a4c857dd37fb908d8ac8158f5e4f89b:

  crypto: Unexport AES_*_rot, AES_TeN, AES_TdN (2023-07-09 13:48:23 +0100)

----------------------------------------------------------------
crypto: Provide aes-round.h and host accel

----------------------------------------------------------------
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
 host/include/aarch64/host/crypto/aes-round.h | 205 +++++++
 host/include/generic/host/crypto/aes-round.h |  33 ++
 host/include/i386/host/cpuinfo.h             |   1 +
 host/include/i386/host/crypto/aes-round.h    | 152 ++++++
 host/include/ppc/host/cpuinfo.h              |  30 ++
 host/include/ppc/host/crypto/aes-round.h     | 182 +++++++
 host/include/ppc64/host/cpuinfo.h            |   1 +
 host/include/ppc64/host/crypto/aes-round.h   |   1 +
 host/include/x86_64/host/crypto/aes-round.h  |   1 +
 include/crypto/aes-round.h                   | 164 ++++++
 include/crypto/aes.h                         |  30 --
 target/arm/helper.h                          |   2 +
 target/i386/ops_sse.h                        |  60 +--
 tcg/ppc/tcg-target.h                         |  16 +-
 target/arm/tcg/sve.decode                    |   4 +-
 crypto/aes.c                                 | 780 +++++++++++++++++----------
 target/arm/tcg/crypto_helper.c               | 249 +++------
 target/arm/tcg/translate-a64.c               |  13 +-
 target/arm/tcg/translate-neon.c              |   4 +-
 target/arm/tcg/translate-sve.c               |   8 +-
 target/ppc/int_helper.c                      |  50 +-
 target/riscv/crypto_helper.c                 | 138 ++---
 tests/tcg/aarch64/test-aes.c                 |  58 ++
 tests/tcg/i386/test-aes.c                    |  68 +++
 tests/tcg/ppc64/test-aes.c                   | 116 ++++
 tests/tcg/riscv64/test-aes.c                 |  81 +++
 util/cpuinfo-aarch64.c                       |   2 +
 util/cpuinfo-i386.c                          |   3 +
 util/cpuinfo-ppc.c                           |  64 +++
 tcg/ppc/tcg-target.c.inc                     |  44 +-
 tests/tcg/multiarch/test-aes-main.c.inc      | 183 +++++++
 tests/tcg/aarch64/Makefile.target            |   4 +
 tests/tcg/i386/Makefile.target               |   4 +
 tests/tcg/ppc64/Makefile.target              |   1 +
 tests/tcg/riscv64/Makefile.target            |   3 +
 util/meson.build                             |   2 +
 39 files changed, 2044 insertions(+), 724 deletions(-)
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

