Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3641778CA20
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:04:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb27L-0002dw-KZ; Tue, 29 Aug 2023 13:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb27B-0002Th-4C
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:02:53 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb276-000525-N8
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:02:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso27116625ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328565; x=1693933365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aHirIWaDFAatgvDo4fYP79xIs5dz8DP+SlTM+t8FRU4=;
 b=Xo5IKTWHbHm9Zjk6fGreRtx4nQnxS98zt/IIIRsYXhzS447PbsjGMa3JaRe1WSNiOu
 +KBxqwvPvbn292Gi2DDmcZG9dIqUVUbEyz9QWeZ4qpszS9b5YJ9Koq5DnbkbxplPPMsb
 F+NytoHLrLv5QA1QmAkDQmIfGtDJPhaPepDJlPY0EeIuJxF5dO//9OVl+zUlmA2cWBnf
 MjJGIbthVrf5tn35M894ojMPSLuEPiZOf7IyfJq6LPbCtZA06LBiUekyjdSvXykVF4on
 jZDmcFE1ra4ddeO3Anm0oDtwjBz+JpjWN1DR7dtoUGic2ijlgHAbRb2DoejDF/Ve71xr
 gEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328565; x=1693933365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aHirIWaDFAatgvDo4fYP79xIs5dz8DP+SlTM+t8FRU4=;
 b=Tm3HSKGHut9Au5NEcGOBLvuJ1BKOBvdnC2plqhNEF0X6fd8uRrIIlwhYHzSKTO2vIx
 kIXRD204g7ztRTwP4A0dUq/1CR5MlwgDNvfZ3mPC7wIdY+09akMZq8vNM/0UfSMhtpQ5
 CDRKXDdX/oLr8qEYXViXBECGKMBbza0gma4aOzwrLo/PFcxuCHUg7L+hWl9wfS1B+dbI
 kf8KHCDlbVsInY3gSqQJ750p+2q80JuztKXwNy12ndV5qX1bf+dkz0vlOzSHnhwzexOY
 PDeYSSCoUjwr4tAY7MfjeUji/33We1MiXvrAgNgehF3X85BbrraiDj77l+jKmNUAuQ+C
 pSgw==
X-Gm-Message-State: AOJu0Yze7W9vZogkM5I2FX3szIWpjm/wyujC9HbVX0Qr/TQ/IXZ6NOIa
 Aqdzb5rbz8JBTa3BsH0h7OeEM76RMYBTPl/ag8k=
X-Google-Smtp-Source: AGHT+IHvDK7Tw2OZ+eK0uv6DDqioTME8yAzizJJwcJw+wqK8c2o+vFalFlw6+Z4MQdb1OhGgdTeWag==
X-Received: by 2002:a17:90a:ca16:b0:263:fc45:4091 with SMTP id
 x22-20020a17090aca1600b00263fc454091mr22281687pjt.15.1693328564937; 
 Tue, 29 Aug 2023 10:02:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 cv2-20020a17090afd0200b00267b7c5d232sm10989645pjb.48.2023.08.29.10.02.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 10:02:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32
Date: Tue, 29 Aug 2023 10:02:40 -0700
Message-Id: <20230829170240.765996-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829170240.765996-1-richard.henderson@linaro.org>
References: <20230829170240.765996-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Since a59a29312660 ("tcg/sparc64: Remove sparc32plus constraints")
we no longer distinguish registers with 32 vs 64 bits.
Therefore we can remove support for the backend-specific
type change opcodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.h     |  2 +-
 tcg/sparc64/tcg-target.c.inc | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 3d41c9659b..5cfc4b4679 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -115,7 +115,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_extr_i64_i32     1
+#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_rot_i64          0
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index f2a346a1bd..81a08bb6c5 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -529,11 +529,6 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
     tcg_out_ext32u(s, rd, rs);
 }
 
-static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
-{
-    tcg_out_mov(s, TCG_TYPE_I32, rd, rs);
-}
-
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
 {
     return false;
@@ -1444,9 +1439,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_divu_i64:
         c = ARITH_UDIVX;
         goto gen_arith;
-    case INDEX_op_extrh_i64_i32:
-        tcg_out_arithi(s, a0, a1, 32, SHIFT_SRLX);
-        break;
 
     case INDEX_op_brcond_i64:
         tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
@@ -1501,7 +1493,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
@@ -1533,8 +1524,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_extrl_i64_i32:
-    case INDEX_op_extrh_i64_i32:
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
     case INDEX_op_qemu_ld_a32_i64:
-- 
2.34.1


