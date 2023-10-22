Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7D7D2730
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwi-0004Mz-1T; Sun, 22 Oct 2023 19:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwe-0004ET-Vu
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:21 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwb-0007Uo-6a
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1935270b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017594; x=1698622394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGKFAuhaFR6s2v1QljnD4mKd9249Dwf7ZIsDOC+Vbuw=;
 b=PgUdv8MS9Hp7LWpHC3Mwh0sUgOiv3E0qqiIu4glng8xd880TbsQLmVsn0IzA8/n49X
 y4QC/+3tndJUQjS/CG7mH0kZB0oI5lIIrwzWgUI5b3mmS0a2n+iY4VPVr2P8ehsFUoh0
 DcJuJG6fC35U15dyW8HCthxV9nGfDSY5uCv1tHvJm/pGbtEUUMcYODS7rjQEAEk8liCa
 /4bKKgQ12RKVXRHo7ydouGzViQP3QQCOFTFq3VNm5SLz4Uz9UoUbNPZ+U/VASZI/S0SW
 0pv/eJVQLlA2OZliqedjo/1VnHC4Tyhy19lwn5leJloozszlTt3bCTD1slUpre3R0A8I
 mkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017594; x=1698622394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGKFAuhaFR6s2v1QljnD4mKd9249Dwf7ZIsDOC+Vbuw=;
 b=l1GU2KEuxH9rO1L/TxkXDUwSLfgFyXVIPA1O5pLdWoKbJTNNCvKnOUA5Tae2BjmqBC
 87vYLuQk9YML0NX2O4nJduWaE3tfYa08asvEU6eCC5ltMWlpfep5JrDdXjdheiAf1UvZ
 pwDD1JgFjLH/RgLY+vQjm0Jkyxdo+RAwZhrDVTPcH5a+E13F+6md++PIHET1qpyQG4/2
 C7yL6TW6aGeWavb4xIMmT8VGn+hdCkGR9cYKXHRSUlGhhk2hEzmPxSFF0KvxdTpo5HgD
 9Fp/YfscYBleX7VbJ/nvzrC112HFcRdCizOt8xUrAntm1px+NZB2/xL1ATuzzU1qqZhf
 9nEg==
X-Gm-Message-State: AOJu0Yzt1SY9WFGUqKP4UeYLmcn7L132xjEhRuJwaKrdxyuYGl/YggLJ
 BkIkJgqDK22O6tDYM8sjyVDMlUMuIotMyrtWn8g=
X-Google-Smtp-Source: AGHT+IGCuoDTrtWTPnsiShGdpy+DUYTWT9+3cKlKuL42rHu1kDi41aPd6S7aaRuL0kvpQl7d8G02Ig==
X-Received: by 2002:a05:6a00:1817:b0:68e:3616:604a with SMTP id
 y23-20020a056a00181700b0068e3616604amr10905528pfa.8.1698017593716; 
 Sun, 22 Oct 2023 16:33:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 46/94] target/sparc: Move FLUSH, SAVE, RESTORE to decodetree
Date: Sun, 22 Oct 2023 16:28:44 -0700
Message-Id: <20231022232932.80507-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 target/sparc/insns.decode |  4 ++++
 target/sparc/translate.c  | 35 +++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 271789ac13..aa90b5c5bb 100644
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
index f3cb5e5146..e90be8b959 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4077,6 +4077,11 @@ static bool do_saved_restored(DisasContext *dc, bool saved)
 TRANS(SAVED, 64, do_saved_restored, true)
 TRANS(RESTORED, 64, do_saved_restored, false)
 
+static bool trans_NOP(DisasContext *dc, arg_NOP *a)
+{
+    return advance_pc(dc);
+}
+
 static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
 {
     /*
@@ -4454,6 +4459,24 @@ static bool do_return(DisasContext *dc, int rd, TCGv src)
 
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
@@ -5269,18 +5292,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


