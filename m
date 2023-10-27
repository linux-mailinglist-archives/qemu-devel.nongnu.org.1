Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C8A7D9DD4
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 18:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPTT-0004li-6I; Fri, 27 Oct 2023 12:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qwPTM-0004l3-Sd
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qwPTL-0007rX-BL
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698423245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q15Y7fQTLYa5G6KcEVEqMGLgxQ1nLEG/D4IABnxyjLs=;
 b=glMewOEbj4cv+brxw35kQVrvMD3j02bw40Bfi6qqra3QD3jnj0COMiPgrVz1TD/ZPYE9to
 TyOVdTi89kY+qYKaSGVJBmUOI4o8BxeZKZehWcz1T/nwRfMGD6tiyhsqP7uKl5yBxyIwJW
 uUWQsB7hzE2suc/DJ/SnmC3VktSvEkM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-g2g0a1EDMsGOCoKEHuS7kA-1; Fri, 27 Oct 2023 12:13:54 -0400
X-MC-Unique: g2g0a1EDMsGOCoKEHuS7kA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77891ef5fc9so58422885a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 09:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698423233; x=1699028033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q15Y7fQTLYa5G6KcEVEqMGLgxQ1nLEG/D4IABnxyjLs=;
 b=wGbChlhsm9ZQOQkLGB4KwNzPn7PKWK3JGoBpkiJsQGC38IjLxWaNqpU9Nih/kDPutb
 ZLodqZI7GS8aHyN17SVAmlw+D1gCVXe3zFa4denji73u3RE7+nyNzFNRiueEYmoe6rF9
 Ni4OCqjtkkYTGvmMfzPAKH5r2d/Vt/cHC/IIM1r+BblePyE3DulVppuBl3BrzyO/+CTZ
 cuECiH/b0AQbpkf4ZoO/Mh/NSi44sy8A6jvNAViJuZtIJFhShmxw/5N/33kqdkmUtTA0
 FjZgHYEfvmm9ZmNDpqDnvdstMW8HZ3xMyVzFnMrY9mD5ca6CVqM1NfmRyGqiGZQwykPo
 XILA==
X-Gm-Message-State: AOJu0Yx2zUcJYSc48zxwXfZlqY94x6MryLQMD2hB5dGrC23tgwDZkdEE
 Ac/Uvz2yEoFtBz0DvodDIN18RAlL91/ZX4Ns+mRyt/hw2tsXhLiiM2i1k2nJ8EkCrkRWVKB++Ap
 Hfj3v7r6C6COPRhV/074fTsU=
X-Received: by 2002:a05:620a:d47:b0:773:615e:71e with SMTP id
 o7-20020a05620a0d4700b00773615e071emr2484267qkl.1.1698423233509; 
 Fri, 27 Oct 2023 09:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEquJJQjROEo9dauZhKXbKdYwtDcnW/B1EINVSqJ+v0Fkn98JBz/C3jL7PWrJjOfa7dMkHtDw==
X-Received: by 2002:a05:620a:d47:b0:773:615e:71e with SMTP id
 o7-20020a05620a0d4700b00773615e071emr2484250qkl.1.1698423233200; 
 Fri, 27 Oct 2023 09:13:53 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c13-20020a05620a200d00b00773fe8971bbsm665021qka.90.2023.10.27.09.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 09:13:52 -0700 (PDT)
Date: Fri, 27 Oct 2023 12:13:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/6] system/physmem: IOMMU: Invoke the translate_size
 function if it is implemented
Message-ID: <ZTvhvjlPnzWzI8bg@x1n>
References: <ZTkw4itrYANXm4qR@x1n> <ZTsuZLMOLsehgzoc@ethan84-VirtualBox>
 <ZTvfECmO4JFZ/aIp@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTvfECmO4JFZ/aIp@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Add cc list.

On Fri, Oct 27, 2023 at 12:02:24PM -0400, Peter Xu wrote:
> On Fri, Oct 27, 2023 at 11:28:36AM +0800, Ethan Chen wrote:
> > On Thu, Oct 26, 2023 at 10:20:41AM -0400, Peter Xu wrote:
> > > Could you elaborate why is that important?  In what use case?
> > I was not involved in the formulation of the IOPMP specification, but I'll try
> > to explain my perspective. IOPMP use the same the idea as PMP. "The matching 
> > PMP entry must match all bytes of an access, or the access fails."
> > 
> > > 
> > > Consider IOVA mapped for address range iova=[0, 4K] only, here we have a
> > > DMA request with range=[0, 8K].  Now my understanding is what you want to
> > > achieve is don't trigger the DMA to [0, 4K] and fail the whole [0, 8K]
> > > request.
> > > 
> > > Can we just fail at the latter DMA [4K, 8K] when it happens?  After all,
> > > IIUC a device can split the 0-8K DMA into two smaller DMAs, then the 1st
> > > chunk can succeed then if it falls in 0-4K.  Some further explanation of
> > > the failure use case could be helpful.
> > 
> > IOPMP can only detect partially hit in an access. DMA device will split a 
> > large DMA transfer to small DMA transfers base on target and DMA transfer 
> > width, so partially hit error only happens when an access cross the boundary.
> > But to ensure that an access is only within one entry is still important. 
> > For example, an entry may mean permission of a device memory region. We do 
> > not want to see one DMA transfer can access mutilple devices, although DMA 
> > have permissions from multiple entries.
> 
> I was expecting a DMA request can be fulfilled successfully as long as the
> DMA translations are valid for the whole range of the request, even if the
> requested range may include two separate translated targets or more, each
> point to different places (either RAM, or other devicie's MMIO regions).
> 
> AFAIK currently QEMU memory model will automatically split that large
> request into two or more smaller requests, and fulfill them separately by
> two/more IOMMU translations, with its memory access dispatched to the
> specific memory regions.
> 
> The example you provided doesn't seem to be RISCV specific.  Do you mean it
> is a generic requirement from PCI/PCIe POV, or is it only a restriction of
> IOPMP?  If it's a valid PCI restriction, does it mean that all the rest
> IOMMU implementations in QEMU currently are broken?
> 
> [copy Michael and Igor]
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


