Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E182EF5D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:04:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPj5j-0007J7-Dm; Tue, 16 Jan 2024 08:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5c-0007Hv-SU
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5b-0006gD-7E
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:48 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e76626170so22140445e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 05:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1705410165; x=1706014965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DuMtCGQX75A6cCz1826JeXv62INpDD1iP3VCB/kG23I=;
 b=bebrmx5UkeOGNBspBL2RuSos3G6iDJGeGQLVGuhfApJBa0CxjP0BcvHLlhYvI1Nim7
 BjUMJGEPyxWn5zQummLYFZSeH8KXsoDfvJdplXKZ0SlzwJIMzvJK6yDK2ZCwvISpz4a2
 XHsyHTmldHR7puIMdRLY7jkgiDZLJKlssBrcr8zGE6D+kwonR4lYumWhOKE4bSb5jLxI
 itBtbSJfSDqW4zkxXk4QAZAs2Y9YRgdhjuoyDrN5ufPjLpb4w4/QjNeorARTn9yiSKQ0
 1PAiuOtc/1qJXJei/LiIy6/MXAFwmTYBTtL+1RJNAAfx7DtJXa2yZChWBu4IuKbz2Nv9
 ZM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705410165; x=1706014965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DuMtCGQX75A6cCz1826JeXv62INpDD1iP3VCB/kG23I=;
 b=gfaNvhLyfqN3MNtWqY5SnyjwZuRjeormd+QxF4YYBFd5V442j8Gl9LtOODeSrC2jjC
 PmozwilKd6lBzwYDv7pfSyqneUfwp7m7eVxj/58lw5DlMdVYc+knleTz64CLrCgHdNOP
 O27DJURdQkJlnQn/MM/pYm1Z1sirW4JJFetAa/BnApH2L/MywwNzA6XAmbpOuhaZlaGR
 RAvi4VHoJYRwhLO3dwakn/bs6WaQ/y1OZwNHysfYeIqzdEx3eeTCs7g/bzFS0igXm4Cm
 6JPUj3Gm7zjf4C/cdkA/J/tJdcMhrRYQiE5mj6E4ZQy55KapwDQg4810dxEfDWT7kb0Y
 wwyw==
X-Gm-Message-State: AOJu0Yw2qhgpfJq5HaDaE4+t1W7kc4QJC5lCo6zJyTOyDVgbjkwIl6UD
 qwerx3u+/2jvbm/lx+8l7YIy/dun+Frjwe1YOnnEy1Nafw==
X-Google-Smtp-Source: AGHT+IFdGZ83uPF94VnJ2aDIZFOBFkWmWjAoPTW5ppEKSvAu0EWJEy9eFll7HqrL0y9hdYBieIu4Zw==
X-Received: by 2002:a1c:721a:0:b0:40e:5a86:d291 with SMTP id
 n26-20020a1c721a000000b0040e5a86d291mr4104841wmc.87.1705410165325; 
 Tue, 16 Jan 2024 05:02:45 -0800 (PST)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b0040e83867d62sm2495316wmq.34.2024.01.16.05.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 05:02:44 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 5/8] target/sparc: implement asr17 feature for smp
Date: Tue, 16 Jan 2024 14:02:10 +0100
Message-Id: <20240116130213.172358-6-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116130213.172358-1-chigot@adacore.com>
References: <20240116130213.172358-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This allows the guest program to know its cpu id.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.c    | 16 ++++++++++++++++
 target/sparc/helper.h    |  1 +
 target/sparc/translate.c | 13 +++----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index bd10b60e4b..2247e243b5 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -212,4 +212,20 @@ void helper_power_down(CPUSPARCState *env)
     env->npc = env->pc + 4;
     cpu_loop_exit(cs);
 }
+
+target_ulong helper_rdasr17(CPUSPARCState *env)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong val;
+
+    /*
+     * TODO: There are many more fields to be filled,
+     * some of which are writable.
+     */
+    val = env->def.nwindows - 1;    /* [4:0]   NWIN   */
+    val |= 1 << 8;                  /* [8]      V8    */
+    val |= (cs->cpu_index) << 28;   /* [31:28] INDEX  */
+
+    return val;
+}
 #endif
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 55eff66283..fc818b8678 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -2,6 +2,7 @@
 DEF_HELPER_1(rett, void, env)
 DEF_HELPER_2(wrpsr, void, env, tl)
 DEF_HELPER_1(rdpsr, tl, env)
+DEF_HELPER_1(rdasr17, tl, env)
 DEF_HELPER_1(power_down, void, env)
 #else
 DEF_HELPER_FLAGS_2(wrpil, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9387299559..1cabda9565 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -37,6 +37,7 @@
 
 #ifdef TARGET_SPARC64
 # define gen_helper_rdpsr(D, E)                 qemu_build_not_reached()
+# define gen_helper_rdasr17(D, E)               qemu_build_not_reached()
 # define gen_helper_rett(E)                     qemu_build_not_reached()
 # define gen_helper_power_down(E)               qemu_build_not_reached()
 # define gen_helper_wrpsr(E, S)                 qemu_build_not_reached()
@@ -2681,16 +2682,8 @@ static bool trans_RDY(DisasContext *dc, arg_RDY *a)
 
 static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 {
-    uint32_t val;
-
-    /*
-     * TODO: There are many more fields to be filled,
-     * some of which are writable.
-     */
-    val = dc->def->nwindows - 1;   /* [4:0] NWIN */
-    val |= 1 << 8;                 /* [8]   V8   */
-
-    return tcg_constant_tl(val);
+    gen_helper_rdasr17(dst, tcg_env);
+    return dst;
 }
 
 TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
-- 
2.25.1


