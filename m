Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B546279D32C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg40z-0008FC-QM; Tue, 12 Sep 2023 10:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40a-000871-8v
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:04:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40N-0003pb-Nm
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:04:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31f915c3c42so3143133f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694527476; x=1695132276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AZ7z+PF4zRsdie2W5wNUk9pY8AcE3Vlvunka/Km+EXQ=;
 b=k50PTPYcziYiy1SUZB5An8TkPyoepEGaY393+MoDPpqFBdqJYoUQSA4/N+NPmF9oe/
 c8w1hNbVPBmhF1iTKSl4AfwT+a+2RpiTcVHMi6YRTQuXs3WpPnyi+aAsHIqlxXqW3kPq
 b6e75/GSrgRnMYb4dTmM0/n+N2AxWwEJ0OyLXq3eBc1ChlPDkg+F5ziRvDmLYpsbJCz2
 guQ4ZXs94jmFRWtAGXZAH4PILfJSqlAf7FR6ESO/duPWRhxjLb0LWVEmjZdsefRYfT3e
 5g0vP+/Qd7UzFR+USe+TF2fWvOEcjy4bvf54J3IcIFWQVPD2dkZc864bKpw00LC1tSBH
 PA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527476; x=1695132276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZ7z+PF4zRsdie2W5wNUk9pY8AcE3Vlvunka/Km+EXQ=;
 b=JIfWWZ6KTCT0ALs7Oz9pbl3FQAwFKVIty9Up462084mXnPpW9ogRdq7l782D46i8z2
 sMx+tK0jANi2dhOmomuDwi7PxshDTNffmZ6oGM2k950BeYJS5ZAUm3JO77SIVQqco4mJ
 3Elc8NL4m3wbx4P1ze3ivaaYzsXDidarqB7dTBtcK4SmTFrEqrE6DShgAqF6KpOHW6P/
 11ZW4tl/yU9RGr+CszompLyVGF2mpe6rB+tt62sR3r0Y+FYg4w90+SHoSQr4DjSVqeZW
 efYbCaQqM26ijgOiUz33GpiDovQvnUzv9fVEE+OLjKhL5MwRIgS+l0+s+g+7tFEiyxTa
 Xbkg==
X-Gm-Message-State: AOJu0Yysi/QUWcwYjvl8kltXGytdqLJh5E0AyX2sEymEaVhwS2fDoCcZ
 5snKVCvENB/efDMc2BHmqJSl/w==
X-Google-Smtp-Source: AGHT+IEFo5heK34NHC3SLa+QX2Z2Ys7xTlfTeLqCfCL6UsXoBp+NY493yUZTmbhDjJiDjn31KyPuFg==
X-Received: by 2002:a5d:5103:0:b0:315:8f4f:81b8 with SMTP id
 s3-20020a5d5103000000b003158f4f81b8mr10928695wrt.50.1694527476476; 
 Tue, 12 Sep 2023 07:04:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm12892672wrq.49.2023.09.12.07.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 07:04:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/12] target/arm: Don't skip MTE checks for LDRT/STRT at
 EL0
Date: Tue, 12 Sep 2023 15:04:23 +0100
Message-Id: <20230912140434.1333369-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912140434.1333369-1-peter.maydell@linaro.org>
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


