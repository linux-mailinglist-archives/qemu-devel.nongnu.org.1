Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 889F47EC20B
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 13:19:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3EqP-0006Hf-As; Wed, 15 Nov 2023 07:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1r3EqN-0006H5-4e
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 07:18:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1r3EqL-0005kl-Eq
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 07:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700050683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uFSmPmJ9qLXHCirLCU1lG0SIBq8FZeGtn+2R0siKIYo=;
 b=APpOpNefzoOstu5thSpn4QVyCcWbEIZroa1e2NCWAmc3zbWGfAPvkTVsDBrEhcuKM8WRZy
 42wgmMkQc+V0uZ6f+dLAZT6H/plnZ/IfP4guGkaegAosevfuYojKwD2FxvO/sC+5iisrTg
 OmgzsbG2jD3N4Rr4R52fD4zKlAltT1Q=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-aMcRmBKBNGWwAxR7qKANwQ-1; Wed, 15 Nov 2023 07:18:02 -0500
X-MC-Unique: aMcRmBKBNGWwAxR7qKANwQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6ce27d056ceso6210766a34.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 04:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700050681; x=1700655481;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uFSmPmJ9qLXHCirLCU1lG0SIBq8FZeGtn+2R0siKIYo=;
 b=RJMm1i8/GomPw6cFkWMRVYCanqSmljtxTHb7jDm/6BUH+2hfzz0KF9VqejkvD/FA4A
 4DtekDJCVnUDnPl5TNxBNN1W/VdXzIW3QFKtiizNRKUzOgNp8pmEmFk8MMlp8JjMwSNQ
 Nqdr0S9Y6HPlYfHbDosjHyFGkze6ipTbmwiciRUQlScC3xmBtBiDNA6N9jRwJ3GzvVpW
 8/c8ymxM0bMIzjVCFz/zd1WemtA3JHSqaCr9fiRfbojfdAc3FMuSHa5rq5PIfDzecFB6
 qp0YX0w1A8l5KkHUR/tWtKcYdKmp61rVfQFDtIvqin5IW82So3mXoMu3yX3BekQM+QFu
 19KQ==
X-Gm-Message-State: AOJu0YwMLfwuhUUaLgo5GJdJ0q3hN1ySmhpkha/0i9QfSCG0nNPTLAia
 +sHZQ8KTwCFIhnkFYFRVU/D9dvuJf44fG01XH06MVLz9Avg8058oz04nydpojnl5cOwtWcHwkhc
 LsRsCgAgzM8AVuf8=
X-Received: by 2002:a05:6830:348c:b0:6c6:5053:66dc with SMTP id
 c12-20020a056830348c00b006c6505366dcmr5271622otu.21.1700050681748; 
 Wed, 15 Nov 2023 04:18:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuteN+jkOs7Pk0h51R2XIAQA3l6e/ETSzK83KjygEg4ZKVNMaP0v6d/pJRWFe9lG1nPw9YZg==
X-Received: by 2002:a05:6830:348c:b0:6c6:5053:66dc with SMTP id
 c12-20020a056830348c00b006c6505366dcmr5271611otu.21.1700050681510; 
 Wed, 15 Nov 2023 04:18:01 -0800 (PST)
Received: from rh (p200300c93f306f0016d68197cd5f6027.dip0.t-ipconnect.de.
 [2003:c9:3f30:6f00:16d6:8197:cd5f:6027])
 by smtp.gmail.com with ESMTPSA id
 dw15-20020a0562140a0f00b0067079ecca05sm489704qvb.108.2023.11.15.04.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 04:18:01 -0800 (PST)
Date: Wed, 15 Nov 2023 13:17:56 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
cc: qemu-arm@nongnu.org, eric.auger@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
In-Reply-To: <20231113081713.153615-1-shahuang@redhat.com>
Message-ID: <3a570842-aaec-6447-b043-d908e83717ec@redhat.com>
References: <20231113081713.153615-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, 13 Nov 2023, Shaoqin Huang wrote:
> +    ``pmu-filter={A,D}:start-end[;...]``
> +        KVM implements pmu event filtering to prevent a guest from being able to
> +	sample certain events. It has the following format:
> +
> +	pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
> +
> +	The A means "allow" and D means "deny", start if the first event of the
                                                       ^
                                                       is

Also it should be stated that the first filter action defines if the whole
list is an allow or a deny list.

> +static void kvm_arm_pmu_filter_init(CPUState *cs)
> +{
> +    struct kvm_pmu_event_filter filter;
> +    struct kvm_device_attr attr = {
> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
> +    };
> +    KVMState *kvm_state = cs->kvm_state;
> +    char *tmp;
> +    char *str, act;
> +
> +    if (!kvm_state->kvm_pmu_filter)
> +        return;
> +
> +    tmp = g_strdup(kvm_state->kvm_pmu_filter);
> +
> +    for (str = strtok(tmp, ";"); str != NULL; str = strtok(NULL, ";")) {
> +        unsigned short start = 0, end = 0;
> +
> +        sscanf(str, "%c:%hx-%hx", &act, &start, &end);
> +        if ((act != 'A' && act != 'D') || (!start && !end)) {
> +            error_report("skipping invalid filter %s\n", str);
> +            continue;
> +        }
> +
> +        filter = (struct kvm_pmu_event_filter) {
> +            .base_event     = start,
> +            .nevents        = end - start + 1,
> +            .action         = act == 'A' ? KVM_PMU_EVENT_ALLOW :
> +                                           KVM_PMU_EVENT_DENY,
> +        };
> +
> +        attr.addr = (uint64_t)&filter;

That could move to the initialization of attr (the address of filter
doesn't change).

> +        if (!kvm_arm_set_device_attr(cs, &attr, "PMU Event Filter")) {
> +            error_report("Failed to init PMU Event Filter\n");
> +            abort();
> +        }
> +    }
> +
> +    g_free(tmp);
> +}
> +
> void kvm_arm_pmu_init(CPUState *cs)
> {
>     struct kvm_device_attr attr = {
>         .group = KVM_ARM_VCPU_PMU_V3_CTRL,
>         .attr = KVM_ARM_VCPU_PMU_V3_INIT,
>     };
> +    static bool pmu_filter_init = false;
>
>     if (!ARM_CPU(cs)->has_pmu) {
>         return;
>     }
> +    if (!pmu_filter_init) {
> +        kvm_arm_pmu_filter_init(cs);
> +        pmu_filter_init = true;

pmu_filter_init could move inside kvm_arm_pmu_filter_init() - maybe
together with a comment that this only needs to be called for 1 vcpu.

Thanks,
Sebastian


