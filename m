Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A5582A399
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 22:53:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNgUn-0003Zs-8Q; Wed, 10 Jan 2024 16:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNgUk-0003Z8-U7
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:52:18 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNgUj-0005do-3E
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:52:18 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7831ed13d39so347692385a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 13:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704923536; x=1705528336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cc2RPo52FmEiV7m0RK0jR9X26iVBZu5+1nh1fPIm+Uk=;
 b=fokUvWvk2xld39RpsmFlisSwNN4F+LmUGPj2vhC/+WlJD6PVOXuC7vfrZT7oX0MoE8
 xiDrLN8BzDUNYAGRDuewB2R3r4vDVquJyHlIGpoQNF+yhN6UpDo5QoLfRXt6zgBdpJLj
 E/mHloBvePojQeEIMs3M5NYaasObM75c/CQ7tZDZSnqqEX0vd+UcuocmuOH8bHZiFo7s
 ESPfDVQIwP1XLVUKzhdfilaLbAHLbtm8zTUT2YTbTwyqqhPIpaeOkmN1LNKWHc+KzV5L
 P97iByWa5SqWlQC/H3Sp2JVt8qC0GNeZck1C5nDIdqKQf1UL8xDxCx4pgRyd/jpB8mVl
 2q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704923536; x=1705528336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cc2RPo52FmEiV7m0RK0jR9X26iVBZu5+1nh1fPIm+Uk=;
 b=BTe5iS2TWsRUIs2t5i53xC5z3fWhkRErLMd6kcvVl5Su2et1CS+yaFhmp7Yha/l2Q9
 pBaTcM8G55L3UtLb42zllqDkVmxg0kC4HCvy0aZi1kEgboNLaeBf0ejA/5X3eX+xSZQg
 CYIDRo4kaos3jIDFKaBjdDZSP9VTcVLZmP6mDjXaqSTNe0dQNIXwUjewCzKj45uvpR95
 84SBTUIKvNUXqifvvNioR4fJ20skWLGB0XEs86TOX/9h+6oGQi9IBJYx/YtVXj52fHmb
 sy2Xg+fTMlzYbIgP+8Nmx5aCGz+X3ff+B+uLgcZozWVhvnE/pK5LEbdV8NnKTZB1KJ3A
 oOQA==
X-Gm-Message-State: AOJu0YyefAj9ZqeVZ/qNypVZAzMcOmrJvescEWoHeoQmr7xowp9VwuM5
 7InOC9MuodfOVxL8B/mY0MaEmUVWgkd/z1g4frjiDCYBUOE0zhd1
X-Google-Smtp-Source: AGHT+IFQuy3k+nEPduIywR1jiEuPyjLb5l1EmGhVebDDyee5uI5h0kGBdl9HybmPOnY3mjiiC9Dwyw==
X-Received: by 2002:a05:620a:288d:b0:781:5e3a:a85f with SMTP id
 j13-20020a05620a288d00b007815e3aa85fmr374385qkp.17.1704923535987; 
 Wed, 10 Jan 2024 13:52:15 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 z8-20020ae9c108000000b0078313c87609sm1888387qki.100.2024.01.10.13.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 13:52:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 1/4] tcg/i386: convert add/sub of 128 to sub/add of -128
Date: Thu, 11 Jan 2024 08:52:01 +1100
Message-Id: <20240110215204.9353-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215204.9353-1-richard.henderson@linaro.org>
References: <20240110215204.9353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x733.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

Extend the existing conditional that generates INC/DEC, to also swap an
ADD for a SUB and vice versa when the immediate is 128.  This facilitates
using OPC_ARITH_EvIb instead of OPC_ARITH_EvIz.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20231228120514.70205-1-pbonzini@redhat.com>
[rth: Use a switch on C]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 49 +++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a83f8aab30..29e80af78b 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1316,23 +1316,41 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
         c &= 7;
     }
 
-    /* ??? While INC is 2 bytes shorter than ADDL $1, they also induce
-       partial flags update stalls on Pentium4 and are not recommended
-       by current Intel optimization manuals.  */
-    if (!cf && (c == ARITH_ADD || c == ARITH_SUB) && (val == 1 || val == -1)) {
-        int is_inc = (c == ARITH_ADD) ^ (val < 0);
-        if (TCG_TARGET_REG_BITS == 64) {
-            /* The single-byte increment encodings are re-tasked as the
-               REX prefixes.  Use the MODRM encoding.  */
-            tcg_out_modrm(s, OPC_GRP5 + rexw,
-                          (is_inc ? EXT5_INC_Ev : EXT5_DEC_Ev), r0);
-        } else {
-            tcg_out8(s, (is_inc ? OPC_INC_r32 : OPC_DEC_r32) + r0);
+    switch (c) {
+    case ARITH_ADD:
+    case ARITH_SUB:
+        if (!cf) {
+            /*
+             * ??? While INC is 2 bytes shorter than ADDL $1, they also induce
+             * partial flags update stalls on Pentium4 and are not recommended
+             * by current Intel optimization manuals.
+             */
+            if (val == 1 || val == -1) {
+                int is_inc = (c == ARITH_ADD) ^ (val < 0);
+                if (TCG_TARGET_REG_BITS == 64) {
+                    /*
+                     * The single-byte increment encodings are re-tasked
+                     * as the REX prefixes.  Use the MODRM encoding.
+                     */
+                    tcg_out_modrm(s, OPC_GRP5 + rexw,
+                                  (is_inc ? EXT5_INC_Ev : EXT5_DEC_Ev), r0);
+                } else {
+                    tcg_out8(s, (is_inc ? OPC_INC_r32 : OPC_DEC_r32) + r0);
+                }
+                return;
+            }
+            if (val == 128) {
+                /*
+                 * Facilitate using an 8-bit immediate.  Carry is inverted
+                 * by this transformation, so do it only if cf == 0.
+                 */
+                c ^= ARITH_ADD ^ ARITH_SUB;
+                val = -128;
+            }
         }
-        return;
-    }
+        break;
 
-    if (c == ARITH_AND) {
+    case ARITH_AND:
         if (TCG_TARGET_REG_BITS == 64) {
             if (val == 0xffffffffu) {
                 tcg_out_ext32u(s, r0, r0);
@@ -1351,6 +1369,7 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
             tcg_out_ext16u(s, r0, r0);
             return;
         }
+        break;
     }
 
     if (val == (int8_t)val) {
-- 
2.34.1


