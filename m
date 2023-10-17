Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD57CBAC7
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:17:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKC-0000Dp-NX; Tue, 17 Oct 2023 02:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKA-0000Ca-JJ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK8-0003sN-Vp
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:02 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso35619145ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523179; x=1698127979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRsXuHDffyQpwn6iwozzaEFt19iWrF0/6hbYZNaItec=;
 b=ggdi0o949RNen9dKjvI4D3PY6M5SwI6LencNnYWbShsr+l1KKX4ARr0reUIPB5XmdT
 6CjAOKLihF2ZRuP1vyuFOov6f/QYzhAScd43a5I7gZGjZmmbIvvAnJlWi56Vbedi1UVH
 M/pKSJBgZPpK7ceKylkAF60NaXo5equzICdSA6S9Tkm/hsn+Rqx8isdLKT4MGgzQkJBR
 M862+rXWfp1jalrtHyiLaCREeATF6/h+VxD0K0/L7XI1RRX0jrtXTWwQlxQMSs96/BdB
 1zze5mqoP19LhTd7EoFbxJ0BLhAq7aVj8sFLyJm1Iv6HebY+Hy1bgcpJpYNHzei9gQhM
 0Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523179; x=1698127979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LRsXuHDffyQpwn6iwozzaEFt19iWrF0/6hbYZNaItec=;
 b=MwhpmQjwqzbju4JJBqbAovvQ+uN6h5urTgn8TJrhqYRUbFpoVZDGLeRG99c5aVo92z
 +0pab4dZuCbpH49XkS+oewq855x2zgX7tTgldP1Y6iKPKLago7k+C79O+pbKuvrX1mud
 vU+EvtW/qzzfJ5YTOyStQ34X/+ihc+g9qvK0OK4Y3sYJjsnaWIHL9B6A3Zr9r1TRv5A8
 vYU/26ShWHxPsZbxju0E8+6md0LB8DKmZ8F8VB0Rp9q3S3e6Vi3Y9MjTpTvI/+1C6btd
 DBBWNa93WocYxWn3i+nzmrku1B8WDMYsdkrhTbzoQVjj1NYrsJUWpxBdI5axBzxaDa+D
 J5vw==
X-Gm-Message-State: AOJu0YyN76Vjqz0bXbuKox7Jv2uwzeqszUSsH1zFJ8+1lOEWt8fgIba0
 xwJygIo+oPpBuKh02G8vl50Z/UOuaDBD54Prhmw=
X-Google-Smtp-Source: AGHT+IHOplmmT9sI9qfZbSGMOqkeJa14EywHrIe8G8QJrX3Z6fDmzgOIMbJyEnbFkoM4D8GIDm++pA==
X-Received: by 2002:a17:903:4346:b0:1c9:d358:b3d9 with SMTP id
 lo6-20020a170903434600b001c9d358b3d9mr1329367plb.18.1697523179553; 
 Mon, 16 Oct 2023 23:12:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 16/90] target/sparc: Merge gen_fcond with only caller
Date: Mon, 16 Oct 2023 23:11:30 -0700
Message-Id: <20231017061244.681584-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index 61a75b5fab..cc19f0606e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1304,19 +1304,6 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
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
@@ -2990,6 +2977,7 @@ TRANS(Bicc, ALL, do_bpcc, a)
 static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
 {
     target_long target = dc->pc + a->i * 4;
+    DisasCompare cmp;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
@@ -3004,7 +2992,13 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
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


