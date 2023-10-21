Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B1D7D1D4E
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 15:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quCM1-0003gm-Q1; Sat, 21 Oct 2023 09:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1quCDP-0000k0-Rh
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 09:40:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1quCDO-0006M1-7q
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 09:40:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so13236575e9.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697895628; x=1698500428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=At1jsVLlupIiRvoiq5by/aHnfQWBZjYV5W5vgE3NJa4=;
 b=CMe0QBtJmS2VSIWcpiMjYq+J0jqR9gIeBJVejyDZdaW5/Vr38ObIsKgo0GH022TDm2
 dVwjCqtPsNKk4Y70veF4sOU9gPj4CgFHHMmsdmi31HbD3NeXBnPTN6cGvYHyBEYRcfMU
 b8jFqxk43wHdgOFNiEQ9hxh6YvNlFAthNwnNqGfPiFTPUeUPDscnumHqdaTHh+3VuBkO
 YcQQ1n1l7FohcISv7bv3+lunRKVDNO0WFdOI14nk+cPJVf+okE1fUJEk5/oum5fIHMgs
 ELyQqqQZ94206sLXfgPofgJ+kFfJOrJMBFDwkhBClYxbFO1YieSAIF4/rK3i2rZenMEb
 Poyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697895628; x=1698500428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=At1jsVLlupIiRvoiq5by/aHnfQWBZjYV5W5vgE3NJa4=;
 b=K/hWi8kSphUVZZ/mBXO6Iru8vu2JZhkbtwyc/1jQI94oVmEaPRUWBs9XRNGRMCramP
 J475IeohrGnf8D+yWucelguqS95zbpmt7DUAlKbYK4FO7bTJLWd75rVkG/pBOnLGLiQC
 3KdLXZmoKGg6DCUlkk66KBBcw90QzBAtKs8NQ9wWgZzLKUHZV4fhZJOxBz8CvZ84zYeq
 7xGmdkDJ0EjQYD1MjQbJZYEXLy1c1fXR/0SStvQd7Nsw8s12y6WcKn3eo/g4gCUS5dFH
 Eop7z2AUBQpKeVRunQi9YlWtoJAOStRy7T4L9YU/0LXS+ZlTLtYsYuMlaIhXOMICwhsO
 h5Vw==
X-Gm-Message-State: AOJu0YzulPGC1iOzvXPiPLOhwwlranFyrETLALMXTIjAqikPxpxf++L7
 7fIbdG0CMyeaG4Ka3dKqclTWf5gY4do=
X-Google-Smtp-Source: AGHT+IEnZ/0NJLa2Gx/dyL23Jh+pUGPX2QqVxWhvvc8m5QJWNV2Sl/aI/LuNDM2hajRdioanaI2evA==
X-Received: by 2002:a05:600c:4f45:b0:407:7e7a:6017 with SMTP id
 m5-20020a05600c4f4500b004077e7a6017mr3625970wmq.11.1697895627615; 
 Sat, 21 Oct 2023 06:40:27 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
 by smtp.googlemail.com with ESMTPSA id
 e7-20020a05600c218700b00407efbc4361sm9302948wme.9.2023.10.21.06.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 06:40:26 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH] Add class property to configure KVM device node to use
Date: Sat, 21 Oct 2023 15:40:15 +0200
Message-ID: <20231021134015.1119597-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 21 Oct 2023 09:48:48 -0400
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

This allows passing the KVM device node to use as a file
descriptor via /dev/fdset/XX. Passing the device node to
use as a file descriptor allows running qemu unprivileged
even when the user running qemu is not in the kvm group
on distributions where access to /dev/kvm is gated behind
membership of the kvm group (as long as the process invoking
qemu is able to open /dev/kvm and passes the file descriptor
to qemu).

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 accel/kvm/kvm-all.c      | 25 ++++++++++++++++++++++++-
 include/sysemu/kvm_int.h |  1 +
 qemu-options.hx          |  8 +++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 72e1d1141c..3e0b2d00e9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2478,7 +2478,7 @@ static int kvm_init(MachineState *ms)
     QTAILQ_INIT(&s->kvm_sw_breakpoints);
 #endif
     QLIST_INIT(&s->kvm_parked_vcpus);
-    s->fd = qemu_open_old("/dev/kvm", O_RDWR);
+    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
     if (s->fd == -1) {
         fprintf(stderr, "Could not access KVM kernel module: %m\n");
         ret = -errno;
@@ -3775,6 +3775,24 @@ static void kvm_set_dirty_ring_size(Object *obj, Visitor *v,
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
@@ -3793,6 +3811,7 @@ static void kvm_accel_instance_init(Object *obj)
     s->xen_version = 0;
     s->xen_gnttab_max_frames = 64;
     s->xen_evtchn_max_pirq = 256;
+    s->device = NULL;
 }
 
 /**
@@ -3833,6 +3852,10 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "dirty-ring-size",
         "Size of KVM dirty page ring buffer (default: 0, i.e. use bitmap)");
 
+    object_class_property_add_str(oc, "device", kvm_get_device, kvm_set_device);
+    object_class_property_set_description(oc, "device",
+        "Path to the device node to use (default: /dev/kvm)");
+
     kvm_arch_accel_class_init(oc);
 }
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index a5b9122cb8..19a5364a4b 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -124,6 +124,7 @@ struct KVMState
     uint32_t xen_caps;
     uint16_t xen_gnttab_max_frames;
     uint16_t xen_evtchn_max_pirq;
+    char *device;
 };
 
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
diff --git a/qemu-options.hx b/qemu-options.hx
index 54a7e94970..40ad15a9da 100644
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
2.41.0


