Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B04F72B0EB
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8GuU-0000vn-LN; Sun, 11 Jun 2023 04:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GuS-0000uy-A1
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:58:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GuQ-0003WF-5L
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:58:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30fbcfdc7b6so130727f8f.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686473928; x=1689065928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t0NdcEUrbCPnpVDr1IxBm04NJqSbsxwlcbwIYAJr9rc=;
 b=on3FdXsl5dhsFFVczV/rqMkXbSgfQII83oFFUY5IwPa6xMltx7VlG00QMhPttGwvCk
 xoLHKEhs8lvQUq2UCqncxCLf9Arbbc6ga9C8QT+ZpFfIbzKlvhYQfeUId1ZB2+Ma5OLW
 3uvGJFqiPIQTB0vmzkSMcl6+PTG+ieijHPeLsFbhk6z+i64voCxTtbpbwXqfoW9uZgZg
 kRALVtmWTzZNxqxe4NvR/Ts1SVRJKpi+mLcifJSCTkzHmyXh1xyXIh30oLbL4Wbd/7TM
 WZaokynOr5HYadrj9VB5OxWQtxcHWjOFFn3EIVpIOT0CtgKRuII2u+r6Z4Ez6/n/SlpV
 QEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686473928; x=1689065928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t0NdcEUrbCPnpVDr1IxBm04NJqSbsxwlcbwIYAJr9rc=;
 b=OSuhYgWOZZdE/3iuuqaSNyQ636IMONaCNIcm3481R8ETk2o98rE4epgBCcef5sH2Md
 BDRggE3yQaCPvITdmkiD4OeEU2PMpL0KZd9c3Cci90ojHyVXZK4xD1AnPSJL0mMSXr0g
 EjdX87ekiFCUCIqEGdMpyCkpRJT16n/UN0RZkCS7m1KZb7N1ERSRh7qPPEh4926zg/7/
 VTeHWDbQhVpf0K16ipfKLRelbN2oDjp3xV+SIyb73pZrfYvLvMBRQJjaQfvkKg6SbaCx
 gwaQ0fhP5yguUlO+QYS5XQ0qn3g2OUu7JhCbMw70I6GmRn86jh3+sHpcHyOyyrjbCjPq
 ILRw==
X-Gm-Message-State: AC+VfDw3puLEc5ARNeHSLJpqoOOprN6QYsdriTqMYgB5jUvK/LoMUgNF
 whPiWhAearZK0zLrvivyn6oKob3S5ZteVz9ESik=
X-Google-Smtp-Source: ACHHUZ4N1Iqy2dtc70qezZutrGeG6vv92WsCypO2kClIMfNTH29VyTojckIk4Tn8BhYdxZBz4x84/w==
X-Received: by 2002:adf:e8c3:0:b0:30a:efb0:ce5c with SMTP id
 k3-20020adfe8c3000000b0030aefb0ce5cmr2143123wrn.45.1686473927971; 
 Sun, 11 Jun 2023 01:58:47 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 e8-20020adff348000000b00304adbeeabbsm9113851wrp.99.2023.06.11.01.58.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 01:58:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/26] target/arm/tcg: Remove inclusions of
 'exec/helper-[proto/gen].h'
Date: Sun, 11 Jun 2023 10:58:20 +0200
Message-Id: <20230611085846.21415-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Philippe Mathieu-Daudé (26):
  plugins: Remove unused 'exec/helper-proto.h' header
  accel/tcg/cpu-exec: Use generic 'helper-proto-common.h' header
  target/arm/tcg: Remove CONFIG_TCG #ifdef'ry check
  target/arm/tcg: Rename helper template headers as '.h.inc'
  target/arm/tcg: Extract iwMMXt helpers from the generic 'helper.h'
  target/arm/tcg: Fix iwmmxt-related code style
  target/arm/tcg: Expose some iwmmxt methods in 'translate.h'
  target/arm/tcg: Extract iwmmxt code to translate-iwmmxt.c
  target/arm/tcg: Reduce 'helper-iwmmxt.h.inc' inclusion
  target/arm/tcg: Extract VFP definitions to 'helper-vfp.h.inc'
  target/arm/tcg: Reduce 'helper-vfp.h.inc' inclusion
  target/arm/tcg: Move neon_tbl() from op_helper.c to neon_helper.c
  target/arm/tcg: Extract NEON definitions to 'helper-neon.h.inc'
  target/arm/tcg: Reduce 'helper-neon.h.inc' inclusion
  target/arm/tcg: Extract SVE2 definitions to 'helper-sve.h.inc'
  target/arm/tcg: Reduce 'helper-sve.h.inc' inclusion
  target/arm/tcg: Reduce 'helper-mve.h.inc' inclusion
  target/arm/tcg: Reduce 'helper-sme.h.inc' inclusion
  target/arm/tcg: Reduce 'helper-a64.h.inc' inclusion
  target/arm/tcg: Move v8m_stackcheck() from op_helper.c to m_helper.c
  target/arm/tcg: Extract M-profile definitions to 'helper-m.h.inc'
  target/arm/tcg: Reduce 'helper-m.h.inc' inclusion
  target/arm/tcg: Inline 'exec/helper-gen.h'
  target/arm/tcg: Inline 'exec/helper-proto.h'
  target/arm/tcg: Rename 'helper.h' -> 'tcg/helper.h.inc'
  tests/tcg/aarch64: Rename bti-crt.inc.c -> bti-crt.c.inc

 target/arm/tcg/translate.h                    |   10 +-
 .../tcg/{helper-a64.h => helper-a64.h.inc}    |    0
 target/arm/tcg/helper-iwmmxt.h.inc            |  103 ++
 target/arm/tcg/helper-m.h.inc                 |   23 +
 .../tcg/{helper-mve.h => helper-mve.h.inc}    |    0
 target/arm/tcg/helper-neon.h.inc              |  213 +++
 .../tcg/{helper-sme.h => helper-sme.h.inc}    |    0
 .../tcg/{helper-sve.h => helper-sve.h.inc}    |   46 +
 target/arm/tcg/helper-vfp.h.inc               |  163 ++
 target/arm/{helper.h => tcg/helper.h.inc}     |  524 -------
 accel/tcg/cpu-exec.c                          |    2 +-
 plugins/core.c                                |    1 -
 target/arm/debug_helper.c                     |    6 +-
 target/arm/helper.c                           |    7 +-
 target/arm/tcg/cpu32.c                        |    4 +-
 target/arm/tcg/crypto_helper.c                |    5 +-
 target/arm/tcg/helper-a64.c                   |    9 +-
 target/arm/tcg/hflags.c                       |    5 +-
 target/arm/tcg/iwmmxt_helper.c                |    5 +-
 target/arm/tcg/m_helper.c                     |   31 +-
 target/arm/tcg/mte_helper.c                   |    4 +-
 target/arm/tcg/mve_helper.c                   |    9 +-
 target/arm/tcg/neon_helper.c                  |   27 +-
 target/arm/tcg/op_helper.c                    |   43 +-
 target/arm/tcg/pauth_helper.c                 |    4 +-
 target/arm/tcg/psci.c                         |    5 +-
 target/arm/tcg/sme_helper.c                   |    5 +-
 target/arm/tcg/sve_helper.c                   |   12 +-
 target/arm/tcg/tlb_helper.c                   |    4 +-
 target/arm/tcg/translate-a64.c                |   18 +
 target/arm/tcg/translate-iwmmxt.c             | 1331 +++++++++++++++++
 target/arm/tcg/translate-m-nocp.c             |   11 +
 target/arm/tcg/translate-mve.c                |    6 +
 target/arm/tcg/translate-neon.c               |   10 +
 target/arm/tcg/translate-sme.c                |   14 +
 target/arm/tcg/translate-sve.c                |    5 +
 target/arm/tcg/translate-vfp.c                |   10 +
 target/arm/tcg/translate.c                    | 1278 +---------------
 target/arm/tcg/vec_helper.c                   |   21 +-
 target/arm/vfp_helper.c                       |    9 +-
 tests/tcg/aarch64/bti-1.c                     |    2 +-
 tests/tcg/aarch64/bti-3.c                     |    2 +-
 .../aarch64/{bti-crt.inc.c => bti-crt.c.inc}  |    0
 target/arm/tcg/meson.build                    |    1 +
 44 files changed, 2133 insertions(+), 1855 deletions(-)
 rename target/arm/tcg/{helper-a64.h => helper-a64.h.inc} (100%)
 create mode 100644 target/arm/tcg/helper-iwmmxt.h.inc
 create mode 100644 target/arm/tcg/helper-m.h.inc
 rename target/arm/tcg/{helper-mve.h => helper-mve.h.inc} (100%)
 create mode 100644 target/arm/tcg/helper-neon.h.inc
 rename target/arm/tcg/{helper-sme.h => helper-sme.h.inc} (100%)
 rename target/arm/tcg/{helper-sve.h => helper-sve.h.inc} (98%)
 create mode 100644 target/arm/tcg/helper-vfp.h.inc
 rename target/arm/{helper.h => tcg/helper.h.inc} (53%)
 create mode 100644 target/arm/tcg/translate-iwmmxt.c
 rename tests/tcg/aarch64/{bti-crt.inc.c => bti-crt.c.inc} (100%)

-- 
2.38.1


