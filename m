Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 976EF73E225
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:29:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlZU-0007tI-UT; Mon, 26 Jun 2023 08:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDlZ7-0007Pq-EG
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDlZ5-0006rX-S6
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687783411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3Ea0SKZau2Jo979u+ZtC+1sgLp3g4vwTJL9iw20rFXM=;
 b=i8lXISbalAtMdjrP08aS52vJ+XoKtCSt441Td/Muag3lnSL8/jMbWTpPDnhO+qUw5irTn4
 HYjf+QaGGuwG+H0UfpaR7ul6h6H4Q88Jt/EszefKUbvP67ZkmmLGwgrP8lpboieskIoJXh
 AnWR0X7TCfyTKcUXvwGyXNnR69pbgeE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-8E0pxUNbO1uZZnzB3C3leg-1; Mon, 26 Jun 2023 08:43:26 -0400
X-MC-Unique: 8E0pxUNbO1uZZnzB3C3leg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b7fd27e120so9996815ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687783405; x=1690375405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Ea0SKZau2Jo979u+ZtC+1sgLp3g4vwTJL9iw20rFXM=;
 b=Bk1j2lI+ADToZuLyE1wZmqAbI1BvIWB88QEpC7OwoxKm/i8fXU46tC3jKJom5WQK92
 V3dc8QIdJlX3pdCoc7iAQHW6SPh31+kgPpbkAAZVbpgCBkuV5++sRnzHyYgFN99UMf+P
 adFf2802yZxU2AHjNo4WkyLLZEcOET42OG1VBR2yAFkz7VZzEAD7BSx0G9oP4WrvNv/n
 M9aVPHWOfsinkEEIffMMz5GV7coM8hJAK7YuP90Up1bxcI2c5Xb0Tl0IEQsyUnOczu7N
 uIdS6A9mC6p/LXF/p2Ga5nQlkmoQXxwX6WUrHFPWYMlWMMuj0jPl2r4OPRcC7ZELbojI
 OUTg==
X-Gm-Message-State: AC+VfDym0UaCuOZHmKLDOByQO0elHaiVKP8/uYw8njhmzOhYqtWGxIId
 ucFCdN5jCsZWqrJv/4eTwDLFmbJ4cV2s5vQWBO4NIbEM5F6NhE56TAeL6Vjp5EqX4/iq2kcEA/s
 pa1UGotOPO4MQr5t83OzxvFiVl4H6WPE0qeE41tPWrnd66RYDu3R65Y9Eb9V+/EoRY85MyO5t3C
 c=
X-Received: by 2002:a17:903:2656:b0:1b0:3df1:c293 with SMTP id
 je22-20020a170903265600b001b03df1c293mr6828824plb.45.1687783405133; 
 Mon, 26 Jun 2023 05:43:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5LBjIoJ4dmgExadpoS6wdyIiqok0ST5dj+wTgydrj4Dr9JscvGGNzMNTuKUhufv2FvDCdCBA==
X-Received: by 2002:a17:903:2656:b0:1b0:3df1:c293 with SMTP id
 je22-20020a170903265600b001b03df1c293mr6828807plb.45.1687783404794; 
 Mon, 26 Jun 2023 05:43:24 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 j22-20020a170902759600b001b3c892c367sm4111671pll.63.2023.06.26.05.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:43:24 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 jusual@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 michael.labiuk@virtuozzo.com
Subject: [PATCH v3 0/5] test and QEMU fixes to ensure proper PCIE device usage
Date: Mon, 26 Jun 2023 18:13:01 +0530
Message-Id: <20230626124306.4572-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Patches 1-4:
Fix tests so that devices do not use non-zero slots on the pcie root
ports. PCIE ports only have one slot, so PCIE devices can only be
plugged into slot 0 on a PCIE port.

Patch 5:
Enforce only one slot on PCIE port.

The test fixes must be applied before the QEMU change that checks for use
of a single slot in PCIE port.

CC: mst@redhat.com
CC: imammedo@redhat.com
CC: jusual@redhat.com
CC: thuth@redhat.com
CC: lvivier@redhat.com
CC: michael.labiuk@virtuozzo.com

Changelog:
v3: tags added. reword the error description in patch 5. Reword commit log in patch 4. 
v2: add hd-geo-test fix as well as the actual QEMU code fix to the patchset.
The patches are added in the right order.


Ani Sinha (5):
  tests/acpi: allow changes in DSDT.noacpihp table blob
  tests/acpi/bios-tables-test: use the correct slot on the
    pcie-root-port
  tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp
  tests/qtest/hd-geo-test: fix test by removing unnecessary
    pcie-root-port
  hw/pci: ensure PCIE devices are plugged into only slot 0 of PCIE port

 hw/pci/pci.c                      |   6 ++++++
 tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
 tests/qtest/bios-tables-test.c    |   4 ++--
 tests/qtest/hd-geo-test.c         |  18 ++++++++----------
 4 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.39.1


