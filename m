Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E807B742D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 00:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qno0H-0000sx-AG; Tue, 03 Oct 2023 18:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qno0E-0000sD-J5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 18:36:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qno0D-0005WA-3H
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 18:36:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso11209555ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696372587; x=1696977387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07ipDomwKPWH1v+VDScOyLYevFTg9yHIDq77d/et9Yo=;
 b=x2wuFKw1pgMkGG6CUWcTgxkaNDFa7aiXVr+peWe4uVcrDQeLw4RaH+h/U2H2x18C5L
 k2xOTfSANo+8prT4O0wSTqL9p7O9y1QjxdLWVFJcPrML4SO6deNSEn6S5A91QtfmVTwl
 ZFEi+mMtZWG2xFiVO0HYKdHglKh02CIhF8MrZ7Ahm4ZR5gigXOBedb4Pb7ANanbhqj0n
 gbWNFn3EmWmNCQ08dJifo22f1DTjTWJLTOVq/mP9H1laKOzZQ1+wHV9qputfN+vaOeUe
 rRD4ZrjS7j8MvSdcd1/MUBk9vm59cR2hPRf2i2DY/21010IFgfXq9dcT8bzuWJb53CWh
 NK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696372587; x=1696977387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07ipDomwKPWH1v+VDScOyLYevFTg9yHIDq77d/et9Yo=;
 b=Wt7KywVrbwke/3rBmTU9GM4IGPrg2V9/99sMnAJXmriIpXnFhfmoHNaVcewmillZN5
 +mn2yu5dkU8jwqapxPcg2J1YYcxLoe+qPSAej7qXv90OhvuuKS6qcjadUaF8eu5Gwxr2
 CA5oBJI/Tl0EdKrKLOLs47U5NMoOWfEZzsVAYWExEcDzbg3vzNz53TeCCZAklr4FB8og
 dmAxCT8S2EDgWnF8f4YGUDgNc/WFN1faZRNoauO6td0nEYB3bjEz17MvVoBL78CI3x4V
 /NVVMD7SkIUppbYXk/Fz/N7loxfvEsZKVW9trgEZYPsNGNLsMSCHwDDg/+DBLFwlFsXi
 2HDA==
X-Gm-Message-State: AOJu0Yx2Kgu/o6At/RFBqCZkTDU1URpRQSIXbnOx9sjqFf2GJL0lsLBq
 g6ONaNQWH2Zkk4aQtRAjEE4VavIiFnEqM8U1tIg=
X-Google-Smtp-Source: AGHT+IGgv3iwmmaUuSHcnZrzpZ9PU/QR9/Kw1atTIy/5q0DXqNC73rOHW3NiJ7mdGo0WP1UZ5YAFxQ==
X-Received: by 2002:a17:902:e80e:b0:1c6:2d13:5b77 with SMTP id
 u14-20020a170902e80e00b001c62d135b77mr1035003plg.39.1696372587618; 
 Tue, 03 Oct 2023 15:36:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 q16-20020a170902dad000b001c75d7f2597sm2126055plx.141.2023.10.03.15.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 15:36:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: keithp@keithp.com,
	laurent@vivier.eu
Subject: [PATCH v2 2/2] target/m68k: Support semihosting on non-ColdFire
 targets
Date: Tue,  3 Oct 2023 15:36:24 -0700
Message-Id: <20231003223624.1753000-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003223624.1753000-1-richard.henderson@linaro.org>
References: <20231003223624.1753000-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

According to the m68k semihosting spec:

"The instruction used to trigger a semihosting request depends on the
 m68k processor variant.  On ColdFire, "halt" is used; on other processors
 (which don't implement "halt"), "bkpt #0" may be used."

Add support for non-CodeFire processors by matching BKPT #0 instructions.

Signed-off-by: Keith Packard <keithp@keithp.com>
[rth: Use semihosting_test()]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index e07b0b659d..54c3ff1218 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2663,6 +2663,11 @@ DISAS_INSN(bkpt)
 #if defined(CONFIG_USER_ONLY)
     gen_exception(s, s->base.pc_next, EXCP_DEBUG);
 #else
+    /* BKPT #0 is the alternate semihosting instruction. */
+    if ((insn & 7) == 0 && semihosting_test(s)) {
+        gen_exception(s, s->pc, EXCP_SEMIHOSTING);
+        return;
+    }
     gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
 #endif
 }
-- 
2.34.1


