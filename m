Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFC0735CCE
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:10:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBINn-0001Nx-L5; Mon, 19 Jun 2023 13:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qBINl-0001NE-8d; Mon, 19 Jun 2023 13:09:37 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qBINj-0000kp-Dc; Mon, 19 Jun 2023 13:09:37 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id DFE4A260ADB;
 Mon, 19 Jun 2023 19:09:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eafiISAUVR0d; Mon, 19 Jun 2023 19:09:29 +0200 (CEST)
Received: from applejack.lan (83.11.39.176.ipv4.supernova.orange.pl
 [83.11.39.176])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 5483126021A;
 Mon, 19 Jun 2023 19:09:29 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Shashi Mallela <shashi.mallela@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v2 0/1] hw/arm/sbsa-ref: add ITS support in GIC
Date: Mon, 19 Jun 2023 19:09:12 +0200
Message-Id: <20230619170913.517373-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

In 2021 Shashi Mallela sent v8 of GIC ITS patchset [1]. At that time it
was decided to do platform versioning first.

1. https://lore.kernel.org/qemu-devel/20210812165341.40784-8-shashi.mallela@linaro.org/

Now we are going through our list of changes for SBSA Reference Platform
and GIC ITS is one of early ones. There was decision that there will be
no option to disable it and platform version will get a minor bump.

This is refreshed version of v8 one from 2021. GIC ITS is placed behind
GIC Redistributor in memory space to allow use of older EDK2 firmware.

New address is placed in DeviceTree for firmware to use. Due to it we
also bump platform version to 0.2 version.

Trusted Firmware will read GIC ITS address and provide to EDK2 via
Secure Monitor Call (SMC). Same way as it is done with GIC addresses
already.

Changes since v1:
- everything in one patch
- removed bogus check for kvm_irqchip_in_kernel()
- documentation about platform version changes added


Shashi Mallela (1):
  hw/arm/sbsa-ref: add ITS support in SBSA GIC

 docs/system/arm/sbsa.rst | 14 ++++++++++++++
 hw/arm/sbsa-ref.c        | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.40.1


