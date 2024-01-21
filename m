Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE468356B9
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 17:49:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRazV-0001vb-03; Sun, 21 Jan 2024 11:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rRazP-0001sE-LA
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 11:48:09 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rRazN-0002RC-R1
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 11:48:07 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so24133465e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 08:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705855682; x=1706460482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2fWaQq4rWnp40PzjNHzj6lKaMLvc/fS0V8M6PQMp2GQ=;
 b=NSNLLi84wlNwgyyUUIo5pgVRxQFHbJ1POXsPwXj6HjLb11taGYMwuSrXf7tcvie/gq
 DPzoNIN1BMWPB3Sz0nuFKb24+YMtK3TvsFt7cv7qEDdvkJUQYZ2h5tUTfJvlx197nR0t
 LklTN5pCmEfMD4UpyXVvywbQN1bmLoulCtug9pcWU0ig7DgP4oAb57JuIhnWw4yiW68G
 sqMzXAjbWlqQLARoUCrBbI4M/vYnSbs9FNDucZ1SHiNKXlMeJHGcscmjXxXXUFLFH9Ex
 PDDN344y52a3RAEfsqOD1O+49xXJnpsslwnpeuY3BNVClZl+SMh4QpE6P7IaGu5gjvJf
 TgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705855682; x=1706460482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2fWaQq4rWnp40PzjNHzj6lKaMLvc/fS0V8M6PQMp2GQ=;
 b=a2MLodN75RHmFcFfSQm4xCmLY+n1CsbTBH19oXfeq8u3qQ3C3S0NQ5p165eJhDobvC
 /6VW2pKhqE3JAdtb7WoWc1vc7ERBwD+p5VlYbNTfYUxUn9dMgAWEnjzH6xaLqd254RTS
 YgSIUGhaP+wVglDPZMbrzl4pc4nYq1bLUTcM5d2st93L28Er5wGMYcg8eJzKA+BHXtcH
 Ae0fpy8Xl3TL+9CYYFVa4Ddl0NU0+P50pZhwRS5JXUuKx8XW3dD8dM08rPKQ/T4BR0lZ
 Z6CldBRIGuhtt7CQ9YU/+gwkayw2yA9B/OdDZkPGVhYSzM6PqpwHPFzIgS6G4jNIINoi
 s1cw==
X-Gm-Message-State: AOJu0Yz09PQKsnU3KV64jtR0Cwv9Q2BD3+h6DyaTRuf9XkQYTBUZ9w66
 4r/PJ8VGElLqb29YH+mkeQwymH+1XJPbzCIlDWYVI2QgT0eO9OK5aO6MvsucG5E=
X-Google-Smtp-Source: AGHT+IE/nL8cO88wYta38z59v4S58wkBeRgzssEN6B/Qq/c0kFGVzQaofnp3geKZ7ySkK0awl2phNg==
X-Received: by 2002:a05:600c:4e8a:b0:40e:34e2:9d1f with SMTP id
 f10-20020a05600c4e8a00b0040e34e29d1fmr1824136wmq.62.1705855682339; 
 Sun, 21 Jan 2024 08:48:02 -0800 (PST)
Received: from Dev-shlomop.pliops.ent ([213.8.195.28])
 by smtp.googlemail.com with ESMTPSA id
 v21-20020a05600c445500b0040d62f89381sm36289367wmn.35.2024.01.21.08.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 08:48:01 -0800 (PST)
From: Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To: qemu-devel@nongnu.org
Cc: andrew.sminov@gmail.com, peter.maydell@linaro.com, shlomop@pliops.com,
 shlomopongratz@gmail.com
Subject: [PATCH v3] Handle wrap around in limit calculation
Date: Sun, 21 Jan 2024 18:47:54 +0200
Message-Id: <20240121164754.47367-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shlomopongratz@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Shlomo Pongratz <shlomopongratz@gmail.com>

    Hanlde wrap around when calculating the viewport size
    caused by the fact that perior to version 460A the limit variable
    was 32bit quantity and not 64 bits quantity.
    In the i.MX 6Dual/6Quad Applications Processor Reference Manual
    document on which the original code was based upon in the
    description of the iATU Region Upper Base Address Register it is
    written:
    Forms bits [63:32] of the start (and end) address of the address region to be
    translated.
    That is in this register is the upper of both base and the limit.
    In the current implementation this value was ignored for the limit
    which caused a wrap around of the size calculaiton.
    Using the documnet example:
    Base HI: 0x80000000 Base LO: 0xd0000000 Limit LO: 0xd000ffff
    The correct size is 0x80000000d000ffff - 0x80000000d0000000 + 1 =
0x010000
    The wrong result is 0xd000ffff - 0x80000000d0000000 + 1 = 0x8000000000010000

    Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>

    ----

    Changes since v2:
     * Don't try to fix the calculation.
     * Change the limit variable from 32bit to 64 bit
     * Set the limit bits [63:32] same as the base according to
       the specification on which the original code was base upon.

    Changes since v1:
     * Seperate subject and description
---
 hw/pci-host/designware.c         | 19 ++++++++++++++-----
 include/hw/pci-host/designware.h |  2 +-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index dd9e389c07..43cba9432f 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -269,7 +269,7 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
 {
     const uint64_t target = viewport->target;
     const uint64_t base   = viewport->base;
-    const uint64_t size   = (uint64_t)viewport->limit - base + 1;
+    const uint64_t size   = viewport->limit - base + 1;
     const bool enabled    = viewport->cr[1] & DESIGNWARE_PCIE_ATU_ENABLE;
 
     MemoryRegion *current, *other;
@@ -351,6 +351,14 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     case DESIGNWARE_PCIE_ATU_UPPER_BASE:
         viewport->base &= 0x00000000FFFFFFFFULL;
         viewport->base |= (uint64_t)val << 32;
+        /* The documentatoin states that the value of this register
+         * "Forms bits [63:32] of the start (and end) address
+         * of the address region to be translated.
+         * Note that from version 406A there is a sperate
+         * register fot the upper end address
+         */
+        viewport->limit &= 0x00000000FFFFFFFFULL;
+        viewport->limit |= (uint64_t)val << 32;
         break;
 
     case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
@@ -364,7 +372,8 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         break;
 
     case DESIGNWARE_PCIE_ATU_LIMIT:
-        viewport->limit = val;
+        viewport->limit &= 0xFFFFFFFF00000000ULL;
+        viewport->limit |= val;
         break;
 
     case DESIGNWARE_PCIE_ATU_CR1:
@@ -429,7 +438,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         viewport->inbound = true;
         viewport->base    = 0x0000000000000000ULL;
         viewport->target  = 0x0000000000000000ULL;
-        viewport->limit   = UINT32_MAX;
+        viewport->limit   = 0x00000000FFFFFFFFULL;
         viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
 
         source      = &host->pci.address_space_root;
@@ -453,7 +462,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         viewport->inbound = false;
         viewport->base    = 0x0000000000000000ULL;
         viewport->target  = 0x0000000000000000ULL;
-        viewport->limit   = UINT32_MAX;
+        viewport->limit   = 0x00000000FFFFFFFFULL;
         viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
 
         destination = &host->pci.memory;
@@ -560,7 +569,7 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(base, DesignwarePCIEViewport),
         VMSTATE_UINT64(target, DesignwarePCIEViewport),
-        VMSTATE_UINT32(limit, DesignwarePCIEViewport),
+        VMSTATE_UINT64(limit, DesignwarePCIEViewport),
         VMSTATE_UINT32_ARRAY(cr, DesignwarePCIEViewport, 2),
         VMSTATE_END_OF_LIST()
     }
diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index 908f3d946b..51052683b7 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -41,7 +41,7 @@ typedef struct DesignwarePCIEViewport {
 
     uint64_t base;
     uint64_t target;
-    uint32_t limit;
+    uint64_t limit;
     uint32_t cr[2];
 
     bool inbound;
-- 
2.25.1


