Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC8B7D217C
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:14:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRa1-0000Sk-O0; Sun, 22 Oct 2023 02:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZq-0008Pn-R3
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:42 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZo-0002DT-PW
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:42 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-581cb88f645so1448477eaf.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954679; x=1698559479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydcqatW2bnzMrZaY8ZtfzySXSm+HsAl/9hXJ+Ym7/Lw=;
 b=LpYZsbNIbapWzDa89k6chXIoD+PvXqfSKhM1Vm/H8b+SdopKjVxVD/7zrvtAbsCMxg
 euWHyThmw2ldVeHzQFRdIKKTk+FUsJ/tOwQkCgSKxSQrMnEJR+0ErQoL3BZaXxnNIfz8
 QhVGkthfy2D1w/SioJWX7VtZ/vOPR8K1MmFAZPt1RZDNZfJNhZcDG5Qtxz1Z15jKvC0+
 hZxdxTSbatGcXBcwIs9YPUued7g605a/b0uGeUBpTin3kiyNXhIpK1rLNYtsaBTQsKg3
 0OdtkrwNzWFgkkY1oRI/rKhq1lipnMR0gz1HG0Gx6NQgAyzQ24R9AaN4b4Vpz5KnVndn
 v3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954679; x=1698559479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydcqatW2bnzMrZaY8ZtfzySXSm+HsAl/9hXJ+Ym7/Lw=;
 b=LkLwjc1nX2pKBhpqFd9mM2KWRze9sjSSFVNIzrI7mcXwNYxCUcDt3vCeipR+05s7e7
 9J3yIdpLFUAmlcoGWzN/dRbL4FvTqhaZmcUJYtSOcyJQ3t2EafPG3U3S5CAWxMNDBA8i
 x55jqLHmxprl9Hsi/YzvkOI2wLjjiO7Gpf76VBtVzdZWEasEkKczvDimb4dsOjinoI+X
 9VgqjYipDpKpuY7ZfHOXTi0FTbb0r61hKU1JRHUup2/v0uRb4XR1v1192khi2WXBchtn
 NcNwsL2CvS4M1Kx7XG+veiH9WRcgRkuZ0DyH8cZ4dhnviLpA0XlDkxd14qAcY0AqW9XY
 Ezqw==
X-Gm-Message-State: AOJu0YzRH3Z+HqxfvcQN2b9uJNoTuCCY9ORifi/r4ehqHDjmTztNVVon
 yGj0/iH9Nqw7X817O/6Btxy3j4L6KDVWnbWr4H8=
X-Google-Smtp-Source: AGHT+IEP3XlOnc0WPPIlO8uzLrovJqtocf5Fsoj8Ccoi9a1Wrp/hglyqW9FaxRbPNfJcQMZWt62A5w==
X-Received: by 2002:a05:6358:2822:b0:14f:6a41:5d14 with SMTP id
 k34-20020a056358282200b0014f6a415d14mr7107075rwb.27.1697954679298; 
 Sat, 21 Oct 2023 23:04:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 44/90] target/sparc: Split out resolve_asi
Date: Sat, 21 Oct 2023 22:59:45 -0700
Message-Id: <20231022060031.490251-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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
index 48e69389e5..9b1bd97947 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1906,15 +1906,25 @@ typedef struct {
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
@@ -1957,7 +1967,7 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
         type = GET_ASI_EXCP;
     }
 #else
-    if (IS_IMM) {
+    if (asi < 0) {
         asi = dc->asi;
     }
     /* With v9, all asis below 0x80 are privileged.  */
@@ -2116,9 +2126,16 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
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


