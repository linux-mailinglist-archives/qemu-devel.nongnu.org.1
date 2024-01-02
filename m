Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD018821B9D
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 13:30:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKdtB-0001ou-Hk; Tue, 02 Jan 2024 07:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKdt9-0001oL-Tx
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 07:28:55 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKdt8-0005ar-06
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 07:28:55 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40d4a222818so43817545e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 04:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704198532; x=1704803332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EGWivcS99+wHRa2vbtr7B5dRD4LP8waN05N4XbedEWs=;
 b=qpZYR7vUHu4hR2nW04oXyygioP//vw/SmrW3UXtb/1DWepo6FXuggLJ1gRBVYPZxNf
 Da+eTK8ocelyXqm3W8mv4TtAJ6kQaWtbV8P/rKyhA32m4blMD6BXjaKhg5F2UiZ3MRIu
 LaFtBBLhs3Z1KgNu+e5wYnoD3im4ncPrtZM9PR3c12Pe56IqM3VlUQyLtcdQ2ZuDYvYq
 FLJQkNwjKbnq0cIkAVG/YKsvWk7tVpjD0fwZdhzi7mTE4vhyuun5ajjB3jcIWmKzlBXv
 ZPlWPt6Xmff4JUm+wSgtuiLvj7kXDL36U+cNTvzn/kTbSKx+aaPgF0UDqWUkjXvO5sGv
 /NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704198532; x=1704803332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EGWivcS99+wHRa2vbtr7B5dRD4LP8waN05N4XbedEWs=;
 b=Ds1ipe75EA+Oh+VyE5yhffD+0m4czyCEEuSp0//6aDqooolOpLpfOk02gNz7bZasnP
 EcHqYJDwlAlblZZB205laFC9LIQzuHbgifcvYm6Dc1vZqiS5ObuVOUtrACHeM+3K4eku
 o9H6j1sHomgWG+RVWBNoWzttJKr3um8y8GW2wy2tqkZy1ccTg2shajPL/ASHzvfJTJf6
 uOA7Gb81SkTLUw6dhAcgpoAAL9iCHn6CrKwl+eZZ9XgLB7qfK+dQP7UZHJo/RWnVGXQT
 vehmvs86dhWDyIVW2J04C4MGJ7PkOtA8GTiol4K52tzwTe376bBbM7Hnj1YUtPGbxU9Z
 OcSQ==
X-Gm-Message-State: AOJu0YyHDaVX4Voykl1G7kZP42LNWIjI9ZSMauxmzGPfN8j7CyhuTCqb
 7lNlQPB4r++MLRThQL574s/mH7vc8dmT2Q==
X-Google-Smtp-Source: AGHT+IEwpcTL0Csf+EWLMVI9iqmJ7YDfPSWV44S+4HHothwKYStghNbHwsGo0zDVddU+owpDPGqmRw==
X-Received: by 2002:a05:600c:5020:b0:40b:3322:2af6 with SMTP id
 n32-20020a05600c502000b0040b33222af6mr7727002wmr.5.1704198531712; 
 Tue, 02 Jan 2024 04:28:51 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 i2-20020a05600c354200b0040d5ac00dc6sm25464652wmq.8.2024.01.02.04.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 04:28:51 -0800 (PST)
Message-ID: <9293e63b-8032-4ea0-b516-9db6949fb607@linaro.org>
Date: Tue, 2 Jan 2024 13:28:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/arm: Prefer arm_feature() over
 object_property_find()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Radoslaw Biernacki
 <rad@semihalf.com>, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231214171447.44025-1-philmd@linaro.org>
 <CAFEAcA-Je+_tNCwiL_sQb-tDmCRJ2LWm5mAfuowtxbUBNEWQXQ@mail.gmail.com>
 <871qbkug24.fsf@pond.sub.org>
 <CAFEAcA9vEvOeTseaC27hz9RKe13zs_2oPGjK-bLs8VL1wQF2jw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9vEvOeTseaC27hz9RKe13zs_2oPGjK-bLs8VL1wQF2jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi,

On 18/12/23 10:48, Peter Maydell wrote:
> On Mon, 18 Dec 2023 at 07:26, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Thu, 14 Dec 2023 at 17:14, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> QOM properties are added on the ARM vCPU object when a
>>>> feature is present. Rather than checking the property
>>>> is present, check the feature.
>>>>
>>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> RFC: If there is no objection on this patch, I can split
>>>>       as a per-feature series if necessary.
>>>>
>>>> Based-on: <20231123143813.42632-1-philmd@linaro.org>
>>>>    "hw: Simplify accesses to CPUState::'start-powered-off' property"
>>>
>>> I'm not a super-fan of board-level code looking inside
>>> the QOM object with direct use of arm_feature() when
>>> it doesn't have to. What's wrong with asking whether
>>> the property exists before trying to set it?
>>
>> I'm not a fan of using QOM instead of the native C interface.
>>
>> The native C interface is CPUArmState method arm_feature().
> 
> But we don't in most of these cases really want to know "is this
> a CPU with feature foo?". What we're asking is "does this
> QOM property exist so it won't blow up if I set/get it?".

[More analysis on this topic.]

ARMV7M (hw/arm/armv7m.c) is an interesting QOM use case.

ARMV7M is a ARMCPU container, with few more things. (We have
more complex cases with containers of array of vCPUs, so this
single-vCPU case is a good start).

We'd like to apply properties on ARMV7M which get forwarded
to the embedded ARMCPU.
Usually we create the ARMCPU in armv7m_instance_init(), call
object_property_add_alias() to alias some ARMCPU to ARMV7M,
so these properties can be set externally before ARMV7M is
realized, being directly forwarded to the embedded ARMCPU [*].

The problem with ARMV7M is it the ARMCPU QOM type is variable,
so we don't know it in armv7m_instance_init() but only later
in armv7m_realize(), thus we can not call QOM _add_alias() to
alias them. One way to resolve this is to duplicate all possible
ARMCPU properties we want to set on ARMV7M, and set them in
armv7m_realize() after the ARMCPU is created and before it is
realized (the current implementation):

static void armv7m_realize(DeviceState *dev, Error **errp)
{
     ...
     s->cpu = ARM_CPU(object_new_with_props(s->cpu_type,
                                            OBJECT(s), "cpu",
                                            &err, NULL));
     ...

     if (object_property_find(OBJECT(s->cpu), "vfp")) {
         if (!object_property_set_bool(OBJECT(s->cpu), "vfp",
                                       s->vfp, errp)) {
             return;
         }
     }
     ...

     if (!qdev_realize(cpudev, NULL, errp)) {
         return;
     }
     ...
}

static Property armv7m_properties[] = {
     DEFINE_PROP_STRING("cpu-type", ARMv7MState, cpu_type),
     ...
     DEFINE_PROP_BOOL("vfp", ARMv7MState, vfp, true),
     ...
};

Note ARMV7M "vfp" is a /static/ QOM property, so can not be
unregistered if the ARMCPU doesn't expose it.

* If ARMCPU doesn't provide "vfp", ARMV7M properties introspection
   still shows 'vfp=true'.

* If ARMCPU doesn't provide "vfp", requesting 'vfp=true' on ARMV7M
   is silently ignored.

* If ARMCPU doesn't provide "vfp", even if we unregister ARMV7M "vfp"
   property in realize() for cleaner introspection, we can not check
   whether user requested an explicit value before realize().
   Possibly we could use a tri-state {unset/false/true} dynamic property
   to check that.

[*] object_property_add_alias() is a 1-1 static aliasing. In the
     case of cluster of objects we don't have API to do a 1-N static
     aliasing; the current way to do that is similar to dynamic
     properties setters iterating on the array (getter usually return
     the container property, ignoring the cluster values).

Regards,

Phil.

