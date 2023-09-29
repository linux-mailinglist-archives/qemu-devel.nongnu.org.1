Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 479067B385B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 19:07:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmGwm-0004r4-UJ; Fri, 29 Sep 2023 13:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmGwk-0004oq-KE
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 13:06:34 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmGwg-0001B0-GP
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 13:06:32 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32003aae100so598754f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696007188; x=1696611988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNqxwbje+1l9ilqjIYUIRp0+X+eo75099WKcuvQNE24=;
 b=LOHvMBF8ZTpVMyT6ojGoA8g7orRsaedbVYjxAdun52SfNmfZqhb7oNEwL1u5uA2Jjz
 a4I59yWD3TwcwXxRrph/zDjaenHTjZGBzYG6ybBea5j/DKKeqH3AF6nAlsz6Ma/M2vdH
 b0n/gCMIN9/wln9G7RXOagqJvxrD+MzxCUpvc9LzPtJiTuKFV6UErBUwzR/+19c/vl3e
 4Pe3ohzyT0V6yZbfe2vhvqEuL2ZESpVUcpRaOEOVYNjwTCH7A1gcmlqzV4XY0C5IRUb9
 JUpLkhcDTtCbvxIOgih3p2J4Y8FNiN18hV35R5zRyhkbqKn00xwXOve9x11HGE9XEO/k
 6uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696007188; x=1696611988;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rNqxwbje+1l9ilqjIYUIRp0+X+eo75099WKcuvQNE24=;
 b=ucIUyZXRzx9GcdEen2X9vAKU3XY9nKf+tum6QZo+FQXPcBZvvam5ZAbV2vQmvA6FRS
 DsUoR8tVozL0wguRVBTG2KOyH9vXFOFYcZh6f5OpFs3CWO1ZPyXykJPTeiFzaNoUGt+N
 UWAmjefTS5ZlF0buG3Y91Ve7PNqQcC9NnM4oDdLxsd/dYMP5nrGVWAysb+9ICbasI4VD
 xfIRQjQ55E7KuQ0J82UtnMboHX3k430hjcLVyDQ8bTQeTRBniXCazDZcBjmAxmiKT6XS
 Sf1EQsDD1NHW/XpNsnmffME7DbYwmrkXL7od8SCk+5/iXJJKXDcFRe0yAslm5M8J2/Jo
 6uaQ==
X-Gm-Message-State: AOJu0YyIfXfn7ob02ezeowHBB9kjYbDZwjp5PATUSI5q324Fn/c4Eezd
 zLBfS4iqxPkjn9jG7NA6TLJwOw==
X-Google-Smtp-Source: AGHT+IF4S4jPYqmVyfetGglveFKXcLA3xIs5IpftNh8xdNwa/jbdTFrEx9iAIBOKEegWb34jdUj0tA==
X-Received: by 2002:adf:e60c:0:b0:314:3e96:bd7e with SMTP id
 p12-20020adfe60c000000b003143e96bd7emr4694936wrm.4.1696007188158; 
 Fri, 29 Sep 2023 10:06:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a056000009000b0031c71693449sm21952235wrx.1.2023.09.29.10.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 10:06:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4AAE91FFBB;
 Fri, 29 Sep 2023 18:06:27 +0100 (BST)
References: <20230929124304.13672-1-salil.mehta@huawei.com>
 <20230929124304.13672-2-salil.mehta@huawei.com>
 <877co9oz6m.fsf@linaro.org> <49003eaeba6f4719ad3ffb2c9c066eb9@huawei.com>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, Linuxarm
 <linuxarm@huawei.com>
Subject: Re: [PATCH 1/9] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Date: Fri, 29 Sep 2023 17:45:37 +0100
In-reply-to: <49003eaeba6f4719ad3ffb2c9c066eb9@huawei.com>
Message-ID: <87h6ncoqng.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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


Salil Mehta <salil.mehta@huawei.com> writes:

> Hi Alex,
> Thanks for taking pains to review it.
>
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>
>> Salil Mehta <salil.mehta@huawei.com> writes:
>>=20
>> > KVM vCPU creation is done once during the initialization of the VM whe=
n Qemu
>> > threads are spawned. This is common to all the architectures.
>> >
>> > Hot-unplug of vCPU results in destruction of the vCPU objects in QOM b=
ut
>> > the KVM vCPU objects in the Host KVM are not destroyed and their repre=
sentative
>> > KVM vCPU objects/context in Qemu are parked.
>> >
>> > Refactor common logic so that some APIs could be reused by vCPU Hotplu=
g code.
>> >
>> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>> > ---
>> >  accel/kvm/kvm-all.c  | 61 ++++++++++++++++++++++++++++++++++----------
>> >  include/sysemu/kvm.h |  2 ++
>> >  2 files changed, 49 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> > index ff1578bb32..57889c5f6c 100644
>> > --- a/accel/kvm/kvm-all.c
>> > +++ b/accel/kvm/kvm-all.c
>> > @@ -137,6 +137,7 @@ static QemuMutex kml_slots_lock;
>> >  #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>> >
>> >  static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
>> > +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
>>=20
>> weird to have a forward static declaration here if you are declare in
>> the header later on.
>
> Yes, it is awkward. Actually, I had to move a function to get
> a diff of changes which were more readable. Without moving
> existing kvm_get_vcpu() function, change was not getting
> highlighted properly in the generated patch. This relocation
> of the function meant the order of declaration and its call
> got reversed. So I had to use above tactics, even though weird.
>
> Suggestions welcome to solve this?

You could have a code-motion commit ahead of this one to move things
into more useful places.

>
>> >  static inline void kvm_resample_fd_remove(int gsi)
>> >  {
>> > @@ -320,11 +321,51 @@ err:
>> >      return ret;
>> >  }
>> >
>> > +void kvm_park_vcpu(CPUState *cpu)
>> > +{
>> > +    unsigned long vcpu_id =3D cpu->cpu_index;
>>=20
>> cpu_index is a plain int in CPUState:
>>=20
>>     int cpu_index;
>>=20
>> but is defined as an unsigned long in KVMParkedVcpu:
>>=20
>>     unsigned long vcpu_id;
>>=20
>> I'm not sure if this is just a historical anomaly but I suspect we
>> should fixup the discrepancy first so all users of cpu_index use the
>> same size.
>
>
> Yes, agreed. But it is out of scope of this patch.

Not so sure about that. Its adding another potential integer overflow
that would have to be cleared up later rather than fixing the
foundations before doing the refactor.

>> > +    struct KVMParkedVcpu *vcpu;
>> > +
>> > +    vcpu =3D g_malloc0(sizeof(*vcpu));
>> > +    vcpu->vcpu_id =3D vcpu_id;
>> > +    vcpu->kvm_fd =3D cpu->kvm_fd;
>> > +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
>> > +}
>> > +
>> > +int kvm_create_vcpu(CPUState *cpu)
>> > +{
>>=20
>> I don't think you get anything other than -1 on failure so at this point
>> you might as well return a bool.
>
> kvm_vm_ioctl() can return other values? The 'ret' value can then be set=20
> using error_setg_errno() for example, in kvm_init_vcpu().

Ahh yes - although:

    if (ret =3D=3D -1) {
        ret =3D -errno;
    }

So I think you end up inverting again at the error reporting stage.

> It is better to keep error handling standard for any future changes
> as well.

Well the "proper" way is to pass errp down because the -1 from
kvm_get_cpu() isn't the same as -errno from the kvm_vm_ioctl() so
passing that to error_setg_errno() for the former is incorrect as its
just a lookup failure and -1 doesn't mean anything other than fail in
that context.

So yes returning int can be valid but often bool + errp makes for neater
code.

>>=20
>> > +    unsigned long vcpu_id =3D cpu->cpu_index;
>>=20
>> Is this used?
>
> It is used but we can get away with this. I think it
> is a stray left over from shuffle.
>
> Thanks!
>
>> > +    KVMState *s =3D kvm_state;
>> > +    int ret;
>> > +
>> > +    DPRINTF("kvm_create_vcpu\n");
>>=20
>> Please don't add new DPRINTFs - use tracepoints instead. Whether its
>> worth cleaning up up kvm-all first I leave up to you.
>
> I can definitely change for this code.
>
>
>>=20
>> > +    /* check if the KVM vCPU already exist but is parked */
>> > +    ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>> > +    if (ret > 0) {
>> > +        goto found;
>> > +    }
>> > +
>> > +    /* create a new KVM vCPU */
>> > +    ret =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>> > +    if (ret < 0) {
>> > +        return ret;
>> > +    }
>> > +
>> > +found:
>> > +    cpu->vcpu_dirty =3D true;
>> > +    cpu->kvm_fd =3D ret;
>> > +    cpu->kvm_state =3D s;
>> > +    cpu->dirty_pages =3D 0;
>> > +    cpu->throttle_us_per_full =3D 0;
>> > +
>> > +    return 0;
>> > +}
>> > +
>>=20
>> This is trivially nestable to avoid gotos:
>
>
> No issues. I can remove gotos. I was trying to reduce
> indentation.

I think 2 levels is fair enough. We have a lot of goto's in the code for
error clean-up paths although we are slowly cleaning them up now we have
things like g_autoptr and friends.=20

>>=20
>>   bool kvm_create_vcpu(CPUState *cpu)
>
> It is better to return ioctl value so that error can be
> set at the caller handling code.

Or pass down errp.

>
>>   {
>>       unsigned long vcpu_id =3D cpu->cpu_index;
>>       KVMState *s =3D kvm_state;
>>       int ret;
>>=20
>>       /* check if the KVM vCPU already exist but is parked */
>>       ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>>       if (ret < 0) {
>>           /* not found, try to create a new KVM vCPU */
>>           ret =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>>           if (ret < 0) {
>>               return false;
>>           }
>>       }
>
> Yes, can be done this way.
>
>>=20
>>       cpu->vcpu_dirty =3D true;
>>       cpu->kvm_fd =3D ret;
>>       cpu->kvm_state =3D s;
>>       cpu->dirty_pages =3D 0;
>>       cpu->throttle_us_per_full =3D 0;
>>=20
>>       return true;
>
> return value is better than Boolean.
>
>>   }
>>=20
>> >  static int do_kvm_destroy_vcpu(CPUState *cpu)
>> >  {
>> >      KVMState *s =3D kvm_state;
>> >      long mmap_size;
>> > -    struct KVMParkedVcpu *vcpu =3D NULL;
>> >      int ret =3D 0;
>> >
>> >      DPRINTF("kvm_destroy_vcpu\n");
>> > @@ -353,10 +394,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>> >          }
>> >      }
>> >
>> > -    vcpu =3D g_malloc0(sizeof(*vcpu));
>> > -    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
>> > -    vcpu->kvm_fd =3D cpu->kvm_fd;
>> > -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
>> > +    kvm_park_vcpu(cpu);
>> >  err:
>> >      return ret;
>> >  }
>> > @@ -384,7 +422,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long
>> vcpu_id)
>> >          }
>> >      }
>> >
>> > -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>> > +    return -1;
>> >  }
>> >
>> >  int kvm_init_vcpu(CPUState *cpu, Error **errp)
>> > @@ -395,19 +433,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>=20
>> Hmm it looks like no one cares about the return value here and the fact
>> that callers use &error_fatal should be enough to exit. You can then
>> just return early and avoid the error ladder.
>
> Maybe yes, but is that change really required?

Well it would simplify the goto jumps in the function that are only
there to ensure a value that is never looked at is generated.=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

