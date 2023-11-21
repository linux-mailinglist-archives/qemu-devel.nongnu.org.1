Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 696637F280F
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:52:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MU4-00066t-QC; Tue, 21 Nov 2023 03:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5MU3-00063Y-1u; Tue, 21 Nov 2023 03:51:51 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5MTo-0003BU-Hm; Tue, 21 Nov 2023 03:51:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZJ5H287Pz4xWM;
 Tue, 21 Nov 2023 19:51:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZJ5F2pL7z4xWJ;
 Tue, 21 Nov 2023 19:51:29 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 0/4] ppc queue
Date: Tue, 21 Nov 2023 09:51:20 +0100
Message-ID: <20231121085124.396578-1-clg@kaod.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=nm9w=HC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

The following changes since commit af9264da80073435fd78944bc5a46e695897d7e5:

  Merge tag '20231119-xtensa-1' of https://github.com/OSLL/qemu-xtensa into staging (2023-11-20 05:25:19 -0500)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-ppc-20231121

for you to fetch changes up to b664466d8f3c7b448fc7e9bd50d03a36538c6c27:

  ppc/pnv: Fix PNV I2C invalid status after reset (2023-11-21 08:39:58 +0100)

----------------------------------------------------------------
ppc queue:

* PNV I2C fixes
* VSX instruction fix when converting floating point to integer values

----------------------------------------------------------------
Cédric Le Goater (1):
      ppc/pnv: Fix potential overflow in I2C model

Glenn Miles (2):
      ppc/pnv: PNV I2C engines assigned incorrect XSCOM addresses
      ppc/pnv: Fix PNV I2C invalid status after reset

John Platts (1):
      target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2 macros

 hw/ppc/pnv.c                    |   6 +-
 hw/ppc/pnv_i2c.c                |  52 +++----
 target/ppc/fpu_helper.c         |  12 +-
 tests/tcg/ppc64/vsx_f2i_nan.c   | 300 ++++++++++++++++++++++++++++++++++++++++
 tests/tcg/ppc64/Makefile.target |   5 +
 5 files changed, 343 insertions(+), 32 deletions(-)
 create mode 100644 tests/tcg/ppc64/vsx_f2i_nan.c

