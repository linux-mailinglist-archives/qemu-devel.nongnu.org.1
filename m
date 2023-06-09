Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9D9729753
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:47:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZeQ-0000jQ-Tt; Fri, 09 Jun 2023 06:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZeP-0000j6-9S
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZeN-0001AJ-4V
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30e53cacc10so1110096f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307641; x=1688899641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HJ5HI0lL3qjrViOVTfhSFThyUieC3Zv2QHm9pLeOb3Y=;
 b=CjcWwxj7J3aWhPFCLcAWd8QwV2klkvtWSZ8RsuH/yZovIYJFZbwJLOk53n8o4Cfdq0
 HArgQBPMXM3YAb8fLAjxajKD7BBpu31FZtHxjD6iq+LjNpvOJhYMZIv9UOsm3UwA1Znf
 oSpMpU3jUIIbAdKKcOB1BHINd9bxEa9ctjqw5kMTbblMthu6vsnx33btjl8ikevyv2ca
 QcwA+r8JG2nOGoTkfqjK1AzfYRp0jvfMReeIIUGdsgO5217VTwyj/zlnsrXCJj0pp9P0
 Uyzn5MaDFzDSl2bO1yxf/8e8Bl725KORS9bvGCGW+bKMyCTOOKwmwBWoG6G+l+1iAqR9
 fZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307641; x=1688899641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HJ5HI0lL3qjrViOVTfhSFThyUieC3Zv2QHm9pLeOb3Y=;
 b=Pmyur8i5PsjbAkZgYIGjzylBl2iNt8+GB47if17YvF7kcvf5WsWrlw2ds/kjzrhkH+
 2l1dAPOBpyy477UFOYfvpOi+BQEsIJPAHBWaA1UV5t4h1l1DlsZ+1FLk+9HfaCUBijTT
 lvuvfnOBrYrrXOGCHrwtXBIWkglfRi001DnhK8CHD7/qJluCe2Q2TbeOUnmMI9ljZlm+
 zPrMsmHIw7NCsOvksEVqEROUUH1K+k8gq9voYvb8oM25sKK8fTvQ7fqpi2PVQIVSs3OG
 T5kPLv6AUsFxARIz52N0aLKWkeE344NyoQEwrj/zi+ECJx694sZ20YFKN0OoxNSkoQas
 YPDA==
X-Gm-Message-State: AC+VfDxG11VLpm+IZ/08RlZGGpHgfue7/ws7ATDjxobJ/Ga2Hzt6opqO
 iaCUj/khueeRK8v4KMC9EfL9RIIgnfsVmAMbsE1HEw==
X-Google-Smtp-Source: ACHHUZ6tx/QjkUl2ar5mPangUWyyDMKCgAKUsJHt/RFW6GCk/FfPfcpuqr0AcEAvoZBfD2tQAnoZ1g==
X-Received: by 2002:a5d:4bd0:0:b0:30a:eeee:2fba with SMTP id
 l16-20020a5d4bd0000000b0030aeeee2fbamr558252wrt.34.1686307641228; 
 Fri, 09 Jun 2023 03:47:21 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 k10-20020adff5ca000000b003077a19cf75sm4108102wrp.60.2023.06.09.03.47.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:47:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/22] target/arm/tcg: Remove inclusions of
 'exec/helper-[proto/gen].h'
Date: Fri,  9 Jun 2023 12:46:55 +0200
Message-Id: <20230609104717.95555-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Philippe Mathieu-Daudé (22):
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
  target/arm/tcg: Define SME set_svcr() helper in common 'helper.h'
  target/arm/tcg: Reduce 'helper-sme.h.inc' inclusion
  target/arm/tcg: Reduce 'helper-a64.h.inc' inclusion
  target/arm/tcg: Remove inclusions of 'exec/helper-[proto/gen].h'
  tests/tcg/aarch64: Rename bti-crt.inc.c -> bti-crt.c.inc

 target/arm/tcg/translate.h                    |   11 +-
 .../tcg/{helper-a64.h => helper-a64.h.inc}    |    0
 target/arm/tcg/helper-iwmmxt.h.inc            |  114 ++
 .../tcg/{helper-mve.h => helper-mve.h.inc}    |    0
 target/arm/tcg/helper-neon.h.inc              |  205 +++
 .../tcg/{helper-sme.h => helper-sme.h.inc}    |    2 -
 .../tcg/{helper-sve.h => helper-sve.h.inc}    |   46 +
 target/arm/tcg/helper-vfp.h.inc               |  136 ++
 target/arm/{helper.h => tcg/helper.h.inc}     |  488 +-----
 accel/tcg/cpu-exec.c                          |    2 +-
 plugins/core.c                                |    1 -
 target/arm/debug_helper.c                     |    7 +-
 target/arm/helper.c                           |    7 +-
 target/arm/tcg/cpu32.c                        |    4 +-
 target/arm/tcg/crypto_helper.c                |    6 +-
 target/arm/tcg/helper-a64.c                   |   11 +-
 target/arm/tcg/hflags.c                       |    6 +-
 target/arm/tcg/iwmmxt_helper.c                |    6 +-
 target/arm/tcg/m_helper.c                     |   12 +-
 target/arm/tcg/mte_helper.c                   |    5 +-
 target/arm/tcg/mve_helper.c                   |   16 +-
 target/arm/tcg/neon_helper.c                  |   28 +-
 target/arm/tcg/op_helper.c                    |   28 +-
 target/arm/tcg/pauth_helper.c                 |    5 +-
 target/arm/tcg/psci.c                         |    6 +-
 target/arm/tcg/sme_helper.c                   |   11 +-
 target/arm/tcg/sve_helper.c                   |   20 +-
 target/arm/tcg/tlb_helper.c                   |    5 +-
 target/arm/tcg/translate-a64.c                |   16 +
 target/arm/tcg/translate-iwmmxt.c             | 1340 +++++++++++++++++
 target/arm/tcg/translate-mve.c                |    6 +
 target/arm/tcg/translate-neon.c               |   11 +
 target/arm/tcg/translate-sme.c                |   16 +
 target/arm/tcg/translate-sve.c                |    5 +
 target/arm/tcg/translate-vfp.c                |    6 +
 target/arm/tcg/translate.c                    | 1274 +---------------
 target/arm/tcg/vec_helper.c                   |   26 +-
 target/arm/vfp_helper.c                       |   11 +-
 tests/tcg/aarch64/bti-1.c                     |    2 +-
 tests/tcg/aarch64/bti-3.c                     |    2 +-
 .../aarch64/{bti-crt.inc.c => bti-crt.c.inc}  |    0
 target/arm/tcg/meson.build                    |    1 +
 42 files changed, 2100 insertions(+), 1804 deletions(-)
 rename target/arm/tcg/{helper-a64.h => helper-a64.h.inc} (100%)
 create mode 100644 target/arm/tcg/helper-iwmmxt.h.inc
 rename target/arm/tcg/{helper-mve.h => helper-mve.h.inc} (100%)
 create mode 100644 target/arm/tcg/helper-neon.h.inc
 rename target/arm/tcg/{helper-sme.h => helper-sme.h.inc} (99%)
 rename target/arm/tcg/{helper-sve.h => helper-sve.h.inc} (98%)
 create mode 100644 target/arm/tcg/helper-vfp.h.inc
 rename target/arm/{helper.h => tcg/helper.h.inc} (56%)
 create mode 100644 target/arm/tcg/translate-iwmmxt.c
 rename tests/tcg/aarch64/{bti-crt.inc.c => bti-crt.c.inc} (100%)

-- 
2.38.1


