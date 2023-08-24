Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEB8786BE5
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:30:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6es-000888-PC; Thu, 24 Aug 2023 05:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e3-00044u-LJ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:56 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6dx-0004xz-JW
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:49 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c5c06e8bbso2906223f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869321; x=1693474121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dRFY4MrPTXsRJTRRlqLG+Tta4bFNbY1bwdeVb1jh0sw=;
 b=e+b2tYo0MuLqI8seMT1bU3go9DRCRAjZ+DMjo04hhrsTxocGjRKWG60Kjp0GL6zGxT
 1wiXCEMltkTfb6T3LwY1jSUJy/JH6uzgsSIoQEHL7GymPyLOggstjX6bGGMPZd6JpqsK
 OZlsNDnHHIsVStNOYYefvp9DVg29qHS5GPjox6JxpwS/pAzqsgS+rVUeFKZcFMwf986a
 D2GD6jsDBXVeZQyVCkEYToIhFIZbbvz31ipiFbMfjbzxa8FjWyOygOK8ijFuEn0bsBVW
 GnSlC/jIPA/IG8z09Rfy+Kt6El5oUHI7GH8VtGsazqMVDp2dn5KfA75Uxx+BmuQS0H0+
 lwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869321; x=1693474121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRFY4MrPTXsRJTRRlqLG+Tta4bFNbY1bwdeVb1jh0sw=;
 b=c6qJu2XD8gYHwp/hRVm/gFda69T7fUN4Z+Wkukiocic4ir4zyBnREMUCLLOeq1bfT7
 e9PdTHmcu1pecz1yDx9oA80ejUbfTCGbrI+gWPHQzni62pKjhOsREAZY8TJAi9oR0eVC
 qvV8j0NsmnoN4XL/YcU8hm3V1LEho7iCJOSI/8DROUyaQRWLbVeb4P1sJDXiCNzeyzyG
 rjwppM7L42Cau2MlxKMnQqU7pXYXJDkh/3d250Ff3q67WtalCJi0k7FZqkYSdS0EAGhv
 t86VBglgK2JiYkSvdoynPw2VS5jVC0FbB0PSY1OvAERThYfP08Iv/fLIbqR2/0Dx/Aan
 e8yA==
X-Gm-Message-State: AOJu0Yxtnq+ZIhpXlfKxSqyp2Rxsk/v0ovSmDUX8lSOg2xClvXpVQCe6
 1lAJsfHB3gJmzOzKchVtsGKvCzIrsg15LfmqDSo=
X-Google-Smtp-Source: AGHT+IHqNHggWzpRL1AhcB7LgfCLI4BP/ipJGePNJsyL5PUSCmWElQO+GHK9NeDBic3NKwSpGxSyvg==
X-Received: by 2002:a05:6000:18d:b0:319:74d5:a2d7 with SMTP id
 p13-20020a056000018d00b0031974d5a2d7mr10543643wrx.32.1692869321382; 
 Thu, 24 Aug 2023 02:28:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/35] accel/kvm: Specify default IPA size for arm64
Date: Thu, 24 Aug 2023 10:28:09 +0100
Message-Id: <20230824092836.2239644-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

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

Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230727073134.134102-3-akihiko.odaki@daynix.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 40f577bfd55..23aeb099490 100644
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
2.34.1


