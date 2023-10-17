Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9687CBACD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:18:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNb-0002eS-Iw; Tue, 17 Oct 2023 02:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNQ-0002Hq-K4
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:24 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNO-0004f8-GZ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:24 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57b8cebf57dso2797760eaf.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523381; x=1698128181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExtlfcmBRE2sB2/CWMkspqZTp25HPrR30GPM9tlU6fg=;
 b=ps5rbuSqCxYnNhjFl3Ve5e0yP5c51DqgmMKVqqhAWm7gXOZemFVwdUb/b5Lc9qSV96
 I7oe2KAIqofQUS8XbPa2gUn5m0YOI9ICBydhPssPgBShqCov77Udxv7/414LnJ5liuUO
 gfp/Pfv6RecSUrKSmrzJ1eC+0+QqlVUUi7d6R/38ZuLhWUr4CzcnfO/2afxk+CPxPRmP
 pPRxUUy8TCkB2qo8l9L5xEAL2dcftaULrH82jmzExJqUn/xO6iYXWDr/oXSh1xsHFHYq
 AB7ocQQkGmaBr6Rey+TDn9PUYjSqlnQnB0a8ghCWzrXJCw+5cxa8rawqY7laVs7T1Fxo
 xy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523381; x=1698128181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExtlfcmBRE2sB2/CWMkspqZTp25HPrR30GPM9tlU6fg=;
 b=DcUXC455sD1DotbW/+adN2bBfJG5wKeBrep41K5cAOovY1yZ0sYiGfuDGOH901fi98
 ruhYIWCSq/LmCk0jQYtQo6EayBgXSQ5fnGy0gfDIOtnVEZetis2iKArFprxFojJeNK5c
 dqLEq07j11xrS1ho6jVT/903psUijKBecw4DAfbP1mveCA8p4kG45V4Z02s0UvrIjvoQ
 4SBnNtPaim6zpmYYg0+kFSak3c+vgcHMFzChMn56b/n7Pdr8uY4aVanuCW2kemIrydsr
 8pOCn83ctLWOoqjc4CUNQkjVnCKJx1KS7o+I5icfTjcLoS2L+P+oiW3LqCOj9blNgAiF
 9S+A==
X-Gm-Message-State: AOJu0YxBWOYkYy3TADtxXBFPK7hn7/I7Ah2LiWQDiY0FUlw5Bi+5pG51
 qj5I2y89dX0cOXofSmUdJWhe/MmMtwnhAkuw4LY=
X-Google-Smtp-Source: AGHT+IGsV1FZ1uS1Mwa7gSjI2xMGHy1cpsPNDqtIMqGqZyqeqO2CrdJgqaK9sSJlTpY120DNvLbnlA==
X-Received: by 2002:a05:6359:2f81:b0:164:8225:83a8 with SMTP id
 rs1-20020a0563592f8100b00164822583a8mr1629604rwb.0.1697523380925; 
 Mon, 16 Oct 2023 23:16:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 42/90] target/sparc: Move FLUSH, SAVE, RESTORE to decodetree
Date: Mon, 16 Oct 2023 23:11:56 -0700
Message-Id: <20231017061244.681584-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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
index 060ee79db0..9c4c493630 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -216,6 +216,10 @@ JMPL        10 ..... 111000 ..... . .............          @r_r_ri
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
index bf8d611942..5fc46d1b20 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4138,6 +4138,11 @@ static bool do_saved_restored(DisasContext *dc, void (*func)(TCGv_env))
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
@@ -4526,6 +4531,24 @@ static bool do_return(DisasContext *dc, int rd, TCGv src)
 
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
@@ -5341,18 +5364,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


