Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F5780D3D0
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:31:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCk6h-0000Yg-B0; Mon, 11 Dec 2023 12:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3G0d3ZQwKCrglYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com>)
 id 1rCk6Y-0000Y6-SP
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:30:06 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3G0d3ZQwKCrglYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com>)
 id 1rCk6X-0004eq-1W
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:30:06 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d9a541b720aso5152864276.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702315803; x=1702920603; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5JLWmGN1YtJFcZD4A27y487SNCjmUIhzf9njtpghJTk=;
 b=hv6FjIV7rDPPJBiAFNe5VVD28WSgYmcUTyceSROIQcH4M4Z1gfLrHjRE1mAxvcrjVY
 U1s5bcHAkaRmEtiK4dzFMEj/nBjsZBdleX9WzU41i51g8fT1gR2xCiW/Fbu/IObedeFR
 rDroXuyh2gOjYy55XNN3av3/WALrupjnAAlJPDZMGTiyDAayfwBWYZFBA299Fh8wln/q
 Ubop8AymbuV/59T5s+7pVij4ys8UFDqeAQxuforHh/GYV4VZBdcwccUYeQJzE2CT66v5
 KT6HUu0jQROnJ7ctSf3Ne/Hmlnu8NFdNISy+lQOqlf5At1hUT8eAZ7w6/0WuSYfuwpR1
 sM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702315803; x=1702920603;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5JLWmGN1YtJFcZD4A27y487SNCjmUIhzf9njtpghJTk=;
 b=oW5/v6kL1bPafWFXyJHsnMDvXmcmkKgk09iIoyE/HFySmzd3eeWmrKtpptLSsx+QP0
 l9tz+aoJCn2XPk3ZiaoxKx43PCmQrfuxI7C1B4aoUhetuAN4jVlSP/51ixHzjGybQsgQ
 xdyweOxGd9ypLxhmZRovp7LhyIJNqaDM1BSlLvju5g3tPiOImKemt8NUgFt9Uv3IYyJz
 q0iZHNDxnm3qAtdH5jBoucpbMrKx2EPHvqKJDtXBw3Ump+0+xvgXDDBRUUeEIAkb3J0H
 o96n21pQWqeMgjx1Nh3hwV4YYYF2J5fb5wY7oR0PUoZ4cYy1xQWUBYar4pZ+84UEfgnT
 IX0w==
X-Gm-Message-State: AOJu0YxxmtConoqlLBOAw+H4VUfozkqUEfCZFqTvvj/pyxGCNycfZIOQ
 m8Ynizt5yq9kEVC+MO7K3w0ltfNDtsKiMLhwCPs=
X-Google-Smtp-Source: AGHT+IHmahHCPsrjoIye8AOz6NC7mlm7SmNK2h1FUFILmSI5X+bpYQ5sRsQsBzAHOiwgITif8xl5tmPXnofs41eKKQk=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:9:b0:db5:382f:3997 with SMTP
 id l9-20020a056902000900b00db5382f3997mr31219ybh.11.1702315803048; Mon, 11
 Dec 2023 09:30:03 -0800 (PST)
Date: Mon, 11 Dec 2023 17:29:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211172953.3164357-1-nabihestefan@google.com>
Subject: [PATCH v6 00/11] Implementation of NPI Mailbox and GMAC Networking
 Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3G0d3ZQwKCrglYZgfcqrcdYlemmejc.amkocks-bctcjlmlels.mpe@flex--nabihestefan.bounces.google.com;
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


