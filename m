Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061D77D1B3C
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bK-0007KU-5z; Sat, 21 Oct 2023 01:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b0-0007Cu-VN
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:25 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4az-0008Qz-56
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:22 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1196418b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866340; x=1698471140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtxjKXMcGsD5n0K7UcFblBkmcaT4TjEmnLQE1OFn+DY=;
 b=wYjDLyQ26ioUCIm3kO915lNizdOel+qZL2Voa216D7ZxkhOwy8LesXOV5qh4jq8Uy7
 UKdim6ueJnEZnOs4USIvLW6xWG9M/w6zozkRcA3A3PVXia6kRWea30oojX7BURACfC25
 nhLziiTSAVotE8sZYbx2Vk9IqylJGtrUXwzP36WvuaLHrv2QjOzpPBFHw6HnwE8kXK2Z
 In/jMXa28YQeNodAnksYo7g/dvyXDntPEpQlO6CE81TWEeZ7fJ6T575ITqXTxo0WhN7O
 l0RZF8kPwLdIh9JifJi26m3WQfbWweF/tO7Y63+lcwIlY7VOsh8ZuvNSVu+JyhlrZq8J
 iBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866340; x=1698471140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtxjKXMcGsD5n0K7UcFblBkmcaT4TjEmnLQE1OFn+DY=;
 b=qRz5l5p+UKazmzbF151UoTRlwtRLeCDkseqmciHIl0t6JMSyACXV3/0bo4VKPn9YmN
 9FzQyo8iCGqZ70BCafvVIkJTFHK1j5NE5+B9UUhAt0S/nh3o3IdHi6SDxbqb6LKdgrNn
 Pws8qCbkMPbCEJjcDjNmBiauRvY/SMgjbFcxC0RSlFLqjxTxQNjWA0vw4KPVLRRZZQHz
 QA6DxfVaXmxeARCHJzggKy3TawfI4GUykB7lsns2OIeUurNDJBmNoTfOOZCujeABaVgm
 g9kzilBWN+WXWgJGbeKO58gnotHdjCVxc6TeaLw+kIqXgkAnIAORiu9GyoB58G4iMSpK
 B+nA==
X-Gm-Message-State: AOJu0YzSzS1S1ZAH5nD9Y80/t9y8roteXa72xeUtGw2PRWJzTq6LTlHd
 Vq0WKdxQe33bObz/1mmKySlrcdWLkS7DekycuR8=
X-Google-Smtp-Source: AGHT+IErzCoc8Pd+OeGsiAX4AUko6jCevX0ZGYEWGE5KNv/ifVj5QT1I75A4pdUH0RfL7bWk9DS3Ig==
X-Received: by 2002:a05:6a00:80f7:b0:68a:48e7:9deb with SMTP id
 ei55-20020a056a0080f700b0068a48e79debmr9169816pfb.2.1697866339936; 
 Fri, 20 Oct 2023 22:32:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 24/90] target/sparc: Move RDTBR, FLUSHW to decodetree
Date: Fri, 20 Oct 2023 22:30:52 -0700
Message-Id: <20231021053158.278135-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  5 +++++
 target/sparc/translate.c  | 23 +++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 99e4f8f671..7fb5fa3b3a 100644
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
index 70ebf3cf79..4c9079d598 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3476,6 +3476,7 @@ static TCGv do_rdtba(DisasContext *dc, TCGv dst)
     return cpu_tbr;
 }
 
+TRANS(RDTBR, 32, do_rd_special, supervisor(dc), a->rd, do_rdtba)
 TRANS(RDPR_tba, 64, do_rd_special, supervisor(dc), a->rd, do_rdtba)
 
 static TCGv do_rdpstate(DisasContext *dc, TCGv dst)
@@ -3614,6 +3615,16 @@ static TCGv do_rdver(DisasContext *dc, TCGv dst)
 
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
@@ -3644,18 +3655,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


