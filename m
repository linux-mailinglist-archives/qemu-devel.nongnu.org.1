Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B99BE9685D1
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Sep 2024 13:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl4wk-0004Bw-Hr; Mon, 02 Sep 2024 07:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sl4wZ-0004An-PG
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 07:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sl4wW-0004zk-VI
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 07:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725275393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWwwyKN968E8bTJQ0ZUsEIy4QAoECgjKceDYvJ2Kt9A=;
 b=ZVV9E4mBIk1stjK1/ya6DoBqX3t5pQNdl4+ZU50WvhkoxRHehh1IGR1Y12ywEx2xd0cgaC
 fIHr9OocC/0/uzAVJfx+nC2CYZhvI4brgo9wcvVwX11pHiZKZWzVblMda8D7vut4dVLrX1
 4BHcG/9AEJ4p8zkVYjO+bYexRZXvQrc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Vgaf-XYGO2KUi4njVAoq9Q-1; Mon, 02 Sep 2024 07:09:52 -0400
X-MC-Unique: Vgaf-XYGO2KUi4njVAoq9Q-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6d5235d1bcaso41990767b3.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 04:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725275391; x=1725880191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWwwyKN968E8bTJQ0ZUsEIy4QAoECgjKceDYvJ2Kt9A=;
 b=K1NQIHlQRKx9Y6k9N9e1jSf/Y8lgltOjYqmK6xCh90+p0KmgbhxhBacpzGxjSOHJKc
 Qg76mpwzbcJv4jeUNvPxUZFsUTfcgoUSJlO+es1UmpiE/QB9vrZ7dUZF98XW15H3jt1H
 uqSdpWHXXQUzX1Ocem+cYiEWndw1sF0d9d3+GeziSVgikwSPvX4TrrShVTKeMMi7AM39
 wqescuyevCJxacE7Gn5sGIk+lFt3BcoS0tDTSkJxBfoW8cV3hqQoNHjJI+rCd9RRUWIw
 hRDS3UUnqoQEwa097jbeEIIljUuUuVQ9AZY6vdC1jAmA8Eaqxru0cnCWUWjh5Z0Qwh0c
 Xfbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD9YPQawfFCAOxHIokuiqA2YQIHDoYKcK6djMqwEP3W21Mk9cWyCWvFhXiEGqSZJr0dRAm+wD8hmPL@nongnu.org
X-Gm-Message-State: AOJu0Yzzy/pOAB/Zrs5bzwhzKdaCkbupzm+xbKZ4kq66yN+ROs3Sgk24
 4+y3K7WBhTB5YKZVk9aM15yBY5fEnSCaqQrWR25pgGT+p7awF6r7gP084fbtOh7auM7iYOYqgBw
 qRXGspPc/LaexTA3ut6llXTgfeCmvkh9tHiF/DlnLXdgqZSBtEcIu4uqO1k+gWezPoiFJX9ZAnM
 Ml4hZkINjQrfdmzs0FyZZExfRURD4=
X-Received: by 2002:a05:690c:d91:b0:6b3:a6ff:7687 with SMTP id
 00721157ae682-6d40d88f2fdmr105254267b3.1.1725275391487; 
 Mon, 02 Sep 2024 04:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPJXT2rIrxUbO1Z2jv4wzHotYHT1ByPXs1J7Igfeyk84K7RDaNNGpxeFW7nCWNQork/YBcPgoMnPu1sztp3kg=
X-Received: by 2002:a05:690c:d91:b0:6b3:a6ff:7687 with SMTP id
 00721157ae682-6d40d88f2fdmr105254017b3.1.1725275391076; Mon, 02 Sep 2024
 04:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
 <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
 <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
 <43277dbe-fb11-025c-fe99-8ee074a6a345@oracle.com>
In-Reply-To: <43277dbe-fb11-025c-fe99-8ee074a6a345@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 2 Sep 2024 13:09:14 +0200
Message-ID: <CAJaqyWcFBxF4+LzC7EDXgFsp+dUNaWmzOqY5x8dav88LM6LhCw@mail.gmail.com>
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, 
 leiyang@redhat.com, peterx@redhat.com, dtatulea@nvidia.com, 
 jasowang@redhat.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Aug 30, 2024 at 11:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
>
>
> On 8/30/2024 1:05 AM, Eugenio Perez Martin wrote:
> > On Fri, Aug 30, 2024 at 6:20=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
> >>> On Wed, Aug 21, 2024 at 2:56=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>> Decouples the IOVA allocator from the IOVA->HVA tree and instead add=
s
> >>>> the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA =
tree
> >>>> will hold all IOVA ranges that have been allocated (e.g. in the
> >>>> IOVA->HVA tree) and are removed when any IOVA ranges are deallocated=
.
> >>>>
> >>>> A new API function vhost_iova_tree_insert() is also created to add a
> >>>> IOVA->HVA mapping into the IOVA->HVA tree.
> >>>>
> >>> I think this is a good first iteration but we can take steps to
> >>> simplify it. Also, it is great to be able to make points on real code
> >>> instead of designs on the air :).
> >>>
> >>> I expected a split of vhost_iova_tree_map_alloc between the current
> >>> vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
> >>> similar. Similarly, a vhost_iova_tree_remove and
> >>> vhost_iova_tree_remove_gpa would be needed.
> >>>
> >>> The first one is used for regions that don't exist in the guest, like
> >>> SVQ vrings or CVQ buffers. The second one is the one used by the
> >>> memory listener to map the guest regions into the vdpa device.
> >>>
> >>> Implementation wise, only two trees are actually needed:
> >>> * Current iova_taddr_map that contains all IOVA->vaddr translations a=
s
> >>> seen by the device, so both allocation functions can work on a single
> >>> tree. The function iova_tree_find_iova keeps using this one, so the
> >> I thought we had thorough discussion about this and agreed upon the
> >> decoupled IOVA allocator solution.
> > My interpretation of it is to leave the allocator as the current one,
> > and create a new tree with GPA which is guaranteed to be unique. But
> > we can talk over it of course.
> >
> >> But maybe I missed something earlier,
> >> I am not clear how come this iova_tree_find_iova function could still
> >> work with the full IOVA-> HVA tree when it comes to aliased memory or
> >> overlapped HVAs? Granted, for the memory map removal in the
> >> .region_del() path, we could rely on the GPA tree to locate the
> >> corresponding IOVA, but how come the translation path could figure out
> >> which IOVA range to return when the vaddr happens to fall in an
> >> overlapped HVA range?
> > That is not a problem, as they both translate to the same address at th=
e device.
> Not sure I followed, it might return a wrong IOVA (range) which the host
> kernel may have conflict or unmatched attribute i.e. permission, size et
> al in the map.
>

Let's leave out the permissions at the moment. I'm going to use the
example you found, but I'll reorder (1) and (3) insertions so it picks
the "wrong" IOVA range intentionally:

(1)
HVA: [0x7f7903ea0000, 0x7f7903ec0000)
GPA: [0xfeda0000, 0xfedc0000)
IOVA: [0x1000, 0x21000)

(2)
HVA: [0x7f7983e00000, 0x7f9903e00000)
GPA: [0x100000000, 0x2080000000)
IOVA: [0x80001000, 0x2000001000)

(3)
HVA: [0x7f7903e00000, 0x7f7983e00000)
GPA: [0x0, 0x80000000)
IOVA: [0x2000001000, 0x2080000000)

Let's say that SVQ wants to translate the HVA range
0xfeda0000-0xfedd0000. So it makes available for the device two
chained buffers: One with addr=3D0x1000 len=3D0x20000 and the other one
with addr=3D(0x20000c1000 len=3D0x10000).

The VirtIO device should be able to translate these two buffers in
isolation and chain them. Not optimal but it helps to keep QEMU source
clean, as the device already must support it. I don't foresee lots of
cases like this anyway :).

About the permissions, maybe we can make the permissions to be part of
the lookup? Instead of returning them at iova_tree_find_iova, make
them match at iova_tree_find_address_iterator.

> >
> > The most complicated situation is where we have a region contained in
> > another region, and the requested buffer crosses them. If the IOVA
> > tree returns the inner region, it will return the buffer chained with
> > the rest of the content in the outer region. Not optimal, but solved
> > either way.
> Don't quite understand what it means... So in this overlapping case,
> speaking of the expectation of the translation API, you would like to
> have all IOVA ranges that match the overlapped HVA to be returned? And
> then to rely on the user (caller) to figure out which one is correct?
> Wouldn't it be easier for the user (SVQ) to use the memory system API
> directly to figure out?
>

All of them are correct in the translation path. The device should be
able to work with a buffer that spans over different IOTLB too. You
can see how QEMU handles it at hw/virtio/virtio.c:virtqueue_map_desc.
If the region is not big enough to contain the whole buffer, the
device must keep looking for the rest of it.

> As we are talking about API we may want to build it in a way generic
> enough to address all possible needs (which goes with what memory
> subsystem is capable of), rather than just look on the current usage
> which has kind of narrow scope. Although virtio-net device doesn't work
> with aliased region now, some other virtio device may do, or maybe some
> day virtio-net would need to use aliased region than the API and the
> users (SVQ) would have to go with another round of significant
> refactoring due to the iova-tree internal working. I feel it's just too
> early or too tight to abstract the iova-tree layer and get the API
> customized for the current use case with a lot of limitations on how
> user should expect to use it. We need some more flexibility and ease on
> extensibility if we want to take the chance to get it rewritten, given
> it is not a lot of code that Jonah had showed here ..
>

Let me know if they are addressed here. Sorry if I didn't explain it
well, but I'm not trying to limit the alias or to handle just a subset
of them. I'm trying to delegate the handling of these to the device as
much as possible, as the device already needs to handle them and the
less we complicate the QEMU solution, the better. Of course, the IOVA
tree is a very self-contained area easy to rewrite in theory, but with
potential future users it might get complicated.

> > The only problem that comes to my mind is the case where the inner
> > region is RO
> Yes, this is one of examples around the permission or size I mentioned
> above, which may have a conflict view with the memory system or the kerne=
l.
>
> Thanks,
> -Siwei
>
> > and it is a write command, but I don't think we have this
> > case in a sane guest. A malicious guest cannot do any harm this way
> > anyway.
> >
> >> Do we still assume some overlapping order so we
> >> always return the first match from the tree? Or we expect every curren=
t
> >> user of iova_tree_find_iova should pass in GPA rather than HVA and use
> >> the vhost_iova_xxx_gpa API variant to look up IOVA?
> >>
> > No, iova_tree_find_iova should keep asking for vaddr, as the result is
> > guaranteed to be there. Users of VhostIOVATree only need to modify how
> > they add or remove regions, knowing if they come from the guest or
> > not. As shown by this series, it is easier to do in that place than in
> > translation.
> >
> >> Thanks,
> >> -Siwei
> >>
> >>> user does not need to know if the address is from the guest or only
> >>> exists in QEMU by using RAMBlock etc. All insert and remove functions
> >>> use this tree.
> >>> * A new tree that relates IOVA to GPA, that only
> >>> vhost_iova_tree_map_alloc_gpa and vhost_iova_tree_remove_gpa uses.
> >>>
> >>> The ideal case is that the key in this new tree is the GPA and the
> >>> value is the IOVA. But IOVATree's DMA is named the reverse: iova is
> >>> the key and translated_addr is the vaddr. We can create a new tree
> >>> struct for that, use GTree directly, or translate the reverse
> >>> linearly. As memory add / remove should not be frequent, I think the
> >>> simpler is the last one, but I'd be ok with creating a new tree.
> >>>
> >>> vhost_iova_tree_map_alloc_gpa needs to add the map to this new tree
> >>> also. Similarly, vhost_iova_tree_remove_gpa must look for the GPA in
> >>> this tree, and only remove the associated DMAMap in iova_taddr_map
> >>> that matches the IOVA.
> >>>
> >>> Does it make sense to you?
> >>>
> >>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >>>> ---
> >>>>    hw/virtio/vhost-iova-tree.c | 38 ++++++++++++++++++++++++++++++++=
-----
> >>>>    hw/virtio/vhost-iova-tree.h |  1 +
> >>>>    hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++------
> >>>>    net/vhost-vdpa.c            | 13 +++++++++++--
> >>>>    4 files changed, 70 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree=
.c
> >>>> index 3d03395a77..32c03db2f5 100644
> >>>> --- a/hw/virtio/vhost-iova-tree.c
> >>>> +++ b/hw/virtio/vhost-iova-tree.c
> >>>> @@ -28,12 +28,17 @@ struct VhostIOVATree {
> >>>>
> >>>>        /* IOVA address to qemu memory maps. */
> >>>>        IOVATree *iova_taddr_map;
> >>>> +
> >>>> +    /* IOVA tree (IOVA allocator) */
> >>>> +    IOVATree *iova_map;
> >>>>    };
> >>>>
> >>>>    /**
> >>>> - * Create a new IOVA tree
> >>>> + * Create a new VhostIOVATree with a new set of IOVATree's:
> >>> s/IOVA tree/VhostIOVATree/ is good, but I think the rest is more an
> >>> implementation detail.
> >>>
> >>>> + * - IOVA allocator (iova_map)
> >>>> + * - IOVA->HVA tree (iova_taddr_map)
> >>>>     *
> >>>> - * Returns the new IOVA tree
> >>>> + * Returns the new VhostIOVATree
> >>>>     */
> >>>>    VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova=
_last)
> >>>>    {
> >>>> @@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_fir=
st, hwaddr iova_last)
> >>>>        tree->iova_last =3D iova_last;
> >>>>
> >>>>        tree->iova_taddr_map =3D iova_tree_new();
> >>>> +    tree->iova_map =3D iova_tree_new();
> >>>>        return tree;
> >>>>    }
> >>>>
> >>>> @@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_fir=
st, hwaddr iova_last)
> >>>>    void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
> >>>>    {
> >>>>        iova_tree_destroy(iova_tree->iova_taddr_map);
> >>>> +    iova_tree_destroy(iova_tree->iova_map);
> >>>>        g_free(iova_tree);
> >>>>    }
> >>>>
> >>>> @@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tre=
e, DMAMap *map)
> >>>>        /* Some vhost devices do not like addr 0. Skip first page */
> >>>>        hwaddr iova_first =3D tree->iova_first ?: qemu_real_host_page=
_size();
> >>>>
> >>>> -    if (map->translated_addr + map->size < map->translated_addr ||
> >>> Why remove this condition? If the request is invalid we still need to
> >>> return an error here.
> >>>
> >>> Maybe we should move it to iova_tree_alloc_map though.
> >>>
> >>>> -        map->perm =3D=3D IOMMU_NONE) {
> >>>> +    if (map->perm =3D=3D IOMMU_NONE) {
> >>>>            return IOVA_ERR_INVALID;
> >>>>        }
> >>>>
> >>>>        /* Allocate a node in IOVA address */
> >>>> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_firs=
t,
> >>>> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
> >>>>                                   tree->iova_last);
> >>>>    }
> >>>>
> >>>> @@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tr=
ee, DMAMap *map)
> >>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
> >>>>    {
> >>>>        iova_tree_remove(iova_tree->iova_taddr_map, map);
> >>>> +    iova_tree_remove(iova_tree->iova_map, map);
> >>>> +}
> >>>> +
> >>>> +/**
> >>>> + * Insert a new mapping to the IOVA->HVA tree
> >>>> + *
> >>>> + * @tree: The VhostIOVATree
> >>>> + * @map: The iova map
> >>>> + *
> >>>> + * Returns:
> >>>> + * - IOVA_OK if the map fits in the container
> >>>> + * - IOVA_ERR_INVALID if the map does not make sense (like size ove=
rflow)
> >>>> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing r=
ange
> >>>> + */
> >>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
> >>>> +{
> >>>> +    if (map->translated_addr + map->size < map->translated_addr ||
> >>>> +        map->perm =3D=3D IOMMU_NONE) {
> >>>> +        return IOVA_ERR_INVALID;
> >>>> +    }
> >>>> +
> >>>> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
> >>>>    }
> >>>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree=
.h
> >>>> index 4adfd79ff0..8bf7b64786 100644
> >>>> --- a/hw/virtio/vhost-iova-tree.h
> >>>> +++ b/hw/virtio/vhost-iova-tree.h
> >>>> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const Vhos=
tIOVATree *iova_tree,
> >>>>                                            const DMAMap *map);
> >>>>    int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *m=
ap);
> >>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)=
;
> >>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
> >>>>
> >>>>    #endif
> >>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >>>> index 3cdaa12ed5..6702459065 100644
> >>>> --- a/hw/virtio/vhost-vdpa.c
> >>>> +++ b/hw/virtio/vhost-vdpa.c
> >>>> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(Mem=
oryListener *listener,
> >>>>        if (s->shadow_data) {
> >>>>            int r;
> >>>>
> >>>> -        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr,
> >>>>            mem_region.size =3D int128_get64(llsize) - 1,
> >>>>            mem_region.perm =3D IOMMU_ACCESS_FLAG(true, section->read=
only),
> >>>>
> >>>> +        /* Allocate IOVA range and add the mapping to the IOVA tree=
 */
> >>>>            r =3D vhost_iova_tree_map_alloc(s->iova_tree, &mem_region=
);
> >>>>            if (unlikely(r !=3D IOVA_OK)) {
> >>>>                error_report("Can't allocate a mapping (%d)", r);
> >>>> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(Memo=
ryListener *listener,
> >>>>            }
> >>>>
> >>>>            iova =3D mem_region.iova;
> >>>> +
> >>>> +        /* Add mapping to the IOVA->HVA tree */
> >>>> +        mem_region.translated_addr =3D (hwaddr)(uintptr_t)vaddr;
> >>>> +        r =3D vhost_iova_tree_insert(s->iova_tree, &mem_region);
> >>>> +        if (unlikely(r !=3D IOVA_OK)) {
> >>>> +            error_report("Can't add listener region mapping (%d)", =
r);
> >>>> +            goto fail_map;
> >>>> +        }
> >>> I'd say it is not intuitive for the caller code.
> >>>
> >>>>        }
> >>>>
> >>>>        vhost_vdpa_iotlb_batch_begin_once(s);
> >>>> @@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(struc=
t vhost_dev *dev,
> >>>>     *
> >>>>     * @v: Vhost-vdpa device
> >>>>     * @needle: The area to search iova
> >>>> + * @taddr: The translated address (SVQ HVA)
> >>>>     * @errorp: Error pointer
> >>>>     */
> >>>>    static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap =
*needle,
> >>>> -                                    Error **errp)
> >>>> +                                    hwaddr taddr, Error **errp)
> >>>>    {
> >>>>        int r;
> >>>>
> >>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
> >>>>        r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, needle)=
;
> >>>>        if (unlikely(r !=3D IOVA_OK)) {
> >>>>            error_setg(errp, "Cannot allocate iova (%d)", r);
> >>>>            return false;
> >>>>        }
> >>>>
> >>>> +    /* Add mapping to the IOVA->HVA tree */
> >>>> +    needle->translated_addr =3D taddr;
> >>>> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, needle);
> >>>> +    if (unlikely(r !=3D IOVA_OK)) {
> >>>> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
> >>>> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
> >>>> +        return false;
> >>>> +    }
> >>>> +
> >>>>        r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, need=
le->iova,
> >>>>                               needle->size + 1,
> >>>>                               (void *)(uintptr_t)needle->translated_=
addr,
> >>>> @@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struct =
vhost_dev *dev,
> >>>>        vhost_svq_get_vring_addr(svq, &svq_addr);
> >>>>
> >>>>        driver_region =3D (DMAMap) {
> >>>> -        .translated_addr =3D svq_addr.desc_user_addr,
> >>>>            .size =3D driver_size - 1,
> >>>>            .perm =3D IOMMU_RO,
> >>>>        };
> >>>> -    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, errp);
> >>>> +    ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc=
_user_addr,
> >>>> +                                 errp);
> >>>>        if (unlikely(!ok)) {
> >>>>            error_prepend(errp, "Cannot create vq driver region: ");
> >>>>            return false;
> >>>> @@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struct =
vhost_dev *dev,
> >>>>        addr->avail_user_addr =3D driver_region.iova + avail_offset;
> >>>>
> >>>>        device_region =3D (DMAMap) {
> >>>> -        .translated_addr =3D svq_addr.used_user_addr,
> >>>>            .size =3D device_size - 1,
> >>>>            .perm =3D IOMMU_RW,
> >>>>        };
> >>>> -    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, errp);
> >>>> +    ok =3D vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used=
_user_addr,
> >>>> +                                 errp);
> >>>>        if (unlikely(!ok)) {
> >>>>            error_prepend(errp, "Cannot create vq device region: ");
> >>>>            vhost_vdpa_svq_unmap_ring(v, driver_region.translated_add=
r);
> >>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >>>> index 03457ead66..81da956b92 100644
> >>>> --- a/net/vhost-vdpa.c
> >>>> +++ b/net/vhost-vdpa.c
> >>>> @@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vhost=
_vdpa *v, void *buf, size_t size,
> >>>>        DMAMap map =3D {};
> >>>>        int r;
> >>>>
> >>>> -    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> >>>>        map.size =3D size - 1;
> >>>>        map.perm =3D write ? IOMMU_RW : IOMMU_RO,
> >>>> +
> >>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
> >>>>        r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
> >>>>        if (unlikely(r !=3D IOVA_OK)) {
> >>>> -        error_report("Cannot map injected element");
> >>>> +        error_report("Cannot allocate IOVA range for injected eleme=
nt");
> >>>>            return r;
> >>>>        }
> >>>>
> >>>> +    /* Add mapping to the IOVA->HVA tree */
> >>>> +    map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> >>>> +    r =3D vhost_iova_tree_insert(v->shared->iova_tree, &map);
> >>>> +    if (unlikely(r !=3D IOVA_OK)) {
> >>>> +        error_report("Cannot map injected element into IOVA->HVA tr=
ee");
> >>>> +        goto dma_map_err;
> >>>> +    }
> >>>> +
> >>>>        r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, map.=
iova,
> >>>>                               vhost_vdpa_net_cvq_cmd_page_len(), buf=
, !write);
> >>>>        if (unlikely(r < 0)) {
> >>>> --
> >>>> 2.43.5
> >>>>
>


