Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07051826469
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 15:05:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMTmD-0005aE-6s; Sun, 07 Jan 2024 09:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rMTm6-0005QI-7d
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 09:05:14 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rMTm3-0006ua-2R
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 09:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1704636309; bh=//Fd5lI5J8z6T03oQgOMGUggiy/9qp+ute6/BYnhrdM=;
 h=From:Subject:Date:To:Cc:From;
 b=dRfMQfAM0bimLBk2UTFm9TqSCpO2CtmCSqRsLQjuQKUPaNTgvo0P109EkaxoOefHJ
 5oW8WAHTXOVl5LsMpIumC4S33U+hXK6Eno4lqDqVJGD4GIzl8SwXiCJ5hQcRZP1AMN
 V4lH7yngD7issq7CIyWpitUUB1vDu5V8XIJG5QiQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH v4 0/4] hw/misc/pvpanic: add support for normal shutdowns
Date: Sun, 07 Jan 2024 15:05:07 +0100
Message-Id: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJOvmmUC/33NQQ7CIBCF4as0rMXADCi48h7GRaFU2LQNVNQ0v
 bu0q8Y0Lt8k3z8TSS4Gl8ilmkh0OaTQd2WIQ0Wsr7uHo6EpmwAD5JwJOuSh7oKlyT/Hpn91lIE
 TRlgjtNCksCG6NrzX5O1etg9p7ONn/ZD5cv0Ty5yyUkSJXJ6V5uY6UmX9sXFkaWXYeFA7HopXy
 FCjEdKa04/Hrdc7Hou3ugalobUScOPnef4C9UC44y8BAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704636308; l=2648;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=//Fd5lI5J8z6T03oQgOMGUggiy/9qp+ute6/BYnhrdM=;
 b=plaJlaCLZSp8nBLIgttxvu0djy57CQaVFuOxkIwi5xL+XklxubGpBKwA7csATzD70xPB5aCFu
 AlJ58OOMdpTAYhWxEYuz0xybdigvpHB5YtHCp8PY3rBY4MrbTucdZlb
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
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

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

The background is the usage of minimal Linux kernels with different
architectures for testing purposes.
Poweroff support varies highly per architecture and requires a bunch of
code to be compiled to work.
pvpanic on the other hand is very small and uniform.

I sent an RFC[0] for this before to qemu-devel and lkml which didn't
generate feedback, so let's discuss the concrete proposal.

Patch 1 and 2 are general cleanups, that seems useful even without this
proposal being implemented.

A corresponding patch has been submitted for Linux [1].
This is also where the request was voiced to drop move away from a
pvpanic uapi header in Linux.

[0] https://lore.kernel.org/all/984794aa-4af0-4c68-a74e-7420ec3151a5@t-8ch.de/
[1] https://lore.kernel.org/lkml/20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net/

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
Changes in v4:
- Rebase on 8.2 master
- Resend after tree reopened and holidays
- Link to v3: https://lore.kernel.org/r/20231129-pvpanic-shutdown-v3-0-c9a2892fc523@t-8ch.de

Changes in v3:
- Drop from Linux imported pvpanic header as discussed with Cornelia and
  requested by Greg
- Link to v2: https://lore.kernel.org/r/20231128-pvpanic-shutdown-v2-0-830393b45cb6@t-8ch.de

Changes in v2:
- Remove RFC status
- Add Ack from Thomas to 2nd patch
- Fix typo in title of 2nd patch
- Link to v1: https://lore.kernel.org/r/20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de

---
Thomas Weißschuh (4):
      linux-headers: drop pvpanic.h
      hw/misc/pvpanic: centralize definition of supported events
      tests/qtest/pvpanic: use centralized definition of supported events
      hw/misc/pvpanic: add support for normal shutdowns

 docs/specs/pvpanic.rst                   | 2 ++
 hw/misc/pvpanic-isa.c                    | 3 +--
 hw/misc/pvpanic-pci.c                    | 3 +--
 hw/misc/pvpanic.c                        | 8 ++++++--
 include/hw/misc/pvpanic.h                | 5 +++++
 include/standard-headers/linux/pvpanic.h | 9 ---------
 scripts/update-linux-headers.sh          | 3 +--
 tests/qtest/pvpanic-pci-test.c           | 5 +++--
 tests/qtest/pvpanic-test.c               | 5 +++--
 9 files changed, 22 insertions(+), 21 deletions(-)
---
base-commit: 0c1eccd368af8805ec0fb11e6cf25d0684d37328
change-id: 20231104-pvpanic-shutdown-02e4b4cb4949

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


