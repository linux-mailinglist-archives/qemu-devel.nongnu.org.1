Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB7080A4F9
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 15:02:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBbPe-0000za-Er; Fri, 08 Dec 2023 09:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBbPc-0000zA-4a
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 09:01:04 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBbPT-0003I8-If
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 09:01:03 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3332efd75c9so1958371f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 06:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702044053; x=1702648853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6sbieA5Qc2+0DWsbpOrqV4Cag6SkOK2ipyny+MT0vvc=;
 b=iFCpK3Y3lz1w4IEZzTtuTLxYMoaLhrJuYnszeBQE0JlSE3Su2O3d05586TEYZXQmQY
 /1wWL+q7RLLp2k3vA+R+yKTw4ELSoUl8D7Yx6ih8zDND47n2NwfMNdRXXDqAEeaufx0z
 gTk/62ixzEQP966DMv2rXioT1shnNeqZ5AFB641YDuTvRs1R5tgoS5EwDL+LeLENPj4W
 4gSLujiOOvljmheYSnapsBF/s2maFlU7QGJXw++6jyDuFrH7YdwAdA76tgys/EwwUXu8
 /K2dZp6UqCK3zar0j9p22Gct9OA6KpAjF1L5fCc704+CErRSyR/i4xn96BfAN0/mPrBI
 WGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702044053; x=1702648853;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6sbieA5Qc2+0DWsbpOrqV4Cag6SkOK2ipyny+MT0vvc=;
 b=pVe0fBGuU2FnWH1f9vVsqdXeu+xcaeqQV89Kf5eLMEjmHEuj2ELWMHQllpqfCqY5FT
 VtRPLZIIkKnygjH1dBObCSHPyvRY1M6OyJrkaMVeUVfsSeKi29x9ykzcu+1R3fdVfYVl
 EyM1h8vaSyJ8zfgUGsHkcMx9DmB0NvAfemhqGd4asFZudLq0h+OEuHUQ5AL1j8T80gIp
 XN6U1GBnWx+h8zEvCTo79PtIWGxU2YJPKsg3FKCX0Xff1lP0/UkxJH1NqB5sLaS8CCK0
 teRYx3VswduFDH+rhxouOWHrbQOcE/lgJeRcEmwufMsBwuD4lSj+1BmEp3bGox/sRn3e
 02uQ==
X-Gm-Message-State: AOJu0YwiXMgUvkNmTK2xDRhe992OyIsicD8plg2J5kPkmaCO0XyBvnYc
 gw0PVqV1+cqfcmsyEsKMASPgTA==
X-Google-Smtp-Source: AGHT+IFeRdN8+YwGS3C/fXLQ/p7CNU7I9tWdbbQYTaNS4jTERa6VFgGPDZDonjezPxZALhU2KiWT1g==
X-Received: by 2002:adf:ef0f:0:b0:333:f5e:7d58 with SMTP id
 e15-20020adfef0f000000b003330f5e7d58mr17885wro.62.1702044053393; 
 Fri, 08 Dec 2023 06:00:53 -0800 (PST)
Received: from [192.168.69.100] ([176.176.146.181])
 by smtp.gmail.com with ESMTPSA id
 i16-20020adffc10000000b003333fd29854sm2115148wrr.45.2023.12.08.06.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 06:00:52 -0800 (PST)
Message-ID: <debe5041-3a8d-4fc0-a487-059f990aac98@linaro.org>
Date: Fri, 8 Dec 2023 15:00:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] target/arm: Ensure icount is enabled when
 emulating INST_RETIRED
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Aaron Lindsay <aaron@os.amperecomputing.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20231207154550.65087-1-philmd@linaro.org>
 <20231207154550.65087-3-philmd@linaro.org>
 <9508bf5e-a554-468f-ba94-4d6f1a5be7bf@linaro.org>
 <323be810-5f4e-4218-812a-7c0ebc858599@linaro.org>
 <CAFEAcA-HVf8vWLzmdStEo2NrSKQdZV612rBjiaj-gLW4vXyvpA@mail.gmail.com>
 <793e3c8f-497f-468e-b6b5-accc79e2bef0@linaro.org>
In-Reply-To: <793e3c8f-497f-468e-b6b5-accc79e2bef0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/12/23 12:23, Philippe Mathieu-Daudé wrote:
> Hi Peter,
> 
> On 8/12/23 11:59, Peter Maydell wrote:
>> On Fri, 8 Dec 2023 at 10:36, Philippe Mathieu-Daudé 
>> <philmd@linaro.org> wrote:
>>>
>>> On 7/12/23 23:12, Richard Henderson wrote:
>>>> On 12/7/23 07:45, Philippe Mathieu-Daudé wrote:
>>>>> pmu_init() register its event checking the pm_event::supported()
>>>>> handler. For INST_RETIRED, the event is only registered and the
>>>>> bit enabled in the PMU Common Event Identification register when
>>>>> icount is enabled as ICOUNT_PRECISE.
>>>>>
>>>>> Assert the pm_event::get_count() and pm_event::ns_per_count()
>>>>> handler will only be called under this icount mode.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>    target/arm/helper.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>>>> index adb0960bba..333fd5f4bf 100644
>>>>> --- a/target/arm/helper.c
>>>>> +++ b/target/arm/helper.c
>>>>> @@ -940,11 +940,13 @@ static bool instructions_supported(CPUARMState
>>>>> *env)
>>>>>    static uint64_t instructions_get_count(CPUARMState *env)
>>>>>    {
>>>>> +    assert(icount_enabled() == ICOUNT_PRECISE);
>>>>>        return (uint64_t)icount_get_raw();
>>>>>    }
>>>>>    static int64_t instructions_ns_per(uint64_t icount)
>>>>>    {
>>>>> +    assert(icount_enabled() == ICOUNT_PRECISE);
>>>>>        return icount_to_ns((int64_t)icount);
>>>>>    }
>>>>>    #endif
>>>>
>>>> I don't think an assert is required -- that's exactly what the
>>>> .supported field is for. If you think this needs additional
>>>> clarification, a comment is sufficient.
>>>
>>> Without this I'm getting this link failure with TCG disabled:
>>>
>>> ld: Undefined symbols:
>>>     _icount_to_ns, referenced from:
>>>         _instructions_ns_per in target_arm_helper.c.o
>>> clang: error: linker command failed with exit code 1 (use -v to see
>>> invocation)
>>
>> I think we should fix this earlier by not trying to enable
>> these TCG-only PMU event types in a non-TCG config.
> 
> I agree... but (as discussed yesterday on IRC), this is a bigger rework.

Giving it a try, I figured HVF emulates PMC (cycle counter) within
some vPMU, containing "a single event source: the cycle counter"
(per Alex).
Some helpers are duplicated, such pmu_update_irq().

pmu_counter_enabled() diff (-KVM +HVF):

  /*
   * Returns true if the counter (pass 31 for PMCCNTR) should count 
events using
   * the current EL, security state, and register configuration.
   */
  static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
  {
      uint64_t filter;
-    bool e, p, u, nsk, nsu, nsh, m;
-    bool enabled, prohibited = false, filtered;
-    bool secure = arm_is_secure(env);
+    bool enabled, filtered = true;
      int el = arm_current_el(env);
-    uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
-    uint8_t hpmn = mdcr_el2 & MDCR_HPMN;

-    if (!arm_feature(env, ARM_FEATURE_PMU)) {
-        return false;
-    }
-
-    if (!arm_feature(env, ARM_FEATURE_EL2) ||
-            (counter < hpmn || counter == 31)) {
-        e = env->cp15.c9_pmcr & PMCRE;
-    } else {
-        e = mdcr_el2 & MDCR_HPME;
-    }
-    enabled = e && (env->cp15.c9_pmcnten & (1 << counter));
-
-    /* Is event counting prohibited? */
-    if (el == 2 && (counter < hpmn || counter == 31)) {
-        prohibited = mdcr_el2 & MDCR_HPMD;
-    }
-    if (secure) {
-        prohibited = prohibited || !(env->cp15.mdcr_el3 & MDCR_SPME);
-    }
-
-    if (counter == 31) {
-        /*
-         * The cycle counter defaults to running. PMCR.DP says "disable
-         * the cycle counter when event counting is prohibited".
-         * Some MDCR bits disable the cycle counter specifically.
-         */
-        prohibited = prohibited && env->cp15.c9_pmcr & PMCRDP;
-        if (cpu_isar_feature(any_pmuv3p5, env_archcpu(env))) {
-            if (secure) {
-                prohibited = prohibited || (env->cp15.mdcr_el3 & 
MDCR_SCCD);
-            }
-            if (el == 2) {
-                prohibited = prohibited || (mdcr_el2 & MDCR_HCCD);
-            }
-        }
-    }
+    enabled = (env->cp15.c9_pmcr & PMCRE) &&
+              (env->cp15.c9_pmcnten & (1 << counter));

      if (counter == 31) {
          filter = env->cp15.pmccfiltr_el0;
      } else {
          filter = env->cp15.c14_pmevtyper[counter];
      }

-    p   = filter & PMXEVTYPER_P;
-    u   = filter & PMXEVTYPER_U;
-    nsk = arm_feature(env, ARM_FEATURE_EL3) && (filter & PMXEVTYPER_NSK);
-    nsu = arm_feature(env, ARM_FEATURE_EL3) && (filter & PMXEVTYPER_NSU);
-    nsh = arm_feature(env, ARM_FEATURE_EL2) && (filter & PMXEVTYPER_NSH);
-    m   = arm_el_is_aa64(env, 1) &&
-              arm_feature(env, ARM_FEATURE_EL3) && (filter & PMXEVTYPER_M);
-
      if (el == 0) {
-        filtered = secure ? u : u != nsu;
+        filtered = filter & PMXEVTYPER_U;
      } else if (el == 1) {
-        filtered = secure ? p : p != nsk;
-    } else if (el == 2) {
-        filtered = !nsh;
-    } else { /* EL3 */
-        filtered = m != p;
+        filtered = filter & PMXEVTYPER_P;
      }

      if (counter != 31) {
          /*
           * If not checking PMCCNTR, ensure the counter is setup to an 
event we
           * support
           */
          uint16_t event = filter & PMXEVTYPER_EVTCOUNT;
-        if (!event_supported(event)) {
+        if (!pmu_event_supported(event)) {
              return false;
          }
      }

-    return enabled && !prohibited && !filtered;
+    return enabled && !filtered;
  }

I could link HVF without PMU a few surgery such:
---
@@ -1493,12 +1486,12 @@ static int hvf_sysreg_write(CPUState *cpu, 
uint32_t reg, uint64_t val)

      switch (reg) {
      case SYSREG_PMCCNTR_EL0:
-        pmu_op_start(env);
+        pmccntr_op_start(env);
          env->cp15.c15_ccnt = val;
-        pmu_op_finish(env);
+        pmccntr_op_finish(env);
          break;
      case SYSREG_PMCR_EL0:
-        pmu_op_start(env);
+        pmccntr_op_start(env);

---

I'll try to split as:

- target/arm/pmu_common_helper.c (?)
- target/arm/pmc_helper.c
- target/arm/tcg/pmu_helper.c

Ideally pmu_counter_enabled() should be unified, but I
don't feel confident enough to do it.

Regards,

Phil.

