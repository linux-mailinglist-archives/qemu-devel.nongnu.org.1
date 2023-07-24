Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 019EA75FA6E
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 17:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNx8a-0003cT-Hz; Mon, 24 Jul 2023 11:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qNx8Y-0003by-Fg
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qNx8W-0005aY-Nr
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690211171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aY9jhpwiHiBD+p7mtwx8QiCihGSJ9Cs70/OZB0clfE0=;
 b=WxAU33d5EQ73ZDhL1ui5hWp0nbpFHZKLgnJf2LuhxDNCx/SkE9OmNd8jfqUxYOVI0vzYnm
 z0Eej4P0vBD5GD6T953rXGnm0uGtIumetdx5+jDnjUAbDBYL3OBr1OmzarQRT3QJK06y4V
 GiAyX6oiOvYeBeRMr6aqjAx0KQeHE0A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-8WlnDt8CP0mmSlAmiKAHDQ-1; Mon, 24 Jul 2023 11:06:09 -0400
X-MC-Unique: 8WlnDt8CP0mmSlAmiKAHDQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3144bf68a03so2119281f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690211166; x=1690815966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aY9jhpwiHiBD+p7mtwx8QiCihGSJ9Cs70/OZB0clfE0=;
 b=OSFjZrPZKJbq4Z+PYVLtaTgf4HZfGVl4pxrCgreji8yvxQgYncj4GdtmCn05Q8V3BI
 EFiGuX46R3OS6RBOnpzK4U45LCCrFypT8Y4IBa3V+tsc9jdWWd8wUxA9/pMgxMy1sP+e
 mq77HEtXL468EO6RtK4MBTKl87cWRZyE+Guia7CyPlVZPO872AXUkJFwevTcXiPikdSL
 jf3rzHDwPev9xqCZ7mAl3p9DWSzkL5m6D/jbhwWXjhFtF9c429E+qzH+JhoRvLGLFety
 EcVps7eBtJmjOugLmRp/KYhrBY7Koc/xQ0Qhc0eGesJPZo/1LSq7jSBx9zjCixpAq8Hd
 ZqwA==
X-Gm-Message-State: ABy/qLbeIL0tWW+aHF3v5sKCwW8/S2sZNcLQrpc2XHst2ha03cc38/ge
 Il6LTlF6c/fSRnQQMC4qH+lujY0SANqD1o+4uPxNGwAbhabudCloT//HX9e9DoNkmWJPEef0Ipc
 11Onz9ncjd+CdpxU=
X-Received: by 2002:a05:6000:1b90:b0:306:46c4:d313 with SMTP id
 r16-20020a0560001b9000b0030646c4d313mr204199wru.28.1690211166477; 
 Mon, 24 Jul 2023 08:06:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGXQEWMhnY7v3BToy9YYg+gcDWot4lDgkc75Mvmy0vXeXyiJVcPxeKPQlJCACcgzPsqcIH7XQ==
X-Received: by 2002:a05:6000:1b90:b0:306:46c4:d313 with SMTP id
 r16-20020a0560001b9000b0030646c4d313mr204184wru.28.1690211166013; 
 Mon, 24 Jul 2023 08:06:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 j9-20020a5d4529000000b0030fd03e3d25sm13195886wra.75.2023.07.24.08.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 08:06:05 -0700 (PDT)
Date: Mon, 24 Jul 2023 17:06:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Message-ID: <20230724170604.74b4ca0a@imammedo.users.ipa.redhat.com>
In-Reply-To: <527ed3dc-b723-5c37-37e2-58d4266b1f32@redhat.com>
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
 <CAFEAcA-XK0U0bPuAf4K7avdJqnmcibFX_swY1Weo_Tn3wHJ1fw@mail.gmail.com>
 <20230714135004.230c05b2@imammedo.users.ipa.redhat.com>
 <CAFEAcA92QFxN0at+5rk7yrfk1sj3tX-GcfZYYY5_=210np_j4g@mail.gmail.com>
 <20230717144455.6f02fde9@imammedo.users.ipa.redhat.com>
 <527ed3dc-b723-5c37-37e2-58d4266b1f32@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 18 Jul 2023 20:31:39 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Igor,
> 
> On 7/17/23 22:44, Igor Mammedov wrote:
> > On Fri, 14 Jul 2023 13:56:00 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >   
> >> On Fri, 14 Jul 2023 at 12:50, Igor Mammedov <imammedo@redhat.com> wrote:  
> >>>
> >>> On Thu, 13 Jul 2023 12:59:55 +0100
> >>> Peter Maydell <peter.maydell@linaro.org> wrote:
> >>>     
> >>>> On Thu, 13 Jul 2023 at 12:52, Marcin Juszkiewicz
> >>>> <marcin.juszkiewicz@linaro.org> wrote:  
> >>>>>
> >>>>> W dniu 13.07.2023 o 13:44, Peter Maydell pisze:
> >>>>>     
> >>>>>> I see this isn't a change in this patch, but given that
> >>>>>> what the user specifies is not "cortex-a8-arm-cpu" but
> >>>>>> "cortex-a8", why do we include the "-arm-cpu" suffix in
> >>>>>> the error messages? It's not valid syntax to say
> >>>>>> "-cpu cortex-a8-arm-cpu", so it's a bit misleading...  
> >>>>>
> >>>>> Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for
> >>>>> other architectures.  
> >>>>
> >>>> Yes; my question is "why are we not using the user-facing
> >>>> string rather than the internal type name?".  
> >>>
> >>> With other targets full CPU type name can also be valid
> >>> user-facing string. Namely we use it with -device/device_add
> >>> interface. Considering we would like to have CPU hotplug
> >>> on ARM as well, we shouldn't not outlaw full type name.
> >>> (QMP/monitor interface also mostly uses full type names)  
> >>
> >> You don't seem to be able to use the full type name on
> >> x86-64 either:
> >>
> >> $ ./build/all/qemu-system-x86_64 -cpu pentium-x86_64-cpu
> >> qemu-system-x86_64: unable to find CPU model 'pentium-x86_64-cpu'  
> > 
> > that's because it also tied into old cpu_model resolving
> > routines, and I haven't added typename lookup the last
> > time I've touched it (it was out of topic change anyway).
> > 
> > but some targets do recognize typename, while some
> > do a lot more juggling with cpu_model (alpha/ppc),
> > and yet another class (garbage in => cpu type out).
> > 
> > With the last one we could just error,
> > while with alpha/ppc we could dumb it down to typenames
> > only.
> >   
> 
> Your summary here is correct to me. However, I don't quiet understand
> the issue you're trying to resolve. As you mentioned, there are two
> cases where the users need to specify CPU typename: (1) In the command
> lines to start VM; (2) When CPU is hot added.
> 
> For (1), the list of all available CPU is provided by each individual
> target. It's to say, each individual target is responsible for correlating
> the name (typename, CPU model name, or whatever else). Each individual
> target has its own rules for this correlation. Why do we bother to unify
> the rules so that only the typename is allowed?

I've seen others asking why you print type name instead of shorter cpu-model
used on CLI. To do that would make you write a patch to implement reverse mapping.
In some cases it's simple, in others plain impossible unless you can get
access to -cpu foo stored somewhere.

What I don't particularity like about adding reverse type->cpu_model mapping,
is that it would complicate code to carter to QEMU's interface inconsistencies.
And if you do it easy way (instead of fixing every target) touching only ARM,
it will be spotty at best and just add to technical debt elsewhere ->
more inconsistencies.

What I'm proposing is for you to keep printing type names.
So if others won't object to type names I'm more or less fine with your
current approach.

Instead of adding type->cpu_model mapping (it's not the first time
this particular question had arisen - there were similar patches before
on qemu-devel), get rid of shortened cpu_model in user interface (-cpu)
altogether and use CPU type name there.
Beside making UI consistent across QEMU it will also simplify
QEMU codebase (cpu-model -> type resolving machinery + all legacy junk
that was accumulated for years QEMU has existed).

>    // The output can be directly used in the command lines to start VM.
>    // I don't see any problems we have. Note that the list of available
>    // CPU names is printed by cpu_list(), which is a target specific
>    // implementation.
>    //
>    # aarch64-softmmu/qemu-system-aarch64 -cpu help
>    Available CPUs:
>      a64fx
>      arm1026
>      arm1136
>      arm1136-r2
>      arm1176
>      arm11mpcore
>      arm926
>      arm946
>      cortex-a15
>      cortex-a35
>      cortex-a53
> 
> For (2) where CPU is hot added, the help option can also be used to dump
> the available CPUs. Nothing went to wrong as I can see. The rule used here
> to correlate names with CPUs is global: typename <-> CPU
> 
>    //
>    // The printed CPU typenames can be taken as the driver directly
>    //
>    (qemu) device_add driver=?
>       :
>    CPU devices:
>    name "a64fx-arm-cpu"
>    name "cortex-a35-arm-cpu"
>    name "cortex-a53-arm-cpu"
>    name "cortex-a55-arm-cpu"
>    name "cortex-a57-arm-cpu"
>    name "cortex-a72-arm-cpu"
>    name "cortex-a76-arm-cpu"
>    name "max-arm-cpu"
>    name "neoverse-n1-arm-cpu"
> 
> >> and '-cpu help' does not list them with the suffix.  
> > 
> > both above points are fixable,
> > 
> > I can prepare PoC patches for that if there is
> > no opposition to the idea.
> >   
> 
> Please refer to above for the argument. If I'm correct, there is nothing
> to be resolved or improved.
> 
> >>> Instead it might be better to consolidate on what has
> >>> been done on making CPU '-device' compatible and
> >>> allow to use full CPU type name with '-cpu' on arm machines.
> >>>
> >>> Then later call suffix-less legacy => deprecate/drop it from
> >>> user-facing side including cleanup of all the infra we've
> >>> invented to keep mapping between cpu_model and typename.  
> >>
> >> This seems to me like a worsening of the user interface,
> >> and in practice there is not much likelihood of being
> >> able to deprecate-and-drop the nicer user-facing names,
> >> because they are baked into so many command lines and
> >> scripts.  
> > Nice names are subjective point, I suspect in a long run
> > once users switched to using longer names, they won't care much
> > about that either.
> > 
> > Also it's arguable if it is worsening UI or not.
> > I see using consolidated typenames across the board (incl. UI)
> > as a positive development.
> > 
> > As for scripts/CLI users out there, yes it would be disruptive
> > for a while but one can adapt to new naming (or use a wrapper
> > around QEMU that does suffix adding/model mapping as a crutch).
> > 
> > It weren't possible to drop anything before we introduced
> > deprecation process, but with it we can do it.
> >   
> 
> Thanks,
> Gavin
> 


