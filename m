Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F387C8F0A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:30:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiP-0006D9-GS; Fri, 13 Oct 2023 17:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiN-0006Cg-UF
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:59 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiM-0000Rx-C0
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:59 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57b74782be6so1356305eaf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232537; x=1697837337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxgRnIm4dUpDEBZ3CmjdW0lb2sqX4MaY0GW5BhVXm9s=;
 b=zzJ2+VAf3bkFsPPtVHLHVmg64JfNguF6PmKw2RcVeh/wkghfb0I0qlSXc+Xu1PzykT
 +c2OchzeWqdqBAXfKp14U8UjmH26OEIQTNcIdlGd1FRErPRkbMPy0wYWXtQtfJJPQ33C
 jQ8F9m23euVgFlU6ph+X4++fF/0QKHEMjLtpZW/4006DpKm7ENnt9YHDj/11bj1NxjlK
 Twh3XlOFnc3d+qHGqXBmjyOHG0mjVnxT0G92PNQGywqLKQoI+tVECKHq9B4UX8sLXJHA
 Be4/AAXWNx3gFsV9asd0kp71Z8HC/NnlwmbucRxBVk3PLbo5A8y60Fj0S2lzlajOuhyI
 unNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232537; x=1697837337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxgRnIm4dUpDEBZ3CmjdW0lb2sqX4MaY0GW5BhVXm9s=;
 b=qVsdLLpE20YTen7nfEZeBFaBVbN/8v65gBtDHh5h/UpaYR5Isr7uXC4AlttN3qpE9g
 OSN/hYy3drUTnC2sdR9zFX+8W0DVvT/Q8CNsbVeF87Xg4wawjdhxSnmETNECdUIJJ4Hz
 ZXULLx9aBI/j8vtBgnV/1N2dpHME72fEva7h6koUrxCv71tvlo13yCUwkqux1a8Ggitx
 xtkmpdrG8Ci355lVJTEZGfhX0j4u3SuvC+X8k/eQUsvZA7pbKM4TbgmfG9s/02tC52pY
 0ZHuxXDn7s7Ad9NVRHgTYMJyGXGTrmb56hVXL2g7eP7X85icNfuateietPWoKLqIlFxI
 8Mdw==
X-Gm-Message-State: AOJu0Yz4wSpj60RTwcTNWtyAolSrPfuCWuRFvSqbPq82CixAZ0Swp35u
 qpfhEfCf06f4M1/QfWfoH/9MmZ1j9lGTrU+7lZA=
X-Google-Smtp-Source: AGHT+IFdtiKoVn7r2N0TQHwNDU7yRDDzd/+VO1uTd8NIw8YyBg9Xfd/MFcWaOJTyjkVK3Y4aETB3QQ==
X-Received: by 2002:a05:6358:430c:b0:134:ea45:53d7 with SMTP id
 r12-20020a056358430c00b00134ea4553d7mr32913739rwc.26.1697232537298; 
 Fri, 13 Oct 2023 14:28:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 10/85] target/sparc: Merge gen_cond with only caller
Date: Fri, 13 Oct 2023 14:27:31 -0700
Message-Id: <20231013212846.165724-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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
 target/sparc/translate.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8c15ca08c4..1ac3bdd03f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1265,20 +1265,6 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
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
@@ -2936,6 +2922,7 @@ static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
 static bool do_bpcc(DisasContext *dc, arg_bcc *a)
 {
     target_long target = dc->pc + a->i * 4;
+    DisasCompare cmp;
 
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
@@ -2947,7 +2934,13 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
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


