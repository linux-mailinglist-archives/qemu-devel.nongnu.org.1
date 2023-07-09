Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3A074C73E
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:38:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAn-0008U6-Dw; Sun, 09 Jul 2023 14:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAe-0008Qb-8N
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAc-0000oH-Nn
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5746cso43742745e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927405; x=1691519405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Cz1+kZjkC5u47gB2bogcl1IkIjVlfgBFhqhPCwU85Y=;
 b=K5EDORanXq4CU4bsiHvaUgCy6IAb9ZSTWMj0TGnIKC6ZsQMm5Z8qcgMoYeGEFZt9pC
 c36zxGY7BlpTjdBoxM+RVFWcUPcRHkc0C2mvXXcut7nlwx7LcBBQ3ygV/UM9EAkpLr6J
 pt0DSZbAch9RI6+rDjq2K2FFKiJFCTBFuLRNDpiANpkxsEp6Qe6Ar7xrSHF95OAwu5lL
 vYVzVuWCPObJIoMLi8r9ZVHS6ZnWO3067+Syt3V7WRZj+eAVmPK4pj7m5uc7gosnuE9R
 PCbyyKJ6amY6O/Blb8P3WER+FT6mytZtp9VVpDFLkyCLKDTC9VizOY7eQDoVF3v737Qy
 2G6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927405; x=1691519405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Cz1+kZjkC5u47gB2bogcl1IkIjVlfgBFhqhPCwU85Y=;
 b=a53gxacrOknQRJK00eF0Dz5RwD8bKM2YnbzdXFMTVWcD6PY3NB5UjLVqpRw6EKQ+/Z
 B3G7QJKrzvIUQrqgYWcrweun7rehHnxN+aH16NMQLfagN79y6WXlm1fDm+6m6DW6aqNi
 VhSQcCEUBU9FXnVZvgvYuyRso68IqQNwhXIuYj7H0Sop2wgEjjIb6mUY9KtmOdaq9W49
 xp8SqniagRNRPJRIVQkvOW10fd3lStGfCmaiOowHLXPyVcb6gwwSIIhbgHoWorWuwObo
 ykEBuPid+AtYb53IRDuW2e0fx9nQ3qLd9rtIeMIChxQ+GdjBedEkjheeHP4kyshUgDBZ
 1lUg==
X-Gm-Message-State: ABy/qLY8qQt/KN9jA5JlWFOWRC4DfTrgOrxcFUsqyso+2NzUKYS7pPDV
 AMWqykypeDf2a4g117LbrF0pt9FpS8jRzVsjsMZK/A==
X-Google-Smtp-Source: APBJJlEGkgr3PwYyYLZPJROwdyyZCS93QpcCiQSAU9uXH6741zw99pw1JgUplIhOg5ToehIbDn0fYg==
X-Received: by 2002:a05:600c:21d0:b0:3f9:b17a:cb61 with SMTP id
 x16-20020a05600c21d000b003f9b17acb61mr8009311wmj.13.1688927405411; 
 Sun, 09 Jul 2023 11:30:05 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 17/37] target/ppc: Use aesenc_SB_SR_MC_AK
Date: Sun,  9 Jul 2023 19:28:46 +0100
Message-Id: <20230709182934.309468-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

This implements the VCIPHER instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 15f07fca2b..1e477924b7 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2933,17 +2933,11 @@ void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 
 void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
+    AESState *ad = (AESState *)r;
+    AESState *st = (AESState *)a;
+    AESState *rk = (AESState *)b;
 
-    VECTOR_FOR_INORDER_I(i, u32) {
-        result.VsrW(i) = b->VsrW(i) ^
-            (AES_Te0[a->VsrB(AES_shifts[4 * i + 0])] ^
-             AES_Te1[a->VsrB(AES_shifts[4 * i + 1])] ^
-             AES_Te2[a->VsrB(AES_shifts[4 * i + 2])] ^
-             AES_Te3[a->VsrB(AES_shifts[4 * i + 3])]);
-    }
-    *r = result;
+    aesenc_SB_SR_MC_AK(ad, st, rk, true);
 }
 
 void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1


