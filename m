Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E783316D
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:24:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQyCl-0000Wp-8N; Fri, 19 Jan 2024 18:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCj-0000Vr-59
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:17 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCg-0008GI-Gw
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:16 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33678156e27so946081f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 15:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705706593; x=1706311393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXasRInUYhxYQ7vo9aVxtxxPjnzjuuS5fA7fLDaoYN0=;
 b=wKmg20xDzz3S2PGRwNXhYnAn80LKKQi/joEOXbaPziC+3M4YJySvxHJ7vkI3tucBKo
 BLAQ8nqFy3N0eo1qKemKH/ByF7eLbLqsKbHa0XEgQNMSO+EzbdWixQ07azewgIOhq0Bj
 sLiXqVjjh3ozSTacVcGIab8dY5cXs3oiKJ4qhVxaXMAo4GMfrBg5yyKJKJZKj3oLbrp3
 hCCZcjaQeXjaGRMxTAFG5HTmiYwHKXsbFCBaZmNzLLlwYB2ASMxVW52+kDfRGO/kJoBi
 OIZWZJP2B0SChMD0BDyE7M/aNQCj7EaeCiOLbsgCNKPUQoMPhf9ohtUxTAqHllIJ2Uyf
 w5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705706593; x=1706311393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXasRInUYhxYQ7vo9aVxtxxPjnzjuuS5fA7fLDaoYN0=;
 b=dSpSaOzGtGsHNWK6XW7h9dOGNAlDFop4ygZk1uBNU67ljDFS+Kug6Vtdvk5tRDyvTg
 D0EOyJAnAH+ftap35cLkMOMdfB3UnGPT5FM7yiWU8PoPz5EmXMeVo9h79QHV/dVai+t1
 pVfgNADLPaKUFhpn6Zu0VMxeBXEn5CbU8n/2/hK4hW+JCYKEteaqtpS9kMGSqx4vl0Ib
 Sh6PssWPy7tArAJ+HfFe4zCJPhfFaUekkg4ga5Fd3GsfMKOC9xWEushahayuYtVTjIt/
 uW9fegIEcA2rcMZW0EDANwJr+c6u4gh4jcIBcixgRH5/NqDMBsBdALY3a/ELkBb9512i
 f17A==
X-Gm-Message-State: AOJu0YxM376e+jehMw8KUQk7o6BsXitQ03ze1R+p2i3K2M/o2RVi46mG
 WDVA5MXgqKoU5CW/VupOt+nW9tRLI5a/FgcZmuD4DjU6jKW2h2yUnh+RAeuASC28wIHaGch1p/o
 4
X-Google-Smtp-Source: AGHT+IFGr0kiKvlEs9hQqcY0IjR6HkqqFEVwr9ueWQfWn8H+X8bxrHpdzjpMiXmvXismJUZcseBccA==
X-Received: by 2002:a5d:4012:0:b0:337:9f2b:a2df with SMTP id
 n18-20020a5d4012000000b003379f2ba2dfmr266065wrp.47.1705706592824; 
 Fri, 19 Jan 2024 15:23:12 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 t26-20020adfa2da000000b00337c0cacf54sm7579061wra.101.2024.01.19.15.23.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 15:23:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/38 3/6] target/s390x: Reorder CC_OP_STATIC switch case
 in disas_jcc (3/5)
Date: Sat, 20 Jan 2024 00:22:59 +0100
Message-ID: <20240119232302.50393-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110224408.10444-16-richard.henderson@linaro.org>
References: <20240110224408.10444-16-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Code movement to ease review, no logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index aedce85029..fd1138c684 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -910,12 +910,6 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(1);
             break;
-        case 0x8 | 0x2: /* cc == 0 || cc == 2 => (cc & 1) == 0 */
-            cond = TCG_COND_EQ;
-            c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
-            break;
         case 0x8 | 0x4: /* cc < 2 */
             cond = TCG_COND_LTU;
             c->u.s32.b = tcg_constant_i32(2);
@@ -924,6 +918,18 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(0);
             break;
+        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
+            cond = TCG_COND_NE;
+            c->u.s32.a = tcg_temp_new_i32();
+            c->u.s32.b = tcg_constant_i32(0);
+            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
+            break;
+        case 0x8 | 0x2: /* cc == 0 || cc == 2 => (cc & 1) == 0 */
+            cond = TCG_COND_EQ;
+            c->u.s32.a = tcg_temp_new_i32();
+            c->u.s32.b = tcg_constant_i32(0);
+            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
+            break;
         case 0x4 | 0x2 | 0x1: /* cc != 0 */
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(0);
@@ -932,12 +938,6 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_GTU;
             c->u.s32.b = tcg_constant_i32(1);
             break;
-        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
-            cond = TCG_COND_NE;
-            c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
-            break;
         default:
             /* CC is masked by something else: (8 >> cc) & mask.  */
             cond = TCG_COND_NE;
-- 
2.41.0


