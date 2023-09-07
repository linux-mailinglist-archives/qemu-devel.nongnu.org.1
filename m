Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AB6797642
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:05:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHTz-0000pM-EX; Thu, 07 Sep 2023 12:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTx-0000mT-3e
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:49 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTt-0001zW-6M
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31f615afa52so1213246f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102623; x=1694707423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pr9z6x8cZyDAxlgtwSk5bQrpw1Jw2YIgz6/gNj+f09U=;
 b=I/tU/eNG+yKCNorhD4hpCtvCxdUVAljBBSEBprh3QcCLudehgPb8IwoTtUrpoQmLOw
 CXzP0gtJMCXWQYKzXowzbfJ/hzQXYZHKqMnu1RGeVkxKElWWovVkS7pooRuxnr6s8imu
 JFlzsNP/cPKnl/p96Y0Pym5C+LB8dOuM1l8+az7eN1aSCxwpBVrGYNB765tpcvTswMxb
 Vp8LSOZ3rPm6oFVys+nIq+Mqe69aMOXisECwCi1aLURDS3RkIQOTdGSKcL+uCWDIr0jK
 NJFW06RrsLCS8+nxbKvPgq3oE28yLQAlE0AANmnTPRZco9V6A4n8l6RXikwW+4iiVSEi
 Kc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102623; x=1694707423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pr9z6x8cZyDAxlgtwSk5bQrpw1Jw2YIgz6/gNj+f09U=;
 b=hJ3r6ilfSBvWa+VpBKOX2n3Bstaqggg4mHdLd7dTOuMGpxv2lIDWwuFhOHGPSWhY1o
 hbzvvMTmOWyMbRS7OiJhR3zQAE5+4WXBKFPFUcu3+qjyLhhOe1E9apbdKVaEujpyqdlN
 AMGtIbbvAjwx+U5zAfIbWxrNmKvHfuTHOoMgUkPPh4xEd30lSe1PM/5Eh4ug/de63EB3
 IprGmn/PX/n2CSJwXc9N6/ifpbHiTurYtvgDB28Oy5Eucx/czFVxhXLqkbYJhIsZ+CPx
 w7ndZAHVQxnl3xGOtFmJ8v9EMkJOslXmzWLHHOn15OKz+n0T7hqf6uKzr0DsxFJ/u2KM
 xzKA==
X-Gm-Message-State: AOJu0Ywahajef7SPV5CDe4ff3nlAJQ0lzWmSqXFG7Bqr6jZF2aOwxCPV
 fcBvFOOxyD2IjklmYf2RICcc3w==
X-Google-Smtp-Source: AGHT+IGILO2/thvnQdfZ8fvKD9n4aqsYh0Vy+ZUC1RwV18aZZvWVU05zWZIo1gGQcgjtVx8U7gpcEQ==
X-Received: by 2002:a5d:4ed2:0:b0:315:8a80:329e with SMTP id
 s18-20020a5d4ed2000000b003158a80329emr5302728wrv.40.1694102623485; 
 Thu, 07 Sep 2023 09:03:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/14] target/arm: Don't skip MTE checks for LDRT/STRT at EL0
Date: Thu,  7 Sep 2023 17:03:28 +0100
Message-Id: <20230907160340.260094-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The LDRT/STRT "unprivileged load/store" instructions behave like
normal ones if executed at EL0. We handle this correctly for
the load/store semantics, but get the MTE checking wrong.

We always look at s->mte_active[is_unpriv] to see whether we should
be doing MTE checks, but in hflags.c when we set the TB flags that
will be used to fill the mte_active[] array we only set the
MTE0_ACTIVE bit if UNPRIV is true (i.e.  we are not at EL0).

This means that a LDRT at EL0 will see s->mte_active[1] as 0,
and will not do MTE checks even when MTE is enabled.

To avoid the translate-time code having to do an explicit check on
s->unpriv to see if it is OK to index into the mte_active[] array,
duplicate MTE_ACTIVE into MTE0_ACTIVE when UNPRIV is false.

(This isn't a very serious bug because generally nobody executes
LDRT/STRT at EL0, because they have no use there.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/hflags.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 616c5fa7237..ea642384f5a 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -306,6 +306,15 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                 && !(env->pstate & PSTATE_TCO)
                 && (sctlr & (el == 0 ? SCTLR_TCF0 : SCTLR_TCF))) {
                 DP_TBFLAG_A64(flags, MTE_ACTIVE, 1);
+                if (!EX_TBFLAG_A64(flags, UNPRIV)) {
+                    /*
+                     * In non-unpriv contexts (eg EL0), unpriv load/stores
+                     * act like normal ones; duplicate the MTE info to
+                     * avoid translate-a64.c having to check UNPRIV to see
+                     * whether it is OK to index into MTE_ACTIVE[].
+                     */
+                    DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
+                }
             }
         }
         /* And again for unprivileged accesses, if required.  */
-- 
2.34.1


