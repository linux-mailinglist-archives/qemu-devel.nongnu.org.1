Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7218010F5
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:17:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977W-0003FH-1L; Fri, 01 Dec 2023 12:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977F-0002vg-BB
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977D-0007mQ-LC
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3TadiBzWxZMuZn5AZtIJq/ijRLN+jTi0zGXDM8cGr3A=;
 b=TnpaKLunKA5SeZENYpT62cfinIt4kRd0sgxWa9gesskv+IZOihyh8/eskBC6raUnN0+2mV
 nIM46ttlwU8+xoFn9xIJjS4shaI8W9+9aI4/tqgb4UEFyUXMkG0E17SDt/6kH7xfj6zgai
 bENt6phbsQSHqpr9RUYnF+ARpgjPIUE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-CosZnLNrODKSGmODdqHGsQ-1; Fri, 01 Dec 2023 12:15:42 -0500
X-MC-Unique: CosZnLNrODKSGmODdqHGsQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50be177a378so171090e87.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450939; x=1702055739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TadiBzWxZMuZn5AZtIJq/ijRLN+jTi0zGXDM8cGr3A=;
 b=m7wrpvTU/kl1TFagMDrThI35HPekCL84MBb2/olsI4/gDM7J+0JyQ1AUryHn2fK/nP
 cuSV5aRgtFvkKeKWJF7Gq4YhbZXOkMWN1eY0gTrnxK8ZD3RZKzFm1hep5EI1KhMB7kqe
 7GUpxLdNt59Ycg8SstZr8kuyv/aVWjidN/nvlwoJWyDzhQBwaFpPqhVvuKV3v+AgWmkm
 V/+qcuY+6PLoVB4c1kWi8QIqZM+JANFB8qM822GaUEOEYbHDLEeXo0ukw5LnWEMpHXiG
 g1oiNsGZgBTQuTcd5mgaWYo2kQHoYKc5xnBkOjMKrlsG9UjZoOCvBX3JDWcb5P/EkAJA
 0WEw==
X-Gm-Message-State: AOJu0YyTmCqZ8zg4VnqEk9lwtBlleyQWfO3Dy4lTovddXQCdl0l0bTx8
 4abQ+U2RDL8CX/2eGedOhRQEyDYGq74A+IsvHsxx5FYSgitpHTKpBhbVp0/SXJZHXm9RU9xtLFW
 KFHphGshSvYpyPCQ7NkqC7wF05PV4ubNEXSQTYC+M6VtEmmUxiZJpvBT/xzTXpYxmldUS
X-Received: by 2002:a19:5507:0:b0:50b:d944:c01c with SMTP id
 n7-20020a195507000000b0050bd944c01cmr428645lfe.222.1701450939336; 
 Fri, 01 Dec 2023 09:15:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsBepjSxAY0vHp2eJgc8vzN/lsRS6BCwwp3R03VfJM4y8tmoeuPndAuXb5NJsxjhNe6qnJRQ==
X-Received: by 2002:a19:5507:0:b0:50b:d944:c01c with SMTP id
 n7-20020a195507000000b0050bd944c01cmr428635lfe.222.1701450938929; 
 Fri, 01 Dec 2023 09:15:38 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a05600c0a4400b0040b4ccdcffbsm6040810wmq.2.2023.12.01.09.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:38 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Hoffman <dhoff749@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 11/15] hw/i386: fix short-circuit logic with non-optimizing
 builds
Message-ID: <74b665da374aa1462fe3067415ffe167621fccc7.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Daniel Hoffman <dhoff749@gmail.com>

`kvm_enabled()` is compiled down to `0` and short-circuit logic is
used to remove references to undefined symbols at the compile stage.
Some build configurations with some compilers don't attempt to
simplify this logic down in some cases (the pattern appears to be
that the literal false must be the first term) and this was causing
some builds to emit references to undefined symbols.

An example of such a configuration is clang 16.0.6 with the following
configure: ./configure --enable-debug --without-default-features
--target-list=x86_64-softmmu --enable-tcg-interpreter

Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
Message-Id: <20231119203116.3027230-1-dhoff749@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/x86.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b3d054889b..2b6291ad8d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -131,8 +131,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     /*
      * Can we support APIC ID 255 or higher?  With KVM, that requires
      * both in-kernel lapic and X2APIC userspace API.
+     *
+     * kvm_enabled() must go first to ensure that kvm_* references are
+     * not emitted for the linker to consume (kvm_enabled() is
+     * a literal `0` in configurations where kvm_* aren't defined)
      */
-    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
+    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
         (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
         error_report("current -smp configuration requires kernel "
                      "irqchip and X2APIC API support.");
@@ -418,8 +422,13 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     }
     cpu->thread_id = topo_ids.smt_id;
 
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
-        kvm_enabled() && !kvm_hv_vpindex_settable()) {
+    /*
+    * kvm_enabled() must go first to ensure that kvm_* references are
+    * not emitted for the linker to consume (kvm_enabled() is
+    * a literal `0` in configurations where kvm_* aren't defined)
+    */
+    if (kvm_enabled() && hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
+        !kvm_hv_vpindex_settable()) {
         error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
         return;
     }
-- 
MST


