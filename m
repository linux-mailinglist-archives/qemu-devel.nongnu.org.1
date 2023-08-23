Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E1A78618E
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOj-0000K1-8f; Wed, 23 Aug 2023 16:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOZ-0008PS-3S
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0005Vb-Q1
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:01 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-689f9576babso4160826b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822231; x=1693427031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAmE7joGqyZttz+k7cOjgHhj0sK9IgQhYb7Z62glHBk=;
 b=LCAOwYVSEVsGCo2LtvV0ekOk91L2vse2eCuoZ697lMoj706DPL90QGWoi66/t31UXL
 uP8PKAGzuS0R6fPQMd2G3rGeTnmBP8SisqotqD0GmD41dpdz0zounxKyfOF1ayTipXBd
 7sqHT9G2WMz3P+CHTfD3vu+cnofv4s6uPilGXb6ljy2T4MPNRjtZgOVZlqLG73G/jQ2A
 k/c4GEf9dgM+VbUKmopu2PkpIEg9qQjVqTCrerYrct/uNGzuoxfnm4HPQi59dA/Xhkjd
 JXM0iGBxj240SxYAN5ZAZqZ0GPUZHrErnzUovjE95MNo9jBYJ+KUoyzAMAwY7k1dT4+t
 TtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822231; x=1693427031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAmE7joGqyZttz+k7cOjgHhj0sK9IgQhYb7Z62glHBk=;
 b=iJZse+bUaHwBhTh01LbSoZuXO3lRPpXLh2gtt5+BClnVLg7p0S8WIuK07veIKINgrO
 /Ff/04p6UMwtKGt2GDXvy8RaCPnELp0FUFlw+Ir6fwb4Jr7RImOQ6RuBjIbilwsTJ635
 NoVaA67V3CT6QenNI1g7CrbtV96OmuFPVeDVtmX2dVhuaEJ6tuh5oy0enVDncX9SG7qF
 dIWPN0BC6xrDfcVtO8569514ffplWDROUVmEIXkK6acagR0yO1xEEWXkkcTvLUlAjLPl
 SdZP33XYlHPhKesZS57itLGC422QnUNHGdRvAm3Vmqc0JOjPYEwQIvaV1tkrXnqTnEYp
 8RrA==
X-Gm-Message-State: AOJu0YychQikLWMuu9MeOdYRIHCb0BmvPPD734FP5TeTJmBuoz3PVeOV
 4IPBCm6ZYUXSkCc5DGk2IFFBMbMMCzUnhKWwM3M=
X-Google-Smtp-Source: AGHT+IGCQpRFSpLPXiq73BfYuJY/rtgmLvcPq+v17dkvsCziQLb0ADOB2mb9ARofBxwfc+2GLGibyA==
X-Received: by 2002:a05:6a20:7da2:b0:141:cc5f:7d28 with SMTP id
 v34-20020a056a207da200b00141cc5f7d28mr13742096pzj.50.1692822231677; 
 Wed, 23 Aug 2023 13:23:51 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 26/48] tcg/ppc: Use the Set Boolean Extension
Date: Wed, 23 Aug 2023 13:23:04 -0700
Message-Id: <20230823202326.1353645-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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


