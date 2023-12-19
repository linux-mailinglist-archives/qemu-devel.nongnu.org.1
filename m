Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A30281906A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX3-0001xL-TP; Tue, 19 Dec 2023 14:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWs-0001st-0a
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:22 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWp-0001o5-5v
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:21 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d2764c0f2so13007205e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013197; x=1703617997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q+JqI01nncfSjIKYc0Twd9PO0mRP3lelRgIHx6yJ+Vs=;
 b=M1thYfq17LZ5IdGjTbcizyBqzNCGxLSZNdDa6BOvB7nMsVpSZdF8vNI4PgQvn+jDqj
 zh3/V9YIAPDlE2LDkE0ou0RnTuIw/pnDJ+Amu2pmRzkCGPl623fTYdn/4IFYMDtZSe91
 nGzrGA3TzWqIWZHNKcaRYAp61gMLUV6S5rhorDS/jdGiARhsqXR0U4m7WvK5QeRqTljJ
 OoshCWrRN0z5fjVaDbu9GWmRTfv6hjtUfSKpqvM4NFoSfWj3ZBN7n9wQQWN+RrzOFF2q
 fF4KxY67B7XU5mXGntEuyTdQKVFw8aIBhPt1MURZlz0FTphfcUwxHSXSWFhXxFNWQFem
 d9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013197; x=1703617997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+JqI01nncfSjIKYc0Twd9PO0mRP3lelRgIHx6yJ+Vs=;
 b=GGNhZC0gBl3reXbp6QiqkvBYy5fKYJ1Vbm7Q7Ib+5Ap7twnZtz70gpbDkB1ik+GMY2
 J2KuUwy9kHYC0tEluDCfNYf78bzpPS68l2MEUjDPg3XCnoAm2mvAM1GJuL6Kj4SMDjSn
 3M0JLBYMPQrLSXKQZEtMe7UYdOuSpypxSYNWfdvZlsz8TyDmtIFsizga1dxelwLWp1yJ
 vf1ybt85rzChRjKweMQ9XD4prXGR/GHBzxItS1Z4Gr5tiyg6TWiAuB19S1KQJJ2bG3rh
 JZhDWTJ1ijFZ6SfXZ7KpnBNQss/5a04JEIF/IJ7QnEPsBdA4/qtcP4vhE648Sz05kbx6
 HYpA==
X-Gm-Message-State: AOJu0Yy/vADRT8KGcJDtNHcpPuXNNOpf88D/Ew+s045VWwR5F+1JL/4E
 7akWwYFpw2c5cji6Aej4InDUyrb3mG1kMGvBjR8=
X-Google-Smtp-Source: AGHT+IFEWpV/sgOW3gim+QzQ+V73yCTqXCTWBqcYHHlw28I0sSTRK2lU9vmX7whXVcTTn+3LbXRgiQ==
X-Received: by 2002:a05:600c:1503:b0:40c:38ae:928d with SMTP id
 b3-20020a05600c150300b0040c38ae928dmr9367611wmg.29.1703013197605; 
 Tue, 19 Dec 2023 11:13:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/43] target/arm/kvm: Unexport kvm_arm_init_cpreg_list
Date: Tue, 19 Dec 2023 19:12:41 +0000
Message-Id: <20231219191307.2895919-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 12 ------------
 target/arm/kvm.c     | 10 ++++++++--
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 9b630a1631e..350ba6cb967 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -39,18 +39,6 @@
 void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
                              uint64_t attr, int dev_fd, uint64_t addr_ormask);
 
-/**
- * kvm_arm_init_cpreg_list:
- * @cpu: ARMCPU
- *
- * Initialize the ARMCPU cpreg list according to the kernel's
- * definition of what CPU registers it knows about (and throw away
- * the previous TCG-created cpreg list).
- *
- * Returns: 0 if success, else < 0 error code
- */
-int kvm_arm_init_cpreg_list(ARMCPU *cpu);
-
 /**
  * write_list_to_kvmstate:
  * @cpu: ARMCPU
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5bc96f469e1..d87d3e53e02 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -787,11 +787,17 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
     }
 }
 
-/* Initialize the ARMCPU cpreg list according to the kernel's
+/**
+ * kvm_arm_init_cpreg_list:
+ * @cpu: ARMCPU
+ *
+ * Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
  * the previous TCG-created cpreg list).
+ *
+ * Returns: 0 if success, else < 0 error code
  */
-int kvm_arm_init_cpreg_list(ARMCPU *cpu)
+static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
 {
     struct kvm_reg_list rl;
     struct kvm_reg_list *rlp;
-- 
2.34.1


