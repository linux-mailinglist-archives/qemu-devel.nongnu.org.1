Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D681275794B
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:32:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLhzu-0006j2-Py; Tue, 18 Jul 2023 06:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qLhzp-0006gJ-Ij
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qLhzm-0007WH-15
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689676309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rETFe8jJkQSXqGI75lQYC/IfRjlfSdzlb2a2/I/CK7U=;
 b=bLhTm4nCMfPZORXrv/SuoWxvyI0MG68Ttd4khDvRkicwewhhktYRvdRSJHqFYQLaMhuLt/
 lk1x9BaX4hDD2+wUM/h003xh71DvMC07Zp8cfr/nuUOwjzuPoS3DsDtsGBcLlQzchvaAVB
 uErNCyIK12fSc8LaW2Nxd/AHyFl72+E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-Fa7wNsf7MqKzFNBrjIyx5g-1; Tue, 18 Jul 2023 06:31:48 -0400
X-MC-Unique: Fa7wNsf7MqKzFNBrjIyx5g-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b890ca6718so26892065ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 03:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689676307; x=1692268307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rETFe8jJkQSXqGI75lQYC/IfRjlfSdzlb2a2/I/CK7U=;
 b=fa3iZNaNLeTtmUBq9dqsgqAYGxk/pYyjBTWhh5EjAsVfyXRtlV2tN+qdGKEdZoOy7M
 Cg7ltuGR7TTJFcQUWO3X7qnkloXgVsnDTevY3xieTybsvPUOqQ0i+FHJVrQ6WeKdma18
 lNT/6FcQlwtAN5cYz7gdAL/Z4s8TMC3lEmJ8atHnzaXuWEBJQMJiBIE/Ym7zh3EHJQ4v
 bw+NnGCHGh+ZWShlo3e2DbSOARKCdJlRqRF3rsFqi04JruVK1ZdCFw4AdgsXX7k6bmQv
 BLphjf2CUqIRcKc/sPhLudLXcjEjwePX3n6bZaFk9pjP/IfgyZZ5lgAvUARGR+QzPTd1
 65mA==
X-Gm-Message-State: ABy/qLZd7cOF1AVfCrg85T2x6uwp1YA2+g5FF4RGBpuzY4A5D9rkIZSo
 5mWyoBcVWvMlDv7CHFuTlYEO8+x9SzIYLy4+w9OxkameAyEF6DCFPDzBJEQyTXS7E8PKuJQVrlZ
 aJbVikv2COXWF5fM=
X-Received: by 2002:a17:903:32cd:b0:1b8:a936:1905 with SMTP id
 i13-20020a17090332cd00b001b8a9361905mr16988584plr.38.1689676307519; 
 Tue, 18 Jul 2023 03:31:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGNXJ31VIafTtEEgznYejLJXlJlRfRKbJ18IOIhIOZRdsiO8cQ1VRRh5brRoMMG4SQGYfnI5w==
X-Received: by 2002:a17:903:32cd:b0:1b8:a936:1905 with SMTP id
 i13-20020a17090332cd00b001b8a9361905mr16988562plr.38.1689676307113; 
 Tue, 18 Jul 2023 03:31:47 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 jg5-20020a17090326c500b001b9f7bc3e77sm1500705plb.189.2023.07.18.03.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 03:31:46 -0700 (PDT)
Message-ID: <527ed3dc-b723-5c37-37e2-58d4266b1f32@redhat.com>
Date: Tue, 18 Jul 2023 20:31:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
 <CAFEAcA-XK0U0bPuAf4K7avdJqnmcibFX_swY1Weo_Tn3wHJ1fw@mail.gmail.com>
 <20230714135004.230c05b2@imammedo.users.ipa.redhat.com>
 <CAFEAcA92QFxN0at+5rk7yrfk1sj3tX-GcfZYYY5_=210np_j4g@mail.gmail.com>
 <20230717144455.6f02fde9@imammedo.users.ipa.redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230717144455.6f02fde9@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Igor,

On 7/17/23 22:44, Igor Mammedov wrote:
> On Fri, 14 Jul 2023 13:56:00 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> On Fri, 14 Jul 2023 at 12:50, Igor Mammedov <imammedo@redhat.com> wrote:
>>>
>>> On Thu, 13 Jul 2023 12:59:55 +0100
>>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>>   
>>>> On Thu, 13 Jul 2023 at 12:52, Marcin Juszkiewicz
>>>> <marcin.juszkiewicz@linaro.org> wrote:
>>>>>
>>>>> W dniu 13.07.2023 o 13:44, Peter Maydell pisze:
>>>>>   
>>>>>> I see this isn't a change in this patch, but given that
>>>>>> what the user specifies is not "cortex-a8-arm-cpu" but
>>>>>> "cortex-a8", why do we include the "-arm-cpu" suffix in
>>>>>> the error messages? It's not valid syntax to say
>>>>>> "-cpu cortex-a8-arm-cpu", so it's a bit misleading...
>>>>>
>>>>> Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for
>>>>> other architectures.
>>>>
>>>> Yes; my question is "why are we not using the user-facing
>>>> string rather than the internal type name?".
>>>
>>> With other targets full CPU type name can also be valid
>>> user-facing string. Namely we use it with -device/device_add
>>> interface. Considering we would like to have CPU hotplug
>>> on ARM as well, we shouldn't not outlaw full type name.
>>> (QMP/monitor interface also mostly uses full type names)
>>
>> You don't seem to be able to use the full type name on
>> x86-64 either:
>>
>> $ ./build/all/qemu-system-x86_64 -cpu pentium-x86_64-cpu
>> qemu-system-x86_64: unable to find CPU model 'pentium-x86_64-cpu'
> 
> that's because it also tied into old cpu_model resolving
> routines, and I haven't added typename lookup the last
> time I've touched it (it was out of topic change anyway).
> 
> but some targets do recognize typename, while some
> do a lot more juggling with cpu_model (alpha/ppc),
> and yet another class (garbage in => cpu type out).
> 
> With the last one we could just error,
> while with alpha/ppc we could dumb it down to typenames
> only.
> 

Your summary here is correct to me. However, I don't quiet understand
the issue you're trying to resolve. As you mentioned, there are two
cases where the users need to specify CPU typename: (1) In the command
lines to start VM; (2) When CPU is hot added.

For (1), the list of all available CPU is provided by each individual
target. It's to say, each individual target is responsible for correlating
the name (typename, CPU model name, or whatever else). Each individual
target has its own rules for this correlation. Why do we bother to unify
the rules so that only the typename is allowed?

   //
   // The output can be directly used in the command lines to start VM.
   // I don't see any problems we have. Note that the list of available
   // CPU names is printed by cpu_list(), which is a target specific
   // implementation.
   //
   # aarch64-softmmu/qemu-system-aarch64 -cpu help
   Available CPUs:
     a64fx
     arm1026
     arm1136
     arm1136-r2
     arm1176
     arm11mpcore
     arm926
     arm946
     cortex-a15
     cortex-a35
     cortex-a53

For (2) where CPU is hot added, the help option can also be used to dump
the available CPUs. Nothing went to wrong as I can see. The rule used here
to correlate names with CPUs is global: typename <-> CPU

   //
   // The printed CPU typenames can be taken as the driver directly
   //
   (qemu) device_add driver=?
      :
   CPU devices:
   name "a64fx-arm-cpu"
   name "cortex-a35-arm-cpu"
   name "cortex-a53-arm-cpu"
   name "cortex-a55-arm-cpu"
   name "cortex-a57-arm-cpu"
   name "cortex-a72-arm-cpu"
   name "cortex-a76-arm-cpu"
   name "max-arm-cpu"
   name "neoverse-n1-arm-cpu"

>> and '-cpu help' does not list them with the suffix.
> 
> both above points are fixable,
> 
> I can prepare PoC patches for that if there is
> no opposition to the idea.
> 

Please refer to above for the argument. If I'm correct, there is nothing
to be resolved or improved.

>>> Instead it might be better to consolidate on what has
>>> been done on making CPU '-device' compatible and
>>> allow to use full CPU type name with '-cpu' on arm machines.
>>>
>>> Then later call suffix-less legacy => deprecate/drop it from
>>> user-facing side including cleanup of all the infra we've
>>> invented to keep mapping between cpu_model and typename.
>>
>> This seems to me like a worsening of the user interface,
>> and in practice there is not much likelihood of being
>> able to deprecate-and-drop the nicer user-facing names,
>> because they are baked into so many command lines and
>> scripts.
> Nice names are subjective point, I suspect in a long run
> once users switched to using longer names, they won't care much
> about that either.
> 
> Also it's arguable if it is worsening UI or not.
> I see using consolidated typenames across the board (incl. UI)
> as a positive development.
> 
> As for scripts/CLI users out there, yes it would be disruptive
> for a while but one can adapt to new naming (or use a wrapper
> around QEMU that does suffix adding/model mapping as a crutch).
> 
> It weren't possible to drop anything before we introduced
> deprecation process, but with it we can do it.
> 

Thanks,
Gavin


