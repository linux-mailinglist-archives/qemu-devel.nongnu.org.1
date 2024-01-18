Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3347831C23
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:14:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU0p-0000xK-2b; Thu, 18 Jan 2024 10:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0S-0000ef-PF; Thu, 18 Jan 2024 10:08:39 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0R-0008AS-0J; Thu, 18 Jan 2024 10:08:36 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d6f2443b06so13154165ad.2; 
 Thu, 18 Jan 2024 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590512; x=1706195312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vy60hrRrrlBavCX3H9x/6nZdx6ZqVNqV3pobq9fWbpc=;
 b=R05W4jzDC1JtKla/VR9w/Ldwh8IZ3JHBXcBr2yt5RKTNYw46laAJg8f4EOdIqZ5sbO
 TvBL+MljbabfqS7XkMYk1HxMoDnLYXnWFTP2X2g7PTaM9kK2dHPOZs3XlTsFGgRvl3Zq
 CH0iR00jwXkqOL+0wO2qGKo8h/YH0oQM83iz6eRwhOHr0ibewqZ+tMBWXEOR+ZTVlSxZ
 cLQ3Z2zD8wLl0BPMv0al2KtzINVQUKUsKgQY1Ss3piepgZEejwdknwjgX3kQkpEpyuA5
 RDosnTx7rH8+B6tA1RWh+hSBv143pZXCwDERqzqLK+eyfbfogwQnTBEHBWrZwx0FHaCl
 ceBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590512; x=1706195312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vy60hrRrrlBavCX3H9x/6nZdx6ZqVNqV3pobq9fWbpc=;
 b=aR5Z6nPfIYTRm2BV7okY+n66UWLXxcSAoNomnQnPUCKnsBAFrA1EWVkZPBMHew1sdc
 m75XzktU8NcYaZaiqBF8a9Rlo4yvWM4rWvaqRJquTeCJDGh6LFGfixoXjsuY2G2ga5k9
 E+jb3IZNPNGD87pUYMRp6CPhSYFbpp/6wwJlmJ6VS0H9w+DyWnPVmO4STZgPrwotLdLf
 PIPY98uk/p6FNkcJxXOoJWtKRZz4/DSdQo2tPXdd9mBPA7ID4YQNTcOUyQ8rdjVANyuy
 q9e+d2Dv6aeScF6p0RrQCZj1wwZZKthNQKn5xtjaqBvBNKU84QSXp3NXwfDBNNcoGLwx
 r/EQ==
X-Gm-Message-State: AOJu0YxNuGomI09BcEFtGFWlpj+akHt3WRF9xpcRlrIAuRHtmcFJoh/Z
 0SGL6Xlg0mYWTi4tUvjpjp0k/CntK+k1rMUXPVFZPveVo+FLNypDWkLUjgQY
X-Google-Smtp-Source: AGHT+IEebBuVKnO/wEjvLFnuAkft97FP4er3VEiAWpHgrJJPrTWX/S3KcBnDIjxdd5uEOwE+vvxQMw==
X-Received: by 2002:a17:903:32c3:b0:1d5:78db:4293 with SMTP id
 i3-20020a17090332c300b001d578db4293mr1142158plr.29.1705590512290; 
 Thu, 18 Jan 2024 07:08:32 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 21/26] target/ppc: add helper to write per-LPAR SPRs
Date: Fri, 19 Jan 2024 01:06:39 +1000
Message-ID: <20240118150644.177371-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

An SPR can be either per-thread, per-core, or per-LPAR. Per-LPAR means
per-thread or per-core, depending on 1LPAR mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/spr_common.h |  2 ++
 target/ppc/translate.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 9e40b3b608..85f73b860b 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -83,6 +83,8 @@ void spr_read_generic(DisasContext *ctx, int gprn, int sprn);
 void spr_write_generic(DisasContext *ctx, int sprn, int gprn);
 void spr_write_generic32(DisasContext *ctx, int sprn, int gprn);
 void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn);
+void spr_core_write_generic32(DisasContext *ctx, int sprn, int gprn);
+void spr_core_lpar_write_generic(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR0(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR1(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCRA(DisasContext *ctx, int sprn, int gprn);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c5089f90f6..e7749d9b32 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -472,6 +472,32 @@ void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn)
     spr_store_dump_spr(sprn);
 }
 
+void spr_core_write_generic32(DisasContext *ctx, int sprn, int gprn)
+{
+    TCGv t0 = tcg_temp_new();
+    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
+        spr_write_generic32(ctx, sprn, gprn);
+        return;
+    }
+
+    if (!gen_serialize(ctx)) {
+        return;
+    }
+
+    tcg_gen_ext32u_tl(t0, cpu_gpr[gprn]);
+    gen_helper_spr_core_write_generic(tcg_env, tcg_constant_i32(sprn), t0);
+    spr_store_dump_spr(sprn);
+}
+
+void spr_core_lpar_write_generic(DisasContext *ctx, int sprn, int gprn)
+{
+    if (ctx->flags & POWERPC_FLAG_SMT_1LPAR) {
+        spr_core_write_generic(ctx, sprn, gprn);
+    } else {
+        spr_write_generic(ctx, sprn, gprn);
+    }
+}
+
 static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
 {
     /* This does not implement >1 thread */
-- 
2.42.0


