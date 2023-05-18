Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DBD7088E0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:01:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjnc-0005iD-V9; Thu, 18 May 2023 16:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzjnS-0005hv-PR
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzjnQ-0004TF-Ap
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684440018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J3RWa2eU+R6B31HSOq9aBdsZOVq82W0+JHjFTRe+MFY=;
 b=jK8/Qk1Fifujyp6jMYjYvCilsbi6tw1XNnxKxaVXtXXaIdyIMWG1TpLY7tSAlW2guVm7fM
 9XRDBzIYN4BIeWB25EFmxQ1Qf52doZIxXwew3/RGxSORVMdlh2V0ukCtqiKHzroKABX+ZV
 j39WYTiZlJNFN/mDY/ZK2wpAyUeXldE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-l-hqpQvWO1iVZ-DzB4UFpw-1; Thu, 18 May 2023 16:00:16 -0400
X-MC-Unique: l-hqpQvWO1iVZ-DzB4UFpw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af08de8c2fso13541301fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 13:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684440014; x=1687032014;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3RWa2eU+R6B31HSOq9aBdsZOVq82W0+JHjFTRe+MFY=;
 b=XKgMi2TRandAkfDHI1k2YsOczrTEhln3DuG+m+OBNYvmIFsjd9dFK/WgTmUKRmYfAq
 +kAw3fgAvmT9mRTRbyreHViTzz4GV3s+4riksj9Dg+HyRM9uQ4HHKR8XrqZpS09la9Vw
 XTHfRWUhK3aIZtM0NJP6anA8Y6dvJMD/MQe3zKxT/MhWaqG01byEphb2fwxxd5qPVl4T
 w6qtjiJuNLSe4wZDg3TeXDGDnzTSmGzShXZOWYRSs7y54XVYqM4JDq9zwFtYLlZYkiFI
 TKqkmaTNCQaPDBTFqDsJ8aEIGkwhKIObQEYPHuF6cIEu0nWRkYx3+bMRnlZPblfjW7nz
 oNxQ==
X-Gm-Message-State: AC+VfDyy0TsBZ2KVtXt0xHLq8UOyo02h8aBvwZqJVCzhH+xEZ9xbZuQz
 xAlZkvc4eUsIyZdDbhxdEaZ6mSu4vKGcunrB1kOa+o0oY/z4Cf1tTkhzIM4nhVqpyKh1pNwCTCo
 5cuzEbPvNDWOLnPw=
X-Received: by 2002:a2e:6a02:0:b0:2ae:da46:7f62 with SMTP id
 f2-20020a2e6a02000000b002aeda467f62mr6232218ljc.29.1684440014668; 
 Thu, 18 May 2023 13:00:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7eFUIoaxUyVmxG8wAzm+tVjqVbBQTgmTonb3QwtW6CL2p/R8ZN2L0LUu46I4re/BIlbixwSw==
X-Received: by 2002:a2e:6a02:0:b0:2ae:da46:7f62 with SMTP id
 f2-20020a2e6a02000000b002aeda467f62mr6232212ljc.29.1684440014329; 
 Thu, 18 May 2023 13:00:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a2eb0c9000000b002ad93c4c4e7sm450084ljl.83.2023.05.18.13.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 13:00:13 -0700 (PDT)
Date: Thu, 18 May 2023 16:00:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [REPOST PATCH v3 4/5] intel_iommu: allow Extended Interrupt Mode
 when using userspace APIC
Message-ID: <20230518155946-mutt-send-email-mst@kernel.org>
References: <20230411142440.8018-1-minhquangbui99@gmail.com>
 <20230411142440.8018-5-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411142440.8018-5-minhquangbui99@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Apr 11, 2023 at 09:24:39PM +0700, Bui Quang Minh wrote:
> As userspace APIC now supports x2APIC, intel interrupt remapping
> hardware can be set to EIM mode when userspace local APIC is used.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  hw/i386/intel_iommu.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a62896759c..fd7c16b852 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4045,17 +4045,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>                        && x86_iommu_ir_supported(x86_iommu) ?
>                                                ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>      }
> -    if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
> -        if (!kvm_irqchip_is_split()) {
> -            error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
> -            return false;
> -        }
> -        if (!kvm_enable_x2apic()) {
> -            error_setg(errp, "eim=on requires support on the KVM side"
> -                             "(X2APIC_API, first shipped in v4.7)");
> -            return false;
> -        }
> -    }
>  
>      /* Currently only address widths supported are 39 and 48 bits */
>      if ((s->aw_bits != VTD_HOST_AW_39BIT) &&


Paolo I think if you ack the kvm bits, I can merge.

> -- 
> 2.25.1
> 
> 


