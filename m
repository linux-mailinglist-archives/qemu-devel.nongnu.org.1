Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 265127D9F20
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 19:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwR3e-0006MA-Fy; Fri, 27 Oct 2023 13:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mPk7ZQwKCqsYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1qwR3c-0006Le-9p
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 13:55:40 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mPk7ZQwKCqsYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1qwR3a-0007hr-Na
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 13:55:40 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5afa071d100so13889197b3.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698429336; x=1699034136; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=f/zHwvZvQKGDpS3Vwsu8URM4wG++XiSdS9L3QRhTu+I=;
 b=kPl3C3pelTb7IJhp4nkgOFNJxI+IkzI+81UzT0/q5EBGfEfCmZdPHLlM16PIgNO8Gb
 90bFxB/L5jIP3H1Tspauy5pYby0MKPe8wWsF1OkAcRkGenE+YoGuzy2xPIfGRaMNbkcD
 ITtVxApVYaykElNT5Yn7lACJkmycrBZeuRHWMSk9RZbZH5EyLgeyQoDTaNApQXdN3TTt
 xAjrLk7AOzs3VYTb5iKFk/e5g4NiOGr7TvnAOpikwZ3/T3T4q9kVtk8Jkq3+XVtJXm7k
 gQ95HI0k9g21DYtvNyXMpvQfeE+C5qBuJpm8OSQxAzVxDwRY8YgH6bDOtP5kuRmEW1Hp
 mNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698429336; x=1699034136;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f/zHwvZvQKGDpS3Vwsu8URM4wG++XiSdS9L3QRhTu+I=;
 b=G6n76KIctGgjw7GS/lAFt7Q2kQbmIgeNfjyphpn/e4ZD+5COL9aIIDpJSJIb1LU8wp
 Q/B1uDbe4eRhb1WVPV7zf8pUGnaQlMH5xc3hnJdv/am4sjoslL2UrAEyJmDQplFPzfO4
 G1EWqRYrl5gDyF38ms/xyIJx62MX0S5M1XQbNHsQaGcufB+I610wm/w5ZCrfSlBWbcom
 KwgnEkR0HK1SQqox+RJypx5RtuFs47qFGchiY7r8vYedsXRacwj8N+3EAGP4oEw4EBzU
 oOfasjhsO0LWiXkeadBzH3Hq5QkjjV3JOcD9f1pte7xBEboHNhQg2Dob3CgpD19vENAk
 EInA==
X-Gm-Message-State: AOJu0YzxQICaPXyxAL7hgfgtEqsNjwsm8Te/Z8tr7FYGYoIkN+nB3fwO
 YsBABKal5z96+ZkVM/v8Lwp0ZxuEPRNVCJbeUQ8=
X-Google-Smtp-Source: AGHT+IGsQxR6e7tjtRRh8//ytaOdgeMGbqzudtdXUbSl57F0jQoItOF6vT+vx7iYWpaq7TLIvBGwS2Dcd1s6uJ3N7vY=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:a151:0:b0:5a7:b9b0:d23f with SMTP
 id y78-20020a81a151000000b005a7b9b0d23fmr71868ywg.6.1698429336502; Fri, 27
 Oct 2023 10:55:36 -0700 (PDT)
Date: Fri, 27 Oct 2023 17:55:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027175532.3601297-1-nabihestefan@google.com>
Subject: [PATCH v5 00/11] Implementation of NPI Mailbox and GMAC Networking
 Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3mPk7ZQwKCqsYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com;
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

Nabih Estefan Diaz (6):
  tests/qtest: Creating qtest for GMAC Module
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
 hw/net/trace-events                 |  19 +
 include/hw/arm/npcm7xx.h            |   4 +
 include/hw/misc/npcm7xx_pci_mbox.h  |  81 +++
 include/hw/net/npcm_gmac.h          | 340 ++++++++++
 tests/qtest/meson.build             |   8 +-
 tests/qtest/npcm7xx_pci_mbox-test.c | 238 +++++++
 tests/qtest/npcm_gmac-test.c        | 341 ++++++++++
 14 files changed, 2351 insertions(+), 9 deletions(-)
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
 create mode 100644 tests/qtest/npcm_gmac-test.c

-- 
2.42.0.820.g83a721a137-goog


