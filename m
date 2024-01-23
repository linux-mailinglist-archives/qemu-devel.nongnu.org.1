Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5A838B42
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:00:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDYC-0000pB-VQ; Tue, 23 Jan 2024 04:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rSDYB-0000p1-Lz
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:58:35 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rSDYA-00089B-0d
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:58:35 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40ea5653f6bso36519025e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 01:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706003912; x=1706608712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VcJwkYMqUSjkE5fDzZQeShAVzibJ7FwWpRDb8AOYV3A=;
 b=AyVz3PFthHNA7RkYQ7bVQS0yzsneMf3fKSafcIFvV+DjmjhAbkMJ/b0OPrGvfA/pj5
 QSzbLmdn3790PsNFIRphhM6AJS7PO3t/lz78Z98ECzvCCt87xyxK5m4L1l60k3+eNyE1
 xm+7tf91aqoSf6E6WXuzM4PPqNf/EAQoTP4Z4A9Ih6DYTKPyWmdoFdEtIs9y9ZSmll5W
 tY7R6uq1IwDJwAyQdriowWHNmBPm/YcGGQo8YtdQZPVp32P1ALh0fASr9VivHVOBZjbQ
 vca++oEHrKcC24kfzzpWMVaaN5cDMyyQUf546WDWFke2LJma3uwBScv3DYjvRrUGOj7Y
 +8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706003912; x=1706608712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VcJwkYMqUSjkE5fDzZQeShAVzibJ7FwWpRDb8AOYV3A=;
 b=dGscnUAPI/4F+/EsZ6jNLtp6ETWC/Q5FQAiE54yJ8cK5iY0EPy12SOlNNJA/IPu/xi
 PxB02/CbuucKr12YGfZnKY7nwqXryEsDl/IRjOv4S+WX8KTcM0Tx4pTPI4yG/gRIsrm7
 aA3YfivsaAatZVgglgCe0ACydxtENlw8BCvhBJREzIuYx9BSQkCJZeHeU/XBCJxWIbZ8
 IH7HGqF6hDlkLlhUUvAL8fEiK6VVPiQGyyS9I0n4M8cwKdV0OXRZHQjYjcjNSPTG4zw6
 w/SFypYiYrB4yfvqXLDt4wZVTqglIppQb52DdItteWTeOwgMMDKp1xb62Wy6hI7dvAvr
 PftQ==
X-Gm-Message-State: AOJu0YxE+PlD64tBHdbgrXiMg1HLL2JO4owqaoEjKawVlZX7vVpOLFTc
 rTkKtZceudPSpWO9K8o10L7ZqKyOzv0l3VyZfxIycN3WSJ8n+MsMBUEfeR1bfuU=
X-Google-Smtp-Source: AGHT+IFsoj3Aze1igwwscmmIVPcoYyX4osGucZued+WMxsItnwXq+IFUzfmPXVh6gr8Ow6tH4H4UYg==
X-Received: by 2002:a05:600c:1910:b0:40e:5978:c94a with SMTP id
 j16-20020a05600c191000b0040e5978c94amr387332wmq.24.1706003911530; 
 Tue, 23 Jan 2024 01:58:31 -0800 (PST)
Received: from Dev-shlomop.pliops.ent ([213.8.195.28])
 by smtp.googlemail.com with ESMTPSA id
 n18-20020a05600c3b9200b0040e4ca7fcb4sm42113422wms.37.2024.01.23.01.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 01:58:30 -0800 (PST)
From: Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To: qemu-devel@nongnu.org
Cc: andrew.sminov@gmail.com, peter.maydell@linaro.com, philmd@linaro.org,
 shlomop@pliops.com, shlomopongratz@gmail.com
Subject: [PATCH v4] Handle wrap around in limit calculation
Date: Tue, 23 Jan 2024 11:58:21 +0200
Message-Id: <20240123095821.59625-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shlomopongratz@gmail.com; helo=mail-wm1-x32f.google.com
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

    Changes since v3:
     * Use Peter Maydell's suggestion for fixing the bug,
       that is compute a 64 bits limit from the upper 32 bits of the base
       and the given 32 bits limit.

    Changes since v2:
     * Don't try to fix the calculation.
     * Change the limit variable from 32bit to 64 bit
     * Set the limit bits [63:32] same as the base according to
       the specification on which the original code was base upon.

    Changes since v1:
     * Seperate subject and description
---
 hw/pci-host/designware.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index dd9e389c07..f81dbe3975 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -269,8 +269,20 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
 {
     const uint64_t target = viewport->target;
     const uint64_t base   = viewport->base;
-    const uint64_t size   = (uint64_t)viewport->limit - base + 1;
+    uint64_t size;
     const bool enabled    = viewport->cr[1] & DESIGNWARE_PCIE_ATU_ENABLE;
+    uint64_t limit;
+
+    /*
+     * Versions 460A and above of this PCI controller have a
+     * 64-bit limit register. We currently model the older type
+     * where the limit register is 32 bits, and the upper 32 bits
+     * of the end address are the same as the upper 32 bits of
+     * the start address.
+     */
+
+    limit = deposit64(viewport->limit, 32, 32, extract64(base, 32, 32));
+    size = limit - base + 1;
 
     MemoryRegion *current, *other;
 
-- 
2.25.1


