Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63B79176F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:45:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8wp-0003RI-D2; Mon, 04 Sep 2023 08:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wk-0002tk-6U
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:52 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wg-0004tB-GN
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:49 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so1871459a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831485; x=1694436285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgUPYLmjXf0NM9VXdRKjm+MRqu9ErWeVIsJU5m+yYDU=;
 b=ElGuqkKPb4tccOJZzDdzhDceFkTKIqylpNDmc649b6nbMf1REbF1Efa0VFpwrGWSM3
 2xKl0K+rIs/6CovWnoWd8DSYsfZ5odFhQ9ORInIdwJwk+P3jUmMJNv332kKBVjNcav0+
 nl3UPRkchznUU2UQhb/mgadNEJB2hkwv355uNDCh696UmxOgHL0iurJHI7N6r14OPCW5
 +qJx/03q9RA0C+9rJ6CB8ODB6WR36FavEUtPE5P+9s3lzPjqfkTa8ZBCBIeGeD9Jb0hY
 87L4ZRMryQ76hoLnfEWbQPxdA+9IkPdDdzhsUM0oZtIizjvAg1zORD2B17oUnblvQbqk
 UWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831485; x=1694436285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgUPYLmjXf0NM9VXdRKjm+MRqu9ErWeVIsJU5m+yYDU=;
 b=BNoqDKPhINO0+DGoX242DIdUOAXWBKy4kK6DiQqqp6W4vCiov4jR/dGy18S6pHEYmY
 Ktp8E6A9c0reBjvgHGj3AjxmlWsPurczQUFsjiEZqOdZnzUedaasKLkgfvYTnAeUEkcb
 nM2sAQKriW8lanu4Lpditd0xX0HT7BKC/94aEgnr3h2Nk7nYSi8I0LSNc/JJqY8Dnv0B
 uebFUURL7MquKrYTPqFDA3Y/Lii5Mq2CMjkI5KygkXFWqm/IzitDlaOCc3NNT/jtJxNn
 WeFHLg2NXfLlqW70V/nFplxWD+Io/mJnHe8W2EOgT9CDnLKIpTWzUYLMcyVw7/fhRr8H
 yLHg==
X-Gm-Message-State: AOJu0YwzzXM8s3DTKJprruRtFmPKHEWCD9OIBSB6kF+5jPybxuq8/sK/
 s9DjIiZD06XI0U1XOhbWK28pQHojtse1OoWF8xc=
X-Google-Smtp-Source: AGHT+IGpqxvPFHv+7iL7JBf8coc8ir/WyqX6mJSQUkJ8wn20F+l+BdUJBcSdl1rEC9tKrnU3giCDUw==
X-Received: by 2002:aa7:c393:0:b0:525:570c:566b with SMTP id
 k19-20020aa7c393000000b00525570c566bmr6829285edq.22.1693831484850; 
 Mon, 04 Sep 2023 05:44:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a50ea84000000b00521d2f7459fsm5753793edo.49.2023.09.04.05.44.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:44:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 13/13] sysemu/kvm: Restrict kvm_pc_setup_irq_routing() to x86
 targets
Date: Mon,  4 Sep 2023 14:43:24 +0200
Message-ID: <20230904124325.79040-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

kvm_pc_setup_irq_routing() is only defined for x86 targets (in
hw/i386/kvm/apic.c). Its declaration is pointless on all
other targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/kvm.h       | 1 -
 target/i386/kvm/kvm_i386.h | 2 ++
 hw/i386/kvm/ioapic.c       | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 147967422f..ee9025f8e9 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -514,7 +514,6 @@ int kvm_irqchip_add_irqfd_notifier(KVMState *s, EventNotifier *n,
 int kvm_irqchip_remove_irqfd_notifier(KVMState *s, EventNotifier *n,
                                       qemu_irq irq);
 void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi);
-void kvm_pc_setup_irq_routing(bool pci_enabled);
 void kvm_init_irq_routing(KVMState *s);
 
 bool kvm_kernel_irqchip_allowed(void);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 76e8f952e5..55d4e68c34 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -78,4 +78,6 @@ bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
 
 #endif /* CONFIG_KVM */
 
+void kvm_pc_setup_irq_routing(bool pci_enabled);
+
 #endif
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index cd5ea5d60b..409d0c8c76 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -16,6 +16,7 @@
 #include "hw/intc/ioapic_internal.h"
 #include "hw/intc/kvm_irqcount.h"
 #include "sysemu/kvm.h"
+#include "kvm/kvm_i386.h"
 
 /* PC Utility function */
 void kvm_pc_setup_irq_routing(bool pci_enabled)
-- 
2.41.0


