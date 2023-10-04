Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 329987B782B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:53:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvjj-0002Mq-44; Wed, 04 Oct 2023 02:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnvjg-0002Mf-7q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnvjc-00016H-QS
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696402310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxkP5dnEyYaBS1oS1McLz6qxS6aE9UIJL//e2pHBYvM=;
 b=fFAa1RvVl2UCnZhv/2KuuXVGMxRtWrgtrALlLJRKSoymzrIphYrrycLES8bmnDD/EWILnx
 mS0zw2U/rt1UU8LlNyckKy98qSLmpOcpMJO2/o7b4G77vKab/PHY7dSFeGUAbvNRvqJl1j
 h2e8DioxBYj/mv7BU9V1cHkoKggOLPY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-3gmUFXdYPGKN2oIO1sD8mA-1; Wed, 04 Oct 2023 02:51:49 -0400
X-MC-Unique: 3gmUFXdYPGKN2oIO1sD8mA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-323334992fbso1327069f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696402306; x=1697007106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxkP5dnEyYaBS1oS1McLz6qxS6aE9UIJL//e2pHBYvM=;
 b=EgSDBcP6fEPCsScmesL+5t2pOr6ZeKSd8ynn+tBodkmkTvAFgBZguRkcWyKWWnxBFo
 bhQI8bdF1mozaBKgbpEk7qDlMzq8ORJJYkvTg2A3MGStndP/29+QBu1pMfC6EQ3YWUW3
 y7Snyel546s/h5f8GSi5G/vLn7wDg3EqHT0cxMej1WGRDxEaKBZAFlCsE+2PK4sGzQzW
 ozD5hAQaZ0C++a62PbNUV61zWtGEDY9DfJZQ1GEvZOnyuYS+br+rpklJ/RdRS97Q7phq
 NKakCIgyJJGhrDZw1/ybqMqNXTBpZLx3h+UjU4FX3fknGvxegQyrC/1PBvEjSrv53gIl
 AjOg==
X-Gm-Message-State: AOJu0Yze+mduL6oS5h9iklkJ5ytzQpegife7QVjRci+Lus1GbxcHfstj
 t5MTIDxel2hSQ3egZCzvvKG6aEH739x0L6NEGkzRFLWg3h3DMpqaN30GeI+YUEW9S9zUtdd71I+
 bEooiXCuedXe9sIQdo0NtoAs=
X-Received: by 2002:adf:fdd0:0:b0:31f:d7bb:481e with SMTP id
 i16-20020adffdd0000000b0031fd7bb481emr1418871wrs.63.1696402306607; 
 Tue, 03 Oct 2023 23:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0IR34G9EhXQCoewEUfHNQhzZSPb7xlzjAOmSLYggFSaDuh9OcC7ztMbpn2jrQbJ5jaEjR0g==
X-Received: by 2002:adf:fdd0:0:b0:31f:d7bb:481e with SMTP id
 i16-20020adffdd0000000b0031fd7bb481emr1418848wrs.63.1696402306276; 
 Tue, 03 Oct 2023 23:51:46 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 u4-20020adfed44000000b003197c7d08ddsm3237274wro.71.2023.10.03.23.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 23:51:45 -0700 (PDT)
Date: Wed, 4 Oct 2023 02:51:40 -0400
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
Message-ID: <20231004025051-mutt-send-email-mst@kernel.org>
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
 <1e402165-24bd-7380-a5a7-c32fe33e457d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e402165-24bd-7380-a5a7-c32fe33e457d@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 26, 2023 at 11:23:53PM +0700, Bui Quang Minh wrote:
> On 9/26/23 23:06, Bui Quang Minh wrote:
> 
> > Version 8 changes,
> > - Patch 2, 4:
> >    + Rebase to master and resolve conflicts in these 2 patches
> 
> The conflicts when rebasing is due to the commit 9926cf34de5fa15da
> ("target/i386: Allow elision of kvm_enable_x2apic()"). AFAIK, this commit
> adds kvm_enabled() before kvm_enable_x2apic() in the and (&&) expression so
> that when kvm_enabled() is known to be false at the compile time
> (CONFIG_KVM_IS_POSSIBLE is undefined), the compiler can omit the
> kvm_enable_x2apic() in the and expression.
> 
> In patch 2, I simply combine the change logic in patch 2 with logic in the
> commit 9926cf34de5fa15da.
> 
> In patch 4, the end result of version 8 is the same as version 7. I don't
> think we need to add the kvm_enabled() to make the expression become
> 
> 	if (kvm_enabled() && kvm_irqchip_is_split() && !kvm_enable_x2apic())
> 
> Because when CONFIG_KVM_IS_POSSIBLE is undefined, kvm_irqchip_is_split() is
> known to be false at the compile time too so just keep the expression as
> 
> 	if (kvm_irqchip_is_split() && !kvm_enable_x2apic())
> 
> is enough.
> 
> > git range-diff feat/tcg-x2apic-v7~5..feat/tcg-x2apic-v7
> feat/tcg-x2apic-v8~5..feat/tcg-x2apic-v8
> 
> 1:  c1d197a230 = 1:  f6e3918e0f i386/tcg: implement x2APIC registers MSR
> access
> 2:  dd96cb0238 ! 2:  54d44a15b6 apic: add support for x2APIC mode
>     @@ Commit message
> 
>       ## hw/i386/x86.c ##
>      @@ hw/i386/x86.c: void x86_cpus_init(X86MachineState *x86ms, int
> default_cpu_version)
>     -      * Can we support APIC ID 255 or higher?
>     -      *
>     -      * Under Xen: yes.
>     --     * With userspace emulated lapic: no
>     -+     * With userspace emulated lapic: checked later in
> apic_common_set_id.
>     -      * With KVM's in-kernel lapic: only if X2APIC API is enabled.
>     +      * both in-kernel lapic and X2APIC userspace API.
>            */
>     -     if (x86ms->apic_id_limit > 255 && !xen_enabled() &&
>     +     if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
>      -        (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
>      +        kvm_irqchip_in_kernel() && !kvm_enable_x2apic()) {
>               error_report("current -smp configuration requires kernel "
> 3:  31a5c555a6 = 3:  eb080d1e2c apic, i386/tcg: add x2apic transitions
> 4:  d78b5c43b4 ! 4:  59f028f119 intel_iommu: allow Extended Interrupt Mode
> when using userspace APIC
>     @@ hw/i386/intel_iommu.c: static bool vtd_decide_config(IntelIOMMUState
> *s, Error *
>      -            error_setg(errp, "eim=on requires
> accel=kvm,kernel-irqchip=split");
>      -            return false;
>      -        }
>     --        if (!kvm_enable_x2apic()) {
>     +-        if (kvm_enabled() && !kvm_enable_x2apic()) {
>      +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
>                   error_setg(errp, "eim=on requires support on the KVM side"
>                                    "(X2APIC_API, first shipped in v4.7)");
> 5:  51f558035d = 5:  bc95c3cb60 amd_iommu: report x2APIC support to the
> operating system
> 
> As the change is minor and does not change the main logic, I keep the
> Reviewed-by and Acked-by tags.
> 
> Thank you,
> Quang Minh.



Causes some build failures:

https://gitlab.com/mstredhat/qemu/-/jobs/5216377483
/builds/mstredhat/qemu/build/../hw/intc/apic.c:1023: undefined reference to `raise_exception_ra'

checkpatch warnings:
https://gitlab.com/mstredhat/qemu/-/jobs/5216377552



