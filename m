Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBEBB18283
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 15:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhppV-00012c-Uu; Fri, 01 Aug 2025 09:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uhpYt-0007vH-Hf
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:12:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uhpYr-0004KI-2c
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:12:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso5254425e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1754053954; x=1754658754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QZFBl3XMjqJs9ITIs0pTTYPqn0HayVowzZGxu1QTQLM=;
 b=ZlCbGDPsYAkTDQ0q44pavB/VLAVIxuN7ck0RxJkGd037Twv111+omCy44SjuKnYCml
 2/kOq9WRQxse4wGVOH9MDcyMt1ox67P41XP02/B5ttdU/WmZXQ2RtHNuSr9AF7YT3TsH
 5PFlgQXVzI3X9g9tOB3aXmhQZz9go2+R+QI3B9OuFHQ4BvPfc5yRXo8z7tFHK/K81Yw2
 JUKYGpWphOLWe15SQeHP9+KowyEiD7aKrIpUPwGNLCXJLrzYp8FPrMx6I+Btj4u9Ybtm
 4Sh+O2BVhReWizQz02jOfzdlxdpARTy6TCE87sgIVhB80D0VvZNKofOgNqS87Y0M5/Va
 pECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754053954; x=1754658754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZFBl3XMjqJs9ITIs0pTTYPqn0HayVowzZGxu1QTQLM=;
 b=Jeo/FRou//B6pbNL9aSkix9PgzBqiHhiyXHi09sQ7psy50mtUH2MhE9/9D1g5b30FG
 jBrqk1JZGjsynzK+bCKBWIZXeVLISc9qucG37SydrKYUN4Nfp7G+45z/+olF/T0gr2jz
 PBhreejggh/PZE4R7nizc7iolzr3bmaSYGLU/bPVsXcTX8QAJDnM4ap+sewdTA0IyxvE
 gILwSLGCL0vdi4El55Hp9uyrNXrh+9q/Mb97A0tFvdM3FCA5CN3peECl90fS2WG25cJj
 NX8S5XIdve6p2576DSsn7QGu9dITwded+E/sqPFs1B8VwjGnZVxfA26EKjPaVPG2aCEn
 3lLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2jlWFz9OJeou1l4zqvc/GI7a7kibs2mySWgV4tQ9DapZPWyAzDH2SO5GlTd6ba0G2PrdsTfYu2Ixq@nongnu.org
X-Gm-Message-State: AOJu0Yxrokx58gqylk2odHB3W1h3r8nSf/18eNIuMWMmao8i7Vq3tgkQ
 IRD1XAnYYA3VAJEp9Avh86IReZ4Rrbf/s8lci6warWsKwxZsOeJulwk8Lxokw4LvxYE=
X-Gm-Gg: ASbGnctY+29w7tr5V6pS2/FcSVOAkJeRtDhO8cBywLDd9NZIvI5FLPQgh2bxe/LTFmr
 MSNvEFYgFrxl3rowdnkBImrVWP7028603YtC8TBDgJnZFiSsb3zkpXgIi/nZsdF3BBI7KrNNNS/
 IsYSMpLmixevGNgc7BBvVqzOvvFh1vrBx2lIZK0yakpyLIMbY5Oey++fiwoJ6Ws9MR7w+5HLot+
 UQE4yIlP6sEGiDA/kT/oBABEka7EqX00W0EfoRn7tBb+tBd/loIySi3WvOBRmNvL9JakJIx81I2
 9VPP51bDFBH17+iKCegeX4B6Y7iT6x+jx/scnLFKEgoMrd/JDLmrx2SMTeQRP1B7JcMxapmnj64
 EtgnIaQh3wmUvMYR12LVrdwUncACzAHkwg8KQDgs0jccfIYyUeXakxAlO0PjPXZ243VwZeUH0Ac
 j0y9SqsT+nD6YTGh4IujQqt8v2W/0=
X-Google-Smtp-Source: AGHT+IGF6VUXkzxD7jTuxQEPCnB97q/5xT9nU/mIsWmCe9cFXTD3T+xOCGKrQdXxLGO2MM7wP3o9Aw==
X-Received: by 2002:a05:600c:3ba3:b0:456:1abd:fcfc with SMTP id
 5b1f17b1804b1-45893943cc5mr81413845e9.25.1754053953969; 
 Fri, 01 Aug 2025 06:12:33 -0700 (PDT)
Received: from bell.fritz.box
 (p200300faaf22cf002208a86d0dff5ae9.dip0.t-ipconnect.de.
 [2003:fa:af22:cf00:2208:a86d:dff:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b0a55c92sm6475175e9.4.2025.08.01.06.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:12:33 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 kvm@vger.kernel.org, Mathias Krause <minipli@grsecurity.net>,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
Subject: [PATCH v3] i386/kvm: Provide knob to disable hypercall patching quirk
Date: Fri,  1 Aug 2025 15:12:26 +0200
Message-Id: <20250801131226.2729893-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

KVM has a weird behaviour when a guest executes VMCALL on an AMD system
or VMMCALL on an Intel CPU. Both naturally generate an invalid opcode
exception (#UD) as they are just the wrong instruction for the CPU
given. But instead of forwarding the exception to the guest, KVM tries
to patch the guest instruction to match the host's actual hypercall
instruction. That is doomed to fail for regular operating systems, as
read-only code is rather the standard these days. But, instead of
letting go the patching attempt and falling back to #UD injection, KVM
propagates its failure and injects the page fault instead.

That's wrong on multiple levels. Not only isn't that a valid exception
to be generated by these instructions, confusing attempts to handle
them. It also destroys guest state by doing so, namely the value of CR2.

Sean attempted to fix that in KVM[1] but the patch was never applied.

Later, Oliver added a quirk bit in [2] so the behaviour can, at least,
conceptually be disabled. Paolo even called out to add this very
functionality to disable the quirk in QEMU[3]. So lets just do it.

Add a new property 'hypercall-patching=on|off' to the KVM accelerator
but keep the default behaviour as-is as there are, unfortunately,
systems out there relying on the patching, e.g. KUT[4,5].

For regular operating systems, however, the patching wouldn't be needed,
nor work at all. If it would, these systrems would be vulnerable to
memory corruption attacks, freely overwriting kernel code as they
please.

[1] https://lore.kernel.org/kvm/20211210222903.3417968-1-seanjc@google.com/
[2] https://lore.kernel.org/kvm/20220316005538.2282772-2-oupton@google.com/
[3] https://lore.kernel.org/kvm/80e1f1d2-2d79-22b7-6665-c00e4fe9cb9c@redhat.com/
[4] https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/f045ea5627a3/x86/apic.c#L644
[5] https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/f045ea5627a3/x86/vmexit.c#L36

Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
Xiaoyao, I left out your Tested-by and Reviewed-by as I changed the code
(slightly) and it didn't felt right to pick these up. However, as only
the default value changed, the functionality would be the same if you
tested both cases explicitly (-accel kvm,hypercall-patching={on,off}).

v3:
- switch default to 'on' to not change the default behaviour
- reference KUT tests relying on hypercall patching

v2:
- rename hypercall_patching_enabled to hypercall_patching (Xiaoyao Li)
- make use of error_setg*() (Xiaoyao Li)

 accel/kvm/kvm-all.c      |  1 +
 include/system/kvm_int.h |  1 +
 qemu-options.hx          | 10 +++++++++
 target/i386/kvm/kvm.c    | 45 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f865..a68f779b6c1c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3997,6 +3997,7 @@ static void kvm_accel_instance_init(Object *obj)
     s->kvm_dirty_ring_size = 0;
     s->kvm_dirty_ring_with_bitmap = false;
     s->kvm_eager_split_size = 0;
+    s->hypercall_patching = true;
     s->notify_vmexit = NOTIFY_VMEXIT_OPTION_RUN;
     s->notify_window = 0;
     s->xen_version = 0;
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 9247493b0299..ec891ca8e302 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -160,6 +160,7 @@ struct KVMState
     uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size */
     struct KVMDirtyRingReaper reaper;
     struct KVMMsrEnergy msr_energy;
+    bool hypercall_patching;
     NotifyVmexitOption notify_vmexit;
     uint32_t notify_window;
     uint32_t xen_version;
diff --git a/qemu-options.hx b/qemu-options.hx
index ab23f14d2178..98af1a91e6e6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -236,6 +236,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                dirty-ring-size=n (KVM dirty ring GFN count, default 0)\n"
     "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
     "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
+    "                hypercall-patching=on|off (disable KVM's VMCALL/VMMCALL hypercall patching quirk, x86 only)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n"
     "                device=path (KVM device path, default /dev/kvm)\n", QEMU_ARCH_ALL)
 SRST
@@ -318,6 +319,15 @@ SRST
         open up for a specified of time (i.e. notify-window).
         Default: notify-vmexit=run,notify-window=0.
 
+    ``hypercall-patching=on|off``
+        KVM tries to recover from the wrong hypercall instruction being used by
+        a guest by attempting to rewrite it to the one supported natively by
+        the host CPU (VMCALL on Intel, VMMCALL for AMD systems). However, this
+        patching may fail if the guest memory is write protected, leading to a
+        page fault getting propagated to the guest instead of an illegal
+        instruction exception. As this may confuse guests, this option allows
+        disabling it (x86 only, enabled by default).
+
     ``device=path``
         Sets the path to the KVM device node. Defaults to ``/dev/kvm``. This
         option can be used to pass the KVM device to use via a file descriptor
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8d7..a841d53c240f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3228,6 +3228,26 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
     return 0;
 }
 
+static int kvm_vm_disable_hypercall_patching(KVMState *s, Error **errp)
+{
+    int valid_quirks = kvm_vm_check_extension(s, KVM_CAP_DISABLE_QUIRKS2);
+    int ret = -1;
+
+    if (valid_quirks & KVM_X86_QUIRK_FIX_HYPERCALL_INSN) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_DISABLE_QUIRKS2, 0,
+                                KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
+        if (ret) {
+            error_setg_errno(errp, -ret, "kvm: failed to disable "
+                             "hypercall patching quirk: %s",
+                             strerror(-ret));
+        }
+    } else {
+        error_setg(errp, "kvm: disabling hypercall patching not supported");
+    }
+
+    return ret;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret;
@@ -3367,6 +3387,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    if (!s->hypercall_patching) {
+        if (kvm_vm_disable_hypercall_patching(s, &local_err)) {
+            error_report_err(local_err);
+        }
+    }
+
     return 0;
 }
 
@@ -6478,6 +6504,19 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask)
     }
 }
 
+static bool kvm_arch_get_hypercall_patching(Object *obj, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    return s->hypercall_patching;
+}
+
+static void kvm_arch_set_hypercall_patching(Object *obj, bool value,
+                                            Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    s->hypercall_patching = value;
+}
+
 static int kvm_arch_get_notify_vmexit(Object *obj, Error **errp)
 {
     KVMState *s = KVM_STATE(obj);
@@ -6611,6 +6650,12 @@ static void kvm_arch_set_xen_evtchn_max_pirq(Object *obj, Visitor *v,
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
+    object_class_property_add_bool(oc, "hypercall-patching",
+                                   kvm_arch_get_hypercall_patching,
+                                   kvm_arch_set_hypercall_patching);
+    object_class_property_set_description(oc, "hypercall-patching",
+                                          "Disable hypercall patching quirk");
+
     object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
                                    &NotifyVmexitOption_lookup,
                                    kvm_arch_get_notify_vmexit,
-- 
2.30.2


