Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 388B27D214A
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:06:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWQ-0000e1-Rf; Sun, 22 Oct 2023 02:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWB-0000Zv-Ip
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:56 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW9-0001aB-WF
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:55 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-357a69dde08so9869935ab.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954453; x=1698559253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asz40augiXcc49Y45ipmViblriY/2MT+gl4uuC0pd+Y=;
 b=lCo+p6eNnlwDZ+C2tG99Z1/FhGHv/lKGSynaGmqhoynVIeYEpEcaIo5jOeHOqH98Q0
 CVjyPvBiPyi9TH7KfmACWDOyFbm4j/MZ35WHBj7MTypXWLPcPr0REWJ1NsicSW754nwi
 BB3X/fGYDFStBkMxPdoS5K/qLhs3XUl2D+HjP9r2/VPEE4SIXGblWt2EXwgFTMtegEap
 DkEx2RaqzK7loc7MNtKx36BBHgeT1+RYqrBSG4qjWriA81F9rPwDHCQ8ISnSQ1qDUItr
 pUjy/bJFOzk4nDbGz7Goa1SxVnVfnbb1Q+yL9QuMhaYYUfNjkGF9aB/WITz8pTJutsXL
 ROCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954453; x=1698559253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asz40augiXcc49Y45ipmViblriY/2MT+gl4uuC0pd+Y=;
 b=kR5MUWz3ClrQ9S51U1FMDebsq0mr/6fpZJkwaTGdcuAH6avI43k80fmnJDjbdFeZoz
 xqU7XHTak1RD6deCfnwJMZmAZupWVuB2mxG5vidZkk5a2+ff/dwqvG8bvLOfMR8F5qjP
 x6BInz+es0Ix1eUFSkUvY9wWVMunQdRW1bJRIjdNzNZWiigOzQ9I9zaEmZKZIoF8Rkiz
 2n5oeBwkyJJngAu1XUooS+LmskqoWgN7nSgagbQIlcI9rZKyitY+8Sd4sW3w6vsvzGUQ
 aTYrropI2eCiZmEZpPbdj3tD1yKPyQb30Xws4ppvgplNXMq/4gSwereAUsqilpNAhEwA
 fq/w==
X-Gm-Message-State: AOJu0YzYDzJgmlYvrnHUhHAyQicmJWhUPf+OzDKbbVjqYKQiamFJUCdw
 MkVHhOQXsYS/xUNIOTWWD6n4j+UEk1BFrHyQbH8=
X-Google-Smtp-Source: AGHT+IHTKsNalpKCNleySRaHXVv/ikVigRVBR5m5Hm/EBBakmsLu2RvwhzCfcnckVSj/sZMPWzB0pg==
X-Received: by 2002:a05:6e02:1ba2:b0:349:296c:9b8a with SMTP id
 n2-20020a056e021ba200b00349296c9b8amr7108021ili.2.1697954452871; 
 Sat, 21 Oct 2023 23:00:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 24/90] target/sparc: Move RDTBR, FLUSHW to decodetree
Date: Sat, 21 Oct 2023 22:59:25 -0700
Message-Id: <20231022060031.490251-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12e.google.com
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
index 0dd963776c..83659ec5b3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3497,6 +3497,7 @@ static TCGv do_rdtba(DisasContext *dc, TCGv dst)
     return cpu_tbr;
 }
 
+TRANS(RDTBR, 32, do_rd_special, supervisor(dc), a->rd, do_rdtba)
 TRANS(RDPR_tba, 64, do_rd_special, supervisor(dc), a->rd, do_rdtba)
 
 static TCGv do_rdpstate(DisasContext *dc, TCGv dst)
@@ -3635,6 +3636,16 @@ static TCGv do_rdver(DisasContext *dc, TCGv dst)
 
 TRANS(RDPR_ver, 64, do_rd_special, supervisor(dc), a->rd, do_rdver)
 
+static bool trans_FLUSHW(DisasContext *dc, arg_FLUSHW *a)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_flushw(tcg_env);
+    return advance_pc(dc);
+#else
+    return false;
+#endif
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3665,18 +3676,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


