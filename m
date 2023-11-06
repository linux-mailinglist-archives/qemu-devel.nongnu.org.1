Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FBA7E195C
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 05:19:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzr3i-0008Vb-AW; Sun, 05 Nov 2023 23:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qzr3a-0008VO-0M
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 23:17:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qzr3X-0000R9-Lo
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 23:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699244261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLoNnHHwseLC6xNMKT1kT+YENPkAooVkwyhzv9xjYiM=;
 b=O8fDQ8NyIVv3eY7GnjVF85RY7i0eC5BBThPWvAiEO6A6J+7h5zJsVBkkdgYHGBYe+FOOXZ
 2hQVNTiK1irBfH7H2zotaPuTbBL9KmKQYuE2a36z1P5I4iRimS3wckTRKukQdL1kQmooo4
 z6mIS2AEzsTla44HN6PeD3YEgHfJmFs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-S2_pLK6jOJ2pM3QtPVPxdg-1; Sun, 05 Nov 2023 23:17:39 -0500
X-MC-Unique: S2_pLK6jOJ2pM3QtPVPxdg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50911cc75adso4187232e87.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 20:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699244258; x=1699849058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLoNnHHwseLC6xNMKT1kT+YENPkAooVkwyhzv9xjYiM=;
 b=n38mnZak3PtML50dTRRsdJmhGv9TpfI1GcYmi5LGA226Gp6vWK4l5/IY7t6rVuGZyq
 JZ5RlYpD302s56wJFivJAse7Sk8dNVa92gzE7cjus4ox1OC6YxR/D+tIjePYWfSH0AWd
 om0bRMalMzW0HkjfgpuoIHSmuFkNjtOupo/vfQuzWPrMmdSHSudC0kqNATZqRlT5xZdU
 8nmutlyUVnJa/8u+dwG7A9RkwHtQPcT86LWjcFjFo7VueiBLG4YVzHhxRTxjcj6kQ7sG
 31bbbmuHzvUCfq7GB/eI8qox8XjWx2a8n2tMPrArWupUpaxhEiO8+Bfwocg8K9L1HDEk
 Ubmg==
X-Gm-Message-State: AOJu0Yy6zfvXReBqBOTbfRclM6hAyVromBnDciUFj7rKPsCM9jYNXcQ8
 gI7GCdx+ihWjTDUceZTBg9p0pfCSWBgm/ZL0dnlEgS6gvm/U8UCZzxQWj781XD8AEyU/fqxKXUn
 bs4qWuCG4o6SY9DOrt9TIkobHGt6wviI=
X-Received: by 2002:ac2:4a8e:0:b0:505:6c99:bd7c with SMTP id
 l14-20020ac24a8e000000b005056c99bd7cmr21197613lfp.57.1699244258286; 
 Sun, 05 Nov 2023 20:17:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAb2eK+lGWt9K9UrYSzekEPmSDr2Ycrqt5yjxSbk5bScUmKcsQczjIY5qyQJG1rF5rZ1EcCI5EmFpqC8QZ1+4=
X-Received: by 2002:ac2:4a8e:0:b0:505:6c99:bd7c with SMTP id
 l14-20020ac24a8e000000b005056c99bd7cmr21197598lfp.57.1699244257953; Sun, 05
 Nov 2023 20:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <1e565b27-2897-4063-8eff-e42cfd5934c2@oracle.com>
 <CAJaqyWeOG0Eoc8W9FYFzJ9r1ENd3Cd1oLGF=ggJvWth2xD6u9A@mail.gmail.com>
In-Reply-To: <CAJaqyWeOG0Eoc8W9FYFzJ9r1ENd3Cd1oLGF=ggJvWth2xD6u9A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 12:17:26 +0800
Message-ID: <CACGkMEt2CZLQ7Uj5Vy5f=pY3SEiFP=BSoaeQHzgq1UYHaYQa0w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/18] Map memory at destination .load_setup in
 vDPA-net migration
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, qemu-devel@nongnu.org, 
 Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 yin31149@gmail.com, 
 Yajun Wu <yajunw@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Gautam Dawar <gdawar@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Thu, Nov 2, 2023 at 8:38=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Thu, Nov 2, 2023 at 11:13=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com=
> wrote:
> >
> >
> >
> > On 10/19/2023 7:34 AM, Eugenio P=C3=A9rez wrote:
> > > Current memory operations like pinning may take a lot of time at the
> > >
> > > destination.  Currently they are done after the source of the migrati=
on is
> > >
> > > stopped, and before the workload is resumed at the destination.  This=
 is a
> > >
> > > period where neigher traffic can flow, nor the VM workload can contin=
ue
> > >
> > > (downtime).
> > >
> > >
> > >
> > > We can do better as we know the memory layout of the guest RAM at the
> > >
> > > destination from the moment the migration starts.  Moving that operat=
ion allows
> > >
> > > QEMU to communicate the kernel the maps while the workload is still r=
unning in
> > >
> > > the source, so Linux can start mapping them.  Ideally, all IOMMU is c=
onfigured,
> > >
> > > but if the vDPA parent driver uses on-chip IOMMU and .set_map we're s=
till
> > >
> > > saving all the pinning time.
> > I get what you want to say, though not sure how pinning is relevant to
> > on-chip IOMMU and .set_map here, essentially pinning is required for al=
l
> > parent vdpa drivers that perform DMA hence don't want VM pages to move
> > around.
>
> Basically highlighting that the work done under .set_map is not only
> pinning, but it is a significant fraction on it. It can be reworded or
> deleted for sure.
>
> > >
> > >
> > >
> > > Note that further devices setup at the end of the migration may alter=
 the guest
> > >
> > > memory layout. But same as the previous point, many operations are st=
ill done
> > >
> > > incrementally, like memory pinning, so we're saving time anyway.
> > >
> > >
> > >
> > > The first bunch of patches just reorganizes the code, so memory relat=
ed
> > >
> > > operation parameters are shared between all vhost_vdpa devices.  This=
 is
> > >
> > > because the destination does not know what vhost_vdpa struct will hav=
e the
> > >
> > > registered listener member, so it is easier to place them in a shared=
 struct
> > >
> > > rather to keep them in vhost_vdpa struct.  Future version may squash =
or omit
> > >
> > > these patches.
> > It looks this VhostVDPAShared facility (patch 1-13) is also what I need
> > in my SVQ descriptor group series [*], for which I've built similar
> > construct there. If possible please try to merge this in ASAP. I'll
> > rework my series on top of that.
> >
> > [*]
> > https://github.com/siwliu-kernel/qemu/commit/813518354af5ee8a6e867b2bf7=
dff3d6004fbcd5
> >
>
> I can send it individually, for sure.
>
> MST, Jason, can this first part be merged? It doesn't add a lot by
> itself but it helps pave the way for future changes.
>

I'm fine with that, or it might be easier if you resend it as a
standalone series.

Thanks


