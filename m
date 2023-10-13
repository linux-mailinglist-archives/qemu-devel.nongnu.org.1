Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8297C8F1F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:32:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPis-0006RQ-5X; Fri, 13 Oct 2023 17:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPip-0006Qy-KQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:27 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPio-0000YS-48
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:27 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6c4fc2ce697so1713730a34.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232565; x=1697837365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3x6eGpyMzcHLtmXWSfLOAiDgrHIMIv6MYnepjBlPbGI=;
 b=CKC08jYLeZWKjRuRZ9t8bMosgQ1Dx4wXSbygce9Cgo//4Q6UXjpquq7oVYke9w065g
 7jX//0wJddYaO3xGOmPmbr28dv5ZR4IILt2ilSWjZ3lSAXxkCL4hm8vNUNzL58ytS179
 msLknoK27eDePSAQPwZXDClCz5G+ljnAThCb2CMxxsBCrsdciyIxS65zsUJ4tzcC3rwt
 A5f9p25cFrF1shTS1niH7TNru+LwvfpV5ldtF0GhobcHfOFlPeAwTlhv00+EgGI9CTBN
 9LyAYPWx40hX4b6T4qjxv7BSiI/hx4dk7k9NQP0yxx2UXheqLd5ug+UbvBLcFH0gt9fs
 htyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232565; x=1697837365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3x6eGpyMzcHLtmXWSfLOAiDgrHIMIv6MYnepjBlPbGI=;
 b=T153dYYBfqgE/oWxerz7Kna/i7mad3BpeDyEWM22m6cIRccn0Mo7pSmySUmxr0LAl2
 +T7JWBTEuqBqDV3cYbQynaskCe6a2j2qxlhGJCjhkTt8cGlquHET8NADc1RIOA+w1RyJ
 ALh6mxuXuWnb6N0AZGBfDRnETiFUdUQ9BP9isiKaCJaJ9riP2VmMJTeIKpGxaRtsGLB3
 vITL0Pt0/qoY3jXop5+Bn7ahFNI+Cm+XKx8AHXeT0+mbK6zb/WG1ZncTpxA1Lh8zhDXr
 xVzb4mA0EbQFlxTM2r2mHFn1q/IFOH6n/XnaX1leKKNmj32ewXhMJpfUAiEPUVX5l29r
 zBQA==
X-Gm-Message-State: AOJu0YxpyDufTf+/u3WGZRb9Y8dBFjTbTHJPjfqJmaiiQfyZJTWD8AAb
 QHzbbSPMw16B7LKqXZYN16XyOrpD2K60DeFPM1M=
X-Google-Smtp-Source: AGHT+IGTKTDgMmY7wtGyA48aFXAA6Y0H/9C34Ns1ehrSW4VKfLPwsikSXj/4ooGCfp2xJFswOCwFZQ==
X-Received: by 2002:a05:6871:8a4:b0:1e9:8885:b534 with SMTP id
 r36-20020a05687108a400b001e98885b534mr11693856oaq.9.1697232564878; 
 Fri, 13 Oct 2023 14:29:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 39/85] target/sparc: Split out resolve_asi
Date: Fri, 13 Oct 2023 14:28:00 -0700
Message-Id: <20231013212846.165724-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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
index e652bdcac2..42a26671f1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1815,15 +1815,25 @@ typedef struct {
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
@@ -1866,7 +1876,7 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
         type = GET_ASI_EXCP;
     }
 #else
-    if (IS_IMM) {
+    if (asi < 0) {
         asi = dc->asi;
     }
     /* With v9, all asis below 0x80 are privileged.  */
@@ -2025,9 +2035,16 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
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


