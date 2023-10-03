Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F057B621C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:06:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZSX-00016d-7A; Tue, 03 Oct 2023 03:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZSV-00013B-4n
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:04:43 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZST-0008QW-CA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:04:42 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5031ccf004cso623951e87.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696316679; x=1696921479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ck9fFBQ6PJmRxQ+9dHxfsblvqg5P8PS2Huy1TTlnqL4=;
 b=m6kJrcCZHiYNmzY2lBjyGVtOFZK4A84Xw7yTWoKJXUhmUYn0v1aNCTm61mIXwPQ3Xs
 7qQOmVOAdZzgP5chBuO/7a6UHJJ7Y8Pan6HBF/KECGq+EENe8ouCwKruBcQTkjK0hYg5
 LytSrkFLF+WZWTpmZHM4m2jWqSZJiosO5Pe1AZviZ9zontZ+QSY8dlJkE7Wy/lQ2ACIx
 B4sRgWKvV6TORpaC/QkGYUxylCwrLyOeuj9hzFM0ZGD8PsTIbdvKo+LA/5zC5L0ECKb0
 qHXZIjAySQK+v3EY0TMc9djySVeW8lLmXI+CaNpg/wXBqwr4yLQd9V9szIMeIrp71Z+d
 oVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696316679; x=1696921479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ck9fFBQ6PJmRxQ+9dHxfsblvqg5P8PS2Huy1TTlnqL4=;
 b=Ac4dQoTMMIymF/9KAQJIgOErTECSONEs31UIqmrg+ah5dM9xiA5ClW6fLaKh7jbf7P
 YaVclKrfQR8XhJKP6gzqffC4f5yIDNkqCeqGsAIKggkOFEA2z4ce/qFbca6Kpu7677uO
 JqiUA/nNWWQ0WO2zOsGBwLina4hqK0EURSMeVQ23iTk5KaKipLVTSXGJZwdIBFEKfGjz
 t9Z/rPwy5An5Ah91xMnTslrGW9TQkoW5HyRtv/YmWPQMfp0nOeWNqvTNvdPItMOoXdFz
 oF4fPBeUKIJwN1tijeTT0zmpnydV3kI3xQndXKguySOZr2yAZLyv84SrSwzCu2Ytpvbh
 eRgw==
X-Gm-Message-State: AOJu0YzDWE2sJHBTVUcYhwnp/JxOG1v1kTrgXrKlPFCVqozuo+4CYyOQ
 fZzWIiAT1Lk+Wkgi8h+Ma+BAb8zoStZ3K1/bggKC8g==
X-Google-Smtp-Source: AGHT+IGryZXpTasDyIEnsH7yk7XUzG20teV6i2IANYrNa3Q4/4WtdfVUXfEaIbLjPIZ6q+as+mmEXw==
X-Received: by 2002:ac2:4567:0:b0:503:383c:996d with SMTP id
 k7-20020ac24567000000b00503383c996dmr10962753lfm.12.1696316679009; 
 Tue, 03 Oct 2023 00:04:39 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a5d4d48000000b00324ae863ac1sm828475wru.35.2023.10.03.00.04.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 00:04:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/4] sysemu/kvm: Restrict kvmppc_get_radix_page_info() to
 ppc targets
Date: Tue,  3 Oct 2023 09:04:23 +0200
Message-ID: <20231003070427.69621-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003070427.69621-1-philmd@linaro.org>
References: <20231003070427.69621-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/kvm.h | 1 -
 target/ppc/kvm.c     | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

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
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 51112bd367..19fe6d2d00 100644
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
@@ -2372,7 +2372,7 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
     }
 
 #if defined(TARGET_PPC64)
-    pcc->radix_page_info = kvm_get_radix_page_info();
+    pcc->radix_page_info = kvmppc_get_radix_page_info();
 
     if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
         /*
-- 
2.41.0


