Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8897ED819
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 00:24:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3PDD-0007WF-Ku; Wed, 15 Nov 2023 18:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3PD7-0007W3-95
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 18:22:17 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3PCs-0003IG-4q
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 18:22:16 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso323312a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 15:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700090518; x=1700695318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kkOZV3biFdXSEp/vYh8ReEbONrvb3kSMa+0ggMMO8o0=;
 b=YrX2IwIELFkdal7kNL8agK0O1lig8RVkWIcLUaBmjLwcDkYEbAatmR3/IXs2FRtrhB
 dTUZEe0vl9o8UCWgNQmpvZSjruLm56eRKJofuJVCQL6ghJvthMhllH+JVHSFjgNjJzYv
 MIG+xDPcdcO2HvVFaOF1qVwWhINK6F9uxrWtIF4ugOBDZhP13voYD5MJ1ZpyouvRDy2X
 Y/xhY9mTw6r2GemuWw2QbFFp3QxP49cDqDCt1PYMwMU8DauU6n0Ut2DRw9A63eu5IMfb
 UWjIWKRsupe2fJojkLyYv5pZNZTR2vcj4NfrbJXaOQxYVE69uCsqu24zewEk4p96MG8Y
 bo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700090518; x=1700695318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kkOZV3biFdXSEp/vYh8ReEbONrvb3kSMa+0ggMMO8o0=;
 b=dt0zisvSmPcetxGlL8KZB1ZqkK9orgC5VJdHZYx8WZXTZLlOu9RvJI0bm1z+OrxkiX
 obkQSJmtd7n7LoJyPNTxWq9cYev66I+F3wbkxP4Xed8Xgsv3ZS0EPWGB4Sydxx0QTPuv
 VkUZe1S4woj/azmDIZo7qp03Z6qb8bz/SEUVGHXmkEOe8MDsPZeJz8V6tUwwBJqzyAdu
 PDMEoDOdcJ/rndhuV6BQ2KDJYGCaDZISAbwZ6MeUUXgwJB8Tzx4w7UHLMXM+4AeFSgSr
 FE3WOSCcD/AwDaVAsA6eahoxHMMFaOwk0+tmZnDQ0uGVbiQZj5Hh8gKvqTGC6+czXmkB
 lPKw==
X-Gm-Message-State: AOJu0Yz8zMq6X/0a9GwhEWpSVLITUrw3aJhCVdshZPY2mugk3Hbk1v5I
 HAzwuyggIuU1QxAydBnrrLzM20BNOUe1C/kwJdg=
X-Google-Smtp-Source: AGHT+IELSkv+ph6w5HIg3ubuwDj3U49bjEhCb8UFq/EnJ+0RMUXlpXHD+Yw9vxiPGE/s9MfTYseRrA==
X-Received: by 2002:a05:6402:40e:b0:542:d8a6:bf14 with SMTP id
 q14-20020a056402040e00b00542d8a6bf14mr10711894edv.33.1700090518116; 
 Wed, 15 Nov 2023 15:21:58 -0800 (PST)
Received: from m1x-phil.lan ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a056402174600b00530a9488623sm7063267edx.46.2023.11.15.15.21.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Nov 2023 15:21:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Tyrone Ting <kfting@nuvoton.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Hao Wu <wuhaotsh@google.com>, Felipe Balbi <balbi@kernel.org>,
 Gavin Shan <gshan@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2? 0/6] hw/arm/stm32xxx: Report error when incorrect CPU
 is used
Date: Thu, 16 Nov 2023 00:21:47 +0100
Message-ID: <20231115232154.4515-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

While reviewing this [1] series from Arnaud and Inès,
I realized STM32 based boards don't check the requested
CPU type is correct, and ignore it. Possibly confusing
users.
Since these simple boards code is used as template,
I took the opportunity to sanitize it a bit, using the
MachineClass::valid_cpu_types which seems simpler (to me)
for newcomers.

First 3 patches are candidate for 8.2 but this is a long
standing issue, not a regression from 8.1.

Other patches are similar cleanups, for 9.0. Besides, the
CPU list output will be nicer with Gavin Shan work [2]
integrated.

Regards,

Phil.

[1] https://lore.kernel.org/qemu-devel/170003673257.14701.8139061802716120109-0@git.sr.ht/
[2] https://lore.kernel.org/qemu-devel/20231114235628.534334-1-gshan@redhat.com/

Philippe Mathieu-Daudé (6):
  hw/arm/stm32f405: Report error when incorrect CPU is used
  hw/arm/stm32f205: Report error when incorrect CPU is used
  hw/arm/stm32f100: Report error when incorrect CPU is used
  hw/arm/msf2: Simplify setting MachineClass::valid_cpu_types[]
  hw/arm/npcm7xx_boards: Simplify setting
    MachineClass::valid_cpu_types[]
  hw/arm/musca: Simplify setting MachineClass::valid_cpu_types[]

 include/hw/arm/msf2-soc.h      |  3 ---
 include/hw/arm/stm32f100_soc.h |  4 ----
 include/hw/arm/stm32f205_soc.h |  4 ----
 include/hw/arm/stm32f405_soc.h |  4 ----
 hw/arm/msf2-soc.c              |  3 +--
 hw/arm/msf2-som.c              | 16 ++++++----------
 hw/arm/musca.c                 | 13 +++++--------
 hw/arm/netduino2.c             |  7 ++++++-
 hw/arm/netduinoplus2.c         |  7 ++++++-
 hw/arm/npcm7xx_boards.c        | 13 +++++--------
 hw/arm/olimex-stm32-h405.c     |  8 ++++++--
 hw/arm/stm32f100_soc.c         |  9 ++-------
 hw/arm/stm32f205_soc.c         |  9 ++-------
 hw/arm/stm32f405_soc.c         |  8 +-------
 hw/arm/stm32vldiscovery.c      |  7 ++++++-
 15 files changed, 46 insertions(+), 69 deletions(-)

-- 
2.41.0


