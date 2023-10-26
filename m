Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 280467D7951
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6P-0001aQ-BK; Wed, 25 Oct 2023 20:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6A-0000w1-NA
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:44 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5u-0006bk-8J
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:40 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cacde97002so2069285ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279565; x=1698884365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhTCRa9XqTvPXY/WNnNRGDaEgNbn6sdIYbZhiFVFjNI=;
 b=JV43HpWyMwwmbz2AaQpmPq3OsUYJ9bK+laqGZjtrdKnqunI7pDQa8a1qmfLRg45FJv
 KLZmE5vhOiQiUwgUlSm4YZrbxVmu8wSdABxN98lelwOFryrlwjEc35/O/Y3ShgWXfCCq
 r1S3jL46SvzIPoSc1+ot5vVn1NQ18l03VdLevdE2pog3CRSu+guwsO8Twv60wY+NFqJE
 ExOupGK2t93oYBgnZZ6/H+OlkKBd8ilIdfOeIVXCB2vYmBugCs5Zr/i0CW0EMmc+Z2AW
 xRI9ot903qKTCRS/fF/L00sb9g0QpGVslrLDgCt+HuDHZ8E6T2b1Cra6xMzk2k2MIZ3M
 gVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279565; x=1698884365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhTCRa9XqTvPXY/WNnNRGDaEgNbn6sdIYbZhiFVFjNI=;
 b=rQOcm1O2vGsn1noorjtXhFwk7JIjTydTSa6CHTZGGqSot4A1LcsTQKp7FgfxTDcN8d
 oh9UWW9P/WJxsYYG4SXQ1G7wKQesT7siolRSZlj71MLfyBMLeBeUoSIE6nLo4ytWhlMJ
 g+5MH2m34vvCycPTrbBLnv26s7PWXI3jBv5Pa3r/EvjyDdILxSRRdeKl6RBiyMgw0MDp
 XVSIpFW57Ap5AG+dRitYd5GOfyo6QH9TdPYCdsZXJ0Be+anQePqmwIWgQMGveUvyQjgV
 gF1Sbqd+AgTSsoG2smH8kgMywmd3qYXBwxGt5kpyrRZRBrNFAyAt0Y7pt5umNxZZMJOt
 k6pA==
X-Gm-Message-State: AOJu0YzMCzgByfPYXko6eKvxiKfWziNNFAiTtWQIfiNdu1d/0ZG0Kk1Y
 GEdMUz3dL4gGjTjP/L4NRkxn+fN3YHfJ8ig0AII=
X-Google-Smtp-Source: AGHT+IGfUbxDgZlUtmmtEGG8s6+3/hn94escdnjYq2scaAMjhoAjFtbuHE3ZpJmW0Ab4z2CaoMkong==
X-Received: by 2002:a17:902:e54e:b0:1ca:2cd0:2410 with SMTP id
 n14-20020a170902e54e00b001ca2cd02410mr18669350plf.53.1698279564951; 
 Wed, 25 Oct 2023 17:19:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 25/94] target/sparc: Move RDTBR, FLUSHW to decodetree
Date: Wed, 25 Oct 2023 17:14:28 -0700
Message-Id: <20231026001542.1141412-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/sparc/insns.decode |  5 +++++
 target/sparc/translate.c  | 23 +++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 7d91a7bc83..0b6f4c9c38 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -76,6 +76,11 @@ RDPR_gl             10 rd:5  101010 10000 0 0000000000000
 RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
 RDPR_ver            10 rd:5  101010 11111 0 0000000000000
 
+{
+  FLUSHW    10 00000 101011 00000 0 0000000000000
+  RDTBR     10 rd:5  101011 00000 0 0000000000000
+}
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6e415d7070..67d3292e68 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -39,6 +39,7 @@
 #ifdef TARGET_SPARC64
 # define gen_helper_rdpsr(D, E)                 qemu_build_not_reached()
 #else
+# define gen_helper_flushw(E)                   qemu_build_not_reached()
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_tick_get_count(D, E, T, C)  qemu_build_not_reached()
@@ -3464,6 +3465,7 @@ static TCGv do_rdtba(DisasContext *dc, TCGv dst)
     return cpu_tbr;
 }
 
+TRANS(RDTBR, 32, do_rd_special, supervisor(dc), a->rd, do_rdtba)
 TRANS(RDPR_tba, 64, do_rd_special, supervisor(dc), a->rd, do_rdtba)
 
 static TCGv do_rdpstate(DisasContext *dc, TCGv dst)
@@ -3562,6 +3564,15 @@ static TCGv do_rdver(DisasContext *dc, TCGv dst)
 
 TRANS(RDPR_ver, 64, do_rd_special, supervisor(dc), a->rd, do_rdver)
 
+static bool trans_FLUSHW(DisasContext *dc, arg_FLUSHW *a)
+{
+    if (avail_64(dc)) {
+        gen_helper_flushw(tcg_env);
+        return advance_pc(dc);
+    }
+    return false;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3592,18 +3603,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_dst __attribute__((unused)) = tcg_temp_new();
             TCGv cpu_tmp0 __attribute__((unused));
 
-#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
-            if (xop == 0x2b) { /* rdtbr / V9 flushw */
-#ifdef TARGET_SPARC64
-                gen_helper_flushw(tcg_env);
-#else
-                if (!supervisor(dc))
-                    goto priv_insn;
-                gen_store_gpr(dc, rd, cpu_tbr);
-#endif
-                break;
-            }
-#endif
             if (xop == 0x34) {   /* FPU Operations */
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
-- 
2.34.1


