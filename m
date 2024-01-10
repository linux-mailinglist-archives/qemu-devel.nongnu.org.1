Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD018295CE
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:09:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUUK-0005Bx-MK; Wed, 10 Jan 2024 04:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUTB-0003ZQ-I1
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:02:00 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUT9-0005jz-OR
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:53 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9bc8939d0so2102358b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877309; x=1705482109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqx6DK/WndzvPi6CVWSwKepXM0C4841Pf/bOwcgRzj8=;
 b=KfBhoPgGkcqW9JnjsEqgbkJRDV4UlVqHklCOMH/vG7+3KPurRRgPwahFaJ9HVNQS1T
 NQvRpCAx+9C12n9llJCBut9IOwXQIwj+00z6bF7vnnNukNATvIPArCtfAq+HGbEOQ+g1
 dG2KLCTm5YH4UQ6JsVaX1ryBcTC+2hwxTWeS2gwoWetjZSmf7hOwZHj2dAn+SstFjPwH
 CpOQh6rmBfLHc1F4I3SwmwhVuxY+WaT6tl4bmKs4XqIIqoc/9Poae1UpWXaupCJfkyZi
 /BHByqQZpzX9RtkyOa7c04GuCVGC16Y7tr7Mr5KHR9tcLXCTDib9xZv2vPLbPuz+SU/+
 jmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877309; x=1705482109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqx6DK/WndzvPi6CVWSwKepXM0C4841Pf/bOwcgRzj8=;
 b=Dn8sE3czkj2Lnu/f3GNxYnDJSEhVDgruu8z3AfN/t+F5LTAy9CV5rPId7acNn1AT0f
 BBg0UFLgixovtLBlh553FnhP/PehPha/dcjspIfveSzMNdVcEKkRdMc+r3g2J8W7btel
 stYvwCThxyGman7Eb4xtiS8vCVWFsdOdBWX9sGEHUVJB5Gxj9ZABKMOcq1sjtc3wIO7v
 5Wo0MNVfYNL3qCkCgecKyCoBgF08kSb5Np3NkFqJA6x3DLQ9D9Ol44cBC6MrYZoDJQdp
 H/Wa3HWA9yxYiIL15KyILSUdTqYnFAcg2i+DYMwC2yJV1D8HeFDsWqSQBEvu4jyjEvM+
 jheQ==
X-Gm-Message-State: AOJu0YwmLOIQuFI5Is6BUo7IFxyspwyPLP0/Yc74Z6iYGJmgsR8YrG+m
 XBbx4VZLKnLQMcwcxNDbN/Jjol1DSvHHIBGF
X-Google-Smtp-Source: AGHT+IEnsjjixUo/s9t68XNcXMfbv+qecilj0jio6WeipWVNHtqwf2q7AqwgXP7Exmr/HhqvcgPulg==
X-Received: by 2002:a05:6a20:3c8b:b0:19a:13:ba4d with SMTP id
 b11-20020a056a203c8b00b0019a0013ba4dmr435692pzj.82.1704877309104; 
 Wed, 10 Jan 2024 01:01:49 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:48 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 65/65] target/riscv: Ensure mideleg is set correctly on reset
Date: Wed, 10 Jan 2024 18:57:33 +1000
Message-ID: <20240110085733.1607526-66-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
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

From: Alistair Francis <alistair23@gmail.com>

Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor is
enabled. We currently only set them on accesses to mideleg, but they
aren't correctly set on reset. Let's ensure they are always the correct
value.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1617
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240108001328.280222-4-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b32681f7f3..8cbfc7e781 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -931,6 +931,14 @@ static void riscv_cpu_reset_hold(Object *obj)
     /* mmte is supposed to have pm.current hardwired to 1 */
     env->mmte |= (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
 
+    /*
+     * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor
+     * extension is enabled.
+     */
+    if (riscv_has_ext(env, RVH)) {
+        env->mideleg |= HS_MODE_INTERRUPTS;
+    }
+
     /*
      * Clear mseccfg and unlock all the PMP entries upon reset.
      * This is allowed as per the priv and smepmp specifications
-- 
2.43.0


