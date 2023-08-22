Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E93E07838CB
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYIxb-0006Jl-2a; Tue, 22 Aug 2023 00:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxX-0006Ek-9b
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:39 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxS-0007Vl-99
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:38 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68a3236a414so2029144b3a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692678332; x=1693283132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D/7Y2YmeMVgHIyf5S/5OxQ4B8Ovk33UJWuMGrWw9fNQ=;
 b=qzwt6Ue5K2z3ql52paJ2S5mqPGSV7ofPrKoarQ2Dfi0jZZBgecAM1Ixty6+fQfn89Y
 UwsfRFHcloRi0xOpRHMclJD/Km78LQJFxtD5jYcIWbySXIcF3Z5f63rE2BosLQMNFASa
 084Ksx+Onfa1U++wdVt46QuyeR5dcFWZnjCc1R1rqVhVvgAwTPWqzXEtt1lyjau3vX5G
 7jKp/ijH8Wzjv91eKIBbREP/1An8jNlPiWZ9QZMkQoKMghorJh108cT1olpBqDNkaKez
 lX7AgS1wJU3sP0A0leeSFfQ+VVkkRp1DQN8zE9Zt1hUZGiRjAoAQi1kppNnWeWuIyo4H
 dW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692678332; x=1693283132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D/7Y2YmeMVgHIyf5S/5OxQ4B8Ovk33UJWuMGrWw9fNQ=;
 b=OSVS8beKsmPrMa90iFGz1X1maXOG/5T/zqGl1A0Te7H3e1CCesYOqqZAT+b5lNsPs8
 mIJU5ktU85R2VynrOUtSBdJBGSmvuqxMEnm4ZOq6lOaB5nl5WBHHzSJYNCTC2oPD7Ky0
 6Nd2GreLeVjoPozyeZPOG2NRYQEZVxWs0D5fx7Uy9XxiroDnn6AU6u/GX3FRebmZThTJ
 FBf5bZkj5PkNB2rQg7qP5kCHSQ5JlhDWHKhqwbDGf+fD8/VbVjkefRsp+QPt+6UkjnzB
 kEHGWhsUTPPPR2D2G5/aheJXvgf43VBozUf08nFwMqlRX8f1OTvQkHuGTuk1eaj1G1fR
 uVBQ==
X-Gm-Message-State: AOJu0YyJZFIH7Ft9nLbW1Wb+vmXE2OPQIOhe5Vvv0wEGyLF789LaSoc6
 hhNtGZHh6UDGb6m80vWR+CMheyR32RSCZze5mdE=
X-Google-Smtp-Source: AGHT+IGevb9XRnlGRj+blLYPzEVsFT6x92756WM/fAjSvZ3B5jop5YpLPPP+YjuB4VVOQ3ZHsUqpOg==
X-Received: by 2002:a05:6a00:14d0:b0:68a:45a1:c0ee with SMTP id
 w16-20020a056a0014d000b0068a45a1c0eemr6290266pfu.15.1692678332076; 
 Mon, 21 Aug 2023 21:25:32 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa7900e000000b0068a3f861b24sm3364908pfo.195.2023.08.21.21.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 21:25:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 0/9] Implement Most ARMv8.3 Pointer Authentication Features
Date: Mon, 21 Aug 2023 21:25:21 -0700
Message-Id: <20230822042530.1026751-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an update of Aaron's v3 [1].
There are a fair number of changes beyond a mere rebase:

  * Updates to the test cases which fail with the new features.
  * Updates to the documentation.
  * Preserve pauth feature set when changing pauth algorithm.
  * Rearrange feature detection:
     - Add ARMPauthFeature
     - Use it with isar_feature_pauth_feature
     - Remove many of the isar predicates
    The pauth_auth and pauth_addpac routines wind up making lots
    of tests against the pauth feature set.  Rather than recompute
    the feature set many times for each predicate, compute it once
    and compare against the enumerators.
  * Algorithmic simplification of Pauth2 and FPAC using cmp_mask.

r~

[1] https://patchew.org/QEMU/20230322202541.1404058-1-aaron@os.amperecomputing.com/

Aaron Lindsay (6):
  target/arm: Add ID_AA64ISAR2_EL1
  target/arm: Add feature detection for FEAT_Pauth2 and extensions
  target/arm: Implement FEAT_EPAC
  target/arm: Implement FEAT_Pauth2
  targer/arm: Inform helpers whether a PAC instruction is 'combined'
  target/arm: Implement FEAT_FPAC and FEAT_FPACCOMBINE

Richard Henderson (3):
  tests/tcg/aarch64: Adjust pauth tests for FEAT_FPAC
  target/arm: Don't change pauth features when changing algorithm
  target/arm: Implement FEAT_PACQARMA3

 docs/system/arm/cpu-features.rst  |  21 ++--
 docs/system/arm/emulation.rst     |   7 ++
 target/arm/cpu.h                  |  51 +++++++--
 target/arm/syndrome.h             |   7 ++
 target/arm/tcg/helper-a64.h       |   4 +
 target/arm/arm-qmp-cmds.c         |   2 +-
 target/arm/cpu64.c                |  86 ++++++++++----
 target/arm/helper.c               |   4 +-
 target/arm/hvf/hvf.c              |   1 +
 target/arm/kvm64.c                |   2 +
 target/arm/tcg/cpu64.c            |   2 +
 target/arm/tcg/pauth_helper.c     | 180 ++++++++++++++++++++++++------
 target/arm/tcg/translate-a64.c    |  12 +-
 tests/qtest/arm-cpu-features.c    |  12 +-
 tests/tcg/aarch64/pauth-2.c       |  61 ++++++++--
 tests/tcg/aarch64/pauth-4.c       |  28 ++++-
 tests/tcg/aarch64/pauth-5.c       |  20 ++++
 tests/tcg/aarch64/Makefile.target |   5 +-
 18 files changed, 409 insertions(+), 96 deletions(-)

-- 
2.34.1


