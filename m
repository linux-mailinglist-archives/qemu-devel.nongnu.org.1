Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A027CBB07
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKN-0000gB-J6; Tue, 17 Oct 2023 02:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKK-0000Zo-4X
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:12 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKF-0003u5-Dd
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:11 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso33426165ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523186; x=1698127986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0V5M82NG7JGYdCRA+WhlsKSM/qMjWgqbad3PPOsTsuY=;
 b=yiUe+jJsI0QEZTGyOC3aksACCTszhsMl2s2lPKeziP7W0RH6BllZ4HorebgxzRLtRa
 yaqwui/sajAJqn2ozLmbQwd/5EErAjvBQibkeozdmOvPqw96pk+RTtuwB5kWUPvORXDV
 V6DHduHkGZ9h3J3VfBnX5AolpwL+4pyz6EKgbKHvqd7Rm2B1QKtr7rYt13Gzy7jiD++X
 MvXn0addp+FAdHDNjZaAHhLjcp1RvbVVBdk5V35RiN4dCONR2rnOnL2vVH/uvjrkiw6Y
 tIQTPoNQdscxls1ktwhMq1zrQrVORCueriCOdZSxVV+dQyh0W4stjkkXeVAhU46rAi3z
 hBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523186; x=1698127986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0V5M82NG7JGYdCRA+WhlsKSM/qMjWgqbad3PPOsTsuY=;
 b=e+pCSIPy7Vzz2SzGtHkYOv7fvqT9UsYvtLEIszT5ohqJjSpnAScwPHOEmcmd/yzBG7
 0e5cRDl+FwlRmymlG7lNCjEn7fo3ZB1N2Uh+11XPlDGqyskoFm7wsP2T7XYqLD7wqLyq
 0CYKzn6nsI2v8hZj9bR/lNEDIQXZZUAnwf9SUfi7FIFqR0fltHI20kGman+fBh6GZ6J1
 DPOoL5znmUPyifcxQSHDw4n/vqlW8oGmQaLika/MDVfpJSetS0ky6+M05rlk16Emu4fJ
 XHXipGJspsAspN4TF5Sj0YI5ylWCjg1LnsiOS5okj+z2Mc/XN5U6CLAmcGHLTwROZN9D
 mDKA==
X-Gm-Message-State: AOJu0YySMmN5VkhPGdwyN7Vc9hPh75pft+eR7O69XmNRo+fQ6zlsX0AQ
 TMwnDYq4+31xmzWhNtSwj5tPgOm0RJIppuw+gjM=
X-Google-Smtp-Source: AGHT+IHoEIIbWV9TcGVuK8e9KRGvfreiI7096cRq0A13IbThXKtrcsQbtgMxiK13/xWPdH03KJEUaw==
X-Received: by 2002:a17:903:41cc:b0:1b8:8682:62fb with SMTP id
 u12-20020a17090341cc00b001b8868262fbmr1660734ple.4.1697523186144; 
 Mon, 16 Oct 2023 23:13:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 24/90] target/sparc: Move RDTBR, FLUSHW to decodetree
Date: Mon, 16 Oct 2023 23:11:38 -0700
Message-Id: <20231017061244.681584-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
index bab80514ba..c2d8b0dbbe 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -77,3 +77,8 @@ RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
 RDPR_gl             10 rd:5  101010 10000 0 0000000000000
 RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
 RDPR_ver            10 rd:5  101010 11111 0 0000000000000
+
+{
+  FLUSHW    10 00000 101011 00000 0 0000000000000
+  RDTBR     10 rd:5  101011 00000 0 0000000000000
+}
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9d01c53791..c6f64e7fbb 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3479,6 +3479,7 @@ static TCGv do_rdtba(DisasContext *dc, TCGv dst)
     return cpu_tbr;
 }
 
+TRANS(RDTBR, 32, do_rd_special, supervisor(dc), a->rd, do_rdtba)
 TRANS(RDPR_tba, 64, do_rd_special, supervisor(dc), a->rd, do_rdtba)
 
 static TCGv do_rdpstate(DisasContext *dc, TCGv dst)
@@ -3617,6 +3618,16 @@ static TCGv do_rdver(DisasContext *dc, TCGv dst)
 
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
@@ -3647,18 +3658,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


