Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 796BE7DF6EF
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 16:47:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyZtj-0000au-L7; Thu, 02 Nov 2023 11:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyZtV-0000a1-Ug
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 11:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyZtR-0007BN-2I
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 11:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698939958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEGVfQbr8VJBn8BJiNU+vYH0vzFDol9ooRwfl8y7O2k=;
 b=P/kx4S2G8Bj7wIjJ5hPIz0pamzxyG15Mzk9MWDg2Q5uXuZBRdzYNkpS0hXsOofWBZZL0/T
 Gn1sY4FrEZQvkDSlSUhOZPhqGbz8f7OLEUgswhOrHl5lfAqHm2iT4pbCzVpz8uQGvDgvjK
 YCSkw28GhCqOZp7igT/L1gysbWtmcJc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-WGimNi9BPgCQsOAOX24bOQ-1; Thu, 02 Nov 2023 11:45:57 -0400
X-MC-Unique: WGimNi9BPgCQsOAOX24bOQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3b3f4ab1238so1471529b6e.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 08:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698939956; x=1699544756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEGVfQbr8VJBn8BJiNU+vYH0vzFDol9ooRwfl8y7O2k=;
 b=FX5v919QEtd67Hv5qn1l8/SqR7rTkRiaElvgRtNrx6Y2XydkvRmWlMkga+pUpa7M+f
 MUJdMB1Ia+MzqJ+paMB2D9X494SvGegmudjarfqM/vQMH22MLkskSQbDEsX/V3KgTtjp
 TcAtw7ZCBjlDx91ogKf7pZRgmN6ChFLDKWVPu4/Tc3Ib8lhHnqBQjge0E5Rv0SG5cwWq
 4bQAi1i09GxpCTCeTGIdhuI0sNUxuUguSfaP+1+vvuqT6V6H7l9RwqAj2pNYTdW6RYtg
 xm6Q0a9ySs+fjScMDSmqwit6ig67WefQA5HtFBzTEQyjglPsT/5bZMvytewQtIw4ovgU
 HWrA==
X-Gm-Message-State: AOJu0YxcoT44/3x+Cfzkwoz/I80PZ1BCkUJYOF+HoKPa34QEGA1jjcOV
 LM4KJ7Frn/7buMpNm2egY4slBik+hPmXeHG0/nk5mVA2tRjEnrcQJvt09sb5YSgjc/pS6DuMnRx
 jiqB+fiu+jxG/AFIZH4E0F59X4RiY9jU=
X-Received: by 2002:a05:6871:3986:b0:1e9:d1b8:5d5a with SMTP id
 oh6-20020a056871398600b001e9d1b85d5amr16008557oac.39.1698939956566; 
 Thu, 02 Nov 2023 08:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoDca+WTdfP3cHBeW5/OpspB6Pi7taE93WubtgFyWm8of1tsMMoCGrtrckRNNnbziQ8uUAn94FRn6E0W1arRg=
X-Received: by 2002:a05:6871:3986:b0:1e9:d1b8:5d5a with SMTP id
 oh6-20020a056871398600b001e9d1b85d5amr16008544oac.39.1698939956285; Thu, 02
 Nov 2023 08:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <20231019143455.2377694-5-eperezma@redhat.com>
 <b031ffc0-76e7-4e17-b755-60923731314f@oracle.com>
In-Reply-To: <b031ffc0-76e7-4e17-b755-60923731314f@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 2 Nov 2023 16:45:20 +0100
Message-ID: <CAJaqyWfACg9W3PkKbU2dvtwdprpzoE9hki0bsKQi9+5UZda6JA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/18] vdpa: move shadow_data to vhost_vdpa_shared
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, Shannon <shannon.nelson@amd.com>, 
 Parav Pandit <parav@mellanox.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, 
 Yajun Wu <yajunw@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Gautam Dawar <gdawar@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Nov 2, 2023 at 9:48=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
>
> On 10/19/2023 7:34 AM, Eugenio P=C3=A9rez wrote:
> > Next patches will register the vhost_vdpa memory listener while the VM
> > is migrating at the destination, so we can map the memory to the device
> > before stopping the VM at the source.  The main goal is to reduce the
> > downtime.
> >
> > However, the destination QEMU is unaware of which vhost_vdpa device wil=
l
> > register its memory_listener.  If the source guest has CVQ enabled, it
> > will be the CVQ device.  Otherwise, it  will be the first one.
> >
> > Move the shadow_data member to VhostVDPAShared so all vhost_vdpa can us=
e
> > it, rather than always in the first or last vhost_vdpa.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   include/hw/virtio/vhost-vdpa.h |  5 +++--
> >   hw/virtio/vhost-vdpa.c         |  6 +++---
> >   net/vhost-vdpa.c               | 23 ++++++-----------------
> >   3 files changed, 12 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-v=
dpa.h
> > index 8d52a7e498..01e0f25e27 100644
> > --- a/include/hw/virtio/vhost-vdpa.h
> > +++ b/include/hw/virtio/vhost-vdpa.h
> > @@ -36,6 +36,9 @@ typedef struct vhost_vdpa_shared {
> >
> >       /* IOVA mapping used by the Shadow Virtqueue */
> >       VhostIOVATree *iova_tree;
> > +
> > +    /* Vdpa must send shadow addresses as IOTLB key for data queues, n=
ot GPA */
> > +    bool shadow_data;
> >   } VhostVDPAShared;
> >
> >   typedef struct vhost_vdpa {
> > @@ -47,8 +50,6 @@ typedef struct vhost_vdpa {
> >       MemoryListener listener;
> >       uint64_t acked_features;
> >       bool shadow_vqs_enabled;
> > -    /* Vdpa must send shadow addresses as IOTLB key for data queues, n=
ot GPA */
> > -    bool shadow_data;
> >       /* Device suspended successfully */
> >       bool suspended;
> >       VhostVDPAShared *shared;
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 2bceadd118..ec028e4c56 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -353,7 +353,7 @@ static void vhost_vdpa_listener_region_add(MemoryLi=
stener *listener,
> >                                            vaddr, section->readonly);
> >
> >       llsize =3D int128_sub(llend, int128_make64(iova));
> > -    if (v->shadow_data) {
> > +    if (v->shared->shadow_data) {
> >           int r;
> >
> >           mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr,
> > @@ -380,7 +380,7 @@ static void vhost_vdpa_listener_region_add(MemoryLi=
stener *listener,
> >       return;
> >
> >   fail_map:
> > -    if (v->shadow_data) {
> > +    if (v->shared->shadow_data) {
> >           vhost_iova_tree_remove(v->shared->iova_tree, mem_region);
> >       }
> >
> > @@ -435,7 +435,7 @@ static void vhost_vdpa_listener_region_del(MemoryLi=
stener *listener,
> >
> >       llsize =3D int128_sub(llend, int128_make64(iova));
> >
> > -    if (v->shadow_data) {
> > +    if (v->shared->shadow_data) {
> >           const DMAMap *result;
> >           const void *vaddr =3D memory_region_get_ram_ptr(section->mr) =
+
> >               section->offset_within_region +
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 9648b0ef7e..01202350ea 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -282,15 +282,6 @@ static ssize_t vhost_vdpa_receive(NetClientState *=
nc, const uint8_t *buf,
> >       return size;
> >   }
> >
> > -/** From any vdpa net client, get the netclient of the first queue pai=
r */
> > -static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
> > -{
> > -    NICState *nic =3D qemu_get_nic(s->nc.peer);
> > -    NetClientState *nc0 =3D qemu_get_peer(nic->ncs, 0);
> > -
> > -    return DO_UPCAST(VhostVDPAState, nc, nc0);
> > -}
> > -
> >   static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool =
enable)
> >   {
> >       struct vhost_vdpa *v =3D &s->vhost_vdpa;
> > @@ -360,10 +351,10 @@ static int vhost_vdpa_net_data_start(NetClientSta=
te *nc)
> >       if (s->always_svq ||
> >           migration_is_setup_or_active(migrate_get_current()->state)) {
> >           v->shadow_vqs_enabled =3D true;
> > -        v->shadow_data =3D true;
> > +        v->shared->shadow_data =3D true;
> >       } else {
> >           v->shadow_vqs_enabled =3D false;
> > -        v->shadow_data =3D false;
> > +        v->shared->shadow_data =3D false;
> >       }
> >
> >       if (v->index =3D=3D 0) {
> > @@ -513,7 +504,7 @@ dma_map_err:
> >
> >   static int vhost_vdpa_net_cvq_start(NetClientState *nc)
> >   {
> > -    VhostVDPAState *s, *s0;
> > +    VhostVDPAState *s;
> >       struct vhost_vdpa *v;
> >       int64_t cvq_group;
> >       int r;
> > @@ -524,12 +515,10 @@ static int vhost_vdpa_net_cvq_start(NetClientStat=
e *nc)
> >       s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> >       v =3D &s->vhost_vdpa;
> >
> > -    s0 =3D vhost_vdpa_net_first_nc_vdpa(s);
> > -    v->shadow_data =3D s0->vhost_vdpa.shadow_vqs_enabled;
> > -    v->shadow_vqs_enabled =3D s0->vhost_vdpa.shadow_vqs_enabled;
> > +    v->shadow_vqs_enabled =3D s->always_svq;
> This doesn't seem equivalent to the previous code. If always_svq is not
> set and migration is active, will it cause CVQ not shadowed at all? The
> "goto out;" line below would effectively return from this function,
> resulting in cvq's shadow_vqs_enabled left behind as false.
>

You're right, this is probably a bad rebase. Thanks for the catch!

>
> >       s->vhost_vdpa.address_space_id =3D VHOST_VDPA_GUEST_PA_ASID;
> >
> > -    if (s->vhost_vdpa.shadow_data) {
> > +    if (v->shared->shadow_data) {
> >           /* SVQ is already configured for all virtqueues */
> >           goto out;
> >       }
> > @@ -1455,12 +1444,12 @@ static NetClientState *net_vhost_vdpa_init(NetC=
lientState *peer,
> >       s->always_svq =3D svq;
> >       s->migration_state.notify =3D vdpa_net_migration_state_notifier;
> >       s->vhost_vdpa.shadow_vqs_enabled =3D svq;
> > -    s->vhost_vdpa.shadow_data =3D svq;
> >       if (queue_pair_index =3D=3D 0) {
> >           vhost_vdpa_net_valid_svq_features(features,
> >                                             &s->vhost_vdpa.migration_bl=
ocker);
> >           s->vhost_vdpa.shared =3D g_new0(VhostVDPAShared, 1);
> >           s->vhost_vdpa.shared->iova_range =3D iova_range;
> > +        s->vhost_vdpa.shared->shadow_data =3D svq;
> >       } else if (!is_datapath) {
> >           s->cvq_cmd_out_buffer =3D mmap(NULL, vhost_vdpa_net_cvq_cmd_p=
age_len(),
> >                                        PROT_READ | PROT_WRITE,
>


