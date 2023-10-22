Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB857D271D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:34:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwj-0004fh-4T; Sun, 22 Oct 2023 19:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwd-000452-EN
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:19 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwa-0007Vx-Im
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:18 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b26a3163acso1907015b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017595; x=1698622395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhqwlaYbulfgn4XJLkmSH9JqIoXF1XNQT30wUOM3U5o=;
 b=vQuiX1OFZ8C5TN61KeAgzCIlDXbPREfvLmXgJCG9B+7ysqG4cwAyjA5RlhoK/i1/5h
 3VQ6uoNCaTcH3oLm6KoP4IwGtqUnkAWf6WYegCrzc5RvLkgovKDZyIQ2SrDHzkJKmtjQ
 APJ1uofF3VXVEHZ/SUb4zhRIDVLM8TvK8batN0qk68txzgkNLu5vb9AdyyNJv8nuqRU2
 4w4ugUR2FH/MIF+i/3jtWd/mIR1Y08MdzzggCUOYT6hmX8tzaOpnfFlKroYm6HcSQyoT
 QSXzVMhDEtqWYxN1Hxtaxoen8A/FrQQvxwgn1H1KQo7MmNPRtCfsG/CAkm1WfXLtruaL
 lcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017595; x=1698622395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhqwlaYbulfgn4XJLkmSH9JqIoXF1XNQT30wUOM3U5o=;
 b=Lu5Mt51mpnoFegZe2y8fo1MzzufABVL3HbEkFRY75F16hRylP/t9Ax0wNOQYXE0AL4
 9xw+K78TfH2SrkKDubtIB2HEu4wR1+HsR77EoptXl67rx+tXNLiwJeS6kdVSSULvajtF
 AUYatvKXxppylQsEcGUQFSj/XvFsXyaP5o06d6qM10vuK9aImbJQQlCMz4593HYDEEPK
 57GNHuky2lbnbJeHLXQn00lU4bw4ZTFjyumonoc4pwVFZv8c6U+fLi8ygL6yLqU4TIcD
 nU4jV7FsxTkDmZ6I4RxC+DdoXcTq2geBT0KIZIAi7BLfyLNJwNC04aKk4zNId0y2hQ1I
 gMaA==
X-Gm-Message-State: AOJu0YyPYrimgI2QEbjXIS2sty3bN46dGUmGAlYowcGPB37tlbqVxnDn
 KdBPbTx1iopbOG1+qsmExfq8Qz2ln7tUuHpRN5o=
X-Google-Smtp-Source: AGHT+IEr/kKcZ6ePqtlfcdkaZBhWbmdIufABOmJ96MsIZYDEP6QFw/NYKKWloqUwtYwY8gmoOacZYw==
X-Received: by 2002:a05:6a00:134c:b0:68e:351b:15b8 with SMTP id
 k12-20020a056a00134c00b0068e351b15b8mr6118341pfu.12.1698017595242; 
 Sun, 22 Oct 2023 16:33:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 48/94] target/sparc: Split out resolve_asi
Date: Sun, 22 Oct 2023 16:28:46 -0700
Message-Id: <20231022232932.80507-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
index 7fc4d8945a..81277fb8ea 100644
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


