Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA6975DA4C
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 08:22:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN5zY-00010B-Do; Sat, 22 Jul 2023 02:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qN5zW-000101-2z
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 02:21:22 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qN5zS-0004Uc-Td
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 02:21:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso2357581f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 23:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690006877; x=1690611677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sCKadz1sa7B+pPByWCa2eSUlHWWYau2xZhNN+fFvTSE=;
 b=amHkH59ENGCnN2jKxyb6WgmweGcYn163+m+oXmMs6VrHrew3J0/0q6zB7Ot3PG37u/
 CdIhwag54P2tJ14WmHKqpEw9Ie2mH4xeDr/KC+m6Bo5EThX43H+ePqcVOnkHZn7uWHja
 WP0HJFHgzz3O5r9OkuQoaXMfQx1JRESri2TBZWWUlSLpEDbptXZMPA5CfZVDY1CUx05x
 HF6rdNR/7N7QEEWhYRjVsd40DzchLpK/GMOyG1bK5LDS4OkE/A0Arqh0jph8NeJHfm5g
 rAZO2WSgaWyzJekgH6FtrdWh3TjKf8uSwWrpXdSBQkJp8r2JiahS5xY0OhlrbbFGodli
 Kd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690006877; x=1690611677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCKadz1sa7B+pPByWCa2eSUlHWWYau2xZhNN+fFvTSE=;
 b=LSCoDrRNQRlCNZAeygf8FH23H/lP19GEt8sXaeFyisJ0mNJZ0MiMXy581nkdMMmnFx
 OKQG/Zruo4M82X2nnrxparL6kHg6zQX5YjR5jYA0igXXaNK0JQTn0eGJV4Guk086GCZI
 FKqRDfzzv4qFLyj2UNCcy1XYcQ1pgxwZhGRGdQJ/NbbaBP0MOgzjzcmIdbgq7GUYNGcg
 DjYxS3IBaXQAvCEF2eNgx2hCqI3BnumrQThRETlW8TI3yvcXKQ3WK8y8PGiVURB1AQOB
 xqQp9l0KBvzojvz1boRgfbMLtkdpKlOPVt2UNxoS/58w5hsUCHjEUUeoKGQYrztIciVo
 dMdg==
X-Gm-Message-State: ABy/qLYMvs3A2ErgOAnoLsRzTWhCUJQNedbz7eN90ZgXrI8RCfh455iA
 PNlJZVZmEozcBE1m8rJR+SOX/U4gn8yklUHxrm8=
X-Google-Smtp-Source: APBJJlFg4BQVD/+fq5gDSBUNLzcoGaF27jAYI8khDVD0RfKWE/sHDbCxU7NomcQSUxgsp99BdzQ82Q==
X-Received: by 2002:adf:e9c7:0:b0:311:360e:ea3a with SMTP id
 l7-20020adfe9c7000000b00311360eea3amr7111321wrn.34.1690006876834; 
 Fri, 21 Jul 2023 23:21:16 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d6a50000000b0030ae901bc54sm5983854wrw.62.2023.07.21.23.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 23:21:16 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, peter.maydell@linaro.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 dbarboza@ventanamicro.com, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH] kvm: Remove KVM_CREATE_IRQCHIP support assumption
Date: Sat, 22 Jul 2023 08:21:16 +0200
Message-ID: <20230722062115.11950-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x434.google.com
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

Since Linux commit 00f918f61c56 ("RISC-V: KVM: Skeletal in-kernel AIA
irqchip support") checking KVM_CAP_IRQCHIP returns non-zero when the
RISC-V platform has AIA. The cap indicates KVM supports at least one
of the following ioctls:

  KVM_CREATE_IRQCHIP
  KVM_IRQ_LINE
  KVM_GET_IRQCHIP
  KVM_SET_IRQCHIP
  KVM_GET_LAPIC
  KVM_SET_LAPIC

but the cap doesn't imply that KVM must support any of those ioctls
in particular. However, QEMU was assuming the KVM_CREATE_IRQCHIP
ioctl was supported. Stop making that assumption by introducing a
KVM parameter that each architecture which supports KVM_CREATE_IRQCHIP
sets. Adding parameters isn't awesome, but given how the
KVM_CAP_IRQCHIP isn't very helpful on its own, we don't have a lot of
options.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---

While this fixes booting guests on riscv KVM with AIA it's unlikely
to get merged before the QEMU support for KVM AIA[1] lands, which
would also fix the issue. I think this patch is still worth considering
though since QEMU's assumption is wrong.

[1] https://lore.kernel.org/all/20230714084429.22349-1-yongxuan.wang@sifive.com/


 accel/kvm/kvm-all.c    | 5 ++++-
 include/sysemu/kvm.h   | 1 +
 target/arm/kvm.c       | 3 +++
 target/i386/kvm/kvm.c  | 2 ++
 target/s390x/kvm/kvm.c | 3 +++
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 373d876c0580..0f5ff8630502 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -86,6 +86,7 @@ struct KVMParkedVcpu {
 };
 
 KVMState *kvm_state;
+bool kvm_has_create_irqchip;
 bool kvm_kernel_irqchip;
 bool kvm_split_irqchip;
 bool kvm_async_interrupts_allowed;
@@ -2377,8 +2378,10 @@ static void kvm_irqchip_create(KVMState *s)
         if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
             error_report("Split IRQ chip mode not supported.");
             exit(1);
-        } else {
+        } else if (kvm_has_create_irqchip) {
             ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
+        } else {
+            return;
         }
     }
     if (ret < 0) {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 115f0cca79d1..84b1bb3dc91e 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -32,6 +32,7 @@
 #ifdef CONFIG_KVM_IS_POSSIBLE
 
 extern bool kvm_allowed;
+extern bool kvm_has_create_irqchip;
 extern bool kvm_kernel_irqchip;
 extern bool kvm_split_irqchip;
 extern bool kvm_async_interrupts_allowed;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4c7654f4980..2fa87b495d68 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -250,6 +250,9 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret = 0;
+
+    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_IRQCHIP);
+
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ebfaf3d24c79..6363e67f092d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2771,6 +2771,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_IRQCHIP);
+
     return 0;
 }
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index a9e5880349d9..c053304adf94 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -391,6 +391,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
+
+    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_S390_IRQCHIP);
+
     return 0;
 }
 
-- 
2.41.0


