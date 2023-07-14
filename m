Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 048DD753B5A
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKILM-0002bh-TK; Fri, 14 Jul 2023 08:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKILI-0002au-MR
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:56:16 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKILG-000773-Nu
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:56:16 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fb761efa7aso3136997e87.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689339372; x=1691931372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzPAS+JpxoI5nrbnmh94HbU/MkQCQUh9XpTOg5be4Lc=;
 b=Atk10F0aTIXdQVYmh/s5qzbPVhpOpXX0sBwrjZGEHoQ9r+CuwDvbod6abr5TUTUAZM
 sQUXiNgSLZx/+sS1idTW1oZTlu2FVtKreksYJhePeK8Nuwcj2t02zE/+az3XC2IL25bu
 SC5fcO2lVLQ5YpCtxUKHpvgaaddjCGhFVsZmfJSkA6M2daoghh6WqQDiESnoe66dtXlM
 EHhWNH1iHgenEHvRoaD4fLSMNUKjE1VZPPHOZ2HJsdXBl/sua+Nn9valvTJceFMPsbvq
 nKtbMQJ1a8pPpRdteiUgGWBG1ncQpk/vHcVr5JCtqm3zxoyBbq/9/jh+sM2g7tBCWoBj
 xT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689339372; x=1691931372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZzPAS+JpxoI5nrbnmh94HbU/MkQCQUh9XpTOg5be4Lc=;
 b=KEkVUrUS62DMUJa16FqneQGldihTvqlqa5sZa4gQDfosRnnv+FZmQazJ10bKrprOlv
 eXtL3mjUcteVgYW/E/rrpFhonfmls1ubUYTR8csvRuJAQM2SSrwxMO4ixxe4WsZ4DYMz
 LBwJu3e12t5bxz7CZLeRNaOJkGxV6TEBU6vvs686DddxktW0ljQkPLwKwQU5OLhqhaBN
 8RLb35/3vmrqkhbRF98NtC4R/BvQcfQmqa7EgY2yru9pY0SjZWRaJzHePmDuyX6tPRLB
 wgSGGlUKmQ/cJ2Xn3K62ZlJB5mtgksMdW4b2ejNItvKqqke6TnsK7Wzf4Je2bNJvVK7p
 UwnA==
X-Gm-Message-State: ABy/qLapwfOvZBb+m+zMskd0eIA2She4F5zBtT7W7myF5QGYe2ONpPBy
 QyAiQWkUzoo11ONMB9/rt2VkihFl8jMnDEbM16glRA==
X-Google-Smtp-Source: APBJJlHLjn+MrJk51KUg1BnyNP//SlqfJSkEDiKYJ351h0OcwplcI2eB5W/Xsu6iSHj5vSF+o6RJQxxdbsfS/J3xZMg=
X-Received: by 2002:a05:6512:2083:b0:4f9:571d:c50e with SMTP id
 t3-20020a056512208300b004f9571dc50emr3204963lfr.36.1689339371694; Fri, 14 Jul
 2023 05:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
 <CAFEAcA-XK0U0bPuAf4K7avdJqnmcibFX_swY1Weo_Tn3wHJ1fw@mail.gmail.com>
 <20230714135004.230c05b2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230714135004.230c05b2@imammedo.users.ipa.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2023 13:56:00 +0100
Message-ID: <CAFEAcA92QFxN0at+5rk7yrfk1sj3tX-GcfZYYY5_=210np_j4g@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
To: Igor Mammedov <imammedo@redhat.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Fri, 14 Jul 2023 at 12:50, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 13 Jul 2023 12:59:55 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Thu, 13 Jul 2023 at 12:52, Marcin Juszkiewicz
> > <marcin.juszkiewicz@linaro.org> wrote:
> > >
> > > W dniu 13.07.2023 o 13:44, Peter Maydell pisze:
> > >
> > > > I see this isn't a change in this patch, but given that
> > > > what the user specifies is not "cortex-a8-arm-cpu" but
> > > > "cortex-a8", why do we include the "-arm-cpu" suffix in
> > > > the error messages? It's not valid syntax to say
> > > > "-cpu cortex-a8-arm-cpu", so it's a bit misleading...
> > >
> > > Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for
> > > other architectures.
> >
> > Yes; my question is "why are we not using the user-facing
> > string rather than the internal type name?".
>
> With other targets full CPU type name can also be valid
> user-facing string. Namely we use it with -device/device_add
> interface. Considering we would like to have CPU hotplug
> on ARM as well, we shouldn't not outlaw full type name.
> (QMP/monitor interface also mostly uses full type names)

You don't seem to be able to use the full type name on
x86-64 either:

$ ./build/all/qemu-system-x86_64 -cpu pentium-x86_64-cpu
qemu-system-x86_64: unable to find CPU model 'pentium-x86_64-cpu'

and '-cpu help' does not list them with the suffix.

> Instead it might be better to consolidate on what has
> been done on making CPU '-device' compatible and
> allow to use full CPU type name with '-cpu' on arm machines.
>
> Then later call suffix-less legacy => deprecate/drop it from
> user-facing side including cleanup of all the infra we've
> invented to keep mapping between cpu_model and typename.

This seems to me like a worsening of the user interface,
and in practice there is not much likelihood of being
able to deprecate-and-drop the nicer user-facing names,
because they are baked into so many command lines and
scripts.

thanks
-- PMM

