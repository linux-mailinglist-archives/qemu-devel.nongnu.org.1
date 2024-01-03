Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D0882284C
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 07:18:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKuYe-0001GT-Mb; Wed, 03 Jan 2024 01:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rKuYc-0001GD-OT
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 01:16:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rKuYa-0001Fe-Uv
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 01:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704262607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UsM2EvnusQ7YzQZpEu/z3mi82TrvynL1hRuLj3GBook=;
 b=Gtn1xlt2lSQuB8o6THCvXJKZsejL3I/QpjFoaO3Pjk0cqlG3A+NWruEgIXEhPlCRB4DDYb
 j7Er+kN21B2ePcBQc02ZEMDmNBHjaQ+diTlFJ1cTZ4SClrkoezE6Ct6v1NsyRV8EXhdcm5
 GwPMcyngVROzjJShGL3HsdSDp21HjrU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-Vm7VaPqlMlWYbXd6kTqROQ-1; Wed, 03 Jan 2024 01:16:45 -0500
X-MC-Unique: Vm7VaPqlMlWYbXd6kTqROQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d99cdbeb9dso1489052b3a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 22:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704262604; x=1704867404;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UsM2EvnusQ7YzQZpEu/z3mi82TrvynL1hRuLj3GBook=;
 b=TXR7TrxkN/gSGIhs04nWt7M31AIiC+ZdYxrm7yyY8JehbXA5KhA0vgpnaDQhTMRoUU
 397Ws9hOIpRe1DOLyGmo6gUqjV23NeJZDIPHDP2zhM8deyddjHe5qhZguL+50BrIpZWN
 aBUJrgT/BZ5WrzM0J2Ud+MxwVZLm5Ayy3+8T/9zeQkUDAZxkm3iblfmdYK0qGBriZ7E4
 ME15SnQ9ADjCAIPfBi0mE/6DoYtF7+bVK0qpoANCmlpBqoF0HvrnG31hAc4R0aXY/Gr5
 9xsi+fOcWwbGdTMFV08IG17M3YMbFMXy7IBoqrae9pBm8IqyHkYTHnMBKcvMx1gpkRiH
 YizQ==
X-Gm-Message-State: AOJu0Yym8i/e7ve6VGjtQqy5mVDOKCYZ8EmUHuyJ1/pRogRmk+GQVE4s
 nDiK1oGP/uuU4vwxu8zgiO6qpOahPNIwRSP88invdNtGbQkqnofRp+zsdnZx8FBQcU2gJUFA5zF
 wOH0LxKH7wO5AtvPnub8IbGs=
X-Received: by 2002:a05:6a00:8a85:b0:6da:86e5:165d with SMTP id
 id5-20020a056a008a8500b006da86e5165dmr7526970pfb.0.1704262604603; 
 Tue, 02 Jan 2024 22:16:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3leWhHzn4XvyAHfXgcFaD6OlhCFgk6ubq7WX4ci5pHrT/0NAJCbg6tS/hygcw2/A1v7DyLQ==
X-Received: by 2002:a05:6a00:8a85:b0:6da:86e5:165d with SMTP id
 id5-20020a056a008a8500b006da86e5165dmr7526961pfb.0.1704262604230; 
 Tue, 02 Jan 2024 22:16:44 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 a25-20020aa78659000000b006d9c216a9e6sm15032358pfo.56.2024.01.02.22.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 22:16:43 -0800 (PST)
Date: Wed, 3 Jan 2024 14:16:34 +0800
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
Message-ID: <ZZT7wuq-_IhfN_wR@x1n>
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-9-eperezma@redhat.com>
 <CACGkMEvH=uU4QxMHVHTo5tQiuML2+NTE3gZssfz84-+4kGHa1Q@mail.gmail.com>
 <CAJaqyWczW+uwYBsWas97JY6OgiSurnvNQnnTYPFWv5La55GOOg@mail.gmail.com>
 <CACGkMEukZNUnXRSwpVAROe7U7GzkubP9i37ev+qOSQvWxLEK_Q@mail.gmail.com>
 <CAJaqyWfGkboB4sN0PSukKx1kAV-QQ_YSWXWvksPScBD9OgHRsQ@mail.gmail.com>
 <ZZOgGmpNT_zi2eat@x1n>
 <CAJaqyWcajuV12tV0aguBO1qpa95pK0qUEHjsNh2+VpMR3fCVyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcajuV12tV0aguBO1qpa95pK0qUEHjsNh2+VpMR3fCVyg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 02, 2024 at 12:28:48PM +0100, Eugenio Perez Martin wrote:
> On Tue, Jan 2, 2024 at 6:33 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Jason, Eugenio,
> >
> > Apologies for a late reply; just back from the long holiday.
> >
> > On Thu, Dec 21, 2023 at 09:20:40AM +0100, Eugenio Perez Martin wrote:
> > > Si-Wei did the actual profiling as he is the one with the 128G guests,
> > > but most of the time was spent in the memory pinning. Si-Wei, please
> > > correct me if I'm wrong.
> >
> > IIUC we're talking about no-vIOMMU use case.  The pinning should indeed
> > take a lot of time if it's similar to what VFIO does.
> >
> > >
> > > I didn't check VFIO, but I think it just maps at realize phase with
> > > vfio_realize -> vfio_attach_device -> vfio_connect_container(). In
> > > previous testings, this delayed the VM initialization by a lot, as
> > > we're moving that 20s of blocking to every VM start.
> > >
> > > Investigating a way to do it only in the case of being the destination
> > > of a live migration, I think the right place is .load_setup migration
> > > handler. But I'm ok to move it for sure.
> >
> > If it's destined to map the 128G, it does sound sensible to me to do it
> > when VM starts, rather than anytime afterwards.
> >
> 
> Just for completion, it is not 100% sure the driver will start the
> device. But it is likely for sure.

My understanding is that vDPA is still a quite special device, assuming
only targeting advanced users, and should not appear in a default config
for anyone.  It means the user should hopefully remove the device if the
guest is not using it, instead of worrying on a slow boot.

> 
> > Could anyone help to explain what's the problem if vDPA maps 128G at VM
> > init just like what VFIO does?
> >
> 
> The main problem was the delay of VM start. In the master branch, the
> pinning is done when the driver starts the device. While it takes the
> BQL, the rest of the vCPUs can move work forward while the host is
> pinning. So the impact of it is not so evident.
> 
> To move it to initialization time made it very noticeable. To make
> things worse, QEMU did not respond to QMP commands and similar. That's
> why it was done only if the VM was the destination of a LM.

Is that a major issue for us?  IIUC then VFIO shares the same condition.
If it's a real problem, do we want to have a solution that works for both
(or, is it possible)?

> 
> However, we've added the memory map thread in this version, so this
> might not be a problem anymore. We could move the spawn of the thread
> to initialization time.
> 
> But how to undo this pinning in the case the guest does not start the
> device? In this series, this is done at the destination with
> vhost_vdpa_load_cleanup. Or is it ok to just keep the memory mapped as
> long as QEMU has the vDPA device?

I think even if vDPA decides to use a thread, we should keep the same
behavior before/after the migration.  Having assymetric behavior over DMA
from the assigned HWs might have unpredictable implications.

What I worry is we may over-optimize / over-engineer the case where the
user will specify the vDPA device but not use it, as I mentioned above.

For the long term, maybe there's chance to optimize DMA pinning for both
vdpa/vfio use cases, then we can always pin them during VM starts? Assuming
that issue only exists for large VMs, while they should normally be good
candidates for huge pages already.  Then, it means maybe one folio/page can
cover a large range (e.g. 1G on x86_64) in one pin, and physical continuity
also provides possibility of IOMMU large page mappings.  I didn't check at
which stage we are for VFIO on this, Alex may know better. I'm copying Alex
anyway since the problem seems to be a common one already, so maybe he has
some thoughts.

Thanks,

-- 
Peter Xu


