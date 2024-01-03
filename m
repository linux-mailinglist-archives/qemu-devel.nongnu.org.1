Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E49C8230DA
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 16:55:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL3Z7-0004Lp-O6; Wed, 03 Jan 2024 10:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rL3Z5-0004Ke-Pp; Wed, 03 Jan 2024 10:53:55 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rL3Z2-00052C-Ko; Wed, 03 Jan 2024 10:53:55 -0500
Received: from buffy.. (buffy [192.168.147.6])
 by zoidberg.rfc1149.net (Postfix) with ESMTP id 333A280024;
 Wed,  3 Jan 2024 16:53:43 +0100 (CET)
Authentication-Results: zoidberg.rfc1149.net;
 dmarc=fail (p=none dis=none) header.from=rfc1149.net
Authentication-Results: zoidberg.rfc1149.net;
 spf=fail smtp.mailfrom=rfc1149.net
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Anton Kochkov <anton.kochkov@proton.me>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alexandre Iooss <erdnaxe@crans.org>, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH v2 0/3] Add "num-prio-bits" property for Cortex-M devices
Date: Wed,  3 Jan 2024 16:53:34 +0100
Message-ID: <20240103155337.2026946-1-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch series builds on a discussion initiated by Anton Kochkov on
this list in 2022. It allows setting the appropriate number of priority
bits for Cortex-M devices. For example, FreeRTOS checks at startup that
the right number of priority bits is available in order to guarantee
its runtime structures safety. They have added a configuration option
to disable this check when running on QEMU because QEMU always use 2
bits for Cortex-M0/M0+/M1 and 8 bits for other devices.

While this change allows the number of priority bits to be properly
configured, it keeps the same default as before in order to preserve
backward compatibility unless the SoC configures the exact value.

Changes from v1:
- Add support for the STM32L4x5 SOC family (which is currently
  under review for integration) and fix the Based-on: trailer
  in the cover letter.
- Fix a typo in one of the commit messages ("compatibility")

Based-on: <20231221213838.54944-1-ines.varhol@telecom-paris.fr>
([PATCH v4 0/2] Add minimal support for the B-L475E-IOT01A board)

Samuel Tardieu (3):
  hw/intc/armv7m_nvic: add "num-prio-bits" property
  hw/arm/armv7m: alias the NVIC "num-prio-bits" property
  hw/arm/socs: configure priority bits for existing SOCs

 hw/arm/armv7m.c        |  2 ++
 hw/arm/stellaris.c     |  2 ++
 hw/arm/stm32f100_soc.c |  1 +
 hw/arm/stm32f205_soc.c |  1 +
 hw/arm/stm32f405_soc.c |  1 +
 hw/arm/stm32l4x5_soc.c |  1 +
 hw/intc/armv7m_nvic.c  | 23 ++++++++++++++++++++++-
 7 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.42.0


