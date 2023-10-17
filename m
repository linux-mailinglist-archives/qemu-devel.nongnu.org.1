Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A30577CD037
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 01:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qst6T-0005tY-IG; Tue, 17 Oct 2023 19:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <32BIvZQwKCukYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1qst6S-0005tO-5I
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 19:03:56 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <32BIvZQwKCukYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1qst6Q-0002I2-J0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 19:03:55 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5a8b33d2a93so6201627b3.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697583833; x=1698188633; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZtnZX3qq6VUqd48mODDcHeavJ1fpcDwaSYbnpD75Hjw=;
 b=zU2ItVPUXwzPeNKYsf7PwemVnaYlIJLYm8u8JMnpFXRWabG1OnfHP4H1HGN/dAhKl+
 zTio+6B4joAuNJ7Q/A7NIbpwly5J85Ug+M+/o7cMu7qwCnI6egmmMzLZ+zLMETyrHmpC
 KAxORLFIirFCZ7+YcXAXzGyxaeBTqkt8/yCCph69EfxNTrQUhkqEale4sSIKKpmsPTjo
 RQuoUan586Y+z9ZVFCcvY1Y/Mf2Z96fFA9JwznbrvH1SZ9/1e4zGGIPzmkudut1hJllG
 vdw09ppcvS5+df9vHIFqO12Yk4a0c/IG9ySY8S5weqhp9v7hOQfC0arf8djp74u1YBkI
 HiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697583833; x=1698188633;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZtnZX3qq6VUqd48mODDcHeavJ1fpcDwaSYbnpD75Hjw=;
 b=psPCAIMg8rUwrbVypv/arMRij/ldlIwsapdpBpapespBGeY0U3gOqaiflw5DrXFZ1o
 RXZl9AmynBMk+TA8bBxY7lA2Tt7kXbjMwdc8w3ule+ysKQf6r6plPrcD4MRVRrMAaXrn
 hxN6CI96c+++VSTnJBoEAX1dGLjGrV4kpeGELz1QSHrq13Oqp8/tjdyjRXMT3xiOWzBm
 Ov9005/V0TuD5ODNM58pjrtFNO/G8NcSBcSkdq9nlzoQeLkZ5OsRgPz40Zx9Vj4eG0Bn
 P75udYAMw3zWGqQocG7RFochaGTBhVyD8KByb9+mp4zJQBAHpL503NNRAQqltlDi4CuQ
 fxng==
X-Gm-Message-State: AOJu0YyMWyxJs/Zu3vtfSM30z8fPTGL96Xg1B6+Wfh7jdRr6CCSKyyzg
 ihBN0gbhpM3mL4M81a422/KDgcQILQ7ZQxAd+Gg=
X-Google-Smtp-Source: AGHT+IGYUUW9kgyiXMl5tGArhBtw9UKjvjpdyEV1eZevOhOXkpyT2cyUgAt6Mw3m7GE+ALfnp9hVB3ZjEU8llDmhIhA=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:b16:b0:d9a:fd4d:d536 with
 SMTP id ch22-20020a0569020b1600b00d9afd4dd536mr83747ybb.3.1697583832692; Tue,
 17 Oct 2023 16:03:52 -0700 (PDT)
Date: Tue, 17 Oct 2023 23:03:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017230342.311227-1-nabihestefan@google.com>
Subject: [PATCH v3 00/11] Implementation of NPI Mailbox and GMAC Networking
 Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=32BIvZQwKCukYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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
 hw/net/npcm_gmac.c                  | 942 ++++++++++++++++++++++++++++
 hw/net/trace-events                 |  20 +
 include/hw/arm/npcm7xx.h            |   4 +
 include/hw/misc/npcm7xx_pci_mbox.h  |  81 +++
 include/hw/net/npcm_gmac.h          | 340 ++++++++++
 tests/qtest/meson.build             |  12 +-
 tests/qtest/npcm7xx_pci_mbox-test.c | 238 +++++++
 tests/qtest/npcm_gmac-test.c        | 341 ++++++++++
 14 files changed, 2356 insertions(+), 9 deletions(-)
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
 create mode 100644 tests/qtest/npcm_gmac-test.c

-- 
2.42.0.655.g421f12c284-goog


