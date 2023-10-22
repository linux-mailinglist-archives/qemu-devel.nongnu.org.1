Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF17D213D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:04:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWU-0000kf-Kr; Sun, 22 Oct 2023 02:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWF-0000b2-3R
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:00 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWD-0001bN-Ax
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:58 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso1748960b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954456; x=1698559256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mMYmKwJtPq/+64v43x89L2IhKcuVN5x2HBXcrC0/Jw=;
 b=Gs/9jXvcz8wPlvfweLZBU/o6nfY/Dem51XDTri9wfNaQ+Sa2G788XJLiQyR6LSJv4m
 lyDNOTWYfSqHJYZJ5TgpgtXYoNE5DezP8fBMFwarZABAKrmAP539bFl9Zr+IFc/orVnv
 lua1mGZPKK17JJHIbt2pGeEDjGhhbqphBnlZ7xgnN4K0bAqsQd3YJWP6fEwg6dMWl3xV
 jy3QzNt6eBK5x19cqNL3bwGP37IduezAIDz2fOf72Jyh2Zmn+BZU/0oCpSeX79tj/miB
 yigyg2+BRbDfxopiON4UWitKvXaosoziDEvpRWfJLEfX77AO/gVvebCtOZdIVU20eEpf
 u8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954456; x=1698559256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mMYmKwJtPq/+64v43x89L2IhKcuVN5x2HBXcrC0/Jw=;
 b=aX+P0BrokLTmn8ohDjMUslM9QawTC/nCd+Me/fBTaIrSI2KlNZT5ghhkZGciuZRWxH
 WaRFwdpcoYQ6iZm6Eupiix7LOMhVwBV598LPsPArD8xSrH1xqjSF3R0vcwexEQxQAU7T
 Oy0wDf6GTF6azKlzD2HJmp7BEfbWZ2kgLlgh1mmHs0ZPp0+aIZOT/+PdrLeKa/mMlB/i
 r/44qOILzsz4AoeUKBPZBiSyF0uX0vib/ku+ZtufGFQ71RT4a+lSzk2heVDxy6ph1SuQ
 ITJFsWzIeGMwlJCQsnD/ksrOiDTi7PDHmthDfB3tGuws+YWpAWvgjOKly5idhw5cisHh
 plgg==
X-Gm-Message-State: AOJu0YwUhNuXnadz8rvqiYMJo9oWHWaGaUStJ2SlWFlM1qxBu6IhZ2lc
 7GyN0zu7M3QNO+autS099LWVtj5a05uPIsT6Nzs=
X-Google-Smtp-Source: AGHT+IGnT+HQn5em8UoRomUInYLAFNnfCXf5xh7mxs75xiyGeQ6w6eiyFqBlJgNeYpa6aCtvxOzBfA==
X-Received: by 2002:a05:6a20:4e1a:b0:15d:e8ce:145 with SMTP id
 gk26-20020a056a204e1a00b0015de8ce0145mr4064378pzb.21.1697954456050; 
 Sat, 21 Oct 2023 23:00:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 28/90] target/sparc: Move WRTBR, WRHPR to decodetree
Date: Sat, 21 Oct 2023 22:59:29 -0700
Message-Id: <20231022060031.490251-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Implement htstate in the obvious way.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   9 +++
 target/sparc/translate.c  | 130 ++++++++++++++++++++++----------------
 2 files changed, 85 insertions(+), 54 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f478999ee1..eab737fdcc 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -143,6 +143,15 @@ WRPR_strand_status  10 11010 110010 ..... . .............  @n_r_ri
   RDTBR     10 rd:5  101011 00000 0 0000000000000
 }
 
+{
+  WRTBR             10 00000 110011 ..... . .............  @n_r_ri
+  WRHPR_hpstate     10 00000 110011 ..... . .............  @n_r_ri
+}
+WRHPR_htstate       10 00001 110011 ..... . .............  @n_r_ri
+WRHPR_hintp         10 00011 110011 ..... . .............  @n_r_ri
+WRHPR_htba          10 00101 110011 ..... . .............  @n_r_ri
+WRHPR_hstick_cmpr   10 11111 110011 ..... . .............  @n_r_ri
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8735cf1845..ea991bf1f8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4052,6 +4052,81 @@ static void do_wrssr(DisasContext *dc, TCGv src)
 
 TRANS(WRPR_strand_status, HYPV, do_wr_special, a, hypervisor(dc), do_wrssr)
 
+TRANS(WRTBR, 32, do_wr_special, a, supervisor(dc), do_wrtba)
+
+static void do_wrhpstate(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_st_i64(src, tcg_env, offsetof(CPUSPARCState, hpstate));
+    dc->base.is_jmp = DISAS_EXIT;
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(WRHPR_hpstate, HYPV, do_wr_special, a, hypervisor(dc), do_wrhpstate)
+
+static void do_wrhtstate(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_i32 tl = tcg_temp_new_i32();
+    TCGv_ptr tp = tcg_temp_new_ptr();
+
+    tcg_gen_ld_i32(tl, tcg_env, offsetof(CPUSPARCState, tl));
+    tcg_gen_andi_i32(tl, tl, MAXTL_MASK);
+    tcg_gen_shli_i32(tl, tl, 3);
+    tcg_gen_ext_i32_ptr(tp, tl);
+    tcg_gen_add_ptr(tp, tp, tcg_env);
+
+    tcg_gen_st_i64(src, tp, offsetof(CPUSPARCState, htstate));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRHPR_htstate, HYPV, do_wr_special, a, hypervisor(dc), do_wrhtstate)
+
+static void do_wrhintp(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_mov_tl(cpu_hintp, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(WRHPR_hintp, HYPV, do_wr_special, a, hypervisor(dc), do_wrhintp)
+
+static void do_wrhtba(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_mov_tl(cpu_htba, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(WRHPR_htba, HYPV, do_wr_special, a, hypervisor(dc), do_wrhtba)
+
+static void do_wrhstick_cmpr(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+
+    tcg_gen_mov_tl(cpu_hstick_cmpr, src);
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, offsetof(CPUSPARCState, hstick));
+    translator_io_start(&dc->base);
+    gen_helper_tick_set_limit(r_tickptr, cpu_hstick_cmpr);
+    /* End TB to handle timer interrupt */
+    dc->base.is_jmp = DISAS_EXIT;
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(WRHPR_hstick_cmpr, HYPV, do_wr_special, a, hypervisor(dc),
+      do_wrhstick_cmpr)
+
 static bool do_saved_restored(DisasContext *dc, void (*func)(TCGv_env))
 {
     if (!supervisor(dc)) {
@@ -4737,63 +4812,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 #endif
                     case 0x30:
                         goto illegal_insn;  /* WRASR in decodetree */
-#if !defined(CONFIG_USER_ONLY)
                     case 0x32:
                         goto illegal_insn;  /* WRPR in decodetree */
                     case 0x33: /* wrtbr, UA2005 wrhpr */
-                        {
-#ifndef TARGET_SPARC64
-                            if (!supervisor(dc))
-                                goto priv_insn;
-                            tcg_gen_xor_tl(cpu_tbr, cpu_src1, cpu_src2);
-#else
-                            CHECK_IU_FEATURE(dc, HYPV);
-                            if (!hypervisor(dc))
-                                goto priv_insn;
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                            switch (rd) {
-                            case 0: // hpstate
-                                tcg_gen_st_i64(cpu_tmp0, tcg_env,
-                                               offsetof(CPUSPARCState,
-                                                        hpstate));
-                                save_state(dc);
-                                gen_op_next_insn();
-                                tcg_gen_exit_tb(NULL, 0);
-                                dc->base.is_jmp = DISAS_NORETURN;
-                                break;
-                            case 1: // htstate
-                                // XXX gen_op_wrhtstate();
-                                break;
-                            case 3: // hintp
-                                tcg_gen_mov_tl(cpu_hintp, cpu_tmp0);
-                                break;
-                            case 5: // htba
-                                tcg_gen_mov_tl(cpu_htba, cpu_tmp0);
-                                break;
-                            case 31: // hstick_cmpr
-                                {
-                                    TCGv_ptr r_tickptr;
-
-                                    tcg_gen_mov_tl(cpu_hstick_cmpr, cpu_tmp0);
-                                    r_tickptr = tcg_temp_new_ptr();
-                                    tcg_gen_ld_ptr(r_tickptr, tcg_env,
-                                                   offsetof(CPUSPARCState, hstick));
-                                    translator_io_start(&dc->base);
-                                    gen_helper_tick_set_limit(r_tickptr,
-                                                              cpu_hstick_cmpr);
-                                    /* End TB to handle timer interrupt */
-                                    dc->base.is_jmp = DISAS_EXIT;
-                                }
-                                break;
-                            case 6: // hver readonly
-                            default:
-                                goto illegal_insn;
-                            }
-#endif
-                        }
-                        break;
-#endif
+                        goto illegal_insn;  /* WRTBR, WRHPR in decodetree */
 #ifdef TARGET_SPARC64
                     case 0x2c: /* V9 movcc */
                         {
-- 
2.34.1


