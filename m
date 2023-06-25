Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8271F73D022
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 12:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDN7R-0001gD-8D; Sun, 25 Jun 2023 06:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDN7J-0001fm-Eq; Sun, 25 Jun 2023 06:37:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDN7G-0001gV-Og; Sun, 25 Jun 2023 06:37:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b5422163f4so18726375ad.2; 
 Sun, 25 Jun 2023 03:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687689428; x=1690281428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tb5eqhpSBrUMtUUyvYiVbs030OE5D++w6YJ7FotUsnY=;
 b=FLrMJFalREN/H9N+BpXbe2vaGFzhv1T+tFAs3PjwEh/AynjkuhmAgcJhLf0cP1EWoN
 hnpXZaM5zFIMipvYCS9l8Ha7sy9gJo0CLURcIwcgezhaQLhSromEEhUgxku7OkSSyEGX
 JTuLwEBlThs/2FpkP7phUMpOwHAeh5rWF4I+wLG4zTFNhthcuAgi7v31u02spOKtOv0H
 6Qo4kAe1lq6d8KLjzSOWrcVfTEnUVEZBfoN5fJSclXn7TYGV+wHFWUKhveDoVtPFeiT+
 qUjnOIfRZtAkxU19MmvlhEbOSgrDYYjw4iW/UQGP5Gs7sUsLzRG+PMfPGmwW9LLoOzWY
 zsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687689428; x=1690281428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tb5eqhpSBrUMtUUyvYiVbs030OE5D++w6YJ7FotUsnY=;
 b=NkKqU9rXkXwknzjBzRFXiymoFkNllIlCoidYbb/Gz9NN5JBVINVth/GXFbysXmzRcL
 uoz8KqOr4jdcKf6Y1XTdDjcsM9ZaOzRjK8Wl2OKd80Pbhxf2GxqN8Q0O2UMpwk6oMkar
 MUHU6fwWKqN1G6eLMJMhZIvKD2DF6bby/2IS4Oc6OOi1zv57zr3i0IgPYH1BJ2JigfhB
 M4jXm7NJT+EGiyhLV+XcfpZZbx6quwtgg+83imBP+dSnOC+6o+bws5ufNTX+PAw0BnOX
 O2V/gT2MfecNsVPY7vdiMedtb1Qy1NIOixStvrMARq2hFpQ9VuzUcs3R6X1Kq6qf/3+g
 hd1w==
X-Gm-Message-State: AC+VfDzQPmCLHOL3SIIGY7y+ltrA5q6VP3gwkwoHFf0ffZln0cR1XXz3
 1Hl1UK/+ViAwDbr1pqE2kailY+QLo2I=
X-Google-Smtp-Source: ACHHUZ5yqrpYQOph3RwjcPsW00VVepDbQ7Q4ablYQQw/4lptBUtEKzl7lBCnL7bKFI2L3fov0VlQ2w==
X-Received: by 2002:a17:903:2793:b0:1b3:f8db:6f0c with SMTP id
 jw19-20020a170903279300b001b3f8db6f0cmr4079286plb.58.1687689428423; 
 Sun, 25 Jun 2023 03:37:08 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 n91-20020a17090a5ae400b002471deb13fcsm2299115pji.6.2023.06.25.03.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 03:37:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 1/2] target/ppc: Fix icount access for some hypervisor
 instructions
Date: Sun, 25 Jun 2023 20:36:59 +1000
Message-Id: <20230625103700.8992-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

Several instructions and register access require icount reads and are
missing translator_io_start().

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index eb278c2683..c1c3cd8767 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1177,6 +1177,7 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
 
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
 {
+    translator_io_start(&ctx->base);
     gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
 }
 #endif /* !defined(CONFIG_USER_ONLY) */
@@ -4002,6 +4003,7 @@ static void gen_doze(DisasContext *ctx)
     TCGv_i32 t;
 
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     t = tcg_constant_i32(PPC_PM_DOZE);
     gen_helper_pminsn(cpu_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
@@ -4017,6 +4019,7 @@ static void gen_nap(DisasContext *ctx)
     TCGv_i32 t;
 
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     t = tcg_constant_i32(PPC_PM_NAP);
     gen_helper_pminsn(cpu_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
@@ -4032,6 +4035,7 @@ static void gen_stop(DisasContext *ctx)
     TCGv_i32 t;
 
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     t = tcg_constant_i32(PPC_PM_STOP);
     gen_helper_pminsn(cpu_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
@@ -4047,6 +4051,7 @@ static void gen_sleep(DisasContext *ctx)
     TCGv_i32 t;
 
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     t = tcg_constant_i32(PPC_PM_SLEEP);
     gen_helper_pminsn(cpu_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
@@ -4062,6 +4067,7 @@ static void gen_rvwinkle(DisasContext *ctx)
     TCGv_i32 t;
 
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     t = tcg_constant_i32(PPC_PM_RVWINKLE);
     gen_helper_pminsn(cpu_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
@@ -4458,6 +4464,7 @@ static void gen_hrfid(DisasContext *ctx)
 #else
     /* Restore CPU state */
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_hrfid(cpu_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
-- 
2.40.1


