Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6077E1640
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:13:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjUB-0003RA-VK; Sun, 05 Nov 2023 15:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU7-0003O5-Ep
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:39 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU5-0002AE-QA
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:39 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b2e44c7941so2521057b6e.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215156; x=1699819956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1YIzqOFSgMcnN6BcwtNadmOERabr9cbQIvdlvZH1EA=;
 b=Ximxj220XcPmDSdnSbGF6hP7NB9DLVVuBFWM+NnqUfAvO8W6DRd+aQ5McsmNll8Z4U
 0TMesuXwjErD+5iPHtMwzZvZgK8ySmkEuFcq5rj8i6HmWMFWUFx6Pz3JZI3mAvX6SHMF
 FTKOQ16tDzV46ShkuFhhNWc6VbrxdKqP07N5Vz98X8NmNvCe/OK+0PdMCFP9T4hraJ5a
 gq5pnvkZq5DK8JVYo4JPQDwX+e5M685fDH8grL8+uDzTLFH7tgbIAZSVZ+uVibyC0m5s
 59j54HT7CQASKQo6vF4QrxD/DuVeMekfV7EzmJMvXGg2Ly4Zzy1sQ4ZLHB+8NYibtDV9
 BwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215156; x=1699819956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1YIzqOFSgMcnN6BcwtNadmOERabr9cbQIvdlvZH1EA=;
 b=qzbB9WHiKPP93tMN6KNiocPYKvYTHDKcjMFaj3nZMqE5gYu4NXFym4RMiHESIPNrYc
 3PZL8IwF9NcR8X2YPrtkj2kyVRJja333hQyPa6S0EC1BlJPHiTWE/uTNpQ8A82dpsPsJ
 2/lk8BcGVz+bFCrtzH6z4salTmef+/JU0UbTeJSLEOVOc3tJwBF8RuHZpkGzYGBk6Rsv
 FNIAkbnhchQzicTeUcwUs2fAwrTJmYOXvrHiRWm0DljGSLm+L5ftHdnsj1y8s0N6UM1d
 dlGZ6Ya82DvaC6zN8zSzTjYQxnArUsuHDQOmYH99K3X+knZRloYWIrRBgDyJlAtv985f
 uQpw==
X-Gm-Message-State: AOJu0YxPYJcWQdrx3x65tMGde2yG/GfhlIMYhikG1oES+eLyCfR5BsxQ
 Q0pON1RvImPBoC3cGpAfQ/p4uyRbOrm4dLaveak=
X-Google-Smtp-Source: AGHT+IGs7iaONpqdFwFTIrWAmcleK/ATBn9989EsFuBS5mwzchpEDo+7zdknmgtVZy7xsA2OoFmjvw==
X-Received: by 2002:aca:1a02:0:b0:398:5d57:3d08 with SMTP id
 a2-20020aca1a02000000b003985d573d08mr28443756oia.37.1699215156742; 
 Sun, 05 Nov 2023 12:12:36 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 15/21] target/sparc: Pass displacement to advance_jump_cond
Date: Sun,  5 Nov 2023 12:12:16 -0800
Message-Id: <20231105201222.202395-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cbee5435a3..1233911b69 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2379,8 +2379,9 @@ static bool advance_pc(DisasContext *dc)
  */
 
 static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
-                              bool annul, target_ulong dest)
+                              bool annul, int disp)
 {
+    target_ulong dest = address_mask_i(dc, dc->pc + disp * 4);
     target_ulong npc;
 
     if (cmp->cond == TCG_COND_ALWAYS) {
@@ -2475,11 +2476,10 @@ static bool gen_trap_float128(DisasContext *dc)
 
 static bool do_bpcc(DisasContext *dc, arg_bcc *a)
 {
-    target_long target = address_mask_i(dc, dc->pc + a->i * 4);
     DisasCompare cmp;
 
     gen_compare(&cmp, a->cc, a->cond, dc);
-    return advance_jump_cond(dc, &cmp, a->a, target);
+    return advance_jump_cond(dc, &cmp, a->a, a->i);
 }
 
 TRANS(Bicc, ALL, do_bpcc, a)
@@ -2487,14 +2487,13 @@ TRANS(BPcc,  64, do_bpcc, a)
 
 static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
 {
-    target_long target = address_mask_i(dc, dc->pc + a->i * 4);
     DisasCompare cmp;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
     gen_fcompare(&cmp, a->cc, a->cond);
-    return advance_jump_cond(dc, &cmp, a->a, target);
+    return advance_jump_cond(dc, &cmp, a->a, a->i);
 }
 
 TRANS(FBPfcc,  64, do_fbpfcc, a)
@@ -2502,7 +2501,6 @@ TRANS(FBfcc,  ALL, do_fbpfcc, a)
 
 static bool trans_BPr(DisasContext *dc, arg_BPr *a)
 {
-    target_long target = address_mask_i(dc, dc->pc + a->i * 4);
     DisasCompare cmp;
 
     if (!avail_64(dc)) {
@@ -2513,7 +2511,7 @@ static bool trans_BPr(DisasContext *dc, arg_BPr *a)
     }
 
     gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
-    return advance_jump_cond(dc, &cmp, a->a, target);
+    return advance_jump_cond(dc, &cmp, a->a, a->i);
 }
 
 static bool trans_CALL(DisasContext *dc, arg_CALL *a)
-- 
2.34.1


