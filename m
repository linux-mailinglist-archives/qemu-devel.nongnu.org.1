Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A587E331A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:35:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bsf-00066m-P3; Mon, 06 Nov 2023 21:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsc-0005rn-GF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:50 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BsR-0002tq-2m
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:50 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc29f39e7aso34153455ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324296; x=1699929096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvtdu4iXiRF+4dT7x2oNhELKW/cIvsq/iJU6RdOYr0s=;
 b=GpQi7ByszRLkP9hQCmuilCMB9Fx3cQnR3l2z9Obx2T3MJBj3ENrgSAnr5Ko25oNBB6
 sbTqBvMbAZ7lBUEWzlOx0m/j8zssutc0rVyNGdavMV5CHuWnwtixPGr7a6H1Q1eciNd6
 yJqufRYBQFslMN7Iw5PaCkQaWj4U/e/ax/MLWH0QqNXwo1vHEcQ0vzHZrEtK9rn2M3w+
 UYmR8FJ5RgOJ1aMJ1M60uGdoDnueTJoYTJL/qDgmkhAY7S6KtjV+Pr4QWdpbSSgDwWUK
 jPVGcP0SiE0HI09ab6HPWzzqdvosZOgOmLt/LKSJ+IxgUd0HToAExTnahJC4H4D2ENGW
 ZJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324296; x=1699929096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvtdu4iXiRF+4dT7x2oNhELKW/cIvsq/iJU6RdOYr0s=;
 b=S51bWDIAoCMlhF8RAlIMW+1vpc8T3VHiLwRLNKWK+jKK1sOwJqM2aydT7ptM8blCRm
 SbcsqzfaxpvIpF1eePLJkRKH3A6U5Ee6pp+kw0Z8tXU9UlvzCdPvXasW4a4N7bKsDB4I
 6jxKxTbL2kbIj9TjgtWvfL3PfE5ZyV5q6zCB5jubRXVHch6wvdbQEAsTmfyk165ykHrV
 Rc2cMb/A0LWy4kuiq9+xabF8oe8VnNxbqRkfWyn3kgFCGfbAVb0ZthiaTqPFmEArDomr
 kwPYEEYKOxGOWAw0Uxfuo3khNWaKTwyKy0Iq13J6A2L3Iv0TS6ts8tTqmvoA9xxISu6Q
 JPjw==
X-Gm-Message-State: AOJu0YwFXgbF1qjOgsoFKia8NMQExVHee/UUqkGCZBGf0EuHx6l0sdJi
 VQaGg9l6QyJjD7J/SnF/76bnxaE+BgJnpA==
X-Google-Smtp-Source: AGHT+IEwg1bt46QharBFYQPkjDGim5q+6/uzLJQBFR7OZUHGsSTgw9aZjtcK8C3weLYo1bHZn7urBA==
X-Received: by 2002:a17:903:1c6:b0:1cc:8b4c:9ba1 with SMTP id
 e6-20020a17090301c600b001cc8b4c9ba1mr11325173plh.50.1699324296207; 
 Mon, 06 Nov 2023 18:31:36 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:35 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 29/49] target/riscv: Add cfg property for Zvkt extension
Date: Tue,  7 Nov 2023 12:29:25 +1000
Message-ID: <20231107022946.1055027-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

Vector crypto spec defines the Zvkt extension that included all of the
instructions of Zvbb & Zvbc extensions and some vector instructions.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231026151828.754279-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 6eef4a51ea..1f0dac5c8a 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -96,6 +96,7 @@ struct RISCVCPUConfig {
     bool ext_zvknhb;
     bool ext_zvksed;
     bool ext_zvksh;
+    bool ext_zvkt;
     bool ext_zmmul;
     bool ext_zvfbfmin;
     bool ext_zvfbfwma;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 093bda2e75..87baae56a1 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -499,6 +499,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvkt) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
+    }
+
     /*
      * In principle Zve*x would also suffice here, were they supported
      * in qemu
-- 
2.41.0


