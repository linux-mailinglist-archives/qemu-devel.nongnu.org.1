Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA69FC9B2
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Dec 2024 09:25:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQjA0-0007sW-4f; Thu, 26 Dec 2024 03:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hhJtZwgKCqEXVIBPUTIHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9j-0007Yn-Kq
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:44 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hhJtZwgKCqEXVIBPUTIHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9f-0000aG-C8
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:41 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-21640607349so107953845ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201415; x=1735806215; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mSqBtRF4XTytwLiQf1Tk6i2T92wgV1efOniSzvWdnQk=;
 b=P8Mu1agRco17Kl3kP4k08yolLZSTorz7qnm1/JZvmKr2mWnzyH0QA3pkXBkvzVROed
 ajlDy+ql9YTPQpUL7pdTSCfiAvbrtdV5+ncTqRDECHJMfeHlBDTg9vZt+TJmVxVvvwCX
 kauZlSBLUq0ION+KQoMrczGCHlntSEuyz+I09X+HvdE3w5OrC+6bUVDudju3jGb5zTdz
 SQJytnDVK1jzZ+YUlGGFa7+1//SboyRENq2uPLoODHT/45tbCw8ZprpMHPgHJj+PH5GQ
 2QL0wN27/bLfvHFBWJEoN/nO7NDnLpufd/4UcxcqkNUOyF+WoJ55yyrRNNxiwD985GHq
 Vgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201415; x=1735806215;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mSqBtRF4XTytwLiQf1Tk6i2T92wgV1efOniSzvWdnQk=;
 b=TX5yJFcIgP9i7e5l42zhpxvaRy+lNKIeLSKPBBZ4itmSd8KE+rIl+2Uv3JjmqRsMSI
 rVZTzvrGyANlNwNojOR+U5B9t+EInz3KUX59yCF7i8RGcUi8QcZ6q2Pk7fUOx1h8Tfkw
 LRcQSIG1T4LzbVTqSCIccA8xaf/i0q3pfVNQajYQkUwLjc4YkMfQbfQwzw+XGmlPB/WE
 wWOha0vJTu4uVHPJQ+LA+xZ2vzdp6SO2znxJ5NA19IEecZrqMPWfKnnl+RLaLl0pH/ry
 1Z9fJw8MVkbrvCFLyCiHnIYd7NPWfQ4eBmATJHlZYSEZdi/UxuO8EHiF127LTktrU8co
 jKXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3oLO5/Qx2TMLbQc8eO8RPjvjy22qpQPW7pUDdczIwNiJR6FGgGUtEjuicQ5Qy5GgNIQOMceFk/lD+@nongnu.org
X-Gm-Message-State: AOJu0YzX/wCIdlmhwxkO2IdbXcOoP/rAU3tiBe8JCJq/ZR5KC8QkLcqT
 aD98QHW58t7ydcUcuAwnorF8bx9/Hxqb02Jy02BB5BzGXILaq6wjOzX0F77vbxL3duVaIfThJ3D
 VlGbtYXW/kg==
X-Google-Smtp-Source: AGHT+IF5PkHeQ8xGGfFzyZMFceR151l4CxZTr+gzSl498iRRm8V5NvsKEB1Ji5mJatl+6/Jh4TGJOZGw0wRTOQ==
X-Received: from pgnp25.prod.google.com ([2002:a63:7f59:0:b0:7fd:4e21:2f56])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2449:b0:215:3a42:dc17 with SMTP id
 d9443c01a7336-219e6e8bbabmr280278025ad.7.1735201414765; 
 Thu, 26 Dec 2024 00:23:34 -0800 (PST)
Date: Thu, 26 Dec 2024 08:22:32 +0000
In-Reply-To: <20241226082236.2884287-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082236.2884287-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082236.2884287-14-wuhaotsh@google.com>
Subject: [PATCH 13/17] hw/misc: Add nr_regs and cold_reset_values to NPCM CLK
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3hhJtZwgKCqEXVIBPUTIHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

These 2 values are different between NPCM7XX and NPCM8XX
CLKs. So we add them to the class and assign different values
to them.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_clk.c         | 17 +++++++++++------
 include/hw/misc/npcm_clk.h |  9 ++++++++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index 0ecf0df3bb..eee754d31f 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -81,7 +81,7 @@ enum NPCM7xxCLKRegisters {
  * All are loaded on power-up reset. CLKENx and SWRSTR should also be loaded on
  * core domain reset, but this reset type is not yet supported by QEMU.
  */
-static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
+static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
     [NPCM7XX_CLK_CLKEN1]        = 0xffffffff,
     [NPCM7XX_CLK_CLKSEL]        = 0x004aaaaa,
     [NPCM7XX_CLK_CLKDIV1]       = 0x5413f855,
@@ -728,10 +728,11 @@ static uint64_t npcm_clk_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMCLKState *s = opaque;
+    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
     int64_t now_ns;
     uint32_t value = 0;
 
-    if (reg >= NPCM7XX_CLK_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -776,11 +777,12 @@ static void npcm_clk_write(void *opaque, hwaddr offset,
 {
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMCLKState *s = opaque;
+    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
     uint32_t value = v;
 
     trace_npcm_clk_write(offset, value);
 
-    if (reg >= NPCM7XX_CLK_NR_REGS) {
+    if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
                       __func__, offset);
@@ -870,10 +872,9 @@ static const struct MemoryRegionOps npcm_clk_ops = {
 static void npcm_clk_enter_reset(Object *obj, ResetType type)
 {
     NPCMCLKState *s = NPCM_CLK(obj);
+    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
 
-    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
-
-    memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
+    memcpy(s->regs, c->cold_reset_values, sizeof(s->regs));
     s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     npcm7xx_clk_update_all_clocks(s);
     /*
@@ -1045,11 +1046,14 @@ static void npcm_clk_class_init(ObjectClass *klass, void *data)
 
 static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
 {
+    NPCMCLKClass *c = NPCM_CLK_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END > NPCM_CLK_MAX_NR_REGS);
     QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END != NPCM7XX_CLK_NR_REGS);
     dc->desc = "NPCM7xx Clock Control Registers";
+    c->nr_regs = NPCM7XX_CLK_NR_REGS;
+    c->cold_reset_values = npcm7xx_cold_reset_values;
 }
 
 static const TypeInfo npcm7xx_clk_pll_info = {
@@ -1081,6 +1085,7 @@ static const TypeInfo npcm_clk_info = {
     .parent             = TYPE_SYS_BUS_DEVICE,
     .instance_size      = sizeof(NPCMCLKState),
     .instance_init      = npcm_clk_init,
+    .class_size         = sizeof(NPCMCLKClass),
     .class_init         = npcm_clk_class_init,
     .abstract           = true,
 };
diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
index db03b46a52..f47614ac8d 100644
--- a/include/hw/misc/npcm_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -175,8 +175,15 @@ struct NPCMCLKState {
     Clock *clkref;
 };
 
+typedef struct NPCMCLKClass {
+    SysBusDeviceClass parent;
+
+    size_t nr_regs;
+    const uint32_t *cold_reset_values;
+} NPCMCLKClass;
+
 #define TYPE_NPCM_CLK "npcm-clk"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCMCLKState, NPCM_CLK)
+OBJECT_DECLARE_TYPE(NPCMCLKState, NPCMCLKClass, NPCM_CLK)
 #define TYPE_NPCM7XX_CLK "npcm7xx-clk"
 
 #endif /* NPCM_CLK_H */
-- 
2.47.1.613.gc27f4b7a9f-goog


