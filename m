Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F46C02C0F
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Oct 2025 19:38:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzFo-0000rB-3a; Thu, 23 Oct 2025 13:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1vBzFi-0000qA-Cw
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:37:30 -0400
Received: from mail-m17212.xmail.ntesmail.com ([45.195.17.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1vBzFd-0001pf-UK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:37:29 -0400
Received: from DESKTOP-FHFCVTH.localdomain (unknown [114.104.79.1])
 by smtp.qiye.163.com (Hmail) with ESMTP id 26f8a51a7;
 Fri, 24 Oct 2025 01:30:10 +0800 (GMT+08:00)
From: fanyihao@rt-thread.org
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yihao Fan <fanyihao@rt-thread.org>
Subject: 
Date: Fri, 24 Oct 2025 01:30:07 +0800
Message-ID: <20251023173008.46232-1-fanyihao@rt-thread.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a121ef64503a4kunm9f8d824b246a9b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGk8YVhpCSxlPS0oeS0lNT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSk9VSktPVUxCVUpZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
 b=BZqeyAFSugWKp/8aPyhTgBqu/NjW/r/7uKI72AUisdcnLVW7E5rtjR/5VaXjw0tSkrnc23+hcqNWn/M+uM9+LnHjG10jo6BRWaMdZlDhocy0LYkVJkMzMe5LYrKZUg6oLPxNZe2rpOR80c+XD6RkG4Q9lud4xH2CdqxmLrgEtSXjqhHJhe5BI3pg9eDqqfG5cDo5ZkO8o8wM4GrAui7O7gvBGqfMy31hfwwkNmNXJ/iDT7LA4N/1jK61yz73emFhPZzaSAQKnwFguzsPB2zj4vvuJ8O5p/JF73EU7ZVT6ZvPMAe2PCf5wxM4WIdrRWUeeNcW/0k52vL8JHynPwYr1Q==;
 s=default; c=relaxed/relaxed; d=rt-thread.org; v=1; 
 bh=UJ2+eSqtg6AU1/zT1PesOqvWnJFtkJ9DfQOO2qNggAk=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=45.195.17.212;
 envelope-from=fanyihao@rt-thread.org; helo=mail-m17212.xmail.ntesmail.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yihao Fan <fanyihao@rt-thread.org>

Subject: [PATCH v3 0/3] hw/arm Add STM32F4 support and PWR device model

This patch series introduces basic support for the STM32F407 SoC and
a new STM32F4spark machine in QEMU, along with a PWR device model.

In addition, I have modified the header file referenced by the RCC
driver to STM32RCC in accordance with the suggestions.

This series includes:
- A new SoC model (STM32F407) with initial integration.
- A board model called STM32F4spark to instantiate and test the SoC.
- A PWR device implementation for STM32F4xx family.

Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>


Yihao Fan (3):
  hw/arm: Add support for the STM32F407 SoC
  hw/arm: Add support for the STM32F407-RT-SPARk board
  hw/arm/stm32f407: Add PWR device to stm32f407 SoC

 MAINTAINERS                            |  14 ++
 docs/system/arm/STM32F407-RT-SPARK.rst |  41 +++++
 docs/system/arm/stm32.rst              |   2 +
 docs/system/target-arm.rst             |   1 +
 hw/arm/Kconfig                         |  13 ++
 hw/arm/meson.build                     |   2 +
 hw/arm/stm32f407_soc.c                 | 217 +++++++++++++++++++++++++
 hw/arm/stm32f4spark.c                  |  56 +++++++
 hw/misc/Kconfig                        |   3 +
 hw/misc/meson.build                    |   1 +
 hw/misc/stm32f4xx_pwr.c                | 111 +++++++++++++
 include/hw/arm/stm32f407_soc.h         |  77 +++++++++
 include/hw/misc/stm32f4xx_pwr.h        |  40 +++++
 13 files changed, 578 insertions(+)
 create mode 100644 docs/system/arm/STM32F407-RT-SPARK.rst
 create mode 100644 hw/arm/stm32f407_soc.c
 create mode 100644 hw/arm/stm32f4spark.c
 create mode 100644 hw/misc/stm32f4xx_pwr.c
 create mode 100644 include/hw/arm/stm32f407_soc.h
 create mode 100644 include/hw/misc/stm32f4xx_pwr.h

-- 
2.43.0


