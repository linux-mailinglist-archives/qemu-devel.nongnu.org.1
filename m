Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 549E5764999
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 09:57:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOvTZ-0005E9-10; Thu, 27 Jul 2023 03:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTW-0005D1-R6
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:31:54 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTV-0003cq-6U
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:31:54 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686b643df5dso504541b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 00:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690443109; x=1691047909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiO61RFWQc576A2x8jBmto7Eq50nA+0j/FFgWXdA55I=;
 b=VNKaMnEOQNKlZR10dtEZyO1TSdS8k+fSD0DHogH1R6yudKKGkTFXMKAarSnSO2Kzhb
 xvD1EZKgScgBJoiuS8bn3iq9oS82m2GgS+xDRQL1LO1mZUI0h3QAs51vMSM0GF23EJ36
 kplgCIlhxqVOD1kJw6Ndxf2MuGlGp3gf7FYdVXtivp0O9KAty+FICxA19fmvqlbFAaNK
 VaYy5/5qDpFY1/9OGQo8WReDwdFPntnukR2eDMEbxZ3IC+hZuDnSxabg/c1oO/jw/A5N
 2zqYrcpUt7hQTCIvlGGKoh2gtLlNZHxV/k1JPuu0ENiemMNzGr+TMDNr5+hLTalPd13F
 f+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690443109; x=1691047909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aiO61RFWQc576A2x8jBmto7Eq50nA+0j/FFgWXdA55I=;
 b=Z808+AQZ6eJogfLTxtVl+nI/63glYmNry9qaUW6Idi/RsP7ZJbwhmY/PM6axGw/yki
 9DK1T28XNn8E/6B57V3C5zsNaQ5gL7XU+ojMJ6nWhMxfpXxXPQTjV23gDxXCOTHa0Zsf
 DPB25wnKdsuiVsE9zhulqSK4QJlMbQ/dCBkHImmujdn4NB1PQwlB2M7RpArthGFT3MO3
 7iOo7hEhewX2/jnlLmzQiZeeCbr6bQ6rPaIy8bXfgUPY9a6Jyd2bf9OwSHXQ3KbrH6QO
 xy/t+s/LeZrkRYC4xDZKEu9S0HTsOFIFSmUAbmUFw1RJfvKEFenJrhE3Su4LrSPmyWBI
 WnIQ==
X-Gm-Message-State: ABy/qLa2xdpULNcLvyQSn56CeF2/iVHy5cEXB0ETmROBhj9//gMiUySK
 ukw+d30/eNJMTTy4T8PXVMf5TofWblynPSa1l+o=
X-Google-Smtp-Source: APBJJlEuLZxP0ZyEIi7VHNrW7mhtveHSO5fc5w71A22qd8/dfAl9uK20/rnFzi8GOuvgoOIN1lD60w==
X-Received: by 2002:a05:6a00:2184:b0:65e:ec60:b019 with SMTP id
 h4-20020a056a00218400b0065eec60b019mr4039381pfi.25.1690443108991; 
 Thu, 27 Jul 2023 00:31:48 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 d9-20020aa78689000000b0064fa2fdfa9esm802002pfo.81.2023.07.27.00.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 00:31:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 2/6] accel/kvm: Specify default IPA size for arm64
Date: Thu, 27 Jul 2023 16:31:27 +0900
Message-ID: <20230727073134.134102-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727073134.134102-1-akihiko.odaki@daynix.com>
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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


