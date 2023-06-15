Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB6C731F53
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 19:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9qt4-0000c9-4W; Thu, 15 Jun 2023 13:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xCJj=CD=kaod.org=clg@ozlabs.org>)
 id 1q9qsu-0000Zp-RO; Thu, 15 Jun 2023 13:35:48 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xCJj=CD=kaod.org=clg@ozlabs.org>)
 id 1q9qsq-0007g9-6P; Thu, 15 Jun 2023 13:35:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QhqFM0bsCz4x0D;
 Fri, 16 Jun 2023 03:35:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhqFK2nQDz4x0B;
 Fri, 16 Jun 2023 03:35:33 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 0/6] aspeed queue
Date: Thu, 15 Jun 2023 19:35:19 +0200
Message-Id: <20230615173525.428831-1-clg@kaod.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=xCJj=CD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The following changes since commit 7efd65423ab22e6f5890ca08ae40c84d6660242f:

  Merge tag 'pull-riscv-to-apply-20230614' of https://github.com/alistair23/qemu into staging (2023-06-14 05:28:51 +0200)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20230615

for you to fetch changes up to 42bea956f6f7477c06186c7add62fa0107a27a9c:

  target/arm: Allow users to set the number of VFP registers (2023-06-15 18:35:58 +0200)

----------------------------------------------------------------
aspeed queue:

* extension of the rainier machine with VPD contents
* fixes for Coverity issues
* new "bmc-console" machine option
* new "vfp-d32" ARM CPU property

----------------------------------------------------------------
Cédric Le Goater (5):
      aspeed/hace: Initialize g_autofree pointer
      aspeed: Introduce a boot_rom region at the machine level
      aspeed: Use the boot_rom region of the fby35 machine
      aspeed: Introduce a "bmc-console" machine option
      target/arm: Allow users to set the number of VFP registers

Ninad Palsule (1):
      hw/arm/aspeed: Add VPD data for Rainier machine

 docs/system/arm/aspeed.rst | 11 +++++++++
 hw/arm/aspeed_eeprom.h     |  5 ++++
 target/arm/cpu.h           |  2 ++
 hw/arm/aspeed.c            | 58 ++++++++++++++++++++++++++++++++++++++--------
 hw/arm/aspeed_ast2600.c    |  2 ++
 hw/arm/aspeed_eeprom.c     | 45 ++++++++++++++++++++++++++++++++++-
 hw/arm/fby35.c             | 29 ++++++++++++-----------
 hw/misc/aspeed_hace.c      |  2 +-
 target/arm/cpu.c           | 32 +++++++++++++++++++++++++
 9 files changed, 160 insertions(+), 26 deletions(-)

