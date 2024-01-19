Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AE2833170
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:24:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQyCw-0000as-Su; Fri, 19 Jan 2024 18:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCv-0000a6-3I
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:29 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCt-0008Ir-Gy
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:28 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40ea34df934so1926735e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 15:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705706606; x=1706311406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIz5d9b5T7LFW05WUUJ9h1myyFYL4h2BqUyq/mWZyYE=;
 b=ARmT+CX6lA5xohdQUMVcmHbVZfaZiMSfUmZGGWRt+EFmWCUwLOcXGgeODyR1SOSUda
 rqJ8taiE6zuXCxc0FWQZy5Txl9a3znHVbF0r8nR3p5IAH3Zqpn1e9RPloBcb0gLcUOLK
 y6G/NgDv3nlTVrxgX2NONBeE5aN/xjwFuF+hPxsjswiGbgfpCxW3Ts+AWTBU5Qv4mkRp
 QoWVqlzEUlo6zvFAmq85U/20C1OYOfvzZQBVY57uXL3FoknSouXuH58rVZfEaKTa3Q4n
 gQuyMD1hPypqczHPlhL1b/gbZV7nk6pEL4097flh3RzbU0sK0iDfX0VJgr64orPChn77
 FE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705706606; x=1706311406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIz5d9b5T7LFW05WUUJ9h1myyFYL4h2BqUyq/mWZyYE=;
 b=PX/QTeKS5Jn5n+/t4lqPmXWJiXzMxiM1PxurjNbOb7Z+T5VOzNTA9Znyaxth2zSckG
 UwWUs5MoEFYlqM3CB3pzc6hp9LLHgUV/4hyZ6419XmLE6ubVPS5pgTjuY7zmK7rslm7X
 ++Pc9TZc3HCTGLensVGuHEu/mslOdzrGIkk+TJQIyzevGrnQe4YYM9kKlgyswN122jsI
 yiSf7WH8dBB7D6mrrsAg55IEdaKPH+XYZyw++B8L+z+5GeV+2agtcwl+15kJ4M5h0/aJ
 wx/49gGyZQlsOGZdtsrIk9z/BRIuHJ41Wqz5KLaviKvvYoTBMxEK39eNaEzzNIR1zCHs
 ZR/w==
X-Gm-Message-State: AOJu0Yz9MlQ69Z0autRTXqMtOw6ww6bOccwkK6HRQooHQFfU4ue7WtUK
 EnJl2Le3NWweCMj8hDWLfolhCCgqGxaaUzzN8+aO8XQ734ECDHJkHPhvo74TZer2pLC5hmejvoH
 J
X-Google-Smtp-Source: AGHT+IFVxd8YvHhj4sgjJle9cy1pelY/JRV52XNDP7yR6DYD/xDEfLyxsY2VAQSnGnUhMQ3oTeRpDw==
X-Received: by 2002:a05:600c:3553:b0:40e:5a80:7e7c with SMTP id
 i19-20020a05600c355300b0040e5a807e7cmr269027wmq.7.1705706606004; 
 Fri, 19 Jan 2024 15:23:26 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 je14-20020a05600c1f8e00b0040e3635ca65sm34333850wmb.2.2024.01.19.15.23.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 15:23:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/38 6/6] target/s390x: Improve general case of disas_jcc
Date: Sat, 20 Jan 2024 00:23:02 +0100
Message-ID: <20240119232302.50393-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110224408.10444-16-richard.henderson@linaro.org>
References: <20240110224408.10444-16-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Avoid code duplication by handling 7 of the 14 cases
by inverting the test for the other 7 cases.

Use TCG_COND_TSTNE for cc in {1,3}.
Use (cc - 1) <= 1 for cc in {1,2}.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 52 +++++++++++-------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 93c64db33e..030c026699 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -885,67 +885,45 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
     case CC_OP_STATIC:
         c->is_64 = false;
         c->u.s32.a = cc_op;
-        switch (mask) {
+
+        /* Fold half of the cases using bit 3 to invert. */
+        switch (mask & 8 ? mask ^ 0xf : mask) {
         case 0x1: /* cc == 3 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(3);
             break;
-        case 0x8 | 0x4 | 0x2: /* cc != 3 */
-            cond = TCG_COND_NE;
-            c->u.s32.b = tcg_constant_i32(3);
-            break;
         case 0x2: /* cc == 2 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(2);
             break;
-        case 0x8 | 0x4 | 0x1: /* cc != 2 */
-            cond = TCG_COND_NE;
-            c->u.s32.b = tcg_constant_i32(2);
-            break;
         case 0x4: /* cc == 1 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(1);
             break;
-        case 0x8 | 0x2 | 0x1: /* cc != 1 */
-            cond = TCG_COND_NE;
-            c->u.s32.b = tcg_constant_i32(1);
-            break;
-        case 0x8 | 0x4: /* cc < 2 */
-            cond = TCG_COND_LTU;
-            c->u.s32.b = tcg_constant_i32(2);
-            break;
-        case 0x2 | 0x1: /* cc > 1 */
+        case 0x2 | 0x1: /* cc == 2 || cc == 3 => cc > 1 */
             cond = TCG_COND_GTU;
             c->u.s32.b = tcg_constant_i32(1);
             break;
         case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
-            cond = TCG_COND_NE;
-            c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
+            cond = TCG_COND_TSTNE;
+            c->u.s32.b = tcg_constant_i32(1);
             break;
-        case 0x8 | 0x2: /* cc == 0 || cc == 2 => (cc & 1) == 0 */
-            cond = TCG_COND_EQ;
+        case 0x4 | 0x2: /* cc == 1 || cc == 2 => (cc - 1) <= 1 */
+            cond = TCG_COND_LEU;
             c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
+            c->u.s32.b = tcg_constant_i32(1);
+            tcg_gen_addi_i32(c->u.s32.a, cc_op, -1);
             break;
         case 0x4 | 0x2 | 0x1: /* cc != 0 */
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(0);
             break;
-        case 0x8: /* cc == 0 */
-            cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(0);
-            break;
         default:
-            /* CC is masked by something else: (8 >> cc) & mask.  */
-            cond = TCG_COND_NE;
-            c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_shr_i32(c->u.s32.a, tcg_constant_i32(8), cc_op);
-            tcg_gen_andi_i32(c->u.s32.a, c->u.s32.a, mask);
-            break;
+            /* case 0: never, handled above. */
+            g_assert_not_reached();
+        }
+        if (mask & 8) {
+            cond = tcg_invert_cond(cond);
         }
         break;
 
-- 
2.41.0


