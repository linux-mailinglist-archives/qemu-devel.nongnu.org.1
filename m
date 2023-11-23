Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0E47F6383
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 17:04:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6CAk-0007lS-TT; Thu, 23 Nov 2023 11:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6CAd-0007kp-On
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 11:03:15 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6CAb-0004WA-MD
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 11:03:15 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso6790215e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 08:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700755392; x=1701360192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nlWRT+PrdlAnCO9FQl/pWIQPvdcP9ZXH3YCgK+oWzOc=;
 b=aMo3IGaai3w4Z+vwwUGEdaUarCpZS9Ho4DPWKD/1f+1dEZNnIcd8+TTZO+z30VLEtI
 EdsWsMfkkrxbrobGJQ3bIrv0/aSw60EJFYzodAZ7vHb+8XjZJHYdTnrXuyjUMJbmg9gK
 ONwRz4siW1jLP16xtu3mGivmm8iuuH+8u1ui3AEgeTDJO32w2GtRYNZFWycny5Y2Hcuk
 OIhFQ5OJQBn2s5TVppnQxlQ9B3fcWsTDmxNWJWSDHb109+X0dtYzaVq8p0HSzby0AEkn
 J3oR/SXv6WUOrcTzvv/2y3dy2dMHZtVihl1NrfGIcDxjvsat6zsdaOOuq+ZFEqJGxRFj
 u94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700755392; x=1701360192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nlWRT+PrdlAnCO9FQl/pWIQPvdcP9ZXH3YCgK+oWzOc=;
 b=rqPODOv9XbxJs4f/cJaa9Gq3uUjn9sqFyuuzsScr8wI98v6fb3Hqb4vCj0Rrjvnw1B
 KWNuJeFTSJuBM379LolDjYW7g3gq2DAO6xVlnnAsPOgwNYdAASBIlH+fzyunxgEZlnei
 rgVkUZyyGt1YkA/F9/VwEmoAhb+mKOKVQBBUPIayjbUrtqhwetdA3Tc0pPfE1FfRnyuG
 p5CyyXutChQuYM/+5dF8Zkzexa1o0WiA4YfSI9yd80mnwWr10HhcIsZZeyp7LZXcfJeL
 j/h9XoSYZMyk7YTi8l4cXBPoBRso/OZubi1tsJwRmxfM/3qZqKdpvd/6xMqhAyHbs+Cb
 7ygw==
X-Gm-Message-State: AOJu0YwRBe/KAatYciAYBcDWaFJ4nbtgiqAWVgwZKMuipuOn7jDTiqwf
 RnCSS7xaCRy2Kwnt5Yo3xndOKg==
X-Google-Smtp-Source: AGHT+IFrcAhQ06va4+kUpXiNVcPAw4CyiJLcTkfkLlezdYY5IBg3POYV4oKXUus9mAMHeN8UcTwn3g==
X-Received: by 2002:a05:600c:314c:b0:40b:369e:6951 with SMTP id
 h12-20020a05600c314c00b0040b369e6951mr21612wmo.28.1700755391752; 
 Thu, 23 Nov 2023 08:03:11 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 v9-20020adfe4c9000000b00332c6f1beccsm1958128wrm.66.2023.11.23.08.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 08:03:11 -0800 (PST)
Message-ID: <59101052-6446-443c-8934-581b90a9bd2b@linaro.org>
Date: Thu, 23 Nov 2023 17:03:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0 01/11] qom: Introduce the
 TypeInfo::can_register() handler
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
 <20231122183048.17150-2-philmd@linaro.org>
 <dc8664c2-c1d4-4e11-8bcd-9465a2d97174@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dc8664c2-c1d4-4e11-8bcd-9465a2d97174@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/11/23 16:09, Thomas Huth wrote:
> On 22/11/2023 19.30, Philippe Mathieu-Daudé wrote:
>> Add a helper to decide at runtime whether a type can
>> be registered to the QOM framework or not.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/qom/object.h | 4 ++++
>>   qom/object.c         | 3 +++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index afccd24ca7..0d42fe17de 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -372,6 +372,8 @@ struct Object
>>    * struct TypeInfo:
>>    * @name: The name of the type.
>>    * @parent: The name of the parent type.
>> + * @can_register: This optional function is called before a type is 
>> registered.
>> + *   If it exists and returns false, the type is not registered.
> 
> The second sentence is quite hard to parse, since it is not quite clear 
> what "it" refers to (type or function) and what "registered" means in 
> this context (you don't mention type_register() here).
> 
> Maybe rather something like:
> 
> If set, type_register() uses this function to decide whether the type 
> can be registered or not.
> 
> ?
> 
>>    * @instance_size: The size of the object (derivative of #Object).  If
>>    *   @instance_size is 0, then the size of the object will be the 
>> size of the
>>    *   parent object.
>> @@ -414,6 +416,8 @@ struct TypeInfo
>>       const char *name;
>>       const char *parent;
>> +    bool (*can_register)(void);
>> +
>>       size_t instance_size;
>>       size_t instance_align;
>>       void (*instance_init)(Object *obj);
>> diff --git a/qom/object.c b/qom/object.c
>> index 95c0dc8285..f09b6b5a92 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -150,6 +150,9 @@ static TypeImpl *type_register_internal(const 
>> TypeInfo *info)
>>   TypeImpl *type_register(const TypeInfo *info)
>>   {
>>       assert(info->parent);
>> +    if (info->can_register && !info->can_register()) {
>> +        return NULL;
>> +    }
> 
> I have to say that I don't like it too much, since you're trying to fix 
> a problem here in common code that clearly belongs to the code in 
> hw/arm/ instead.
> 
> What about dropping it, and changing your last patch to replace the 
> DEFINE_TYPES(raspi_machine_types) in hw/arm/raspi.c with your own 
> implementation of type_register_static_array() that checks the condition 
> there?

This isn't ARM specific, it happens I started to unify ARM/aarch64
binaries.

Types can be registered depending on build-time (config/host specific)
definitions and runtime ones. How can we check for runtime if not via
this simple helper?

Still ARM, but as example what I have then is (module meson):

-- >8 --
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e8f033f59..e7f566f05d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1102,6 +1102,7 @@ typedef struct ARMCPUInfo {
      const char *name;
      void (*initfn)(Object *obj);
      void (*class_init)(ObjectClass *oc, void *data);
+    bool (*can_register)(void);
  } ARMCPUInfo;

  /**
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 558a85e6d7..109fb160b5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2512,6 +2512,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
          .instance_init = arm_cpu_instance_init,
          .class_init = info->class_init ?: cpu_register_class_init,
          .class_data = (void *)info,
+        .can_register = info->can_register,
      };

      type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1e9c6c85ae..c3b7e5666c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -744,7 +744,8 @@ static void aarch64_max_initfn(Object *obj)
  static const ARMCPUInfo aarch64_cpus[] = {
      { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
      { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
-    { .name = "max",                .initfn = aarch64_max_initfn },
+    { .name = "max",                .initfn = aarch64_max_initfn,
+                                    .can_register = 
target_aarch64_available },
  #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
      { .name = "host",               .initfn = aarch64_host_initfn },
  #endif
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index d9e0e2a4dd..dcad399a60 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -1049,7 +1049,6 @@ static void arm_v7m_class_init(ObjectClass *oc, 
void *data)
      cc->gdb_core_xml_file = "arm-m-profile.xml";
  }

-#ifndef TARGET_AARCH64
  /*
   * -cpu max: a CPU with as many features enabled as our emulation 
supports.
   * The version of '-cpu max' for qemu-system-aarch64 is defined in 
cpu64.c;
@@ -1112,7 +1111,11 @@ static void arm_max_initfn(Object *obj)
      cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
  #endif
  }
-#endif /* !TARGET_AARCH64 */
+
+static bool aa32_only(void)
+{
+    return !target_aarch64_available();
+}

  static const ARMCPUInfo arm_tcg_cpus[] = {
      { .name = "arm926",      .initfn = arm926_initfn },
@@ -1162,9 +1165,8 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
      { .name = "pxa270-b1",   .initfn = pxa270b1_initfn },
      { .name = "pxa270-c0",   .initfn = pxa270c0_initfn },
      { .name = "pxa270-c5",   .initfn = pxa270c5_initfn },
-#ifndef TARGET_AARCH64
-    { .name = "max",         .initfn = arm_max_initfn },
-#endif
+    { .name = "max",         .initfn = arm_max_initfn,
+                             .can_register = aa32_only },
  #ifdef CONFIG_USER_ONLY
      { .name = "any",         .initfn = arm_max_initfn },
  #endif
---

