Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A26867FB99A
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 12:46:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7wWY-0000Ou-Ac; Tue, 28 Nov 2023 06:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7wWV-0000O9-PP
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 06:45:03 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7wWU-00016N-0Z
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 06:45:03 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-548ce39b101so7109074a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 03:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701171900; x=1701776700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fY+zgyNlH3HP/fcFI3nAgR1hmj5MinaOr/zzJ49EWhA=;
 b=dJkbJ59H6F0a391aDmfjikI3XaUuRxYvdTsDl2bCRC3AhX1YnhzGMAVtBwhiuMLwHV
 RFW5hk+m2R1iY12ML+nBivOMC2TjgOfeh67+zYpy0OqMkiKGRFNNss7Rx9O+ejbl/G3V
 UQTbL33YyfvTt4zYGIObines8fky/6vkjaufj4CfaDA579sz1IXwqGPJTWFryq1o8Djg
 Qllau5Vv8U8ojIegdfH+gNnXT9CAn9XtoDXYI7SD7JwyLfQF6SX+UEsI27sG1TmXjVW/
 TI/aUch11m9vEszXTK1qeQ2PMZ1nNg4jlMYpfZ6R2sVVJyQBlpdziBQxk04umA6QzVjS
 eM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701171900; x=1701776700;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fY+zgyNlH3HP/fcFI3nAgR1hmj5MinaOr/zzJ49EWhA=;
 b=CG8xRKw7JLyOmC/nC6q+Ad9JgxVLyAaJ/5ryKYY08x1zd/uum5OpEgvcA4vtU1N/sG
 OsYRPDV6e1rrjYJ7/Ddg5HHk312QUxsDniAifh3Jf35zx7MkzKRGOmJMWFYZeWGlDgfY
 xHDxY3GhoOAa3jE0BZHwvMcaf5qjAiDX3H5SAGRZwh+oexChLq8m7aENSd9okiV0yfGF
 eZ4X52MRE8pPGkKksEuBX+qOvSKbbf68ZGZGPHMdzfFbvweIjecABvzJshijve0jUSAA
 6iRAJgJrPN0nRvrVGOt/BxTrY/5pV71tJHmbmWP0lvh0xjRDzllVzVTcvs3G7cAl5uy/
 gkOA==
X-Gm-Message-State: AOJu0YwOJ7RR2yAtt6KgPSqdE4SijCAD1G8sZw3VZT5tsXRiryXjoUA0
 KtYkoaR7O8LUDayZsSYtyW1Zew==
X-Google-Smtp-Source: AGHT+IEWu6MtBVGxT2PopjytuHZws/TRrw4z4Q/v/tur+qUVXEM1Cu3oXAVdoFiJTmoQKnWX7doj1Q==
X-Received: by 2002:a05:6402:d6b:b0:54b:1a4c:870a with SMTP id
 ec43-20020a0564020d6b00b0054b1a4c870amr6776874edb.5.1701171900323; 
 Tue, 28 Nov 2023 03:45:00 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 l1-20020a056402230100b00548ab6c9f12sm6279125eda.54.2023.11.28.03.44.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 03:45:00 -0800 (PST)
Message-ID: <2830159e-3d6d-430b-aed7-43b1b4fce56e@linaro.org>
Date: Tue, 28 Nov 2023 12:44:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] target/arm: Add support for DC CVAP & DC CVADP ins
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, quintela@redhat.com,
 dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com
References: <20191105234100.22052-1-beata.michalska@linaro.org>
 <20191105234100.22052-5-beata.michalska@linaro.org>
 <95cc7c22-939f-4ce0-aecd-d0ff7b0e7c9c@linaro.org>
 <CAFEAcA-G7hbnRv52btWkpDs-1rgFqyVGgRVx-hG40i7zgsykaQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-G7hbnRv52btWkpDs-1rgFqyVGgRVx-hG40i7zgsykaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 28/11/23 12:34, Peter Maydell wrote:
> On Tue, 28 Nov 2023 at 11:24, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi,
>>
>> On 6/11/19 00:41, Beata Michalska wrote:
>>> ARMv8.2 introduced support for Data Cache Clean instructions
>>> to PoP (point-of-persistence) - DC CVAP and PoDP (point-of-deep-persistence)
>>> - DV CVADP. Both specify conceptual points in a memory system where all writes
>>> that are to reach them are considered persistent.
>>> The support provided considers both to be actually the same so there is no
>>> distinction between the two. If none is available (there is no backing store
>>> for given memory) both will result in Data Cache Clean up to the point of
>>> coherency. Otherwise sync for the specified range shall be performed.
>>>
>>> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
>>> ---
>>>    linux-user/elfload.c |  2 ++
>>>    target/arm/cpu.h     | 10 ++++++++++
>>>    target/arm/cpu64.c   |  1 +
>>>    target/arm/helper.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    4 files changed, 69 insertions(+)
>>
>>
>>> +#ifndef CONFIG_USER_ONLY
>>> +static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
>>> +                          uint64_t value)
>>> +{
>>> +    ARMCPU *cpu = env_archcpu(env);
>>> +    /* CTR_EL0 System register -> DminLine, bits [19:16] */
>>> +    uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
>>> +    uint64_t vaddr_in = (uint64_t) value;
>>> +    uint64_t vaddr = vaddr_in & ~(dline_size - 1);
>>> +    void *haddr;
>>> +    int mem_idx = cpu_mmu_index(env, false);
>>> +
>>> +    /* This won't be crossing page boundaries */
>>> +    haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
>>> +    if (haddr) {
>>> +
>>> +        ram_addr_t offset;
>>> +        MemoryRegion *mr;
>>> +
>>> +        /* RCU lock is already being held */
>>> +        mr = memory_region_from_host(haddr, &offset);
>>> +
>>> +        if (mr) {
>>> +            memory_region_do_writeback(mr, offset, dline_size);
>>> +        }
>>> +    }
>>> +}
>>
>>
>>> +#ifndef CONFIG_USER_ONLY
>>> +    /* Data Cache clean instructions up to PoP */
>>> +    if (cpu_isar_feature(aa64_dcpop, cpu)) {
>>
>> Am I correct understanding this is a TCG-only feature?
> 
> For KVM, whether the vCPU implements these cache
> maintenance instructions is up to it -- like all insns,
> QEMU doesn't ever see if the guest executes them or not
> (either the host CPU just implements them, or the host
> kernel traps and handles them). The code in this patch is
> specifically for the QEMU TCG emulation of them.

Thank you Peter. In this case I'm compiling HVF, but this is the
same reasoning. I'll add #ifdef'ry similar to ats_write() (commit
9fb005b02d "target/arm: Restrict the Address Translate write operation
to TCG accel"):

-- >8 --
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 99c7da9ca4..a05e613e10 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7629,6 +7629,7 @@ static const ARMCPRegInfo rndr_reginfo[] = {
  static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
                            uint64_t value)
  {
+#ifdef CONFIG_TCG
      ARMCPU *cpu = env_archcpu(env);
      /* CTR_EL0 System register -> DminLine, bits [19:16] */
      uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
@@ -7653,6 +7654,10 @@ static void dccvap_writefn(CPUARMState *env, 
const ARMCPRegInfo *opaque,
          }
  #endif /*CONFIG_USER_ONLY*/
      }
+#else
+    /* Handled by hardware accelerator. */
+    g_assert_not_reached();
+#endif /* CONFIG_TCG */
  }
---

Regards,

Phil.


