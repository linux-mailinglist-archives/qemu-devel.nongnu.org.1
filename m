Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A68EF82ACF4
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:09:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssi-0001c8-RT; Thu, 11 Jan 2024 06:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss6-0001Kt-UW
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:15 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss5-0004PC-2H
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:14 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3366e78d872so5439888f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971111; x=1705575911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oeCuiQBz7GI2Tnh0N3wKJtjrrHPQdjyFY69+nM/wilI=;
 b=xYUDu7ttRpqKdcq3zGrKmP3Uno/mykpbIc3M67Bwig0pquz6wgR/w9VX/XE5s9XGBQ
 3YaDoM2Yvuz0U3hygb5g7NVQIkD0FUB9mc5NFesVvwaObrn++mEJCrx/EJCo+6O55GHb
 VjZAt+JSZuihNHw+EfI8kztMpOhJgDX4dBQysBkVPTkGDFohbmzDmsbZnNy/TDMvBm8b
 is28vHsuJRVtu75nREjl5gQugHaUKOzwqiiGp2Ve6O5+4qv9jz2DWTHLpzF4q+uJHFux
 1+iYHaRz5C9NAU8n3COXcYDQ5iKuKDwWjzrXbJUwGl00y+AuvTBIO9cYbyjU7gFGmLcO
 l2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971111; x=1705575911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeCuiQBz7GI2Tnh0N3wKJtjrrHPQdjyFY69+nM/wilI=;
 b=Adx8WIh7MF+6hvGPPQqTDKp+4S7GbDSX8tn4+FD7sDLwJ63bpWklxPz+gQbQnIs1E7
 G4widuNj/gjc2Q2KOrBNdnN69QhUX0rXls5aDI81KYw6Nv3lHYwM5nVbfZPAjJU0brW+
 eEIHTcExfeaZP5J3RrRvfG3GzPfcfOaSnPEF2CaDTytuKKbkmBx+/9z0iv7zkWC1vdwI
 obDgwlnnqXen7u/fMlzv7KoZjiOgC+B3b7sS41A6/e1m7YwWJFrY2DtRV6vPuHtOf32Z
 m+TgdwatdY8CpcnVtrt/bHO32DfUbMAZxcG1PlXnW8vQDd3hVH6yUoUxPhU/94OMOqfW
 qPLA==
X-Gm-Message-State: AOJu0YzOW+HYPVHwgGVpOJnWMSDAQzdDNBvXY7bJknaH+J2Z2yadY1G6
 qggM+KKBgiDVeb9WtWXBSXyyO8eg0FzEsTZbbfuMpsJxiD4=
X-Google-Smtp-Source: AGHT+IHl/SsxfsJrGNLgH/rRuGDPWhDEul4vFYdpFGsHCAr/cyB3MZmyFulbnukQwn5M8/bMjzVX/g==
X-Received: by 2002:adf:e3c7:0:b0:337:427f:e993 with SMTP id
 k7-20020adfe3c7000000b00337427fe993mr309982wrm.85.1704971111005; 
 Thu, 11 Jan 2024 03:05:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/41] hw/intc/arm_gicv3_cpuif: handle LPIs in in the list
 registers
Date: Thu, 11 Jan 2024 11:04:33 +0000
Message-Id: <20240111110505.1563291-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

The hypervisor can deliver (virtual) LPIs to a guest by setting up a
list register to have an intid which is an LPI.  The GIC has to treat
these a little differently to standard interrupt IDs, because LPIs
have no Active state, and so the guest will only EOI them, it will
not also deactivate them.  So icv_eoir_write() must do two things:

 * if the LPI ID is not in any list register, we drop the
   priority but do not increment the EOI count
 * if the LPI ID is in a list register, we immediately deactivate
   it, regardless of the split-drop-and-deactivate control

This can be seen in the VirtualWriteEOIR0() and VirtualWriteEOIR1()
pseudocode in the GICv3 architecture specification.

Without this fix, potentially a hypervisor guest might stall because
LPIs get stuck in a bogus Active+Pending state.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 hw/intc/arm_gicv3_cpuif.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 77c2a6dd3b6..6ac90536402 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1434,16 +1434,25 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     idx = icv_find_active(cs, irq);
 
     if (idx < 0) {
-        /* No valid list register corresponding to EOI ID */
-        icv_increment_eoicount(cs);
+        /*
+         * No valid list register corresponding to EOI ID; if this is a vLPI
+         * not in the list regs then do nothing; otherwise increment EOI count
+         */
+        if (irq < GICV3_LPI_INTID_START) {
+            icv_increment_eoicount(cs);
+        }
     } else {
         uint64_t lr = cs->ich_lr_el2[idx];
         int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
         int lr_gprio = ich_lr_prio(lr) & icv_gprio_mask(cs, grp);
 
         if (thisgrp == grp && lr_gprio == dropprio) {
-            if (!icv_eoi_split(env, cs)) {
-                /* Priority drop and deactivate not split: deactivate irq now */
+            if (!icv_eoi_split(env, cs) || irq >= GICV3_LPI_INTID_START) {
+                /*
+                 * Priority drop and deactivate not split: deactivate irq now.
+                 * LPIs always get their active state cleared immediately
+                 * because no separate deactivate is expected.
+                 */
                 icv_deactivate_irq(cs, idx);
             }
         }
-- 
2.34.1


