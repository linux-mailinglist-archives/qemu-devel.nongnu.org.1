Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6707D7E1FD6
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:23:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxS6-0004Iz-OI; Mon, 06 Nov 2023 06:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxS3-0004GB-1D
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:07:27 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxRw-0004hY-VH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:07:26 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c501bd6ff1so60995751fa.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268839; x=1699873639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8/5vIGDLKMGAXYMu1UZsIS0RjKQzcO4h+Duvu/oNU4=;
 b=T/Wo+Xn8U0u/8Pu1u7PgUN2SrXwHUG4+yDMEJVtknA2Ms426kFrCl5kkQqS0pOgPKn
 j4RT2uWEU7UtbTY7xrxW1jhG/kf3nb98Y3+ulGjjyTELu8/PiAOwvW16XWzUGN9L/xtm
 /retS4fJySK7pDKsXpj5Kk1IvxWvaGnYK1THsh4DqTzg7O+a80olhdVDZZY4tcwy4hXB
 1KO3imu7EwikGTbYUjNsq4CkyYZeGvkbUYjGVr0Fk2jOk4M/muDLysLoTmvFRM8LDaHr
 p17lkxdtLNlV9IpgCZ3vb0wSwS/fKGOjTImrhmouAulqp2wkbB0ZnBK8Dke8Bi60alwD
 uMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268839; x=1699873639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8/5vIGDLKMGAXYMu1UZsIS0RjKQzcO4h+Duvu/oNU4=;
 b=WHuTHUqv/RT/zQybBdVw9Zx83VLKyku7gnbye8FpGOiaK7jCPRO/r8r0dk85R+7a37
 UUEvJqZFbaLyDPk88rIPX5+aVblh1d+MAkQqSOYMrCmh1q48dXs3wjyOIsgsDOGzwa/9
 dS1CS4auLmo2eF6PC4s5YPaqKnno4ydJPfkQA77x5qsBSORIHwFyoWvB4yL+DqNSW/VJ
 SM7wzeEnwiNr117DXb+K6EmGcvC036Ayqpj6ettZ97ljH7DOCRWbTnVLy+0+QK7a//Yn
 w9mVFalZqOc7F4Jw9OKG4qJX0Glf/mW1lViObjqTLlyjAXgYnDuBnaSjCp/FYdM1hlfA
 FmuQ==
X-Gm-Message-State: AOJu0Yz0iuR3cwAXh+mFgoU8Dyr1UlNrW6Vg9fKt70Zt8clD5lU1GynW
 sxPLUfULUg9eIOKFmPDf0IfYWQ6h5ALdxamqgKg=
X-Google-Smtp-Source: AGHT+IGUmAjl7n06mFubnd+gEr0baz8hJiaRcQUniE2ytONQaxbr97H+8iARFxziBtFUQ6m1v/mnVw==
X-Received: by 2002:a2e:940e:0:b0:2c6:e46e:9849 with SMTP id
 i14-20020a2e940e000000b002c6e46e9849mr10927288ljh.15.1699268838970; 
 Mon, 06 Nov 2023 03:07:18 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a05600c470900b003feea62440bsm11701095wmo.43.2023.11.06.03.07.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:07:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 32/60] sysemu/kvm: Restrict kvmppc_get_radix_page_info() to ppc
 targets
Date: Mon,  6 Nov 2023 12:03:04 +0100
Message-ID: <20231106110336.358-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

kvm_get_radix_page_info() is only defined for ppc targets (in
target/ppc/kvm.c). The declaration is not useful in other targets,
reduce its scope.
Rename using the 'kvmppc_' prefix following other declarations
from target/ppc/kvm_ppc.h.

Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20231003070427.69621-2-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/kvm.h | 1 -
 target/ppc/kvm.c     | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 80b69d88f6..d614878164 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -521,7 +521,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
  * Returns: 0 on success, or a negative errno on failure.
  */
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
-struct ppc_radix_page_info *kvm_get_radix_page_info(void);
 
 /* Notify resamplefd for EOI of specific interrupts. */
 void kvm_resample_fd_notify(int gsi);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d0e2dcdc77..9b1abe2fc4 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -268,7 +268,7 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info, Error **errp)
                      "KVM failed to provide the MMU features it supports");
 }
 
-struct ppc_radix_page_info *kvm_get_radix_page_info(void)
+static struct ppc_radix_page_info *kvmppc_get_radix_page_info(void)
 {
     KVMState *s = KVM_STATE(current_accel());
     struct ppc_radix_page_info *radix_page_info;
@@ -2368,7 +2368,7 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
     }
 
 #if defined(TARGET_PPC64)
-    pcc->radix_page_info = kvm_get_radix_page_info();
+    pcc->radix_page_info = kvmppc_get_radix_page_info();
 
     if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
         /*
-- 
2.41.0


