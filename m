Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB384AC640A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 10:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKByN-0002Jh-2n; Wed, 28 May 2025 04:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwR-0008QZ-VV
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwF-0005KL-Ry
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-442ed8a275fso55596075e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420090; x=1749024890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vReLdCvt8zTuHDLo/oBCevvrI7mZDgVXnPW/80F7G4=;
 b=p5khNGIPmDgeGOS43zkzwccBEJEaDZMDSs9HDG7/yYq1Q4+AL0g0o5zh1aKQXsqhRR
 QlRazSPVsb9Y3E8tN32oJ3kOluG5jumqsqm3NCCIXCxK/dL4T7HQ/B62S1Phz/hdpGsT
 OHMo5DPfyYFCEcbMFnegYRsFleED+TVgTGc4UKlcgS7M0C2D6PyLcduSar9FRLJdQlsu
 fyCyHKeUSkcpDeSt9AL18yNsgpFLkQrm/SACvu3GX/+21h4Wc6rdhL+jU1lHhC/0tIDw
 R0PgPj0TEiwEZP1sPXvNbQMT+H/JfP3bypbqpZ5zsYjy6KCYh4CZyBgRpu1mEgCVYt+4
 gTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420090; x=1749024890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vReLdCvt8zTuHDLo/oBCevvrI7mZDgVXnPW/80F7G4=;
 b=Z4NhtenftdvUkIA/LWGuIKLFiBdviehz+u3Rxb9b94YhJcoxCpD5PlK9qnDwm8Ml7l
 tu8F/Sjqy2xVW3VPRGVa+g0QwwiE4DL71eFlPYA76jBGBS5vE70nxjehFBqEe9tE9z3k
 rmw9FKxhh22SZuetqMgn170vF9Xkb7Gwh9cSUA7GDq5nnfxtVj4ZrRPLZeXPjZcIvQmL
 ZZNGWime78+WThMg81ax31PgYbd6n8MYWN+iXMBwIza7Tkr3EUNY5DKC1c3AOyXijEIQ
 zQ3DJ06Pb+3od5zpFMNflbRpCl8ptdSKn8JbUPZmdXZTFvv/0xQESvLMjXZIDkdwysco
 dNoQ==
X-Gm-Message-State: AOJu0YyngfFVvRxcTz4E1x4gMWhJqWiw2aIQEifPqG018Z29yeX1Uvca
 1nItSkE/NeZZMk+hC3QU45Dnce/cymFQJknoRNhaWeeEZep2fj/+8qPUDo6k2DPILoO6v95gTrR
 k5nn0/nWJhQ==
X-Gm-Gg: ASbGncuhhIakOasZjFGwBDcxsUOgLRMu5jvev44F2jYpEtFVbEWoehEKJU7+M+h+H73
 woH6zR1yogSxgYxm8B78rz/D0foTMALKII5e0rLy1yQINCblWtM/m8So4SbQ5Vlm3v9WNDapWXj
 +pnSR3+YdmXpX3ZDU9kIWqWZS0V2SuRhNtnVKOB0ZTJaqUHVJHztC+lRfZ9vuUEwNU6b2z4j2mc
 bff9Y11l8nHDGvXOLZLqGe/bijc1Vc2IT+KOZRq/EBrK7kbHZCbzxwEr7YDOrT5bA8N8bZw5V09
 /1IW32r13CCyKoxTtioOWpkrbEIDXTPWno3kiUc4QenZIE8i4PKcqTQi
X-Google-Smtp-Source: AGHT+IHksdM+h+GeT6/MYpUp0ryVDkdFvO0pSy8trqxjAUPPrPFKsP5YOyYEnBl/IHk1ds0vfEGc4w==
X-Received: by 2002:a05:600d:108:10b0:442:d9f2:c753 with SMTP id
 5b1f17b1804b1-44d5bb93604mr72718145e9.26.1748420089906; 
 Wed, 28 May 2025 01:14:49 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/28] target/sparc: Fill in TCGCPUOps.pointer_wrap
Date: Wed, 28 May 2025 09:14:09 +0100
Message-ID: <20250528081410.157251-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Check address masking state for sparc64.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 2a3e408923..ed7701b02f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1002,6 +1002,18 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 
+#ifndef CONFIG_USER_ONLY
+static vaddr sparc_pointer_wrap(CPUState *cs, int mmu_idx,
+                                vaddr result, vaddr base)
+{
+#ifdef TARGET_SPARC64
+    return cpu_env(cs)->pstate & PS_AM ? (uint32_t)result : result;
+#else
+    return (uint32_t)result;
+#endif
+}
+#endif
+
 static const TCGCPUOps sparc_tcg_ops = {
     /*
      * From Oracle SPARC Architecture 2015:
@@ -1036,6 +1048,7 @@ static const TCGCPUOps sparc_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
+    .pointer_wrap = sparc_pointer_wrap,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
     .cpu_exec_halt = sparc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


