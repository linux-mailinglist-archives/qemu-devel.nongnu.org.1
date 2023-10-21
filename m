Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BB7D1AFF
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eP-0002en-7H; Sat, 21 Oct 2023 01:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eC-0002CQ-Bb
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:40 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4e9-00015E-JQ
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:40 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1e0ee4e777bso1082436fac.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866536; x=1698471336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqcfeNJ9wzGAGV7oxUL/7nZeKmkczdhN3f+SdC8Dc8c=;
 b=UTl6KukJjtirXIvslns2KHu/ThbgHTARIxrkpJT4vX2APojqQOzCT5+RIxUqrw0odF
 OZbxZ5Djz/uPyXE5jRTzlkrJIvyfL6/cnRYzZZUzgfbIOGb+w6JP5oqi9lmr/PrcrwTW
 VmC+5CdJCuYHLWP7Ev4GwdOLcOxPoSh9pGpdR7aCo++ZzvkJ/1AByvroC5HnHwskqXfV
 cgoDjXMx0N8DCnxg3+F2eY/ZKl1wNobqQcCknw1tDUJ3XV0MFMZhlcxv596HnJkuJoq8
 GYmkz/aZ8TUSV+MyVVTaXafNLnemFBE5P7okvSjY7RMAQfvk+80vdDkGcdE9YzvjF+BY
 Ox0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866536; x=1698471336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqcfeNJ9wzGAGV7oxUL/7nZeKmkczdhN3f+SdC8Dc8c=;
 b=SLJywaQw1YAIJQtu71L9qo/fjRUWDTHa9JAgb+1pE3qpHMDk2vwyN0rCc1oftqq0x9
 MHhCQoxPcUFKKfChCjwRoRXvQBtxgV0u7BbyZEJHwWhdu/PMBjGjD0YflhkpD5bLzakQ
 /ZQvis8Q4EV7gIO1FPwivxzBi8FFsVLGpMjVyJXk/Za9JuUZoiWSt5AM7gAR8IbJ+g+q
 9yt611sjQPlsQ7gVbhMp5jNpHwIf4EMHnX7tfk8QIHJmPxgSdiIep4JX41pB5hDuURyF
 QSS4EeKnQ3pzEzlJtYBdY5Pxoj3zq6NC9GoKnc5s4cGsuDpwnEAEvxqUMMDBf+qbcehZ
 GzUg==
X-Gm-Message-State: AOJu0YxqEu9KA82IOZ69xAkOE/8bDZX6hMIAMKWOVxuc6Vcg+0tuHaVo
 CMKRTzvpR4pi7UTj3FleX7o1V13ueLMP6Nxx2NE=
X-Google-Smtp-Source: AGHT+IEMsc+7f2YF6xfHMVTtwPZq3n2cWb5Rr4QvQ03oWrdvK6enU778p7qh2aLtsxdJF1i8aQ8llw==
X-Received: by 2002:a05:6870:888:b0:1bf:b863:b6d with SMTP id
 fx8-20020a056870088800b001bfb8630b6dmr4271513oab.1.1697866536154; 
 Fri, 20 Oct 2023 22:35:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 44/90] target/sparc: Split out resolve_asi
Date: Fri, 20 Oct 2023 22:31:12 -0700
Message-Id: <20231021053158.278135-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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
index 2e2df42c53..f71c70a897 100644
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


