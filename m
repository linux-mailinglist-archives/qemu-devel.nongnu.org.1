Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC27C832FD1
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 21:34:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQvYB-0001Dq-4b; Fri, 19 Jan 2024 15:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hNyqZQwKCh0G34BA7LM783G9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--nabihestefan.bounces.google.com>)
 id 1rQvY8-0001D0-Qj
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:33:12 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hNyqZQwKCh0G34BA7LM783G9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--nabihestefan.bounces.google.com>)
 id 1rQvY6-0003lO-MZ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:33:12 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dbf216080f5so2055214276.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 12:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705696388; x=1706301188; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XT0ON0Vc5XZiw7+efUTcqN8o3WszI5rq+6Gmma4AQ2g=;
 b=bJwudI6z+X9RX6L+VZWdghBZZoolICgawPrBvd0tq9DjZwlLPKKCgbrseT5qyy5vMc
 EeGHJO9ZG7RONzzTZur0/Lo70mxzLu+L/Xi+QuIs2Sc+j3s1WnrvpbknWrRFm18ulDJA
 4I4/OgDqIaSrIP04vmRm/CjvQCqrkD3Z/U6nbzOAwIdKCCaJb6JEr+SJAmf2CBgn9ZP7
 qoYYOnrBz4PGlhohAP0d9avJF1IoOqKrw1Pcsa8gF3qNpgoRoAsQby9Hym3UVIdrRkd9
 v6y1a8KnLGtbZmK/E8rXsSiDBEf/mB1oojGKpSifn4rY21QDA19JBxt4QJ83j8RgU0q2
 OAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705696388; x=1706301188;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XT0ON0Vc5XZiw7+efUTcqN8o3WszI5rq+6Gmma4AQ2g=;
 b=ZcTj3Lm+/cTcX5LFKqHaJ26+Yech9NJlqwSt0ZFwxbOONMOFPFny3VLdJRe2gu2GDU
 RWLftjLQPMVdxN60sJTRoTcTggo0wY5JctUkhweA2DmLcjdcgvjlLhnqifohcv7RtujO
 GfOuhAScNZBEoQ588xFQpFUNvdnkmoywYwkBRHzgeIahz5rgV89V+lRInR79RtGiPG12
 frhWFV5Bc3XfNMIVvKd7yS2qdmja0ICDg1LkXXYviPzb5qTMdc0v1GYS8//htugb1s4o
 zccquYG9j6THnnlsqEMPAVuMyLtQlfe7PgOD57Bt1cIxzwZ9M+uFLCthHZ9CNbV3ltHi
 oYAQ==
X-Gm-Message-State: AOJu0YxIeSCmD+eXXbvR7CPVQsG2vwop+hpb774+WG0eAIXvAOIg3/5M
 z0N5MorIjQQTD0AEjzvgEt/rEqbAEnq07NuiHySV1Npvj1APAvQLzpGdXM2fYuhLzXg0w/imqet
 ukLw6/QS9pseQ6h4X8tL3Ss/U0A==
X-Google-Smtp-Source: AGHT+IGWJ0/gX+XtiM/YP+oxI/RPRKwGFcKNZYTp1sMsWESYMvub04MxHBQ+cI6YGPvunjWE1Kj/qCMsbiO5+TciZ2I=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:ac24:0:b0:dc2:466a:23c4 with SMTP
 id w36-20020a25ac24000000b00dc2466a23c4mr218900ybi.4.1705696388379; Fri, 19
 Jan 2024 12:33:08 -0800 (PST)
Date: Fri, 19 Jan 2024 20:32:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240119203303.2230984-1-nabihestefan@google.com>
Subject: [PATCH v13 0/9] Implementation of NPI Mailbox and GMAC Networking
 Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3hNyqZQwKCh0G34BA7LM783G9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Nabih Estefan Diaz <nabihestefan@google.com>

[Changes since v12]
Fix errors found when testing in big-endian host.

[Changes since v11]
Branch couldn't be merged with master because of issues in patchset 6.
Fixed.

[Changes since v10]
Fixed macOS build issue. Changed imports to not be linux-specific.

[Changes since v9]
More cleanup and fixes based on suggestions from Peter Maydell
(peter.maydell@linaro.org) suggestions.

[Changes since v8]
Suggestions and Fixes from Peter Maydell (peter.maydell@linaro.org),
also cleaned up changes so nothing is deleted in a later patch that was
added in an earlier patch. Patch count decresed by 1 because this cleanup
led to one of the patches being irrelevant.

[Changes since v7]
Fixed patch 4 declaration of new NIC based on comments by Peter Maydell
(peter.maydell@linaro.org)

[Changes since v6]
Remove the Change-Ids from the commit messages.

[Changes since v5]
Undid remove of some qtests that seem to have been caused by a merge
conflict.

[Changes since v4]
Added Signed-off-by tag and fixed patch 4 commit message as suggested by
Peter Maydell (peter.maydell@linaro.org)

[Changes since v3]
Fixed comments from Hao Wu (wuhaotsh@google.com)

[Changes since v2]
Fixed bugs related to the RC functionality of the GMAC. Added and
squashed patches related to that.

[Changes since v1]
Fixed some errors in formatting.
Fixed a merge error that I didn't see in v1.
Removed Nuvoton 8xx references since that is a separate patch set.

[Original Cover]
Creates NPI Mailbox Module with data verification for read and write (internal and external),
wiring to the Nuvoton SoC, and QTests.

Also creates the GMAC Networking Module. Implements read and write functionalities with cooresponding descriptors
and registers. Also includes QTests for the different functionalities.

Hao Wu (5):
  hw/misc: Add Nuvoton's PCI Mailbox Module
  hw/arm: Add PCI mailbox module to Nuvoton SoC
  hw/misc: Add qtest for NPCM7xx PCI Mailbox
  hw/net: Add NPCMXXX GMAC device
  hw/arm: Add GMAC devices to NPCM7XX SoC

Nabih Estefan Diaz (4):
  tests/qtest: Creating qtest for GMAC Module
  hw/net: GMAC Rx Implementation
  hw/net: GMAC Tx Implementation
  tests/qtest: Adding PCS Module test to GMAC Qtest

 docs/system/arm/nuvoton.rst         |   2 +
 hw/arm/npcm7xx.c                    |  53 +-
 hw/misc/meson.build                 |   1 +
 hw/misc/npcm7xx_pci_mbox.c          | 330 ++++++++++
 hw/misc/trace-events                |   5 +
 hw/net/meson.build                  |   2 +-
 hw/net/npcm_gmac.c                  | 939 ++++++++++++++++++++++++++++
 hw/net/trace-events                 |  19 +
 include/hw/arm/npcm7xx.h            |   4 +
 include/hw/misc/npcm7xx_pci_mbox.h  |  81 +++
 include/hw/net/npcm_gmac.h          | 340 ++++++++++
 tests/qtest/meson.build             |   2 +
 tests/qtest/npcm7xx_pci_mbox-test.c | 242 +++++++
 tests/qtest/npcm_gmac-test.c        | 341 ++++++++++
 14 files changed, 2357 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
 create mode 100644 tests/qtest/npcm_gmac-test.c

-- 
2.43.0.429.g432eaa2c6b-goog


