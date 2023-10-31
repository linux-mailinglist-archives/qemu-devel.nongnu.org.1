Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE47E7DC8B8
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 09:54:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkUX-0005Aa-4D; Tue, 31 Oct 2023 04:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qxkUT-0005A6-IF
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:52:49 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qxkUQ-00050X-GC
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:52:49 -0400
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39V8qQmE051939;
 Tue, 31 Oct 2023 16:52:26 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.51) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 31 Oct 2023
 16:52:23 +0800
Date: Tue, 31 Oct 2023 16:52:16 +0800
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>
Subject: Re: [PATCH 2/6] system/physmem: IOMMU: Invoke the translate_size
 function if it is implemented
Message-ID: <ZUDANzCz/uDZ+fB/@ethan84-VirtualBox>
References: <ZTvfECmO4JFZ/aIp@x1n> <ZT9GlTLtTOT3WUif@ethan84-VirtualBox>
 <ZT/FhsJ0UrYfUHmd@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZT/FhsJ0UrYfUHmd@x1n>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39V8qQmE051939
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 30, 2023 at 11:02:30AM -0400, Peter Xu wrote:
> On Mon, Oct 30, 2023 at 02:00:54PM +0800, Ethan Chen wrote:
> > On Fri, Oct 27, 2023 at 12:13:50PM -0400, Peter Xu wrote:
> > > Add cc list.
> > > 
> > > On Fri, Oct 27, 2023 at 12:02:24PM -0400, Peter Xu wrote:
> > > > On Fri, Oct 27, 2023 at 11:28:36AM +0800, Ethan Chen wrote:
> > > > > On Thu, Oct 26, 2023 at 10:20:41AM -0400, Peter Xu wrote:
> > > > > > Could you elaborate why is that important?  In what use case?
> > > > > I was not involved in the formulation of the IOPMP specification, but I'll try
> > > > > to explain my perspective. IOPMP use the same the idea as PMP. "The matching 
> > > > > PMP entry must match all bytes of an access, or the access fails."
> > > > > 
> > > > > > 
> > > > > > Consider IOVA mapped for address range iova=[0, 4K] only, here we have a
> > > > > > DMA request with range=[0, 8K].  Now my understanding is what you want to
> > > > > > achieve is don't trigger the DMA to [0, 4K] and fail the whole [0, 8K]
> > > > > > request.
> > > > > > 
> > > > > > Can we just fail at the latter DMA [4K, 8K] when it happens?  After all,
> > > > > > IIUC a device can split the 0-8K DMA into two smaller DMAs, then the 1st
> > > > > > chunk can succeed then if it falls in 0-4K.  Some further explanation of
> > > > > > the failure use case could be helpful.
> > > > > 
> > > > > IOPMP can only detect partially hit in an access. DMA device will split a 
> > > > > large DMA transfer to small DMA transfers base on target and DMA transfer 
> > > > > width, so partially hit error only happens when an access cross the boundary.
> > > > > But to ensure that an access is only within one entry is still important. 
> > > > > For example, an entry may mean permission of a device memory region. We do 
> > > > > not want to see one DMA transfer can access mutilple devices, although DMA 
> > > > > have permissions from multiple entries.
> > > > 
> > > > I was expecting a DMA request can be fulfilled successfully as long as the
> > > > DMA translations are valid for the whole range of the request, even if the
> > > > requested range may include two separate translated targets or more, each
> > > > point to different places (either RAM, or other devicie's MMIO regions).
> > 
> > IOPMP is used to check DMA translation is vaild or not. In IOPMP specification
> > , a translation access more than one entry is not invalid.
> > Though it is not recommand, user can create an IOPMP entry contains mutiple
> > places to make this kind translations valid.
> > 
> > > > 
> > > > AFAIK currently QEMU memory model will automatically split that large
> > > > request into two or more smaller requests, and fulfill them separately by
> > > > two/more IOMMU translations, with its memory access dispatched to the
> > > > specific memory regions.
> > 
> > Because of requests may be split, I need a method to take the original request
> > information to IOPMP.
> 
> I'm not sure whether translate() is the "original request" either.  The
> problem is QEMU can split the request for various reasons already, afaict.
> 
> For example, address_space_translate_internal() has this:
> 
>     if (memory_region_is_ram(mr)) {
>         diff = int128_sub(section->size, int128_make64(addr));
>         *plen = int128_get64(int128_min(diff, int128_make64(*plen)));
>     }
> 
> Which can already shrink the request size from the caller before reaching
> translate().  So the length passed into translate() can already be
> modified.
> 
> Another thing is, we have two other common call sites for translate():
> 
>         memory_region_iommu_replay
>         address_space_translate_for_iotlb
> 
> I'm not sure whether you've looked into them and think they don't need to
> be trapped: at least memory_region_iommu_replay() looks all fine in this
> regard because it always translate in min page size granule.  But I think
> the restriction should apply to all translate()s.
> 
> translate_size() is weird on its own. If the only purpose is to pass the
> length into translate(), another option is to add that parameter into
> current translate(), allowing the implementation to ignore it.  I think
> that'll be better, but even if so, I'm not 100% sure it'll always do what
> you wanted as discussed above.

It seems that there are too many things that have not been considered in my 
current method. I am doing the revision that no new translation function but 
adding start address and end address to MemTxAttrs. 

Since attrs_to_index() only return one interger, IOPMP attrs_to_index() will 
copy the address range to its device state and then handle the translate(). 

Thanks,
Ethan Chen

