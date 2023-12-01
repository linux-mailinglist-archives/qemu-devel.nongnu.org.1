Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B43800D31
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:33:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r94Yy-0003YN-Ay; Fri, 01 Dec 2023 09:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r94Yu-0003Xp-GX
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:32:12 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r94Ys-0002WX-UU
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:32:12 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33330305372so663653f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 06:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701441129; x=1702045929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2r7iA7OoHYzxctfj3egfbT+slVUvULOjb8ti2ra+So=;
 b=KADm7TplXpHqeQkRyKD8tPYVHOdRVOhIinLHImGZ2VcV5ReJ4tgkNKfniMY/e6eg0V
 wYy1gnygbp+TNUtOnvUnLKOf3NcXlJF1vYp7T/nS25i5Vs/cjvyQE4IpaLu4PeDLD5/k
 S02Ig2oZtt/kZ3Pi0IuJGvLAdC1xR3/4SNxuvtov2LQH2iabmMG0JuZ9vIQjkRnk2O7i
 Xs3V2HYRpuE0OH+1EThYclKv0A5sxlD4s2Rptxi6df6ej1VOIU0fHIHr9BKHFX7Chyo3
 g05uO+X/Xegx78ScnqsgcW1dksq0N8veUpwpZ5K6YTMiUrhjfhwPlzOmt6RBZz95Eurj
 kb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701441129; x=1702045929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2r7iA7OoHYzxctfj3egfbT+slVUvULOjb8ti2ra+So=;
 b=b0QolRmdEqKiPRD649JvdJDzrzS48lvpKhbJTHxG3tOu3pmW7MLm+ys2YYg4FiWWHu
 rNkSOcPbGDlrCEddbQbdTv2v4MZhveZFVATPWPhEO7cY4xrAFmG1Rkckry3OSHHpYXBL
 XYD5+zKfEec64MI5hsh3tu4nfYb/Fn1vomFH9KKYuzXzB35TS/q0IGwglwUGepUJ/WHN
 IHmr3dKUUDU8thT1kSTG7IuXY3tPH2Z1a0tFiUDa0P0pRN8kpQFWE3bg+SzzvN53oodR
 EINduUurX35Vsa95/sCff22SAEetL9WodFvT3l2S1sZi3sAPxadKJ1feqWo/vE9P+U/Y
 7Zhg==
X-Gm-Message-State: AOJu0Yx41oCiGVP2Q5MFpXyVdyCSOPswrfiqqWu3Yck/TFB79KsKvaY+
 Xdf4Zy+jePQhszLlPyqARk4dfRMEV1tsPHG+uck=
X-Google-Smtp-Source: AGHT+IFRjWrcyt6o2zfMnv+I2s9cP1wBQQTO9OsNacCHUVKUdyh72wWH41cpsgSJYt+qugV5saDEJQ==
X-Received: by 2002:a5d:4e8b:0:b0:333:85e:a11f with SMTP id
 e11-20020a5d4e8b000000b00333085ea11fmr889298wru.59.1701441129295; 
 Fri, 01 Dec 2023 06:32:09 -0800 (PST)
Received: from m1x-phil.lan ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 dq4-20020a0560000cc400b00332e7f9e2a8sm4277513wrb.68.2023.12.01.06.32.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 01 Dec 2023 06:32:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 1/2] accel/kvm: Expose kvm_supports_guest_debug()
 prototype
Date: Fri,  1 Dec 2023 15:32:00 +0100
Message-ID: <20231201143201.40182-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201143201.40182-1-philmd@linaro.org>
References: <20231201143201.40182-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

kvm_supports_guest_debug() should be accessible by KVM
implementations.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-cpus.h | 1 -
 include/sysemu/kvm.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index ca40add32c..a232348c91 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -18,7 +18,6 @@ void kvm_destroy_vcpu(CPUState *cpu);
 void kvm_cpu_synchronize_post_reset(CPUState *cpu);
 void kvm_cpu_synchronize_post_init(CPUState *cpu);
 void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
-bool kvm_supports_guest_debug(void);
 int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
 int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
 void kvm_remove_all_breakpoints(CPUState *cpu);
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index d614878164..6ed18f2d6a 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -206,6 +206,7 @@ int kvm_has_gsi_routing(void);
  */
 bool kvm_arm_supports_user_irq(void);
 
+bool kvm_supports_guest_debug(void);
 
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
-- 
2.41.0


