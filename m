Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5B706276
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzCGr-0005oV-20; Wed, 17 May 2023 04:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGh-0005ig-UA; Wed, 17 May 2023 04:12:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGa-0003Hd-F7; Wed, 17 May 2023 04:12:18 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f415a90215so4513435e9.0; 
 Wed, 17 May 2023 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684311130; x=1686903130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GvLwPP3OlpsxnlaiQ9oet+iKjdJF8kobWIOEfKy9iIM=;
 b=kGfslOCJTXqdlOOsn33bNrZoTRLF1Ab/VnoMR9zMdfWL0+fRQD8cNzZTfRto0xyv7l
 cMbtu3JPOYtspt1EZwKyjHeTepHLBDDs/0LTNdWnr3F3q8XHuWRMxEDe/XWLAyCLWpnV
 eB8PbNn9g36Hw/z7i9Bap6ZoLgTXKCWKoNqVU7V5KPI8Nv1jMSIB/HM3eRfArRwfTpK2
 Egqw1qCkKG3g8hWT0FmxSNooe4NxOyHm7GekVRiVrFQFNHUAoQo+7Clav5rjjU2SV5rr
 xlUPwjsXV6ljYqQcRJ2b5vpMo+58TSVjH13dZgNVU0Da9bFiW62X3e03AUtEMeyEVrTq
 FYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684311130; x=1686903130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GvLwPP3OlpsxnlaiQ9oet+iKjdJF8kobWIOEfKy9iIM=;
 b=AfekONjBvWT3xoFcvVES61109lVBdf4+o9FFg+9zuwCWsvIWQvYKrBb4yQk4ceGOfj
 BNK29AvV643+/n2wBX/138l42uaRaYXVdka8Q8IG+6i7wHbZDxnVehUVloCm8TdxDalv
 f1YFIywyTqP3ITZTVLcmV4I5Y21MWTdgqqW3WxERp4z72FEBv2VQBEN+PalFCUxn50zH
 Qj+CMn1km6RH5YgK73shaAW3IO/Umq/qUudKmSBZkvD2LQsgJ4OKeMzzdzRVGVnsa/dj
 XhITRN1evzzJUBLvLw8+MBM7jDxN1cNtYzlxAB5dCj2ZcADPV0CkKaAvIUjGX5vQUutw
 mP0g==
X-Gm-Message-State: AC+VfDwnW1C1/eJP9PoTazXHFbWhRFvcplURKxFxzLBuEl9WzTWieHM+
 gkvveWCfMvmfY/FJUuEx32I4mTgYuwEfRQ==
X-Google-Smtp-Source: ACHHUZ4y3K9v7lWRe1B8JUh7beyjYWqcYiL7JoaZ/DJ01vz9JPVzXjZRNmIQ4emA/L1uKRcyjVnrXg==
X-Received: by 2002:a7b:c449:0:b0:3f4:2d04:f3f0 with SMTP id
 l9-20020a7bc449000000b003f42d04f3f0mr18186398wmi.39.1684311130021; 
 Wed, 17 May 2023 01:12:10 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 o24-20020a1c7518000000b003f42158288dsm1414942wmc.20.2023.05.17.01.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 01:12:09 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PATCH 0/8] Tiva C Implementation
Date: Wed, 17 May 2023 11:11:56 +0300
Message-Id: <20230517081204.30333-1-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wm1-x32e.google.com
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

This contribution aims to add the Tiva C support into QEMU.
The code could be found at https://github.com/moesay/qemu_TivaC

Mohamed ElSayed (8):
  The tivac board initial machine definition
  tiva c usart module implementation
  tiva c gpio implementation
  tiva c sysctl implementation
  tiva c watchdog timers implementation
  tiva c general purpose timers implementation
  tiva c board documentation
  adding tiva c to the qemu build system and adding my info to the
    maintainers list

 MAINTAINERS                             |   9 +
 configs/devices/arm-softmmu/default.mak |   1 +
 docs/system/arm/tivac.rst               |  47 ++
 hw/arm/Kconfig                          |  13 +
 hw/arm/meson.build                      |   3 +
 hw/arm/tivac.c                          |  56 ++
 hw/arm/tm4c123gh6pm_soc.c               | 275 +++++++
 hw/char/Kconfig                         |   3 +
 hw/char/meson.build                     |   1 +
 hw/char/tm4c123_usart.c                 | 381 +++++++++
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
 33 files changed, 3836 insertions(+)
 create mode 100644 docs/system/arm/tivac.rst
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


