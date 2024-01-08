Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0172826BF1
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:59:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnLZ-0004MJ-LQ; Mon, 08 Jan 2024 05:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rMnLX-0004MB-OF
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:59:07 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rMnLR-0006rX-FJ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:59:07 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-336897b6bd6so1891597f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 02:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704711538; x=1705316338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tYYOOvHfhkgck3QqF8kym4SroXyG/FWDJsLrhrUthYw=;
 b=XtVbFKGk+pf9zn0/WrmsGK3cLxniDoIUwHsD5v/MvHbGJIbe0DpA3202hcubq4hdBH
 N9eIHhOFAEBL2bHnnoY/xjohpnRG3kN2O+vafCj3YbHFpMGQN6yWZs7OmpJS3RVipP0Y
 rkKgAKDEbE3EhU68fJdmXEvEkL43IdVN83RmuZwj70yuzxYq2Qj4DKQGwu15z9BtDeHI
 pHp4K7VRDHApObtlLGdS3HoSIR8qReGOvNmHQqmJvdbCs81vbo5ZT+Tu3O9M1SfGvHRt
 xq5XGT+e1BpjgT/TXjj/wYePr71QSq8o3AJOwNInevZsfhJb9aIRHpCrAI7uIqHZF8Wr
 K2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711538; x=1705316338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tYYOOvHfhkgck3QqF8kym4SroXyG/FWDJsLrhrUthYw=;
 b=rxN6cfd3ElRPf/GQzoH+riiU2BEegfccKNFrHc+FyPMsKMofLZd+wJ9ZgoV1dmnswk
 p8oYhD7m++xgRHvtP8JaTQHP736UoQG9/wNe1voT8nqLBCGNvHYSYAteiqMz8jW8QNEg
 9Ke+ojt6YbN9tfOz5caiWIEYKg1WLRNIt8ucxt7xoIGuEJj/EBg4UuThoovL7Wcq1V04
 ov0DJH5963dpIJQKI8d5j+XP16Dn50b1CjLYLLzzbw84EjhTWywslE9zfSoX0zAFPc43
 Dwh1a1DdR76xONMRbvnY8RtxdAl+ReNBjvUVC36IZXixTZHzAmaF2PbdHXfZE3ITHneK
 XiLw==
X-Gm-Message-State: AOJu0YwQxCbCxG92HmWwUa8CUKpgD3gr3ewYgYXrWPaSGEXtYVQ0V/ju
 NLRXSsxV7UfWm10n5U9ft0bzemR2aXVPrA==
X-Google-Smtp-Source: AGHT+IHdmlAZbvpVWVV8mt9t25my+50JXKk3WrFuKcwQrDo6JVHbgf2PCEGKIIcksQQr5QGd7sUZXw==
X-Received: by 2002:a05:600c:190b:b0:40d:8ad9:b8f8 with SMTP id
 j11-20020a05600c190b00b0040d8ad9b8f8mr1550431wmq.10.1704711537794; 
 Mon, 08 Jan 2024 02:58:57 -0800 (PST)
Received: from Dev-shlomop.pliops.ent ([213.8.195.28])
 by smtp.googlemail.com with ESMTPSA id
 f13-20020a05600c154d00b0040e3635ca65sm10651592wmg.2.2024.01.08.02.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:58:57 -0800 (PST)
From: Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To: qemu-devel@nongnu.org
Cc: andrew.sminov@gmail.com, peter.maydell@linaro.com, shlomop@pliops.com,
 shlomopongratz@gmail.com
Subject: [PATCH] Hanlde wrap around caused by the fact that perior to version
 460A the limit was 32bit quantity. See Linux kernel code in:
 drivers/pci/controllers/dwc/pcie-designware.c function:
 __dw_pcie_prog_outbound_atu Now in a 64bit system the range can be above 4G
 but as long as the limit itself is less then 4G the overflow is avoided
Date: Mon,  8 Jan 2024 12:57:27 +0200
Message-Id: <20240108105727.117431-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shlomopongratz@gmail.com; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
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


