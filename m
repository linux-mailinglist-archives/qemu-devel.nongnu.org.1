Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BAA7D1B31
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eL-0002SP-IW; Sat, 21 Oct 2023 01:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eA-0002AW-OH
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:40 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4e8-00014n-4s
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:37 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c7b3adbeb6so1080977a34.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866534; x=1698471334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlXxtBQuyDJO+Ok229Ry7qRy9usRtj5AVUqWicQKQlE=;
 b=fb8vpmIqvBJ5fMxK1FeXlHdhhBKutxAmT6g8L1KrEWjpjhAjiHWkG+6yhaZWtQxu5r
 g2x+EZQgLIUFiB4CJNPIoYoPGQp+WJMekLCEEGsxuyd5nplQUJywk0cQitfZsCDHh7H9
 Qg/PlkNsYbcYN9HW7Zsav3p7W3WHRwqEZUcnaMx7Tmb5svjawTZS7npOz5r17/uQWoYt
 R3sVuTtHTq7m3WMdyAmzepRdeiOjtTOevCX3bYc0/0YYFa4NV64fZjvegFQXgo8rKe2E
 OvDzeNgFfcZro81cKTvmd623ZuudokLtlJs0P3QaHOtvX7R3RBye2P3kITSNQf3JPBjT
 p1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866534; x=1698471334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlXxtBQuyDJO+Ok229Ry7qRy9usRtj5AVUqWicQKQlE=;
 b=n9c02wCoaoKEkF+nTXaUHsszB8g50zTGZr+T2nU/U6xqxkV9hiqGdYJPqbWIbIgOP2
 pvu74uJuKSeWrJgrHoLbNsIK7DqAeyXSmYY6it6KrKE601vFzrPOQF3mJU1MwOdMkMjn
 AORTze/9hPv7RJ29BHvnBlgkQKXIxEcOWBCLHRY3hCM4GYjsxFM/inwjFASscKFb2PFQ
 5MVN2H0RfgOThG7qy/Rp9JxWCcMNdDLrUwqicHVWwXT3FH0Es/eJBbwDjeHdhoMSuO5t
 GqMERPXpc5V8OBqemwwDeWXd1Jo/Byrbjeoz4C05MQJZ71gSwPfHp52NpzssesEm+AHd
 DdAA==
X-Gm-Message-State: AOJu0YyIvH/g0sHxnmbzKk1FdNZcIl+mdkXOHh/7ydZqFu9cjc0a1iXT
 6wGisaZcZx0nhtqjcUsKr6cwcdxsOo1zdg4jG8M=
X-Google-Smtp-Source: AGHT+IHDiA8wmUrKmbCbbyubD9zje5my7QdKyVL8b/EqWK+klEgiJ9Yba4BtDvKcoSHJTluir4avMw==
X-Received: by 2002:a05:6830:2693:b0:6c4:9852:a498 with SMTP id
 l19-20020a056830269300b006c49852a498mr4613215otu.4.1697866534506; 
 Fri, 20 Oct 2023 22:35:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 42/90] target/sparc: Move FLUSH, SAVE, RESTORE to decodetree
Date: Fri, 20 Oct 2023 22:31:10 -0700
Message-Id: <20231021053158.278135-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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
index c2bf5f78e3..629547326b 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -223,6 +223,10 @@ JMPL        10 ..... 111000 ..... . .............          @r_r_ri
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
index 51c267f019..a3ac95fba2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4172,6 +4172,11 @@ static bool do_saved_restored(DisasContext *dc, void (*func)(TCGv_env))
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
@@ -4560,6 +4565,24 @@ static bool do_return(DisasContext *dc, int rd, TCGv src)
 
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
@@ -5375,18 +5398,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


