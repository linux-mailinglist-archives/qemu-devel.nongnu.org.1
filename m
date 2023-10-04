Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3529E7B861A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5K1-0000RV-3n; Wed, 04 Oct 2023 13:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qo5Jv-0000Om-Ma
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qo5Js-0007UE-QI
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696439155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6srQVg+1gkrmZzR2+/abUIQ/r4tcRZ2ZZAfGa9x+6X0=;
 b=a5G4vnfDxwa6/nCROyq73yIOVSvUByrHBUJV8o+iTcYaviEpe9H8yVmcrUNV0HqQiRbytD
 FCn03i5a3PvYDqUNJna/6u/WuxG0LI1SReFzrUFbcfROJ95nUF7z5cH/Bf64TMHEd9JPFO
 PpfFhn7u7ceKhKN+x3TFvYm63g1Lo4k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-E-qzXEBCPn68eVhdh-2Nfw-1; Wed, 04 Oct 2023 13:05:54 -0400
X-MC-Unique: E-qzXEBCPn68eVhdh-2Nfw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b98bbf130cso3454866b.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696439152; x=1697043952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6srQVg+1gkrmZzR2+/abUIQ/r4tcRZ2ZZAfGa9x+6X0=;
 b=RxhpQp6i5pqf754PdjgSUFhp8H9atuHRV+ROkYx6eJU5XjHL0IgyVO0Aopg4XJZFYq
 HVtc7ajg9y4XrsyOknrsWbU03jqghqGjcB8km5cc2FZV7PJO8mxTLgSSm6ILnq94NABE
 KmEI1XaPard8/sRZTJefJDC2MVFvSsUpXFth4K2dJ0daOkDZEFA4sp9+0QMiawrvipa7
 L9EMVjWZGMkm9W6kA3bpZ7iuEXxk95U2K8FuB6kTrjNvxEJ9wAMYaTtYHD0McW0QbQUo
 BSbXo4PlIBxbLfOZA3fron8JFvLAOIAAIIgzzD1TCybdh1fV9pNQArFJRFcz1oHlv6EW
 lwaQ==
X-Gm-Message-State: AOJu0YxiaX1gzcJ/R33zejB2+yWOJ1ooQgibQIzNVMkPkTUHeu+OoxNv
 FzWiy2e+EpQKopX2HId2W7NZs9O0d1hWh+c8SgRBzHyqKOUB8IybSOJcIbLcTH7b7Ym1/yfaOGQ
 zwMEOf9JyX8xjuLc=
X-Received: by 2002:a17:906:2215:b0:9ae:4536:728e with SMTP id
 s21-20020a170906221500b009ae4536728emr2896479ejs.72.1696439152730; 
 Wed, 04 Oct 2023 10:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzqzwGhqB+/GtFgFcUOM0y47r5IotHMNAZc/wky/+qPLzXN2OFhIEGkhgXEwifiI+7TEIuGg==
X-Received: by 2002:a17:906:2215:b0:9ae:4536:728e with SMTP id
 s21-20020a170906221500b009ae4536728emr2896464ejs.72.1696439152354; 
 Wed, 04 Oct 2023 10:05:52 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a7bc450000000b0040536dcec17sm1965901wmi.27.2023.10.04.10.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 10:05:51 -0700 (PDT)
Date: Wed, 4 Oct 2023 13:05:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v8 0/5] Support x2APIC mode with TCG accelerator
Message-ID: <20231004130458-mutt-send-email-mst@kernel.org>
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
 <1e402165-24bd-7380-a5a7-c32fe33e457d@gmail.com>
 <20231004025051-mutt-send-email-mst@kernel.org>
 <d7e14546-96e0-4ee2-928e-bd4035f09b89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e14546-96e0-4ee2-928e-bd4035f09b89@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 04, 2023 at 11:40:43PM +0700, Bui Quang Minh wrote:
> On 10/4/23 13:51, Michael S. Tsirkin wrote:
> > On Tue, Sep 26, 2023 at 11:23:53PM +0700, Bui Quang Minh wrote:
> > > On 9/26/23 23:06, Bui Quang Minh wrote:
> > > 
> > > > Version 8 changes,
> > > > - Patch 2, 4:
> > > >     + Rebase to master and resolve conflicts in these 2 patches
> > > 
> > > The conflicts when rebasing is due to the commit 9926cf34de5fa15da
> > > ("target/i386: Allow elision of kvm_enable_x2apic()"). AFAIK, this commit
> > > adds kvm_enabled() before kvm_enable_x2apic() in the and (&&) expression so
> > > that when kvm_enabled() is known to be false at the compile time
> > > (CONFIG_KVM_IS_POSSIBLE is undefined), the compiler can omit the
> > > kvm_enable_x2apic() in the and expression.
> > > 
> > > In patch 2, I simply combine the change logic in patch 2 with logic in the
> > > commit 9926cf34de5fa15da.
> > > 
> > > In patch 4, the end result of version 8 is the same as version 7. I don't
> > > think we need to add the kvm_enabled() to make the expression become
> > > 
> > > 	if (kvm_enabled() && kvm_irqchip_is_split() && !kvm_enable_x2apic())
> > > 
> > > Because when CONFIG_KVM_IS_POSSIBLE is undefined, kvm_irqchip_is_split() is
> > > known to be false at the compile time too so just keep the expression as
> > > 
> > > 	if (kvm_irqchip_is_split() && !kvm_enable_x2apic())
> > > 
> > > is enough.
> > > 
> > > > git range-diff feat/tcg-x2apic-v7~5..feat/tcg-x2apic-v7
> > > feat/tcg-x2apic-v8~5..feat/tcg-x2apic-v8
> > > 
> > > 1:  c1d197a230 = 1:  f6e3918e0f i386/tcg: implement x2APIC registers MSR
> > > access
> > > 2:  dd96cb0238 ! 2:  54d44a15b6 apic: add support for x2APIC mode
> > >      @@ Commit message
> > > 
> > >        ## hw/i386/x86.c ##
> > >       @@ hw/i386/x86.c: void x86_cpus_init(X86MachineState *x86ms, int
> > > default_cpu_version)
> > >      -      * Can we support APIC ID 255 or higher?
> > >      -      *
> > >      -      * Under Xen: yes.
> > >      --     * With userspace emulated lapic: no
> > >      -+     * With userspace emulated lapic: checked later in
> > > apic_common_set_id.
> > >      -      * With KVM's in-kernel lapic: only if X2APIC API is enabled.
> > >      +      * both in-kernel lapic and X2APIC userspace API.
> > >             */
> > >      -     if (x86ms->apic_id_limit > 255 && !xen_enabled() &&
> > >      +     if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
> > >       -        (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
> > >       +        kvm_irqchip_in_kernel() && !kvm_enable_x2apic()) {
> > >                error_report("current -smp configuration requires kernel "
> > > 3:  31a5c555a6 = 3:  eb080d1e2c apic, i386/tcg: add x2apic transitions
> > > 4:  d78b5c43b4 ! 4:  59f028f119 intel_iommu: allow Extended Interrupt Mode
> > > when using userspace APIC
> > >      @@ hw/i386/intel_iommu.c: static bool vtd_decide_config(IntelIOMMUState
> > > *s, Error *
> > >       -            error_setg(errp, "eim=on requires
> > > accel=kvm,kernel-irqchip=split");
> > >       -            return false;
> > >       -        }
> > >      --        if (!kvm_enable_x2apic()) {
> > >      +-        if (kvm_enabled() && !kvm_enable_x2apic()) {
> > >       +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> > >                    error_setg(errp, "eim=on requires support on the KVM side"
> > >                                     "(X2APIC_API, first shipped in v4.7)");
> > > 5:  51f558035d = 5:  bc95c3cb60 amd_iommu: report x2APIC support to the
> > > operating system
> > > 
> > > As the change is minor and does not change the main logic, I keep the
> > > Reviewed-by and Acked-by tags.
> > > 
> > > Thank you,
> > > Quang Minh.
> > 
> > 
> > 
> > Causes some build failures:
> > 
> > https://gitlab.com/mstredhat/qemu/-/jobs/5216377483
> > /builds/mstredhat/qemu/build/../hw/intc/apic.c:1023: undefined reference to `raise_exception_ra'
> 
> raise_exception_ra is tcg specific so the builds are failed as tcg is
> disabled. I will remove the use of raise_exception_ra, the invalid register
> read just returns 0, invalid register write has no effect without raising
> the exception anymore. The APIC state invalid transition does not raise
> exception either, just don't change the APIC state. As a side effect, we
> fail some more KVM unit test of invalid APIC state transition, as they
> expect to catch exception in these cases. I think it's not a big problem.
> What's your opinion?
> 
> Thank you,
> Quang Minh.

Hmm.  I think this will have to be addressed somehow so people
and ci systems are not confused. Paolo any feedback?

-- 
MST


