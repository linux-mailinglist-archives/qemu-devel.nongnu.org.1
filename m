Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 907EF7D5650
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJJn-00029c-P3; Tue, 24 Oct 2023 11:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qvJJk-00029R-EJ
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:27:40 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qvJJe-0004a6-JL
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:27:40 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so39168185ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698161253; x=1698766053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=68UqSz6uc9bDl5yfLUTqpQvEGESZoZLcxG/gli/Buls=;
 b=mJVYaLNqZpse6G4tGKVaBrVq2F1qB/iUv1V9yKbtNxg7h0mcSUKxP5V8SOKYCb/nU9
 +IY9XQwFqXJU/Wnh3dr3BKVW0TmD7goLgc6htcNfn2Tt8sE7XAbzHr3QN/E2CZTLy1O8
 06QFTmQlPtIp+ysSvwGLvxM+8cggNmoaqFJly/62R+SUYd8+Ah+xrP5E1NBbI209MOrc
 /79LpmiZTPqgsHsvtgx9Psw3W9n8YsdVJ0TVnibE7auS25Q/G/tRNxmn5eYFep5RUSd6
 dbuGJj2QHJdW/mbp7u32poBImbeqCvlWJqMzAE9m9fOyoEj9F1U0SFULf4BKfNQeByVr
 pjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698161253; x=1698766053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=68UqSz6uc9bDl5yfLUTqpQvEGESZoZLcxG/gli/Buls=;
 b=uV+EfEY3K58xZud4Djb5za98EfJ+plVCWRlekG5RouPTDgJC+Nq3g96gTZsaoR3BIm
 E01W0Pzt2RXk1+9slvWdFwvARPoXnWDZ1f4limeHk9oQtnMZLLuho4rHxpdvSGQMR7R0
 m5ZKFPg2HyzA9ONEMzNNAcW5CJ5LdqYJ2brInHyh2Fy9g40vIlyHMDA0E5MtSKyz5q+d
 YRIMbANePSKjzd0vMvQpvp2vW12Zd0/w6IasyI+5cidEj0F6dl8YhLfd6GcJw4cxkUug
 7uKCQ5FYBGzBhTp00LT8Vlv4ve6MpfzjLPoz/Scdk27s+M5zKf9PBzbPrl+uZNi0+KhX
 NZVw==
X-Gm-Message-State: AOJu0YwRoJQyf0uV5O0WGEN5L01mLECso8jktk+/AL2y3nj51pbYfBD3
 Lhix4d374kRl4/G5OZadQQQ=
X-Google-Smtp-Source: AGHT+IEoqyy9gkTqbsN67m5irJQ95H51M9S6QoCiiuVLdq3BQ+Mm943Jq19FwKAx7o/ZHoMnujH1lQ==
X-Received: by 2002:a17:902:f295:b0:1ca:2743:bf79 with SMTP id
 k21-20020a170902f29500b001ca2743bf79mr11172666plc.39.1698161252961; 
 Tue, 24 Oct 2023 08:27:32 -0700 (PDT)
Received: from ?IPV6:2001:ee0:50f4:9050:647f:b391:99d7:635d?
 ([2001:ee0:50f4:9050:647f:b391:99d7:635d])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a17090332d100b001c32fd9e412sm7523278plr.58.2023.10.24.08.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 08:27:32 -0700 (PDT)
Message-ID: <f7ed46e8-cf71-4b1d-95d4-edc4a0b7540f@gmail.com>
Date: Tue, 24 Oct 2023 22:27:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] i386/tcg: implement x2APIC registers MSR access
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
 <20230926160637.27995-2-minhquangbui99@gmail.com>
 <CAGCz3vtQiRkeErcA9NpUeu0Ak7o=qsy02PiVvZrEMoP=86MU1g@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CAGCz3vtQiRkeErcA9NpUeu0Ak7o=qsy02PiVvZrEMoP=86MU1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 10/22/23 20:59, Phil Dennis-Jordan wrote:
> I can confirm that this works. The build issue obviously needs fixing,
> but once that's fixed, this improves on the status quo.
> 
> I've tested this and patch 2/5 with x2apic CPUID bit enabled with the
> hvf backend on macOS. To make it work in hvf mode, I used the attached
> additional minimal patch to wire it up, but with that in place it
> noticeably improves guest OS performance. (This patch doesn't yet
> implement raising exceptions or checking for x2apic mode, more on that
> in my comments below.)
> 
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> 
> On Tue, 26 Sept 2023 at 18:08, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> @@ -455,6 +469,19 @@ void helper_rdmsr(CPUX86State *env)
>>           val = (cs->nr_threads * cs->nr_cores) | (cs->nr_cores << 16);
>>           break;
>>       }
>> +    case MSR_APIC_START ... MSR_APIC_END: {
>> +        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
>> +
>> +        if (!is_x2apic_mode(env_archcpu(env)->apic_state)) {
>> +            raise_exception_ra(env, EXCP0D_GPF, GETPC());
>> +        }
>> +
>> +        qemu_mutex_lock_iothread();
>> +        val = apic_register_read(index);
>> +        qemu_mutex_unlock_iothread();
> 
> Shouldn't the x2apic mode check technically be inside the lock?
> Furthermore, we need the mode check logic in each accelerator whose
> MSR read and write we wire up. Finally, there's the exception raising
> issue which Michael noted.
> 
> So my suggestion would be to wrap the x2apic mode check and the call
> to the lower level apic_register_read into a standalone
> apic_x2apic_msr_read() or similar, and the equivalent for writes.
> These functions should then also return success or failure, the latter
> indicating an exception should be raised. Raising the exception can
> then also be implemented for each accelerator at the relevant call
> site. That contains the raise_exception_ra call in the TCG specific
> code, and I can do the equivalent on the hvf side.

Thanks a lot for your suggestion, I've taken this approach and 
implemented an apic_msr_read/write wrapper as you suggested in version 9 
(https://lore.kernel.org/qemu-devel/20231024152105.35942-1-minhquangbui99@gmail.com/)

Thank you,
Quang Minh.

