Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D93A79734
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Apr 2025 23:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Hs-0007eh-87; Wed, 02 Apr 2025 17:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05HB-0006Ol-Kg
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05H8-0006VB-96
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so961385e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627928; x=1744232728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zJ+9PRdTkzm4S+5qzZZ/q1fkpIlcsQe1WgOLBXrsHmE=;
 b=diRUzr3HxXklNx2dv5GratNpbk3niz96QT6XuAiXzYbR08V1LeeOv1FBvot5H4b2qD
 0dY2O6Sic9ldeuaOZ7DNXbG5OGuEbMhpaql9eQcfgqAr6N1A5o9gCbqUYvGseUUsdqgX
 1C0HIJRWo6WLnSVXaYT2cZuwoUtHNcv9s61mORYsFFCamgki7AZ5HOKfNJIFpgCM03xC
 YVVLwqqJjc38ilAW6tREObIqrAkVHed7ux+UjGN9b8NHaal71r1GyZB+1PuqB9SK0FM4
 OIDVejQRdbwVAaA5BdP6NmZKmHPpzH3mI5bu5C0rFRzr8OEgC8nwB1Siyqnt0KtMKC0/
 vFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627928; x=1744232728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJ+9PRdTkzm4S+5qzZZ/q1fkpIlcsQe1WgOLBXrsHmE=;
 b=SAqva0gn09DlDGralfoi1qlaHTNwdkfmsW/ZAQadGurbPJjpO4Qs46INmCnZHd9zF1
 22Dk6FC2psxHJiecKuonqv4qvbFumJy8l1YOrU3ICNf2vOUmWeppE3PXLwtOyT8jlYo1
 GNqhXBLBCeJRivnrpWssbM94ZK4rWqMgoWqVEc1Myzj9sS8VIPGVLGAF8nILOucrFDMH
 QVaueuOi49R3v2IKrqzvNcuer47DHPe3TMbekT8NnKVxhutj01skAxSPm8YXrh+ks05k
 fmfsI+cq5d1XEqPrWQSKeyOzPfc5aS3fy/cNgPVu8FqR/j7RHutftYJIuU1uHtKOcvJ7
 4G1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXyi5wAJFPuGlhZ3SiWdGc6TWD5Px3fOlDDe2iB5HUd3YdAuos7gvBOzm0TmU+hAj/9llrrVA5H8ux@nongnu.org
X-Gm-Message-State: AOJu0YzQ7JRUcjtJT/TVbVIGmXoFnaAUL0gNZfm28x3Pt0E0z1kFyTRx
 MRBwBvxjkN/Vtzkc5WQmkjuy7sl2tdArm/FlTIF4/JrMZlc9TMYOC83adFzLZHHaMPjPc+TtU2t
 /
X-Gm-Gg: ASbGncsazxCwC7uxV3uxQX/sSd30F66LQvgFeP6TQOQMkjlvOy6FLf0ry6KBksXVRxB
 wFuTGNAlqIFKuB0l4ZKfoAl++UPAyR0+G8KIu9Tvh59BkiHZKd9Zv8bovIwFMC8aTqW+7wWKWJf
 8VvTIxQE1RIZEi6W/Z/jMOjVgJuIFCzhNNydBy+OUQZpGBr6HoyCVid8YnGrULn829LGlwNy70o
 2b9xYgleMb/Jxs2ny0G4WF811Bkbb/IJSpos+yIBdvGNvq0+q7uQ8jKPCGngY8uBpxWNIAwp49U
 VwA57Z/Rg4jZ/ALlJ0Wqtf30fqZj9WJ6kxVszyPpMiYpWTnlm8EJPRwfEaUnfE4oSYW8PbvXlJs
 UCNCUDH8hsV/l2CMfkV4=
X-Google-Smtp-Source: AGHT+IG0tdOIlzn8L5BIC/zoCp3iDTKJJ99KN2okh2woPn5Cb/4Ex7gM1vslseanB6KnD5SDv4XUIQ==
X-Received: by 2002:a05:600c:1c22:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-43eb5bfc50cmr39276595e9.2.1743627928589; 
 Wed, 02 Apr 2025 14:05:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663564sm18248384f8f.32.2025.04.02.14.05.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:05:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 24/43] target/tricore: Restrict SoftMMU mmu_index()
 to TCG
Date: Wed,  2 Apr 2025 23:03:09 +0200
Message-ID: <20250402210328.52897-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 16acc4ecb92..833a93d37af 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -176,6 +176,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .translate_code = tricore_translate_code,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
+    .mmu_index = tricore_cpu_mmu_index,
     .tlb_fill = tricore_cpu_tlb_fill,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
@@ -194,7 +195,6 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     resettable_class_set_parent_phases(rc, NULL, tricore_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
     cc->class_by_name = tricore_cpu_class_by_name;
-    cc->mmu_index = tricore_cpu_mmu_index;
 
     cc->gdb_read_register = tricore_cpu_gdb_read_register;
     cc->gdb_write_register = tricore_cpu_gdb_write_register;
-- 
2.47.1


