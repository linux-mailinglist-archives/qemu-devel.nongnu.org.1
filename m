Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E477C8F10
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:30:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPie-0006JF-51; Fri, 13 Oct 2023 17:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPib-0006HE-DI
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:14 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiX-0000Tn-B1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:13 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1e0ee4e777bso1495660fac.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232546; x=1697837346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6q3VzZvsaBpEMylLqymMLp6EE3lGsY1PtUwRY/mn3xM=;
 b=g679ad9EEQT4cyqBxtRZAA63FzYrhY7I9mN4Uoesx09I53KR4WeRd0o+BV/wsgswlu
 K7TDm/ZbDY4f59yH5A7G29l+sw/Rj2b4suiTbYBqANuJ9puvfkBe6mAxbZOb5SlZ1hh5
 QjfFr29idnM43UHEyPFoMI0fxGLyg4oNEP9vChYsPlmrCkRuRw5huJmffsgcSndqxgsp
 vC3l6SeBdl+8Gzi7XsqQGa+FXFB9NCBK/5ENPhiXqZrmZXa0P6Bd5oZ6INHV0LTogxy8
 0zgN39p8I0aZfezrSZiLw7ND3sh/v9ERms/ABqdUkY/v+tG3nJIY7lpCElu14NIMjgi0
 S3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232546; x=1697837346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6q3VzZvsaBpEMylLqymMLp6EE3lGsY1PtUwRY/mn3xM=;
 b=SVh+my+mCjjWJUwCScU9eMOvhXwEk2oKcnj4E/3JAOSHCF3z+EbJkWyccCXLf/SBcq
 IvflQIPogB3yQ6ZLnpDbMavH52v2AjAvtW+K69WuutYw5W3Al/I2FdMKYGyQy6bR3fzy
 DxcTmyVOydJlxKX8sKZj4q51qWGKM109LFjBjKkyj57ZAeLDqaSb6WQAayKu3QtkLRSd
 yyB3AZdG4Pg6qGoqugizmonRm3UNSGxeEGPlw7bGHCtpWsaicj/P4qfnZ4ipjPlSDIxX
 5vVuS5LRACYQFgydDdAArj3dDkgIqlYtj4hnXPAdq+BslJcNs0i3iAa+BFMdh5sQdH0+
 yJtA==
X-Gm-Message-State: AOJu0YzNkfR592tmzTzB+mshsaisuivMWHlNRSc76hLGhnM7ih3v4N/1
 Y3gCjRzd67ZeMgIoLFy03z6/OW72VxfsRZKcvD0=
X-Google-Smtp-Source: AGHT+IFAWZocYeAbFaINEf98yispafO0ABxkVa5sTrGMBEtrIrxMdD3khAcqnuGvdl8yHk94OXw79w==
X-Received: by 2002:a05:6870:15:b0:1e9:c315:9d66 with SMTP id
 a21-20020a056870001500b001e9c3159d66mr5057055oaa.40.1697232545905; 
 Fri, 13 Oct 2023 14:29:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 19/85] target/sparc: Move RDTBR, FLUSHW to decodetree
Date: Fri, 13 Oct 2023 14:27:40 -0700
Message-Id: <20231013212846.165724-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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
index 05329803f4..9142e0e2f0 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -78,3 +78,8 @@ RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
 RDPR_gl             10 rd:5  101010 10000 0 0000000000000
 RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
 RDPR_ver            10 rd:5  101010 11111 0 0000000000000
+
+{
+  FLUSHW    10 00000 101011 00000 0 0000000000000
+  RDTBR     10 rd:5  101011 00000 0 0000000000000
+}
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 00264326da..26601e508f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3445,6 +3445,7 @@ static TCGv do_rdtba(DisasContext *dc, TCGv dst)
     return cpu_tbr;
 }
 
+TRANS(RDTBR, 32, do_rd_special, supervisor(dc), a->rd, do_rdtba)
 TRANS(RDPR_tba, 64, do_rd_special, supervisor(dc), a->rd, do_rdtba)
 
 static TCGv do_rdpstate(DisasContext *dc, TCGv dst)
@@ -3583,6 +3584,16 @@ static TCGv do_rdver(DisasContext *dc, TCGv dst)
 
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
@@ -3613,18 +3624,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


