Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DC7D7D6C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 09:15:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvuZi-00021W-9E; Thu, 26 Oct 2023 03:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qvuZf-0001u3-0m
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 03:14:35 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qvuZb-0002Zw-5N
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 03:14:34 -0400
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39Q7EITo027112;
 Thu, 26 Oct 2023 15:14:18 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.51) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 26 Oct 2023
 15:14:14 +0800
Date: Thu, 26 Oct 2023 15:14:14 +0800
To: David Hildenbrand <david@redhat.com>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 1/6] exec/memory: Introduce the translate_size function
 within the IOMMU class
Message-ID: <ZToRxn/jFyj1Mm1r@ethan84-VirtualBox>
References: <20231025051430.493079-1-ethan84@andestech.com>
 <20231025051430.493079-2-ethan84@andestech.com>
 <babd9eb7-1f9c-478a-b288-96606795fc8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <babd9eb7-1f9c-478a-b288-96606795fc8b@redhat.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39Q7EITo027112
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

On Wed, Oct 25, 2023 at 04:56:22PM +0200, David Hildenbrand wrote:
> On 25.10.23 07:14, Ethan Chen wrote:
> > IOMMU have size information during translation.
> > 
> 
> Can you add some more information why we would want this and how the backend
> can do "better" things with the size at hand?
>
With size information, IOMMU can reject a memory access which is patially in 
valid region.

Currently translation function limit memory access size with a mask, so the 
valid part of access will success. My target is to detect partially hit and 
reject whole access. Translation function cannot detect partially hit because 
it lacks size information.
> Note that I was not CCed on the cover letter.
> 
> > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > ---
> >   include/exec/memory.h | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> > 
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 9087d02769..5520b7c8c0 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -396,6 +396,25 @@ struct IOMMUMemoryRegionClass {
> >        */
> >       IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
> >                                  IOMMUAccessFlags flag, int iommu_idx);
> > +    /**
> > +     * @translate_size:
> > +     *
> > +     * Return a TLB entry that contains a given address and size.
> > +     *
> > +     * @iommu: the IOMMUMemoryRegion
> > +     *
> > +     * @hwaddr: address to be translated within the memory region
> > +     *
> > +     * @size: size to indicate the scope of the entire transaction
> > +     *
> > +     * @flag: requested access permission
> > +     *
> > +     * @iommu_idx: IOMMU index for the translation
> > +     */
> > +    IOMMUTLBEntry (*translate_size)(IOMMUMemoryRegion *iommu, hwaddr addr,
> > +                                    hwaddr size, IOMMUAccessFlags flag,
> > +                                    int iommu_idx);
> > +
> >       /**
> >        * @get_min_page_size:
> >        *
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
Thanks,
Ethan Chen

