Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3EE828635
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 13:47:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNBUU-0004Py-93; Tue, 09 Jan 2024 07:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rNBUN-0004Pm-GJ
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 07:45:51 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rNBUF-0000oX-IB
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 07:45:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d8902da73so27445295e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 04:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704804300; x=1705409100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3qMiaar5IOtsCSNqZb+svB+dENrjorAlUkTx9SCX+Ng=;
 b=ZBAnows9k3GRqNZVNguzx0BubgcDWNmy6CkrrNTAw0CdxW+sAwXib1kREZ6LfxoyDY
 K9aFpkv/lemceW/AjTr8/Y37n5DcxPlVR7TkGniuyQW0WTj7rqNn2a/hs3kXGTIrc+xd
 fcd3HYKAr/SoLIjvoRR/j0GhhkcSw/CzRFzKdkAdLlCDpLY9zfPJXcRt75uYSXtrKT1z
 cWFY9TEZ3NY7m2W9xXJKu8emD90xXHKHVMlOYY7CrjRaBk3ZATa4hrJ58UGj0MnzBb8p
 YOujfHoLQIcVqJtihgYQTo9YHcSfY6GMCNxj8fVWJuU46k32aQGLREflaF/+TZlitDIm
 Pdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704804300; x=1705409100;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3qMiaar5IOtsCSNqZb+svB+dENrjorAlUkTx9SCX+Ng=;
 b=pl/E+VT5d1axi5QYp+A9nectzcQXDNZ+RedM7GxNNgJFkDRNIsO/jGOyxoskQ7JiZY
 4yKTYJ5F2LeHqA+6fxMb072p7FGQvUXm1nhPIGQdZ+1foTQN8N69dZEdVVjG40Pwsqox
 DloFUSEV/CSQWN+wBfmWXECh9I9iWARDn0nUAy9j0YTL9wC207q5JJtCxntGqHWzHxyr
 Z4TXStWrE+ZRDY8V63SF1bqykh3+W8B5rEN7NA0BXciAQ3Oci94up7l0VQOcb7T3n4zq
 OVaqON9nqWAGJjD0wLsIciP+HV2xmJvzxd2/S0aePti+1kqF8ropXv2jHn/zU8+VrzUX
 Ix8A==
X-Gm-Message-State: AOJu0YyGx7rHod3EzzfYVje4vIkUwGWYtDclGI8N1pt9sLSICXI1FtcI
 mj2f9C4XV48AJI8sQIHkjeU9uyxJQ/IUaQ==
X-Google-Smtp-Source: AGHT+IGu26SFknSKcEI3uyTyUoV4wfmRqGikgT9u9WvO6UhrSZ6LkaXEKe3S/i7aIx2HQNsTkg14tg==
X-Received: by 2002:a05:600c:1c02:b0:40e:3bf4:3a92 with SMTP id
 j2-20020a05600c1c0200b0040e3bf43a92mr3004669wms.45.1704804300040; 
 Tue, 09 Jan 2024 04:45:00 -0800 (PST)
Received: from Dev-shlomop.pliops.ent ([213.8.195.28])
 by smtp.googlemail.com with ESMTPSA id
 gw24-20020a05600c851800b0040d3276ba19sm3569210wmb.25.2024.01.09.04.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 04:44:59 -0800 (PST)
From: Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To: qemu-devel@nongnu.org
Cc: andrew.sminov@gmail.com, peter.maydell@linaro.com, shlomop@pliops.com,
 shlomopongratz@gmail.com
Subject: [PATCH V2] Handle wrap around in limit calculation
Date: Tue,  9 Jan 2024 14:43:33 +0200
Message-Id: <20240109124333.224240-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shlomopongratz@gmail.com; helo=mail-wm1-x32e.google.com
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

Hanlde wrap around caused by the fact that perior to version 460A
the limit was 32bit quantity.
See Linux kernel code in:
drivers/pci/controllers/dwc/pcie-designware.c
function: __dw_pcie_prog_outbound_atu
Now in a 64bit system the range can be above 4G but as long as
the limit itself is less then 4G the overflow is avoided

Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>

----

Changes since v1:
 * Seperate subject and description
---
 hw/pci-host/designware.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index dd9e389c07..7ce4a6b64d 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -269,11 +269,24 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
 {
     const uint64_t target = viewport->target;
     const uint64_t base   = viewport->base;
-    const uint64_t size   = (uint64_t)viewport->limit - base + 1;
     const bool enabled    = viewport->cr[1] & DESIGNWARE_PCIE_ATU_ENABLE;
+    uint64_t tbase, tlimit, size;
 
     MemoryRegion *current, *other;
 
+    /*
+     * Hanlde wrap around caused by the fact that perior to version 460A
+     * the limit was 32bit quantity.
+     * See Linux kernel code in:
+     * drivers/pci/controllers/dwc/pcie-designware.c
+     * function: __dw_pcie_prog_outbound_atu
+     * Now in a 64bit system the range can be above 4G but as long as
+     * the limit itself is less then 4G the overflow is avoided
+     */
+    tbase = base & 0xffffffff;
+    tlimit = 0x100000000 + (uint64_t)viewport->limit;
+    size = ((tlimit - tbase) & 0xffffffff) + 1;
+
     if (viewport->cr[0] == DESIGNWARE_PCIE_ATU_TYPE_MEM) {
         current = &viewport->mem;
         other   = &viewport->cfg;
-- 
2.25.1


