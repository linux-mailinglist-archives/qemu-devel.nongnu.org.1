Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 003EA8877D2
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Mar 2024 10:40:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnxqV-0001oi-QV; Sat, 23 Mar 2024 05:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rnxqS-0001nu-1B
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 05:39:20 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rnxqP-0006wJ-S8
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 05:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1711186751; bh=eTOuE4cC4RhNgWruqoYaiJD00GB4p3TYcljmZitJZD4=;
 h=From:Subject:Date:To:Cc:From;
 b=D1ivHLT6soAJx1c3laa8KFVVdH5HJ9vUOhpe+eFZaqYbFmnUtd18+yST6W9rXkOv2
 PdH0hFt1bFduasnXOiOaVivHYTcK0Fc2XbCS5iOY8Pe75Ct6JNygRqULbXaFTuFKW+
 SFiyH9KbZ8i2EjriDe2UOrp0unLnKcibOAp5etFg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH v7 0/7] hw/misc/pvpanic: add support for normal shutdowns
Date: Sat, 23 Mar 2024 10:39:05 +0100
Message-Id: <20240323-pvpanic-shutdown-v7-0-4ac1fd546d6f@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADmj/mUC/33QzWrEIBQF4FcZXNdy1Xv9mVXfo3ShxjRukpCk6
 QxD3r1moDQE6fJc+M5BH2xOU04zu14ebEprnvPQl2BeLix2vv9MPDclMwlSCQHIx3X0fY587r6
 WZvjuOciEAWNAh44VNk6pzbdn5ftHyV2el2G6PxdWsV//KVsFh9KoSAky1onwtnAbu9cmsb1rl
 QcvbcXL4q0C5VRAikGfvDp6V/Gq+Oi8tE62kaQ6efz1CAJMxeO+LwjAm4RgxcnTwVf3qfiWPGg
 I1kSDJ6//vITa+3XxThNZ8BHIHP9v27YfIXb7TO8BAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711186751; l=3734;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=eTOuE4cC4RhNgWruqoYaiJD00GB4p3TYcljmZitJZD4=;
 b=+26432pKI8nGiJgsD/CB6T3fUvRoRpsRS9qa3QEC66NZm2bKUFBx3MHphhkH02YQyjSlTcbHj
 cuay1bDAz3WAQaUsMSrJCjkEP1PiPE4bZgDoTET7Bt4cJL2Y96z5WJl
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Patch 1, 2 and 3 are general cleanups, which seem useful even without this
proposal being implemented.
They should also be ready to be picked up from the series on their own.

Patch 4 adds a qemu-internal definition PVPANIC_SHUTDOWN.
It should be removed as soon as the kernel exposes the define and the
the new kernel header has been reimported into qemu.

A corresponding patch has been submitted for Linux [0].
This is also where the request was voiced to drop move away from a
pvpanic uapi header in Linux.

[0] https://lore.kernel.org/lkml/20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net/

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
Changes in v7:
- Keep standard-header/pvpanic.h
- Predefine PVPANIC_SHUTDOWN in include/hw/misc/pvpanic.h
- Fix alignment in QAPI to comply with newly enforced layout
- Update Since: tag in QAPI to 9.0
- Drop note from pvpanic spec about missing implementation
- Link to v6: https://lore.kernel.org/r/20240208-pvpanic-shutdown-v6-0-965580ac057b@t-8ch.de

Changes in v6:
- Replace magic constant "4" in tests with PVPANIC_SHUTDOWN
- Link to v5: https://lore.kernel.org/r/20240129-pvpanic-shutdown-v5-0-f5a060b87c74@t-8ch.de

Changes in v5:
- Add patch from Alejandro to emit a QMP event.
- Update cover letter.
- Add tests.
- Link to v4: https://lore.kernel.org/r/20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de

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
Alejandro Jimenez (1):
      pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic shutdown signal

Thomas Weißschuh (6):
      hw/misc/pvpanic: centralize definition of supported events
      tests/qtest/pvpanic: use centralized definition of supported events
      hw/misc/pvpanic: add local definition for PVPANIC_SHUTDOWN
      hw/misc/pvpanic: add support for normal shutdowns
      tests/qtest/pvpanic: add tests for pvshutdown event
      Revert "docs/specs/pvpanic: mark shutdown event as not implemented"

 docs/specs/pvpanic.rst         |  2 +-
 hw/misc/pvpanic-isa.c          |  3 +--
 hw/misc/pvpanic-pci.c          |  3 +--
 hw/misc/pvpanic.c              |  8 ++++++--
 include/hw/misc/pvpanic.h      |  9 +++++++++
 include/sysemu/runstate.h      |  1 +
 qapi/run-state.json            | 14 ++++++++++++++
 system/runstate.c              |  6 ++++++
 tests/qtest/pvpanic-pci-test.c | 44 ++++++++++++++++++++++++++++++++++++++++--
 tests/qtest/pvpanic-test.c     | 34 ++++++++++++++++++++++++++++++--
 10 files changed, 113 insertions(+), 11 deletions(-)
---
base-commit: 853546f8128476eefb701d4a55b2781bb3a46faa
change-id: 20231104-pvpanic-shutdown-02e4b4cb4949

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


