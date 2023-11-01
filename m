Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C354B7DDBCB
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:13:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aB-0005yG-4q; Wed, 01 Nov 2023 00:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a5-0005xF-Lm
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:50 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a4-0007Za-7T
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:49 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-da0cfcb9f40so5226244276.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811907; x=1699416707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93dCSJrm44LkdzbP5+WJG6+06al2nZXixDKJsA+6dnE=;
 b=pDMfaa1PMLS2Nj+S3Bw3SZb663SFJtVySwV9tecbBb5zmWsym9zvNP6tS9CGqHxL6a
 EV4x9DEmhqFCvZ+CjLPtfYABTvOfnTF7XN5gII82uJLDaqOmzt3fyDCuRELWaF12y2Sc
 FdOYs+vXlets5soRcxi0565Uq2p60hP5snCFaBwxK8G5qC9iDzAjTY9Bi/iSBuUxdXe3
 fKJNJNptFhEyYfkwvPsfHc6gih4NzwmpGk5448C8nWSsVAcP0tO7Iu/nplykAkFUFgYO
 unlxc5DEvOxsfKKXv9nxBXfYsg4ViID6tna/8ylNiOZvXOFg63EH91apWM3hbkehYlpO
 Fs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811907; x=1699416707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=93dCSJrm44LkdzbP5+WJG6+06al2nZXixDKJsA+6dnE=;
 b=VTWBPQm6Upt78VhkjrXWcx4tEda0+teK1WqceXin/B7/H5JItieJj5TyeSDKcpA/eB
 1q+ts/UTJUxK3ZL/DqMoQEFnzOQhE41THOON64QyrDoKot9TaaMnDOG2fK9gk6f6gbQf
 1gck1q8oDFmnkilu9ALDhztHQxJ1wL9TSUXAae4ca4+U5nOzL4JE6Dp2ldEXU7aJmpCa
 0Uncw1jqvJP8zQJcfDpzzmwVZyLpYgdhJhjVm7p991u9yVHweJXtnjP0xbxvu1QUzuPT
 TtYIG4+ITTjxMoTzdBBZGpfR4GFZ7D7y27YraEq63HbRKtDWbdRq0exXU02lm1ZVWtuP
 OJgA==
X-Gm-Message-State: AOJu0YztAacTbtI+bosc2m1eMwFso+izhyyhxwVZjxnz5JJQWPY9WoCd
 BGIkC+8Zb2mv9D6CPpVnKGqGQAj2Q+q2mrQYd14=
X-Google-Smtp-Source: AGHT+IFCj4o+/QzhRt7iHUBGpWQzNNHnDjWRP9bHhynHCKj9QuvFrc65AeWKIC4UzMEIoeNU4ZDTPQ==
X-Received: by 2002:a25:c5c6:0:b0:da0:46e5:a7e3 with SMTP id
 v189-20020a25c5c6000000b00da046e5a7e3mr13448255ybe.20.1698811906913; 
 Tue, 31 Oct 2023 21:11:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 15/21] target/sparc: Pass displacement to advance_jump_cond
Date: Tue, 31 Oct 2023 21:11:26 -0700
Message-Id: <20231101041132.174501-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2c.google.com
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


