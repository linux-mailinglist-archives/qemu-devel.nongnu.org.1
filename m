Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B7F7B645A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnao7-0001uz-Qm; Tue, 03 Oct 2023 04:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao3-0001rH-W9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao2-0000Hb-9a
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0LC5OOAa8z5GyVDABXpLQOMcj65G8oVaFMpm1S2hNU=;
 b=RdjfudTAX3HGmWNgTfZYI+kT7kvUZgcjso0KF5v8RaXzLuEIy+FtikvP25v0UrYkGfIOtQ
 640pnngYL0ol9AVf5ryKsee/s7Yd/jjT0GPvgbSdwKfv+UVop2zhr+yTN7uUHnKe5c0nVY
 VbHqCLdp0mcm2aqjJ1KIlh2iyA2HFqc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-2n568OysNA-gvD1AJMISWw-1; Tue, 03 Oct 2023 04:30:50 -0400
X-MC-Unique: 2n568OysNA-gvD1AJMISWw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-533f8bc82a8so512968a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321848; x=1696926648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0LC5OOAa8z5GyVDABXpLQOMcj65G8oVaFMpm1S2hNU=;
 b=QY/pEVE8ZvLFa17C6D+D9K2NK07/RHABQHQYvJiDBVmjJtI25owR9XkYxYCiA8/Yg0
 XDA5R4q5aTKsbZicAV/UUMyKD8htqF82kELGJVFaDxJAG9sjUAhh3Nq+YFzbHNFVNvza
 wZVyNdLOQUoSrz2PDrdRBysKE1OiaMm4MegW3Onj8jG8v7Fe/CJ0hM54jp8parmlNmB7
 7JQ53dwMwJx+K4+xsh/0RVIq4/tqWXd3iSwLnaviZDLpaO4KDUhzFhPiv/gw7s2PY77Y
 EeMAff3BiPDxfOxjHr67/Z0U2dcG6HevA30yS7ShiaicsDVAIFqmMwNtobQ6eBOHk0kq
 mrxw==
X-Gm-Message-State: AOJu0YwfWXIV45JQVW4NBIE+qEE27FriouX09tc47jao/kiJUm5HEeti
 XQzd3H8WsMYspMDwTf9O8WOArF0aMfM8ykDqXy1nuTgpxKXVhOZ75iiDOpUxzi7/MWjNV1ird7Z
 EY4YOTAhbO23Hngh+JD76xdXC/a8ql78OaeqE941sfiU5/t+VgvawMFFDWvQOt+hpktrcPPfoJL
 I=
X-Received: by 2002:aa7:c6d3:0:b0:531:f4:57a8 with SMTP id
 b19-20020aa7c6d3000000b0053100f457a8mr11972728eds.26.1696321848250; 
 Tue, 03 Oct 2023 01:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3UeMGLLw8V/A9wj4DU1d+Wb+fA9JYIuSZPph7QBzDNHtkEtnCe9yiuFbWjxE324f+tWnDFA==
X-Received: by 2002:aa7:c6d3:0:b0:531:f4:57a8 with SMTP id
 b19-20020aa7c6d3000000b0053100f457a8mr11972713eds.26.1696321847887; 
 Tue, 03 Oct 2023 01:30:47 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 d26-20020aa7d5da000000b0053635409213sm484993eds.34.2023.10.03.01.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:30:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 02/24] accel/kvm/kvm-all: Handle register access errors
Date: Tue,  3 Oct 2023 10:30:19 +0200
Message-ID: <20231003083042.110065-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A register access error typically means something seriously wrong
happened so that anything bad can happen after that and recovery is
impossible.
Even failing one register access is catastorophic as
architecture-specific code are not written so that it torelates such
failures.

Make sure the VM stop and nothing worse happens if such an error occurs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20221201102728.69751-1-akihiko.odaki@daynix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ff1578bb32b..72e1d1141c4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2851,7 +2851,13 @@ bool kvm_cpu_check_are_resettable(void)
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-        kvm_arch_get_registers(cpu);
+        int ret = kvm_arch_get_registers(cpu);
+        if (ret) {
+            error_report("Failed to get registers: %s", strerror(-ret));
+            cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+            vm_stop(RUN_STATE_INTERNAL_ERROR);
+        }
+
         cpu->vcpu_dirty = true;
     }
 }
@@ -2865,7 +2871,13 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
 
 static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
 {
-    kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE);
+    int ret = kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE);
+    if (ret) {
+        error_report("Failed to put registers after reset: %s", strerror(-ret));
+        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+        vm_stop(RUN_STATE_INTERNAL_ERROR);
+    }
+
     cpu->vcpu_dirty = false;
 }
 
@@ -2876,7 +2888,12 @@ void kvm_cpu_synchronize_post_reset(CPUState *cpu)
 
 static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 {
-    kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE);
+    int ret = kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE);
+    if (ret) {
+        error_report("Failed to put registers after init: %s", strerror(-ret));
+        exit(1);
+    }
+
     cpu->vcpu_dirty = false;
 }
 
@@ -2969,7 +2986,14 @@ int kvm_cpu_exec(CPUState *cpu)
         MemTxAttrs attrs;
 
         if (cpu->vcpu_dirty) {
-            kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE);
+            ret = kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE);
+            if (ret) {
+                error_report("Failed to put registers after init: %s",
+                             strerror(-ret));
+                ret = -1;
+                break;
+            }
+
             cpu->vcpu_dirty = false;
         }
 
-- 
2.41.0


