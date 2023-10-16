Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47F7CA464
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsK4J-00063s-LN; Mon, 16 Oct 2023 05:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsK4H-0005zh-GG
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:39:21 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsK4F-0002E2-KH
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:39:21 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b1ebc80d0aso665530266b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697449158; x=1698053958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XjW7XPWu77DyEkmU0Wg0fiUGoPfYWklWaEf2257jS/0=;
 b=PwwlXduTpYdJXFOHbdWwK20dSiLmORD9tiVNuRPN11xGJmwoV1I93BbRxft40ge38H
 4PWbHn/bngEsv0oW6y4/p3EHPIq8QDQ/3r0YCS7gxTcDVI7+IvFr6OuYMxV6taNfpB9C
 wlt8V24nnBvaCpjbDn03nyde9D+Xu/ofmk9OZnwtYUFjERZiBLYPb5W+7VtRUrsuN+m6
 JJrCfiHIL+/eHrUBZnd3XydJh3WK6+adsSPCoTv7eLfOC0das6cnNV4V86f3mOH9QrZo
 mh2bNmNHKfisUZVGDOotOfi3+UUIU+5H0kFgiDerhVm8NFUJB83QSLMhDXSkfL74j928
 Qinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697449158; x=1698053958;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XjW7XPWu77DyEkmU0Wg0fiUGoPfYWklWaEf2257jS/0=;
 b=eUaG9Z+dD1ts20X2S0FXr8ZWscIKLXRqpD2FYGmGUqsVXP0dhuDG4TmoYq9b9HZYC7
 cw7Kc0SO0XH96yQLvxx/159cskcTasjE2MeS/Xp0Cey1NZHANcTEa4CocnBreAGuk4O6
 etzwvArelt1/9+8E2oJ5D2Bn4cicS7B1mXKrC7a4P10TFEnMlXDeddkaa3VOW3zIftZn
 qLnrZBB88364KEHKYfP/ru0q/CHwQQEog7tPVx+VqwIPhOTDl06CldPj0u6UBtWZRu5x
 tf4jGAfeyecNFS6ssIGUfeFAAP0h9YXXe5qtzHXA1/f0upwzZeLfR1lxtVi0Za4e9Qba
 NQ3A==
X-Gm-Message-State: AOJu0YzE3PykR2xRJsf+YHCo+K0PcLcWo2hwt2uOi3rcPOSMNRn/W3j5
 UdQ291FgqZ8ntOoWZrL+Aa3D2/8GnF7Y56O6wdg=
X-Google-Smtp-Source: AGHT+IHm3vTwK0uz2Gm7us7WGfAEODp9v6PbD/tYY6QBKeIWwo2QIVt6FV91VEazqCxKkIC84pkkfg==
X-Received: by 2002:a17:906:c10e:b0:9bf:d70b:986a with SMTP id
 do14-20020a170906c10e00b009bfd70b986amr3376458ejc.13.1697449157729; 
 Mon, 16 Oct 2023 02:39:17 -0700 (PDT)
Received: from [192.168.69.115]
 (9r679-h01-176-171-216-136.dsl.sta.abo.bbox.fr. [176.171.216.136])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a170906c41400b009b9720a85e5sm3704169ejz.38.2023.10.16.02.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:39:17 -0700 (PDT)
Message-ID: <c48c9829-3dfa-79cf-3042-454fda0d00dc@linaro.org>
Date: Mon, 16 Oct 2023 11:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 03/16] target/arm: Move internal declarations from
 'cpu-qom.h' to 'cpu.h'
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231013140116.255-1-philmd@linaro.org>
 <20231013140116.255-4-philmd@linaro.org>
 <64733bf8-58bb-4176-927f-f17c33fa3846@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <64733bf8-58bb-4176-927f-f17c33fa3846@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 13/10/23 16:27, Richard Henderson wrote:
> On 10/13/23 07:01, Philippe Mathieu-Daudé wrote:
>> These definitions and declarations are only used by
>> target/arm/, no need to expose them to generic hw/.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/cpu-qom.h | 28 ----------------------------
>>   target/arm/cpu.h     | 28 ++++++++++++++++++++++++++++
>>   2 files changed, 28 insertions(+), 28 deletions(-)


>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index fb1b08371c..06f92dacb9 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1116,11 +1116,39 @@ struct ArchCPU {
>>       uint64_t gt_cntfrq_hz;
>>   };
>> +/* Callback functions for the generic timer's timers. */
>> +void arm_gt_ptimer_cb(void *opaque);
>> +void arm_gt_vtimer_cb(void *opaque);
>> +void arm_gt_htimer_cb(void *opaque);
>> +void arm_gt_stimer_cb(void *opaque);
>> +void arm_gt_hvtimer_cb(void *opaque);
>> +
>>   unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
>>   void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
>>   void arm_cpu_post_init(Object *obj);
>> +void arm_cpu_register(const ARMCPUInfo *info);
>> +void aarch64_cpu_register(const ARMCPUInfo *info);
>> +
>> +void register_cp_regs_for_features(ARMCPU *cpu);
>> +void init_cpreg_list(ARMCPU *cpu);
> 
> These can go to internals.h.

OK, I'm squashing:

-- >8 --
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ad2f32efd5..2bd8aaff3d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1153,12 +1153,6 @@ void gt_rme_post_el_change(ARMCPU *cpu, void 
*opaque);

  void arm_cpu_post_init(Object *obj);

-void arm_cpu_register(const ARMCPUInfo *info);
-void aarch64_cpu_register(const ARMCPUInfo *info);
-
-void register_cp_regs_for_features(ARMCPU *cpu);
-void init_cpreg_list(ARMCPU *cpu);
-
  #define ARM_AFF0_SHIFT 0
  #define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
  #define ARM_AFF1_SHIFT 8
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1dd9182a54..cfd64145ea 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -182,6 +182,12 @@ static inline int r14_bank_number(int mode)
      return (mode == ARM_CPU_MODE_HYP) ? BANK_USRSYS : bank_number(mode);
  }

+void arm_cpu_register(const ARMCPUInfo *info);
+void aarch64_cpu_register(const ARMCPUInfo *info);
+
+void register_cp_regs_for_features(ARMCPU *cpu);
+void init_cpreg_list(ARMCPU *cpu);
+
  void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
  void arm_translate_init(void);

---

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


