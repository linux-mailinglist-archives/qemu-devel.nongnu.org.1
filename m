Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1BB827A94
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 23:29:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMy69-0006kC-UX; Mon, 08 Jan 2024 17:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <353acZQwKCnolYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com>)
 id 1rMy68-0006je-2g
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:27:56 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <353acZQwKCnolYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com>)
 id 1rMy66-00042f-GV
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:27:55 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5e744f7ca3bso32273117b3.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 14:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704752872; x=1705357672; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=v8fECYvLPprgyM3CH5M7DgBKaqSDlj4SV5W/OLDRF4g=;
 b=xnNmmhVxxpJX8u/ezuJ5UrszOQwfEstc09c8Ta+yDJGb1gy8deP8Noru+MjqUVZ4ZG
 Ygf6jae4p6G6wIrjpyJUIvzVC+o4e//I4yZvGh40vkwgNiFTjSJ+/B5O4T7mWPTkrWbL
 gbq752Ei+7k6f9+yfdzcHKrr4hBX1TtGW87pepKeZaTDC0bb5TCQcIF2JNEKAGdNBZCE
 gaCGTtcvZFQ45PegxZW36dbPSMJTJNz4e9gXe4EQV7KWu/pjmSGdFIrKgJV3NUlahd1A
 rwkh+o6GCQus8/PEFddfcOPaL9skmsv1/YSvGXkkBCFMLXR1DM6Rrqi98s9SD1oE5ev/
 UhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704752872; x=1705357672;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v8fECYvLPprgyM3CH5M7DgBKaqSDlj4SV5W/OLDRF4g=;
 b=rH7XRmKD40jDWrK3kPaFtiSLPXt77o0fJQOw8wIwluLohrR7Qfvqo1/9mADTQWqfrK
 BIHYSGrkcXtZ2vztyutxsCGKD86+trP7p8Ra5ayNVmUoDvDxsZfsibury7AyfYBXkqQl
 29FI8VJ1Ow7yOCvdN+LsEsR0PKNnD/lje4aBn7Y53XHeJQ78Inn766PWSHFY2QmvgAP7
 PaszxfeMmqldkSb2BdB7UfYEBODgMVDvP/N2WA1mZDF3a8j6NqMgVB+lCVOLKtCvxmFn
 cA1gY1W21sSVPA9QX3/+4wASEi9S6n6YChM1/kHM9LiOHyXFyqkPKItZnx14BUhai+Zs
 vojA==
X-Gm-Message-State: AOJu0Yy9nGaSVIgyAJrCssndoD+zwAISDnVEGc0faJailVGvLkcRzBZk
 rDqzpdPIcC9LF5whB2yPaL/uQOngUDtOrMZJMAZOMDPE4Q==
X-Google-Smtp-Source: AGHT+IGzmmQqUbqo9g9pDm0nF9/Z0uNMGeP9KRShv1zKiNa6fzIYUmi81ZhQMg43TmE3H8zC2srkv0VvBLgw0WH6fVM=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:690c:3507:b0:5e7:62e:75db with
 SMTP id fq7-20020a05690c350700b005e7062e75dbmr1921296ywb.1.1704752871933;
 Mon, 08 Jan 2024 14:27:51 -0800 (PST)
Date: Mon,  8 Jan 2024 22:27:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240108222747.2453106-1-nabihestefan@google.com>
Subject: [PATCH v10 00/10] Implementation of NPI Mailbox and GMAC Networking
 Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=353acZQwKCnolYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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

Nabih Estefan Diaz (5):
  tests/qtest: Creating qtest for GMAC Module
  include/hw/net: GMAC IRQ Implementation
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
 hw/net/trace-events                 |  19 +
 include/hw/arm/npcm7xx.h            |   4 +
 include/hw/misc/npcm7xx_pci_mbox.h  |  81 +++
 include/hw/net/npcm_gmac.h          | 340 ++++++++++
 tests/qtest/meson.build             |   2 +
 tests/qtest/npcm7xx_pci_mbox-test.c | 238 +++++++
 tests/qtest/npcm_gmac-test.c        | 341 ++++++++++
 14 files changed, 2347 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
 create mode 100644 tests/qtest/npcm_gmac-test.c

-- 
2.43.0.472.g3155946c3a-goog


