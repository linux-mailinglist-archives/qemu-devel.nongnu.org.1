Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C8711354
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQS-00005d-8h; Thu, 25 May 2023 14:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQP-0008TO-EG
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:57 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQN-0005rF-Ln
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:57 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-53033a0b473so1364294a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038254; x=1687630254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+yUsbKoScoR37tEqHJpwp6atQ/4Z4oAuy6m32A5GM4=;
 b=Zbc2vaAwsmPV4bGiNBw6DMQespxAYcHW5mky08e1k990DvNzMLtBE1G3p3DHRX0thj
 1akq6aEmIrSbTDPqHHivXK1SxjkQ+iCt4b1NkNl/q36m/GtMTTw1YGaYoVnos7shBDHb
 6OJhPMVWzfw9MecHkhWMIlqsPMcStw1asJPXZYitJHofbIxtg7VJjMjpcHGhwP4u7dmi
 rMJdsS7VnnqpW41qqmD3y6ylFNrIQQIgFvCBFkG6ATpsOc8P9xatcxEDSa/1x0uUn1q9
 XQVKZyIWsMegU5xWY0mFpHcocFcP0ha833fmua82FvzAAKatknKzqhstnysP4UtatrXY
 p6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038254; x=1687630254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+yUsbKoScoR37tEqHJpwp6atQ/4Z4oAuy6m32A5GM4=;
 b=JpfxtgOJwkWaZdiV2F3Ksb0hL8dZ3FtqXvqzOT5F+Hh0205uHaiS0L8TkuZh9aOXpH
 QcLCSFg14J26x4WcGglXDsbYUMmyq3+bUHgUDL6agHZY1ZyYAX17MkWkVhhnI815Nok9
 w7k8HOkNiIfqvvFgWrrEnPY5xNcI689/7xEHkcHeXX9eR4+wf3ChGgTLyH7QPRtyCiWI
 JDR92WztXWEZmuQVo9olidsQcO9JeRrKkiPQoGMpfvtMZ8m3As2RfpgCpgX1VJ3cM19J
 1+JxakwETaDD8KLXhfJ4Enl/X0v3nPWjxOlCnwkxHZ2xVB+PLhZnHbOKh780HI2OBpd6
 xceA==
X-Gm-Message-State: AC+VfDznYl3ixmSoOk3p3PoJo8ui22Y0hi1S39wor68wRLyNGd8OY2TH
 aFo6eJRZEumunq4GSmavwHmK9AoWWRXXFpHzkZQ=
X-Google-Smtp-Source: ACHHUZ4MOQVB0YcS34HxUCHpIU71i0iv2359GK636X0eHDebunGcpY/GfIWKsB88z4aymoHoGRZ8Mg==
X-Received: by 2002:a17:902:d48e:b0:1af:f4f5:6fa3 with SMTP id
 c14-20020a170902d48e00b001aff4f56fa3mr2734890plg.55.1685038254388; 
 Thu, 25 May 2023 11:10:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 20/23] tcg/riscv: Support CPOP from Zbb
Date: Thu, 25 May 2023 11:10:33 -0700
Message-Id: <20230525181036.1559435-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     | 4 ++--
 tcg/riscv/tcg-target.c.inc | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 8e327afc3a..e0b23006c4 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -127,7 +127,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
-#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_ctpop_i32        have_zbb
 #define TCG_TARGET_HAS_brcond2          1
 #define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -161,7 +161,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
-#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_ctpop_i64        have_zbb
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index cb4afb4733..05ea9fead8 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1511,6 +1511,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_ctpop_i32:
+        tcg_out_opc_imm(s, OPC_CPOPW, a0, a1, 0);
+        break;
+    case INDEX_op_ctpop_i64:
+        tcg_out_opc_imm(s, OPC_CPOP, a0, a1, 0);
+        break;
+
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
                         const_args[4], const_args[5], false, true);
@@ -1637,6 +1644,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
+    case INDEX_op_ctpop_i32:
+    case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
-- 
2.34.1


