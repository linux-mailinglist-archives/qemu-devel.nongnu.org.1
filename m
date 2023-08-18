Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C478154E
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7ix-0004zf-WD; Fri, 18 Aug 2023 18:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iw-0004yk-0C
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:42 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7it-0004OK-QK
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso10960465ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396818; x=1693001618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAmE7joGqyZttz+k7cOjgHhj0sK9IgQhYb7Z62glHBk=;
 b=DhznKj1MDVG/9D33tZM9CzF4qKkmV2mQixZJIIEZ4ZorYoJdJp3wH30UmktTL0Y6cd
 T6brpst0rIRXYtFfL98/YBMniGL8bjQJw55V5s6GCSlJc+IalavyVvZPpIVrBJBrDu6I
 +TXLY0qNCMeWw1VgFy7opnKHiqnZ64byhjKw0xeazIk9Z+diIMQcs7BuFvRniNps7RWT
 EDorgrOdK33LsHT+k1HpnSPffk2gd68qa1Wn3Pg8QputV38cKPUxwZ73PF4x8W3wfFnG
 j6TYYxx3c+eLStEYX2QoVKTkr+TBRDU81HpJxlmlquc9iGkERLTPC8tE/JKB1Y2qVSCK
 ROnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396818; x=1693001618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAmE7joGqyZttz+k7cOjgHhj0sK9IgQhYb7Z62glHBk=;
 b=YkKd5MA85/o2heE48oz/NdPsFdNjnag25mlxvo0ZtWw/ysa7oAOImhV7PlV07v+VWd
 gB42M1CRNRlreEuMJYVw1LesNYagrmXnR6jEDnS1x/6sIaiFuTJIGuh2QIGZJ+GdgOZ8
 IJNdr1rux8aQh1VtKnSrxqZxSz2GmInIHrAV6QG7QgG7+ar1u8GLKfpeA5TTMF2dPz2E
 I+puqjeyHXCOnWla+bcuDMKrdnIiLKZ3P/8k+/6qMqDCpt1hayiaUtv3C1lj+RjPg25L
 6/KhbHCmstZGBsC1QJ8IiWI+zwaURMXABOQCB07RSzj/+ztmD0vSvJH+X87uPheFxYvX
 FEXw==
X-Gm-Message-State: AOJu0YwaJW3nmu18vop4Ph7gnaFqdVsLh7Zq5UHhtxDQoJ0V/G+UIk9y
 9jxgZh3FjjMWw68FhMPqDNdYTuljkg03WydjQjw=
X-Google-Smtp-Source: AGHT+IGF1JXLUrXAruRbEcCvs89Pq4Wk3LVTzWOjJqtwijY8vfBQE1UKPVOmoLOZjus/YT0Rf8pDJw==
X-Received: by 2002:a17:903:4283:b0:1bf:4859:53df with SMTP id
 ju3-20020a170903428300b001bf485953dfmr497591plb.0.1692396818604; 
 Fri, 18 Aug 2023 15:13:38 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v2 11/23] tcg/ppc: Use the Set Boolean Extension
Date: Fri, 18 Aug 2023 15:13:15 -0700
Message-Id: <20230818221327.150194-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

The SETBC family of instructions requires exactly two insns for
all comparisions, saving 0-3 insns per (neg)setcond.

Tested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 10448aa0e6..090f11e71c 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -447,6 +447,11 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 #define TW     XO31( 4)
 #define TRAP   (TW | TO(31))
 
+#define SETBC    XO31(384)  /* v3.10 */
+#define SETBCR   XO31(416)  /* v3.10 */
+#define SETNBC   XO31(448)  /* v3.10 */
+#define SETNBCR  XO31(480)  /* v3.10 */
+
 #define NOP    ORI  /* ori 0,0,0 */
 
 #define LVX        XO31(103)
@@ -1624,6 +1629,23 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
         arg2 = (uint32_t)arg2;
     }
 
+    /* With SETBC/SETBCR, we can always implement with 2 insns. */
+    if (have_isa_3_10) {
+        tcg_insn_unit bi, opc;
+
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
+
+        /* Re-use tcg_to_bc for BI and BO_COND_{TRUE,FALSE}. */
+        bi = tcg_to_bc[cond] & (0x1f << 16);
+        if (tcg_to_bc[cond] & BO(8)) {
+            opc = neg ? SETNBC : SETBC;
+        } else {
+            opc = neg ? SETNBCR : SETBCR;
+        }
+        tcg_out32(s, opc | RT(arg0) | bi);
+        return;
+    }
+
     /* Handle common and trivial cases before handling anything else.  */
     if (arg2 == 0) {
         switch (cond) {
-- 
2.34.1


