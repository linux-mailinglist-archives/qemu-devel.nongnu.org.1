Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4A83316E
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:24:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQyCj-0000V4-FY; Fri, 19 Jan 2024 18:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCd-0000TM-RJ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:12 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCc-0008Ff-7V
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:11 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e800461baso14328965e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 15:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705706588; x=1706311388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=choCcd5gHzMHamKyAS0rgRQ3ZokOOEbOjiuYNvJxvuE=;
 b=u7Yypr09BjZnqsOoSIRqt+GcM+05BAPZ2xTP3wg/935GIrT2o6LIdn+ZK6j9HDXbfJ
 lZsK/ObHCb73sNQ0faNLBepZEuoYYk2CFrGE2ozuM6JKkeHHpLkXJjsCcbzfnHxiQrTN
 E5Cdn5REi4pc18k+/8O6ISVu7QSPYcoYi7LaCBR3Eam8++oH+5DfqSC6pwosXlW1SMaz
 q9Cwps9UvzEd/HceRy6x0UU6X5ioBlcyAERdiFK5GXlHHB2GU4ibIaV3vJ7HTNIpyDwm
 aETWgtPFxZPPhE+g8E8xLh6AlzodtwLlaIOXFrCNhbFiD6GaWI1FO96PiututB07ShoX
 ceNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705706588; x=1706311388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=choCcd5gHzMHamKyAS0rgRQ3ZokOOEbOjiuYNvJxvuE=;
 b=m18bVFYIZZl6oDtCgiQyB7J5pJ15fs1qVeMxituZCoc2Qasl2mOn5gjY7MMNwbVxgg
 IzScDYxFwtdO32EG4UqIE3BtWZYfAi8f9R/RgW8wEDIbW40ddI1LA0xQidpyrGF9HtKF
 XSPG9j46PBX99yQ6DpnYzbb9hE0asnmMxGZqQ+mA8U1nXMdBvMQqoh9S8iQ5DcrY5hBK
 rC5lR7ELUODFhyrn7ylN0YnhxK43WongYctyxU2gZVxoV1CU1x1DcJdzBVzeoIEN2JoX
 /BPRA5A883UnNk+kWTUUoHLZb4NKtQ7/FqPQtd8dNUYm7GuUuLMBl11/cEcjNgn9Wwyr
 G5DA==
X-Gm-Message-State: AOJu0YyW/Wz57x6d318ov+68AV35ynzjUqm6TwfNoZtrOV2o9345kQAW
 40hOTY95N9Kc3Umq1NA0ayaBQs6SMaKTgDyMqmnfYSP9Sh6bejYoGX/NJAtImHm31tt1wwudW09
 F
X-Google-Smtp-Source: AGHT+IG65eESspvntsCaAcrrVWV4FnnZeMbSIvzG+jVgp7xejwRbyhUe91gKollgaFzCO7QcrtbEfw==
X-Received: by 2002:a7b:cc94:0:b0:40e:4863:6c21 with SMTP id
 p20-20020a7bcc94000000b0040e48636c21mr132736wma.341.1705706588394; 
 Fri, 19 Jan 2024 15:23:08 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 j21-20020a05600c1c1500b0040e9f7308f4sm2904997wms.10.2024.01.19.15.23.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 15:23:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/38 2/6] target/s390x: Reorder CC_OP_STATIC switch case
 in disas_jcc (2/5)
Date: Sat, 20 Jan 2024 00:22:58 +0100
Message-ID: <20240119232302.50393-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110224408.10444-16-richard.henderson@linaro.org>
References: <20240110224408.10444-16-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Code movement to ease review, no logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index e84c6459f0..aedce85029 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -886,14 +886,26 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         c->is_64 = false;
         c->u.s32.a = cc_op;
         switch (mask) {
+        case 0x1: /* cc == 3 */
+            cond = TCG_COND_EQ;
+            c->u.s32.b = tcg_constant_i32(3);
+            break;
         case 0x8 | 0x4 | 0x2: /* cc != 3 */
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(3);
             break;
+        case 0x2: /* cc == 2 */
+            cond = TCG_COND_EQ;
+            c->u.s32.b = tcg_constant_i32(2);
+            break;
         case 0x8 | 0x4 | 0x1: /* cc != 2 */
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(2);
             break;
+        case 0x4: /* cc == 1 */
+            cond = TCG_COND_EQ;
+            c->u.s32.b = tcg_constant_i32(1);
+            break;
         case 0x8 | 0x2 | 0x1: /* cc != 1 */
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(1);
@@ -926,18 +938,6 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             c->u.s32.b = tcg_constant_i32(0);
             tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
             break;
-        case 0x4: /* cc == 1 */
-            cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(1);
-            break;
-        case 0x2: /* cc == 2 */
-            cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(2);
-            break;
-        case 0x1: /* cc == 3 */
-            cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(3);
-            break;
         default:
             /* CC is masked by something else: (8 >> cc) & mask.  */
             cond = TCG_COND_NE;
-- 
2.41.0


