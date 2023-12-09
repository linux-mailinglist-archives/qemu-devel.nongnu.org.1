Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01280B4EC
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Dec 2023 15:33:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rByNh-0002X4-2K; Sat, 09 Dec 2023 09:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rByNd-0002Wd-Ib
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 09:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rByNb-000396-JZ
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 09:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702132349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ilQeqoOK+54I+XYs63lNFXG9Moli8cvYedp/SDEiEuU=;
 b=RlxJxccHp0cSYUDfWHOdMhAfsvyMyH2keUw3oZ+tDGvKzNhXYlj/rXZT1EG8PUMGw66KBT
 qtDpxGUcMadS7ssAXW0nC035raud8BhwYmRhZEBCk2i6JK72cpAkwNrP5HHhcnuoUxtx8V
 rfiV7gWGyrbe4j1pKGKR4ygFLgfPo7g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572--TSnGjRVPT2UAMylT9DcaQ-1; Sat, 09 Dec 2023 09:32:27 -0500
X-MC-Unique: -TSnGjRVPT2UAMylT9DcaQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a1d38492da7so179095166b.0
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 06:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702132345; x=1702737145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ilQeqoOK+54I+XYs63lNFXG9Moli8cvYedp/SDEiEuU=;
 b=QBhyQGYgMHeUiajnwmfJxwfO/aMTYzunERZQEXce+aHjLvrjKkvVDjIX7bKECzOGyU
 WsusFMEzlevxrhSYvccIhlx6nDPkQ4OamN46aJKG9WumuU/dipjBnq+N2VvNAYc9YZa/
 pfQ13uQyrmOuDsoWYQ4aL0S0v3g3oMo5rM1/TwmH0kPUP7uUkk7GXyLJu+FG1IgO0LBA
 17Z3AwnBaT5iTQsO6JhkHPnfvYOiQ5tKCyIDn+c13zFx9Zy0Zt9c/hEXsu4EiRH78y8V
 X12I7O2H3H/DvDLMXAlrQnGCD+7ZplW6Zb5zgtu1cFnZVuJolAhlwi4t3rDf2b/6aHV8
 GJ4A==
X-Gm-Message-State: AOJu0YwSgpOmkB4nTYeMGEENVrTfvpv7Fe0IG/KorxA/Y/HqmA77u767
 Dtk6ZxOaR0SV9AsPfYwg1nGsoxIU2SinGRj4J/BueVkfVph+YgUILq8J35T/0O3q5xV/Ni1blck
 QMJN2PAQGrRj4GfffJPRDDx0QIM3NZo9DOxoKtYgAHCMrSWYqUAhx6yv9H4q9x7qIMfFNMeOvCi
 I=
X-Received: by 2002:a17:907:a195:b0:a18:a0cc:8729 with SMTP id
 om21-20020a170907a19500b00a18a0cc8729mr358691ejc.57.1702132345545; 
 Sat, 09 Dec 2023 06:32:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdpkXWcOu05zlvVmvm6GicXJHrzvStGKhAL1wOJHgevDyqfvfgp1a7ZUUECxkWt4fwYZ0NFQ==
X-Received: by 2002:a17:907:a195:b0:a18:a0cc:8729 with SMTP id
 om21-20020a170907a19500b00a18a0cc8729mr358683ejc.57.1702132345165; 
 Sat, 09 Dec 2023 06:32:25 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a17090699d000b00a1e27e584c7sm2282262ejn.69.2023.12.09.06.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 06:32:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <stefano.stabellini@amd.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Young <m.a.young@durham.ac.uk>
Subject: [PATCH] xen: fix condition for enabling the Xen accelerator
Date: Sat,  9 Dec 2023 15:32:22 +0100
Message-ID: <20231209143222.2916891-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
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

A misspelled condition in xen_native.h is hiding a bug in the enablement of
Xen for qemu-system-aarch64.  The bug becomes apparent when building for
Xen 4.18.

While the i386 emulator provides the xenpv machine type for multiple architectures,
and therefore can be compiled with Xen enabled even when the host is Arm, the
opposite is not true: qemu-system-aarch64 can only be compiled with Xen support
enabled when the host is Arm.

Expand the computation of accelerator_targets['CONFIG_XEN'] similar to what is
already there for KVM, and fix xen_native.h.

Cc: Stefano Stabellini <stefano.stabellini@amd.com>
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Reported-by: Michael Young <m.a.young@durham.ac.uk>
Supersedes: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/xen/xen_native.h |  2 +-
 meson.build                 | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index 6f09c48823b..1a5ad693a4d 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -532,7 +532,7 @@ static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
 }
 #endif
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41700
 #define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
 #define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
 #define GUEST_VIRTIO_MMIO_SPI_FIRST   33
diff --git a/meson.build b/meson.build
index ec01f8b138a..67f4ede8aea 100644
--- a/meson.build
+++ b/meson.build
@@ -123,21 +123,24 @@ if get_option('kvm').allowed() and targetos == 'linux'
   kvm_targets_c = '"' + '" ,"'.join(kvm_targets) + '"'
 endif
 config_host_data.set('CONFIG_KVM_TARGETS', kvm_targets_c)
-
 accelerator_targets = { 'CONFIG_KVM': kvm_targets }
 
+if cpu in ['x86', 'x86_64']
+  xen_targets = ['i386-softmmu', 'x86_64-softmmu']
+elif cpu in ['arm', 'aarch64']
+  # i386 emulator provides xenpv machine type for multiple architectures
+  xen_targets = ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu']
+else
+  xen_targets = []
+endif
+accelerator_targets += { 'CONFIG_XEN': xen_targets }
+
 if cpu in ['aarch64']
   accelerator_targets += {
     'CONFIG_HVF': ['aarch64-softmmu']
   }
 endif
 
-if cpu in ['x86', 'x86_64', 'arm', 'aarch64']
-  # i386 emulator provides xenpv machine type for multiple architectures
-  accelerator_targets += {
-    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu'],
-  }
-endif
 if cpu in ['x86', 'x86_64']
   accelerator_targets += {
     'CONFIG_HVF': ['x86_64-softmmu'],
-- 
2.43.0


