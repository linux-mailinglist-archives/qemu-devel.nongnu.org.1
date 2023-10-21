Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303BA7D1AE6
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4az-0007Bp-Ke; Sat, 21 Oct 2023 01:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4au-0007A7-2a
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:16 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4as-0008Ov-FK
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:15 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso1675038b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866333; x=1698471133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRMTQptI2nfQXOSpXQo/O0ul1mHB/BhVdQiXtwwiUDw=;
 b=B/utY96650aNFsj48teI+n7ofj+ivT4P2GH4iyuoOBB0rzbTrQpw6AJ4RpGF1vTAyg
 RYXIIrQJBQaRSktow+cU4FjOg6PXbVH8ytAlKvFSHELw/Q/+YYxtf08KBkoPGCAcR/no
 WUFFYuvmjzQ5NlNB1yIMnTihPv2qasttEtDi4ppcS6XZzULBA8sODf6EV4jcZJZCsNAY
 oAoyNqa6z7PrN4Xsitft5tBlGphx6dCaWq6G6I5m89HRTcGa3KaAWlvJiOITOv3GlMek
 fDLi8cdb0aGYGjc2/QXfN1CDjBfy6Bbwg4eWSNnOvR5yW2MQ/Zz33a0mRMDRx0q1ucX7
 HE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866333; x=1698471133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRMTQptI2nfQXOSpXQo/O0ul1mHB/BhVdQiXtwwiUDw=;
 b=l84ghE3iiOIRooF69BSi2zRmr51qHC6Y7CNwUvQ/Q+iCfgTD25GkPt/PHIILfvJ1wG
 Gx8gG/Z29Ea8Z1HaPwrH0DB836jOr+l6xlBwXBE0j8ed/i98W0N5Esd0nOqp2Oy5h8Do
 H05FF52GHYaX7jJNvR93j9s+FJBnj9iVrzsiGbhcRZU3L1L4n9HCcIYdj8d+AmzMnCJS
 z5gFadY/WAiBBap2TLo6h2NV9OO3PLFzitagdOmodu5co+y81v3fzIfCAFDceLABxXpb
 ffwOVhoMKJH+gTNSUIwvnBs1lhAiyqM/CWuWpTEbcwgTzPBgOcQ0ga5rP9dP23NKaYpd
 srKQ==
X-Gm-Message-State: AOJu0YxIoG3TiG1l/ED0KNLFUGzel/Pg9dBenANKqXmn72eyqSTJ8vWl
 OCzgEx0KkPE13I9DckuJKUoBNeUKSWDAMdmODco=
X-Google-Smtp-Source: AGHT+IG6O7LSJfxsBiXz3k4sqeoxC7Ox/qvdR1iaymcUVUywkSvmjPOx9VboGjRm+WAKU0IMGRtgiw==
X-Received: by 2002:a05:6a20:8e23:b0:15a:4c23:870b with SMTP id
 y35-20020a056a208e2300b0015a4c23870bmr4682658pzj.23.1697866333106; 
 Fri, 20 Oct 2023 22:32:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/90] target/sparc: Merge gen_fcond with only caller
Date: Fri, 20 Oct 2023 22:30:44 -0700
Message-Id: <20231021053158.278135-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/sparc/translate.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2664db302d..b8d51d6d64 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1309,19 +1309,6 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
     }
 }
 
-static void gen_fcond(TCGv r_dst, unsigned int cc, unsigned int cond)
-{
-    DisasCompare cmp;
-    gen_fcompare(&cmp, cc, cond);
-
-    /* The interface is to return a boolean in r_dst.  */
-    if (cmp.is_bool) {
-        tcg_gen_mov_tl(r_dst, cmp.c1);
-    } else {
-        tcg_gen_setcond_tl(cmp.cond, r_dst, cmp.c1, cmp.c2);
-    }
-}
-
 // Inverted logic
 static const TCGCond gen_tcg_cond_reg[8] = {
     TCG_COND_NEVER,  /* reserved */
@@ -2992,6 +2979,7 @@ TRANS(BPcc,  64, do_bpcc, a)
 static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
 {
     target_long target = address_mask_i(dc, dc->pc + a->i * 4);
+    DisasCompare cmp;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
@@ -3003,7 +2991,13 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
         return advance_jump_uncond_always(dc, a->a, target);
     default:
         flush_cond(dc);
-        gen_fcond(cpu_cond, a->cc, a->cond);
+
+        gen_fcompare(&cmp, a->cc, a->cond);
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


