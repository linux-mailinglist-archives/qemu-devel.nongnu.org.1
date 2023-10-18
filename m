Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6727CEB56
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzi-0008By-EW; Wed, 18 Oct 2023 18:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEze-00089U-Om
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:22 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzb-0002W0-V1
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ca6809fb8aso27745355ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667979; x=1698272779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gscgf9TaNURfjEVsbC8XIQGIbXkPOrKC3iA1FwA6PsE=;
 b=tFM6xE+IRcFE+r2xeiyy0EQ4TtJFSHN/ZVABKkwCVS9tKF98I8nVJuVHc6C2uMsOVb
 NsB/PVhLFg80IXD4irj+cqNpwzOhaaV6ZCAzkbsijDgqzZCRum0QmArdYX8v+Hbgce3T
 59RU5Ar+VhGlFJ2b5n6zyO4pG5kv9ncgJ6FDX5SMJ89Uqhl85/7X21qZH027EDZDwG40
 P3vKp08qyLK69QHKyB40X5iyPAG75+fka4LIEAt+5PXRwbnJCoes2mtBA4esuFVRKnxb
 m4kKP5/SudtVUCF+csHcf3JeUygwNXq5wjnioK7p6RnSvxJUUqfZfKIdA/oWgGgHKjBa
 Uglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667979; x=1698272779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gscgf9TaNURfjEVsbC8XIQGIbXkPOrKC3iA1FwA6PsE=;
 b=tFcwREZ6hNGCP1oi7spZvK961S90wa6gj9/Ff3hKLrIJZtONSHMlTr/4CX4Ue0jbGg
 dVCffujHfktWFH8gpJW0Xg7M5RtlJqYV6jY7bpy+9AMhZm0hwu+S423ADouVlz7pl8x6
 zyCYtxxbv/AGWx9OXFK/df+z36NJIkAP6ru58Alm/AdtVr40gpcWAHpsda9NGeIv/IR3
 +J6sFlmg2Eta5F6qowFm7BQV/BHvS3r23OWYmRBcHQnE+GMgRSVpnY6tptAqFaQPLBrL
 AD4AD6rRjtOuCv12Oe4jJpecu7n06FS03dXMeUs9CaPHcUfzfoswNfymk7aShpjc5TT6
 h8bA==
X-Gm-Message-State: AOJu0YwdL8bSYbZTcysvifmEYuWGN+1UpgyVhKShXrTIl66UQ8uikIhG
 Ucnhy2vk40U3J6Lhq1ErmwlkAJ9Rd242jrGzvTQ=
X-Google-Smtp-Source: AGHT+IFDVv9vqf/Y+D1expRVVlBCFKt22brNaYomeW07hpsF3oukV4DxCFj2grnxOeM7MS+lQHiCEw==
X-Received: by 2002:a17:903:cb:b0:1ca:de3:fcad with SMTP id
 x11-20020a17090300cb00b001ca0de3fcadmr562304plc.59.1697667978758; 
 Wed, 18 Oct 2023 15:26:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/29] tcg/riscv: Do not reserve TCG_GUEST_BASE_REG for
 guest_base zero
Date: Wed, 18 Oct 2023 15:25:50 -0700
Message-Id: <20231018222557.1562065-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Fixes: 92c041c59b ("tcg/riscv: Add the prologue generation and register the JIT")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index d6dbcaf3cb..dc71f829d1 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2076,8 +2076,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     }
 
 #if !defined(CONFIG_SOFTMMU)
-    tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
-    tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
+    if (guest_base) {
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+        tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
+    }
 #endif
 
     /* Call generated code */
-- 
2.34.1


