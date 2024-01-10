Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7F482A503
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 00:44:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNiDf-0007Na-9s; Wed, 10 Jan 2024 18:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ciufZQwKCnkkXYfebpqbcXkdlldib.Zljnbjr-absbiklkdkr.lod@flex--nabihestefan.bounces.google.com>)
 id 1rNiDd-0007N5-E3
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 18:42:45 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ciufZQwKCnkkXYfebpqbcXkdlldib.Zljnbjr-absbiklkdkr.lod@flex--nabihestefan.bounces.google.com>)
 id 1rNiDb-0006XR-KR
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 18:42:45 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5e9a02c6d49so88265757b3.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704930162; x=1705534962; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tAfDGsZ8AUgD+M/9Tt0Dtjah8AATenuIrS5Z3ZfvJOQ=;
 b=4lP8XpJ7B4nPqMag5N7JaF3Yevkklp+qLedITzAXhnc0cGQW4fOCF4g1Im/7qHPRrv
 Hlp53pcaOAE01XKoZ9yDji/wxxxJqE45sk5mav3omNY1nJ8x8OMcEF6qSCQvAxfhzvkn
 lGDohK6bYWcPmLcZx35AA5y9pRsdMfaDPe766HatQi0HDu34wfQs06JYSma12yLhiEeY
 /6jrKr18iLEWgHX4lt6fe3lVjcwOGkn3VENRqV1GErb74BeACKtEnnQgCweXTspcWNeB
 6wOVWXNHUxGEKF988PkEABqJsWTRcKvAm3qcSkJYR9ypLrmiIs0H4lVzXe55094610z2
 wc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704930162; x=1705534962;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tAfDGsZ8AUgD+M/9Tt0Dtjah8AATenuIrS5Z3ZfvJOQ=;
 b=aNOkVW7fjEae5J+it8odKlN7xZ/v4yLLUNld2rWh/1bagZ/IZ2I7XEZ3oF/Ds+7yjO
 fCaYeqv7aXZ+6RuaKnh7Zdo9QUoVy4Jk+NGQL3FsjA4MXyIJEj3We91U6lr4samNnTea
 CCEYwxf+7NdnLIiIW9jZZwMS8R+RWNJez7VhuZJQcu4oXH8uX2xkzF5usOmdtpbUkZ5H
 0QycGAvHdinZCGxQFPhIkv/gLQ8w+QRu3Bcvw5Al8Bqp+dc1j3BY5kFtb196xgCTekAB
 FSBPwBLWUgB6mkrjVQMExwTL2nZG3D8VE2XX/nTbXOvPw9VvhGJ2/IKu5G7REw4cTEOS
 U/6A==
X-Gm-Message-State: AOJu0YxfUxzA/dfFovdsoRnb8CrLymaHZ+LRUtfK75j+1x5sTfcPEin7
 +THU02+cieBK16JROhBt/evjzpcx9yXIs1UjFmX2scPmFQ==
X-Google-Smtp-Source: AGHT+IHhNEaMAhPjGWG/6mkLEgo7GTO00ScnlMtgsS868kZsirETaODibQ81lpjQrorPl2FeqSsSu7UPwKSyvoKkyxU=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a0d:d301:0:b0:5f4:f576:6441 with SMTP
 id v1-20020a0dd301000000b005f4f5766441mr270347ywd.0.1704930162174; Wed, 10
 Jan 2024 15:42:42 -0800 (PST)
Date: Wed, 10 Jan 2024 23:42:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110234232.4116804-1-nabihestefan@google.com>
Subject: [PATCH v12 00/10] Implementation of NPI Mailbox and GMAC Networking
 Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3ciufZQwKCnkkXYfebpqbcXkdlldib.Zljnbjr-absbiklkdkr.lod@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

[Changes since v11]
Was running into error syncing into master. It seemed to be related to a
hash problem introduced in patchset 10 (unrelated to the macOS build
issue). carried the patches from v9 (before the syncing problem) and
added the fixes from patchsets 10 and 11 to remove the hash error.

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

Nabih Estefan Diaz (5):
  tests/qtest: Creating qtest for GMAC Module
  include/hw/net: General GMAC Implementation
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
2.43.0.275.g3460e3d667-goog


