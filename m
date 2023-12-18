Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6B9816C83
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:39:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBs3-0006Yh-BE; Mon, 18 Dec 2023 06:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs1-0006X9-DI
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:13 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBrx-0003HD-SR
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:13 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50bf3efe2cbso2997593e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899188; x=1703503988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6tSWrfVlNJNsGkpqxISW8yYbk7W8USGKLzGliHCM/4s=;
 b=WC5OpdR4aPtpOmMUvbopND0cXOONZ/4HcW1QPy9d67AAZssK9uul4B5xgnDXN0W8h3
 ylApyJNv9WxhEKgA2VpZCjINyG1WDl+PQ7GHEF+Mmvde8033xiAOVDdyG9elbpmKdnq4
 QWmhNwGAsqf2cMcFBMOwYZaaBGxTE+/aELqr7F9yBtLN1Gl1VwXplPNMYk7mmvuFGXXY
 +o7yuwijxhNURjsPj0LE1iwYZqrssvJQOBMtDiZhzTG6nZtcWZ9q+9CtNV4cSqv81lWR
 IJFwhnEvg1z2WwbKT04kwZzj68IdLcqmLFbr+/Z/lzUvK2Uv9zqEyOpFxEyLz8q6Yyzq
 /9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899188; x=1703503988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tSWrfVlNJNsGkpqxISW8yYbk7W8USGKLzGliHCM/4s=;
 b=sLaCZCsY0dH7aeiOXEWvYwOKUbb8K9sFd4lZr9kYVGVcZny7WI9eMUS71UsEmHOh9N
 imx0zfNPVfBbdfz6idQKDMABbHXP+/h9sW7Kx9YS2Wlpm1WSEbGjEQqytqg63zCO9veI
 0N8Fj832mUs4TmMmBN1GY2RQcBdG2z6sktkkyHw6lylFyVeOeIO68pQTk37iaYByEtAs
 eBWwolGUMpoUpnsLtui7sltwyvrrAFqoG9XCsrHep4PNbycBUgl/nUrA0Wo7y/pgfnbE
 oINfrbNEZv1xtTyH3DVhW82te5J3lAp+uN7YLPAKLR4B1F5SUS1g/52e7KdpVflnbevR
 w4GQ==
X-Gm-Message-State: AOJu0YwNK5i5PHNtyAgdQcXrZ8sE1gfFg1bHXhZmIwjO+NhkqawMG7uo
 2HxYhR06nPoJF/IbPcnZbUufpA==
X-Google-Smtp-Source: AGHT+IEvL9pDY1u7SQaEML7UriSi3ztcT93muF8e4W7+BaZaKtSWWHa39jPd0GXUioAzjsBG9IkraQ==
X-Received: by 2002:a05:6512:693:b0:50b:ee49:9b42 with SMTP id
 t19-20020a056512069300b0050bee499b42mr4874376lfe.43.1702899188164; 
 Mon, 18 Dec 2023 03:33:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/35] hw/intc/arm_gicv3_cpuif: handle LPIs in in the list
 registers
Date: Mon, 18 Dec 2023 11:32:33 +0000
Message-Id: <20231218113305.2511480-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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
---
Weirdly, I only saw this being a problem when the hypervisor guest
was an EL2-enabled one under my FEAT_NV/FEAT_NV2 implementation.
But there's nothing FEAT_NV specific about the bug.
---
 hw/intc/arm_gicv3_cpuif.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index ab1a00508e6..258dee1b808 100644
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


