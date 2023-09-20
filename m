Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 080CC7A8F2C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 00:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj5Wc-0002JM-VH; Wed, 20 Sep 2023 18:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rm8LZQwKCukYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1qj5Wb-0002J6-KA
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:18:25 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rm8LZQwKCukYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1qj5WZ-000856-VA
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:18:25 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-59bdb9fe821so4583517b3.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695248302; x=1695853102; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Tb9TQO2eF2zR9pRcI1XxqfWuHZFW2+XaCBnMFdypMR0=;
 b=SRFa7nfSOIolchFs/K3JhSPgV0IQSAJ2bb3xmjzvHA2ZpRO7rWmqRB7lcGR5C0yM3o
 pVuMMHlzLs/iz4disw0vEySfiZYGu0/pbZYkURdUFzWuwuTUSlIsbM8PiO/Q7qH4U4eG
 BmvG3IBAivr7MQaJIntmSoKy81WlraOZJJPuT3dZ5d2sqLOMULsInnqpny8/QuEMgXwh
 EgZeHue2jqhtDx+TOidfgCOTj6i+Vy10+JVY2B81EES8FPZ/fp043iWDRjQGa6GI3fkt
 ZKboOTIWjoqSd48gRivFMxLNytLlC0xP9FdggNn8rk3c5c86q0EATtT6u0FulfudQ5zy
 TNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695248302; x=1695853102;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tb9TQO2eF2zR9pRcI1XxqfWuHZFW2+XaCBnMFdypMR0=;
 b=vbnfdZnkVFLkzCdMRSdxjzWv5oytOWiAyiOhSJQVjcmDXl5JeCcNoxQbKGUsSsHvHV
 U++860dxKTgIYcHIx4/faMk1jvNIcimPHvTmv8KVVbdVj4X6+rBAVZaVdt0BzsC6TEti
 CnqXmfQYe7vtLpg5ksiEgRbVBEppmP4/R9cf3BV2zlxcSC/NsE7RXQtDvuD0VMFyLNMd
 liaduPKFikmjRfKRaNJ6mRMMLikE+Z9HQB6Xe2pTWPBUkA5KJdlU2J7DFQETeIrnEcW4
 xNxL/9Ok5NdmKAkOhDCzGR6sYPavxI2lJFCNARochM8CCm9tiqtX1rVggfkizMndV7Y+
 DA/w==
X-Gm-Message-State: AOJu0Yw5jmMUvI24W4E+179iOr8vG4snPvYivQGlevJ7qdcHi+fubAUK
 UQ06DUZpm99xIEoaXR1ztEu+jmL1gpARcsg7Ho0=
X-Google-Smtp-Source: AGHT+IHFGcNxItscscQ0whTB9I5vtI+ja6FOaNvuUE0jwtsXSrz8cqbetMNeaDVAh64g85DoCdAEQAcWtQ1aeM3PCYc=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:8d49:0:b0:59c:b9b:8946 with SMTP
 id w9-20020a818d49000000b0059c0b9b8946mr63731ywj.3.1695248302124; Wed, 20 Sep
 2023 15:18:22 -0700 (PDT)
Date: Wed, 20 Sep 2023 22:18:08 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920221819.1106029-1-nabihestefan@google.com>
Subject: [PATCH v2 00/11] Implementation of NPI Mailbox and GMAC Networking
 Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3rm8LZQwKCukYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Nabih Estefan Diaz (6):
  \tests/qtest: Creating qtest for GMAC Module
  include/hw/net: Implemented Classes and Masks for GMAC Descriptors
  hw/net: General GMAC Implementation
  hw/net: GMAC Rx Implementation
  hw/net: GMAC Tx Implementation
  tests/qtest: Adding PCS Module test to GMAC Qtest

 docs/system/arm/nuvoton.rst         |   2 +
 hw/arm/npcm7xx.c                    |  53 +-
 hw/misc/meson.build                 |   1 +
 hw/misc/npcm7xx_pci_mbox.c          | 324 ++++++++++
 hw/misc/trace-events                |   5 +
 hw/net/meson.build                  |   2 +-
 hw/net/npcm_gmac.c                  | 939 ++++++++++++++++++++++++++++
 hw/net/trace-events                 |  20 +
 include/hw/arm/npcm7xx.h            |   4 +
 include/hw/misc/npcm7xx_pci_mbox.h  |  81 +++
 include/hw/net/npcm_gmac.h          | 340 ++++++++++
 tests/qtest/meson.build             |  12 +-
 tests/qtest/npcm7xx_pci_mbox-test.c | 238 +++++++
 tests/qtest/npcm_gmac-test.c        | 341 ++++++++++
 14 files changed, 2353 insertions(+), 9 deletions(-)
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
 create mode 100644 tests/qtest/npcm_gmac-test.c

-- 
2.42.0.459.ge4e396fd5e-goog


