Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D1D783611
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 01:02:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYDtR-0002vI-MS; Mon, 21 Aug 2023 19:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qYDtO-0002uo-7Q
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 19:01:02 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qYDtL-0006HL-BG
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 19:01:01 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-56a9c951aaaso976182a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692658857; x=1693263657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Klij9wv5DPga//TKbsnaBDvfDfkb7jucsR0dMXHv8YQ=;
 b=s5Lr2ep7iAKN7KmGI1/v5pG4Fy5SbsntwOSZqJY7MHXxB04MlnLd/Dc4viOVbX6HKt
 rh4vXMaIp3VwS4ETG3pVWewzCfqSaxZl1wt5NA9vbuST4U+MFPIr7iheAoW+/o+GAgTK
 9Y2oK50suHEUb64boUuFKgjJBsFoFzrfmF4pw9flPdDqIoEhv4eCyNPAZvHwjzlGRmzY
 X661l9f6GhvmlkU1UAz+kPEnqe2+gGJAALMhHgMN8DKLBkmmMilGYbvewvdTgHlC/VxL
 RU5YyJhET/KfxUS3CFgiH7aMR2g4LFe583XYupalNuQiv/rk0aQ92ziQtsCONwRYoUq1
 8Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692658857; x=1693263657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Klij9wv5DPga//TKbsnaBDvfDfkb7jucsR0dMXHv8YQ=;
 b=VsqCRM+wpw+6uYJ9yNrGx3BJZOYsPWlAP+DnOcg6Cv4QZK77tbO1jtjkcKFaDPtBb8
 tKiR/EsgE4yyrxZ8p5oWI2wi1OY7XaYYPsKXIkr6ysEHl1N/J2LyILPLpH7K5nJAYmLB
 e5bwbSU+3Pwd+wPnmHXRD8/VxRGpN/c8NhT7JPUHbBQ7VoMOs1J4mY+5UcwY3J3wVTW+
 wYrSjmkTMfZpHqQY/J6yQ7a42z/l3cmec8Z9dMaGVk6H+93/48Aq8lXcWVDG3LDLQBeq
 WQPxu+nlI6LTrKHPMWgmDRtiVqwG1g9VyvQkqnHqW2SfV//WzHpZ/c16jl0MAd9H/yw0
 nPnw==
X-Gm-Message-State: AOJu0Yz+kGbgtDtRzrCjFTkL9go1BTBvjhrTtoBN4MZO+nQ4mP1eYr40
 lqX3zlHbdA+F4X9i4HicJ/k=
X-Google-Smtp-Source: AGHT+IHv/GegNd8oLQThewA7cqV9YChRmbTzNOQyZgtTBoOJOXZJqPenMjxk1PJgmY8inKr8cDR9nw==
X-Received: by 2002:a05:6a20:4417:b0:140:54ab:7f43 with SMTP id
 ce23-20020a056a20441700b0014054ab7f43mr7284618pzb.52.1692658857456; 
 Mon, 21 Aug 2023 16:00:57 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 a9-20020a62bd09000000b0068844ee18dfsm6584873pff.83.2023.08.21.16.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 16:00:56 -0700 (PDT)
Date: Mon, 21 Aug 2023 16:00:54 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 08/58] i386/tdx: Adjust the supported CPUID based on
 TDX restrictions
Message-ID: <20230821230054.GB3642077@ls.amr.corp.intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-9-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818095041.1973309-9-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Aug 18, 2023 at 05:49:51AM -0400,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 56cb826f6125..3198bc9fd5fb 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
...
> +static inline uint32_t host_cpuid_reg(uint32_t function,
> +                                      uint32_t index, int reg)
> +{
> +    uint32_t eax, ebx, ecx, edx;
> +    uint32_t ret = 0;
> +
> +    host_cpuid(function, index, &eax, &ebx, &ecx, &edx);
> +
> +    switch (reg) {
> +    case R_EAX:
> +        ret |= eax;
> +        break;
> +    case R_EBX:
> +        ret |= ebx;
> +        break;
> +    case R_ECX:
> +        ret |= ecx;
> +        break;
> +    case R_EDX:
> +        ret |= edx;

Nitpick: "|" isn't needed as we initialize ret = 0 above. Just '='.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

