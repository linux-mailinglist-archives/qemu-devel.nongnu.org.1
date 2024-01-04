Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFB4823C5B
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 07:48:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLHV7-0001DI-Gc; Thu, 04 Jan 2024 01:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLHUy-0001CF-Bk
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 01:46:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLHUv-00058v-4r
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 01:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704350789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYtPe9vhtv4TiE7oIw9K2PTDlEP37Gs3xyj/IQ1fEdE=;
 b=K3uFuwyieZc3Dtmlw0gA/qmKrwfEcUtFJMnwD5kI73/9rJvq2o7dJcovRVW9qN+AaAW5Yy
 RBRmUoSMbvHRR9Wx908CiuBPI3Yd1m7UqmShFjbzq11ZI6X/uCYMHNmfA7PVpw1CpOqSaS
 dMZPeriy7Q30v+TurcASttWWj+hv64o=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-l5_UROVQNRGYsE5krKhjFQ-1; Thu, 04 Jan 2024 01:46:26 -0500
X-MC-Unique: l5_UROVQNRGYsE5krKhjFQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6da4d130a82so51728b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 22:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704350783; x=1704955583;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RYtPe9vhtv4TiE7oIw9K2PTDlEP37Gs3xyj/IQ1fEdE=;
 b=pX6b3B4n/Qk3108xb5LAoTR70iQLbGgaO8ULJAK+LfgMcRYLd/t+hdSqx13oOymom6
 LTwUrESBS7Nt9gmCt0OE7sFyJYYCcpt9KXk7njnmw+OBKSDa2rAr301IzVKilCAE7f2o
 yeqfRgj3gay2tIVrnzYh35vDoqjQXMiXMsUGF3Bt251gR26LEar+as3AUeh63H5AhGNw
 Q/SkZmYkFQ/LitI25/MxuGJeKxIZIkh703eDNYOmpwrGJbMRpCjbmIHEMCROuCFNy25Z
 ljqZSl5pvZeJCu9XaDjn/aJVd6Nj2QfFqbi6mUcpGdfaU+4MSbuJg6OA2p9F4vvlTaTV
 Dl2A==
X-Gm-Message-State: AOJu0Yz0FuLyj0t3xg9FEfcL3Yw9isgmbuNFlsnXNmy4uTIpmcnpQ9nV
 BH9CPF1mvvVihTLs3m2Ax8XZjAq4rRX+fkPLtzopGaJByTzCK3Z0+RNDh/8nwlAZVagJyM79m9u
 XhP2el3RVdTBIYvogtbotao4=
X-Received: by 2002:a05:6a00:399b:b0:6da:86e5:1648 with SMTP id
 fi27-20020a056a00399b00b006da86e51648mr370394pfb.0.1704350783541; 
 Wed, 03 Jan 2024 22:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuGEPyuUvXBHeDEIQIQum00SsRqSLpcxxUCahzH0FtoCfJYrWbwedoFFREZowEPnKlNSo7aw==
X-Received: by 2002:a05:6a00:399b:b0:6da:86e5:1648 with SMTP id
 fi27-20020a056a00399b00b006da86e51648mr370385pfb.0.1704350783182; 
 Wed, 03 Jan 2024 22:46:23 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i126-20020a625484000000b006dac8b83f29sm194518pfb.122.2024.01.03.22.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 22:46:22 -0800 (PST)
Date: Thu, 4 Jan 2024 14:46:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH for 9.0 08/12] vdpa: add vhost_vdpa_load_setup
Message-ID: <ZZZUNsOVxxqr-H5S@x1n>
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-9-eperezma@redhat.com>
 <CACGkMEvH=uU4QxMHVHTo5tQiuML2+NTE3gZssfz84-+4kGHa1Q@mail.gmail.com>
 <CAJaqyWczW+uwYBsWas97JY6OgiSurnvNQnnTYPFWv5La55GOOg@mail.gmail.com>
 <CACGkMEukZNUnXRSwpVAROe7U7GzkubP9i37ev+qOSQvWxLEK_Q@mail.gmail.com>
 <CAJaqyWfGkboB4sN0PSukKx1kAV-QQ_YSWXWvksPScBD9OgHRsQ@mail.gmail.com>
 <ZZOgGmpNT_zi2eat@x1n>
 <CAJaqyWcajuV12tV0aguBO1qpa95pK0qUEHjsNh2+VpMR3fCVyg@mail.gmail.com>
 <ZZT7wuq-_IhfN_wR@x1n>
 <CAJaqyWfMEeg6FVhyFTVEest1eZXEwMiyib47Z8+BUGCaWkfH3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWfMEeg6FVhyFTVEest1eZXEwMiyib47Z8+BUGCaWkfH3w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jan 03, 2024 at 12:11:19PM +0100, Eugenio Perez Martin wrote:
> On Wed, Jan 3, 2024 at 7:16 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Jan 02, 2024 at 12:28:48PM +0100, Eugenio Perez Martin wrote:
> > > On Tue, Jan 2, 2024 at 6:33 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > Jason, Eugenio,
> > > >
> > > > Apologies for a late reply; just back from the long holiday.
> > > >
> > > > On Thu, Dec 21, 2023 at 09:20:40AM +0100, Eugenio Perez Martin wrote:
> > > > > Si-Wei did the actual profiling as he is the one with the 128G guests,
> > > > > but most of the time was spent in the memory pinning. Si-Wei, please
> > > > > correct me if I'm wrong.
> > > >
> > > > IIUC we're talking about no-vIOMMU use case.  The pinning should indeed
> > > > take a lot of time if it's similar to what VFIO does.
> > > >
> > > > >
> > > > > I didn't check VFIO, but I think it just maps at realize phase with
> > > > > vfio_realize -> vfio_attach_device -> vfio_connect_container(). In
> > > > > previous testings, this delayed the VM initialization by a lot, as
> > > > > we're moving that 20s of blocking to every VM start.
> > > > >
> > > > > Investigating a way to do it only in the case of being the destination
> > > > > of a live migration, I think the right place is .load_setup migration
> > > > > handler. But I'm ok to move it for sure.
> > > >
> > > > If it's destined to map the 128G, it does sound sensible to me to do it
> > > > when VM starts, rather than anytime afterwards.
> > > >
> > >
> > > Just for completion, it is not 100% sure the driver will start the
> > > device. But it is likely for sure.
> >
> > My understanding is that vDPA is still a quite special device, assuming
> > only targeting advanced users, and should not appear in a default config
> > for anyone.  It means the user should hopefully remove the device if the
> > guest is not using it, instead of worrying on a slow boot.
> >
> > >
> > > > Could anyone help to explain what's the problem if vDPA maps 128G at VM
> > > > init just like what VFIO does?
> > > >
> > >
> > > The main problem was the delay of VM start. In the master branch, the
> > > pinning is done when the driver starts the device. While it takes the
> > > BQL, the rest of the vCPUs can move work forward while the host is
> > > pinning. So the impact of it is not so evident.
> > >
> > > To move it to initialization time made it very noticeable. To make
> > > things worse, QEMU did not respond to QMP commands and similar. That's
> > > why it was done only if the VM was the destination of a LM.
> >
> > Is that a major issue for us?
> 
> To me it is a regression but I'm ok with it for sure.
> 
> >  IIUC then VFIO shares the same condition.
> > If it's a real problem, do we want to have a solution that works for both
> > (or, is it possible)?
> >
> 
> I would not consider a regression for VFIO since I think it has
> behaved that way from the beginning. But yes, I'm all in to find a
> common solution.
> 
> > >
> > > However, we've added the memory map thread in this version, so this
> > > might not be a problem anymore. We could move the spawn of the thread
> > > to initialization time.
> > >
> > > But how to undo this pinning in the case the guest does not start the
> > > device? In this series, this is done at the destination with
> > > vhost_vdpa_load_cleanup. Or is it ok to just keep the memory mapped as
> > > long as QEMU has the vDPA device?
> >
> > I think even if vDPA decides to use a thread, we should keep the same
> > behavior before/after the migration.  Having assymetric behavior over DMA
> > from the assigned HWs might have unpredictable implications.
> >
> > What I worry is we may over-optimize / over-engineer the case where the
> > user will specify the vDPA device but not use it, as I mentioned above.
> >
> 
> I agree with all of the above. If it is ok to keep memory mapped while
> the guest has not started I think we can move the spawn of the thread,
> or even just the map write itself, to the vdpa init.
> 
> > For the long term, maybe there's chance to optimize DMA pinning for both
> > vdpa/vfio use cases, then we can always pin them during VM starts? Assuming
> > that issue only exists for large VMs, while they should normally be good
> > candidates for huge pages already.  Then, it means maybe one folio/page can
> > cover a large range (e.g. 1G on x86_64) in one pin, and physical continuity
> > also provides possibility of IOMMU large page mappings.  I didn't check at
> > which stage we are for VFIO on this, Alex may know better.
> 
> Sounds interesting, and I think it should be implemented. Thanks for
> the pointer!

I didn't have an exact pointer previously, but to provide a pointer, I
think it can be something like this:

  physr discussion - Jason Gunthorpe
  https://www.youtube.com/watch?v=QftOTtks-pI&list=PLbzoR-pLrL6rlmdpJ3-oMgU_zxc1wAhjS&index=36

Since I have zero knowledge on vDPA side, I can only provide the exmaple
from VFIO and even if so that may not be fully accurate.  Basically afaiu
currently vfio is already smart enough to recognize continuous ranges (via
vfio_pin_pages_remote()):

		/* Pin a contiguous chunk of memory */
		npage = vfio_pin_pages_remote(dma, vaddr + dma->size,
					      size >> PAGE_SHIFT, &pfn, limit,
					      &batch);

But the pin can still be slow, due to e.g. we need a page* for each
PAGE_SIZE range.

I think something like physr can improve it.  That should correspond to the
1st slide of the video of the "performance" entry on pin_user_pages().

Thanks,

> 
> > I'm copying Alex
> > anyway since the problem seems to be a common one already, so maybe he has
> > some thoughts.
> >
> 
> Appreciated :).
> 
> Thanks!
> 

-- 
Peter Xu


