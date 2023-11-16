Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CFA7EE18B
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:30:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cRi-0005Op-10; Thu, 16 Nov 2023 08:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cRW-0005NU-2e
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:30:04 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cRS-0001tg-MG
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:30:00 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d849cc152so622958f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 05:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700141396; x=1700746196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qtG83+EYdNrIJB24tx+lUXOzWx08mfVnmUnfkSuIT+Q=;
 b=rf7yVfL2dH9t+cUNGXGq3Fp7W5OaGqn0CLqe9KZbM2crr/JtywizqjJCnNyATkY9Pc
 wOHXANeF0PmnFdBcD7L2tgQrzrBQGiYzmUnz23wcZv3vIiWRMPVKz/9ilLt/QKKp1lsn
 wodlY5R9W6MLw1bpL2nfOPstTYb7WtunTw0h+59tbbamNVLqQYQSjUlf3VVP3bb2/Qx3
 UWrtFoAVDoHpkuzAqLLK6mdipK+UgqVRO/fUo2OVyKdyViqkIiTfACu1LEy+75Vd5uPW
 x9edA5J7C2T+yzzpmDktDmkNNikC+nMh3DguzZdjNniQXgDcmN2rf8XwKzU30qLssG97
 Zyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700141396; x=1700746196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qtG83+EYdNrIJB24tx+lUXOzWx08mfVnmUnfkSuIT+Q=;
 b=R/K4doXIMg9QxMdyNxJItYNboOUILb+qi+NZ+zsNNAkEUd87LCyHTfdJFany5ltwpB
 lZ/mYZT7Mi93qgKAnWgZ8jQGNJqiSp+fH1QhctVSL3D8mmOfHXV/4f91H+NQ59zfqy9I
 vWYRhdlN4fu/zhuoF1kCTxBWL0jwBWW1GBfIJBuHTNOqXHwCXTgKWJtHS0jv0YS/zcL9
 bVk/91b0ykhKr+7RLd7xeDp4hkhmRUXpAej+arHMSGCXA5SxB0DTT+qwPXNn6XYXHWGl
 5qfsNTxyj/0/keqcqWp9szeWQ9r1kOLbpci3al2LJgu9Bhqs/YK7azkWyYse+eTXAmuI
 f1iA==
X-Gm-Message-State: AOJu0YyUOB0k3IMnr0IS/oTsbCR6YPsGtm00UESNTHIYJbh33dgEGrLv
 rRvjBzPjq4WOWe3eA4cSeHVLYbJ7gT0NrDMYAzY=
X-Google-Smtp-Source: AGHT+IGeqi5nepwthqRXi9nCCfwpRjKd00Qh72aNypXJSVLXC5rDIVZo5oTekryPNPaWcYnUdUlspw==
X-Received: by 2002:a5d:6d89:0:b0:32f:7b14:89d9 with SMTP id
 l9-20020a5d6d89000000b0032f7b1489d9mr13936226wrs.9.1700141396572; 
 Thu, 16 Nov 2023 05:29:56 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 r17-20020adfa151000000b0032d9382e6e0sm13773232wrr.45.2023.11.16.05.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 05:29:56 -0800 (PST)
Message-ID: <51ffd060-b2f8-405c-83e1-a0663c0183f5@linaro.org>
Date: Thu, 16 Nov 2023 14:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/31] target/xtensa: Use generic cpu_list()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-22-gshan@redhat.com>
 <4d12bbdb-8f6b-4fa0-8939-da3d7ae49467@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4d12bbdb-8f6b-4fa0-8939-da3d7ae49467@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 15/11/23 02:12, Richard Henderson wrote:
> On 11/14/23 15:56, Gavin Shan wrote:
>> Before it's applied:
>>
>> [gshan@gshan q]$ ./build/qemu-system-xtensa -cpu ?
>> Available CPUs:
>>    test_mmuhifi_c3
>>    sample_controller
>>    lx106
>>    dsp3400
>>    de233_fpu
>>    de212
>>    dc233c
>>    dc232b
>>
>> After it's applied:
>>
>> [gshan@gshan q]$ ./build/qemu-system-xtensa -cpu ?
>> Available CPUs:
>>    dc232b
>>    dc233c
>>    de212
>>    de233_fpu
>>    dsp3400
>>    lx106
>>    sample_controller
>>    test_mmuhifi_c3
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   target/xtensa/cpu.h          | 10 +---------
>>   target/xtensa/helper.c       | 19 +++----------------
>>   target/xtensa/overlay_tool.h |  7 ++-----
>>   3 files changed, 6 insertions(+), 30 deletions(-)
>>
>> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
>> index dd81729306..ffeb1ca43f 100644
>> --- a/target/xtensa/cpu.h
>> +++ b/target/xtensa/cpu.h
>> @@ -491,11 +491,6 @@ typedef struct XtensaConfig {
>>       bool use_first_nan;
>>   } XtensaConfig;
>> -typedef struct XtensaConfigList {
>> -    const XtensaConfig *config;
>> -    struct XtensaConfigList *next;
>> -} XtensaConfigList;
>> -
>>   #if HOST_BIG_ENDIAN
>>   enum {
>>       FP_F32_HIGH,
>> @@ -600,8 +595,6 @@ G_NORETURN void 
>> xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>>                                                  MMUAccessType 
>> access_type, int mmu_idx,
>>                                                  uintptr_t retaddr);
>> -#define cpu_list xtensa_cpu_list
>> -
>>   #define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU
>>   #if TARGET_BIG_ENDIAN
>> @@ -620,13 +613,12 @@ void xtensa_collect_sr_names(const XtensaConfig 
>> *config);
>>   void xtensa_translate_init(void);
>>   void **xtensa_get_regfile_by_name(const char *name, int entries, int 
>> bits);
>>   void xtensa_breakpoint_handler(CPUState *cs);
>> -void xtensa_register_core(XtensaConfigList *node);
>> +void xtensa_register_core(XtensaConfig *config);
>>   void xtensa_sim_open_console(Chardev *chr);
>>   void check_interrupts(CPUXtensaState *s);
>>   void xtensa_irq_init(CPUXtensaState *env);
>>   qemu_irq *xtensa_get_extints(CPUXtensaState *env);
>>   qemu_irq xtensa_get_runstall(CPUXtensaState *env);
>> -void xtensa_cpu_list(void);
>>   void xtensa_sync_window_from_phys(CPUXtensaState *env);
>>   void xtensa_sync_phys_from_window(CPUXtensaState *env);
>>   void xtensa_rotate_window(CPUXtensaState *env, uint32_t delta);
>> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
>> index dbeb97a953..3654739b09 100644
>> --- a/target/xtensa/helper.c
>> +++ b/target/xtensa/helper.c
>> @@ -35,8 +35,6 @@
>>   #include "qemu/qemu-print.h"
>>   #include "qemu/host-utils.h"
>> -static struct XtensaConfigList *xtensa_cores;
>> -
>>   static void add_translator_to_hash(GHashTable *translator,
>>                                      const char *name,
>>                                      const XtensaOpcodeOps *opcode)
>> @@ -187,17 +185,15 @@ static void xtensa_core_class_init(ObjectClass 
>> *oc, void *data)
>>       cc->gdb_num_core_regs = config->gdb_regmap.num_regs;
>>   }
>> -void xtensa_register_core(XtensaConfigList *node)
>> +void xtensa_register_core(XtensaConfig *config)
>>   {
>>       TypeInfo type = {
>>           .parent = TYPE_XTENSA_CPU,
>>           .class_init = xtensa_core_class_init,
>> -        .class_data = (void *)node->config,
>> +        .class_data = (void *)config,
>>       };
> 
> This patch does two things and should be split.

I'm doing the split. This patch becomes:

-- >8 --
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index dd81729306..d9c49a35fa 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -600,8 +600,6 @@ G_NORETURN void 
xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                                 MMUAccessType 
access_type, int mmu_idx,
                                                 uintptr_t retaddr);

-#define cpu_list xtensa_cpu_list
-
  #define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU

  #if TARGET_BIG_ENDIAN
@@ -626,7 +624,6 @@ void check_interrupts(CPUXtensaState *s);
  void xtensa_irq_init(CPUXtensaState *env);
  qemu_irq *xtensa_get_extints(CPUXtensaState *env);
  qemu_irq xtensa_get_runstall(CPUXtensaState *env);
-void xtensa_cpu_list(void);
  void xtensa_sync_window_from_phys(CPUXtensaState *env);
  void xtensa_sync_phys_from_window(CPUXtensaState *env);
  void xtensa_rotate_window(CPUXtensaState *env, uint32_t delta);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index dbeb97a953..f6632df646 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -234,15 +234,6 @@ void xtensa_breakpoint_handler(CPUState *cs)
      }
  }

-void xtensa_cpu_list(void)
-{
-    XtensaConfigList *core = xtensa_cores;
-    qemu_printf("Available CPUs:\n");
-    for (; core; core = core->next) {
-        qemu_printf("  %s\n", core->config->name);
-    }
-}
-
  #ifndef CONFIG_USER_ONLY
  void xtensa_cpu_do_unaligned_access(CPUState *cs,
                                      vaddr addr, MMUAccessType access_type,
---

What is left is:

-- >8 --
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index d9c49a35fa..ffeb1ca43f 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -491,11 +491,6 @@ typedef struct XtensaConfig {
      bool use_first_nan;
  } XtensaConfig;

-typedef struct XtensaConfigList {
-    const XtensaConfig *config;
-    struct XtensaConfigList *next;
-} XtensaConfigList;
-
  #if HOST_BIG_ENDIAN
  enum {
      FP_F32_HIGH,
@@ -618,7 +613,7 @@ void xtensa_collect_sr_names(const XtensaConfig 
*config);
  void xtensa_translate_init(void);
  void **xtensa_get_regfile_by_name(const char *name, int entries, int 
bits);
  void xtensa_breakpoint_handler(CPUState *cs);
-void xtensa_register_core(XtensaConfigList *node);
+void xtensa_register_core(XtensaConfig *config);
  void xtensa_sim_open_console(Chardev *chr);
  void check_interrupts(CPUXtensaState *s);
  void xtensa_irq_init(CPUXtensaState *env);
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 701c00eed2..7373ba7592 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -450,13 +450,10 @@
  #endif

  #if TARGET_BIG_ENDIAN == (XCHAL_HAVE_BE != 0)
-#define REGISTER_CORE(core) \
+#define REGISTER_CORE(config) \
      static void __attribute__((constructor)) register_core(void) \
      { \
-        static XtensaConfigList node = { \
-            .config = &core, \
-        }; \
-        xtensa_register_core(&node); \
+        xtensa_register_core(&config); \
      }
  #else
  #define REGISTER_CORE(core)
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index f6632df646..3654739b09 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -35,8 +35,6 @@
  #include "qemu/qemu-print.h"
  #include "qemu/host-utils.h"

-static struct XtensaConfigList *xtensa_cores;
-
  static void add_translator_to_hash(GHashTable *translator,
                                     const char *name,
                                     const XtensaOpcodeOps *opcode)
@@ -187,17 +185,15 @@ static void xtensa_core_class_init(ObjectClass 
*oc, void *data)
      cc->gdb_num_core_regs = config->gdb_regmap.num_regs;
  }

-void xtensa_register_core(XtensaConfigList *node)
+void xtensa_register_core(XtensaConfig *config)
  {
      TypeInfo type = {
          .parent = TYPE_XTENSA_CPU,
          .class_init = xtensa_core_class_init,
-        .class_data = (void *)node->config,
+        .class_data = (void *)config,
      };

-    node->next = xtensa_cores;
-    xtensa_cores = node;
-    type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), 
node->config->name);
+    type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), config->name);
      type_register(&type);
      g_free((gpointer)type.name);
  }
---

Which I will skip for now unless Max Ack-by it, since as per commit
ac8b7db493 ("target-xtensa: extract core configuration from overlay")
this might be used externally by the overlay tool generator.

Regards,

Phil.


