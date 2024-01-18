Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E4831913
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:25:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRRy-0003bK-Fr; Thu, 18 Jan 2024 07:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRn-0003Tt-LM
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRl-00069e-CP
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zwo8gv+Nfm+lDqFRavE7UEJZC+0js1OM/QRX97Z4do=;
 b=csDfVfq5FTroNvSUqDQ4SvO50Js0PhZ4uJ0VMPklLPfNTNZCPu0+Hh+uHfDEYXnobBWd9u
 mh91dta4af5a9wNPtrmsfOaTMbl4NNS+ho7Iq66V/DdkDIXzjlTMU0bNfMWpuxXT0JDGcD
 /cSo1dGB4JVtAAUMS+EhwzxRYTb2804=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-0VHBUsyNPGeyA-XbOB-NBw-1; Thu, 18 Jan 2024 07:24:35 -0500
X-MC-Unique: 0VHBUsyNPGeyA-XbOB-NBw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2b8bd6c6a3so810332466b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580673; x=1706185473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zwo8gv+Nfm+lDqFRavE7UEJZC+0js1OM/QRX97Z4do=;
 b=xKF5dWE9vRKAbgvqGwaUSNncy5VOPsRDq9mud169OhMXaOlegPHgTB/qm0zMG4hOpU
 9ZFM0Rhayp20fMt5GWrVQ6GBu1Lzzh5QjA5yNr0yMNSlfs9A81M6jI/NQFn3ARCahk2m
 lsf09mzZrCPOlhmka6Ibd/JUFRSFsZHZby+potNonDnmKH+tChciBUutY67Nfst1/4eI
 Bpr2FkfWm/pLT3dn/vkoH+AZlSNr4b/H4jEE/3tMalIMsEEHp5OWgAhAXpjhCY3DgVni
 BP8UAq4tWk6soyLXXCqFkHD/siW48MvIdMO6kJylAS2Z50+1Fz/l4APMk6qt2NvKmoi9
 9mDA==
X-Gm-Message-State: AOJu0Yz+pIOCjdvDE4PDF7Y3XPpHiWmnoQtLI3HS9LZICORyD+XGLRuC
 TdbUkvLDG2GrZSjD3OIHOY5E9cWJSyXWPx0CU7Fny5xWpDa0Fu1xmpcIuDrpqpsjDMVV/wWsYDh
 nSVp/d15x60NZ5oyZtzJclc4sHJvFA00uH4zVMSuTD0jDwGoUdic+KaeESeyEtFfY0JNaYUxhda
 kE+riskN36dSpJg3eZe7Ata5gJfyCEBUKr3u2R
X-Received: by 2002:a17:906:8c7:b0:a28:7fe8:8b29 with SMTP id
 o7-20020a17090608c700b00a287fe88b29mr459514eje.68.1705580673124; 
 Thu, 18 Jan 2024 04:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6m3/sfGr3z/AEDtkz2sC24fPJQmAf9W+8Nm/ZFCfG0eLWjdljqnw/K5ZFSXxOWnMzpjio3Q==
X-Received: by 2002:a17:906:8c7:b0:a28:7fe8:8b29 with SMTP id
 o7-20020a17090608c700b00a287fe88b29mr459505eje.68.1705580672803; 
 Thu, 18 Jan 2024 04:24:32 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a17090627c700b00a19b7362dcfsm9062109ejc.139.2024.01.18.04.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PULL 09/16] Add class property to configure KVM device node to use
Date: Thu, 18 Jan 2024 13:24:09 +0100
Message-ID: <20240118122416.9209-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daan De Meyer <daan.j.demeyer@gmail.com>

This allows passing the KVM device node to use as a file
descriptor via /dev/fdset/XX. Passing the device node to
use as a file descriptor allows running qemu unprivileged
even when the user running qemu is not in the kvm group
on distributions where access to /dev/kvm is gated behind
membership of the kvm group (as long as the process invoking
qemu is able to open /dev/kvm and passes the file descriptor
to qemu).

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Message-ID: <20231021134015.1119597-1-daan.j.demeyer@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm_int.h |  1 +
 accel/kvm/kvm-all.c      | 25 ++++++++++++++++++++++++-
 qemu-options.hx          |  8 +++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index fd846394be1..882e37e12c5 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -120,6 +120,7 @@ struct KVMState
     uint32_t xen_caps;
     uint16_t xen_gnttab_max_frames;
     uint16_t xen_evtchn_max_pirq;
+    char *device;
 };
 
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index bbc60146d15..49e755ec4ad 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2349,7 +2349,7 @@ static int kvm_init(MachineState *ms)
     QTAILQ_INIT(&s->kvm_sw_breakpoints);
 #endif
     QLIST_INIT(&s->kvm_parked_vcpus);
-    s->fd = qemu_open_old("/dev/kvm", O_RDWR);
+    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
     if (s->fd == -1) {
         fprintf(stderr, "Could not access KVM kernel module: %m\n");
         ret = -errno;
@@ -3585,6 +3585,24 @@ static void kvm_set_dirty_ring_size(Object *obj, Visitor *v,
     s->kvm_dirty_ring_size = value;
 }
 
+static char *kvm_get_device(Object *obj,
+                            Error **errp G_GNUC_UNUSED)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    return g_strdup(s->device);
+}
+
+static void kvm_set_device(Object *obj,
+                           const char *value,
+                           Error **errp G_GNUC_UNUSED)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    g_free(s->device);
+    s->device = g_strdup(value);
+}
+
 static void kvm_accel_instance_init(Object *obj)
 {
     KVMState *s = KVM_STATE(obj);
@@ -3603,6 +3621,7 @@ static void kvm_accel_instance_init(Object *obj)
     s->xen_version = 0;
     s->xen_gnttab_max_frames = 64;
     s->xen_evtchn_max_pirq = 256;
+    s->device = NULL;
 }
 
 /**
@@ -3643,6 +3662,10 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "dirty-ring-size",
         "Size of KVM dirty page ring buffer (default: 0, i.e. use bitmap)");
 
+    object_class_property_add_str(oc, "device", kvm_get_device, kvm_set_device);
+    object_class_property_set_description(oc, "device",
+        "Path to the device node to use (default: /dev/kvm)");
+
     kvm_arch_accel_class_init(oc);
 }
 
diff --git a/qemu-options.hx b/qemu-options.hx
index b66570ae006..2ae51005c12 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -188,7 +188,8 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                dirty-ring-size=n (KVM dirty ring GFN count, default 0)\n"
     "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
     "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
-    "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
+    "                thread=single|multi (enable multi-threaded TCG)\n"
+    "                device=path (KVM device path, default /dev/kvm)\n", QEMU_ARCH_ALL)
 SRST
 ``-accel name[,prop=value[,...]]``
     This is used to enable an accelerator. Depending on the target
@@ -269,6 +270,11 @@ SRST
         open up for a specified of time (i.e. notify-window).
         Default: notify-vmexit=run,notify-window=0.
 
+    ``device=path``
+        Sets the path to the KVM device node. Defaults to ``/dev/kvm``. This
+        option can be used to pass the KVM device to use via a file descriptor
+        by setting the value to ``/dev/fdset/NN``.
+
 ERST
 
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
-- 
2.43.0


