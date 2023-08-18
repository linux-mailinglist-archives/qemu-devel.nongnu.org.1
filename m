Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E903678155B
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:18:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j5-000553-R3; Fri, 18 Aug 2023 18:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j3-00053g-CQ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:49 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j1-0004QL-58
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:49 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso11714225ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396826; x=1693001626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xk1+CqOJWdeIJliIlUjmMI38qlOB1/l73hqKwcbuPU=;
 b=Uz/9wao+QN6xeWY7DgKT813uvyuyTxRiRY8Um5R8HtizH1fgH6ZXlL8sYx2ZRrjjNm
 FU9ldiOXCaaYfLL6x68s6ceagb2SzhUghYgofJnc164acVlsb2G1Th2tv7sn6kyrvGUz
 gn99I0MwjCRAP1VQlPq8fgv2r3/WGd/x0M3+Dsu9Y4vCjClKi5o0YRZz62WJtxQjw1xX
 /OI1u6wEEErzxMWV45Dv71H4MUpydTV7XTq1hSnk4/B6wtlJif+l9NL4XjmvMSzv4KS/
 Kpgz754l07pq/yOGiPOtM81D1ozoegIAqiYPAeCYzsYMtF3ylW1cyYu+PM/lB+OKdyqI
 fE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396826; x=1693001626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9xk1+CqOJWdeIJliIlUjmMI38qlOB1/l73hqKwcbuPU=;
 b=Nlqnj6a1eMj7tKAl8R62BKoYx8iyvSaHr1+Ka7MquQuyPsjor5s9/XYenM3Zku8Hy0
 Kz7cDhv3zuKyVt693SkGMCGQp6rlLF6FPaH8geOHlP1B+6ndW+huhXPFEzoEwnR/6WCc
 vvZeQ+ndq/3yBUSTXK1asVLx0wqt9D0RW8nbpJf7TK2G6LZO/maYsScWgL37PtRrSsPU
 0FVF18Bv+twQ6we6LVkxpvsB2hWig23ymxNC+xhh3IC0+DcfehCjugIJsPItGJRyM4ZG
 dgPZzDF05reUlezGXJmRf/ieEcc2zEhwpgAwXTQbtWdAXv6RcKdjyrUoy/C3TMO5MoJ7
 ll3A==
X-Gm-Message-State: AOJu0YzES7krSr6nwnroK/DnDTZYNOWRqk5PB523C6usaIWr2gC7G8AG
 SaS39UoIty+VdtkSRnMeNn+Yty110x9+hj+DYuE=
X-Google-Smtp-Source: AGHT+IGUk7rY9hCq8XEsvOUUIyYSeUIbAUzzLW2d1/pF8W/Yvp2Vfk4BCn36b8j7NUPHu8dvNKaT2A==
X-Received: by 2002:a17:903:18e:b0:1b8:9461:6729 with SMTP id
 z14-20020a170903018e00b001b894616729mr645690plg.2.1692396825911; 
 Fri, 18 Aug 2023 15:13:45 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 20/23] tcg/i386: Use CMP+SBB in tcg_out_setcond
Date: Fri, 18 Aug 2023 15:13:24 -0700
Message-Id: <20230818221327.150194-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Use the carry bit to optimize some forms of setcond.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 1542afd94d..4d7b745a52 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1531,6 +1531,56 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGArg dest, TCGArg arg1, TCGArg arg2,
                             int const_arg2)
 {
+    bool inv = false;
+
+    switch (cond) {
+    case TCG_COND_NE:
+        inv = true;
+        /* fall through */
+    case TCG_COND_EQ:
+        /* If arg2 is 0, convert to LTU/GEU vs 1. */
+        if (const_arg2 && arg2 == 0) {
+            arg2 = 1;
+            goto do_ltu;
+        }
+        break;
+
+    case TCG_COND_LEU:
+        inv = true;
+        /* fall through */
+    case TCG_COND_GTU:
+        /* If arg2 is a register, swap for LTU/GEU. */
+        if (!const_arg2) {
+            TCGReg t = arg1;
+            arg1 = arg2;
+            arg2 = t;
+            goto do_ltu;
+        }
+        break;
+
+    case TCG_COND_GEU:
+        inv = true;
+        /* fall through */
+    case TCG_COND_LTU:
+    do_ltu:
+        /*
+         * Relying on the carry bit, use SBB to produce -1 if LTU, 0 if GEU.
+         * We can then use NEG or INC to produce the desired result.
+         * This is always smaller than the SETCC expansion.
+         */
+        tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
+        tgen_arithr(s, ARITH_SBB, dest, dest);              /* T:-1 F:0 */
+        if (inv) {
+            tgen_arithi(s, ARITH_ADD, dest, 1, 0);          /* T:0  F:1 */
+        } else {
+            tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_NEG, dest);  /* T:1  F:0 */
+        }
+        return;
+
+    default:
+        break;
+    }
+
     tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
     tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
     tcg_out_ext8u(s, dest, dest);
-- 
2.34.1


