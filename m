Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE427CCA76
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:14:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsoY2-0004qR-3j; Tue, 17 Oct 2023 14:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bc4uZQwKCvQjWXedaopabWjckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--nabihestefan.bounces.google.com>)
 id 1qsoXz-0004pU-Rk
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:12:04 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bc4uZQwKCvQjWXedaopabWjckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--nabihestefan.bounces.google.com>)
 id 1qsoXw-0006v4-FU
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:12:03 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d9a45e7e0f9so8350567276.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697566318; x=1698171118; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZtnZX3qq6VUqd48mODDcHeavJ1fpcDwaSYbnpD75Hjw=;
 b=SIIQd9/JertoOoUk/qNbajWt57u9rekSWhOunIPEKT16bXYyzuragI6qw852kVEW80
 See7aVVn0Q8Mzf4Vb5ZkjAWebtJ7Qu/hbmovulCKrN85yuhbPkgkObu2egO0U+UJGIfy
 4BaWT13g9gF6j7mbPHsDoZVXI3S9oHIGMEHkG7snmdj6SLofdUpgF6WJxxXo1SU6rmce
 ZADD4+0v4IK7Cszp6amdHY8hAO5uWYpW0Np4URbJmI4+GFKWbUb19N6ikdvkekk93yAh
 4ZQyG1EZF6q06mvDanKHX0/Pkhw4mqFjNBwMYA4nXxDnXeIwnXo/QC9HbFA/b/JyWE21
 E7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697566318; x=1698171118;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZtnZX3qq6VUqd48mODDcHeavJ1fpcDwaSYbnpD75Hjw=;
 b=ZcVWKAEImEB6A7YcInkwB2hJPZM4EK+9bCR6Haa1n2zXDQAuOaYsMSQtl3ZOCxWV2L
 mSJCyl630TGgifm+FOzvr3QhSHhYdGgKv3HHvpNHmvh6YZ/GhuiwLt7vuN9EaEL3yCCE
 5lgAXlzCwlzOzClIL2LjbyGQvSQxAerYQgw0qE9WqHEXOWdpUIpb980GRyh4T/9fj/iq
 zKSPRiULowZtw6F6b6RI8Tl5HnstmMJVG/urWYYlQ+NwBSYh6rgoiOqLirzaboEVtvI/
 lI2NQA/Gv5MehTjc+kheQfjgSUpSVmUzQrGFpkvYPIWcaG87mVBZL6XtfOLjoJ46KK2P
 r1Xw==
X-Gm-Message-State: AOJu0YzF5P13HjflaG4Vq1Ifr/ZmLG1tq265PyqZX0UvHo3FB5hXPmr8
 SpoqvWTSHKy/qOfPzQpFjiWPE1uvw0L5r/NjU80=
X-Google-Smtp-Source: AGHT+IFkXDWAvvoqg/dGh/shFnnyQx/K2TASCn+Z9xsHUcixh2c7t1WlDg9ndUcr4hnJVF0rYObd4iJ5mg9+YtXhOcI=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:102d:b0:d9c:2a58:b905 with
 SMTP id x13-20020a056902102d00b00d9c2a58b905mr82918ybt.9.1697566317889; Tue,
 17 Oct 2023 11:11:57 -0700 (PDT)
Date: Tue, 17 Oct 2023 18:11:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017181152.201887-1-nabihestefan@google.com>
Subject: [PATCH 00/11] Implementation of NPI Mailbox and GMAC Networking Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3bc4uZQwKCvQjWXedaopabWjckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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


