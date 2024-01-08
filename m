Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B5F82707D
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:00:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMq9q-0002rC-1E; Mon, 08 Jan 2024 08:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rMq9n-0002po-Gc; Mon, 08 Jan 2024 08:59:11 -0500
Received: from zproxy2.enst.fr ([137.194.2.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rMq9i-00053s-LJ; Mon, 08 Jan 2024 08:59:11 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 6EB3C806EB;
 Mon,  8 Jan 2024 14:58:59 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id AGI5SoaeByTy; Mon,  8 Jan 2024 14:58:58 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 9294780705;
 Mon,  8 Jan 2024 14:58:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 9294780705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1704722338;
 bh=B0/YhQWcQBx7EmShbzqiqD9jFUU6McRZiKkR9+V2i9s=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=4I3ED294YGPMOfVz/96iJJDA94pPb2ytjD4ZQdUw9PurnS4smSwRDNVn2QXFHki3g
 4KCkEhY1azW+jz3XWzirYQND29XW4CySUj3/1aOnhkvtPq2/8QC5D6VgWg31l75652
 3Cct5okQRMkjcWKri2VPER7lk3nCJV5ALR/mN2JE=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id en5WBTNRUayr; Mon,  8 Jan 2024 14:58:58 +0100 (CET)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:240:f2a4:b1b:1eac:479c])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 4D0B5806EB;
 Mon,  8 Jan 2024 14:58:58 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 0/2] Add minimal support for the B-L475E-IOT01A board
Date: Mon,  8 Jan 2024 14:58:27 +0100
Message-ID: <20240108135849.351719-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.221;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy2.enst.fr
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

This patch adds a new STM32L4x5 SoC, it is necessary to add support for
the B-L475E-IOT01A board.
The implementation is derived from the STM32F405 SoC and NetduinoPlus2
board.
The implementation contains no peripherals, only memory regions are
implemented.

Changes from v5 to v6:
- in `stm32l4x5_soc.c`: use boolean returned by `memory_region_init_rom()=
`
and `memory_region_init_ram()` instead of checking `errp`

Changes from v4 to v5:
- in `b-l475e-iot01a.c`: adding missing machine/SoC parentship relation
- in `b-l475e-iot01a.c`: renaming `SYSCLK_FRQ` macro
to `MAIN_SYSCLK_FREQ_HZ`
- in `b-l475e-iot01a.c`: fixing coding style issue
- in `stm32l4x5_soc.h`: removing unused imports

Changes from v3 to v4:
- adding a documentation file for the B-L475E-IOT01A board

Changes from v1 to v3:
- changing the MIT license to GPL.

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (2):
  hw/arm: Add minimal support for the STM32L4x5 SoC
  hw/arm: Add minimal support for the B-L475E-IOT01A board

 MAINTAINERS                             |  15 ++
 configs/devices/arm-softmmu/default.mak |   1 +
 docs/system/arm/b-l475e-iot01a.rst      |  46 ++++
 docs/system/arm/stm32.rst               |   6 +-
 docs/system/target-arm.rst              |   1 +
 hw/arm/Kconfig                          |  11 +
 hw/arm/b-l475e-iot01a.c                 |  72 +++++++
 hw/arm/meson.build                      |   2 +
 hw/arm/stm32l4x5_soc.c                  | 265 ++++++++++++++++++++++++
 include/hw/arm/stm32l4x5_soc.h          |  57 +++++
 10 files changed, 474 insertions(+), 2 deletions(-)
 create mode 100644 docs/system/arm/b-l475e-iot01a.rst
 create mode 100644 hw/arm/b-l475e-iot01a.c
 create mode 100644 hw/arm/stm32l4x5_soc.c
 create mode 100644 include/hw/arm/stm32l4x5_soc.h

--=20
2.43.0


