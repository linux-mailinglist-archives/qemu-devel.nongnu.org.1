Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 622C2A99D8B
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 03:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kvC-0000lN-Qe; Wed, 23 Apr 2025 20:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktV-0005pe-UW
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktQ-00055j-85
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:48 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b0b2ce7cc81so377099a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456202; x=1746061002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyO3H/jvct9185BjfASAXhlbdjAHZIvWqk2wIAaPbys=;
 b=qHqm1/1j4cm4oTN48PHw/RBSa0nHXrebP3bt9mqPYaj9dxj7TmRK2Eck3slJyPPZFK
 INcMtre2G9RCVrV6EXfV0SPSoBXvOzaWBZh1Rgp9eGIgQRtnKZ9kISAUNK45iZrlNr2d
 y8eIlmP5L0xdZKLGXABx9cCYvFoZ6wXHURShdZNT0bmTD0DDQnr7fz06sJ446De/tfuR
 5BsHgI9IBZ/GX1gosioyZLxqqpX1mGPnDx3HH64WpWJJZp9ydoZistHafpBgxA6ea1NU
 NXtdNaj1ot4XUgU7c4YFAsJeu5aTq6BYKCBV0z+cIja9Y3jfaRXsYGaapJroAhmAIKr9
 WjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456202; x=1746061002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyO3H/jvct9185BjfASAXhlbdjAHZIvWqk2wIAaPbys=;
 b=P8hx7Cdrzq5njdVVrALpG7KcftXNbHzqh7J2LmHTh+7CeI6peXyjLAsPJXxO8sGiAy
 oAzKJfs7Eojyiz3uPkGg0Cwwtl4DVLI+MnDzhlgOxWfmKuZdz6cDlpxDrcnwL8XBvojs
 Xw14MUz+bvgtJ0Wx1ihNDHzwiL5y9AoxEjA9T5mfYFbwV+YFr5ZWEczBLMOzINsuy92o
 iI8Mu/1nnTxQ8Oetgmo2LYZ4Qa28tVHLurcsazKxCm9k6lfWPcYeBRyXx7rBUd8QARNF
 cNwFoKcFbFQjZYUbNr/c3EWslf3TBMss8/HjyUWSzuWOFSZQuog/lm8CaOCMamWo79gz
 aGTQ==
X-Gm-Message-State: AOJu0YzVP3RdijdApqG7VGuYBbyy+wTaWTRrz5qkAcVp8DfW6zKaNFyF
 82Y8ni5Ly1QY86X/8IGaGuzXUeKZzRkTy/IPPNe/MmSvXcdP4tSe3o/BhkGulQe1gDtq9l1h7rj
 2
X-Gm-Gg: ASbGncvTPMDJwBBcybm/QowTot5QcENRvhLNXOzQSc+/7nrc7QeSlo3QoCEZD4ciIqW
 QoX9PxYZ1TKbONK2doAnp+zXF6YuNcbjsqXJg5BreRSJSSvsBIA8v0xjXBOV78Z/pxn48AnQpz1
 4QUPk0EzPkJR6pbXrFgBHC0tj+nq64DJKrL9a+l0S1Y625pGYLZA/mU1A3rVIbkjoLBOCw4YgKC
 QM5ay5jG0IpVLwDMmUtSpX7DwRo5WPPNc7H0Ss6EYePgpLponkJGdpy8tPsUM/OZ9+fihwy6Nl1
 wcdSMHxNJQg+0VPYveQ4FR7CcqEotrkbBvG/QEPzOxc0fDe4Uok8xfhBLPHjIoKTBSQ5uCmeqDI
 =
X-Google-Smtp-Source: AGHT+IEAHq35UCrP27cnagS6M1+w03hNHmuoOCuVtXfEt9mpDEO72L3/FHIAf01WWzdPGunOFFB0wg==
X-Received: by 2002:a05:6a20:1587:b0:1f5:931d:ca6d with SMTP id
 adf61e73a8af0-20444e7ad3bmr767468637.1.1745456202450; 
 Wed, 23 Apr 2025 17:56:42 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 092/148] target/tricore: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:37 -0700
Message-ID: <20250424004934.598783-93-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-22-philmd@linaro.org>
---
 target/tricore/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 16acc4ecb9..833a93d37a 100644
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
2.43.0


