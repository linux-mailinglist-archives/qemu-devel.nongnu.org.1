Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 678F97972C2
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEej-000710-Tz; Thu, 07 Sep 2023 09:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEe3-0004ap-TC
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEe1-0007Wl-5T
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UsfWLScmy6sLnC82kfJQtErbSOoNvAJXLrmyFBPVqo8=;
 b=Y7+SKpN4QpMteCP0e0k3mPYpxWq1gwPd72LfTOY9VfpmlbabFQesOmmRD2kNWuP9BiSXzO
 InFxV0uRLqxd05tPEbRKaQgWT0q85ePdAunIht327wcKHiY7+gpWCJly0+iHnUVIk7P52I
 6IwwxR/mxyJitkD8OvE7mVmH8Yo3934=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-xecEF51WP2aDSS8dWa0FTA-1; Thu, 07 Sep 2023 09:01:50 -0400
X-MC-Unique: xecEF51WP2aDSS8dWa0FTA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401d9abf21cso7523245e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091704; x=1694696504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UsfWLScmy6sLnC82kfJQtErbSOoNvAJXLrmyFBPVqo8=;
 b=cHOvttZa8t/JJxVemg4DlNyu1Q3GvNTH2kMtpv9jqGccWSciW9XEbEiqK7Eh2BvOoH
 PUPb4BAbEJQDh7Sg7yckz4c15TxbsH/qTyqe74RdtssBbYR4yYeHsSTtaOobFM3nvVNc
 N+cjuIOOspITZLSRb4IyiAUf6GRzkQuRyqBPLYbAH06UnjwZLwpyKff7Jl08e5ZpG+XN
 FOVNNJs1CYP3Wt6DYZYBTStWX8G3P+6ozqA7MAqn4peNRZTvwP2HhQZQ3T/l9yi0Zj0D
 rJghV8M+LEyf270ue7jt2vAEeSUwnWDAc3hBcy9nuHV99U8t9nuUVxwhOsCAMER7eBvk
 h+4Q==
X-Gm-Message-State: AOJu0YxFOOI8F2BkrNFyOb0v4HgxvQGR4NQ8IMIpiRejL5n8oPPCb3jH
 SqDIVgVQ5dxRHKj7rs9FkIaBIPk6Mj6CLD5SHVlcvePUYbkkSKG/KSHocW5EiTAfyOkR5LvDF+e
 nzgv+ZG7dc27oiCXtvYxBaIASShK0NRVZ8Y6Mw8KOMGVIEscJeHyNbqnSdnQk+tlMs77qlA4gRz
 8=
X-Received: by 2002:a5d:54c8:0:b0:313:f33c:24c4 with SMTP id
 x8-20020a5d54c8000000b00313f33c24c4mr5130102wrv.39.1694091704530; 
 Thu, 07 Sep 2023 06:01:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDyaiRW4nu6INhW0U0YYX6AQWyBEJOuXWr6JMS+giQQPaGuRRCWdwtBW4S0RdvHL14RBmHsA==
X-Received: by 2002:a5d:54c8:0:b0:313:f33c:24c4 with SMTP id
 x8-20020a5d54c8000000b00313f33c24c4mr5130083wrv.39.1694091704194; 
 Thu, 07 Sep 2023 06:01:44 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a5d4083000000b0031435731dfasm23154975wrp.35.2023.09.07.06.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 43/51] target/i386: Allow elision of kvm_enable_x2apic()
Date: Thu,  7 Sep 2023 14:59:52 +0200
Message-ID: <20230907130004.500601-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Call kvm_enabled() before kvm_enable_x2apic() to let the compiler elide
its call.  Cleanup the code by simplifying "!xen_enabled() &&
kvm_enabled()" to just "kvm_enabled()".

Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-8-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/intel_iommu.c      | 2 +-
 hw/i386/x86.c              | 9 +++------
 target/i386/kvm/kvm-stub.c | 7 -------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3ca71df3693..c9961ef752c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4053,7 +4053,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
             error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
             return false;
         }
-        if (!kvm_enable_x2apic()) {
+        if (kvm_enabled() && !kvm_enable_x2apic()) {
             error_setg(errp, "eim=on requires support on the KVM side"
                              "(X2APIC_API, first shipped in v4.7)");
             return false;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index a88a126123b..3e86cf3060f 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -129,13 +129,10 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
                                                       ms->smp.max_cpus - 1) + 1;
 
     /*
-     * Can we support APIC ID 255 or higher?
-     *
-     * Under Xen: yes.
-     * With userspace emulated lapic: no
-     * With KVM's in-kernel lapic: only if X2APIC API is enabled.
+     * Can we support APIC ID 255 or higher?  With KVM, that requires
+     * both in-kernel lapic and X2APIC userspace API.
      */
-    if (x86ms->apic_id_limit > 255 && !xen_enabled() &&
+    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
         (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
         error_report("current -smp configuration requires kernel "
                      "irqchip and X2APIC API support.");
diff --git a/target/i386/kvm/kvm-stub.c b/target/i386/kvm/kvm-stub.c
index f985d9a1d39..62cccebee4f 100644
--- a/target/i386/kvm/kvm-stub.c
+++ b/target/i386/kvm/kvm-stub.c
@@ -12,13 +12,6 @@
 #include "qemu/osdep.h"
 #include "kvm_i386.h"
 
-#ifndef __OPTIMIZE__
-bool kvm_enable_x2apic(void)
-{
-    return false;
-}
-#endif
-
 bool kvm_hv_vpindex_settable(void)
 {
     return false;
-- 
2.41.0


