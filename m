Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC075A7D6
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 09:30:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMO6N-0003UF-3T; Thu, 20 Jul 2023 03:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMO6L-0003Ts-6a
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:29:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMO6H-0002zP-MN
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:29:28 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b8a44ee159so2809355ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689838164; x=1690442964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zu0o/wcEkbfTyvDOhAFRVRnQlN6I6R0hj4RBolX2hdg=;
 b=oVH5QTZbrvnHyydotdMaw7OEyZnGgENiFoLjcYkF94dYXXrP5cCqtMYTXhtgwnqgtU
 1laKHVI6VGEr6FAFlMN6eCvT87ouu1pt/yFRJ+HeiTET0IsHJeWKomR5VOcrFpYla+1a
 jkveSDT7ASJdJ9zykl1PY+3ByvNl2O5gcHPqXgUP//cd40PUzYI3GoDX2oDfAsDk2RD2
 z2vGArKL7EXDROz/73thV/lkO9tEGscXjjc1EhPW9FGRX4+AYPnUjSfcTonBmPgPNo0z
 wWaBza1jE6vXrOs1I2SOiTdnE4em5RZ4a0SxZWsk7P6iWAGK3W8lTWrARYT3G2OJfmWH
 FuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689838164; x=1690442964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zu0o/wcEkbfTyvDOhAFRVRnQlN6I6R0hj4RBolX2hdg=;
 b=klaiu356g0pm82+MgWS5g8Giu0J3wu7KXP8BcXCih2PODltfGldBe3v+fEmSvnuxsf
 kLgspaY2rLkbt7FeAvjBK55ypFAsv5wPfET9ft1kLWKIhjm9Ea0m+RC2oedCq0E3mClZ
 pqukTQy+TFjfHLsp+mh5KbLWaCY9uEMmy5HbEjddwT8OiAQ3UfMf6grwPHytbVfb8+hk
 Ka25x6QiwbWhY8gtjcrTIqWFfa5cRHPEHq4UcA6oQ3Nb1yf03LjAhhGM+ZkK3rNlf55m
 3K1UWpRKTXonPRswTaL5638WGH39aTbf6SO6fMOnroxfd0RoLam7JkAHJ9KROWTiCepP
 YK8A==
X-Gm-Message-State: ABy/qLYLfMF6NYiw/sTaOvWUNbOqa9C+n6KtxvYH5p0KBBNQ3RLvtKvP
 LV9hQ3kAu8kicSg4/dxv3E5c/kKCA9MWEU71mUk=
X-Google-Smtp-Source: APBJJlFhGOYHcvYIXC/iflDORll+mgeCYw2iOdPaeX9f8sxzj4VRPaKE5N19hcP12/8zHpBL9WY1cA==
X-Received: by 2002:a17:902:ab57:b0:1b8:59f0:c748 with SMTP id
 ij23-20020a170902ab5700b001b859f0c748mr1160084plb.2.1689838163988; 
 Thu, 20 Jul 2023 00:29:23 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jh5-20020a170903328500b001bb3beb2bc6sm548433plb.65.2023.07.20.00.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 00:29:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND] accel/kvm: Specify default IPA size for arm64
Date: Thu, 20 Jul 2023 16:29:01 +0900
Message-ID: <20230720072903.21390-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

libvirt uses "none" machine type to test KVM availability. Before this
change, QEMU used to pass 0 as machine type when calling KVM_CREATE_VM.

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

So if Host_IPA_Limit < 40, such KVM_CREATE_VM will fail, and libvirt
incorrectly thinks KVM is not available. This actually happened on M2
MacBook Air.

Fix this by specifying 32 for IPA_Bits as any arm64 system should
support the value according to the documentation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Resending due to inactivity.

 accel/kvm/kvm-all.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 373d876c05..3bd362e346 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2458,7 +2458,11 @@ static int kvm_init(MachineState *ms)
     KVMState *s;
     const KVMCapabilityInfo *missing_cap;
     int ret;
+#ifdef TARGET_AARCH64
+    int type = 32;
+#else
     int type = 0;
+#endif
     uint64_t dirty_log_manual_caps;
 
     qemu_mutex_init(&kml_slots_lock);
-- 
2.41.0


