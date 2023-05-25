Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6197771135A
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQW-0000Be-Ho; Thu, 25 May 2023 14:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQU-00008T-Lm
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:11:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQM-0005zJ-ST
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:11:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae3ed1b08eso16977345ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038253; x=1687630253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNuVE5/hYtEnyIruKa1nN0D/wZFDLkSC2ujquVv/MBE=;
 b=WgNCveAuDMeH+ZCblNaCfiYsdMjLdPerljTmhlXc471YglK8fEYXbsSV67JPDHE/ew
 ywKPDg1zg/lI9XWtyigCUHBckF1sIrvdBdH1dxvoxvHoaRToSCQGY+zSQZL2UoVZQctC
 vkGaHNQgzhUxlrRWHiQ93CAKUn3n8fKWj6Ydg7FQsQyysBlDeAty/L+mDqUwebbqv8Ba
 mbFWVKMHYc6eLrDRA3FewsUou2zxt355i1I0Eiy4B6CgJdIfs0snafecQAeVdBc9S9d5
 a/B9Eer3cRGORolrP+0MAihjDKibVhSpD4enQCY1qFG7G/Qsm0QuDxyg83nRSeu8OiWb
 ZuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038253; x=1687630253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNuVE5/hYtEnyIruKa1nN0D/wZFDLkSC2ujquVv/MBE=;
 b=DC81K6SIZst9YdzsyuOWKEmpAzABaUPrFR+gnGttlANtkuSXv3B1/o1ja01JGgqx9g
 iCSLUfuZRbhpfDI9DQfeXgwLVEgP+WtxMSk+eAC3cK6dOP1cBO3gqZZyZKEb8IMu8yES
 KRlHSTNZvaXxOXBYmZCdfEVubo3fT9P4vwflUlbKwW5RS8mq5E2+KOZKhIwodyKzlY6Y
 aA826VuqQIrnerOIvDw2nt3to5Rn4dam8Rvq5KCIHH97ohGjajIkquUC+Q80fYcNCQyc
 EV0WYZxNk/G/tY+PhWuxF/o9PuxFCs8z5xK/9Ucb9HAfKLA4viP0JnNENGSDg+uC5y3x
 DZUw==
X-Gm-Message-State: AC+VfDxx302Z8czxtuf0qd6Wd34WfXfWjVjl8HEYEvWFotgXxFrSLfqQ
 9lXQGXgIU2/+Fa1pInRgVyS+Pszep9TF7/doa+E=
X-Google-Smtp-Source: ACHHUZ49Go9U9ZmvFxCDJCBz+t2EiVs8uQk0EcCdwclb4M5lho4L+tYux5+DCCgz42qk1ZMS07pv0w==
X-Received: by 2002:a17:902:714c:b0:1aa:ee36:40a5 with SMTP id
 u12-20020a170902714c00b001aaee3640a5mr2297042plm.34.1685038253643; 
 Thu, 25 May 2023 11:10:53 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 19/23] tcg/riscv: Support REV8 from Zbb
Date: Thu, 25 May 2023 11:10:32 -0700
Message-Id: <20230525181036.1559435-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     | 10 +++++-----
 tcg/riscv/tcg-target.c.inc | 29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 317d385924..8e327afc3a 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -116,8 +116,8 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      0
-#define TCG_TARGET_HAS_bswap32_i32      0
+#define TCG_TARGET_HAS_bswap16_i32      have_zbb
+#define TCG_TARGET_HAS_bswap32_i32      have_zbb
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_andc_i32         have_zbb
@@ -149,9 +149,9 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      0
-#define TCG_TARGET_HAS_bswap32_i64      0
-#define TCG_TARGET_HAS_bswap64_i64      0
+#define TCG_TARGET_HAS_bswap16_i64      have_zbb
+#define TCG_TARGET_HAS_bswap32_i64      have_zbb
+#define TCG_TARGET_HAS_bswap64_i64      have_zbb
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_andc_i64         have_zbb
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index cc96425413..cb4afb4733 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1487,6 +1487,30 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_bswap64_i64:
+        tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
+        break;
+    case INDEX_op_bswap32_i32:
+        a2 = 0;
+        /* fall through */
+    case INDEX_op_bswap32_i64:
+        tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
+        if (a2 & TCG_BSWAP_OZ) {
+            tcg_out_opc_imm(s, OPC_SRLI, a0, a0, 32);
+        } else {
+            tcg_out_opc_imm(s, OPC_SRAI, a0, a0, 32);
+        }
+        break;
+    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap16_i32:
+        tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
+        if (a2 & TCG_BSWAP_OZ) {
+            tcg_out_opc_imm(s, OPC_SRLI, a0, a0, 48);
+        } else {
+            tcg_out_opc_imm(s, OPC_SRAI, a0, a0, 48);
+        }
+        break;
+
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
                         const_args[4], const_args[5], false, true);
@@ -1608,6 +1632,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap64_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
-- 
2.34.1


