Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1157610C4
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:26:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFF7-0000bP-Uv; Tue, 25 Jul 2023 06:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE5-0000Gd-O5
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE2-0007UL-SM
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso53510055e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690280705; x=1690885505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RYg+qhllyHHuaHWTSctfXd7Z6v3gvPifLFoz4PDWkKg=;
 b=USGr0B+O4FSy8FTuSvYoZGMT9t8BUShzyVyRaVB2DchQjNmyEpzhwtBtdoHtMK0DO4
 BMRdE6x4WTZuruewpr6GGYFvKhd61ZlCeR7SZsldquxuIg891Ir3qqhbfVWtTgPvp0B2
 YICCTEnT/TMjP+cxd7dqjNTNvEr9P+yEVjgTta6WNphc5KJts1YTLXCkadO1puNnroHz
 SLCElyozMtTegjXS1TGFCBXfdD76DFTWg9Dr0VljoSNZxWHPHevb/JZJvv/kJLnMH7Pv
 zoKup+h8e7YCs3PI2wzBOJmbh5cu4T4Xy98s8XGZu4mZw4sTISRfRtUNkwibX8NQgmk/
 4Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690280705; x=1690885505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RYg+qhllyHHuaHWTSctfXd7Z6v3gvPifLFoz4PDWkKg=;
 b=il0MaOWvKSFowNHPnSfCtjXEi9suTZfCPLa8eJ44AQMcwZcA0YP36OD4tpwt/i4P/6
 Cw7j6A+iSjolG+VI4BxOtYwQoeqxrc/fxDNgkdesZfnkvlx6wZYs2qorv/j0If6xI+QZ
 TOthHgfX8QY5WpITrhF821C+RhrE1vT6iQCKp3FwhEs6edR0IKF1JbgLKMpSz+P1RsyY
 opypINVj59bIGT1EWTNxeWfvX8Y68LX8Ivw3vkt155we9WyfRzo7e+qrkH79pKzxDBqm
 hMS6lwCejYvzihwDupbCotHwAwYVJevjGyofDmwiIMcqYI0MsIJiW9+/UYsH6vTNDa/v
 5Xnw==
X-Gm-Message-State: ABy/qLbwm/rR6IS352NTqQLG4HCB+eEX0/1FUlm0UYqmwCOiP7tHTElC
 rZONurfFF9wx+mxDRaJrSc3rp2UXdcusZs3teC8=
X-Google-Smtp-Source: APBJJlErxuGBXevgzjyOo33iFIC4Mbou54KWOnIRgP2wJgo8u3e48dTFI47ucjRbLqUchLDtMqBBAw==
X-Received: by 2002:a05:600c:3641:b0:3fc:1a9:7900 with SMTP id
 y1-20020a05600c364100b003fc01a97900mr9403652wmq.16.1690280705115; 
 Tue, 25 Jul 2023 03:25:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c211300b003fbc30825fbsm12567185wml.39.2023.07.25.03.25.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:25:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] target-arm queue
Date: Tue, 25 Jul 2023 11:24:58 +0100
Message-Id: <20230725102503.2283907-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

target-arm queue: just bugfixes, mostly mine.

thanks
-- PMM

The following changes since commit 885fc169f09f5915ce037263d20a59eb226d473d:

  Merge tag 'pull-riscv-to-apply-20230723-3' of https://github.com/alistair23/qemu into staging (2023-07-24 11:34:35 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230725

for you to fetch changes up to 78cc90346ec680a7f1bb9f138bf7c9654cf526d5:

  tests/decode: Suppress "error: " string for expected-failure tests (2023-07-25 10:56:52 +0100)

----------------------------------------------------------------
target-arm queue:
 * tests/decode: Suppress "error: " string for expected-failure tests
 * ui/curses: For curses display, recognize a few more control keys
 * target/arm: Special case M-profile in debug_helper.c code
 * scripts/git-submodule.sh: Don't rely on non-POSIX 'read' behaviour
 * hw/arm/smmu: Handle big-endian hosts correctly

----------------------------------------------------------------
Peter Maydell (4):
      hw/arm/smmu: Handle big-endian hosts correctly
      scripts/git-submodule.sh: Don't rely on non-POSIX 'read' behaviour
      target/arm: Special case M-profile in debug_helper.c code
      tests/decode: Suppress "error: " string for expected-failure tests

Sean Estabrooks (1):
      For curses display, recognize a few more control keys

 ui/curses_keys.h          |  6 ++++++
 hw/arm/smmu-common.c      |  3 +--
 hw/arm/smmuv3.c           | 39 +++++++++++++++++++++++++++++++--------
 target/arm/debug_helper.c | 18 ++++++++++++------
 scripts/decodetree.py     |  6 +++++-
 scripts/git-submodule.sh  |  2 +-
 6 files changed, 56 insertions(+), 18 deletions(-)

