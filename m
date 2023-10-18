Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8197E7CE60D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 20:15:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtB1W-0006Qi-6b; Wed, 18 Oct 2023 14:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36x8wZQwKChwF23A96KL672F8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--nabihestefan.bounces.google.com>)
 id 1qtB1T-0006Pv-Li
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:11:59 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36x8wZQwKChwF23A96KL672F8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--nabihestefan.bounces.google.com>)
 id 1qtB1R-00087t-Ta
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:11:59 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-d9cad450d5fso4297276.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697652716; x=1698257516; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ryudDDILGHBqSPSusnyBRafd1nlh0D1vtdTegRn4Qsw=;
 b=0A1Yf8L3rkyhh9cLmjjPAYfu36hFkW6fO9T/QMwIjQYFgVNVEhIX7qVTCstCVman3M
 yauf6IiaPo9lMZxzCO4FS1r1iTKTXoD09vId7FQuYjANxx+B/c6jiEJd0Hpf9txyqdxq
 AFkz/Djhv5AnTD8gU9OYo8rwWtJBIDoPyqYLkxUrN4TAwcskCs/WoHCyq6KJkP4RULpZ
 oDp1b7/oFijtLfxRuTlPNLitTMnfaiVMXXjA/Qcp+ALRivOMvQvDVv9iDD7QJR4IImIQ
 xX9R9Ab/1s1EqcbEE5LmJ8etWNwXuGuDX4h2Ch8IqWDtNHKK0K9B7e+pj0OIXHBB1r3Z
 rCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697652716; x=1698257516;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ryudDDILGHBqSPSusnyBRafd1nlh0D1vtdTegRn4Qsw=;
 b=lmz2BBLXz7EzzYmvg7Dgc9tNeiTMn8yvuky7t4EAqXB4aqtDS9BAoY/WCrNwdv0sgv
 4TdnNV0qk/bgXaRlVbJYDMhz0M9Kx7xMeNhsfqhNK6m952KQ9AnczBn7HyB/BcAVALSE
 OWWBbje+lHu/pH4gtGwX8pl4KEI5kCaB+5jmE5J1YudMuCQM337kv8/J/tOiXSShSM/L
 MwzV39Q7SBrpgz/22OuoIMC1UAiIQdayjZZ72DS1rL/0jqgsbK3UB9oSk7m3ZbvMksqf
 0uU6ey8wa+3hA7+4rjLFE6T1bl23VnZ0eFuNv65qBYBT2gxGe5vxae+XYJFofVZIxkjb
 1XCA==
X-Gm-Message-State: AOJu0YwQa0bgDMfqJwPtui9HOQ7lwKE3nRog7tFPKH3stXDce3oyWJ8D
 ChSJpCeeYfNNhGhKm8SWlb7Sh7ebgR+OaMiMhCI=
X-Google-Smtp-Source: AGHT+IFL2U3Ec/j4h0SXuF4L6QeuiJUwdzqppn8ix4fL6T9VZf2MPiSXdUKv1e8sKfZj/28Ij0hmwlE3CFQFlxAbgdM=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:b46:0:b0:d9a:3e96:b549 with SMTP
 id 67-20020a250b46000000b00d9a3e96b549mr2755ybl.10.1697652715738; Wed, 18 Oct
 2023 11:11:55 -0700 (PDT)
Date: Wed, 18 Oct 2023 18:11:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231018181152.745496-1-nabihestefan@google.com>
Subject: [PATCH 00/11] Implementation of NPI Mailbox and GMAC Networking Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=36x8wZQwKChwF23A96KL672F8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 hw/net/npcm_gmac.c                  | 943 ++++++++++++++++++++++++++++
 hw/net/trace-events                 |  20 +
 include/hw/arm/npcm7xx.h            |   4 +
 include/hw/misc/npcm7xx_pci_mbox.h  |  81 +++
 include/hw/net/npcm_gmac.h          | 340 ++++++++++
 tests/qtest/meson.build             |   8 +-
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
2.42.0.655.g421f12c284-goog


