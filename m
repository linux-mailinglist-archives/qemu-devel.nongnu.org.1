Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1108735B53
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH2I-0001wT-QJ; Mon, 19 Jun 2023 11:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH2G-0001qL-F3
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:43:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH2E-0000tn-BE
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:43:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f9b258f3d8so8061405e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189396; x=1689781396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jVOmFq/xcTz+E+89vhRvBcBDO7Y1DK66CFqImu2lTAI=;
 b=xYDhw0sj/284hKzDG9qBtfQNmzoCR+1GMcA7Jwi4yYGQ1TxRr6+zxjb8if70M3BQuC
 o5eLYThrjN9v2PPs9U5hGA1sAbpRnTKA92uojQAIrP+50pTy4vNWhpswjeBZB5NqKw5E
 zlIG5O+E5fS7JUikuZclTvI3q84/dTnhb87uDdltgeHOZqciK0z7Rx4pY6npxhI9cI2N
 +Jp0LOYdNXN8kgs6gbVCOdB8ddF3Mo4irERQG0m8bGlBG8khCzLO2YKmCbaw9mupSwSR
 vMqsM/7WWwqofsLZzcWXm3vBDEHZ6qQyjmB9aNi1K8d7Nc/FxLkOeItNt0vS0ms4dpGS
 Idvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189396; x=1689781396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jVOmFq/xcTz+E+89vhRvBcBDO7Y1DK66CFqImu2lTAI=;
 b=jSWGomyY4JygeBTy1a/yjlGuF/W+DOBDw3RvcgnoC+5ScekAwJq64/+5VxA7fV04q7
 UijJXy1hghj21vLYvc4hpIVSWuVYSxcg9AUbe9zY9fOyBFO2+t8BivOuJ+x+XOwjBSt3
 /TYwYecOvocupNzJX4IIpKNQ3F81rZYA90222Vr/9ddfX3OM1Bg2CPqo3noeayaB7rTK
 yZhu4aAOq6b9S4/LCy5hxL2nbItfxwrcd1xDiWf5SrtvdYVx6PkXAM7BMVQ+e+tSZONK
 /uKzC1oBm+78TZX93WSGNnRTOs690VP+rFPYVQcOAC2BaOTXxNAreXnlQLnMFKunx4rg
 jv4g==
X-Gm-Message-State: AC+VfDznYR7Qx+ndsG76xHVK0P8Q3/iRLsKqscJcBBmfkXxtF+b2seZI
 TYtnHx/ZwRJBxywCYVjvoHuim0kjW8fQ1ep998eu2A==
X-Google-Smtp-Source: ACHHUZ7NSJmASL0BSXh2YLmyO0aU9tPNyESNUEqOdjhtzeu6uQRY2MQnhFlbiRhUHMsC9B/0fpmsJQ==
X-Received: by 2002:a05:600c:3659:b0:3f7:aee8:c23a with SMTP id
 y25-20020a05600c365900b003f7aee8c23amr13656104wmq.19.1687189396229; 
 Mon, 19 Jun 2023 08:43:16 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 y20-20020a7bcd94000000b003f60e143d38sm59759wmj.11.2023.06.19.08.43.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:43:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/34] target/arm/tcg: Remove inclusions of
 'exec/helper-[proto/gen].h'
Date: Mon, 19 Jun 2023 17:42:28 +0200
Message-Id: <20230619154302.80350-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Since v2:
- Addressed rth's review comments (unnecessary helper-gen)
- Added R-b
- Extracted crypto, pauth, mte, gvec

Possible follow-up:
- merge gvec/vfp
- rename neon -> advsimd
- rename historical op_helper -> misc_helper

Since v1:
- Addressed rth's review comments (unnecessary helper-gen)
- Added R-b
- Extract M-profile helpers
- Fixed licence in new files

Hi,

This series tries to do what Richard suggested in [*]:

  Targets that have a tcg/ subdir should have helper.h.inc
  moved into there.  At the end, include/exec/helper-gen.h
  and include/exec/helper-proto.h become unused and go away.

but only for the ARM target, to first see if this is heading
in the correct direction.

Instead of having TCG generated helpers included by all
translate/helper units, they are reduced to the few places
really needing them. I expect the build step to be slighly
improved, since the compiler doesn't have to compile and
track unused helpers definitions.

[*] https://lore.kernel.org/qemu-devel/cad000d7-f408-9337-9328-ccb262c5fcc7@linaro.org/

Philippe Mathieu-Daudé (34):
  target/arm/tcg: Remove CONFIG_TCG #ifdef'ry check
  target/arm/tcg: Rename helper template headers as '.h.inc'
  target/arm/tcg: Extract iwMMXt helpers from the generic 'helper.h'
  target/arm/tcg: Fix iwmmxt-related code style
  target/arm/tcg: Expose some iwmmxt methods in 'translate.h'
  target/arm/tcg: Extract iwmmxt code to translate-iwmmxt.c
  target/arm/tcg: Reduce 'helper-iwmmxt.h.inc' inclusion
  target/arm/tcg: Un-inline VFP translation helpers
  target/arm/tcg: Move VFP helpers from helper-a64.c to vfp_helper.c
  target/arm/tcg: Extract VFP definitions to 'helper-vfp.h.inc'
  target/arm/tcg: Reduce 'helper-vfp.h.inc' inclusion
  target/arm/tcg: Move NEON helpers to neon_helper.c
  target/arm/tcg: Extract NEON definitions to 'helper-neon.h.inc'
  target/arm/tcg: Reduce 'helper-neon.h.inc' inclusion
  target/arm/tcg: Export some generic vector helpers
  target/arm/tcg: Extract generic vector helpers to translate-gvec.c
  target/arm/tcg: Extract gvec definitions to 'helper-gvec.h.inc'
  target/arm/tcg: Reduce 'helper-gvec.h.inc' inclusion
  target/arm/tcg: Extract SVE2 definitions to 'helper-sve.h.inc'
  target/arm/tcg: Reduce 'helper-sve.h.inc' inclusion
  target/arm/tcg: Extract crypto definitions to 'helper-crypto.h.inc'
  target/arm/tcg: Reduce 'helper-crypto.h.inc' inclusion
  target/arm/tcg: Reduce 'helper-mve.h.inc' inclusion
  target/arm/tcg: Reduce 'helper-sme.h.inc' inclusion
  target/arm/tcg: Extract PAuth definitions to 'helper-pauth.h.inc'
  target/arm/tcg: Extract MemTag definitions to 'helper-mte.h.inc'
  target/arm/tcg: Reduce 'helper-a64.h.inc' inclusion
  target/arm/tcg: Move v8m_stackcheck() from op_helper.c to m_helper.c
  target/arm/tcg: Extract M-profile definitions to 'helper-m.h.inc'
  target/arm/tcg: Reduce 'helper-m.h.inc' inclusion
  target/arm/tcg: Inline 'exec/helper-gen.h'
  target/arm/tcg: Inline 'exec/helper-proto.h'
  target/arm/tcg: Rename 'helper.h' -> 'tcg/helper.h.inc'
  tests/tcg/aarch64: Rename bti-crt.inc.c -> bti-crt.c.inc

 target/arm/helper.h                           | 1047 ------
 target/arm/tcg/translate.h                    |   37 +-
 .../tcg/{helper-a64.h => helper-a64.h.inc}    |   43 -
 target/arm/tcg/helper-crypto.h.inc            |   42 +
 target/arm/tcg/helper-gvec.h.inc              |  378 +++
 target/arm/tcg/helper-iwmmxt.h.inc            |  103 +
 target/arm/tcg/helper-m.h.inc                 |   23 +
 target/arm/tcg/helper-mte.h.inc               |   23 +
 .../tcg/{helper-mve.h => helper-mve.h.inc}    |    0
 target/arm/tcg/helper-neon.h.inc              |  224 ++
 target/arm/tcg/helper-pauth.h.inc             |   19 +
 .../tcg/{helper-sme.h => helper-sme.h.inc}    |    0
 .../tcg/{helper-sve.h => helper-sve.h.inc}    |   46 +
 target/arm/tcg/helper-vfp.h.inc               |  189 ++
 target/arm/tcg/helper.h.inc                   |   97 +
 target/arm/debug_helper.c                     |    6 +-
 target/arm/helper.c                           |    6 +-
 target/arm/tcg/cpu32.c                        |    4 +-
 target/arm/tcg/crypto_helper.c                |    7 +-
 target/arm/tcg/helper-a64.c                   |  176 +-
 target/arm/tcg/hflags.c                       |    5 +-
 target/arm/tcg/iwmmxt_helper.c                |    5 +-
 target/arm/tcg/m_helper.c                     |   31 +-
 target/arm/tcg/mte_helper.c                   |    4 +-
 target/arm/tcg/mve_helper.c                   |    9 +-
 target/arm/tcg/neon_helper.c                  |  111 +-
 target/arm/tcg/op_helper.c                    |   43 +-
 target/arm/tcg/pauth_helper.c                 |    4 +-
 target/arm/tcg/psci.c                         |    5 +-
 target/arm/tcg/sme_helper.c                   |    5 +-
 target/arm/tcg/sve_helper.c                   |   12 +-
 target/arm/tcg/tlb_helper.c                   |    4 +-
 target/arm/tcg/translate-a64.c                |   38 +
 target/arm/tcg/translate-gvec.c               | 1650 ++++++++++
 target/arm/tcg/translate-iwmmxt.c             | 1331 ++++++++
 target/arm/tcg/translate-m-nocp.c             |   11 +
 target/arm/tcg/translate-mve.c                |    6 +
 target/arm/tcg/translate-neon.c               |   18 +
 target/arm/tcg/translate-sme.c                |   14 +
 target/arm/tcg/translate-sve.c                |   13 +
 target/arm/tcg/translate-vfp.c                |   31 +
 target/arm/tcg/translate.c                    | 2907 +----------------
 target/arm/tcg/vec_helper.c                   |   21 +-
 target/arm/vfp_helper.c                       |   98 +-
 tests/tcg/aarch64/bti-1.c                     |    2 +-
 tests/tcg/aarch64/bti-3.c                     |    2 +-
 .../aarch64/{bti-crt.inc.c => bti-crt.c.inc}  |    0
 target/arm/tcg/meson.build                    |    2 +
 48 files changed, 4616 insertions(+), 4236 deletions(-)
 delete mode 100644 target/arm/helper.h
 rename target/arm/tcg/{helper-a64.h => helper-a64.h.inc} (60%)
 create mode 100644 target/arm/tcg/helper-crypto.h.inc
 create mode 100644 target/arm/tcg/helper-gvec.h.inc
 create mode 100644 target/arm/tcg/helper-iwmmxt.h.inc
 create mode 100644 target/arm/tcg/helper-m.h.inc
 create mode 100644 target/arm/tcg/helper-mte.h.inc
 rename target/arm/tcg/{helper-mve.h => helper-mve.h.inc} (100%)
 create mode 100644 target/arm/tcg/helper-neon.h.inc
 create mode 100644 target/arm/tcg/helper-pauth.h.inc
 rename target/arm/tcg/{helper-sme.h => helper-sme.h.inc} (100%)
 rename target/arm/tcg/{helper-sve.h => helper-sve.h.inc} (98%)
 create mode 100644 target/arm/tcg/helper-vfp.h.inc
 create mode 100644 target/arm/tcg/helper.h.inc
 create mode 100644 target/arm/tcg/translate-gvec.c
 create mode 100644 target/arm/tcg/translate-iwmmxt.c
 rename tests/tcg/aarch64/{bti-crt.inc.c => bti-crt.c.inc} (100%)

-- 
2.38.1


