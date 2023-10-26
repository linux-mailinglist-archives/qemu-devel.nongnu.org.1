Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A203D7D79B4
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6r-0002H4-TU; Wed, 25 Oct 2023 20:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6M-0001Sx-At
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6I-0006ue-5l
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so2254675ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279587; x=1698884387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVBY1LYgLUlwFA05aut9PR71PO2vl5OwkfiJRqeU+Ek=;
 b=HeRqIjo3R6K476jX+K7LQSjwv/vPFdZbYViQAEkLgIZWNOmflW0SSFlgW0/oZFRsKw
 H7U3PgpItS3VYgz1KkRXrlCNdwbmja0JXppxz7KMS0NVY3W8Fx4lBZSAAujfGiPlzPJC
 oIO2wIrrb3IL0Rzm9jimVMkPy9bzfpm6uIG2A92FZk51oIdVl1waeta/5s8vnPwHKwlf
 XkDAcM2jZNytZKKMmZpMpmP27IZJ/Mehfi/GNvtBpuQtZZJLqnd5DLW6azQxcMWoNPb+
 TVq9xOzhM7/T79ygG1N5hq1O5MswWgt5Kz7WCpOFbhj9fulIwFN457cFPwRfxOR4TfY7
 nWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279587; x=1698884387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aVBY1LYgLUlwFA05aut9PR71PO2vl5OwkfiJRqeU+Ek=;
 b=U3vjsmEogRsiTVF1Y2tJQrbAc2sqSr7f1LgqtWQZa3wFCWYg5yJJcKyg7HvVMF1Ebf
 th+qlmbjR1S6NZ1zsyVpKXnBir1gTS8R2y8zQbVaEFcN7QQSJECn4IXmE5zVIyCMV8Z2
 Q53JoCJUjt/ZQNH+9/7Mqr2Bza/BPkKmXo3jeyZLRxzgiCHC5tcMzAJUWT5nRiD29DGN
 JDnynf50/Unl6i7D/acBrC99zwm+NlqJGKGufsqSjs07hFN2cRG6dKVwuM/bx93AplN7
 HAPplrzMXKFpurdL7xIyDT1NGvu1Us8cXQmf276GW35X2eqjTOpJD5nrwl+4A/IJUTVJ
 CQbQ==
X-Gm-Message-State: AOJu0YxqCOmXogZGCPbUSqVWB2Fz4EioZws3EyhuzUX0Bz3prkrg5SbK
 bq8CJWmzc8RGYOQZAq+7VGTWvIz3cwVR1a4RDbA=
X-Google-Smtp-Source: AGHT+IEjRjB+/GEyHjKP4T11BSzENiGmrL+2fSjWa/xHNVMEBRLrBV6fQc+zzNawJTfBXTKk3B+DyA==
X-Received: by 2002:a17:903:2642:b0:1ca:7439:f74f with SMTP id
 je2-20020a170903264200b001ca7439f74fmr16448865plb.60.1698279587656; 
 Wed, 25 Oct 2023 17:19:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 48/94] target/sparc: Split out resolve_asi
Date: Wed, 25 Oct 2023 17:14:56 -0700
Message-Id: <20231026001542.1141412-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8faf2c59b2..6c1610486e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1919,15 +1919,25 @@ typedef struct {
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
@@ -1970,7 +1980,7 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
         type = GET_ASI_EXCP;
     }
 #else
-    if (IS_IMM) {
+    if (asi < 0) {
         asi = dc->asi;
     }
     /* With v9, all asis below 0x80 are privileged.  */
@@ -2129,9 +2139,16 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
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


