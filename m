Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9778266C3
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 00:18:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMcNj-0002HT-Gl; Sun, 07 Jan 2024 18:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rMcNh-0002Gu-Jb
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 18:16:37 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rMcNg-0006Jr-0z
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 18:16:37 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50eabbc3dccso1031619e87.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 15:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704669393; x=1705274193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6jsVDJtLEm1lPndCJvtY3GO9mpTGY2wxwxo3LuOR4oE=;
 b=jUZ4Z/UchmHh9EDeQNxB385WRdxe9nfSkqICiNlhbQZrqKsHiPneJZ3YBDSqKKx9B8
 8gTLPQZ+sav/LQJrQ5HKUR/fIgaz9yiCkp+hT2N5HMEezAlSqlQPccZsFjcwqWIe8xXc
 n55kQAeFRDK6VnPnsxK6jQAsRVQPkW/09STPRTvI+N4HMcv+5CKw1LRSxCRFNjlanVF4
 1CoRj2HhUgBdJfKbblD6IdMadpa2wStl+HIZCtvKPdlvhHcWr1uSa5ZzLfAmDiweMafJ
 T9bLTjE3xFTIABc5vFR2pU6gRTS8ykvjvRGjDB6wk6/cMgRAaJBvJ8ghFeFGW5RpzFG2
 9tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704669393; x=1705274193;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jsVDJtLEm1lPndCJvtY3GO9mpTGY2wxwxo3LuOR4oE=;
 b=h804iz97tXKvcyZgN1SKytv56F/pW3xmRlqQUdxfDO0qk1kTMlaTTajCRXdbo3pt7/
 2qhM3tFoSjUiLU59Qh8Jyl0vSth/VEvdbOPA5BW8AYccGCg6Y0oHQVwj5sizEKF6hNHR
 pXwNqwv8mnnCqJGtHD3YCq44GGU2QOTZ7vWzdoOVNK4GUYGUumyg1iT9lb6ukFyaim+c
 2TFDzL3G3etktmYssVc2HIPSPxqkXwkBhI+UObZeCEpNCPbo2vC5asfu0767Ps0LTPID
 wm4IHIPUetXfJuAdR2j609es+B3aFavrTBO39cDr3Xe/14sW4BeuCwWJ2AzJTa63bgyh
 Bkcw==
X-Gm-Message-State: AOJu0YzrQYLODPXMgFIHOgmOp3kBM9w+Qa8opR3IIxATY+PrLyyBGQ3x
 +HKzR54Xqri41VO6dklLfdUYCPAkQkU=
X-Google-Smtp-Source: AGHT+IHk2KwjckC2+0MPqdilUMmvonza/ii8ds1d+gqApYYQ7ahD486c6CLaIVQh3OrzE2iSYbke6w==
X-Received: by 2002:a05:6512:39ce:b0:50b:f1ca:e6a with SMTP id
 k14-20020a05651239ce00b0050bf1ca0e6amr610420lfu.48.1704669392392; 
 Sun, 07 Jan 2024 15:16:32 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-077-191-044-194.77.191.pool.telefonica.de. [77.191.44.194])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a17090635c900b00a27eddc3dcbsm3338834ejb.198.2024.01.07.15.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 15:16:31 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, David Woodhouse <dwmw2@infradead.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] hw/i386/pc_piix: Make piix_intx_routing_notifier_xen() more
 device independent
Date: Mon,  8 Jan 2024 00:16:23 +0100
Message-ID: <20240107231623.5282-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x136.google.com
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

This is a follow-up on commit 89965db43cce "hw/isa/piix3: Avoid Xen-specific
variant of piix3_write_config()" which introduced
piix_intx_routing_notifier_xen(). This function is implemented in board code but
accesses the PCI configuration space of the PIIX ISA function to determine the
PCI interrupt routes. Avoid this by reusing pci_device_route_intx_to_irq() which
makes piix_intx_routing_notifier_xen() more device-agnostic.

One remaining improvement would be making piix_intx_routing_notifier_xen()
agnostic towards the number of PCI interrupt routes and move it to xen-hvm.
This might be useful for possible Q35 Xen efforts but remains a future exercise
for now.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_piix.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 042c13cdbc..abfcfe4d2b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -92,13 +92,10 @@ static void piix_intx_routing_notifier_xen(PCIDevice *dev)
 {
     int i;
 
-    /* Scan for updates to PCI link routes (0x60-0x63). */
+    /* Scan for updates to PCI link routes. */
     for (i = 0; i < PIIX_NUM_PIRQS; i++) {
-        uint8_t v = dev->config_read(dev, PIIX_PIRQCA + i, 1);
-        if (v & 0x80) {
-            v = 0;
-        }
-        v &= 0xf;
+        const PCIINTxRoute route = pci_device_route_intx_to_irq(dev, i);
+        const uint8_t v = route.mode == PCI_INTX_ENABLED ? route.irq : 0;
         xen_set_pci_link_route(i, v);
     }
 }
-- 
2.43.0


