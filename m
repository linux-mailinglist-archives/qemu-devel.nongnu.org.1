Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 233077CBAAF
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKC-0000Da-82; Tue, 17 Oct 2023 02:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK9-0000C5-Rp
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK8-0003sH-8L
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ca816f868fso10897855ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523179; x=1698127979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RafFmEyJOAItMlOtA/gMolHSxQeU0aHLQzOGBDw+LBY=;
 b=dRwikxqqsX/AslnRh89hbEV2SXlvNm3B6L18ka5+8juQYUj0kFUpSBs+Wx9hg+nbOo
 T0Yeowdd/Pp6xJgnE8toWJ8FODm9qLzH9e8exbvU6j47Kd4MjkyzBEJYm7vZBVShhY0h
 LlrmLStCJ2tXGw6fpO10NMoAti3QdXIPhJx4GGIlyzF/9aI3k52TNASp4WvHjdpv+UjC
 Z3XCEGXOC0pOcWWRflL+LFNc4kMUewdUPr96j4sy9pzesmq41Ei3DxtAAifwBzYk1A5O
 z0sV9egeAuCwVopRkHaA3dLQ1twZtygWwdFbVqRAA88b9RnVTP+B0Awv/CTyBdkw7ChF
 o9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523179; x=1698127979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RafFmEyJOAItMlOtA/gMolHSxQeU0aHLQzOGBDw+LBY=;
 b=S0RB3mWfRPbZII9jNg4wR9Q09B7oBytpg31ED2dtPkpeRW5YXCFlfwd0+PeT6CnA3M
 l1F3FhIHqzzorvHCXMotIuIEnpXg8O8iqpzEYFgjAXY0FVO5/WEYInPpwo6TCVe0cUMB
 taR+zvH9+r9fb7HFy56RWcOu+0NqDR1HkQUYzmb72AWXMN90yNywUy9eTHO5mOrOUCNF
 h+w/fELAg99Dw21XQSlC5s6Qo7osEnJp8jwFKUc4jc8HWZWTJ/0zjxGncsslFdIVoTk1
 KUksNHE2STKNvUoWtnT+Z5lVO7NYwkLeBazRwl2j3szhiyIVfo63OHr4tmaF+REyTaGj
 5dIA==
X-Gm-Message-State: AOJu0Yw2cMVdDS8jxDVBUcsnNXQndoOZ8NCRvzPZ099Is9e83YHKDk9b
 inoA2wFCKx2CwR0i1u79FtzGpNva9EEBXc8y1d4=
X-Google-Smtp-Source: AGHT+IEPH94uzV0kSulEe7nRAA3e2Q+lsKGv2mAm20HkoBC4kcx7OmAJlwFqzvAhqtlPSsnHxNWmFQ==
X-Received: by 2002:a17:902:d502:b0:1c7:4a8a:32d1 with SMTP id
 b2-20020a170902d50200b001c74a8a32d1mr1627053plg.28.1697523178797; 
 Mon, 16 Oct 2023 23:12:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/90] target/sparc: Merge gen_cond with only caller
Date: Mon, 16 Oct 2023 23:11:29 -0700
Message-Id: <20231017061244.681584-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a05cb59cd6..61a75b5fab 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1304,20 +1304,6 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
     }
 }
 
-static void gen_cond(TCGv r_dst, unsigned int cc, unsigned int cond,
-                     DisasContext *dc)
-{
-    DisasCompare cmp;
-    gen_compare(&cmp, cc, cond, dc);
-
-    /* The interface is to return a boolean in r_dst.  */
-    if (cmp.is_bool) {
-        tcg_gen_mov_tl(r_dst, cmp.c1);
-    } else {
-        tcg_gen_setcond_tl(cmp.cond, r_dst, cmp.c1, cmp.c2);
-    }
-}
-
 static void gen_fcond(TCGv r_dst, unsigned int cc, unsigned int cond)
 {
     DisasCompare cmp;
@@ -2975,6 +2961,7 @@ static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
 static bool do_bpcc(DisasContext *dc, arg_bcc *a)
 {
     target_long target = dc->pc + a->i * 4;
+    DisasCompare cmp;
 
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
@@ -2986,7 +2973,13 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
         return advance_jump_uncond_always(dc, a->a, target);
     default:
         flush_cond(dc);
-        gen_cond(cpu_cond, a->cc, a->cond, dc);
+
+        gen_compare(&cmp, a->cc, a->cond, dc);
+        if (cmp.is_bool) {
+            tcg_gen_mov_tl(cpu_cond, cmp.c1);
+        } else {
+            tcg_gen_setcond_tl(cmp.cond, cpu_cond, cmp.c1, cmp.c2);
+        }
         return advance_jump_cond(dc, a->a, target);
     }
 }
-- 
2.34.1


