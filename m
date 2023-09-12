Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AF379CFFD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:32:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1be-0004FN-19; Tue, 12 Sep 2023 07:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1bR-00042W-1x
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:30:45 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1bM-0000qd-8q
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:30:44 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bcb89b4767so90374531fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 04:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694518237; x=1695123037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21QMJ7GGkeglUQqOfSInY5x1p67Ji2fztTn3JUMzTjQ=;
 b=FGy2CaNExXOnWrwlzVyh2dju8m1DjwILrSqhsp4HLo2EC0rUvrislOEsf0EyyqTqOa
 1Zdruf5inIiiXzOSP0kzwLBr5ZWfKbGQfo0AozpoQIpdyqxxuSmUKO7TKT+Lcou9LDSK
 wyV/u4XEPQ7bYPJiUU81N0ecyD/dbiBOJFVtXE+5A3iOzVrXpeZXqFHBZ/tmNVTzrE+g
 hdQePJwg86TJhBlvLqD1s1vxI4h79rsei8PHqlyzDhVKOEUZO5WnScQbSa4vb6MZ7+MR
 ayM+1HO67qQ4eIszJNDLwUTHmRLgmL8XHosxm5OkKHUk//10y7A/g6s3t1pdB1fVTPT6
 oS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694518237; x=1695123037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21QMJ7GGkeglUQqOfSInY5x1p67Ji2fztTn3JUMzTjQ=;
 b=VZn2qJSEPsr7bd/qfpYpAsYCoKziynG5KSk0FWmb2JJVisZaqLv4AYQpyqdjw+Bg3Y
 HCuEFkfjRmiBOyS1lA+CTgyAwUQDkMES9jx58H+RDUvmbESV+lmKVT1xoet2zS4bK66y
 Xq0yOd8RzU0QM/iekjB+J3IJeNKFBB3QdcaJvhS1DcRT4SyXrkXadk/GW/63JsT4sIsA
 tQhWILRliwRIn/LmpQh9H/edHxdaQLICG0U72Gk4+hf9X4wO0x2cgrqRsprHxZOQwrOl
 SoDgbD0sdZaTxDzB0YYCJXEnNDEC/sPM+EwXUiOBbFablj5CBUI9iBKjre1wkfWyxenP
 SMeQ==
X-Gm-Message-State: AOJu0YyZwd+SVhceYmT5FWiLfh+H09fKgPNqouiOwcc+nHarsa1QcNDJ
 wQaXxNMbhFbV8is8UgT5bevhysnfTBpStUQ3blU=
X-Google-Smtp-Source: AGHT+IGrmkxUF4fF6+bNXffo8F8gG9e/Ung4GKdfh9dcnF2dShXSPiBar0HZ/5nMx033pCom6oSwBw==
X-Received: by 2002:a2e:7c1a:0:b0:2bc:c846:aa17 with SMTP id
 x26-20020a2e7c1a000000b002bcc846aa17mr10295292ljc.41.1694518236658; 
 Tue, 12 Sep 2023 04:30:36 -0700 (PDT)
Received: from m1x-phil.lan (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 l26-20020a1709061c5a00b009894b476310sm6628964ejg.163.2023.09.12.04.30.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Sep 2023 04:30:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] sysemu/kvm: Restrict kvmppc_get_radix_page_info() to ppc
 targets
Date: Tue, 12 Sep 2023 13:30:23 +0200
Message-ID: <20230912113027.63941-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912113027.63941-1-philmd@linaro.org>
References: <20230912113027.63941-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
target/ppc/kvm.c). The declaration is not useful in other targets.
Rename using the 'kvmppc_' prefix following other declarations
from target/ppc/kvm_ppc.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/kvm.h | 1 -
 target/ppc/kvm_ppc.h | 2 ++
 target/ppc/kvm.c     | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index ee9025f8e9..3bcd8f45be 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -551,7 +551,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
  * Returns: 0 on success, or a negative errno on failure.
  */
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
-struct ppc_radix_page_info *kvm_get_radix_page_info(void);
 int kvm_get_max_memslots(void);
 
 /* Notify resamplefd for EOI of specific interrupts. */
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 6a4dd9c560..440e93f923 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -89,6 +89,8 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
 
 int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
 
+struct ppc_radix_page_info *kvmppc_get_radix_page_info(void);
+
 #define kvmppc_eieio() \
     do {                                          \
         if (kvm_enabled()) {                          \
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 51112bd367..a58708cdfc 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -268,7 +268,7 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info, Error **errp)
                      "KVM failed to provide the MMU features it supports");
 }
 
-struct ppc_radix_page_info *kvm_get_radix_page_info(void)
+struct ppc_radix_page_info *kvmppc_get_radix_page_info(void)
 {
     KVMState *s = KVM_STATE(current_accel());
     struct ppc_radix_page_info *radix_page_info;
@@ -2372,7 +2372,7 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
     }
 
 #if defined(TARGET_PPC64)
-    pcc->radix_page_info = kvm_get_radix_page_info();
+    pcc->radix_page_info = kvmppc_get_radix_page_info();
 
     if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
         /*
-- 
2.41.0


