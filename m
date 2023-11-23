Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786587F5782
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:46:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YY-0006gX-6A; Wed, 22 Nov 2023 23:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y7-0006TK-Gc
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:48 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y4-0006I2-9N
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:47 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b2e4107f47so359406b6e.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714563; x=1701319363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TngP5H8NgKVtRrs3cV2eef3xZ01hrk4ilINuJfIwbMU=;
 b=pKJ/O4nj9LiM72l+6N3miXDNQABKIEsXBipI0o1p4cNOAgYqV9x3ZeBkSKMzHjqk9g
 RdP+V5jqEcRdReLbFphRMK2/grvhpi41gPvK22FtNA2lilylpnVmt7BcddpkzAwR2bl5
 vDZM0JtnQ3uqOdSCzDbTbAXDbzq2Erko3GMCxy2/Hgf2eHbfDxNQCRUI+v30F99vLOby
 e5+vMVJbzeSGxXb2Oi/QlYq2CC8ppEO8xIgUcTFKYEP8PjiAK3WYLo9ZJgHgksZaAk+C
 v4NQchOOsaKGjMHEDNW3e7BYOmllssA1v5crKsMxSO/EVuZmQgsXd4AXuM1vNikQ+15e
 6bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714563; x=1701319363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TngP5H8NgKVtRrs3cV2eef3xZ01hrk4ilINuJfIwbMU=;
 b=v1ilp1juRCLCboUNIpZxMGBnU/s3U9NvoMVr6NXAXY6n4hCX8I6YJWMHqe7zHyMqgR
 KWwjdEJoZdrcqYP2uACuA/dn6YBH+OGTXpO8Og5kID8v6OKQ7Akxod793zRbmP4ss5kb
 Q7XWr49ElQuGVQHbxvtVARP2XPJp6Ge7aS9TZI0AQhxwfjmRnJ8+1R/wSb5/+Z4jIity
 KTbHFX2KPN/t6kpGRp9wTCADER/sl9VD+iobGk+4N6zkTmQaF2hS3I41lDdCqkTEpDWv
 wL+o5sjZYhywTaeGPZptCUmU2SZE/JPH69CUnP8/mSJ3sjXt9ghoSWX+vAOYiUdlqGqV
 3efQ==
X-Gm-Message-State: AOJu0YyCV6JFJEvcTLNr9xKlYIys6axRmi8zxzh38faGibPYYqsjgQe+
 BWzPSdi6AiekkxbSr+zTuFg6W5Wt6wsTlfM8/bhx+9rD
X-Google-Smtp-Source: AGHT+IFtj7S4KU+XONJgdhB67AuP4TwL93ur3uJiBiQLEyELOZuOT9dUy/9bmPcxLFfDaYCDo1cWMA==
X-Received: by 2002:a05:6808:5c4:b0:3b0:daf8:954 with SMTP id
 d4-20020a05680805c400b003b0daf80954mr4578312oij.49.1700714562882; 
 Wed, 22 Nov 2023 20:42:42 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 21/21] target/arm/kvm: Unexport kvm_arm_vm_state_change
Date: Wed, 22 Nov 2023 22:42:19 -0600
Message-Id: <20231123044219.896776-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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
 target/arm/kvm_arm.h | 2 --
 target/arm/kvm.c     | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 8a44a6b762..2037b2d7ea 100644
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
index 19454f432a..6e3fea1879 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1290,7 +1290,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
     return MEMTXATTRS_UNSPECIFIED;
 }
 
-void kvm_arm_vm_state_change(void *opaque, bool running, RunState state)
+static void kvm_arm_vm_state_change(void *opaque, bool running, RunState state)
 {
     CPUState *cs = opaque;
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.34.1


