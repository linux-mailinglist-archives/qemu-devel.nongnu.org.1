Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1037D74477E
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVv-0007WW-Sp; Sat, 01 Jul 2023 02:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVp-0007Tr-H3
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:17 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVn-0007EZ-03
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:17 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fba8f2197bso1070639e87.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194513; x=1690786513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DQAIpWnde8XmaUaSLH8gsoP+vMyKst8btXPNXLq8KfE=;
 b=z0w0WLDLpYihwuE1IfBTmCrPGYLJ3NX81Lub0bsLLbqFnfJ3PUG0ERu+EJY7KQS+2I
 F/Z9NHVPRKTf7eAZAen2cpXFS8UwQDlJSPQoGMbZwYxSan9O3k6niVG98fUWpc6qs3Ia
 qC9nOPNKo7PI40jOud7nfO4UovDPd0ZJUf+X5TEbmjNNSFNWEj9oTlrAh8RHbLBx7FCU
 VrpZScVS433Jb6SIpZwYngqJqUqYKVDqLreCAH3Nuo237fdlf13F7ziSHERoJ8Y25Qy4
 z7XtHoQHpSclecbYKGTrbgFuxZEC8a9ZWUyaCPlF1ztzE/8m745OXZ4kS+/rEhPiwD2d
 twVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194513; x=1690786513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DQAIpWnde8XmaUaSLH8gsoP+vMyKst8btXPNXLq8KfE=;
 b=gRdZupJmdkqqRuawBeUxvEuZe1FpwlCzYKi/KAXJOyBUU5f8ICZzVp+854OUrd8Chs
 hzqwvWvbLut+GpaA2EgnR3NOthJSCL1MbKqostVuvCGM4QuUy7WDg9CB+EJXUYMi+VFR
 +jgFflRgeVRTgLJnDHqlqOcZlbCNZ+yFtwptmZukL5Eju5Ait2Qmk/IJUgPoLKYzyuiq
 KsF+5mBzaLdZ8hVV5BDnR5cjk4+FXP8+LkkZSGYgg+SOOuYG+sXeLemAGSbWb/SkQqaJ
 dTDMCg6MUJRDWHuerGGzW7kmDGA/ocWhfuRExnhmVap8c2PNTMNJ3go/UtqqjQluUTRF
 1XTg==
X-Gm-Message-State: ABy/qLaVnHfYKtlPXWL+d5xThugohmI9VNhToMSEwKy/HMrM3JaUHATv
 dMJgu+q/eE12FIFfZTuPDy90gbI00dTR4LZtgTSU5A==
X-Google-Smtp-Source: APBJJlFgDQpYm9BnQbKh5ec8Ynb3YkuBgluUlnIAQDLGLMXhKbUYqcYkp7mycyxvvV+iyewR8gyxtQ==
X-Received: by 2002:ac2:5e2c:0:b0:4fb:81f2:4228 with SMTP id
 o12-20020ac25e2c000000b004fb81f24228mr3251631lfg.31.1688194512722; 
 Fri, 30 Jun 2023 23:55:12 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] tcg and misc patch queue
Date: Sat,  1 Jul 2023 08:54:59 +0200
Message-Id: <20230701065510.514743-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x132.google.com
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

The following changes since commit 408015a97dbe48a9dde8c0d2526c9312691952e7:

  Merge tag 'pull-vfio-20230630' of https://github.com/legoater/qemu into staging (2023-06-30 08:11:08 +0200)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230701

for you to fetch changes up to 605a8b5491a119a2a6efbf61e5a38f9374645990:

  linux-user: Avoid mmap of the last byte of the reserved_va (2023-07-01 08:33:08 +0200)

----------------------------------------------------------------
dbus: Two hot fixes, per request of Marc-André Lureau
accel/tcg: Fix tb_invalidate_phys_range iteration
fpu: Add float64_to_int{32,64}_modulo
tcg: Reduce scope of tcg_assert_listed_vecop
target/nios2: Explicitly ask for target-endian loads
linux-user: Avoid mmap of the last byte of the reserved_va

----------------------------------------------------------------
Marc-André Lureau (1):
      audio: dbus requires pixman

Mark Cave-Ayland (2):
      accel/tcg: Fix start page passed to tb_invalidate_phys_page_range__locked
      accel/tcg: Assert one page in tb_invalidate_phys_page_range__locked

Peter Maydell (1):
      target/nios2 : Explicitly ask for target-endian loads and stores

Philippe Mathieu-Daudé (1):
      tcg: Reduce tcg_assert_listed_vecop() scope

Richard Henderson (6):
      ui/dbus: fix build errors in dbus_update_gl_cb and dbus_call_update_gl
      fpu: Add float64_to_int{32,64}_modulo
      tests/tcg/alpha: Add test for cvttq
      target/alpha: Use float64_to_int64_modulo for CVTTQ
      target/arm: Use float64_to_int32_modulo for FJCVTZS
      linux-user: Avoid mmap of the last byte of the reserved_va

 include/fpu/softfloat.h         |  3 ++
 include/tcg/tcg.h               |  6 ---
 accel/tcg/tb-maint.c            | 13 +++++--
 fpu/softfloat.c                 | 31 +++++++++++++++
 linux-user/mmap.c               | 14 +++++--
 target/alpha/fpu_helper.c       | 85 +++++++++--------------------------------
 target/arm/vfp_helper.c         | 71 ++++++----------------------------
 target/nios2/translate.c        | 20 +++++-----
 tcg/tcg-op-vec.c                |  6 +--
 tests/tcg/alpha/test-cvttq.c    | 78 +++++++++++++++++++++++++++++++++++++
 ui/dbus-listener.c              |  4 ++
 fpu/softfloat-parts.c.inc       | 78 +++++++++++++++++++++++++++++++++++++
 audio/meson.build               |  2 +-
 tests/tcg/alpha/Makefile.target |  2 +-
 14 files changed, 258 insertions(+), 155 deletions(-)
 create mode 100644 tests/tcg/alpha/test-cvttq.c

