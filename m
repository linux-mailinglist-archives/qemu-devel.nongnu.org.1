Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C597E0F10
	for <lists+qemu-devel@lfdr.de>; Sat,  4 Nov 2023 12:27:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzEml-0003xa-Gp; Sat, 04 Nov 2023 07:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1qzEmc-0003wL-0t
 for qemu-devel@nongnu.org; Sat, 04 Nov 2023 07:25:42 -0400
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1qzEmY-0004Mp-Um
 for qemu-devel@nongnu.org; Sat, 04 Nov 2023 07:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1699097130; bh=Feyv68vDnKce0cp8shSFLIDQwIOdHSVSSxODRVSXuTw=;
 h=From:Subject:Date:To:Cc:From;
 b=XHEWKcFNXIr68FRhQNGYHED7vmVa1wsFiwSnu8OYmx7V+g5egombXp8vIoWCtQ4ha
 Or5MlWjkx6ydambDSEGDBL8A9tvj7nL2YajP9zS8icidYDyRuGSK0THXLq1ZENAWx+
 y4b7jhOCfovF8cF2j+6u4Iw/7yqsTD0ifLwoEt8M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFC 0/3] hw/misc/pvpanic: add support for normal shutdowns
Date: Sat, 04 Nov 2023 12:25:21 +0100
Message-Id: <20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACEqRmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwMT3YKygsS8zGTd4ozSkpT88jxdA6NUkyST5CQTSxNLJaC2gqLUtMw
 KsJHRSkFuzkqxtbUAxMCxm2cAAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699097130; l=1754;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=Feyv68vDnKce0cp8shSFLIDQwIOdHSVSSxODRVSXuTw=;
 b=6R58eTDU+8UB8DpfGo3hOrGe5yCZdjDUgSsifzjHkMDDETLRMzlutfuGAz+8uKezxKk2nT23C
 Kx+H2MUmuoRBIBNmZyGP/LcLDj33StrhIguNfoGDPe5pTI+KiX4caxT
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

I'll send the corresponding Linux patch to LKML.

[0] https://lore.kernel.org/all/984794aa-4af0-4c68-a74e-7420ec3151a5@t-8ch.de/

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
Thomas Weißschuh (3):
      hw/misc/pvpanic: centralize definition of supported events
      tests/qtest/pvanic: use centralized definition of supported events
      hw/misc/pvpanic: add support for normal shutdowns

 docs/specs/pvpanic.rst                   | 2 ++
 hw/misc/pvpanic-isa.c                    | 3 +--
 hw/misc/pvpanic-pci.c                    | 3 +--
 hw/misc/pvpanic.c                        | 8 ++++++--
 include/hw/misc/pvpanic.h                | 2 ++
 include/standard-headers/linux/pvpanic.h | 1 +
 tests/qtest/pvpanic-pci-test.c           | 5 +++--
 tests/qtest/pvpanic-test.c               | 5 +++--
 8 files changed, 19 insertions(+), 10 deletions(-)
---
base-commit: d762bf97931b58839316b68a570eecc6143c9e3e
change-id: 20231104-pvpanic-shutdown-02e4b4cb4949

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


