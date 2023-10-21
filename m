Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0237D1B09
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bH-0007ID-FE; Sat, 21 Oct 2023 01:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b2-0007Cx-C7
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:25 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b0-0008RQ-Ik
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:24 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso1455957b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866341; x=1698471141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNQs2YRR9hL9glz9QxZViAw2f/+tKFV4Vsaoa8u9uVA=;
 b=LhX6MflToDqpdq1axS5cDzYO9XcpcH+hhZ0TAWsuSeLYTqbpXZCJMlvPG+01EhvHl3
 Of/Z10V/e7eCqP+Z1BV7GvnG5SpE/7BLOph/mV3KwhzJX+nGCVcZqG8Jx6QNo7l5CtNo
 lmaIejcej2yqfun7h6syBisgwWAx9Vljrw6OmvM2iNl5pJbBd5VObAoFNDC2PQ/OwDBM
 chkhyWsMlhqNYhlXQHbeUTlcaBSw1yVacGliiJoVRnSFQ0eaIaTw32mKcJuaOcFjdFpz
 3A5t+9wFpkYKKMyYEn2vDCH0HGlFgSGgN8JxBNqhUOqYZqSV0iXTg57DuKZCypKUJucR
 2lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866341; x=1698471141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNQs2YRR9hL9glz9QxZViAw2f/+tKFV4Vsaoa8u9uVA=;
 b=aGu5Y3kJVNSHk6xZSDhvpxOFyqW+8XQdJPsJgSchzS4QrqnYsaI72A8vShmbzrOaOz
 PrT4iX6aSJYnptbAiqQ8DUpocCBpwIHKIWjD1W9qcMpV15lP7z+cmMHyACMBkrvAfHPE
 OolecSD82wyV2TG2MZMdD4zMFQYlzeX/WnYdkHsh8wF7aYTTDK/df0JROXyIMUFt3Qu6
 cTqri7tXz2vtDnmt4A1lnvPasFF0swJNIUukAgrrNrmJH9DDA26TIIzqtGXjVXyIAdJH
 d5WoUTc/InhsnMdsRF9J608w+rkW3TTrlR+OivD3V+DfRxp5KJKJ5f5sF5sqQVEn6LxN
 iy8w==
X-Gm-Message-State: AOJu0YyhtwZ23KQKhb4reeNUGUCv5vMqbq0puqMI7vKqI4Ysd/5i5+53
 eLTXId2LdDCrqf4JHCkKdFDbSP+rr1UvZQW/lqA=
X-Google-Smtp-Source: AGHT+IFv2FtqDXMwNrVGXDfJx2QpJU5wXCAGpNjUEIuf7GnEL0US6WN5Ya/mAdhzWaek+RA7yxa85w==
X-Received: by 2002:a05:6a00:1747:b0:6b1:c1c4:ae98 with SMTP id
 j7-20020a056a00174700b006b1c1c4ae98mr4500092pfc.18.1697866341354; 
 Fri, 20 Oct 2023 22:32:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 26/90] target/sparc: Move WRPSR, SAVED,
 RESTORED to decodetree
Date: Fri, 20 Oct 2023 22:30:54 -0700
Message-Id: <20231021053158.278135-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/sparc/insns.decode | 10 +++++++
 target/sparc/translate.c  | 61 ++++++++++++++++++---------------------
 2 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d7e7f0c577..5ba71c3d84 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -85,6 +85,16 @@ RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
 RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
 RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
 
+{
+  WRPSR             10 00000 110001 ..... . .............  @n_r_ri
+  SAVED             10 00000 110001 00000 0 0000000000000
+}
+RESTORED            10 00001 110001 00000 0 0000000000000
+# UA2005 ALLCLEAN
+# UA2005 OTHERW
+# UA2005 NORMALW
+# UA2005 INVALW
+
 {
   RDWIM             10 rd:5  101010 00000 0 0000000000000
   RDPR_tpc          10 rd:5  101010 00000 0 0000000000000
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c34602df80..7358a59fda 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -38,6 +38,7 @@
 
 #ifdef TARGET_SPARC64
 #define gen_helper_rdpsr(D, E)          qemu_build_not_reached()
+#define gen_helper_wrpsr(E, S)          qemu_build_not_reached()
 #define gen_helper_power_down(E)        g_assert_not_reached()
 #else
 #define gen_helper_rdccr(D, E)          qemu_build_not_reached()
@@ -46,6 +47,8 @@
 #define gen_helper_set_softint(E, S)    qemu_build_not_reached()
 #define gen_helper_clear_softint(E, S)  qemu_build_not_reached()
 #define gen_helper_write_softint(E, S)  qemu_build_not_reached()
+#define gen_helper_saved                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -3803,6 +3806,31 @@ static void do_wrpowerdown(DisasContext *dc, TCGv src)
 
 TRANS(WRPOWERDOWN, POWERDOWN, do_wr_special, a, supervisor(dc), do_wrpowerdown)
 
+static void do_wrpsr(DisasContext *dc, TCGv src)
+{
+    gen_helper_wrpsr(tcg_env, src);
+    tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
+    dc->cc_op = CC_OP_FLAGS;
+    save_state(dc);
+    gen_op_next_insn();
+    tcg_gen_exit_tb(NULL, 0);
+    dc->base.is_jmp = DISAS_NORETURN;
+}
+
+TRANS(WRPSR, 32, do_wr_special, a, supervisor(dc), do_wrpsr)
+
+static bool do_saved_restored(DisasContext *dc, void (*func)(TCGv_env))
+{
+    if (!supervisor(dc)) {
+        return raise_priv(dc);
+    }
+    func(tcg_env);
+    return advance_pc(dc);
+}
+
+TRANS(SAVED, 64, do_saved_restored, gen_helper_saved)
+TRANS(RESTORED, 64, do_saved_restored, gen_helper_restored)
+
 static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
 {
     /*
@@ -4477,39 +4505,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     case 0x30:
                         goto illegal_insn;  /* WRASR in decodetree */
 #if !defined(CONFIG_USER_ONLY)
-                    case 0x31: /* wrpsr, V9 saved, restored */
-                        {
-                            if (!supervisor(dc))
-                                goto priv_insn;
-#ifdef TARGET_SPARC64
-                            switch (rd) {
-                            case 0:
-                                gen_helper_saved(tcg_env);
-                                break;
-                            case 1:
-                                gen_helper_restored(tcg_env);
-                                break;
-                            case 2: /* UA2005 allclean */
-                            case 3: /* UA2005 otherw */
-                            case 4: /* UA2005 normalw */
-                            case 5: /* UA2005 invalw */
-                                // XXX
-                            default:
-                                goto illegal_insn;
-                            }
-#else
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                            gen_helper_wrpsr(tcg_env, cpu_tmp0);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
-                            dc->cc_op = CC_OP_FLAGS;
-                            save_state(dc);
-                            gen_op_next_insn();
-                            tcg_gen_exit_tb(NULL, 0);
-                            dc->base.is_jmp = DISAS_NORETURN;
-#endif
-                        }
-                        break;
                     case 0x32: /* wrwim, V9 wrpr */
                         {
                             if (!supervisor(dc))
-- 
2.34.1


