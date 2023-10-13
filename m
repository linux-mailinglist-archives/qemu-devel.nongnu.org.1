Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A027C8F60
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPir-0006RN-L8; Fri, 13 Oct 2023 17:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPio-0006PO-8o
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:26 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPim-0000Y2-Kt
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:26 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-692d2e8c003so2832354b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232563; x=1697837363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29AYOlo9zsUCJxHi1pCy5JzXY3ZpZHYusexxmkqMPQI=;
 b=EbAf1jX7W8jilg/e8ZtvVcKUfvZB6M8YF1/fwLtnQHxxgFzh6e0gUQtYNR32MNu8U7
 Wp4gXWD9zcjD+i0mN3hwLxu+hWdSi06MvQAixpqfiIJfgnH8MPgDJYeHctymD81jsz6a
 BglfdqlKszAegqBJug+tQh8gGEqy8NX71eOwhAkNW0rm1EYvwE7aaJiRr9kSwbHIOCOI
 fpS/+VFw45NqAybDYSe26eY0SSGpaDxwvN1a4bsYP/4PjIPyIbnYZ5R+lsLSnzeL0Z6b
 e+7jFsqfTCpUyA/oeY8W/+qMsrGVzZYrxLUbbyEdPB+rQ6ZfK2siNLo3+BPOtzDSFU4M
 H+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232563; x=1697837363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29AYOlo9zsUCJxHi1pCy5JzXY3ZpZHYusexxmkqMPQI=;
 b=PkeoKY0oCfgjGWcWRtu1ymDt7bJFriDiBtAHzf5o05J6IIww2aCKBEnV0ozfN9wNPZ
 udzkKoiXSQnRxj9JFTy9AtXZCQZ0ExZhCC488/eQKxUcoUxtKPDI+Jq9FPu4Wmc5+qEC
 jYgZ1pmivZq2LB12mUQNK6CVSOHb19Ofb5w0PE1UDLk8EOvxdQwvIDdRlzv8Xxu4CcE8
 Es9tCVGypaP2Xy9AzUFTv/buSDwy+KAiKEI+a/h+J7uK6GcnR4BKcOtTz4422MFa5VjJ
 2O92YezVXI1ugLUmCoXlSvlyXoH5ylmCW7QC6XNwLR3fsTmmYzIk5drRb4hY+jDjZGG6
 5tLw==
X-Gm-Message-State: AOJu0YwGJsHgiz80n9/n+x+lz5bwVE6zQ+rE1/Y56iAlXQGQWnPHlNCU
 p37jWRPa9pi3rWULeRe5NUmzosWNa1+y5q7yV6k=
X-Google-Smtp-Source: AGHT+IEbPD9m8wcv87dVHgNypdRcoNu5qN2LKqj6uNUHg7L3VVmZhoAImYbEF5Uh3lwxPP8bFZX4NA==
X-Received: by 2002:a05:6a20:3d92:b0:149:97e4:8ae4 with SMTP id
 s18-20020a056a203d9200b0014997e48ae4mr1921443pzi.0.1697232563199; 
 Fri, 13 Oct 2023 14:29:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 37/85] target/sparc: Move FLUSH, SAVE, RESTORE to decodetree
Date: Fri, 13 Oct 2023 14:27:58 -0700
Message-Id: <20231013212846.165724-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/sparc/insns.decode |  4 ++++
 target/sparc/translate.c  | 35 +++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d8ebebce53..b7b60f9919 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -217,6 +217,10 @@ JMPL        10 ..... 111000 ..... . .............          @r_r_ri
   RETT      10 00000 111001 ..... . .............          @n_r_ri
   RETURN    10 00000 111001 ..... . .............          @n_r_ri
 }
+NOP         10 00000 111011 ----- 0 00000000-----          # FLUSH reg+reg
+NOP         10 00000 111011 ----- 1 -------------          # FLUSH reg+imm
+SAVE        10 ..... 111100 ..... . .............          @r_r_ri
+RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 47a281dc38..960a3eabbd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4092,6 +4092,11 @@ static bool do_saved_restored(DisasContext *dc, void (*func)(TCGv_env))
 TRANS(SAVED, 64, do_saved_restored, gen_helper_saved)
 TRANS(RESTORED, 64, do_saved_restored, gen_helper_restored)
 
+static bool trans_NOP(DisasContext *dc, arg_NOP *a)
+{
+    return advance_pc(dc);
+}
+
 static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
 {
     /*
@@ -4460,6 +4465,24 @@ static bool do_return(DisasContext *dc, int rd, TCGv src)
 
 TRANS(RETURN, 64, do_add_special, a, do_return)
 
+static bool do_save(DisasContext *dc, int rd, TCGv src)
+{
+    gen_helper_save(tcg_env);
+    gen_store_gpr(dc, rd, src);
+    return advance_pc(dc);
+}
+
+TRANS(SAVE, ALL, do_add_special, a, do_save)
+
+static bool do_restore(DisasContext *dc, int rd, TCGv src)
+{
+    gen_helper_restore(tcg_env);
+    gen_store_gpr(dc, rd, src);
+    return advance_pc(dc);
+}
+
+TRANS(RESTORE, ALL, do_add_special, a, do_restore)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5275,18 +5298,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 switch (xop) {
                 case 0x38:      /* jmpl */
                 case 0x39:      /* rett, V9 return */
-                    g_assert_not_reached();  /* in decode tree */
-                case 0x3b: /* flush */
-                    /* nop */
-                    break;
+                case 0x3b:      /* flush */
                 case 0x3c:      /* save */
-                    gen_helper_save(tcg_env);
-                    gen_store_gpr(dc, rd, cpu_tmp0);
-                    break;
                 case 0x3d:      /* restore */
-                    gen_helper_restore(tcg_env);
-                    gen_store_gpr(dc, rd, cpu_tmp0);
-                    break;
+                    g_assert_not_reached();  /* in decode tree */
 #if !defined(CONFIG_USER_ONLY) && defined(TARGET_SPARC64)
                 case 0x3e:      /* V9 done/retry */
                     {
-- 
2.34.1


