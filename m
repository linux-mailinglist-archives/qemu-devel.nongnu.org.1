Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE7582A43D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:48:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLU-0008P2-Lg; Wed, 10 Jan 2024 17:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLI-00073i-KO
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:36 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLG-0003Vd-5s
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:35 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-427e55a172bso31676561cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926793; x=1705531593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7nkcnvR7yCW819cN0Z1TIqZ24aA0LLfk5m6dHETDfI=;
 b=MkjhyO09ZUxeIt5xe8bRl8Ew8h/ojQ5fd10BMTx+0GIteKd5jPInzsdUSkEdQLQ7D5
 OPnXZVsu0npI9O7fhyuWk7TDF6NJdn95N9Kg7UZb+dGrlNQKEsPg9EDjtCHBpEgfanQa
 Ngy2m+wxqeHGwZwnUN07ofkNB2XhrJbKHtny1M3o37LlYg1VQurv10ot0wz20t/sCjOE
 3AKjFATTNkAp7YKLMdA/w8woq8yrWyYJcyZGrdXBkRjnL5GDl9ejJyYBhqIGQVnX2Fbz
 w/DgujUzTaR81yYtY+AfWsyz3nDIE0NNAsrJNIq+7guRgKIRHsbIR8gPCwb4gI1ARaOX
 ektg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926793; x=1705531593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7nkcnvR7yCW819cN0Z1TIqZ24aA0LLfk5m6dHETDfI=;
 b=QuhtGxAs5zk425oAPhaWPuZJZ2FblFZe+Ee8O7SLFEbQCBOj3BSDXoeOHfLs6tx0+p
 nZ6Q6ZW7U5kQMEdhXJhqIyXihveF52i+MI1+DaWf83up1mhwX2ihAh8t2uJzAtCjZ9yD
 oASlNvWUqCAmq3/qfRZ20YAV7VlDVbCMUvQXBv0jdn+6kKPvg8168YpKvi/OqrmnnC2T
 qj4rfJAAy7QqUM0pNOYj70WdjolnOJ6xC2Q78YGxJBHnHjfGcaNHqJ7+eb1AX9lghZBM
 /i9y0FkmyAVbPSd/2aLHD3zZaEWAFL0Ud0q5LqeFipAaGGXSBgE03+CrtQpXoGclyep+
 UE1g==
X-Gm-Message-State: AOJu0YyxL3rARZAMTavId2wssWIuHQJy6bllKix6wfJ4qGdlcpSA1XuL
 oY+O6MrJtSWpXjOz2J0CZA9Jjh1+COvY0HnP+X+CtmnIkoCpLHKk
X-Google-Smtp-Source: AGHT+IHLIvpZpl4haxvEpMA6/Gh0QVJq1bG5KwVrjiH3pdO4/ZC2E2htljRXo3fhoNuW7zVw3Bp59Q==
X-Received: by 2002:a05:622a:301:b0:429:a565:8df9 with SMTP id
 q1-20020a05622a030100b00429a5658df9mr291761qtw.61.1704926793059; 
 Wed, 10 Jan 2024 14:46:33 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 29/38] tcg/sparc64: Support TCG_COND_TST{EQ,NE}
Date: Thu, 11 Jan 2024 09:43:59 +1100
Message-Id: <20240110224408.10444-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.h     |  2 +-
 tcg/sparc64/tcg-target.c.inc | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index ae2910c4ee..a18906a14e 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -149,7 +149,7 @@ extern bool use_vis3_instructions;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 #define TCG_AREG0 TCG_REG_I0
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 10fb8a1a0d..176c98740b 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -607,9 +607,11 @@ static void tcg_out_div32(TCGContext *s, TCGReg rd, TCGReg rs1,
                    uns ? ARITH_UDIV : ARITH_SDIV);
 }
 
-static const uint8_t tcg_cond_to_bcond[] = {
+static const uint8_t tcg_cond_to_bcond[16] = {
     [TCG_COND_EQ] = COND_E,
     [TCG_COND_NE] = COND_NE,
+    [TCG_COND_TSTEQ] = COND_E,
+    [TCG_COND_TSTNE] = COND_NE,
     [TCG_COND_LT] = COND_L,
     [TCG_COND_GE] = COND_GE,
     [TCG_COND_LE] = COND_LE,
@@ -649,7 +651,8 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
 static void tcg_out_cmp(TCGContext *s, TCGCond cond,
                         TCGReg c1, int32_t c2, int c2const)
 {
-    tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const, ARITH_SUBCC);
+    tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const,
+                   is_tst_cond(cond) ? ARITH_ANDCC : ARITH_SUBCC);
 }
 
 static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
@@ -744,6 +747,15 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
         cond = (cond == TCG_COND_EQ ? TCG_COND_GEU : TCG_COND_LTU);
 	break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        /* Transform to inequality vs zero.  */
+        tcg_out_arithc(s, TCG_REG_T1, c1, c2, c2const, ARITH_AND);
+        c1 = TCG_REG_G0;
+        c2 = TCG_REG_T1, c2const = 0;
+        cond = (cond == TCG_COND_TSTEQ ? TCG_COND_GEU : TCG_COND_LTU);
+	break;
+
     case TCG_COND_GTU:
     case TCG_COND_LEU:
         /* If we don't need to load a constant into a register, we can
-- 
2.34.1


