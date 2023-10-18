Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C26A7CE305
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:40:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Yx-0001O9-EJ; Wed, 18 Oct 2023 12:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Yc-0001Co-Hb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Ya-0007Px-QP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l81+EyOeU3LSHiNMN6aj26DOrdFpEtWh0cb0/Y84qOo=;
 b=N0w9l9Ftwt6G8ZHQV7t8EWkXvGTyadHuKy1olAaxt0qKgDkyWD6C/fmZesKO5Uypg7w6HG
 DDMM5mlwm5+APHKKkIaSXpr61sA9w0U55ViAaCKQhrZ8naAbvvzsf8oAU0FPv9buCaHoxJ
 fn0o8SaFbKnrAHwDIwyhR3+lZpImdPc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-iiVz7xmWM9y3WP4Rjng0Gw-1; Wed, 18 Oct 2023 12:38:02 -0400
X-MC-Unique: iiVz7xmWM9y3WP4Rjng0Gw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a9e12a3093so778494366b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647081; x=1698251881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l81+EyOeU3LSHiNMN6aj26DOrdFpEtWh0cb0/Y84qOo=;
 b=TOxyvDnhRngyPtaj4WwOfe1nQhceW5ETai/1RX7hgoSJYn9kyC9pjyjfuUYhKHMhBz
 RhG0QofxXdra2L3R+i6AXkwXrJrMB6exbfLASRFiU9aAeAAIxDggQgAZI9crH+u1WXEH
 NYoIMCrSwVVw8neLVqu+rw6Ubdixepx1DczMC12wibxR0z4cF3ShCPyzRxTBOrW4NFe7
 yaSt6a8nqrwWqolFgEb6XsYM/XcZ0HP9N5gqqiHsvdDqNreGlRwQdpeCTFkSowVjaJZ7
 ssQr3aH+9SLj+PCh/FePeRIattineBucAJtYa0o3G/LIFeUTbRqn7esZTJ9uAmPeCGQo
 KKRw==
X-Gm-Message-State: AOJu0YwuEOMcTYRqxw+UBfnxusPm3cNE6w5Lyw74bGFU5ub5uP1gwEri
 bzqloPFHOXNH+4L1b/9sRfqJmpQxurmZbrpy8rMro56SJQ8ya4YWldllFH3hnyt0isDgE06snq/
 s+sQ+90PoiY5clefFuZBrcNxRSsclnft5M0vbAh9+C3kXVP3Sg+Bw9DstKLUZWjaXGXZQ8JDMVG
 c=
X-Received: by 2002:a17:907:7203:b0:9aa:1794:945b with SMTP id
 dr3-20020a170907720300b009aa1794945bmr4961575ejc.22.1697647080857; 
 Wed, 18 Oct 2023 09:38:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA0V9+RH6GJAcpy5133H6UidEEqPjulDoN4+vNartrnn20sf11H+qt3FbEEDJMNHb8l3SUTg==
X-Received: by 2002:a17:907:7203:b0:9aa:1794:945b with SMTP id
 dr3-20020a170907720300b009aa1794945bmr4961555ejc.22.1697647080474; 
 Wed, 18 Oct 2023 09:38:00 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a50d5c2000000b0053ebe6c1396sm3131611edj.27.2023.10.18.09.37.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/17] kvm: i386: require KVM_CAP_SET_IDENTITY_MAP_ADDR
Date: Wed, 18 Oct 2023 18:37:27 +0200
Message-ID: <20231018163728.363879-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163728.363879-1-pbonzini@redhat.com>
References: <20231018163728.363879-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

This was introduced in KVM in Linux 2.6.32, we can require it unconditionally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index df131fcc8b1..a3d52cb538f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -99,6 +99,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
     KVM_CAP_INFO(MCE),
     KVM_CAP_INFO(ADJUST_CLOCK),
+    KVM_CAP_INFO(SET_IDENTITY_MAP_ADDR),
     KVM_CAP_LAST_INFO
 };
 
@@ -2600,20 +2601,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      * In order to use vm86 mode, an EPT identity map and a TSS  are needed.
      * Since these must be part of guest physical memory, we need to allocate
      * them, both by setting their start addresses in the kernel and by
-     * creating a corresponding e820 entry. We need 4 pages before the BIOS.
-     *
-     * Older KVM versions may not support setting the identity map base. In
-     * that case we need to stick with the default, i.e. a 256K maximum BIOS
-     * size.
+     * creating a corresponding e820 entry. We need 4 pages before the BIOS,
+     * so this value allows up to 16M BIOSes.
      */
-    if (kvm_check_extension(s, KVM_CAP_SET_IDENTITY_MAP_ADDR)) {
-        /* Allows up to 16M BIOSes. */
-        identity_base = 0xfeffc000;
-
-        ret = kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, &identity_base);
-        if (ret < 0) {
-            return ret;
-        }
+    identity_base = 0xfeffc000;
+    ret = kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, &identity_base);
+    if (ret < 0) {
+        return ret;
     }
 
     /* Set TSS base one page after EPT identity map. */
-- 
2.41.0


