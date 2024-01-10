Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AC782A424
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:46:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhKj-0005i7-Te; Wed, 10 Jan 2024 17:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKO-0005CW-0A
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:45 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKM-0002zf-D6
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:39 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5f15a1052b3so43127777b3.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926737; x=1705531537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GS3d6Cpw6XkPNpi2NrfgOHaZo+XrWfNCNBnXScIVqj4=;
 b=CSuLkcffE1w0jEfbGW+l9lSjqdI4AYilwWYX4SqqKF9eyHUK3XxcNL9K2HWnQ47ma/
 uOeVhjOD+X3luj4j0VE0RBoEx3zOsKYusTi4VxxA5HUGgvK9+DFSE82KwF07mksHKH7E
 jrVgCKKPD5WMUKbGIRtx4OM/pzZXvPA1JgCKsHV+w5YR6z0ZKFDHGfjkub+Hac88GFpe
 3TD+kAOpo6TLBX63hjnsV18fOyRGTMSapXOcG6rAv+SZMT6aWUTLaeuLS3Gi7EcDdSXS
 m2F/LlEAAYa0a8tTYVJdS5Vrxk+w7q+oPTO8ej/XFw51rIdurTXbi6h2B1SbylwH2PFi
 WNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926737; x=1705531537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GS3d6Cpw6XkPNpi2NrfgOHaZo+XrWfNCNBnXScIVqj4=;
 b=EXV46sPnAJwQ0ScJ9PlkE5yZejOtQYQhooex1NYkdhypW4OFwiUQQAxxdAu6uwYVwr
 dDFJOKgvHwTluAEzRdWzWJ2jMLmryAvxMsFCb2qjCVvH4hfp8Bcu+El3/O6Y7nAckKEQ
 bhAwbICZV7rjFcND7lPuoy8IiPt2L5RN35hpnPct1+fCg+0h1W/SYQF8ypYyJqWMpksC
 w8M+Lc+hAj43OleyLs31URXO/QCsJ3oLMWd6RguFv+Yvfu62znIaAuPCTcrD39rSJz4k
 AYFm2hE03T4hpVgh9/ZEq6/fM/tvjWenH9cnVkHoGlZWAk7HOD6S3mYeaADR7/TH1Mh1
 7Obw==
X-Gm-Message-State: AOJu0YxjKKvhDRpnvaNsUiEG3AJCKua4jBV051y90nKDc6UeoOHCcHh+
 OpDsiEf2NmYT7nZfvZ7BUG3mxOXvR3TReUxJCg4OazbDskDivsjU
X-Google-Smtp-Source: AGHT+IFUPLhjOVNjtD+Jl2a+1SNTt63cDl0xmFHjrWu+S2KYxv6bhbYv/GkTgtd6QF0hdUVnCjEcDA==
X-Received: by 2002:a25:bdc3:0:b0:db7:dacf:3f9c with SMTP id
 g3-20020a25bdc3000000b00db7dacf3f9cmr307624ybk.73.1704926737416; 
 Wed, 10 Jan 2024 14:45:37 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 14/38] target/s390x: Use TCG_COND_TSTNE for CC_OP_{TM,ICM}
Date: Thu, 11 Jan 2024 09:43:44 +1100
Message-Id: <20240110224408.10444-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1133.google.com
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

These are all test-and-compare type instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 62ab2be8b1..ae4e7b27ec 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -754,10 +754,10 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
     case CC_OP_TM_64:
         switch (mask) {
         case 8:
-            cond = TCG_COND_EQ;
+            cond = TCG_COND_TSTEQ;
             break;
         case 4 | 2 | 1:
-            cond = TCG_COND_NE;
+            cond = TCG_COND_TSTNE;
             break;
         default:
             goto do_dynamic;
@@ -768,11 +768,11 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
     case CC_OP_ICM:
         switch (mask) {
         case 8:
-            cond = TCG_COND_EQ;
+            cond = TCG_COND_TSTEQ;
             break;
         case 4 | 2 | 1:
         case 4 | 2:
-            cond = TCG_COND_NE;
+            cond = TCG_COND_TSTNE;
             break;
         default:
             goto do_dynamic;
@@ -854,18 +854,14 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         c->u.s64.a = cc_dst;
         c->u.s64.b = tcg_constant_i64(0);
         break;
+
     case CC_OP_LTGT_64:
     case CC_OP_LTUGTU_64:
-        c->u.s64.a = cc_src;
-        c->u.s64.b = cc_dst;
-        break;
-
     case CC_OP_TM_32:
     case CC_OP_TM_64:
     case CC_OP_ICM:
-        c->u.s64.a = tcg_temp_new_i64();
-        c->u.s64.b = tcg_constant_i64(0);
-        tcg_gen_and_i64(c->u.s64.a, cc_src, cc_dst);
+        c->u.s64.a = cc_src;
+        c->u.s64.b = cc_dst;
         break;
 
     case CC_OP_ADDU:
-- 
2.34.1


