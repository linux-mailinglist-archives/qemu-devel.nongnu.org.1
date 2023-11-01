Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC807DDBD9
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:15:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aC-0005ya-PA; Wed, 01 Nov 2023 00:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a8-0005xr-JO
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a1-0007Yt-MX
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:52 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso366622b3a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811904; x=1699416704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zI0pCBQLHasJTvgPVEjz4kIyqL9hNkSrswDbsWUPfUs=;
 b=dgEL0II3CQ40zdMptulEjiT/PdrI539jaw/v5OckCMTEIrxEoA1w98P0aVs9iW71P+
 bxAGpaxV5RmH+RcxvP0q6bdK2sMV86XmgPPh4YIJdrVkp0Wj0ujtAJOxC38RxjLibWPY
 YsaEeDIMni5cQLFsU8y3fj5FXWxgF3x9DsOta8NJN86kwmgW4I9sVDSSUZuaGrJ5VzID
 lUCZfP5lxzvd9EbHISJkLecopgFQYMaYoBGMXKkCGEh/o8UJOQ5R3PgntRJRz8gDSv3+
 dps0ZYrUa/6U5ZHCXtM3nLUi/d/sbiHqnC5v8X/0nKZANC+OoU7QsAj/+yyZDXwQy7rn
 95ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811904; x=1699416704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zI0pCBQLHasJTvgPVEjz4kIyqL9hNkSrswDbsWUPfUs=;
 b=lOd4CX5v2mPC4KSVUCE0y5oQXK/j2NOno/3s1y2k2uDdj0CGCFyzDyoxOBGvICEJDz
 6Fxrf8sRAaxX2nsUNKn1B7EfPi1p+/xCglvWBSIPtwE85gbe5Xffn6yg3T/cyysL4I+t
 kW+Ovr+hrJsw4zwzXxZGDd6JUOhYGaeJjw/CU/UvFJBLMthx8iirIbvJUHjCuZCaDBvP
 fkxB04NtkPUMnNuYB0LBF7xLBZyK3z0fZ3I3uG5+0MqC/aHU25vXN5jska/Un6Xzi8U3
 btKiC7xVC2fzzKTPSA4UsbLEGr50BETsbD+EdfJtcg/SE4IF8r+oQMA+9Lp/6EbDnc0p
 aXdw==
X-Gm-Message-State: AOJu0Yz7i456u+ujozFSb044QXXsgzAgc4h46Y6FBXX/JUdjs4jXIDj8
 +7XMoqALzm8Zh5WhcNILqroGv+Wnrb/6oM/1Cuo=
X-Google-Smtp-Source: AGHT+IFLxRuwqza6Yg4sAbQ9WMS5q6OquPmid5DGXcDi6VyHFsDMr+DUS7daA6IiFdZmYP8HAuvnAA==
X-Received: by 2002:a05:6a21:33a1:b0:177:a131:f31c with SMTP id
 yy33-20020a056a2133a100b00177a131f31cmr6260887pzb.13.1698811904289; 
 Tue, 31 Oct 2023 21:11:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 12/21] target/sparc: Do flush_cond in advance_jump_cond
Date: Tue, 31 Oct 2023 21:11:23 -0700
Message-Id: <20231101041132.174501-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Do this here instead of in each caller.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index dd6d43d1f1..2e7deb5e33 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2407,7 +2407,10 @@ static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
 static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
                               bool annul, target_ulong dest)
 {
-    target_ulong npc = dc->npc;
+    target_ulong npc;
+
+    flush_cond(dc);
+    npc = dc->npc;
 
     if (annul) {
         TCGLabel *l1 = gen_new_label();
@@ -2481,8 +2484,6 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
     case 0x8:
         return advance_jump_uncond_always(dc, a->a, target);
     default:
-        flush_cond(dc);
-
         gen_compare(&cmp, a->cc, a->cond, dc);
         return advance_jump_cond(dc, &cmp, a->a, target);
     }
@@ -2505,8 +2506,6 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
     case 0x8:
         return advance_jump_uncond_always(dc, a->a, target);
     default:
-        flush_cond(dc);
-
         gen_fcompare(&cmp, a->cc, a->cond);
         return advance_jump_cond(dc, &cmp, a->a, target);
     }
@@ -2527,7 +2526,6 @@ static bool trans_BPr(DisasContext *dc, arg_BPr *a)
         return false;
     }
 
-    flush_cond(dc);
     gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
     return advance_jump_cond(dc, &cmp, a->a, target);
 }
-- 
2.34.1


