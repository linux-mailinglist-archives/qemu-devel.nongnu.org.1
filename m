Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5D47D798C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6d-0001wz-Ss; Wed, 25 Oct 2023 20:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6A-0000wT-Nu
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5x-0006cY-TI
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:42 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso297114b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279568; x=1698884368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfaWHs7XImN3mnlF+/SiSC4bocYESJxyh1DleES1r9E=;
 b=Hr5maUdcFcuwSbIwhZti77OzeqidwZHSgdHwMWv264Hp566aB+8D2+ImApDeaXBiAm
 Qf9ayH/CQ/HF1YUobtbMLs2KGK5ScNGdBhykEpWBskxu3Dq6/aJWX+QWYH+WKM/i96JU
 Xpawsm2heUkNkqW8ZuSZeLnILtt0xYO9e1BSFjHeI+M8x88ddM6VFeBwu7zoIF4EioV3
 Ai3MUvZGiba90UKX7JSBy3RMjKq2bVWv8s8KOy/3uV2t3GUzlCl6RKYHAhZhXqg/avCN
 iet1SWR0z7YvMSP4N1croq/Qq2kOWc0UeSsyAGKDB6u/SgVEAdDRTdWBPGWiZOm98EYO
 /LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279568; x=1698884368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfaWHs7XImN3mnlF+/SiSC4bocYESJxyh1DleES1r9E=;
 b=PZZzHVwSMuHgiGT57y/mwD8TViOfXXgT3ihpk7IdxsomsojauXcU9ifCz1f22E5nWW
 nvrpdaEpSNFqeigX6vxV5hShaRETSzNkV0zORc0/DzICyQ6l3744OGwe5qukwVFx4Ohr
 fk72PHPJvOqDAdhKnBAfHr6qo1d2OdpvB2OSkIkG178yWkXtB8KjPbFIE0nsUvPJlBRy
 KmOLbG10c2tgyqeDFLjYKOeB4nDzC8H27iKJkKvPl2qEdqyiH604u1GS6Y9LFmJD12AT
 H4ThwwM4Avtn6/IuJYgxDj76cHK060sYJW58Bv6iBC+cD2nK1vTqDLuEsZA+kA6m/XQi
 duDw==
X-Gm-Message-State: AOJu0Yye+7xshpazl6zm4OW7Ok440prN6j1AdOGSvALHfENR11qmfpJE
 6X0VggHqHKx/EfwyMHbqJFUBX0fOuQQa7LoFhpM=
X-Google-Smtp-Source: AGHT+IFX/RbdJ1TxiCDUgVVhjGwQQ2wAO7yzwTorhYabJ5Qo4iNht8XWsXcxg7r+wjUpGtIofoeGtw==
X-Received: by 2002:a05:6a20:5486:b0:16a:b651:dcd6 with SMTP id
 i6-20020a056a20548600b0016ab651dcd6mr7948081pzk.7.1698279568611; 
 Wed, 25 Oct 2023 17:19:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 27/94] target/sparc: Move WRPSR, SAVED, RESTORED to decodetree
Date: Wed, 25 Oct 2023 17:14:33 -0700
Message-Id: <20231026001542.1141412-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/sparc/insns.decode | 10 +++++++
 target/sparc/translate.c  | 62 ++++++++++++++++++---------------------
 2 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 118f0f1f17..45cf47a32f 100644
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
index 83716307f6..58ea3b2ba7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -39,11 +39,14 @@
 #ifdef TARGET_SPARC64
 # define gen_helper_rdpsr(D, E)                 qemu_build_not_reached()
 # define gen_helper_power_down(E)               qemu_build_not_reached()
+# define gen_helper_wrpsr(E, S)                 qemu_build_not_reached()
 #else
 # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_flushw(E)                   qemu_build_not_reached()
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
+# define gen_helper_restored(E)                 qemu_build_not_reached()
+# define gen_helper_saved(E)                    qemu_build_not_reached()
 # define gen_helper_set_softint(E, S)           qemu_build_not_reached()
 # define gen_helper_tick_get_count(D, E, T, C)  qemu_build_not_reached()
 # define gen_helper_wrccr(E, S)                 qemu_build_not_reached()
@@ -3745,6 +3748,32 @@ static void do_wrpowerdown(DisasContext *dc, TCGv src)
 
 TRANS(WRPOWERDOWN, POWERDOWN, do_wr_special, a, supervisor(dc), do_wrpowerdown)
 
+static void do_wrpsr(DisasContext *dc, TCGv src)
+{
+    gen_helper_wrpsr(tcg_env, src);
+    tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
+    dc->cc_op = CC_OP_FLAGS;
+    dc->base.is_jmp = DISAS_EXIT;
+}
+
+TRANS(WRPSR, 32, do_wr_special, a, supervisor(dc), do_wrpsr)
+
+static bool do_saved_restored(DisasContext *dc, bool saved)
+{
+    if (!supervisor(dc)) {
+        return raise_priv(dc);
+    }
+    if (saved) {
+        gen_helper_saved(tcg_env);
+    } else {
+        gen_helper_restored(tcg_env);
+    }
+    return advance_pc(dc);
+}
+
+TRANS(SAVED, 64, do_saved_restored, true)
+TRANS(RESTORED, 64, do_saved_restored, false)
+
 static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
 {
     /*
@@ -4419,39 +4448,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


