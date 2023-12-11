Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 228DE80D4A7
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:53:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkS7-0003AA-9r; Mon, 11 Dec 2023 12:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3UUx3ZQwKCvgsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com>)
 id 1rCkS5-00039n-BJ
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:52:21 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3UUx3ZQwKCvgsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com>)
 id 1rCkS3-0000WQ-3M
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:52:21 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-db99bac23cdso5351483276.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702317137; x=1702921937; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RwXl4JkBorQRvhMj6a1QvJpgqTyHTTCbStUxi85OUwc=;
 b=tKwcsZ5saqItrya584S3no/E/KS3aDIfRQL7ArPmr51Q7IaXTFCweS5reGZACnDGJD
 tsVY6o6RG8Db7CktMj2D6/00u3UJOUvjWjJcjYBmmO1+zMrp4eDt9NIO7+J1bvexiNC0
 5eMSBrQ9NjIinQnVfGwq6hPMtfIcPeYZ7i+Jksrvabc136Xhq3wI8y7TNEgiwxqcWv31
 ZJAeCO+RXHkhjIzpcD7dVbSVqM/11mGlcZ7+wYjTeNoS8oB6xmyp/9kN+A/ML607ihl3
 MA7z3EclAHTT+TOFaulcsPHJRD8BalsGsF/0TTV3sutG9a+9guQsYn1kP2GoxMpQFT25
 xjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317137; x=1702921937;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RwXl4JkBorQRvhMj6a1QvJpgqTyHTTCbStUxi85OUwc=;
 b=Xe5YB/Jhjc1HrsR8k5oPKvWBVGNk1BTvngzzMIjnNsmTYZ9A62QMjFOvzEjRTriaJl
 BBX/Eam9Vc+UjXXI4HOVk/jcFWrVfTQm4hXfpz5ba433tj5r79KEMbfe27ZWmwVW4eSD
 KkgkKvFAvOZMfaIvNIpUvVjSAqePuTKy9Ugtew6aCqdVKLxA0DQKWez4DW0PG7eE3479
 DTUJskWlo08ZDLQcz/EtwlJjp3QKLmITB5d6K/PEOHyYxhGmcEPaJ8Wu0NlsLI5CCHqZ
 6ZxqLL/3o5g92oM78miB9+N8h9FJMY60uZjmFurusG3Gg5lHKL5K2h2aALLoLu9Pw7Um
 +G1g==
X-Gm-Message-State: AOJu0YxuRT8mY/SpufMkZVREJr31kYWO62HtoRFdbJrOnKl3o4BI6kMs
 Cq4KFPa0oX8bCc3R9vn0RN7DLii9bUB03gC5ywc=
X-Google-Smtp-Source: AGHT+IEfTp+C6k9fE2Jx5iRGovfjNOqizo23Igm5bcZTjymKWrl4E9jaA1sgpgSN7HjV+gbIdM6gMkZp8bG6wIBCZ0g=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:2691:0:b0:dbc:6826:1207 with SMTP
 id m139-20020a252691000000b00dbc68261207mr32687ybm.5.1702317137766; Mon, 11
 Dec 2023 09:52:17 -0800 (PST)
Date: Mon, 11 Dec 2023 17:52:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211175215.3216667-1-nabihestefan@google.com>
Subject: [PATCH v7 00/11] Implementation of NPI Mailbox and GMAC Networking
 Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3UUx3ZQwKCvgsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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
 tests/qtest/meson.build             |   3 +
 tests/qtest/npcm7xx_pci_mbox-test.c | 238 +++++++
 tests/qtest/npcm_gmac-test.c        | 341 ++++++++++
 14 files changed, 2351 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
 create mode 100644 tests/qtest/npcm_gmac-test.c

-- 
2.43.0.472.g3155946c3a-goog


