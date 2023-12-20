Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B8819915
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 08:08:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFqfe-0002Ue-6I; Wed, 20 Dec 2023 02:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rFqfZ-0002UQ-UH
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 02:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rFqfY-0008Pq-9B
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 02:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703056022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vU71ZLfxlsohIkhrtgBvhuo9DsXGIpOZ9dLpvd5tp4g=;
 b=NoT2TRhiNAx/Em7q9kyPQzPw+vV41RInKiI3LGUT7h9dOkAvUSpTBXlX6lwkOuC7a2Eq1u
 gEGhM9mjQMIkQ0Z+22NFz/z+Wy5cB+nkEW4/oW+r54CO2Sxsj3vks9KgLQuGagoLRBy9JW
 H5P+B4fqN1B93/UakifMW/k84xf2t/o=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-a3JLoyfCMD6xb9USBgpg2g-1; Wed, 20 Dec 2023 02:06:59 -0500
X-MC-Unique: a3JLoyfCMD6xb9USBgpg2g-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dbd4db03bd4so1528612276.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 23:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703056019; x=1703660819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vU71ZLfxlsohIkhrtgBvhuo9DsXGIpOZ9dLpvd5tp4g=;
 b=XkjcC0Q8ZXaSruHEu0KKLxpLPUVUBoN1qmja6pAlq5W0sYRD1KaRH/x3FT0m/ao88x
 w/oL/fXXAxZPnVnHbKmWsL0bbppAhjtc1UXvRF6kDdSNccsoFCJQXRTsRFKfaAwmLzew
 PYpVVTD/wGWE0zC1mZYFzlwg9BEYBcEDlicfzdvBATu0qRNtg3AnaQokcXfhNkbWFbg9
 47bB5Li6eyseWw1vPR28YA1GTAqIcmAHt0lDx8cgsMe1CaQfCdtzYLdzowEgS2Cw4v2I
 8PkIkVseWI7Uey1LeaHxl1LqDd+jI5U+WIZ/Z577ZmNvZzCFfMm34RGbuRWxCOgyfU1m
 2Vug==
X-Gm-Message-State: AOJu0Yx5IhZziKO+NnEd7CGlHR1I77LRdgWB4Kp46yR+TIb4VHun2B9X
 kA6n1O7K2Nf7Hc8snHk5moTxbJOSNLh8D2zn7RBzLdgOwrZwXAxhAMEJprk52JHnF3Htel5t/B/
 BQcydj9tAnphGmRVFsTs7DfH2nkkWtTQ=
X-Received: by 2002:a25:ef45:0:b0:dbd:5253:c3af with SMTP id
 w5-20020a25ef45000000b00dbd5253c3afmr1247582ybm.1.1703056018778; 
 Tue, 19 Dec 2023 23:06:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ5FkQdJF510QePLlozDyv9mgxSZyLCCBRqDD/VXOjKkTnvW74uPi22Pv9ZJ0wH3HyMeFjJJgBnoloAHdt980=
X-Received: by 2002:a25:ef45:0:b0:dbd:5253:c3af with SMTP id
 w5-20020a25ef45000000b00dbd5253c3afmr1247575ybm.1.1703056018416; Tue, 19 Dec
 2023 23:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-9-eperezma@redhat.com>
 <CACGkMEvH=uU4QxMHVHTo5tQiuML2+NTE3gZssfz84-+4kGHa1Q@mail.gmail.com>
In-Reply-To: <CACGkMEvH=uU4QxMHVHTo5tQiuML2+NTE3gZssfz84-+4kGHa1Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 08:06:22 +0100
Message-ID: <CAJaqyWczW+uwYBsWas97JY6OgiSurnvNQnnTYPFWv5La55GOOg@mail.gmail.com>
Subject: Re: [PATCH for 9.0 08/12] vdpa: add vhost_vdpa_load_setup
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

On Wed, Dec 20, 2023 at 6:22=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Callers can use this function to setup the incoming migration thread.
> >
> > This thread is able to map the guest memory while the migration is
> > ongoing, without blocking QMP or other important tasks. While this
> > allows the destination QEMU not to block, it expands the mapping time
> > during migration instead of making it pre-migration.
>
> If it's just QMP, can we simply use bh with a quota here?
>

Because QEMU cannot guarantee the quota at write(fd,
VHOST_IOTLB_UPDATE, ...). Also, synchronization with
vhost_vdpa_dev_start would complicate as it would need to be
re-scheduled too.

As a half-baked idea, we can split the mapping chunks in manageable
sizes, but I don't like that idea a lot.

> Btw, have you measured the hotspot that causes such slowness? Is it
> pinning or vendor specific mapping that slows down the progress? Or if
> VFIO has a similar issue?
>

Si-Wei did the actual profiling as he is the one with the 128G guests,
but most of the time was spent in the memory pinning. Si-Wei, please
correct me if I'm wrong.

I didn't check VFIO, but I think it just maps at realize phase with
vfio_realize -> vfio_attach_device -> vfio_connect_container(). In
previous testings, this delayed the VM initialization by a lot, as
we're moving that 20s of blocking to every VM start.

Investigating a way to do it only in the case of being the destination
of a live migration, I think the right place is .load_setup migration
handler. But I'm ok to move it for sure.

> >
> > This thread joins at vdpa backend device start, so it could happen that
> > the guest memory is so large that we still have guest memory to map
> > before this time.
>
> So we would still hit the QMP stall in this case?
>

This paragraph is kind of outdated, sorry. I can only cause this if I
don't enable switchover_ack migration capability and if I artificially
make memory pinning in the kernel artificially slow. But I didn't
check QMP to be honest, so I can try to test it, yes.

If QMP is not responsive, that means QMP is not responsive in QEMU
master in that period actually. So we're only improving anyway.

Thanks!

> > This can be improved in later iterations, when the
> > destination device can inform QEMU that it is not ready to complete the
> > migration.
> >
> > If the device is not started, the clean of the mapped memory is done at
> > .load_cleanup.  This is far from ideal, as the destination machine has
> > mapped all the guest ram for nothing, and now it needs to unmap it.
> > However, we don't have information about the state of the device so its
> > the best we can do.  Once iterative migration is supported, this will b=
e
> > improved as we know the virtio state of the device.
> >
> > If the VM migrates before finishing all the maps, the source will stop
> > but the destination is still not ready to continue, and it will wait
> > until all guest RAM is mapped.  It is still an improvement over doing
> > all the map when the migration finish, but next patches use the
> > switchover_ack method to prevent source to stop until all the memory is
> > mapped at the destination.
> >
> > The memory unmapping if the device is not started is weird
> > too, as ideally nothing would be mapped.  This can be fixed when we
> > migrate the device state iteratively, and we know for sure if the devic=
e
> > is started or not.  At this moment we don't have such information so
> > there is no better alternative.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > ---
>
> Thanks
>


