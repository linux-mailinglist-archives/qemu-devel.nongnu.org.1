Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B416F78B3C5
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 16:57:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qadem-0003Cx-Gh; Mon, 28 Aug 2023 10:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qadek-0003Bo-CN
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 10:55:54 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qadeg-0000bT-Id
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 10:55:54 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso2783007f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693234548; x=1693839348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LZVBTLQ7o6iqgGaPYrq/8xZ+5YbpKZVyztY/hfXbBKA=;
 b=iwCwnBvrXgGyy+qOsBH4SDCkhiq2Ep9B+bPTEn6CF/XeWdwSja6Ylrw7JBBV6NeQtH
 W+geRXjsEXHE+LFLbO8u53bdG7IRwlrz8NudRt+ZQ4YF+/TonBprtgdGtw+ro02Yjit8
 wtEklxA3P7dBVmmzEtoqYY2+sRnu5YpKGrZNC3klGXYBm0SkhbQ3rO2BVu+FulQQWnYc
 OGqFrNmku0NJurlG9RWwwSrr+RNKnS5mbUtwjTA4QahWnj6lgVua7T5hMf/UbgXpNx5J
 T8EP08lBcNmyWeGegB637iTUOrBh26hkyQGD+4INX4uuwv2+7Xw9vzvLy7BK3ph02zKw
 L3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693234548; x=1693839348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LZVBTLQ7o6iqgGaPYrq/8xZ+5YbpKZVyztY/hfXbBKA=;
 b=Q8mel2EbmI+IqXHP1xsQ6oywTJZIAksCE3tYG073F8NYQIdB6YZpwPh1VAJ/R+v8rr
 zrYGdcPjP5wgy41ciImHbF0mvPnRfN5APXqpNsfc+he9tSCoFZfsk9KYoaYmYFbgIrHc
 DebvCumRxTx8cgFEoFyMR3JlTBZquWgZ0iSl9x88STH5nj2Rnl2OPH46eylRxCttJNWf
 oJs4DAlRjn8PWAWV4T1U3QHZY+IN8q3sqagjFkLofd7wRZ3p7cmr89hP0B23yfgBgMIg
 X5/z37/k9d+TMEhRpEwafNyaEA5WFtnCr4KPJIQs5WoQC8I8lzizKS351ayRdM/XdCKe
 L5og==
X-Gm-Message-State: AOJu0Ywnf0vEzkC9HBuHwCPDItki0qsw9Xvd9QSrcgmGp658aupy39os
 orls0PKfGIW6N+hle9lD+oJD9auJ50UFbr9xZIQ=
X-Google-Smtp-Source: AGHT+IHvT7Jvx6viQJBR+GZNS0C1nXBSC1ECewWN64gAJVcwZsG2809ghisnKj4gfkGfVLTokNO7rw==
X-Received: by 2002:a05:6000:9:b0:319:8d94:c245 with SMTP id
 h9-20020a056000000900b003198d94c245mr20189722wrx.69.1693234548557; 
 Mon, 28 Aug 2023 07:55:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a5d4904000000b0031779a6b451sm10682474wrq.83.2023.08.28.07.55.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 07:55:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] target/translate: Remove unused "exec/cpu_ldst.h" /
 "qemu/main-loop.h"
Date: Mon, 28 Aug 2023 16:55:37 +0200
Message-ID: <20230828145545.81165-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Yet another boring 'header cleanups' series :/

Philippe Mathieu-Daudé (8):
  target/ppc/pmu: Include missing 'qemu/timer.h' header
  target/riscv/pmu: Restrict 'qemu/log.h' include to source
  target/translate: Include missing 'exec/cpu_ldst.h' header
  target/translate: Remove unnecessary 'exec/cpu_ldst.h' header
  target/translate: Restrict 'exec/cpu_ldst.h' to user emulation
  target/helpers: Remove unnecessary 'exec/cpu_ldst.h' header
  target/helper: Remove unnecessary 'qemu/main-loop.h' header
  target/mips: Remove unused headers in lcsr_helper.c

 include/exec/exec-all.h              | 2 +-
 target/riscv/pmu.h                   | 3 ---
 target/alpha/translate.c             | 1 -
 target/arm/ptw.c                     | 1 -
 target/avr/helper.c                  | 1 +
 target/cris/op_helper.c              | 1 -
 target/hexagon/translate.c           | 1 -
 target/hppa/translate.c              | 1 -
 target/i386/tcg/fpu_helper.c         | 1 +
 target/i386/tcg/sysemu/excp_helper.c | 1 +
 target/loongarch/cpu.c               | 1 +
 target/loongarch/iocsr_helper.c      | 1 -
 target/loongarch/op_helper.c         | 1 -
 target/m68k/translate.c              | 1 -
 target/microblaze/translate.c        | 1 -
 target/mips/tcg/fpu_helper.c         | 1 -
 target/mips/tcg/ldst_helper.c        | 1 +
 target/mips/tcg/msa_helper.c         | 1 +
 target/mips/tcg/sysemu/lcsr_helper.c | 5 -----
 target/nios2/op_helper.c             | 1 -
 target/nios2/translate.c             | 1 -
 target/openrisc/translate.c          | 1 -
 target/ppc/int_helper.c              | 1 -
 target/ppc/machine.c                 | 1 -
 target/ppc/mem_helper.c              | 1 -
 target/ppc/mmu_common.c              | 1 -
 target/ppc/mmu_helper.c              | 1 -
 target/ppc/power8-pmu.c              | 2 +-
 target/ppc/translate.c               | 2 --
 target/riscv/csr.c                   | 1 -
 target/riscv/m128_helper.c           | 1 -
 target/riscv/op_helper.c             | 2 +-
 target/riscv/pmu.c                   | 1 +
 target/riscv/vector_helper.c         | 1 +
 target/s390x/tcg/crypto_helper.c     | 1 -
 target/s390x/tcg/excp_helper.c       | 1 -
 target/s390x/tcg/fpu_helper.c        | 1 -
 target/s390x/tcg/misc_helper.c       | 1 -
 target/sh4/translate.c               | 1 -
 target/sparc/translate.c             | 1 -
 target/xtensa/dbg_helper.c           | 1 -
 target/xtensa/fpu_helper.c           | 1 -
 target/xtensa/mmu_helper.c           | 2 --
 target/xtensa/op_helper.c            | 2 --
 target/xtensa/win_helper.c           | 1 -
 45 files changed, 11 insertions(+), 46 deletions(-)

-- 
2.41.0


