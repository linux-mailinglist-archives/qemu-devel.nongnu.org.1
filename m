Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD4744E78
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzOz-0001cA-70; Sun, 02 Jul 2023 11:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qFzOx-0001b9-2b
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:54:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qFzOu-0008Hj-Ri
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:54:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-66c729f5618so3100489b3a.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1688313251; x=1690905251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AZ5mvYrQpRrbkCJBurl3TsDLmGROAXhzdK18l8db+6M=;
 b=hbiRq1kB1X+FNocvqZkEEKNlIeaj5KmOYPNWG+C53NbKiAdf0PsQhaW/FYqcvYukcw
 Vyt7SGDHnFvi43XvAiRTgokvB1HekU3dyJJCQojAGg6jbVHXpgnqQB7sYNkrV6c71A24
 rDkk34vHPQoVJ66F9msxf44cAH7z+9/7Uf87Rf0UY9+G82qwYnsfxhU8t99gbNIRyFip
 qAhOvvhsL/c3Ei6V5TuxkJh1PMtSh09B95p/EKN7F23OK9rQnPmlG3XHx7ifBjcbyS7e
 r8teXRT/QkgtE7u1LbBjWTN3HYiNLHAxGU/ckUW6qCcOeA6Rs6CBc3sLmWifAs/+97Ix
 gZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688313251; x=1690905251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AZ5mvYrQpRrbkCJBurl3TsDLmGROAXhzdK18l8db+6M=;
 b=IGyTCr52WXRcQEsL4Veu3e2DpVy0NhtzqVZxxzUtjrByzgi49KKlQmvmwIr6eNSZJB
 aKoEVkoHuSEa7frND91fdkzqRrH056XZHnUbtmeoERSfAUvp4+cG8PEhsMvrij162sRm
 9pj7NXc6tk1ZwEVjiQRgkp3mvXUfMmKyTWotELZBKHbhF/yMbBghJ0LSr+e3p7ulKD36
 OD0u9eHrPU/wtnkC8Rig+/syIb7DhsPR7xpwscHl17KQz8Ux+4io/ylf5XA7GsUdo4pP
 dSxKDYSiUUli6Ra3cldE2BdRU5hurFRQtAAh0VC3xvE4MX3zuGMtYDmxXYp/JXo6Pyxm
 ly4A==
X-Gm-Message-State: ABy/qLZaBPfyekk2iTSkX9O9Ru262gHSJ87SMlu48lG2xZ1Yu0rgNIa9
 bsVH5vMQQgCG9swKVWC831OCRp0tvXQj8zpdMCLISFMnO7t+OSbfw6e2MEbj4et9cVGU6LFCVe3
 QRDwLXYPvaXakBbqOfhJspjfgwnE0OvaE13HV3MxUeyHSGZnYg6RtyYkm/Mj2s3NIQnk3svLN+7
 LE5IA=
X-Google-Smtp-Source: APBJJlFAbiztKNxr26nS90y8TnHUWQ9+aKA6Lvv19DR1LUk7AvuFnODdLcEDG3SwBut8SHyGif5nkQ==
X-Received: by 2002:a05:6a00:2d12:b0:682:4ef7:9b0b with SMTP id
 fa18-20020a056a002d1200b006824ef79b0bmr11445244pfb.0.1688313250672; 
 Sun, 02 Jul 2023 08:54:10 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 y19-20020aa78553000000b0066f37665a63sm8231969pfn.73.2023.07.02.08.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 08:54:10 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com,
	Max Chou <max.chou@sifive.com>
Subject: [PATCH v7 00/15] Add RISC-V vector cryptographic instruction set
 support
Date: Sun,  2 Jul 2023 23:53:34 +0800
Message-Id: <20230702155354.2478495-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
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

This patchset provides an implementation for Zvbb, Zvbc, Zvkned, Zvknh,
Zvksh, Zvkg, and Zvksed of the draft RISC-V vector cryptography
extensions as per the v20230620 version of the specification(1)(168e7b4).
This is an update to the patchset submitted to qemu-devel on
Sun, 2 Jul 2023 23:27:00 +0800

Based-on: 20230620110758.787479-1-richard.henderson@linaro.org
([PATCH v3 00/37] crypto: Provide aes-round.h and host accel)

v2:

    Squashed commits into one commit per extension with separate
    commits for each refactoring.
    Unified trans_rvzvk*.c.inc files into one trans_rvvk.c.inc.
    Style fixes in insn32.decode and other files.
    Added macros for EGS values in translation functions.
    Updated from v20230303 to v20230407 of the spec:
        Zvkb has been split into Zvbb and Zvbc.
        vbrev, vclz, vctz, vcpop and vwsll have been added to Zvbb.

v3:

    New patch 03/19 removes redundant “cpu_vl == 0” checks from
    trans_rvv.c.inc.
    Introduction of new tcg ops has been factored out of patch 11/19
    and into 09/19.
        These ops are now added to non riscv-specific files.

v4:

    New patch 08/17 fixes the tcg_gen_gvec_andcs temporary variable
    issue.
    Patch 09/17 fixes imm mode for vror.vi.
    Rebased to riscv-to-apply.next branch (de395bb):
        Replace vstart constraint checking by TCG op.
    Verified by code examples provided by vector crypto spec repository
    (riscv-crypto).

v5:

    Imported aes-round.h for Zvkned extension.
        Rebased to 20230620110758.787479-1-richard.henderson@linaro.org
    Exposed the properties of v4 patch 17/17 to the patches that the
    extension was added.
    Removed v4 patch 08/17 that is queued to tcg-next.

v6:

    Resent the same content becaue v5 was splitted by broken
    git-send-mail

v7:

    Fixed endian issues
    Replace the TCG ops of vstart & vl EGS checking by helper function
    Changed the SEW selection of vsha2c[hl].vv to TCG translation


As v20230620 is a frozen version, we are not expecting any significant
changes to the specification or this patch series.

Please note that the Zvkt data-independent execution latency extension
(and all extensions including it) has not been implemented, and we
would recommend not using these patches in an environment where timing
attacks are an issue.

Work performed by Dickon, Lawrence, Nazar, Kiran, and William from
Codethink sponsored by SiFive, as well as Max Chou and Frank Chang
from SiFive.

    https://github.com/riscv/riscv-crypto/releases

Thanks to those who have already reviewed:

    Daniel Henrique Barboza dbarboza@ventanamicro.com
        [PATCH v4 09/17] target/riscv: Add Zvbb ISA extension support
        [PATCH v4 10/17] target/riscv: Add Zvkned ISA extension support
        [PATCH v4 11/17] target/riscv: Add Zvknh ISA extension support
        [PATCH v4 12/17] target/riscv: Add Zvksh ISA extension support
        [PATCH v4 13/17] target/riscv: Add Zvkg ISA extension support
    Weiwei Li liweiwei@iscas.ac.cn
        [PATCH v3 01/19] target/riscv: Refactor some of the generic vector functionality
        [PATCH v3 02/19] target/riscv: Refactor vector-vector translation macro
        [PATCH v3 03/19] target/riscv: Remove redundant "cpu_vl == 0" checks
        [PATCH v3 05/19] target/riscv: Move vector translation checks
        [PATCH v3 06/19] target/riscv: Refactor translation of vector-widening instruction
        [PATCH v3 07/19] target/riscv: Refactor some of the generic vector functionality
        [PATCH v3 19/19] target/riscv: Expose Zvk* and Zvb[b, c] cpu properties
    Richard Henderson richard.henderson@linaro.org
        [PATCH v2 02/17] target/riscv: Refactor vector-vector translation macro
        [PATCH v2 04/17] target/riscv: Move vector translation checks
        [PATCH v2 05/17] target/riscv: Refactor translation of vector-widening instruction
        [PATCH v2 07/17] qemu/bitops.h: Limit rotate amounts
        [PATCH v2 08/17] qemu/host-utils.h: Add clz and ctz functions for lower-bit integers
        [PATCH v2 14/17] crypto: Create sm4_subword
    Alistair Francis alistair.francis@wdc.com
        [PATCH v2 02/17] target/riscv: Refactor vector-vector translation macro
    Philipp Tomsich philipp.tomsich@vrull.eu
        Various v1 reviews
    Christoph Müllner christoph.muellner@vrull.eu
        Various v1 reviews


Dickon Hood (2):
  target/riscv: Refactor translation of vector-widening instruction
  target/riscv: Add Zvbb ISA extension support

Kiran Ostrolenk (4):
  target/riscv: Refactor some of the generic vector functionality
  target/riscv: Refactor vector-vector translation macro
  target/riscv: Refactor some of the generic vector functionality
  target/riscv: Add Zvknh ISA extension support

Lawrence Hunter (2):
  target/riscv: Add Zvbc ISA extension support
  target/riscv: Add Zvksh ISA extension support

Max Chou (3):
  crypto: Create sm4_subword
  crypto: Add SM4 constant parameter CK
  target/riscv: Add Zvksed ISA extension support

Nazar Kazakov (4):
  target/riscv: Remove redundant "cpu_vl == 0" checks
  target/riscv: Move vector translation checks
  target/riscv: Add Zvkned ISA extension support
  target/riscv: Add Zvkg ISA extension support

 crypto/sm4.c                             |  10 +
 include/crypto/sm4.h                     |   9 +
 target/arm/tcg/crypto_helper.c           |  10 +-
 target/riscv/cpu.c                       |  37 +
 target/riscv/cpu_cfg.h                   |   8 +
 target/riscv/helper.h                    |  98 +++
 target/riscv/insn32.decode               |  58 ++
 target/riscv/insn_trans/trans_rvv.c.inc  | 171 ++--
 target/riscv/insn_trans/trans_rvvk.c.inc | 606 ++++++++++++++
 target/riscv/meson.build                 |   4 +-
 target/riscv/translate.c                 |   1 +
 target/riscv/vcrypto_helper.c            | 970 +++++++++++++++++++++++
 target/riscv/vector_helper.c             | 243 +-----
 target/riscv/vector_internals.c          |  81 ++
 target/riscv/vector_internals.h          | 228 ++++++
 15 files changed, 2179 insertions(+), 355 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvvk.c.inc
 create mode 100644 target/riscv/vcrypto_helper.c
 create mode 100644 target/riscv/vector_internals.c
 create mode 100644 target/riscv/vector_internals.h

-- 
2.34.1


