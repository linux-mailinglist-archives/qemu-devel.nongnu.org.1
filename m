Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CB375DAEE
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 09:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN7QZ-0001oF-MC; Sat, 22 Jul 2023 03:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qN7QX-0001n4-8Y
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 03:53:21 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qN7QV-0005QE-J5
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 03:53:21 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b8b4749013so20471305ad.2
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690012398; x=1690617198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiO61RFWQc576A2x8jBmto7Eq50nA+0j/FFgWXdA55I=;
 b=V7HDO7h9cMJQuoPaix0ohqhZbGjhwfcE21W7k9j8a9RL0z4OSklK3Ozp1/pF/2D5Ze
 wHNnIBVHARgb9QZGB2Q6IlSnZfLGP8GZiHrn+nGZNrR2P3oibMTlrfeKZ4WjqciR4e8P
 /Ggu3omGCX/RjZeJdiFvz7mlZjl8FY+URnd1rEh/kdE+S4I0A/TGjQBPjl2kQIo9S+zi
 eVkh4FJsbOH8ityr79518E4fKiy2YFOIbajqIh6vCNw2GFoGi0KPnlp800B4oLYL00Zh
 D21ndlGqCOPoqc1A3lECbEpJSGRsNsDnGyCWmO2Bv7jokmk7L2hcOurnqcgQZRb62SpI
 JNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690012398; x=1690617198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aiO61RFWQc576A2x8jBmto7Eq50nA+0j/FFgWXdA55I=;
 b=VGN1jT8w//8vqD5+BsHGKgRUQywsHi4IMxAJw1BKJ/S9TXpLCc0E/OSY155DZLObyv
 mxEVzkLOo4iZ1lMDPnR+cGJYsaI8uuxUB4uqqf3A/Ug78W+z6GDEm6CNslgCi8T43lEL
 0ATaMC6ZQJYAQIfho+RPU4WUycQO+3M1scMMDVeWc0CHx4PgjClyD5a/tgXOrfAD0oa8
 txU/diM3s0WUoCXqXtr9TPNVx1OD58Hm0h3Nzu5+LCLndSDVBkWNtpJhLbKSkkpY+0a8
 AFuX1Bf+DaQWy7HkrZDe6XXj6y2gv+M9dxbRqFY9K0+v7y65n800bNtMA4hkuaHcT0oA
 wDiQ==
X-Gm-Message-State: ABy/qLaC4/vPCHAK74HhwodLromlIUrflJs8iTtQoRceLwZLEvEOOIwp
 xyHVcokubhBu9347SHR/omB7lxlTxRzwclgsz34=
X-Google-Smtp-Source: APBJJlH+WLlrxfTvRvZc+enH2E5T/jZvDny6NU0Ju91BEn/OlAogHCBmr+50XgDXnw9e0uJ7H2L01A==
X-Received: by 2002:a17:902:d512:b0:1b6:c229:c350 with SMTP id
 b18-20020a170902d51200b001b6c229c350mr5599213plg.18.1690012398241; 
 Sat, 22 Jul 2023 00:53:18 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a17090332d100b001b86dd825e7sm4753119plr.108.2023.07.22.00.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jul 2023 00:53:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 2/2] accel/kvm: Specify default IPA size for arm64
Date: Sat, 22 Jul 2023 16:53:06 +0900
Message-ID: <20230722075308.26560-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230722075308.26560-1-akihiko.odaki@daynix.com>
References: <20230722075308.26560-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

Before this change, the default KVM type, which is used for non-virt
machine models, was 0.

The kernel documentation says:
> On arm64, the physical address size for a VM (IPA Size limit) is
> limited to 40bits by default. The limit can be configured if the host
> supports the extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
> KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
> identifier, where IPA_Bits is the maximum width of any physical
> address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
> machine type identifier.
>
> e.g, to configure a guest to use 48bit physical address size::
>
>     vm_fd = ioctl(dev_fd, KVM_CREATE_VM, KVM_VM_TYPE_ARM_IPA_SIZE(48));
>
> The requested size (IPA_Bits) must be:
>
>  ==   =========================================================
>   0   Implies default size, 40bits (for backward compatibility)
>   N   Implies N bits, where N is a positive integer such that,
>       32 <= N <= Host_IPA_Limit
>  ==   =========================================================

> Host_IPA_Limit is the maximum possible value for IPA_Bits on the host
> and is dependent on the CPU capability and the kernel configuration.
> The limit can be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the
> KVM_CHECK_EXTENSION ioctl() at run-time.
>
> Creation of the VM will fail if the requested IPA size (whether it is
> implicit or explicit) is unsupported on the host.
https://docs.kernel.org/virt/kvm/api.html#kvm-create-vm

So if Host_IPA_Limit < 40, specifying 0 as the type will fail. This
actually confused libvirt, which uses "none" machine model to probe the
KVM availability, on M2 MacBook Air.

Fix this by using Host_IPA_Limit as the default type when
KVM_CAP_ARM_VM_IPA_SIZE is available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/kvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 40f577bfd5..23aeb09949 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -249,7 +249,9 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
 
 int kvm_arch_get_default_type(MachineState *ms)
 {
-    return 0;
+    bool fixed_ipa;
+    int size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
+    return fixed_ipa ? 0 : size;
 }
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
-- 
2.41.0


