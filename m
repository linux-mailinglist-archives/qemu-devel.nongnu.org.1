Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B90C78A6A1
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaWnd-0006Zi-86; Mon, 28 Aug 2023 03:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnb-0006Yb-ED
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnZ-0004K3-4p
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so26045275e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693208191; x=1693812991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXRQz+WTZ9cwdEb7LnIQVnwZoTSZIA4RlJg2NnrIBrc=;
 b=n6sdFvqCeJcCpSq1LR0I+LDvOB9n6LqRTz5MahGDmWnOLB4uCUkgkF0MPjD+OqF1FK
 6dW8gaCfhty57M5W3t1RoEQ3pW/yD6MJFZ2GIzlD/pvyPMiP08fRtGGIa2jrmfHWe9pT
 er3EfFyBWfEj8gdoIxl1XOoLFjFOXmeAD+6KFb9G2X3em42BF1MuViGaAU7SDNP5SQ/D
 TfbKs9mS6VTefvFytjzTsVc+mIVGRnn4k7wKxyzLT8mIk91Xt/PhbWYMPPRTI3AuAhtW
 rW94r3Z5O4MhJxxP/oGYzLo24pPn1IvyMpsCXhX8jx2vOghXAXyHva7xF5M4bu49WLO5
 ymqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693208191; x=1693812991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xXRQz+WTZ9cwdEb7LnIQVnwZoTSZIA4RlJg2NnrIBrc=;
 b=iiUwcbCjwqf04Dz8kt0eLqc4OtqON5R8ygS7mky/sv48PryWykhratnoDUrjGSV1Ap
 7lA5lWmXVt17tK1atSQOA3XRr2d/Bid4hVM/9MHFO+mL/4AivGXvEvtWfSI0bFdtBwNX
 dVC9U96dbwGNOYoDOTB+tPIdER7mWXeB73L6seqoLhKdGr2W+pEMlVPqugWW3vkO2g7C
 dbFWZt7WIz4myPM1WQxlIgMEvxvjJGoPt0jBcp6aQbGT6iQzC+uAbF/uIdybZTeggV4/
 O2EzcYvWtuB6JbvDYOq/CNhWMn+AbbF7B5ZmZPfuPE/gmfAeT0e7JcDrm3GMTfpoKw/N
 XQiA==
X-Gm-Message-State: AOJu0Yy3DZ+hFBe5gC2/dP6RDygl6YizeAbPtxmEMC550xW7vOiolmaf
 MZuBz3842le55bPIcaNNkQXHkIARpK67/Q==
X-Google-Smtp-Source: AGHT+IHcY/6t90eKcWhQyqWRBiDJzmxjf8cTvEMGmGCjrR6E5el3WvQK7g91CpxawlFS7/5SFl2pQA==
X-Received: by 2002:a7b:c8d0:0:b0:3fc:193:734e with SMTP id
 f16-20020a7bc8d0000000b003fc0193734emr19621842wml.32.1693208190657; 
 Mon, 28 Aug 2023 00:36:30 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-055-138.78.55.pool.telefonica.de. [78.55.55.138])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c281100b003fef19bb55csm9795285wmb.34.2023.08.28.00.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 00:36:30 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 8/8] hw/acpi/core: Trace enable and status registers of GPE
 separately
Date: Mon, 28 Aug 2023 09:36:09 +0200
Message-ID: <20230828073609.5710-9-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828073609.5710-1-shentey@gmail.com>
References: <20230828073609.5710-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The bit positions of both registers are related. Tracing the registers
independently results in the same offsets across these registers which
eases debugging.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/core.c       | 10 +++++++---
 hw/acpi/trace-events |  6 ++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index c561845a4a..ec5e127d17 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -687,13 +687,13 @@ void acpi_gpe_ioport_writeb(ACPIREGS *ar, uint32_t addr, uint32_t val)
 {
     uint8_t *cur;
 
-    trace_acpi_gpe_ioport_writeb(addr, val);
-
     cur = acpi_gpe_ioport_get_ptr(ar, addr);
     if (addr < ar->gpe.len / 2) {
+        trace_acpi_gpe_sts_ioport_writeb(addr, val);
         /* GPE_STS */
         *cur = (*cur) & ~val;
     } else if (addr < ar->gpe.len) {
+        trace_acpi_gpe_en_ioport_writeb(addr - (ar->gpe.len / 2), val);
         /* GPE_EN */
         *cur = val;
     } else {
@@ -712,7 +712,11 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
         val = *cur;
     }
 
-    trace_acpi_gpe_ioport_readb(addr, val);
+    if (addr < ar->gpe.len / 2) {
+        trace_acpi_gpe_sts_ioport_readb(addr, val);
+    } else {
+        trace_acpi_gpe_en_ioport_readb(addr - (ar->gpe.len / 2), val);
+    }
 
     return val;
 }
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 159937ddb9..d387adfb0b 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -18,8 +18,10 @@ mhp_acpi_pc_dimm_deleted(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm deleted"
 mhp_acpi_pc_dimm_delete_failed(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm delete failed"
 
 # core.c
-acpi_gpe_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%" PRIx8
-acpi_gpe_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%" PRIx8
+acpi_gpe_sts_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%" PRIx8
+acpi_gpe_en_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%" PRIx8
+acpi_gpe_sts_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%" PRIx8
+acpi_gpe_en_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%" PRIx8
 
 # cpu.c
 cpuhp_acpi_invalid_idx_selected(uint32_t idx) "0x%"PRIx32
-- 
2.42.0


