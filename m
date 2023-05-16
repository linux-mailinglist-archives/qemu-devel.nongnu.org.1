Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A248D704667
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyp8P-0004VB-Td; Tue, 16 May 2023 03:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pyp8M-0004Uu-JD; Tue, 16 May 2023 03:30:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pyp8K-0008Jb-Jt; Tue, 16 May 2023 03:30:10 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f42711865eso62317125e9.0; 
 Tue, 16 May 2023 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684222205; x=1686814205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9SXdw2KoJyLsRLwNZT6ZO9qNZzgWNuwXfyfujFOJ2/U=;
 b=nZLVUz4EGQC/YBOQmny3DThIoOx27l4BWAYNru7OijTV8K6aitSQSfV3rnIg6mUwWI
 MiYtjun00fTwLhopr9mN8ZIGXwf7DA1CxngvkTmWvUA46qw0iRQMuvU6FannctrJIe4y
 EGSBC207mZC6ftMDKji2XwSbfwjBZq8+ZooPVhG+ibk3szU6DnDn4kE1yC7OPFAVV3ZB
 NrXJJx0cqZQSm9hDWsZSMwxdUFO9Z7aKYbie33YE5x8TqLSm6eq/nvSeXw+BnuTh/1y6
 wLq6jchExM3DAPsUYn13FQy3f8JXPKrN9iED+R4hv3IVBUvWioweVjs58kbnci+GyUkr
 b6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684222205; x=1686814205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9SXdw2KoJyLsRLwNZT6ZO9qNZzgWNuwXfyfujFOJ2/U=;
 b=i3CacbhtmsVQabV8wNQnhCKyOrpmoE8epZ43odjpVYeZwvHegWOzHHbqYzlFJGlp4i
 xY+sW9MbHjlnkfSVNMQXUK3ED1cSHgKnGcApT5Af4GbUl4R0qquDXb6FzKP6z/y9eSR2
 pu+YaT+2DVgVHfhWSG6nXpMeF9BXGhRocgaiRAIxgYjbntl6VgC3neF6Vot49sp+3z7v
 EQai5UUTEPxcqrBTXyQF1ehG+q7XI8DMlfxFSlH/kbe/WonEwXCZOIsrQ3FqJgim8j7o
 Ao6qn7s1rC2U1g1e/mPeJgnP9cZWuW3Y2Xp3HCCsqr605ta8R9IF3bXD741H9Z7Xg5Aq
 I+eg==
X-Gm-Message-State: AC+VfDzxyivxXziyodvbyVKcEPX4sBlVmebX6FVaQvvGPxjJlqGXsgnx
 SVNhh+3fI172zf/cOYYQ570IBe+aKak=
X-Google-Smtp-Source: ACHHUZ7q90qwdW2sEHjxqQeTxn5PvCp1UoHQdaGXcxblwXpYCMNjc26ewwZunt7BaYOeK32G96HyXA==
X-Received: by 2002:a7b:cc10:0:b0:3f1:7aff:e14a with SMTP id
 f16-20020a7bcc10000000b003f17affe14amr23654871wmh.39.1684222204784; 
 Tue, 16 May 2023 00:30:04 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 y12-20020a5d614c000000b003062c609115sm1559997wrt.21.2023.05.16.00.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 00:30:04 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PULL SUBSYSTEM arm 0/8] TivaC Implementation
Date: Tue, 16 May 2023 10:29:51 +0300
Message-Id: <20230516072959.49994-1-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

***
This is an implementation for the TivaC board.
For now it models the system control block, the general purpose I/O, the general purpose timers, the watchdog timers and the usart module.

The code is available at https://github.com/moesay/qemu_TivaC.git
***

Mohamed ElSayed (8):
  the tivac machine def initial commit
  tivac usart module implementation
  tivac gpio module implementation
  tivac system control implementation
  tivac general purpose timers implementation
  tivac watchdog timers implementation
  editing the meson and KConfig files to add tivac to qemu build system
  code style fixes

 .gitignore                              |   1 +
 README.rst                              | 150 +---
 configs/devices/arm-softmmu/default.mak |   1 +
 hw/arm/Kconfig                          |  13 +
 hw/arm/meson.build                      |   3 +
 hw/arm/tivac.c                          |  56 ++
 hw/arm/tm4c123gh6pm_soc.c               | 276 +++++++
 hw/char/Kconfig                         |   3 +
 hw/char/meson.build                     |   1 +
 hw/char/tm4c123_usart.c                 | 383 +++++++++
 hw/char/trace-events                    |   4 +
 hw/gpio/Kconfig                         |   3 +
 hw/gpio/meson.build                     |   1 +
 hw/gpio/tm4c123_gpio.c                  | 372 +++++++++
 hw/gpio/trace-events                    |   4 +
 hw/misc/Kconfig                         |   3 +
 hw/misc/meson.build                     |   1 +
 hw/misc/tm4c123_sysctl.c                | 989 ++++++++++++++++++++++++
 hw/misc/trace-events                    |   5 +
 hw/timer/Kconfig                        |   3 +
 hw/timer/meson.build                    |   1 +
 hw/timer/tm4c123_gptm.c                 | 495 ++++++++++++
 hw/timer/trace-events                   |   5 +
 hw/watchdog/Kconfig                     |   3 +
 hw/watchdog/meson.build                 |   1 +
 hw/watchdog/tm4c123_watchdog.c          | 297 +++++++
 hw/watchdog/trace-events                |   3 +
 include/hw/arm/tm4c123gh6pm_soc.h       |  71 ++
 include/hw/char/tm4c123_usart.h         | 124 +++
 include/hw/gpio/tm4c123_gpio.h          | 127 +++
 include/hw/misc/tm4c123_sysctl.h        | 307 ++++++++
 include/hw/timer/tm4c123_gptm.h         | 131 ++++
 include/hw/watchdog/tm4c123_watchdog.h  |  97 +++
 33 files changed, 3797 insertions(+), 137 deletions(-)
 create mode 100644 hw/arm/tivac.c
 create mode 100644 hw/arm/tm4c123gh6pm_soc.c
 create mode 100644 hw/char/tm4c123_usart.c
 create mode 100644 hw/gpio/tm4c123_gpio.c
 create mode 100644 hw/misc/tm4c123_sysctl.c
 create mode 100644 hw/timer/tm4c123_gptm.c
 create mode 100644 hw/watchdog/tm4c123_watchdog.c
 create mode 100644 include/hw/arm/tm4c123gh6pm_soc.h
 create mode 100644 include/hw/char/tm4c123_usart.h
 create mode 100644 include/hw/gpio/tm4c123_gpio.h
 create mode 100644 include/hw/misc/tm4c123_sysctl.h
 create mode 100644 include/hw/timer/tm4c123_gptm.h
 create mode 100644 include/hw/watchdog/tm4c123_watchdog.h

--
2.34.1


