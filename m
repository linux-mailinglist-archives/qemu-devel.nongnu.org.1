Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A75D78EB01
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:48:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBM-0003rQ-E1; Thu, 31 Aug 2023 06:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB7-0003ZY-HJ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB3-00044O-GL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401d24f1f27so6410015e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478728; x=1694083528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QhVdc3OQbrieoN9KEVVJ4cHPM40QA7TFXVC/nD97cgo=;
 b=UGtXE3VU5X0nm5b0Ax1H1ZU+ztX2WIbCpKlHXstWtNo8aadh+Y86dn2r/lGsbVW+Ac
 2g9+8pa8koz7B6bD79+Cz5aa6718k/pI/ym02flbEZLj3sAfrnkS/XMoP/cVjxtDXdan
 2yxe7qfknHKiNtKt5v4Uu4u15PgeqrkPQa1Edt+xqW+zH9/Sub3WNHscml0VbMZcYeVO
 cKpN7S0QthAPMBLhVYJ2WO8Ykx4fyEFx7t/TkjM4NJLt+tFnKuNG3tUBzgQaPTFi2TS5
 eJMTypLTtN+x5t1GH+hrQLyHzMsrtO03Wt4ziBdXhMg1Fc8oy8G4wvUXZQiGZLRwNJJ7
 VkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478728; x=1694083528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhVdc3OQbrieoN9KEVVJ4cHPM40QA7TFXVC/nD97cgo=;
 b=ViXxsLZxYeVPvVOFyc9+VoNW/bEUHSepC0OB7xs2CE7YUuYNUOZ0W94NtcDmIpMsiu
 PJTj4BblD69P2XEw9XZRpZAsbU2v5W5MJw+rPzHXDy87JItqhzORQdHPHR2P/piPQ+wH
 hiQ2CfoVUaBg7cnwoTK/XzkLkL9UKd8J2uppjZyZ2r6eM7I9qlC+iIKztZ1XcU+f6vI3
 1WmNCwXZfaKDQHgguP+dH97SGpak31e6PIrZ/bERi9AVk33E8hvrwOj0/wzp+4mOczSR
 d+VcYCZ4MGEiXQI4qdxcnHsx4NujmAgfPfARCl5X6m5u61MjH9PS1HL0cO3TgzsC1oWi
 O57A==
X-Gm-Message-State: AOJu0YwcDBNbptlIKaGsXnQEyYl1UE9BONa3x1yUK9WNYfzuQcRTW1pb
 hn5d5DICA8+NhQkpeDb7M1sLFQziU1SZd3KD6Ag=
X-Google-Smtp-Source: AGHT+IGqegNlSD4UQa4Ou5EKDEFVl02gFXk7Im51sg9NFmdkbUkcx5jGECNkrs+Evss5d3ch2qsUgg==
X-Received: by 2002:a05:600c:cb:b0:3f9:b430:199b with SMTP id
 u11-20020a05600c00cb00b003f9b430199bmr3853750wmm.15.1693478727863; 
 Thu, 31 Aug 2023 03:45:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/24] target/arm: Catch illegal-exception-return from EL3 with
 bad NSE/NS
Date: Thu, 31 Aug 2023 11:45:12 +0100
Message-Id: <20230831104519.3520658-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The architecture requires (R_TYTWB) that an attempt to return from EL3
when SCR_EL3.{NSE,NS} are {1,0} is an illegal exception return. (This
enforces that the CPU can't ever be executing below EL3 with the
NSE,NS bits indicating an invalid security state.)

We were missing this check; add it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807150618.101357-1-peter.maydell@linaro.org
---
 target/arm/tcg/helper-a64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 1c9370f07bd..0cf56f6dc44 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -780,6 +780,15 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         spsr &= ~PSTATE_SS;
     }
 
+    /*
+     * FEAT_RME forbids return from EL3 with an invalid security state.
+     * We don't need an explicit check for FEAT_RME here because we enforce
+     * in scr_write() that you can't set the NSE bit without it.
+     */
+    if (cur_el == 3 && (env->cp15.scr_el3 & (SCR_NS | SCR_NSE)) == SCR_NSE) {
+        goto illegal_return;
+    }
+
     new_el = el_from_spsr(spsr);
     if (new_el == -1) {
         goto illegal_return;
-- 
2.34.1


