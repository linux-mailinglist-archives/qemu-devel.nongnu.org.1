Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FDD75BFC1
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 09:31:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMkbT-0005dK-HQ; Fri, 21 Jul 2023 03:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMkb0-0005Xo-Si
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:30:40 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMkay-0002AU-RJ
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:30:38 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b9540031acso23583391fa.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 00:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689924635; x=1690529435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sVrhGsRHqpb0SJmQRvO/9lQlxmoayB+lW1zezQyO9Ok=;
 b=QpJl7S/e8badX8jT95+A/KHzGPwYS3CIgkPxSBAdlbXGEl84S3Prc7ajvX3bS3ZMLe
 0bIcNJRnAcJ4lpsTOSf1+U3gXYSsCdzrZL41z41rZk0anVizEuY0AS0RsVF5bAZsWGqG
 QFCWCBD2K8OtORWxx7alTRFoZcKbzdW/Fnkczw7/J+J/x2+je33unLiqN4Wi4T9erBvS
 MFbe9434/epO2KOuq4tOS0qHmBuotT4snym+ndYn7RDNrBy0BwR3d3LLysT8Hzmq2Z6l
 KLkkJU6Umev44R31K1w9dkkh5qgMkpSAOY9FCyrCpdQFqpO52x/T1LhQK22u5Tdb9yhV
 Wmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689924635; x=1690529435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sVrhGsRHqpb0SJmQRvO/9lQlxmoayB+lW1zezQyO9Ok=;
 b=VYPuwvD3QEkkTrIWr95khLHc8NyI5Gu23pIqJWZ6l3bJT5wlUvgQbDkShtvoC6xLMw
 KSUS7lUln664NSj896EtGk4b9rWbDeMfVTs4gGWZMwtSRCakfCeXCFM+qYDjMBcwU+ED
 1U9rZM9LxrPKykb0wz8TVph2tOXntdp81WHB90H/o6phSpk3nIsuOsW00u1yd96/P9Mc
 GcMatM5fwKfCCyCIJw1Gwqm4gNx+SVKD0rntb75uUM5d9qcuYR+i2keToRpF6hzck6T9
 UJyiuk6ucioSyU3TU3/oSlMBYm0IhMvIC2u6/PolaJ3CwaH3s0Im0/aL1Ht1zVzG1EGO
 QQWA==
X-Gm-Message-State: ABy/qLby4K3QlNxGt9/CyYak9zszawbHU58Y/6s39/BQPHIZtMskR4lu
 jfUEexYIHKiLjosGcNE8MpGIsg==
X-Google-Smtp-Source: APBJJlEYSTv1ML1XNlOikJMyQbfxJOl8iaoeYeBrEcPuOlBAPeNMlQX6IjhnEjmBWX3/1V2Fuw2I/w==
X-Received: by 2002:a2e:b0f0:0:b0:2b9:5b06:b724 with SMTP id
 h16-20020a2eb0f0000000b002b95b06b724mr1011423ljl.42.1689924634806; 
 Fri, 21 Jul 2023 00:30:34 -0700 (PDT)
Received: from [192.168.96.175] (97.red-88-29-184.dynamicip.rima-tde.net.
 [88.29.184.97]) by smtp.gmail.com with ESMTPSA id
 y13-20020a05600c364d00b003fbb25da65bsm2795160wmq.30.2023.07.21.00.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 00:30:34 -0700 (PDT)
Message-ID: <05d4e5ff-dc5c-b2da-7ae8-ac135d4a73c9@linaro.org>
Date: Fri, 21 Jul 2023 09:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] accel/kvm: Specify default IPA size for arm64
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20230721062421.12017-1-akihiko.odaki@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230721062421.12017-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Akihiko,

On 21/7/23 08:24, Akihiko Odaki wrote:
> libvirt uses "none" machine type to test KVM availability. Before this
> change, QEMU used to pass 0 as machine type when calling KVM_CREATE_VM.
> 
> The kernel documentation says:
>> On arm64, the physical address size for a VM (IPA Size limit) is
>> limited to 40bits by default. The limit can be configured if the host
>> supports the extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
>> KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
>> identifier, where IPA_Bits is the maximum width of any physical
>> address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
>> machine type identifier.
>>
>> e.g, to configure a guest to use 48bit physical address size::
>>
>>      vm_fd = ioctl(dev_fd, KVM_CREATE_VM, KVM_VM_TYPE_ARM_IPA_SIZE(48));
>>
>> The requested size (IPA_Bits) must be:
>>
>>   ==   =========================================================
>>    0   Implies default size, 40bits (for backward compatibility)
>>    N   Implies N bits, where N is a positive integer such that,
>>        32 <= N <= Host_IPA_Limit
>>   ==   =========================================================
> 
>> Host_IPA_Limit is the maximum possible value for IPA_Bits on the host
>> and is dependent on the CPU capability and the kernel configuration.
>> The limit can be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the
>> KVM_CHECK_EXTENSION ioctl() at run-time.
>>
>> Creation of the VM will fail if the requested IPA size (whether it is
>> implicit or explicit) is unsupported on the host.
> https://docs.kernel.org/virt/kvm/api.html#kvm-create-vm
> 
> So if Host_IPA_Limit < 40, such KVM_CREATE_VM will fail, and libvirt
> incorrectly thinks KVM is not available. This actually happened on M2
> MacBook Air.
> 
> Fix this by specifying 32 for IPA_Bits as any arm64 system should
> support the value according to the documentation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> V1 -> V2: Introduced an arch hook
> 
>   include/sysemu/kvm.h   | 1 +
>   accel/kvm/kvm-all.c    | 2 +-
>   target/arm/kvm.c       | 2 ++
>   target/i386/kvm/kvm.c  | 2 ++
>   target/mips/kvm.c      | 2 ++
>   target/ppc/kvm.c       | 2 ++
>   target/riscv/kvm.c     | 2 ++
>   target/s390x/kvm/kvm.c | 2 ++
>   8 files changed, 14 insertions(+), 1 deletion(-)

My understanding of Peter's suggestion would be smth like:

-- >8 --
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 115f0cca79..c0af15eb6c 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -201,10 +201,15 @@ typedef struct KVMCapabilityInfo {

  struct KVMState;

+struct KVMClass {
+    AccelClass parent_class;
+
+    int default_vm_type;
+};
+
  #define TYPE_KVM_ACCEL ACCEL_CLASS_NAME("kvm")
  typedef struct KVMState KVMState;
-DECLARE_INSTANCE_CHECKER(KVMState, KVM_STATE,
-                         TYPE_KVM_ACCEL)
+OBJECT_DECLARE_TYPE(KVMState, KVMClass, KVM_ACCEL)

  extern KVMState *kvm_state;
  typedef struct Notifier Notifier;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 373d876c05..fdd424e1a5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2458,12 +2458,13 @@ static int kvm_init(MachineState *ms)
      KVMState *s;
      const KVMCapabilityInfo *missing_cap;
      int ret;
-    int type = 0;
+    int type;
      uint64_t dirty_log_manual_caps;

      qemu_mutex_init(&kml_slots_lock);

      s = KVM_STATE(ms->accelerator);
+    type = KVM_GET_CLASS(s)->default_vm_type;

      /*
       * On systems where the kernel can support different base page
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4c7654f49..5c13594fdf 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1064,4 +1064,8 @@ bool kvm_arch_cpu_check_are_resettable(void)

  void kvm_arch_accel_class_init(ObjectClass *oc)
  {
+    KVMClass *kc = KVM_CLASS(oc);
+
+    /* Host_IPA_Limit ... */
+    kc->default_vm_type = 32;
  }
---

