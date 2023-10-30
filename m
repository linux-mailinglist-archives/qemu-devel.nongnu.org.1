Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5B7DBC4E
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 16:03:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTmw-0006cj-Qk; Mon, 30 Oct 2023 11:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxTmt-0006Zz-6l
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxTmr-0007dV-I7
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698678159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kR/Hy7gg0dO4FTgHpZcwPe2p2jnegWl6itS/ciSKTUQ=;
 b=EewVpXf49wJhwFarraAOOxoIRnTJxQQjf4tlspHnDtxmMiJhRHZOuUcORSB+DfR5dA/Bpf
 Q+3GVtc7OC4uPNBOsGauV7Agf7mfsj1ZGJbQPjrvvlus+/feieOXtjVtPTBUspjvYsLtjN
 CagFvwGUhMI08XXjg4tNYO3bb7OIw8w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-lD74rPRiOgCMxBzksJpA8g-1; Mon, 30 Oct 2023 11:02:33 -0400
X-MC-Unique: lD74rPRiOgCMxBzksJpA8g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d48cfd295so17092366d6.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 08:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698678153; x=1699282953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kR/Hy7gg0dO4FTgHpZcwPe2p2jnegWl6itS/ciSKTUQ=;
 b=tcQACe/7qtHeqxrtSdTi8tFqH3Dy4TfHd+BbAi3HP4NC+HD5Y83HUfnUR+1CbJuJ9g
 smm3crjADR19tj9RbNBvVeEqnLAyA/NWyxyujKKqVIfpCaTKoKxIpQxm+BGAkijsFrzO
 xvGEPy5Ac4HyWKbl+hdgxZA5TkA0J3Z2m4HvEQFkSl0atIL6V5QbUG4nTT6/rqok9xvr
 kjLgN++WQQkS3x+dxx2ZpVmT8zyfbX8h3s/235hz/Wry5knIFEXRjnklO3xGIfqzlQVY
 GO0u3+5SVLCdcH2ThTLUjl846avrBYrxFYAwlNPCtwMa3yLQH06hAMncfjsNCAaAbk/P
 2O8Q==
X-Gm-Message-State: AOJu0YwlGK0UQYTfF0vfbxm0pfBXCGjtCULzdKH1BIriZDS6J/Ha5zkZ
 U4SNAhyZQy5HfSiTodgCrnbnkWdI6flAGuafu2kf3wudosaw6d5CcIip8x0zYZt2lrNU3kInbK7
 abdNtBTuYgNSBsu4=
X-Received: by 2002:a0c:eda7:0:b0:671:8a1:8975 with SMTP id
 h7-20020a0ceda7000000b0067108a18975mr5779312qvr.4.1698678153149; 
 Mon, 30 Oct 2023 08:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Uo2ks3QrnIW+Z4ttzXLfbJFsIEoH037pxQVquubYY7a2W3GGt9Dd1nnu64Xz8rXbIQx6RA==
X-Received: by 2002:a0c:eda7:0:b0:671:8a1:8975 with SMTP id
 h7-20020a0ceda7000000b0067108a18975mr5779280qvr.4.1698678152752; 
 Mon, 30 Oct 2023 08:02:32 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y18-20020ad457d2000000b0066e0c924109sm3423656qvx.106.2023.10.30.08.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 08:02:32 -0700 (PDT)
Date: Mon, 30 Oct 2023 11:02:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/6] system/physmem: IOMMU: Invoke the translate_size
 function if it is implemented
Message-ID: <ZT/FhsJ0UrYfUHmd@x1n>
References: <ZTvfECmO4JFZ/aIp@x1n>
 <ZT9GlTLtTOT3WUif@ethan84-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZT9GlTLtTOT3WUif@ethan84-VirtualBox>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

On Mon, Oct 30, 2023 at 02:00:54PM +0800, Ethan Chen wrote:
> On Fri, Oct 27, 2023 at 12:13:50PM -0400, Peter Xu wrote:
> > Add cc list.
> > 
> > On Fri, Oct 27, 2023 at 12:02:24PM -0400, Peter Xu wrote:
> > > On Fri, Oct 27, 2023 at 11:28:36AM +0800, Ethan Chen wrote:
> > > > On Thu, Oct 26, 2023 at 10:20:41AM -0400, Peter Xu wrote:
> > > > > Could you elaborate why is that important?  In what use case?
> > > > I was not involved in the formulation of the IOPMP specification, but I'll try
> > > > to explain my perspective. IOPMP use the same the idea as PMP. "The matching 
> > > > PMP entry must match all bytes of an access, or the access fails."
> > > > 
> > > > > 
> > > > > Consider IOVA mapped for address range iova=[0, 4K] only, here we have a
> > > > > DMA request with range=[0, 8K].  Now my understanding is what you want to
> > > > > achieve is don't trigger the DMA to [0, 4K] and fail the whole [0, 8K]
> > > > > request.
> > > > > 
> > > > > Can we just fail at the latter DMA [4K, 8K] when it happens?  After all,
> > > > > IIUC a device can split the 0-8K DMA into two smaller DMAs, then the 1st
> > > > > chunk can succeed then if it falls in 0-4K.  Some further explanation of
> > > > > the failure use case could be helpful.
> > > > 
> > > > IOPMP can only detect partially hit in an access. DMA device will split a 
> > > > large DMA transfer to small DMA transfers base on target and DMA transfer 
> > > > width, so partially hit error only happens when an access cross the boundary.
> > > > But to ensure that an access is only within one entry is still important. 
> > > > For example, an entry may mean permission of a device memory region. We do 
> > > > not want to see one DMA transfer can access mutilple devices, although DMA 
> > > > have permissions from multiple entries.
> > > 
> > > I was expecting a DMA request can be fulfilled successfully as long as the
> > > DMA translations are valid for the whole range of the request, even if the
> > > requested range may include two separate translated targets or more, each
> > > point to different places (either RAM, or other devicie's MMIO regions).
> 
> IOPMP is used to check DMA translation is vaild or not. In IOPMP specification
> , a translation access more than one entry is not invalid.
> Though it is not recommand, user can create an IOPMP entry contains mutiple
> places to make this kind translations valid.
> 
> > > 
> > > AFAIK currently QEMU memory model will automatically split that large
> > > request into two or more smaller requests, and fulfill them separately by
> > > two/more IOMMU translations, with its memory access dispatched to the
> > > specific memory regions.
> 
> Because of requests may be split, I need a method to take the original request
> information to IOPMP.

I'm not sure whether translate() is the "original request" either.  The
problem is QEMU can split the request for various reasons already, afaict.

For example, address_space_translate_internal() has this:

    if (memory_region_is_ram(mr)) {
        diff = int128_sub(section->size, int128_make64(addr));
        *plen = int128_get64(int128_min(diff, int128_make64(*plen)));
    }

Which can already shrink the request size from the caller before reaching
translate().  So the length passed into translate() can already be
modified.

Another thing is, we have two other common call sites for translate():

        memory_region_iommu_replay
        address_space_translate_for_iotlb

I'm not sure whether you've looked into them and think they don't need to
be trapped: at least memory_region_iommu_replay() looks all fine in this
regard because it always translate in min page size granule.  But I think
the restriction should apply to all translate()s.

translate_size() is weird on its own. If the only purpose is to pass the
length into translate(), another option is to add that parameter into
current translate(), allowing the implementation to ignore it.  I think
that'll be better, but even if so, I'm not 100% sure it'll always do what
you wanted as discussed above.

Thanks,

-- 
Peter Xu


