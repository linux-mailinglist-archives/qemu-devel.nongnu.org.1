Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 045307CBAFD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNj-0002rm-Sf; Tue, 17 Oct 2023 02:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNR-0002Tf-VZ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNQ-0004fc-79
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:25 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1640762b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523382; x=1698128182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmNAKobzs1tBTX3N5VeSlsY1hTDzbAPwToQ6SBu8p38=;
 b=UyeCm1jJ7eF/Qg/R1c9cOVuaZBX1+S70HWZJiSEpeiOpBtRciblfxiNqeMGvBjiQWb
 BhBHIhYRggDm/CGlKRZQ2N8xOhJjUJ4ipe7eyctE0yXH8zpSAkaFG0QGfNUaFZlR1Qh0
 qzc7k/LNOmmrrAz67yzD3z9hNBmeTQv0rSAl9pSvMr2DX0COoMZwq2MMN4BVlfM17yWJ
 lHGC9ztU5F1DwPl4tpIK73QPGEm1Y0h1RRl2XFEo7P87CW7xgrWU1iG3/EKNdrZ1l+tC
 3+s4DkZoC4Cf5t09f8jVBUo7lqajcKipNlyEH2b0q5ypDiI/BXJqwLZHIwn4xJaXC8zd
 Cu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523382; x=1698128182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmNAKobzs1tBTX3N5VeSlsY1hTDzbAPwToQ6SBu8p38=;
 b=Df6OQ7u9/EiHwjSb6Eh0RqGRp53u99H/NMLZrQnkK+OLDXDLWkx8S0TGWoVAyOozpW
 /1Yi3jZq5Y7n18d9fQh+FWP8qxBLXfr3m8uAw0fQiEkTUzbuzB51cu2h3RXIhjmGURfB
 qFIdYtySzHlGsexN1YT57W04bB2NYNcdFupCsaohpBds/fX8e1sikupGL93MbmjQAMC6
 F8DuMylwYfe7BB7P2LRde5XDqmZ1B4nC+w5IEe8Cp+NJ5m9roF5myu3U3e9Fv3qJAFNs
 9dcejPTIul9APZ9qojD4tph/ZrJ1G6/q0uogUhz3I8wEuMjEOrW5SUNGagu9R0Yojfkd
 DMoA==
X-Gm-Message-State: AOJu0Yzu/WejBvar1QqbgkLx5wZRpxe/UFQopVgGa3bbhaRPixtyfaX3
 d+f9vMdv1+mwXnbGt0nYe7fFIoz2OekLtKsiAGk=
X-Google-Smtp-Source: AGHT+IG9Zz9HYjcMxHKBvN3c/vksFD9/6eKsfMK8spnvPJkQGu/7BcCHkO5Puv19Wf8QoyM0AKP5PA==
X-Received: by 2002:a05:6a00:290f:b0:68f:c1e0:a2c4 with SMTP id
 cg15-20020a056a00290f00b0068fc1e0a2c4mr1549061pfb.3.1697523382537; 
 Mon, 16 Oct 2023 23:16:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 44/90] target/sparc: Split out resolve_asi
Date: Mon, 16 Oct 2023 23:11:58 -0700
Message-Id: <20231017061244.681584-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 784a019dcf..1d3bfb724e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1864,15 +1864,25 @@ typedef struct {
     MemOp memop;
 } DisasASI;
 
-static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
+/*
+ * Build DisasASI.
+ * For asi == -1, treat as non-asi.
+ * For ask == -2, treat as immediate offset (v8 error, v9 %asi).
+ */
+static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
 {
-    int asi = GET_FIELD(insn, 19, 26);
     ASIType type = GET_ASI_HELPER;
     int mem_idx = dc->mem_idx;
 
+    if (asi == -1) {
+        /* Artificial "non-asi" case. */
+        type = GET_ASI_DIRECT;
+        goto done;
+    }
+
 #ifndef TARGET_SPARC64
     /* Before v9, all asis are immediate and privileged.  */
-    if (IS_IMM) {
+    if (asi < 0) {
         gen_exception(dc, TT_ILL_INSN);
         type = GET_ASI_EXCP;
     } else if (supervisor(dc)
@@ -1915,7 +1925,7 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
         type = GET_ASI_EXCP;
     }
 #else
-    if (IS_IMM) {
+    if (asi < 0) {
         asi = dc->asi;
     }
     /* With v9, all asis below 0x80 are privileged.  */
@@ -2074,9 +2084,16 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
     }
 #endif
 
+ done:
     return (DisasASI){ type, asi, mem_idx, memop };
 }
 
+static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
+{
+    int asi = IS_IMM ? -2 : GET_FIELD(insn, 19, 26);
+    return resolve_asi(dc, asi, memop);
+}
+
 static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
                        int insn, MemOp memop)
 {
-- 
2.34.1


