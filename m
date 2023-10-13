Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB5D7C8F0D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:30:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiR-0006ES-U0; Fri, 13 Oct 2023 17:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiP-0006DX-HO
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:01 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiN-0000S9-Ua
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:01 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso647017b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232538; x=1697837338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+GdCnSdgZMnPa1lP3cKEZTy8hU2+r8c83iJCBTZWNY=;
 b=esv1g5NXEbKuEYZe7PkEBEwVXfpobGdfsYDiHotWiirWm1fJ9SxiAovU86q0YB2MmP
 9is59uZIX4m48plPdQnkLxCFteHf3ZQ+yK1cJziDbi4PMoN/FdaVkoIWbYm+e6p2V6gk
 MAZTxMgurW4j2qnCfdSUgRS2jCvcmtxl0ylhXRrxmP4QtVasQdFf26XZNNyryWReT0FS
 oGHUtePfJpL0JVgDyiwsXpPui6mDs6f00Pl/jQCEWGs7gKRstSk9smRZ7VVOqyigq5X4
 CxCfskEPOf/3vuxZ1rsRE+Y7CVuxSZfena++twUN7nHNrXhKfbdOYIvUd75Rxqw0XJkO
 uRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232538; x=1697837338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+GdCnSdgZMnPa1lP3cKEZTy8hU2+r8c83iJCBTZWNY=;
 b=JM5OriBU19nF59Mu0yVIj81J55++IJkaV/I6xuzIrXDiReGjdorM+rut4NV1T9u8L5
 1u1lW0VD0NOncAPYs8MxAZ0FQ0y49NYlwQ9L6LMIuR9Dm4KyUctX2yuEtLOsLAjS9PBf
 iG+gxKC6mozhicjZH0fNB9E0Hx7wKTGYgDHEhKuDMw+AoQOSdtnhlLmFPTs7kpmH8UIC
 xq4WzFHA21zlWDGUgG+F9z2JAmZwK7+pI81mBHJufWFGUzRHjlm3YuQmufpT9+BDl3gP
 7IWZ8dYn542xcokmIsQkGy9CXG/bTN17sqBTTN5Sa+IE00lBc3LVfP5fmyrD7EieLJ+y
 k1YQ==
X-Gm-Message-State: AOJu0Yz4aNUWEYG/H0/J14qBxjPzBmCSEtdY752V2UG3wb4ZczZp+ACQ
 v03EuCaiLsvMK79NMb0MrEOeDrHkWmMRbDOFPxE=
X-Google-Smtp-Source: AGHT+IEE67J0gLtwerKcOsJjXYV0S8dJRTPvio6gbZ+X7gsBRWbsSL8txOElp1Bmu+OMCxYtXmLp0g==
X-Received: by 2002:a05:6300:8088:b0:172:83b8:67f7 with SMTP id
 ap8-20020a056300808800b0017283b867f7mr9778285pzc.44.1697232538321; 
 Fri, 13 Oct 2023 14:28:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 11/85] target/sparc: Merge gen_fcond with only caller
Date: Fri, 13 Oct 2023 14:27:32 -0700
Message-Id: <20231013212846.165724-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1ac3bdd03f..ecb485c305 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1265,19 +1265,6 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
     }
 }
 
-static void gen_fcond(TCGv r_dst, unsigned int cc, unsigned int cond)
-{
-    DisasCompare cmp;
-    gen_fcompare(&cmp, cc, cond);
-
-    /* The interface is to return a boolean in r_dst.  */
-    if (cmp.is_bool) {
-        tcg_gen_mov_tl(r_dst, cmp.c1);
-    } else {
-        tcg_gen_setcond_tl(cmp.cond, r_dst, cmp.c1, cmp.c2);
-    }
-}
-
 // Inverted logic
 static const TCGCond gen_tcg_cond_reg[8] = {
     TCG_COND_NEVER,  /* reserved */
@@ -2951,6 +2938,7 @@ TRANS(Bicc, ALL, do_bpcc, a)
 static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
 {
     target_long target = dc->pc + a->i * 4;
+    DisasCompare cmp;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
@@ -2965,7 +2953,13 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
         return advance_jump_uncond_always(dc, a->a, target);
     default:
         flush_cond(dc);
-        gen_fcond(cpu_cond, a->cc, a->cond);
+
+        gen_fcompare(&cmp, a->cc, a->cond);
+        if (cmp.is_bool) {
+            tcg_gen_mov_tl(cpu_cond, cmp.c1);
+        } else {
+            tcg_gen_setcond_tl(cmp.cond, cpu_cond, cmp.c1, cmp.c2);
+        }
         return advance_jump_cond(dc, a->a, target);
     }
 }
-- 
2.34.1


