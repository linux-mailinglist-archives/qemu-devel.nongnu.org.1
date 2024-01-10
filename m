Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FAC82A443
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:52:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLM-0007Mh-5O; Wed, 10 Jan 2024 17:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKu-0006Oz-LV
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:16 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKr-0003Fa-Pv
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:12 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4299e43a712so15455071cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926768; x=1705531568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIn73/7L0/UvLzTpfBg1BsspTF3e93L6IUnQvuIa2EY=;
 b=Xp+KOfokdo8TOxX9F5RBZY7ktjN79N37LrQ3L9G7qUBVsFhwzhEkbOEXMxMc4WMTDE
 PjGQ46s2yNnv5EiFMc7I2cCxp49akRj4nzt3mBMoFuogtZg+fme6SkDVaNWGoPKiCpEn
 bxIb6KZ+UZPNh5caQQtGUvQ3KJzZC/nkq6ZWtKfHS3aSEg4qrYTtPtmfo8I322s/aK5I
 4x1K12C41gE1zoc95moICDU6E3eS5FgBCGcdJCbm47A/YuraG7GVAunm3950cvSLP6i9
 QO7cTDnytI2Hqid1Xem9RavqM6dGKmzJJcLBVxHC+Mf1zWgL1mCAvrLzQlt7YXRAAnfW
 qGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926768; x=1705531568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIn73/7L0/UvLzTpfBg1BsspTF3e93L6IUnQvuIa2EY=;
 b=iD3h8oAX9oXn0JJChYGEpeLto6fO7+TPdIQ4OB63QxUHUjqCxI/uZQV2KbH7HSNYkA
 inMVvlnMNHxfIgv8st+30s+v1+qFwIXGyiZtKf/8kzAcd/bTRZFwDxp3wLh2YDeqJERG
 Vn2mKIbf9AsVhNw+JAIFiIgO7pp0W9a4AbDRN2zsKkql1o8JJln7NpH/FREqGZqVyXSA
 KwzEk2W3JzHetT+xjVNW0c2I7divw/rx0oeAR7rXSy8UgR4wGRovHX36NHISz9tn3myd
 EsYXt0vGcWREcKvRYcXIsG7+5C7vEGQU6pBtQncMCmdb/gocyEvw1OcLydq+F19yAQta
 Ty8g==
X-Gm-Message-State: AOJu0YzoZjYAsfO0QpsgwNOXw4Mc3qrNTKCX+ZPgE8vjCJ9xKjDwhDjr
 NuoiRZlWffYS3V4zxX+4GJ09pc5uPDVBpvsw2TVOnD/PUeojCqe4
X-Google-Smtp-Source: AGHT+IHHmeRFlmwYeKkEBykUNVSUDiRQ3CtjOcaZcqtGgr/IrQnBM+VLLX7aqWNmMIhHsv781bjbYg==
X-Received: by 2002:ac8:7f01:0:b0:429:bbf2:14bd with SMTP id
 f1-20020ac87f01000000b00429bbf214bdmr308764qtk.102.1704926768272; 
 Wed, 10 Jan 2024 14:46:08 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 22/38] tcg/i386: Pass x86 condition codes to tcg_out_cmov
Date: Thu, 11 Jan 2024 09:43:52 +1100
Message-Id: <20240110224408.10444-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82f.google.com
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

Hoist the tcg_cond_to_jcc index outside the function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index accaaa2660..2d6100a8f4 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1699,14 +1699,14 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 }
 #endif
 
-static void tcg_out_cmov(TCGContext *s, TCGCond cond, int rexw,
+static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
                          TCGReg dest, TCGReg v1)
 {
     if (have_cmov) {
-        tcg_out_modrm(s, OPC_CMOVCC | tcg_cond_to_jcc[cond] | rexw, dest, v1);
+        tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
     } else {
         TCGLabel *over = gen_new_label();
-        tcg_out_jxx(s, tcg_cond_to_jcc[tcg_invert_cond(cond)], over, 1);
+        tcg_out_jxx(s, jcc ^ 1, over, 1);
         tcg_out_mov(s, TCG_TYPE_I32, dest, v1);
         tcg_out_label(s, over);
     }
@@ -1717,7 +1717,7 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGReg v1)
 {
     tcg_out_cmp(s, c1, c2, const_c2, rexw);
-    tcg_out_cmov(s, cond, rexw, dest, v1);
+    tcg_out_cmov(s, tcg_cond_to_jcc[cond], rexw, dest, v1);
 }
 
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
@@ -1729,12 +1729,12 @@ static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
         }
     } else {
         tcg_debug_assert(dest != arg2);
         tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
     }
 }
 
@@ -1747,7 +1747,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
         }
     } else {
         tcg_debug_assert(!const_a2);
@@ -1760,7 +1760,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
 
         /* Since we have destroyed the flags from BSR, we have to re-test.  */
         tcg_out_cmp(s, arg1, 0, 1, rexw);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
     }
 }
 
-- 
2.34.1


