Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CD3754560
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 01:28:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKSCB-0000j8-DH; Fri, 14 Jul 2023 19:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qKSC8-0000iO-Q0; Fri, 14 Jul 2023 19:27:29 -0400
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qKSC6-0003yL-MB; Fri, 14 Jul 2023 19:27:28 -0400
Date: Fri, 14 Jul 2023 23:27:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1689377242; x=1689636442;
 bh=Qfo6lq/LbSAZX8skPpnL1wCmTjfPNfbiPFkFqV48zqU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=BdXrUBO8GS4GfBwML2GPF2TausdS84GZd7daRCRLOzzNFpLm+LqcPPiKNWopjJAVc
 NMJXolpq6Yf0EpyNlaXfPc8kfsH+bj+7qaNPkbwiWwGEmY64h+mfly6Jrqri7na+4s
 FSQtEDXHc3TzUJoSKSginG4MDKrXVRNbH8+Yj/rYJUboFzUnkDtiaHF5Z0DTnhgc6Y
 qVkj0bq2XGPRsRhcoBV3Wv06RDi5mRWj848vrJZK6yyvUKB/4BUOnq0WOik2rgdIra
 5ZLYzSnxry/7Viddvdidf4+7syoqEFWn5ZLkQcdlbEjMbIZlJur3TnI18OR3CSdws9
 KHd/EDguW0vCQ==
To: qemu-devel@nongnu.org
From: Chris Laplante <chris@laplante.io>
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Chris Laplante <chris@laplante.io>
Subject: [PATCH 0/6] Add nRF51 DETECT signal with test
Message-ID: <20230714232659.76434-1-chris@laplante.io>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=chris@laplante.io;
 helo=mail-4317.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

This patch series implements the nRF51 DETECT signal
in the GPIO peripheral. A qtest is added exercising the signal.

To implement the test, named out-GPIO IRQ interception had to be added
to the qtest framework. I also took the opportunity to improve IRQ
interception a bit by adding 'FAIL' responses when interception fails.
Otherwise, it is frustrating to troubleshoot why calls to
qtest_irq_intercept_out and friends appears to do nothing.

Chris Laplante (6):
  hw/gpio/nrf51: implement DETECT signal
  qtest: implement named interception of out-GPIO
  qtest: bail from irq_intercept_in if name is specified
  qtest: factor out qtest_install_gpio_out_intercepts
  qtest: irq_intercept_[out/in]: return FAIL if no intercepts are
    installed
  qtest: microbit-test: add tests for nRF51 DETECT

 hw/arm/nrf51_soc.c           |  1 +
 hw/gpio/nrf51_gpio.c         | 14 ++++++++-
 include/hw/gpio/nrf51_gpio.h |  1 +
 softmmu/qtest.c              | 56 ++++++++++++++++++++++++++----------
 tests/qtest/libqtest.c       |  6 ++++
 tests/qtest/libqtest.h       | 11 +++++++
 tests/qtest/microbit-test.c  | 42 +++++++++++++++++++++++++++
 7 files changed, 115 insertions(+), 16 deletions(-)

--
2.39.2



