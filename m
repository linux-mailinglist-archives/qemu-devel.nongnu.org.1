Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F582A395
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 22:53:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNgUp-0003ab-Oj; Wed, 10 Jan 2024 16:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNgUn-0003aA-Mk
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:52:21 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNgUm-0005fn-3f
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:52:21 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-783182d4a09so482344485a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 13:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704923539; x=1705528339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBBeoirsyv5/OFQlIRCs3B1+YR9/kciezwI6H7ohodM=;
 b=jcBFQ2hwa1ZICpmBR0Ac7N8axgc1pbmlbmzb1xdlzIyw4wc2rYQRc2NbREnNJBTeBC
 Rr/rypm4r+qTwC56tF24s60nhNRXQNWqHrbz4CL56g69MQk21ECfMz8mYIhw6mW2M2qe
 PrhC4iBgLrcrcPLszVKRVvFT1dBx+Q/kMHfvuEuWnuAXAD3CY4cG625/Y4eawlVBXgPb
 77aaurMpKIVZAVaot44BvyZHvaoFY3/S4+P9T2TITghjX2q7PlQNnQ9rduDguZWwsDZt
 +O9DW0Aw8HDIPVcOHS2X5xs+cQjhNJukmETKYUlKEnQNzTyG3eBJeIuDlgRXXGPTWsL2
 xYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704923539; x=1705528339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBBeoirsyv5/OFQlIRCs3B1+YR9/kciezwI6H7ohodM=;
 b=NLwgo4ulKgjbQFmzSzVlPUZ9PFt2ONlDpj+gzQ55aS1yRwsjl9BkU0WalUXD2KVa3f
 cxY5NA86/ALUJN9x11Z6IcPgI8k6BSb5biQXQMqXbidxnG4JqwRmTS7kJ2/oIuOucMfW
 wKVFdSuEnriPiHTqGSfblPU51EY1gw7wjLikpwZU71KXaq01U4MhJPOt0TyznvB6x7na
 C5WC3VEEDtsTugvLRU664OwwcnZPxs8Wql+pvrq51VtSNAYPAAtRZLrRfO6fG2oh4jVz
 5MrUylnHOngUeebH8ClSuhsH1E7lTcJZLh3qRL/FMGDaIMorsyoNxNUldl7TATJAyVgg
 HnuQ==
X-Gm-Message-State: AOJu0YyL3pm0fQ89jn+5hibQLEk6jZXL079uEmDQ5oM6SfjB8wZ7+Ua0
 exc58IkKMyWkzT2JQvKkYJrlpJz+jAhMWM/ZyDSvWXLeuP/S8BFS
X-Google-Smtp-Source: AGHT+IHFPkixC0BUvPVzLcX2wSjTI9QqI2JpICkO2B1iBDwJISqo3pNd+LXcL42yLKyLYH+qPpo3bQ==
X-Received: by 2002:a05:620a:13ed:b0:783:23a1:8b45 with SMTP id
 h13-20020a05620a13ed00b0078323a18b45mr328613qkl.108.1704923539157; 
 Wed, 10 Jan 2024 13:52:19 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 z8-20020ae9c108000000b0078313c87609sm1888387qki.100.2024.01.10.13.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 13:52:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 2/4] tcg/i386: use 8-bit OR or XOR for unsigned 8-bit immediates
Date: Thu, 11 Jan 2024 08:52:02 +1100
Message-Id: <20240110215204.9353-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215204.9353-1-richard.henderson@linaro.org>
References: <20240110215204.9353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
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

In the case where OR or XOR has an 8-bit immediate between 128 and 255,
we can operate on a low-byte register and shorten the output by two or
three bytes (two if a prefix byte is needed for REX.B).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20231228120524.70239-1-pbonzini@redhat.com>
[rth: Incorporate into switch.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 29e80af78b..d268199fc1 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -244,6 +244,7 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 #define P_VEXL          0x80000         /* Set VEX.L = 1 */
 #define P_EVEX          0x100000        /* Requires EVEX encoding */
 
+#define OPC_ARITH_EbIb	(0x80)
 #define OPC_ARITH_EvIz	(0x81)
 #define OPC_ARITH_EvIb	(0x83)
 #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
@@ -1370,6 +1371,16 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
             return;
         }
         break;
+
+    case ARITH_OR:
+    case ARITH_XOR:
+        if (val >= 0x80 && val <= 0xff
+            && (r0 < 4 || TCG_TARGET_REG_BITS == 64)) {
+            tcg_out_modrm(s, OPC_ARITH_EbIb + P_REXB_RM, c, r0);
+            tcg_out8(s, val);
+            return;
+        }
+        break;
     }
 
     if (val == (int8_t)val) {
-- 
2.34.1


