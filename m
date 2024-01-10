Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D5F82A435
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:47:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhM0-0002VO-Ct; Wed, 10 Jan 2024 17:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLd-0001Cl-No
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:57 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLb-0003o9-Q0
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:57 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dbe69afb431so3938482276.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926814; x=1705531614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SG+rKuUVbaUxXp+EMRwo0KDiuCri6E6fV9fOpbonh9A=;
 b=HGkrDq4EnloOo6sjKM2CNrWf9LOTbA3o2esx0G+rJZ8G1EEJZnaDtw0XWj19SPXPHA
 FyGzTBqRMYrInpqVIzzvXgGj4FinG58+tLQZTiATqOEkD4GM1Af/kz4X+NsQsw/NN53s
 JCfmOdiVrr14cQWGkKiG2TiyjSBMQoc0dOI57cyC3XCQ5Vxftt3oD19FWTGuDCli0mh9
 KfxK5SHe1xhs2f8vQz3u7yb7FeKEXxOnZO2LutMNCGwVdcMWLpWnzW0UDmRgRq0xgW5+
 MIX4KNy228nZQJhXbewcmWSuD4rPA2tY87TAwgS9bMggyJQI9HQZsMuPmZKDyumkDCAL
 iFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926814; x=1705531614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SG+rKuUVbaUxXp+EMRwo0KDiuCri6E6fV9fOpbonh9A=;
 b=CapMDIse9WzCtvT+R9q2xsd7CIWs8YVrHSsoNB2Li+hRB+9i0YLc1yXl2gtEwy0qNc
 qK2FeqmCRBI6cRwxkNK2mYkqwpvsOL3yc8J6tXcsMPW4ztrtkaXa7h/yDdvRM1fwhWgr
 3LxYV3yRpG2whcsBGBIiArU00T4EmZTcxB9yvLSbe6d/fgi+ZrZg3lOuhj7934zcotp7
 oGl2Fpn3WQ9ss7n737OCn1Lk8dqyI1Oayu02Em05MBmfII944dX7Z1mwyvFiU7ynvInv
 y/Rn1rkXvEeHgzan90s1hI8QjeI8dwt5E9CmDGk5r6FsQMCNgv3ciatiS3TVY5+6ehKb
 OxNQ==
X-Gm-Message-State: AOJu0YxMNLDQ1FQ7SL8j1JDm9Ah2WiMu4fKLVs6nMc4T5/1FEt4b4MUP
 cFKT5jWXmpy3e3OfH4/f4DfUPZII/qPXMSdDy66aEReXXaDPRJ9F
X-Google-Smtp-Source: AGHT+IFulm/FA8wzkTiqpomjM7QkrneslTHkC+qvHOTefsVwJSohfczVhvUsR73JxGorGUexEtx+yQ==
X-Received: by 2002:a25:ac15:0:b0:dbc:ecba:70fe with SMTP id
 w21-20020a25ac15000000b00dbcecba70femr374693ybi.65.1704926814636; 
 Wed, 10 Jan 2024 14:46:54 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 35/38] tcg/s390x: Split constraint A into J+U
Date: Thu, 11 Jan 2024 09:44:05 +1100
Message-Id: <20240110224408.10444-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb33.google.com
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

Signed 33-bit == signed 32-bit + unsigned 32-bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |  8 ++++----
 tcg/s390x/tcg-target-con-str.h |  2 +-
 tcg/s390x/tcg-target.c.inc     | 36 +++++++++++++++++-----------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 9a42037499..665851d84a 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -15,7 +15,7 @@
 C_O0_I1(r)
 C_O0_I2(r, r)
 C_O0_I2(r, ri)
-C_O0_I2(r, rA)
+C_O0_I2(r, rJU)
 C_O0_I2(v, r)
 C_O0_I3(o, m, r)
 C_O1_I1(r, r)
@@ -27,7 +27,7 @@ C_O1_I2(r, 0, rI)
 C_O1_I2(r, 0, rJ)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
-C_O1_I2(r, r, rA)
+C_O1_I2(r, r, rJU)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rK)
@@ -39,10 +39,10 @@ C_O1_I2(v, v, r)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
 C_O1_I4(r, r, ri, rI, r)
-C_O1_I4(r, r, rA, rI, r)
+C_O1_I4(r, r, rJU, rI, r)
 C_O2_I1(o, m, r)
 C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
 C_O2_I3(o, m, 0, 1, r)
 C_N1_O1_I4(r, r, 0, 1, ri, r)
-C_N1_O1_I4(r, r, 0, 1, rA, r)
+C_N1_O1_I4(r, r, 0, 1, rJU, r)
diff --git a/tcg/s390x/tcg-target-con-str.h b/tcg/s390x/tcg-target-con-str.h
index 25675b449e..9d2cb775dc 100644
--- a/tcg/s390x/tcg-target-con-str.h
+++ b/tcg/s390x/tcg-target-con-str.h
@@ -16,10 +16,10 @@ REGS('o', 0xaaaa) /* odd numbered general regs */
  * Define constraint letters for constants:
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
-CONST('A', TCG_CT_CONST_S33)
 CONST('I', TCG_CT_CONST_S16)
 CONST('J', TCG_CT_CONST_S32)
 CONST('K', TCG_CT_CONST_P32)
 CONST('N', TCG_CT_CONST_INV)
 CONST('R', TCG_CT_CONST_INVRISBG)
+CONST('U', TCG_CT_CONST_U32)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 08fe00a392..a317ccd3a5 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -30,7 +30,7 @@
 
 #define TCG_CT_CONST_S16        (1 << 8)
 #define TCG_CT_CONST_S32        (1 << 9)
-#define TCG_CT_CONST_S33        (1 << 10)
+#define TCG_CT_CONST_U32        (1 << 10)
 #define TCG_CT_CONST_ZERO       (1 << 11)
 #define TCG_CT_CONST_P32        (1 << 12)
 #define TCG_CT_CONST_INV        (1 << 13)
@@ -542,22 +542,23 @@ static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
-        return 1;
+        return true;
     }
-
     if (type == TCG_TYPE_I32) {
         val = (int32_t)val;
     }
 
-    /* The following are mutually exclusive.  */
-    if (ct & TCG_CT_CONST_S16) {
-        return val == (int16_t)val;
-    } else if (ct & TCG_CT_CONST_S32) {
-        return val == (int32_t)val;
-    } else if (ct & TCG_CT_CONST_S33) {
-        return val >= -0xffffffffll && val <= 0xffffffffll;
-    } else if (ct & TCG_CT_CONST_ZERO) {
-        return val == 0;
+    if ((ct & TCG_CT_CONST_S32) && val == (int32_t)val) {
+        return true;
+    }
+    if ((ct & TCG_CT_CONST_U32) && val == (uint32_t)val) {
+        return true;
+    }
+    if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
+        return true;
+    }
+    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
+        return true;
     }
 
     if (ct & TCG_CT_CONST_INV) {
@@ -573,8 +574,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_INVRISBG) && risbg_mask(~val)) {
         return true;
     }
-
-    return 0;
+    return false;
 }
 
 /* Emit instructions according to the given instruction format.  */
@@ -3137,7 +3137,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rA);
+        return C_O1_I2(r, r, rJU);
 
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
@@ -3187,7 +3187,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_brcond_i32:
         return C_O0_I2(r, ri);
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rA);
+        return C_O0_I2(r, rJU);
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -3240,7 +3240,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_movcond_i32:
         return C_O1_I4(r, r, ri, rI, r);
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rA, rI, r);
+        return C_O1_I4(r, r, rJU, rI, r);
 
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
@@ -3259,7 +3259,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i64:
-        return C_N1_O1_I4(r, r, 0, 1, rA, r);
+        return C_N1_O1_I4(r, r, 0, 1, rJU, r);
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
-- 
2.34.1


