Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 768B473B761
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfx4-0001V7-BP; Fri, 23 Jun 2023 08:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfwy-0001TX-I7
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfww-0000eH-LV
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f9bece8d1bso7669275e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523497; x=1690115497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zHzYXk1dzhu04GU5E4G5AOkqlY9Sw8PpRRyhTwni8Fw=;
 b=P+dqsQHx5sRbDwZbu5Yx0RI25I9wK5gCGOT8YsNNo36WshAb5wUtnLNYBsRPfSHn+e
 eGmLpGcHH+xe66q4UaOgtC1FvtquFoNhO1CcV/eeAa/MAuF8PkNJ7lmeaHD0Hjhc1NlM
 avbSGg8aZ1NOEIBJnbiuMJKuv7SBB1WgzbyGsvOW2nFFy2wQAXcIgbJQ+qMQb1JGJ8PM
 +IWjQgFvMNAJD+crkhWzP5mvmIg1z2f9Xe1l7xqY7NRk5LIt9WMfgpJlAQ1xQNFkO9/M
 fG3be+jQEN+ZBd2BrbmXJFzwCg2mm+9oziAx4+3GA+C/53G7GATzZ8Xo36jx3WshA0dy
 X1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523497; x=1690115497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHzYXk1dzhu04GU5E4G5AOkqlY9Sw8PpRRyhTwni8Fw=;
 b=fc51ueE+VwtCT4pQNVbiXMEczSsVrXI6fEfQ8SpukuUQ2u0FQmSARiU8T/bpmrVvZA
 4l4AS1y2rxDBPcFCNBVCl8Fhe/SdOo2TCXSTJnbpVTpLR4Cz3w0cU7nrMP2GIaK585r6
 02R+ru/T5IYBK7p7UQUn0eCMlQb88profkwt6A/mIEpqEQHetQbRnVZz5wcztQPHsYhA
 j88Gisj1WfxmeauI6vO6Lzn+s6q+RikBD2QdLewB040i23sp5Z0UVtz454wGdciI/qWg
 kj6Rsfntt8LlTJVjVEpMJH0HMovYsemTylu9o0j+Sd8H/XLojX7vX132tbKPmnMVKVPG
 j7XQ==
X-Gm-Message-State: AC+VfDzCZryULUPnu+Gk0PyJ9GL5haR9IeCEvF0B8gtNrqi0rzODGQe/
 +dNE0F+oTSG2KzfX/WfLi6kIryW3Ki9O4cfwi3k=
X-Google-Smtp-Source: ACHHUZ4zJwcX+rf/fqAeixUXLHuRcchquxt4k0Xo6lRC/FWD1emVxUmFLpeQBQdXS3jl5/9jblJLIQ==
X-Received: by 2002:a7b:c4d4:0:b0:3f9:cb72:efa9 with SMTP id
 g20-20020a7bc4d4000000b003f9cb72efa9mr4969486wmk.7.1687523497171; 
 Fri, 23 Jun 2023 05:31:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/26] target-arm queue
Date: Fri, 23 Jun 2023 13:31:09 +0100
Message-Id: <20230623123135.1788191-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi; here's a target-arm pullreq. Mostly this is RTH's FEAT_RME
series; there are also a handful of bug fixes including some
which aren't arm-specific but which it's convenient to include
here.

thanks
-- PMM

The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a4cb:

  Merge tag 'q800-for-8.1-pull-request' of https://github.com/vivier/qemu-m68k into staging (2023-06-22 10:18:32 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230623

for you to fetch changes up to 497fad38979c16b6412388927401e577eba43d26:

  pc-bios/keymaps: Use the official xkb name for Arabic layout, not the legacy synonym (2023-06-23 11:46:02 +0100)

----------------------------------------------------------------
target-arm queue:
 * Add (experimental) support for FEAT_RME
 * host-utils: Avoid using __builtin_subcll on buggy versions of Apple Clang
 * target/arm: Restructure has_vfp_d32 test
 * hw/arm/sbsa-ref: add ITS support in SBSA GIC
 * target/arm: Fix sve predicate store, 8 <= VQ <= 15
 * pc-bios/keymaps: Use the official xkb name for Arabic layout, not the legacy synonym

----------------------------------------------------------------
Peter Maydell (2):
      host-utils: Avoid using __builtin_subcll on buggy versions of Apple Clang
      pc-bios/keymaps: Use the official xkb name for Arabic layout, not the legacy synonym

Richard Henderson (23):
      target/arm: Add isar_feature_aa64_rme
      target/arm: Update SCR and HCR for RME
      target/arm: SCR_EL3.NS may be RES1
      target/arm: Add RME cpregs
      target/arm: Introduce ARMSecuritySpace
      include/exec/memattrs: Add two bits of space to MemTxAttrs
      target/arm: Adjust the order of Phys and Stage2 ARMMMUIdx
      target/arm: Introduce ARMMMUIdx_Phys_{Realm,Root}
      target/arm: Remove __attribute__((nonnull)) from ptw.c
      target/arm: Pipe ARMSecuritySpace through ptw.c
      target/arm: NSTable is RES0 for the RME EL3 regime
      target/arm: Handle Block and Page bits for security space
      target/arm: Handle no-execute for Realm and Root regimes
      target/arm: Use get_phys_addr_with_struct in S1_ptw_translate
      target/arm: Move s1_is_el0 into S1Translate
      target/arm: Use get_phys_addr_with_struct for stage2
      target/arm: Add GPC syndrome
      target/arm: Implement GPC exceptions
      target/arm: Implement the granule protection check
      target/arm: Add cpu properties for enabling FEAT_RME
      docs/system/arm: Document FEAT_RME
      target/arm: Restructure has_vfp_d32 test
      target/arm: Fix sve predicate store, 8 <= VQ <= 15

Shashi Mallela (1):
      hw/arm/sbsa-ref: add ITS support in SBSA GIC

 docs/system/arm/cpu-features.rst |  23 ++
 docs/system/arm/emulation.rst    |   1 +
 docs/system/arm/sbsa.rst         |  14 +
 include/exec/memattrs.h          |   9 +-
 include/qemu/compiler.h          |  13 +
 include/qemu/host-utils.h        |   2 +-
 target/arm/cpu.h                 | 151 ++++++++---
 target/arm/internals.h           |  27 ++
 target/arm/syndrome.h            |  10 +
 hw/arm/sbsa-ref.c                |  33 ++-
 target/arm/cpu.c                 |  32 ++-
 target/arm/helper.c              | 162 ++++++++++-
 target/arm/ptw.c                 | 570 +++++++++++++++++++++++++++++++--------
 target/arm/tcg/cpu64.c           |  53 ++++
 target/arm/tcg/tlb_helper.c      |  96 ++++++-
 target/arm/tcg/translate-sve.c   |   2 +-
 pc-bios/keymaps/meson.build      |   2 +-
 17 files changed, 1034 insertions(+), 166 deletions(-)

