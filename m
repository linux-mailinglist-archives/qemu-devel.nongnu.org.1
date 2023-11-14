Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44C7EB292
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:40:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uZT-0003f6-16; Tue, 14 Nov 2023 09:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZR-0003e4-0H
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:17 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZP-0007qf-Hn
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:16 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso1375255966b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972754; x=1700577554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhpN1sNxh5OOZ/KSUE3Y0jUPmEpPW/hS+3a5vlda+P4=;
 b=q+ccnHBdtx/ZEFxIa6c1FhdVHrEh+G6RATqa0qeCtPZL5G03UPdt5FycRZ2peD9KuW
 iyyACTbSudRwhdnj7/jwB/CwzMqUYru9oF6cXz1QS+1aRtJIZXgmK1beH7qf8reT2hCS
 hINDlsJSKU8qWtpcPdvVL/lv7240q75l5UanzGRtmmfrJJaZ6LFgjuf/szwHEfVCU1CI
 eXN38IWNq4rwHTCvQhgin26SVaq3vFScqGZar6CL7Ysk8fS/5/QadvFi8VJljk+SP+Sy
 vjYffeeXMt1JA/KrhiUqNgHsfTjWJWLrVo1YxK0etSK58iljOPU581TZFkiLCR7B2Od1
 aCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972754; x=1700577554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhpN1sNxh5OOZ/KSUE3Y0jUPmEpPW/hS+3a5vlda+P4=;
 b=wBiNkMr3wI6W0iOFhRnb8guNRyAwvTb6XE8J1eezvduDOgl6MaSk5YZaJ3udUakGUB
 lydZH807SokjwfPMsqN/sNRKwPvpwAkB+1kHBfVy0+aIB0wnvuEutmH/4BoeLXDg+cpP
 VdniJwZMjYlyBrg5yWs5+EBS9ILkOtobGJ0DHdBv+dRMwMlvzXaivGrGXBXkgEevPvWb
 GRq+J2xWNuSJy9Xl3Y/8PvXy3i4A38AoOv+SotjfPf8fE7jMgBx9rSla9JiUbv8X3mpu
 oJIWHEwQnZVAuP5f7I1Ktf30MC8jdUdbyk2TC1TdzlQAqN1yobW7TZRAhNGiKiPMSM5J
 A8Sg==
X-Gm-Message-State: AOJu0Yz53seN2D2IWcu6eBqNRZL33fLKkRdOB1nNCrcErD4Ti5hsJrX8
 c/ZP4hha3/AobrZ15BhlYK1H10/1jQ12hu552qU=
X-Google-Smtp-Source: AGHT+IEBPsAFKv3TcvW/4lHrf4Ji7dOfSz7fvZ7L1HUiABJvwud/gdEB/1UIkKrwYaMtMuFVPwAlYw==
X-Received: by 2002:a17:906:bf45:b0:9e5:1db7:3199 with SMTP id
 ps5-20020a170906bf4500b009e51db73199mr3052455ejb.4.1699972753957; 
 Tue, 14 Nov 2023 06:39:13 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 g4-20020a1709064e4400b009e609088c09sm5584953ejw.1.2023.11.14.06.39.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:39:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 08/19] hw/xen: Remove unused Xen stubs
Date: Tue, 14 Nov 2023 15:38:04 +0100
Message-ID: <20231114143816.71079-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

All these stubs are protected by a 'if (xen_enabled())' check.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 stubs/xen-hw-stub.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index 6cf0e9a4c1..53c6a6f2a0 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -8,36 +8,12 @@
 
 #include "qemu/osdep.h"
 #include "hw/xen/xen.h"
-#include "hw/xen/xen-x86.h"
-
-int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
-{
-    return -1;
-}
-
-void xen_intx_set_irq(void *opaque, int irq_num, int level)
-{
-}
-
-int xen_set_pci_link_route(uint8_t link, uint8_t irq)
-{
-    return -1;
-}
 
 int xen_is_pirq_msi(uint32_t msi_data)
 {
     return 0;
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
-{
-    return NULL;
-}
-
 void xen_register_framebuffer(MemoryRegion *mr)
 {
 }
-
-void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
-{
-}
-- 
2.41.0


