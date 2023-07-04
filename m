Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD33A747345
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:50:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgPQ-0002uT-6l; Tue, 04 Jul 2023 09:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGgPO-0002tC-6Y; Tue, 04 Jul 2023 09:49:34 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGgPM-0006VP-4Q; Tue, 04 Jul 2023 09:49:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwPKg1NHPz4wxS;
 Tue,  4 Jul 2023 23:49:27 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwPKd1xqbz4wZw;
 Tue,  4 Jul 2023 23:49:25 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 0/4] ppc: Improve multisocket support
Date: Tue,  4 Jul 2023 15:49:17 +0200
Message-ID: <20230704134921.2626692-1-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=18er=CW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello,

Here are changes improving multisocket support of the XIVE models
(POWER9 only). When a source has an END target on another chip, the
XIVE IC will use an MMIO store to forward the notification to the
remote chip. The long term plan is to get rid of pnv_xive_get_remote()
whic is a modeling shortcut. I have had them for while, they compile,
they seem to still work but this is not for merge yet. If someone
could take over, that would be nice.

The best way to test is to start a 2 sockets * 1 cpu system with devices
attached to the PCI buses of chip 0 and to offline CPU 0. All sources
should be configured to be served by CPU 1 on socket 1 and trigger
notifications on chip 0 should be forwarded to chip 1.

Last patch adds support for degenerative interrupts. This is used by
the lowest level FW of POWER systems. Difficult to test.

Thanks,

C. 

Cédric Le Goater (4):
  ppc/xive: introduce a new XiveRouter end_notify() handler
  ppc/pnv: handle END triggers between chips with MMIOs
  ppc/pnv: add support for the PC MMIOs
  ppc/pnv: Add support for degenerative interrupts (POWER LSI)

 hw/intc/pnv_xive_regs.h   |   1 +
 include/hw/ppc/pnv_xive.h |  15 +++
 include/hw/ppc/xive.h     |   3 +
 hw/intc/pnv_xive.c        | 262 +++++++++++++++++++++++++++++++-------
 hw/intc/xive.c            |  50 ++++++--
 5 files changed, 278 insertions(+), 53 deletions(-)

-- 
2.41.0


