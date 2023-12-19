Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545F819089
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:18:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX5-00020o-Al; Tue, 19 Dec 2023 14:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWy-0001yE-GS
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:33 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWq-0001ob-Ul
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:28 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c2bb872e2so56131675e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013199; x=1703617999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hLgC4WHbF5gkYYbt5891jJq9lfv3cmnzjy976cgpXIk=;
 b=GFu0xqpB7FSTPkoU/7cKJXDUe3EeK1GSLDbAFnXAB1Pvf3V0w5b5v44R7DIcek+l17
 phpG9BReBNR3scgpBAsBSZci9cEW+oTS0cvtvDb6n/skwXU7w2y7LGnNNUlQ2NGZC6cc
 udlDI5acOhxnuFO2SGU901vEQoQ0+IbhpL+LosOxxzxI+zFzGJXZCyvT1prT4twNNAxf
 XRoeUyLQ4cH8UH63lV+o3m+0guTzdn4DQAYOdsawCV2M/GrEStUoU5QsvQt3uXKrFLJk
 /N/NMARuBsafZ6oOLfK/OdV44d59DJOWa57FboOzhhFtgpkYQwvT0NzfBUTftM+H+uNL
 t/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013199; x=1703617999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLgC4WHbF5gkYYbt5891jJq9lfv3cmnzjy976cgpXIk=;
 b=CdjLVQlfin0R7sGNkCjteTxxHZfIQqhHOsAA0E/mzrJt2xn0FoYBWQ8EkhJsm7sEyE
 WqTp3ErLlya9OeG6h2cdTby3pefZYIV+CLz4OGIg0lpwMzqsvJAy5BpKckGLa6G7823I
 ThDz4HFPEAxblH9k7QWezBoNFn9GfGxd2wy6l1RZMYdCTO6lD2jgyRGjZEPXZhDAAC34
 TDoO05AnN70uXajIi+18AUK5Ly7qpcQ+bbq2fOYVwlxI0w9uOVpisNkD0ZSiW8W75kRn
 p50DLfNUSEDaf1J/YPhX9N9FSTChGkV3HMFIaNOC1vP8BeWoosEE/8JAxmaAMpZc3Yt3
 ImzQ==
X-Gm-Message-State: AOJu0YyuM7sQ0NZSpmYJuL3Cdc0ixoDyDgkcEjc/6a3kL2Rk1S3r4Q2J
 fg9e83YeF9vwvExe3pY6CbwPtnUGEkNSeUzWI+8=
X-Google-Smtp-Source: AGHT+IHRJCoLqR0vmzPSDBGsDCMtZ4cUddDtpyK70LzaX6lRkNSwG/TzAEALP3LSetdKLgtmmT3thw==
X-Received: by 2002:a05:600c:ccf:b0:40d:2f89:2e03 with SMTP id
 fk15-20020a05600c0ccf00b0040d2f892e03mr184501wmb.99.1703013199234; 
 Tue, 19 Dec 2023 11:13:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/43] target/arm/kvm: Unexport kvm_arm_vm_state_change
Date: Tue, 19 Dec 2023 19:12:45 +0000
Message-Id: <20231219191307.2895919-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
 target/arm/kvm_arm.h | 2 --
 target/arm/kvm.c     | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 8a44a6b762f..2037b2d7ea8 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -200,8 +200,6 @@ bool kvm_arm_sve_supported(void);
  */
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa);
 
-void kvm_arm_vm_state_change(void *opaque, bool running, RunState state);
-
 int kvm_arm_vgic_probe(void);
 
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index db6d208cf03..41fffef5ef1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1288,7 +1288,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
     return MEMTXATTRS_UNSPECIFIED;
 }
 
-void kvm_arm_vm_state_change(void *opaque, bool running, RunState state)
+static void kvm_arm_vm_state_change(void *opaque, bool running, RunState state)
 {
     CPUState *cs = opaque;
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.34.1


