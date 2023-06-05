Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AFE7224A6
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68SY-0004MW-PX; Mon, 05 Jun 2023 07:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SO-0004K6-5D
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:33:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SM-0008Mv-F4
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6VNJNfovM6IAHqtCsjMnxPI/IpJogaKyhowmplqm8CE=; b=stEaF7ZFhkDcn6GJWHwxV0zJjR
 d30A0rK7WzP2HC1LWyhOdeAL7Wl3NDR/QJXJu0q2iOgd8QFoncn7mhDMeCcWo5bxC2TDeHhPAta5s
 zVNZJrpps2OK7ZR7EkZs1B6OfpKuRupNNDNXmXY7A8dIteC/ksMHtL/Fbo/uWkGUIOGHoywVz/eyI
 iMuENldCQ4DYmL+i5n//IZGc5IBYK8enUO440D35d+UBl9D7Pfsj7+LUrnrPC5qA16kYMO7VNRTBC
 utLHVH7P28BEwNOtvcINxn7+qnqzveOsew7cDXbYds7w5oVsIMfS1E90dX8JPxYS+PO6fAoxnOhMG
 FZTV/6w9k/xv+5/ByDaKm2OEqJCT+H8PoAfgGnUs/JiIWGo+pPXLozrFECL3neTH19e9+B2/0uhyC
 8VQTN2GAH6+CtZ5WkzD+ZZn9ZtlGJ8Ueq0oihJxgFz7PeUxyu+d27g8GoL6mOl4sOXu92VjUcBV5s
 N1A/msl+6tpr03Px931jLfbI1U/XWvfgm+/k3O2T5yiLH24tpZaKKx2ZyiAx7nXmktN3h8G9Okivb
 j2DSKJRHCnkEW+epZWlrpMZr6XOq7MzWpDTOVvmhbmaennWnkzcxoynUcDG5mT8NTQQ+k6kc+OhOF
 p91uBr7PHoo/CCrfo6aoPM8sO8XotcT6lssCl9eA4=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SF-0005fJ-7S; Mon, 05 Jun 2023 12:32:59 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Mon,  5 Jun 2023 12:32:50 +0100
Message-Id: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 0/3] qemu-sparc queue 20230605
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The following changes since commit 848a6caa88b9f082c89c9b41afa975761262981d:

  Merge tag 'migration-20230602-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-06-02 17:33:29 -0700)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-20230605

for you to fetch changes up to 36c9189890bfb936b1b086da639e37fd92b50215:

  hw/isa/i82378: Remove unused "io" attribute (2023-06-05 07:43:23 +0100)

----------------------------------------------------------------
qemu-sparc queue

Hi Richard,

This is one of Bernhard's cleanup series where all patches have been
reviewed/acked. Please apply.

----------------------------------------------------------------
Bernhard Beschow (3):
      hw/timer/i8254_common: Share "iobase" property via base class
      hw/arm/omap: Remove unused omap_uart_attach()
      hw/isa/i82378: Remove unused "io" attribute

 hw/char/omap_uart.c     | 9 ---------
 hw/i386/kvm/i8254.c     | 1 -
 hw/isa/i82378.c         | 1 -
 hw/timer/i8254.c        | 6 ------
 hw/timer/i8254_common.c | 6 ++++++
 include/hw/arm/omap.h   | 1 -
 6 files changed, 6 insertions(+), 18 deletions(-)

