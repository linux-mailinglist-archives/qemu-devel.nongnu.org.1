Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FEE722E0A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ERv-000615-5V; Mon, 05 Jun 2023 13:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ERt-0005z5-Eb
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:56:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ERo-0001Td-DO
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:56:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6a6b9c079so43495915e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685987810; x=1688579810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z4iRS52vMXLw0AkceVZ45AaR9KR5nynhoiwOY8S0/1k=;
 b=JvUMPxDTwBcxrKGK001Evohn4qO6qpLypYWZz8Aywkci621pdV3QGzrqVo8S/Qo1mY
 aL1fla10Uzt7HvSJyXlZ+Nk1OtpRughxGdiyfDMWBQc+TdninHFhPVcl9egPUh9cIgh6
 ZobXJk6pgBCy5pvyz+MeqX/CmoYd+7pIRW6Xz4tpIhhPT8+65rbMshyt2T+k7QbjEpmQ
 DVQQDRAh4avshR+HkT3AN6CQfHVJ6+gVhshV0HuknkZSYgzRYnlRmxhh6RdDWM+RS//l
 MbUi23/eUmLGgm4cWsRJINeB0U8oV7ahEkLIAgNDdx4JbboMb/bVoVqLtOhKp078Rf4L
 QMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685987810; x=1688579810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4iRS52vMXLw0AkceVZ45AaR9KR5nynhoiwOY8S0/1k=;
 b=YqCEcvhzwNX/JxpNtY9qY1xhXmXCAKpF5yewRL+mvF72eycZJYDGzGB+sV4UJHL9hU
 yKOP4PbApzVMeXDw+SMYJ1Pxz4TmtHSYI5TaxqDaksHnmSMHf0pKWLjSGHEhXrV7T8xA
 2fdclZ+sbFEMmQdGrKpwFa9jLxXXzsvmPPRqtZDDyzW+AYQ30ZFtMixPGF/3tVBTGPe6
 FIlyWIM6m/eofxrbTR7eQ2en9rOtFgy278VcE9VRKK0bySS46iVsCIsTtR8lnLEYw7fA
 EXEn/cTun5R7LHmF65Js/o3utajsqLwElgnyDHWLjXwlq38vvl3XlJ8gnYbxuYejIyqy
 UN1g==
X-Gm-Message-State: AC+VfDzlCGssEeQY2RJmdI6MVVxaETd3lCRxowPFXeiWSwNZL4OLSpzk
 Carear6nSDzuTQ9sl4dn75C4258mMrhbK1LaESY=
X-Google-Smtp-Source: ACHHUZ5VFX7lY9jGLRKmZlcsfgRlUwpXx1+zoR5ELeSrX5L0ZnqUsnFpuuyQhw+zE+QQP34d9zVhgw==
X-Received: by 2002:a05:600c:2206:b0:3f7:e800:abc8 with SMTP id
 z6-20020a05600c220600b003f7e800abc8mr771020wml.15.1685987810688; 
 Mon, 05 Jun 2023 10:56:50 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a5d6185000000b0030af05fce4dsm10424645wru.77.2023.06.05.10.56.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 10:56:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/5] bulk: Do not declare function prototypes using
 'extern' keyword
Date: Mon,  5 Jun 2023 19:56:42 +0200
Message-Id: <20230605175647.88395-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
- Do not change variable declarations in "block/dmg.h" (danpb)
- Rebased
- Added R-b from v1

v1:
- Remove the 'extern' keyword on function prototypes declared
  in header.
- Replace __attribute__((noreturn)) -> G_NORETURN
- Trivial cleanups to keep the previous commits generic.

Based-on: <20230605174146.87440-1-philmd@linaro.org>

Philippe Mathieu-Daudé (5):
  util/cacheflush: Use declarations from <OSCacheControl.h> on Darwin
  tcg/tcg-op-vec: Remove left over _link_error() definitions
  qemu/uri: Use QueryParams type definition
  bulk: Do not declare function prototypes using 'extern' keyword
  bulk: Replace __attribute__((noreturn)) -> G_NORETURN

 bsd-user/bsd-file.h            |  6 ++---
 crypto/hmacpriv.h              | 13 +++++------
 hw/xen/xen_pt.h                |  8 +++----
 include/crypto/secret_common.h | 14 +++++-------
 include/exec/page-vary.h       |  4 ++--
 include/hw/misc/aspeed_scu.h   |  2 +-
 include/hw/nvram/npcm7xx_otp.h |  4 ++--
 include/hw/qdev-core.h         |  4 ++--
 include/qemu/crc-ccitt.h       |  4 ++--
 include/qemu/osdep.h           |  4 ++--
 include/qemu/rcu.h             | 14 ++++++------
 include/qemu/sys_membarrier.h  |  4 ++--
 include/qemu/uri.h             |  6 ++---
 include/sysemu/accel-blocker.h | 14 ++++++------
 include/sysemu/os-win32.h      |  4 ++--
 include/user/safe-syscall.h    |  4 ++--
 target/i386/sev.h              |  6 ++---
 target/mips/cpu.h              |  4 ++--
 tcg/tcg-internal.h             |  4 ++--
 include/exec/memory_ldst.h.inc | 42 +++++++++++++++++-----------------
 tcg/tcg-op-vec.c               | 11 ---------
 tests/migration/stress.c       |  2 +-
 util/cacheflush.c              |  4 ++--
 23 files changed, 82 insertions(+), 100 deletions(-)

-- 
2.38.1


