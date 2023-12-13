Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38543809501
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 22:59:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBMNI-0004sK-Ju; Thu, 07 Dec 2023 16:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rBMNF-0004rP-Bj; Thu, 07 Dec 2023 16:57:37 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rBMND-0007gh-5J; Thu, 07 Dec 2023 16:57:37 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 2A03E11EFBC;
 Thu,  7 Dec 2023 21:57:33 +0000 (UTC)
From: ~inesvarhol <inesvarhol@git.sr.ht>
Date: Thu, 07 Dec 2023 21:57:32 +0000
MIME-Version: 1.0
Subject: [PATCH qemu v2 0/2] hw/arm: Add minimal support for the
 B-L475E-IOT01A board
Message-ID: <170198625302.23093.6056065304261752852-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, philmd@linaro.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 ines.varhol@telecom-paris.fr, arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
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
Reply-To: ~inesvarhol <inesvarhol@proton.me>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch adds a new STM32L4x5 SoC, it is necessary to add support for
the B-L475E-IOT01A board.
The implementation is derived from the STM32F405 SoC and NetduinoPlus2
board.
The implementation contains no peripherals, only memory regions are
implemented.

Changes from v1 to v2:
Thank you Alistair and Alex for your comments on the license.
Just to be safe I changed the MIT license to GPL.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (2):
  hw/arm: Add minimal support for the STM32L4x5 SoC
  hw/arm: Add minimal support for the B-L475E-IOT01A board

 MAINTAINERS                             |  15 ++
 configs/devices/arm-softmmu/default.mak |   1 +
 hw/arm/Kconfig                          |  11 +
 hw/arm/b-l475e-iot01a.c                 |  79 +++++++
 hw/arm/meson.build                      |   2 +
 hw/arm/stm32l4x5_soc.c                  | 277 ++++++++++++++++++++++++
 include/hw/arm/stm32l4x5_soc.h          |  68 ++++++
 7 files changed, 453 insertions(+)
 create mode 100644 hw/arm/b-l475e-iot01a.c
 create mode 100644 hw/arm/stm32l4x5_soc.c
 create mode 100644 include/hw/arm/stm32l4x5_soc.h

--=20
2.38.5

