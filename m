Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA95A85196F
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Feb 2024 17:36:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZGt-0001pA-Ru; Mon, 12 Feb 2024 11:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rZZGr-0001oC-9J; Mon, 12 Feb 2024 11:35:05 -0500
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rZZGp-0005QB-1f; Mon, 12 Feb 2024 11:35:05 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 206C8A05C2;
 Mon, 12 Feb 2024 17:34:58 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id cKuKfBSK7DiA; Mon, 12 Feb 2024 17:34:57 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id C8DD9A0590;
 Mon, 12 Feb 2024 17:34:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr C8DD9A0590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1707755697;
 bh=XTbusDoko4+deqOm+fSdKoIBKSVRBD05pQwlOS2R/6I=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=oVcSKfO3oMafVmtbm3jNPts+VuYCjwQJPTa9v1Yr+btfGRaIFb6Xo0KW9/IE+mnpb
 5qyFhAd3fdH4pMhh9nEqFF8y16nRT/0kHDPcutC6jrIJiadn6Jd+usNLSvWyZZ+ocZ
 nBKpnZLu6Iwvo6fh7sXYOlGp21WpBLvqzrfarC0Y=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id QKIZWi2MHzfJ; Mon, 12 Feb 2024 17:34:57 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 6B10CA0562;
 Mon, 12 Feb 2024 17:34:57 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH 0/2] hw/arm: Fix STM32L4x5 EXTI to CPU irq fan-in connections
Date: Mon, 12 Feb 2024 17:31:17 +0100
Message-ID: <20240212163446.227802-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.222;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
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

The original code was connecting several outbounds qemu_irqs to the
same qemu_irq without using a TYPE_OR_IRQ.

This patch fixes the issue by using OR gates when necessary (1st commit).

I attempted to check that the problem is fixed by using a QTest (2nd comm=
it)
but actually the test is passing even before the fix :
when any fan-in input line is raised, the output is raised too.

Fixes: 52671f69f7a4 ("[PATCH v8 0/3] Add device STM32L4x5 EXTI")
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (2):
  hw/arm: Use TYPE_OR_IRQ when connecting STM32L4x5 EXTI fan-in IRQs
  tests/qtest: Check that EXTI fan-in irqs are correctly connected

 hw/arm/stm32l4x5_soc.c            | 69 ++++++++++++++++++----
 tests/qtest/stm32l4x5_exti-test.c | 97 +++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+), 10 deletions(-)

--=20
2.43.0


