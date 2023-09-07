Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA2797287
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:04:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEeo-0007Zv-4L; Thu, 07 Sep 2023 09:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEe7-0004fr-2A
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEe3-0007Xn-CC
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnYWCqXFYjnf7iiegsI+BpRqPdw9Nfqs+eiyxPvUq20=;
 b=XH4MZdkdkB4RYaLdPC+GrrZUYZ6U7ZR+BvSvVBlmtkTx2enJACuHUkr3PNX1ZKXqDgK68x
 ECEgnqUhTjArQ3mIz/zjVBP6LHHGn0nLmkaCyp9YzvPUlMjU1u1iEgXQbIszgL85yh/gys
 c7zepviYi6bSsfNj2Uh+4obxICVER7w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-SUrJEXPzM1OdLuOv1i79-g-1; Thu, 07 Sep 2023 09:02:01 -0400
X-MC-Unique: SUrJEXPzM1OdLuOv1i79-g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so6541135e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091718; x=1694696518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnYWCqXFYjnf7iiegsI+BpRqPdw9Nfqs+eiyxPvUq20=;
 b=Sn/kw7dKJVL/Avj69KeuS3w17W9IytF2Yz7dJEl4qN9cUN6QxDdEFfo323xEWI1n/X
 oS8Igf/S8pEMhm+/YfAL485G8Ijx5PaR88vlziEjEWgCCNsnrpUiex6PDvzfHgX+3O6I
 c+P5rtbW8wI1O5OS2ophkJm5eWfGFOlCU7EK1FO4sLcdVp3jEw3s91FRGyY/zZ5JRjJ6
 /yULX4dktGztceNCTD16CaiM/k1iHeBvN8dttfLHkFfGOjsplN0SxcwiVAYQx7L6NU/V
 nZPW7NzCl5qAdw1f23lQbFWC+I36sDU5wMtUDhnHSDriYkiyzc2NfTmg+WjR6T7AyNvn
 hDhQ==
X-Gm-Message-State: AOJu0YyWto9lMUMu6qd1yU6ioWWKjR5q7SkMHePDTLMX09SK7n1GVyfJ
 mx17JHblpPm7YeTsXRDFhWtkd5DPpfjFIIjtTx6C2SA6LmnNN4OE3CF8KSrO11MpTirpgtBie1Y
 oW8+8sNJdUl1zsXGN1E8jsKMzep70bFuX9Lxt0sk7FNgas0L6BTsA3aRes7DTetBp7adkssNP+j
 A=
X-Received: by 2002:a7b:c7c7:0:b0:400:57d1:4910 with SMTP id
 z7-20020a7bc7c7000000b0040057d14910mr4480993wmk.17.1694091718427; 
 Thu, 07 Sep 2023 06:01:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbtsyXh/oj9l9KT4XaBwVZs5dOrL/bKVQ6jKZ9oP/mao/eF7BrlF7C1nNRyq1I1Srllkgkeg==
X-Received: by 2002:a7b:c7c7:0:b0:400:57d1:4910 with SMTP id
 z7-20020a7bc7c7000000b0040057d14910mr4480975wmk.17.1694091718090; 
 Thu, 07 Sep 2023 06:01:58 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4147000000b0031de43fe9bfsm23505088wrq.0.2023.09.07.06.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 49/51] sysemu/kvm: Restrict kvm_pc_setup_irq_routing() to x86
 targets
Date: Thu,  7 Sep 2023 14:59:58 +0200
Message-ID: <20230907130004.500601-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

kvm_pc_setup_irq_routing() is only defined for x86 targets (in
hw/i386/kvm/apic.c). Its declaration is pointless on all
other targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-14-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/ioapic.c       | 1 +
 include/sysemu/kvm.h       | 1 -
 target/i386/kvm/kvm_i386.h | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index cd5ea5d60b1..409d0c8c766 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -16,6 +16,7 @@
 #include "hw/intc/ioapic_internal.h"
 #include "hw/intc/kvm_irqcount.h"
 #include "sysemu/kvm.h"
+#include "kvm/kvm_i386.h"
 
 /* PC Utility function */
 void kvm_pc_setup_irq_routing(bool pci_enabled)
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 147967422f4..ee9025f8e9e 100644
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
index 76e8f952e5f..55d4e68c342 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -78,4 +78,6 @@ bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
 
 #endif /* CONFIG_KVM */
 
+void kvm_pc_setup_irq_routing(bool pci_enabled);
+
 #endif
-- 
2.41.0


