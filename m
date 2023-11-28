Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCF57FC3DB
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 19:59:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r83Hq-0004eY-EC; Tue, 28 Nov 2023 13:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r83Ho-0004dd-9n
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:58:20 -0500
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r83Hj-0002AS-Vc
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1701197890; bh=TW83cn4j0HI6IjlUS7Q5GF8z3LtYQaFNK0jxrF6xONg=;
 h=From:Subject:Date:To:Cc:From;
 b=Q/8/ZVIFKuNcgaJwWKEglskSsp3xvlC7pBpeZGkpiC1e50NZHljkKbS2utxLEWGRl
 RNzVcGOZMIAD4jeQ5eO7FgZ4Xy9WN2tc3HlA3t+qEgCabP9WkkY5iFZRqv/htg1THz
 Aj+uEmTsBKzYApt8FK6Ph3xg0YQDOlRbR6Colaak=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH v2 0/3] hw/misc/pvpanic: add support for normal shutdowns
Date: Tue, 28 Nov 2023 19:58:03 +0100
Message-Id: <20231128-pvpanic-shutdown-v2-0-830393b45cb6@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADs4ZmUC/32NTQ6CMBBGr0Jm7Zj+EcEV9zAsaBntbAppsWpI7
 27lAC7fS7737ZAoMiW4NjtEypx4CRXUqQHnp/Ag5LkyKKG0lMLgmtcpsMPkn9u8vAIKRcYaZ01
 veqizNdKd30fyNlb2nLYlfo6HLH/2TyxLFLWoWy3bS9dLO2zYOX+eCcZSyhcS8OAerwAAAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701197889; l=1963;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=TW83cn4j0HI6IjlUS7Q5GF8z3LtYQaFNK0jxrF6xONg=;
 b=vIAy+8Hl7sBYGX87H4yjmcK0dzXmyKPm7apJFfmjlcKPe7M8i42jBjtQGZOArpJvLfMdqvTv7
 dRSzkqw6lT1BFZo2fjNfKbt9kiaImgEJNIBJAS+EoBP1Q7rhU0sNccx
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
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
Changes in v2:
- Remove RFC status
- Add Ack from Thomas to 2nd patch
- Fix typo in title of 2nd patch
- Link to v1: https://lore.kernel.org/r/20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de

---
Thomas Weißschuh (3):
      hw/misc/pvpanic: centralize definition of supported events
      tests/qtest/pvpanic: use centralized definition of supported events
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
base-commit: 9155a938cf8fdcb29b760acb8a742bb48be9000f
change-id: 20231104-pvpanic-shutdown-02e4b4cb4949

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


