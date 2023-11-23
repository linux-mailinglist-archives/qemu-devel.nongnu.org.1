Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 737207F5787
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:48:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YI-0006ZS-Nl; Wed, 22 Nov 2023 23:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xv-0006NM-4P
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:36 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xr-00068o-36
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:34 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b842e28917so287655b6e.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714549; x=1701319349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiNpx4DVO1rGLOpbcBfDBEuJhBAvBoc+N7iWO5VmOEE=;
 b=NTwJuNk/9NzC+EtIXoKWKaROf69Iqf2dmtqUG7X7AdzRZaI5lg3QwOKUonvPUvLajO
 GpiDQUKfkGswrOv1VkovgAPA7mmFgzcBtu2hbGaMkwDKUoa6lMvZTANJcW10SSh41eTD
 1wMuDxG9cwTFG/oBGydqQ51Gnnw8ESPc78dQB+RSwVU+GgnvW+25+ZRrbDXoJPglHPq9
 PNJOXB4HPjOhplVk3fLamuMPMB6mdQe/cQDNSrpIwvPYnBQWLN0YA+hAgIHL3SZgEvP1
 I18r8Vp/hZeEa7FSyPqJGGVUVlLme6E0GMdB5D4yB6qrILrIFMopXm0DhQ0eVteEFr+D
 F8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714549; x=1701319349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiNpx4DVO1rGLOpbcBfDBEuJhBAvBoc+N7iWO5VmOEE=;
 b=mQpE5YDCGQLdec1aI7lPAdzgO0k5KULuZkWeRk9iWPfTJG7EXAtUWZj1mYNVGLhJPw
 6IeYY5Gb2ACDmor/O8hp+q2pieF5eCdunpEUrqFdC+TwZwaEfEwSzXzHOYISq13w6hRd
 nTWCqH9aJ3KdPcQ54vSDRLCx8sL1y5DxR8guA16plVpjmxshFo/5smyLuegB9xLhgqtR
 ZFFBPADfAuVaHA/MdtiKOOgKBAwF3bkgCPIrz2CL6RcSBla6innCYZy40Yyo3jTukNAy
 7Qe5hCJ9TuO9YfiSn9iTBoFOa0z4FuQyy+8Z/zgSE0Nsw656SJZ7jmoZHd7Uq3XRlqQ1
 cImw==
X-Gm-Message-State: AOJu0YzocPd+AjSIvVtXdTGO5rz6jJLX6oob322oKeTkb8wYatbbfXC3
 G4IwqBj0157rCKz8IQwze7r+pepruqLEZTGjskCWUfqD
X-Google-Smtp-Source: AGHT+IHpgGjfAI7PmLgdlmllTwHamTmV5Tq/alKz+sQNuLmIGbZPHncQBCM9YCkcmblt8zogyQAElA==
X-Received: by 2002:a05:6808:1247:b0:3b2:dd32:2fe9 with SMTP id
 o7-20020a056808124700b003b2dd322fe9mr4916569oiv.35.1700714549632; 
 Wed, 22 Nov 2023 20:42:29 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/21] target/arm/kvm: Unexport kvm_arm_{get, put}_virtual_time
Date: Wed, 22 Nov 2023 22:42:06 -0600
Message-Id: <20231123044219.896776-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h | 16 ----------------
 target/arm/kvm.c     | 16 ++++++++++++++--
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 9fa9cb7f76..e7c32f6ed0 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -335,22 +335,6 @@ int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu);
  */
 int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
 
-/**
- * kvm_arm_get_virtual_time:
- * @cs: CPUState
- *
- * Gets the VCPU's virtual counter and stores it in the KVM CPU state.
- */
-void kvm_arm_get_virtual_time(CPUState *cs);
-
-/**
- * kvm_arm_put_virtual_time:
- * @cs: CPUState
- *
- * Sets the VCPU's virtual counter to the value stored in the KVM CPU state.
- */
-void kvm_arm_put_virtual_time(CPUState *cs);
-
 void kvm_arm_vm_state_change(void *opaque, bool running, RunState state);
 
 int kvm_arm_vgic_probe(void);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 55e1b4f26e..84f300c602 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -704,7 +704,13 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
     return 0;
 }
 
-void kvm_arm_get_virtual_time(CPUState *cs)
+/**
+ * kvm_arm_get_virtual_time:
+ * @cs: CPUState
+ *
+ * Gets the VCPU's virtual counter and stores it in the KVM CPU state.
+ */
+static void kvm_arm_get_virtual_time(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     int ret;
@@ -722,7 +728,13 @@ void kvm_arm_get_virtual_time(CPUState *cs)
     cpu->kvm_vtime_dirty = true;
 }
 
-void kvm_arm_put_virtual_time(CPUState *cs)
+/**
+ * kvm_arm_put_virtual_time:
+ * @cs: CPUState
+ *
+ * Sets the VCPU's virtual counter to the value stored in the KVM CPU state.
+ */
+static void kvm_arm_put_virtual_time(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     int ret;
-- 
2.34.1


