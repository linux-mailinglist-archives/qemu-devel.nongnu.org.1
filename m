Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F33A7A6C03
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:06:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigxo-00061Y-13; Tue, 19 Sep 2023 16:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3C-EJZQwKCiQNABIHESTEFANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--nabihestefan.bounces.google.com>)
 id 1qieyp-00055O-F5
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:57:48 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3C-EJZQwKCiQNABIHESTEFANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--nabihestefan.bounces.google.com>)
 id 1qieyf-0000zx-L5
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:57:45 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-59c27703cc6so41737277b3.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695146252; x=1695751052; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qC3MQTBowPtZjmB7tHI6GO0FUxL12NNYhHDeMduCgnY=;
 b=4tw9Pl5MI4jqthrMwkXYp5ScnpYaBqBpraJJ8+a0Qu89srOewPr/xpYKKpPIANSIyg
 ycsFUUIJJK3CmgckvLuRWMRWRfibZRE3yhYLjV5b8XTZ7oVAACVMgq2nG3qZxqp67hTF
 woZR+WY8uuTWvkwguUWfQuJP9u3SlSRrjg479zGS9k7KICmv4umVEJh7iDrEpPM2B89F
 fBji396XxgZRp3ttdEMSuRiZ4ZLMtmqWGekHl2uS8Ct5utcxOE2H4DS1bN/thp9lfgcu
 lo0zb1dNTBi+lR8hNBmVQCXeQ5HO0GHY7VidDTsH+KgeeeODTU4oUwiQ/1Hu4XxZGyE1
 UqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146252; x=1695751052;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qC3MQTBowPtZjmB7tHI6GO0FUxL12NNYhHDeMduCgnY=;
 b=S0ekZfocEKymniBb/bb/1tv+O5vkAtR+KfEn2WF6wkWV02y5w/FEvTsdfdMPB6uOde
 eDXxqb9dzI5PWwZgn+gRrQZMUmckSyFK6ewhsJGWbZE/mnrPX4jKxPmre9ZuE1lcI4Pc
 kL3LB/LIVsUtlJe7q+TiRiuruIjI/eRhujHGc6ld0fAmqCylaJPYdT7rcnHdMGWpNdaK
 0+pE5kzvapFOvj4YR3WS48yT/SavacYN1+D8apcLaxBrNwQ47GuF9DZ2nkUu3GQ/CY0I
 YhXasrnv5RWOej2aQGTTru9Fl8R3MXT8QYtf79TD4dximO+UlAN5EQ8Fd9BSN4FIExV8
 /+Ww==
X-Gm-Message-State: AOJu0YyMWCpTwOeAJCVurKUZLrCh/eoVoVsTzggFL/kOW4gafevg2UGD
 cP6YjDsJdtUkVakiOOk+8fVj4QJX9iS/c4HQa/Y=
X-Google-Smtp-Source: AGHT+IH6P4CWfIPgBJvOh+mSVJH1Nvh+pvUJlzLZ++1t+DybiEJmtxJ0jB7ijdKBCObBxtoHseRqYf6VNP3Du2hnZcg=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:8ca:0:b0:d13:856b:c10a with SMTP
 id 193-20020a2508ca000000b00d13856bc10amr6341ybi.3.1695146251886; Tue, 19 Sep
 2023 10:57:31 -0700 (PDT)
Date: Tue, 19 Sep 2023 17:57:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919175725.3413108-1-nabihestefan@google.com>
Subject: [PATCH 00/14] Implementation of NPI Mailbox and GMAC Networking Module
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, Avi.Fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3C-EJZQwKCiQNABIHESTEFANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 Sep 2023 16:04:50 -0400
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

Creates NPI Mailbox Module with data verification for read and write (internal and external),
wiring to the Nuvoton SoC, and QTests.

Also creates the GMAC Networking Module. Implements read and write functionalities with cooresponding descriptors
and registers. Also includes QTests for the different functionalities.

Hao Wu (8):
  hw/misc: Add Nuvoton's PCI Mailbox Module
  hw/arm: Add PCI mailbox module to Nuvoton SoC
  hw/misc: Add qtest for NPCM7xx PCI Mailbox
  hw/net: Add NPCM8XX PCS Module
  hw/net: Add NPCMXXX GMAC device
  hw/arm: Add GMAC devices to NPCM8XX SoC
  hw/arm: Add GMAC devices to NPCM7XX SoC
  hw/arm: Connect to chardev backend for NPCM8XX

Nabih Estefan Diaz (6):
  \tests/qtest: Creating qtest for GMAC Module
  include/hw/net: Implemented Classes and Masks for GMAC Descriptors
  hw/net: General GMAC Implementation
  hw/net: GMAC Rx Implementation
  hw/net: GMAC Tx Implementation
  tests/qtest: Adding PCS Module test to GMAC Qtest

 hw/arm/npcm7xx.c                    |  54 +-
 hw/arm/npcm8xx.c                    | 904 +++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 hw/misc/npcm7xx_pci_mbox.c          | 323 ++++++++++
 hw/misc/trace-events                |   5 +
 hw/net/meson.build                  |   3 +-
 hw/net/npcm_gmac.c                  | 937 ++++++++++++++++++++++++++++
 hw/net/npcm_pcs.c                   | 409 ++++++++++++
 hw/net/trace-events                 |  20 +
 include/hw/arm/npcm7xx.h            |   4 +
 include/hw/arm/npcm8xx.h            | 118 ++++
 include/hw/misc/npcm7xx_pci_mbox.h  |  81 +++
 include/hw/net/npcm_gmac.h          | 342 ++++++++++
 include/hw/net/npcm_pcs.h           |  42 ++
 tests/qtest/meson.build             |  12 +-
 tests/qtest/npcm7xx_pci_mbox-test.c | 238 +++++++
 tests/qtest/npcm_gmac-test.c        | 342 ++++++++++
 17 files changed, 3826 insertions(+), 9 deletions(-)
 create mode 100644 hw/arm/npcm8xx.c
 create mode 100644 hw/misc/npcm7xx_pci_mbox.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 hw/net/npcm_pcs.c
 create mode 100644 include/hw/arm/npcm8xx.h
 create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 include/hw/net/npcm_pcs.h
 create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
 create mode 100644 tests/qtest/npcm_gmac-test.c

-- 
2.42.0.459.ge4e396fd5e-goog


