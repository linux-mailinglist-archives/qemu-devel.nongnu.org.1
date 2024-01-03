Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C68822BE6
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 12:13:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKzAJ-00084M-9s; Wed, 03 Jan 2024 06:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rKzAH-00084E-SJ
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 06:12:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rKzAG-0001Rv-0q
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 06:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704280318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEC6qcVqtx61rhEFaumX3qTsLNeNXfpgbip8CtAeIM0=;
 b=Sv5CPyjWFLpzanJFmBeylp7LXuTQAHRoWpv8TEyfSPFdpau82seDm0woqd1v8pNaGr1vbB
 qOYtsAZpLWGYdfXs2u5CSxVbkkX2gJBJI0G8SgYeSg8g3rbSfGnqU6xHYmrjjISZp20y9D
 WHcNoX92uqATSvoQW3jb6kBAl6nv8Bw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-EL_qpt7xMoO0a6A_hp8ZVw-1; Wed, 03 Jan 2024 06:11:57 -0500
X-MC-Unique: EL_qpt7xMoO0a6A_hp8ZVw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5e6fe91c706so172175707b3.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 03:11:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704280317; x=1704885117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEC6qcVqtx61rhEFaumX3qTsLNeNXfpgbip8CtAeIM0=;
 b=iUhuHPe2ZkOJdRLM/JmqSRXY2q4YirXIB3yGJRXPQn06DDE0QajjvFTP3EXb/GsTS/
 bIUGuzw8MyqUpLSfXij5BZUoVIVenH8EJ3eU4ArfGzldfXIJvHMopXhJm8Hx1D12/xJn
 /K+gqBNJaz6mxPGCDyyk1y7r/rhLnyBvbvsfst8ZKFfcoKZcEC/iKBhU9IAtbWUCOF85
 Y5YjU6RHnjCGoiynIK5oIHACvr9rfZvl749J2U+1diAvBFtWjFAYb+uDQMj/PdR+vGpb
 0EbyxmFEKvXZUorbjbQtNy64CbbUfGOYor4h9oIoq9Yuaeq1xPe4ZL3dGn3bChkT0mtJ
 0AFQ==
X-Gm-Message-State: AOJu0Yz4ywF//R85fqaagTNqUwPQw722xTzHTwBqB3/IJmpW2NaOiCo+
 EbiG1cZ2JhTfPmMgxIJB9Z/66e63wubpG2JLsDFxte9jjD2g5XiB6tbLVeMhaPbRxs517uMZ0qR
 XIBPdJ3DPL0uQ6F38pPccILxyuOh46pTgVesu3tA=
X-Received: by 2002:a0d:eb94:0:b0:5e2:a997:50d5 with SMTP id
 u142-20020a0deb94000000b005e2a99750d5mr10375328ywe.35.1704280316957; 
 Wed, 03 Jan 2024 03:11:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2Xn3qOxm3iwhGtWeey9ViwnqoczZJ4vjCswRtgckVe3QvPfiMm6xIzSvbN5u51ZGJokpkAbUS3RrldGUXOes=
X-Received: by 2002:a0d:eb94:0:b0:5e2:a997:50d5 with SMTP id
 u142-20020a0deb94000000b005e2a99750d5mr10375322ywe.35.1704280316617; Wed, 03
 Jan 2024 03:11:56 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-9-eperezma@redhat.com>
 <CACGkMEvH=uU4QxMHVHTo5tQiuML2+NTE3gZssfz84-+4kGHa1Q@mail.gmail.com>
 <CAJaqyWczW+uwYBsWas97JY6OgiSurnvNQnnTYPFWv5La55GOOg@mail.gmail.com>
 <CACGkMEukZNUnXRSwpVAROe7U7GzkubP9i37ev+qOSQvWxLEK_Q@mail.gmail.com>
 <CAJaqyWfGkboB4sN0PSukKx1kAV-QQ_YSWXWvksPScBD9OgHRsQ@mail.gmail.com>
 <ZZOgGmpNT_zi2eat@x1n>
 <CAJaqyWcajuV12tV0aguBO1qpa95pK0qUEHjsNh2+VpMR3fCVyg@mail.gmail.com>
 <ZZT7wuq-_IhfN_wR@x1n>
In-Reply-To: <ZZT7wuq-_IhfN_wR@x1n>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jan 2024 12:11:19 +0100
Message-ID: <CAJaqyWfMEeg6FVhyFTVEest1eZXEwMiyib47Z8+BUGCaWkfH3w@mail.gmail.com>
Subject: Re: [PATCH for 9.0 08/12] vdpa: add vhost_vdpa_load_setup
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Parav Pandit <parav@mellanox.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Wed, Jan 3, 2024 at 7:16=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jan 02, 2024 at 12:28:48PM +0100, Eugenio Perez Martin wrote:
> > On Tue, Jan 2, 2024 at 6:33=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > Jason, Eugenio,
> > >
> > > Apologies for a late reply; just back from the long holiday.
> > >
> > > On Thu, Dec 21, 2023 at 09:20:40AM +0100, Eugenio Perez Martin wrote:
> > > > Si-Wei did the actual profiling as he is the one with the 128G gues=
ts,
> > > > but most of the time was spent in the memory pinning. Si-Wei, pleas=
e
> > > > correct me if I'm wrong.
> > >
> > > IIUC we're talking about no-vIOMMU use case.  The pinning should inde=
ed
> > > take a lot of time if it's similar to what VFIO does.
> > >
> > > >
> > > > I didn't check VFIO, but I think it just maps at realize phase with
> > > > vfio_realize -> vfio_attach_device -> vfio_connect_container(). In
> > > > previous testings, this delayed the VM initialization by a lot, as
> > > > we're moving that 20s of blocking to every VM start.
> > > >
> > > > Investigating a way to do it only in the case of being the destinat=
ion
> > > > of a live migration, I think the right place is .load_setup migrati=
on
> > > > handler. But I'm ok to move it for sure.
> > >
> > > If it's destined to map the 128G, it does sound sensible to me to do =
it
> > > when VM starts, rather than anytime afterwards.
> > >
> >
> > Just for completion, it is not 100% sure the driver will start the
> > device. But it is likely for sure.
>
> My understanding is that vDPA is still a quite special device, assuming
> only targeting advanced users, and should not appear in a default config
> for anyone.  It means the user should hopefully remove the device if the
> guest is not using it, instead of worrying on a slow boot.
>
> >
> > > Could anyone help to explain what's the problem if vDPA maps 128G at =
VM
> > > init just like what VFIO does?
> > >
> >
> > The main problem was the delay of VM start. In the master branch, the
> > pinning is done when the driver starts the device. While it takes the
> > BQL, the rest of the vCPUs can move work forward while the host is
> > pinning. So the impact of it is not so evident.
> >
> > To move it to initialization time made it very noticeable. To make
> > things worse, QEMU did not respond to QMP commands and similar. That's
> > why it was done only if the VM was the destination of a LM.
>
> Is that a major issue for us?

To me it is a regression but I'm ok with it for sure.

>  IIUC then VFIO shares the same condition.
> If it's a real problem, do we want to have a solution that works for both
> (or, is it possible)?
>

I would not consider a regression for VFIO since I think it has
behaved that way from the beginning. But yes, I'm all in to find a
common solution.

> >
> > However, we've added the memory map thread in this version, so this
> > might not be a problem anymore. We could move the spawn of the thread
> > to initialization time.
> >
> > But how to undo this pinning in the case the guest does not start the
> > device? In this series, this is done at the destination with
> > vhost_vdpa_load_cleanup. Or is it ok to just keep the memory mapped as
> > long as QEMU has the vDPA device?
>
> I think even if vDPA decides to use a thread, we should keep the same
> behavior before/after the migration.  Having assymetric behavior over DMA
> from the assigned HWs might have unpredictable implications.
>
> What I worry is we may over-optimize / over-engineer the case where the
> user will specify the vDPA device but not use it, as I mentioned above.
>

I agree with all of the above. If it is ok to keep memory mapped while
the guest has not started I think we can move the spawn of the thread,
or even just the map write itself, to the vdpa init.

> For the long term, maybe there's chance to optimize DMA pinning for both
> vdpa/vfio use cases, then we can always pin them during VM starts? Assumi=
ng
> that issue only exists for large VMs, while they should normally be good
> candidates for huge pages already.  Then, it means maybe one folio/page c=
an
> cover a large range (e.g. 1G on x86_64) in one pin, and physical continui=
ty
> also provides possibility of IOMMU large page mappings.  I didn't check a=
t
> which stage we are for VFIO on this, Alex may know better.

Sounds interesting, and I think it should be implemented. Thanks for
the pointer!

> I'm copying Alex
> anyway since the problem seems to be a common one already, so maybe he ha=
s
> some thoughts.
>

Appreciated :).

Thanks!


