Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF55B78BAEB
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qakU7-0005oc-SB; Mon, 28 Aug 2023 18:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakU5-0005oM-Q2
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:13:21 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakU3-000473-FW
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:13:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso2326546f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693260798; x=1693865598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vvWgyMZBL8l+yzNWAXsAE0ELDVGdPtARPo+/gTAnl9M=;
 b=VDbLRUPKwlJ5uXO+SMF7VvAfasHRVSjuFlVgjnAHjQhp8dW/53LSIgybfHKjMrgICE
 X6zHLqwMNvD1RfyAUkg/5bcxiWlOlWZW3WAy7kAqgOYIlHF4URvaTUUgEPjR10QxfyfM
 SCSec3yE+sydhD0pwZqAx1g2SwwcWykWHPac/w3wB44j/x5LbC9EfzDJ9PenbDG+8sN8
 KSZ+mymBsf6E6aR/kB6+shVxeD7pFeDl2yMrix5bv5WhQLVCLeK7OqUXC9J1G/TnV5z6
 gojtRcq81CXFQjxpW6rENtZ6WEVvD/YwLOV7BZPrmjZsltWgQOLtRmlAnWgYnE+D6lMh
 /x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260798; x=1693865598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvWgyMZBL8l+yzNWAXsAE0ELDVGdPtARPo+/gTAnl9M=;
 b=G4BSQ9xIjwk+hw61yINukwNgGijHc8yfxSTMs65oy1cRtj4ISqrs+FHfSyAQUZmLCy
 P3au1fQCToWnGCV+HMQNhv7UEtRziCXpkN+Ka0hH6HM8xEVT67T+EySzurTWenPvDUTi
 LSyAoAYEBYDoXbYvBhFKJMqSH3EG/2Hjs+YGfWPqR2SY02eCaDapQmJaA3lspanDTE+n
 vqTtu3BsnlagroWKuxGtXonrmlQnYClOau6PheiUl8xXFUvt/GIVaGC14Z+X3C7q0ezh
 /TzXUtiGm05weZfUHl6aoIw5GK2Zg2FAUWQYJPK23G1uu/wHdgMwttmruj+kcJB9IJo+
 0iXw==
X-Gm-Message-State: AOJu0YwTCUPyB6NeU7TipivY+Q5OfTjGfxOGJ1+gzEUi28jOH2OQz6DE
 X7ucCtvyDVbwsrsfyX9yfR0eN1bYSuCXfOtbSSo=
X-Google-Smtp-Source: AGHT+IFyCOjIkVRIYgh0jSEhMoQhD5qRFHJv8z+B9WFVgp7edId22Hi+m6spVat95NsoSebJgjMo7A==
X-Received: by 2002:adf:f14c:0:b0:317:59ea:1c6b with SMTP id
 y12-20020adff14c000000b0031759ea1c6bmr465012wro.35.1693260797825; 
 Mon, 28 Aug 2023 15:13:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a7bcbd7000000b003fef6881350sm12139194wmi.25.2023.08.28.15.13.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 15:13:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/11] target/translate: Remove unused "exec/cpu_ldst.h" /
 "qemu/main-loop.h"
Date: Tue, 29 Aug 2023 00:13:03 +0200
Message-ID: <20230828221314.18435-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Since v1:
- Addressed Richard review comment
- Added Richard R-b tag
- 3 more patches around 'qemu/qatomic.h'

Philippe Mathieu-Daudé (11):
  target/ppc/pmu: Include missing 'qemu/timer.h' header
  target/riscv/pmu: Restrict 'qemu/log.h' include to source
  target/translate: Include missing 'exec/cpu_ldst.h' header
  target/translate: Remove unnecessary 'exec/cpu_ldst.h' header
  target/translate: Restrict 'exec/cpu_ldst.h' to user emulation
  target/helpers: Remove unnecessary 'exec/cpu_ldst.h' header
  target/helper: Remove unnecessary 'qemu/main-loop.h' header
  target/mips: Remove unused headers in lcsr_helper.c
  target/xtensa: Include missing 'qemu/atomic.h' header
  qemu/processor: Remove unused 'qemu/atomic.h' header
  exec/translation-block: Clean up includes

 include/exec/exec-all.h              | 2 +-
 include/exec/translation-block.h     | 6 +++---
 include/qemu/processor.h             | 2 --
 target/riscv/pmu.h                   | 3 ---
 hw/xtensa/pic_cpu.c                  | 1 +
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
 target/xtensa/exc_helper.c           | 1 +
 target/xtensa/fpu_helper.c           | 1 -
 target/xtensa/mmu_helper.c           | 2 --
 target/xtensa/op_helper.c            | 3 +--
 target/xtensa/win_helper.c           | 1 -
 49 files changed, 17 insertions(+), 51 deletions(-)

-- 
2.41.0


