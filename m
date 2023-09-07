Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357879729F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEef-0006Yq-V9; Thu, 07 Sep 2023 09:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEe2-0004aK-4t
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdz-0007Wz-Mf
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7Xqf7ZLFg5wkXV1H3hDfFHEBrjbErGhe3RTeVJ2jls=;
 b=CNDCatb8vT/rBlpiU8b/r63zkor3xtq0AZHvEGXnknh7BksYQ9z6cOJAL7U5Rf/32Nxz8b
 Q3d2/djQTj0BIQa4VUYzNBYnH9koruanaRZzzDQ1zyCjlWKGLd+pFH1l7fb0fobLB8YEeB
 EqEgnN9kS/iDDFtqvVlNOsOtqGHYojY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-44_jM1cxPGCYsNkW8D2g9g-1; Thu, 07 Sep 2023 09:01:57 -0400
X-MC-Unique: 44_jM1cxPGCYsNkW8D2g9g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so6186265e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091714; x=1694696514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A7Xqf7ZLFg5wkXV1H3hDfFHEBrjbErGhe3RTeVJ2jls=;
 b=jwx8xIbtNFmVeB39dxhntrfMqXdVuT60zONrfnQfnCMx1zhLw3QkfWtpzbP/PPZ7Wo
 Cs+WmJcSCLnImWCdSIZUpcLnsd2oyPUni9gub6cietgr+InM1HxarW/zXaVz9sF0AoN5
 FNB+ajlp06Cd+AmiEqZ134JtJVfddkRo3usV5CAl3M2JAcREuzf81irjW7nnj9Z0Ey4b
 /4dqpYnJyNfTFlsQek/it7Npdf+JcrJbVTKr2SxK+Lj3DN+s9NnpMMni6EehfhTqs+fc
 LikRLk+zjZ16uBSp6CW0E6mvIgodPzg+vLw870ULxoASUeIEFGsy+Tms6pmBdB0VWQbn
 YYoQ==
X-Gm-Message-State: AOJu0Yyy87pjjXexyzXcOLTr/RMZjazm9FuDBkyvlpQ00ho144eRglGE
 +g4SQdW0JXaNZ2dw6y7VTi+Y+tW/XR7avsJZHJP7N89Y9I7T71EnIFcviwgmw84YhAjTbM8HupW
 d20iKxSNZHBgNH90HSH97RCba68l20YOpOgSe8rgleHzOu0mu3a8vQX6wiURkzlUfm3guoir6FM
 w=
X-Received: by 2002:a05:600c:2285:b0:3fe:d630:f568 with SMTP id
 5-20020a05600c228500b003fed630f568mr4150914wmf.39.1694091714350; 
 Thu, 07 Sep 2023 06:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwQlxsyf10iBIbYuYX/Dz8BXpNVy09nHexQUmiV1Qkh5VsZIH6v7AsTvxChzrgbSyEiNsCow==
X-Received: by 2002:a05:600c:2285:b0:3fe:d630:f568 with SMTP id
 5-20020a05600c228500b003fed630f568mr4150898wmf.39.1694091714002; 
 Thu, 07 Sep 2023 06:01:54 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fbdbd0a7desm2475470wmd.27.2023.09.07.06.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 47/51] sysemu/kvm: Restrict kvm_get_apic_state() to x86 targets
Date: Thu,  7 Sep 2023 14:59:56 +0200
Message-ID: <20230907130004.500601-48-pbonzini@redhat.com>
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

kvm_get_apic_state() is only defined for x86 targets (in
hw/i386/kvm/apic.c). Its declaration is pointless on all
other targets.

Since we include "linux-headers/asm-x86/kvm.h", no need
to forward-declare 'struct kvm_lapic_state'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-12-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h       | 3 ---
 target/i386/kvm/kvm_i386.h | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a578961a5e4..4326b53f90f 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -188,7 +188,6 @@ extern bool kvm_msi_use_devid;
 #endif  /* CONFIG_KVM_IS_POSSIBLE */
 
 struct kvm_run;
-struct kvm_lapic_state;
 struct kvm_irq_routing_entry;
 
 typedef struct KVMCapabilityInfo {
@@ -407,8 +406,6 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
 void kvm_irqchip_remove_change_notifier(Notifier *n);
 void kvm_irqchip_change_notify(void);
 
-void kvm_get_apic_state(DeviceState *d, struct kvm_lapic_state *kapic);
-
 struct kvm_guest_debug;
 struct kvm_debug_exit_arch;
 
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index b78e2feb498..d4a1239c68e 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -54,6 +54,7 @@ bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
 void kvm_synchronize_all_tsc(void);
 
+void kvm_get_apic_state(DeviceState *d, struct kvm_lapic_state *kapic);
 void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
 
 bool kvm_has_x2apic_api(void);
-- 
2.41.0


