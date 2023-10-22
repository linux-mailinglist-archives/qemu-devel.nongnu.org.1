Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 935A37D26F7
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:31:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtS-0007Bf-P0; Sun, 22 Oct 2023 19:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtP-00079s-C5
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:59 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtN-0006nD-9j
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:59 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b2e4107f47so2106099b6e.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017396; x=1698622196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhTCRa9XqTvPXY/WNnNRGDaEgNbn6sdIYbZhiFVFjNI=;
 b=tVh2liRlBi7Ul6BINjmvz1aQYjCmRITBQlj5nQGu2rW/rOged6S76oMy2PfHfl3oew
 zRr+dIc+d8n7X5QI0KiZP3DdXFidIecgpynp+AEsQfGhH13PWw3KUZZIrhy+W4ya09WG
 KXtyfcZsGI840lafxvb/zVUA7QvfnZCqPzm+hcWzWrD3eMCkQ4v/JXj0Nc4zwPBBNsUd
 PWxPEWdORTalMWyJIffbsw/SjGltaCl5IP+sD+mchyzBvBQHn4KBQpliqxOywvLiSfbM
 xkhOS2/p8YTss3SdyZeEdANQPUUhbHjKIw+L/gS4u5tZhohzAEXNVUMyApvX1qfBlLu0
 NRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017396; x=1698622196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhTCRa9XqTvPXY/WNnNRGDaEgNbn6sdIYbZhiFVFjNI=;
 b=DR/PsYuV1vLxJwHriOHHhZSqy+Dfb67dXfAO/o1eEaJKNhFBU0MxjcQFFHbCv+fC4S
 Xf8cCAX2iowSU8Dt/Iq1PAxlJ4CyaU20WJLzsltu0jPoyj4y0thlKCVZEax283GNveQr
 QKPb5NmJEgPQHy5hMZw1r56QM5KWCAEWOOyF0M9f34ci2J7J1M8CqUZJCEjeDyPHpjw7
 8SVwqYl6KSUvc98T+ywaU8llhJgUwcr/ca3dkvytn2cpHWcLxs/wtgP8LrAA4z+mkcmp
 LTxro6NamUsN0v/OzWMsB9HrMGzhlxs9BEFMjEH0ZwQ5vMxTw7GNjPIafsCT+Py4kn13
 q4gQ==
X-Gm-Message-State: AOJu0YwWFV50puYU3jcM+U3F8j0doDE0j2M2LbC0TvxKvW4dF63mRm0x
 2ZFKmKJDEzM3JB5Zx4ePTtW4KUKNOhxR1im9Nok=
X-Google-Smtp-Source: AGHT+IHehEUvSnfBC0KfU8zzC6wZ2ioxgdOVjQBTcq9V3BL5Ka2rAgFsa5IEIzQ+kIWFhlBE7GbQqA==
X-Received: by 2002:a05:6808:b0e:b0:3a8:83df:d5a4 with SMTP id
 s14-20020a0568080b0e00b003a883dfd5a4mr8689037oij.59.1698017396092; 
 Sun, 22 Oct 2023 16:29:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 25/94] target/sparc: Move RDTBR, FLUSHW to decodetree
Date: Sun, 22 Oct 2023 16:28:23 -0700
Message-Id: <20231022232932.80507-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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


