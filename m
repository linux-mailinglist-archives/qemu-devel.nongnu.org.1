Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3FF7DE6C8
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:44:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI2k-0002Zz-Ks; Wed, 01 Nov 2023 16:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2j-0002YC-1w
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:25 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2h-0000f2-L5
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:24 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d9c7bba32beso199282276.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698871342; x=1699476142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/A81MfmHSii2g9wXL7wLzUzIse0LpnaxjmFzQl496fY=;
 b=pU8H5I/cgMSAplIt403QlmJSX4KVNx4nOhtGxDqM2MnRwm9qg4oax8L0ZKMrDzUuH3
 ShTo4MhNidIgzlXISx7QiHnNk3Yyi9cjOdi5GgSrRIoapKHZ4f/GdM4RC9Mx1NQ+cMFz
 PmGITvr1am6uxIJWp+KB7Q1TPoXe7f24g3OcSzM6Mz2yNvVsG396JeXIgzwDlGjWZgY1
 NIPWZOe2nU2ejnyVaPuRDsOZKt1Dyu62DzTv80RNkU5p24embTDrMYzcLDgt4Xm5uPot
 6hE0RCoAnx01lH8ZMr3E+8FAyzuXoT/cbRuNUCfCgmRiop0tZP59Lsmilbz3JOazVJ/z
 1Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871342; x=1699476142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/A81MfmHSii2g9wXL7wLzUzIse0LpnaxjmFzQl496fY=;
 b=XVJNNhEqPFdbSGWx1QR888yzuCqePqM4+ohhV60n5xMZqBahIeY5gnDXmIXLiiP9aM
 ycxpWluVK1VO2qLs60EFu83ULG4DEWI3IDNq5uSw4wbWto42NEevMliksjc2XqJ047ag
 qnQ+yfesMsLsAl1x7zH5vtJhH+apzhHtvit9YE7swWvYMTqPCnDdwBmbRQoWbrloBV7J
 thbCCyqxSbP8MdxS86y6gB0J2yvjx9yhA2761Qc77oh8ufKnK4btum8ssevvqZAJUNzi
 reCqLb8avGIlUCipm2zVpToBuvoIofDBTGiD+FJ4LLEZGM7AhP9yCtsB3h0V5/nGRVGs
 6AuA==
X-Gm-Message-State: AOJu0YxLLMbUTKrJaeB2XoCH5Tn2SCb7Hgy93/V4UbAv6Y/8fU5sgHON
 lbbiQsMbuE3lNflL7idS5Dj1DJusGC4uYCG0of4=
X-Google-Smtp-Source: AGHT+IENqMhtKJdqSEYs5OQBjapzS6n0sc4WcNofbV17gAyS5L5sqDD7cdKSqf9DsiA4g+fufbRkHw==
X-Received: by 2002:a25:d7cb:0:b0:da0:4aaa:b480 with SMTP id
 o194-20020a25d7cb000000b00da04aaab480mr18248956ybg.19.1698871341974; 
 Wed, 01 Nov 2023 13:42:21 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 z187-20020a2533c4000000b00d9cc49edae9sm329724ybz.63.2023.11.01.13.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:42:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 04/19] target/riscv/cpu.c: set satp_mode_max MBARE during
 satp_finalize()
Date: Wed,  1 Nov 2023 17:41:49 -0300
Message-ID: <20231101204204.345470-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101204204.345470-1-dbarboza@ventanamicro.com>
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

KVM CPUs can handle "cpu->cfg.satp_mode.supported == 0" because KVM will
make it do internally, not requiring the current SATP support from TCG.

But other TCG CPUs doesn't deal well with it. We'll assert out before
OpenSBI if the CPU doesn't set a default:

ERROR:../target/riscv/cpu.c:317:satp_mode_max_from_map: assertion failed: (map > 0)
Bail out! ERROR:../target/riscv/cpu.c:317:satp_mode_max_from_map: assertion failed: (map > 0)

This will be thrown by target/riscv/csr.c, write_satp(), when stepping
in validate_vm().

There's no current CPUs affected by it, but next patch will add a new
CPU that doesn't have defaults and this assert will be hit.

Change riscv_cpu_satp_mode_finalize() to set satp_mode_max_supported()
to MBARE if the CPU happens to not have a max mode set yet.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9f6837ecb7..f7c1989d14 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -942,9 +942,19 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     uint8_t satp_mode_map_max, satp_mode_supported_max;
 
-    /* The CPU wants the OS to decide which satp mode to use */
     if (cpu->cfg.satp_mode.supported == 0) {
-        return;
+        if (kvm_enabled()) {
+            /* The CPU wants the OS to decide which satp mode to use */
+            return;
+        }
+
+        /*
+         * We do not handle cpu->cfg.satp_mode.supported == 0
+         * with TCG yet. Set to MBARE.
+         */
+        if (tcg_enabled()) {
+            set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
+        }
     }
 
     satp_mode_supported_max =
-- 
2.41.0


