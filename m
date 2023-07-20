Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA9C75B8E4
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 22:48:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMaYe-0000Vx-FY; Thu, 20 Jul 2023 16:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qMaYc-0000Vo-B6
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qMaYa-0000kh-Ey
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689886047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdNbtCqm0c6tAZ8t2d7PHUgXt48WYWbcLtX4qTAfcDY=;
 b=dKjsXdHye3sou8exaSRM/PEXf0fdbrKMdwYkHQY9MUZPJ321IiwDp83z55L8xUh1AArMED
 JOD1YeNfy6YtCtpZNIvL8zNqmw0UKmsRXuAezNngewzKPXQ4HrP6Gb8iK8ga2Du1j4+t8K
 e4twB3r6qowg6QPVxnAlee3abUpu+pQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-Oz_CaT9RNPeU6jizcEzIiQ-1; Thu, 20 Jul 2023 16:47:25 -0400
X-MC-Unique: Oz_CaT9RNPeU6jizcEzIiQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-403a1b0e259so3014711cf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 13:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689886045; x=1690490845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdNbtCqm0c6tAZ8t2d7PHUgXt48WYWbcLtX4qTAfcDY=;
 b=SrREyg+xeePukYtpbzs3AdeDvWbqtrO8JwdXPTjCY8osbJTOHj6h2UipzBnDfC/Crw
 BEVeUgEns2CnGDCh08PMai4PDkmXfbPid26zOOGhLSLmDEDNJbhhrhpsJ6ghCaPFD3pU
 VdCFXtYWKcaQ5PZMwaduZq83AjKkRcqvr5IIj0T7SeQHMaqYL2wivs33M6+2LzsO95+u
 1JKm02VxmPRTryp6LqZyd7WgErjcNDbOr/YlyrnavzdlX3p9xr1UFzHlO9o0ByG2zs7q
 BFNTdf0uBJHZEW4/Vsxw4O7qKyhgf9AcDyJR0yQ2OBmtIj+dw+UYNhvqvuhWH4f5qVPg
 sAMg==
X-Gm-Message-State: ABy/qLZv/ezxfj1CspLH1tP3I1slrGke7iTdrqdYO6chDqE43CwTvQdc
 HmTQJP/9TDi3W+HZ5mpDJGqcrEQH/oILMN6Qn/UPX1GkmycCRTcEMNgqWenCjkUZY0yy+oarbja
 4Cy4JRHZPFNhy7qk=
X-Received: by 2002:a05:622a:5ca:b0:400:84a9:a09c with SMTP id
 d10-20020a05622a05ca00b0040084a9a09cmr155065qtb.6.1689886045158; 
 Thu, 20 Jul 2023 13:47:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGlt+S8xkBzCuZ5O0w+7etUJJbPkxoTPbUd6ZCCgHPiQ14hJNYU+PsPI15jZYpTMyee2hm7Xg==
X-Received: by 2002:a05:622a:5ca:b0:400:84a9:a09c with SMTP id
 d10-20020a05622a05ca00b0040084a9a09cmr155023qtb.6.1689886044609; 
 Thu, 20 Jul 2023 13:47:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v18-20020ac873d2000000b004035b79860dsm686722qtp.81.2023.07.20.13.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 13:47:24 -0700 (PDT)
Date: Thu, 20 Jul 2023 16:47:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v6 4/5] intel_iommu: allow Extended Interrupt Mode when
 using userspace APIC
Message-ID: <ZLmdWv0YndpUe9iM@x1n>
References: <20230715152224.54757-1-minhquangbui99@gmail.com>
 <20230715152224.54757-5-minhquangbui99@gmail.com>
 <4f5a644e-8341-798a-bfe3-27eeb5816623@oracle.com>
 <adf436ea-8b4a-be24-4df4-7f018975b1e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adf436ea-8b4a-be24-4df4-7f018975b1e9@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jul 17, 2023 at 11:29:56PM +0700, Bui Quang Minh wrote:
> On 7/17/23 17:47, Joao Martins wrote:
> > +Peter, +Jason (intel-iommu maintainer/reviewer)

Thanks for copying me, Joan.

> > 
> > On 15/07/2023 16:22, Bui Quang Minh wrote:
> > > As userspace APIC now supports x2APIC, intel interrupt remapping
> > > hardware can be set to EIM mode when userspace local APIC is used.
> > > 
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > ---
> > >   hw/i386/intel_iommu.c | 11 -----------
> > >   1 file changed, 11 deletions(-)
> > > 
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index dcc334060c..5e576f6059 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -4043,17 +4043,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> > >                         && x86_iommu_ir_supported(x86_iommu) ?
> > >                                                 ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> > >       }
> > > -    if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
> > > -        if (!kvm_irqchip_is_split()) {
> > > -            error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
> > > -            return false;
> > > -        }
> > > -        if (!kvm_enable_x2apic()) {
> > > -            error_setg(errp, "eim=on requires support on the KVM side"
> > > -                             "(X2APIC_API, first shipped in v4.7)");
> > > -            return false;
> > > -        }
> > > -    }
> > Given commit 20ca47429e ('Revert "intel_iommu: Fix irqchip / X2APIC
> > configuration checks"'), won't we regress behaviour again  for the accel=kvm
> > case by dropping the kvm_enable_x2apic() call here?
> > 
> > Perhaps if we support userspace APIC with TCG the check just needs to be redone
> > to instead avoid always requiring kvm e.g.:
> > 
> > if (kvm_irqchip_in_kernel()) {
> >      error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split"
> >                 "(X2APIC_API, first shipped in v4.7)");
> > }
> > 
> > if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> >      error_setg(errp, "eim=on requires support on the KVM side"
> >                 "(X2APIC_API, first shipped in v4.7)");
> >      return false;
> > }
> 
> Thank you for your review. I think the check for kvm_irqchip_in_kernel() is
> not correct, AFAIK, kvm_irqchip_is_split() == true also means
> kvm_irqchip_in_kernel() == true on x86. To check if kernel-irqchip = on, we
> need to do something like in x86_iommu_realize
> 
>     bool irq_all_kernel = kvm_irqchip_in_kernel() &&
> !kvm_irqchip_is_split();
> 
> The original check for !kvm_irqchip_is_split means emulated/userspace APIC.
> It's because to reach that check x86_iommu_ir_supported(...) == true and
> x86_iommu_ir_supported(...) == true is not supported when kernel-irqchip =
> on (there is a check for this in x86_iommu_realize)
> 
> So I think we need to change the check to
> 
>     if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
>         if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
>             error_setg(errp, "eim=on requires support on the KVM side"
>                              "(X2APIC_API, first shipped in v4.7)");
>             return false;
>         }
>     }
> 
> Is it OK?

Mostly to me, except that we may also want to keep failing if all irq chips
are in kernel?

Thanks,

-- 
Peter Xu


