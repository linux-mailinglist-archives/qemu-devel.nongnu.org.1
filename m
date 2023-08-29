Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB0678BE65
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 08:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qasBo-0004w0-BW; Tue, 29 Aug 2023 02:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qasBZ-0004tp-Ea
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 02:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qasBP-0006zO-23
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 02:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693290388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+5bUJTOtjM61nZgfBKmHAMH2j9Tt5m4wgBbaF6JRfA=;
 b=A7B9i2/6Y6G5Zq6C68LUDKTgMzjR6VT6/rgXQSsRmdAlPrDL/QJnJ8FmqwVi9FpEQxoLPN
 v+kITPGf9rtgJ4VsSA5v+PeH6w1taR0InLAKjbb+fAaVk4RcL8xo1vx1ye4oJaHm8a7lJx
 XB6aVTAKnls58Tb2EWcvlQiEstqpIbM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-3J412AtSMSCAHgGpjmiYWg-1; Tue, 29 Aug 2023 02:26:27 -0400
X-MC-Unique: 3J412AtSMSCAHgGpjmiYWg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4011f56165eso24655465e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 23:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693290386; x=1693895186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+5bUJTOtjM61nZgfBKmHAMH2j9Tt5m4wgBbaF6JRfA=;
 b=cOYjjuUGac3MT5eCVcvFKfH9QjccaLrs7siKYfrQQrBJK8G58y/NCsm0mtxdYteFVd
 u0gUfAWwvxIniCXcZ3NgzU56CcRR9f9vD+wHjm4wxJISo83m9CNXix3NBiA4YH6Y+r4W
 PiJZ0yqeDyQ9pfsaJsYW6TBGwVR+Uyi3eIyi3fwhUJVFhSvGEN+Vz6MVrh2w+Yk4Z8hP
 nAjMIOO20elWWDcsJ1I8oGZR3WVFvVbUprI7Mwhj4GCCoRfcxEZygTPSXwks4RCQyUJi
 7036Z9J68SQbst66d7WqteyEGRFzgUiKpUCQTeg4EqvR2+ayuQgypmfz5VWE9ES9Oumh
 CtcA==
X-Gm-Message-State: AOJu0Ywcwlwkff9KBNpJs1+3Amq4yGh8AqMqVuJcKzIzyMaijhbQeCwd
 pB1XhpRkahMCEqJ8mZ+xlaDeecJsijbSd2LUiVFCtvnzYy1pz6jAvblOiIlKkvaGdqwVfTLLzON
 4QMZ0tJEzJswSMQo=
X-Received: by 2002:adf:8b95:0:b0:317:59a6:6f68 with SMTP id
 o21-20020adf8b95000000b0031759a66f68mr1266255wra.0.1693290385817; 
 Mon, 28 Aug 2023 23:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOtt5PRYaY8JRITfUy0NeCLiotaEZiC6m5xcUHBMaLUzRyKE4wOwiLtleP4LxCt17N9t1LaA==
X-Received: by 2002:adf:8b95:0:b0:317:59a6:6f68 with SMTP id
 o21-20020adf8b95000000b0031759a66f68mr1266239wra.0.1693290385433; 
 Mon, 28 Aug 2023 23:26:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a5d638e000000b0031971ab70c9sm12678087wru.73.2023.08.28.23.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 23:26:24 -0700 (PDT)
Message-ID: <90ee54b6-e7b0-67d3-b627-b2c8b2066a3b@redhat.com>
Date: Tue, 29 Aug 2023 08:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2] target/s390x/kvm: Simplify the GPRs, ACRs, CRs
 and prefix synchronization code
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>
References: <20230814190604.907982-1-thuth@redhat.com>
 <1b3db0fa-3d63-1f94-838d-cd75baf67431@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <1b3db0fa-3d63-1f94-838d-cd75baf67431@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.169, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Thomas,

On 8/28/23 20:20, Thomas Huth wrote:
> On 14/08/2023 21.06, Thomas Huth wrote:
>> KVM_SYNC_GPRS, KVM_SYNC_ACRS, KVM_SYNC_CRS and KVM_SYNC_PREFIX are
>> available since kernel 3.10. Since we already require at least kernel
>> 3.15 in the s390x KVM code, we can assume that the KVM_CAP_SYNC_REGS
>> sync code is always possible for these registers, and remove the
>> related checks and fallbacks via KVM_SET_REGS and KVM_GET_REGS.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   target/s390x/kvm/kvm.c | 119 ++++++++++++-----------------------------
>>   1 file changed, 34 insertions(+), 85 deletions(-)
> 
> Ping! Anybody any comments on this one?


Only minor comments, see below.

> 
>   Thomas
> 
>> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>> index a9e5880349..ff415f7b30 100644
>> --- a/target/s390x/kvm/kvm.c
>> +++ b/target/s390x/kvm/kvm.c
>> @@ -148,7 +148,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>>       KVM_CAP_LAST_INFO
>>   };
>> -static int cap_sync_regs;
>>   static int cap_async_pf;
>>   static int cap_mem_op;
>>   static int cap_mem_op_extension;
>> @@ -342,21 +341,28 @@ static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
>>   int kvm_arch_init(MachineState *ms, KVMState *s)
>>   {
>> +    int required_caps[] = {
>> +        KVM_CAP_DEVICE_CTRL,
>> +        KVM_CAP_SYNC_REGS,
>> +    };
>> +
>> +    for (int i = 0; i < ARRAY_SIZE(required_caps); i++) {
>> +        if (!kvm_check_extension(s, required_caps[i])) {
>> +            error_report("KVM is missing capability #%d - "
>> +                         "please use kernel 3.15 or newer", required_caps[i]);
>> +            return -1;
>> +        }
>> +    }
>> +
>>       object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
>>                            false, NULL);
>> -    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
>> -        error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - "
>> -                     "please use kernel 3.15 or newer");
>> -        return -1;
>> -    }
>>       if (!kvm_check_extension(s, KVM_CAP_S390_COW)) {
>>           error_report("KVM is missing capability KVM_CAP_S390_COW - "
>>                        "unsupported environment");
>>           return -1;
>>       }
>> -    cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
>>       cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>>       cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>>       cap_mem_op_extension = kvm_check_extension(s, KVM_CAP_S390_MEM_OP_EXTENSION);

I would introduce a first patch for the changes above, checking the
KVM capabilities, and a second for get/put register changes.


>> @@ -463,15 +469,15 @@ void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
>>   static int can_sync_regs(CPUState *cs, int regs)
>>   {
>> -    return cap_sync_regs && (cs->kvm_run->kvm_valid_regs & regs) == regs;
>> +    return (cs->kvm_run->kvm_valid_regs & regs) == regs;
>>   }
>>   int kvm_arch_put_registers(CPUState *cs, int level)
>>   {
>> +    const int required_syncs = KVM_SYNC_GPRS | KVM_SYNC_ACRS |
>> +                               KVM_SYNC_CRS | KVM_SYNC_PREFIX;

May be introduce a KVM_SYNC_s390_REQUIRED_FIELDS define for these fields,
as we already have KVM_SYNC_S390_VALID_FIELDS.

>>       S390CPU *cpu = S390_CPU(cs);
>>       CPUS390XState *env = &cpu->env;
>> -    struct kvm_sregs sregs;
>> -    struct kvm_regs regs;
>>       struct kvm_fpu fpu = {};
>>       int r;
>>       int i;
>> @@ -480,21 +486,16 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>>       cs->kvm_run->psw_addr = env->psw.addr;
>>       cs->kvm_run->psw_mask = env->psw.mask;
>> -    if (can_sync_regs(cs, KVM_SYNC_GPRS)) {
>> -        for (i = 0; i < 16; i++) {
>> -            cs->kvm_run->s.regs.gprs[i] = env->regs[i];
>> -            cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GPRS;
>> -        }
>> -    } else {
>> -        for (i = 0; i < 16; i++) {
>> -            regs.gprs[i] = env->regs[i];
>> -        }
>> -        r = kvm_vcpu_ioctl(cs, KVM_SET_REGS, &regs);
>> -        if (r < 0) {
>> -            return r;
>> -        }
>> +    g_assert((cs->kvm_run->kvm_valid_regs & required_syncs) == required_syncs);

this also is :

           g_assert(can_sync_regs(cs, KVM_SYNC_s390_REQUIRED_FIELDS));

the rest looks good.

Thanks,

C.

>> +    cs->kvm_run->kvm_dirty_regs |= required_syncs;
>> +    for (i = 0; i < 16; i++) {
>> +        cs->kvm_run->s.regs.gprs[i] = env->regs[i];
>> +        cs->kvm_run->s.regs.acrs[i] = env->aregs[i];
>> +        cs->kvm_run->s.regs.crs[i] = env->cregs[i];
>>       }
>> +    cs->kvm_run->s.regs.prefix = env->psa;
>> +
>>       if (can_sync_regs(cs, KVM_SYNC_VRS)) {
>>           for (i = 0; i < 32; i++) {
>>               cs->kvm_run->s.regs.vrs[i][0] = env->vregs[i][0];
>> @@ -572,25 +573,6 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>>           }
>>       }
>> -    /* access registers and control registers*/
>> -    if (can_sync_regs(cs, KVM_SYNC_ACRS | KVM_SYNC_CRS)) {
>> -        for (i = 0; i < 16; i++) {
>> -            cs->kvm_run->s.regs.acrs[i] = env->aregs[i];
>> -            cs->kvm_run->s.regs.crs[i] = env->cregs[i];
>> -        }
>> -        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_ACRS;
>> -        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_CRS;
>> -    } else {
>> -        for (i = 0; i < 16; i++) {
>> -            sregs.acrs[i] = env->aregs[i];
>> -            sregs.crs[i] = env->cregs[i];
>> -        }
>> -        r = kvm_vcpu_ioctl(cs, KVM_SET_SREGS, &sregs);
>> -        if (r < 0) {
>> -            return r;
>> -        }
>> -    }
>> -
>>       if (can_sync_regs(cs, KVM_SYNC_GSCB)) {
>>           memcpy(cs->kvm_run->s.regs.gscb, env->gscb, 32);
>>           cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GSCB;
>> @@ -612,22 +594,15 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>>           cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_DIAG318;
>>       }
>> -    /* Finally the prefix */
>> -    if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
>> -        cs->kvm_run->s.regs.prefix = env->psa;
>> -        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_PREFIX;
>> -    } else {
>> -        /* prefix is only supported via sync regs */
>> -    }
>>       return 0;
>>   }
>>   int kvm_arch_get_registers(CPUState *cs)
>>   {
>> +    const int required_syncs = KVM_SYNC_GPRS | KVM_SYNC_ACRS |
>> +                               KVM_SYNC_CRS | KVM_SYNC_PREFIX;
>>       S390CPU *cpu = S390_CPU(cs);
>>       CPUS390XState *env = &cpu->env;
>> -    struct kvm_sregs sregs;
>> -    struct kvm_regs regs;
>>       struct kvm_fpu fpu;
>>       int i, r;
>> @@ -635,37 +610,16 @@ int kvm_arch_get_registers(CPUState *cs)
>>       env->psw.addr = cs->kvm_run->psw_addr;
>>       env->psw.mask = cs->kvm_run->psw_mask;
>> -    /* the GPRS */
>> -    if (can_sync_regs(cs, KVM_SYNC_GPRS)) {
>> -        for (i = 0; i < 16; i++) {
>> -            env->regs[i] = cs->kvm_run->s.regs.gprs[i];
>> -        }
>> -    } else {
>> -        r = kvm_vcpu_ioctl(cs, KVM_GET_REGS, &regs);
>> -        if (r < 0) {
>> -            return r;
>> -        }
>> -         for (i = 0; i < 16; i++) {
>> -            env->regs[i] = regs.gprs[i];
>> -        }
>> +    /* the GPRS, ACRS and CRS */
>> +    g_assert((cs->kvm_run->kvm_valid_regs & required_syncs) == required_syncs);
>> +    for (i = 0; i < 16; i++) {
>> +        env->regs[i] = cs->kvm_run->s.regs.gprs[i];
>> +        env->aregs[i] = cs->kvm_run->s.regs.acrs[i];
>> +        env->cregs[i] = cs->kvm_run->s.regs.crs[i];
>>       }
>> -    /* The ACRS and CRS */
>> -    if (can_sync_regs(cs, KVM_SYNC_ACRS | KVM_SYNC_CRS)) {
>> -        for (i = 0; i < 16; i++) {
>> -            env->aregs[i] = cs->kvm_run->s.regs.acrs[i];
>> -            env->cregs[i] = cs->kvm_run->s.regs.crs[i];
>> -        }
>> -    } else {
>> -        r = kvm_vcpu_ioctl(cs, KVM_GET_SREGS, &sregs);
>> -        if (r < 0) {
>> -            return r;
>> -        }
>> -         for (i = 0; i < 16; i++) {
>> -            env->aregs[i] = sregs.acrs[i];
>> -            env->cregs[i] = sregs.crs[i];
>> -        }
>> -    }
>> +    /* The prefix */
>> +    env->psa = cs->kvm_run->s.regs.prefix;
>>       /* Floating point and vector registers */
>>       if (can_sync_regs(cs, KVM_SYNC_VRS)) {
>> @@ -690,11 +644,6 @@ int kvm_arch_get_registers(CPUState *cs)
>>           env->fpc = fpu.fpc;
>>       }
>> -    /* The prefix */
>> -    if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
>> -        env->psa = cs->kvm_run->s.regs.prefix;
>> -    }
>> -
>>       if (can_sync_regs(cs, KVM_SYNC_ARCH0)) {
>>           env->cputm = cs->kvm_run->s.regs.cputm;
>>           env->ckc = cs->kvm_run->s.regs.ckc;
> 


