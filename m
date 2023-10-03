Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 630BF7B640B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnal0-0005Ss-2L; Tue, 03 Oct 2023 04:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnakw-0005Rn-Ay
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:27:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnakt-00080X-VC
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:27:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40666aa674fso6071415e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696321666; x=1696926466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NncaZm4Rq7ypawzJ8HayEn0g0SZFapHip8wBEcGgdE=;
 b=t82/BKoJiCOAT3Ux6+Y4iWfkliIsjP7A/D9QISA1mQjQtvLiqYxQW6lkb7Ij4VallT
 xIvHGPe7A7qT1vq2oSF8OdbMuxZlH0SaWceDclQFvoTRNRK9jb+h2Ji2GYAUFC3eoKut
 WM/vAZOhewKO2LaPtvZqorBeo1MKxmxx8WgYorVJ4BsQptJ5Gg0E/k06ZXNq0bMyxUpt
 +iFtm5+qFdT/t13P7QB7AQmIQYCY/XtYt8Tp19Sq25coFpm35b8LWaAG3s+cmj4frWC1
 9c3nH9cXQkV065atXsFYfUbFj4JQbPX2bXKEFSuLNqcURT6Np9oIhQuM/hI1ylYoeHRr
 OfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321666; x=1696926466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NncaZm4Rq7ypawzJ8HayEn0g0SZFapHip8wBEcGgdE=;
 b=rF1LVuMkh+DEdWP50baGaHzvpILpLY6DD3X7qa0MVF9HT88V39Wv4IC3yl4xRao4mZ
 Nx2DmukPCeMeQ3khkEo4EIcUKPZr4GcjFKqMFFwbJ4aCc2iKeWcQimshDkJYlcrkYYmb
 b/tKra6PwNBNBaaw+woTUgAKeX1qjpgKrbBqSlmFeQa0gmk+lvCLJOMU3wXoZdc94qjk
 DXQStCTP+kUz4V3B/IPQMu2ukYf2xy2nzKh7rEfonhosgq5oZpwgYtS06jaNs0K4oEfw
 xYRujAI91/rb32gpPa7M4HyZqKhB4iStBT733yIoLfll+aRT9/fBi4Cmw7YCFWds/74F
 3BWg==
X-Gm-Message-State: AOJu0YyOHNuXp4EiwTTgfA5E+ihkzhJGkqnLUyTJ0nlVSNQxabdaR1a0
 Ew0buduFSIGtfzM6wxSjnPlsRa3uvJ7cSC7T40O5DA==
X-Google-Smtp-Source: AGHT+IFKTop6RARJm3uUlDOI3XgMfv8T8AAVtMSQ4W6hzYJzoHKSeQrFdBbu5EGJVsVOhK4Mdr3L2A==
X-Received: by 2002:a7b:cbd4:0:b0:3fe:d1e9:e6b8 with SMTP id
 n20-20020a7bcbd4000000b003fed1e9e6b8mr12338088wmi.12.1696321666116; 
 Tue, 03 Oct 2023 01:27:46 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a1c7408000000b003fefcbe7fa8sm707360wmc.28.2023.10.03.01.27.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 01:27:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/5] hw/i386/apic: Defer error check from apic_get_class to
 kvm_apic_realize
Date: Tue,  3 Oct 2023 10:27:25 +0200
Message-ID: <20231003082728.83496-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003082728.83496-1-philmd@linaro.org>
References: <20231003082728.83496-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

apic_get_class() isn't supposed to fail. kvm_apic_realize() is
DeviceRealize() handler, which can fail. Defer the error check
to the latter.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/kvm/apic.c       | 5 +++++
 target/i386/cpu-sysemu.c | 8 --------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 1e89ca0899..4883308247 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -228,6 +228,11 @@ static void kvm_apic_realize(DeviceState *dev, Error **errp)
 {
     APICCommonState *s = APIC_COMMON(dev);
 
+    if (!kvm_irqchip_in_kernel()) {
+        error_setg(errp, "KVM does not support userspace APIC");
+        return;
+    }
+
     memory_region_init_io(&s->io_memory, OBJECT(s), &kvm_apic_io_ops, s,
                           "kvm-apic-msi", APIC_SPACE_SIZE);
 
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 2375e48178..6a228c9178 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -253,10 +253,6 @@ APICCommonClass *apic_get_class(Error **errp)
 
     /* TODO: in-kernel irqchip for hvf */
     if (kvm_enabled()) {
-        if (!kvm_irqchip_in_kernel()) {
-            error_setg(errp, "KVM does not support userspace APIC");
-            return NULL;
-        }
         apic_type = "kvm-apic";
     } else if (xen_enabled()) {
         apic_type = "xen-apic";
@@ -272,10 +268,6 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
     APICCommonState *apic;
     APICCommonClass *apic_class = apic_get_class(errp);
 
-    if (!apic_class) {
-        return;
-    }
-
     cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
     object_property_add_child(OBJECT(cpu), "lapic",
                               OBJECT(cpu->apic_state));
-- 
2.41.0


