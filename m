Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7876836DC0
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:38:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyEc-00006S-QK; Mon, 22 Jan 2024 12:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3x6euZQwKCgYtghonkyzklgtmuumrk.iuswks0-jk1krtutmt0.uxm@flex--nabihestefan.bounces.google.com>)
 id 1rRyEW-0008Vf-L4
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:37:16 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3x6euZQwKCgYtghonkyzklgtmuumrk.iuswks0-jk1krtutmt0.uxm@flex--nabihestefan.bounces.google.com>)
 id 1rRyET-0003wn-1c
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:37:15 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5e6fe91c706so55388847b3.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705945031; x=1706549831; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZzqL8rbFgUPnpBxBgJ03nVh6SDRFRBdTMzc/DkWk28Q=;
 b=OSBkO4gICD882NnKkKlWNaGlf9XaSkGRA12iIipGptIDi+C9EWdA42AH+N8THaQZuy
 WApCzFRoOP1chkagPktCyPunPEf5Q0t2yiZxTjXfKY/n982HW+Uf6POccMLHHSb4PFMH
 b7nzl1XI8VYrzMU1EATUyIh7klmmUhv4a94KAGg7mEhDUeFqlwSLyVtzW97mO0omheJL
 sQMVTHNj3LZiJoDxqrpmELprFowU0LccLvx/aSFhRgS56tKWIPa1YuYhgVEQVPYW3Ge7
 6c0Tit+chJZquemlmT55SOyqTv1KoqhCMCFDruX4z6Nh99I6WP+g1CriFpkpykrjLBop
 JQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705945031; x=1706549831;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZzqL8rbFgUPnpBxBgJ03nVh6SDRFRBdTMzc/DkWk28Q=;
 b=LKpW5pDKmPJcyGtNeEsxk+V7NbbafPHuyiSC3p0UZGjWB00uLcZevdOEdlwgGlex+7
 xno9BLVHSp5pztJnMSMb/jvdNdMZu/05adyqRVUZK823mj5wFbQ6wqeiHfD6voPkTbc3
 sNjU4U7i3GPKg3AKAPXk9PfFJKnYVSLO8srBwgdgQMYJt1fmzZQAJ+YAXWNWVeRxco8K
 2ybHpcg/Qai3iFT5NiFyWS2gRRc6OcZPojIxkdfBlPZ9LgMOl2luaySx3So7+/iDm/C2
 mRSL64bQHL0gK3IjcrlQk+jwQLVEOmQgHoV/ixnyy5hOkeCYnDVZp17PMkEbxvvTiy2p
 GLZg==
X-Gm-Message-State: AOJu0Ywr82mo61/A3u/PDJjlYVVeSF7KcyV6yAXML+6ewvmbpky6Git/
 SJb12FIgNOTM2sMG1XP3jOde/jAMDHO2i/IxXLJ+xfyBSHRnSiDVCbCYfG2WsZS1W4IKlwtQHI8
 P/cFCMpUEdc5IDfsHRRVSvJ3NIQ==
X-Google-Smtp-Source: AGHT+IE3T39Q8K99F+p3b1zG0/6e2M3nwH7TvvCHDhJdx8vvotBP6AKMt9//BG2aswXb8bN0OwFagyRdpRPg7YoWUSs=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:9ad5:0:b0:5fb:7e5b:b87f with SMTP
 id r204-20020a819ad5000000b005fb7e5bb87fmr2259354ywg.1.1705945031142; Mon, 22
 Jan 2024 09:37:11 -0800 (PST)
Date: Mon, 22 Jan 2024 17:36:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122173706.4019545-1-nabihestefan@google.com>
Subject: [PATCH v14 0/9] Implementation of NPI Mailbox and GMAC Networking
 Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3x6euZQwKCgYtghonkyzklgtmuumrk.iuswks0-jk1krtutmt0.uxm@flex--nabihestefan.bounces.google.com;
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

[Changes since v13]
Added a couple clarifying comments and documentation about chardev
device expected protocol for ease of review.

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
 hw/misc/npcm7xx_pci_mbox.c          | 333 ++++++++++
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
 14 files changed, 2360 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
 create mode 100644 tests/qtest/npcm_gmac-test.c

-- 
2.43.0.429.g432eaa2c6b-goog


