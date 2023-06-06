Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 000C2723E76
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:54:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIx-0007oB-Cd; Tue, 06 Jun 2023 05:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIn-0007hY-38
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0004mT-OJ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30ae5f2ac94so5882569f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044906; x=1688636906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HeyPIlJBU41xwRproCRZH7VzcIv4RCxHTYjGAE3AhzA=;
 b=pknT3G4riY9EIFy1vUzE0sI176mdsw24wtiXZ9I6cnp2NxzmY5Mu0gDWP0CubYhpmz
 3N71x4uS/fhPzu4anIkQQyuTG1nPtHo9VS3Dei0XMQdvHINMKhmpeSNKwowPw3AU9Haq
 Z67LoQ0lliD5O9WD/bnA2YLUphE+70A+uCFvfu7bhsNPxr0sOnuvItOdkl7J6lLjDLqU
 oHYSuIxBOF09P9nF/ZnO6zicPqc/GigXyQmgiYe5TeWZ5TdXW2ZnO8GSMIEF0g1k48fH
 SWt2uTsVpCDcqPuMD0b907Vd8hjk3bByCIXr45toeFjSUHJ41VBJe2rhEfZleQBKU0if
 jxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044906; x=1688636906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HeyPIlJBU41xwRproCRZH7VzcIv4RCxHTYjGAE3AhzA=;
 b=R70Hw5zbOHgQ+Qgk8fRG+pY/RdrEELFwU2CkD5jB8A/ILrK/UcEiC+DH12jLkf60UD
 +4EX6HKi+3KRm1//QibbTmEu9MypUxGYJCH2H/BZBAspR0HOReaKSXPK4H6FIOy39gPP
 IViROSin7Z+bh13XMASNCpkCw2hEwOhEdEvv4QRosQ/bBcolmkUL4XcoNI1YYBGHg4x+
 Pv3wfaVaoZhY3/bX/V2Zco+YHeZX0opMdjIIwPyZLsq0n3Zh7cIeU0cuqjBN7GPttfeV
 kqvrLLdDzh268sIluJ0rsYmlOCdAWJiH7qkak0yqoH43G5rAv71gz68wJ7vl3b2S7FOf
 T4+w==
X-Gm-Message-State: AC+VfDyVP1sq1SouMuaVHtzOw83UaqR7eFHfXLB188Dh0UKNZ+R7nvRs
 Ja7lnZDj0mrCDkQRQyjz/j1hfxIi0O3NgnWwAkQ=
X-Google-Smtp-Source: ACHHUZ7mrB+2gbhTftOneGO7YxCVPIZxrNlnxzOQx6HEOUoUKon8AxV/gb3ShG+P1bys6fCcwwwwxQ==
X-Received: by 2002:a05:6000:1972:b0:301:8551:446a with SMTP id
 da18-20020a056000197200b003018551446amr1614578wrb.2.1686044905934; 
 Tue, 06 Jun 2023 02:48:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/42] target/arm: Add commentary for CPUARMState.exclusive_high
Date: Tue,  6 Jun 2023 10:47:52 +0100
Message-Id: <20230606094814.3581397-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Document the meaning of exclusive_high in a big-endian context,
and why we can't change it now.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d469a2637b3..81c0df9c259 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -677,8 +677,16 @@ typedef struct CPUArchState {
         uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
         uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
     } vfp;
+
     uint64_t exclusive_addr;
     uint64_t exclusive_val;
+    /*
+     * Contains the 'val' for the second 64-bit register of LDXP, which comes
+     * from the higher address, not the high part of a complete 128-bit value.
+     * In some ways it might be more convenient to record the exclusive value
+     * as the low and high halves of a 128 bit data value, but the current
+     * semantics of these fields are baked into the migration format.
+     */
     uint64_t exclusive_high;
 
     /* iwMMXt coprocessor state.  */
-- 
2.34.1


