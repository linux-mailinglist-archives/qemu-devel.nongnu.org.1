Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3150076D239
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:38:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRDvQ-0006CN-SK; Wed, 02 Aug 2023 11:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRDvG-00068x-2I
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRDvE-0001a7-0g
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690990678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WntBR+PGfv7EIUlu4tW20b9p+xLC7lRuSz0AHY8VMVY=;
 b=NlBLH0rfxez0yZR/8dxbRt8twJUfsxUpGpD1qFs0GXe+4eAjhMLKaTN2lykkIqQcQLwBu2
 G5aluX1+GZBH5g5WoXEnh+lAe/Lku079BzvAuFxZwvobvaZhgzc1I4EQ9mh6wXej9dZfZt
 GOd5Yx+XtU8yiF4s6XhbJC8rPyO4UqY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-ztlGbs9pOrm40VnE9KogbA-1; Wed, 02 Aug 2023 11:37:56 -0400
X-MC-Unique: ztlGbs9pOrm40VnE9KogbA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31444df0fafso4239731f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 08:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690990675; x=1691595475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WntBR+PGfv7EIUlu4tW20b9p+xLC7lRuSz0AHY8VMVY=;
 b=WI0ZWxCSkoJjfAV6L6bYsfE+pUauP4CBSIT58QlMDbGsQZWPWLJ+CjMyM7xGP1Rb0F
 nkAgcee1DwFqtBS5GF3tkOZ7Cfr4eZcFWnhQQj5RBV4Q6jhhcQEssb9UFjdjER3RH41N
 8+rKXHW7eXrz+vljvQu5cNYyzRGQnVUgDTArhmyvpuSl1rN8Abb//XvgAqsHhiR2674a
 ATffuQRKk9VFrKEiHuloZjbiMOju3FMsGkJvJwCyuZ8GIRKXVvp7Q77b4YcniFptk90+
 N8C0S6fM9pOVCQ+lw/e59DkXbhdiu6/xmEX2PC+8Tp5JfbauT92gCZko5ui/BeRJVWI7
 WT/w==
X-Gm-Message-State: ABy/qLYz0IK+WcJRwQfyym/dA4aIyEYc1FQlGrHf/nVXVxfBG6uKk8s1
 jxaxeCU/RRbusSJaoiwIgSVhyYBpuV4hqlNzvzzRZpgrN49sItQ25hbtL1LrDCnfIbfkJeXoGcD
 QE8ennSp1+e9sWhE=
X-Received: by 2002:a5d:538a:0:b0:317:63d0:39b7 with SMTP id
 d10-20020a5d538a000000b0031763d039b7mr5000890wrv.59.1690990675771; 
 Wed, 02 Aug 2023 08:37:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGSq1wXRtM4di/rnKD86qj5lowIVf3RW06GgR5Qjy2UZCTdE3MF8Yfma7qq0SWWArHu9qnj5Q==
X-Received: by 2002:a5d:538a:0:b0:317:63d0:39b7 with SMTP id
 d10-20020a5d538a000000b0031763d039b7mr5000869wrv.59.1690990675425; 
 Wed, 02 Aug 2023 08:37:55 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 d7-20020adfe2c7000000b00317ac0642b0sm5874474wrj.27.2023.08.02.08.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 08:37:54 -0700 (PDT)
Date: Wed, 2 Aug 2023 11:37:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-8.1 0/6] Fix endianness issues in the intel-iommu
 device
Message-ID: <20230802111832-mutt-send-email-mst@kernel.org>
References: <20230802135723.178083-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802135723.178083-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Aug 02, 2023 at 03:57:17PM +0200, Thomas Huth wrote:
> The intel-iommu device is currently unusable on big endian hosts.
> When doing something like this on a s390x host:
> 
>  wget https://download.fedoraproject.org/pub/fedora/linux/releases/38/Server/x86_64/images/Fedora-Server-KVM-38-1.6.x86_64.qcow2
>  ./qemu-system-x86_64 -M q35 -device intel-iommu -m 2G \
>         -hda ~/Fedora-Server-KVM-38-1.6.x86_64.qcow2 -trace "vtd_*"
> 
> ... the guest kernel crashes during boot, complaining about some
> problems with the iommu, and you can see clearly in the traces that
> some values are wrong when compared to running this on a x86 host.
> 
> After spending quite some time hunting down the problems one by one,
> I think I now found them all - at least I can successfully boot the
> above kernel after I applied these patches.
> 
> Thomas Huth (6):
>   hw/i386/intel_iommu: Fix trivial endianness problems
>   hw/i386/intel_iommu: Fix endianness problems related to
>     VTD_IR_TableEntry
>   hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big endian hosts
>   hw/i386/intel_iommu: Fix index calculation in
>     vtd_interrupt_remap_msi()
>   hw/i386/x86-iommu: Fix endianness issue in
>     x86_iommu_irq_to_msi_message()
>   include/hw/i386/x86-iommu: Fix struct X86IOMMU_MSIMessage for big
>     endian hosts
> 
>  hw/i386/intel_iommu_internal.h |  9 ++++++
>  include/hw/i386/intel_iommu.h  | 50 ++++++++++++++++++----------------
>  include/hw/i386/x86-iommu.h    | 50 ++++++++++++++++++----------------
>  hw/i386/intel_iommu.c          | 23 ++++++++++------
>  hw/i386/x86-iommu.c            |  2 +-
>  5 files changed, 76 insertions(+), 58 deletions(-)

I guess it's ok as a hack for 8.1. But we really need better
APIs. Annotating field endianness with __bitwise would be
a start.


> -- 
> 2.39.3


