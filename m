Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C1F8C1D72
	for <lists+qemu-devel@lfdr.de>; Fri, 10 May 2024 06:30:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Hse-0005KI-Br; Fri, 10 May 2024 00:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s5HsU-0005K0-8Q
 for qemu-devel@nongnu.org; Fri, 10 May 2024 00:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s5HsS-0001EQ-6v
 for qemu-devel@nongnu.org; Fri, 10 May 2024 00:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715315339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hK7mnHw5kPyy8AcDIqRU0cxugG5crSxPF+hI4hjQOZk=;
 b=BKBlqiZVwj3OFwUEtHfURnKbIkqZLuL37sS/qrs/TAIYaDDWjWascDeKyABp0v0f+3HI49
 bm2XNvoKrmTKOQPE2E0GbuqUidzmrahDvyfg/ojMwUMppS+gkzPvMudflx06YxKCYbXcsP
 IcFym1vn0VvNI5cEd+F7NjBEzTB5/ag=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-xuXRxHSaOmSspPmiw8dHgw-1; Fri, 10 May 2024 00:28:57 -0400
X-MC-Unique: xuXRxHSaOmSspPmiw8dHgw-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7f14f467812so878417241.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 21:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715315337; x=1715920137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hK7mnHw5kPyy8AcDIqRU0cxugG5crSxPF+hI4hjQOZk=;
 b=MpvNb5a3bYmJ8X+fs8y30KsrQk4dNKRzi5Pvu41NprusMGxEtsGvgi6TbXrnElJ+ue
 5hIZs9Nnh5ILrXzHl6YJwEGYiWRLhjDOraO7fDUkTx4dIcexzpter7nH5P+UHwPb2QGI
 ykvkHWB9GxmAwhnMmCCIuI0dnH0BakZ1VaQSYmYetcG+K8WEF6st7G0p795dtLm0Cz/w
 r/ygKUYt/0jkQw+Q0FcTFLcUYAz2qOPEYEB+z+oBCso5XkTcfVVkli19EMdeA2OQeeco
 yUrGL7IHXIaG8PYAVx8cu3zW2rYkeZUDjB3If5DK3mMeVjJF27ohQHSDIAdIs9CUUeUi
 nvXQ==
X-Gm-Message-State: AOJu0YwJvhjMaV6CKGGof/YWeaoABVwE1N8DB0f9NKwFOckPiO/bRaMw
 7eS+NnM9z+h9GuB2IgBEEwV4hEh/+eWcdAdoOgsocVQ8BVNwGXs+mqeMEBq2EPVjt1Y6aqjNDfn
 EJQTKpgKnq2PYMYo7UTlJoo9mDcs2yr9U2yDA0t/ypV22Z0N02al8VjfCiSil2qv+tJkTUwhvLe
 pFtV7IzbNjvhJclJvfspbsj+vJDkM=
X-Received: by 2002:a05:6102:160c:b0:47c:1255:dc2d with SMTP id
 ada2fe7eead31-48077ea8e35mr1921653137.33.1715315336981; 
 Thu, 09 May 2024 21:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECJxjfITjR3dObXhLx91jR1izj253GKdQhXKn+0iW3FntYNtXmLYjPNws5fBXjYKxxlayJdowkLyvY0G6KlpQ=
X-Received: by 2002:a05:6102:160c:b0:47c:1255:dc2d with SMTP id
 ada2fe7eead31-48077ea8e35mr1921636137.33.1715315336609; Thu, 09 May 2024
 21:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEuJc1ba67Hge+MfpV6npy9KJf84q=uMSP3VYDEA4FiZ=A@mail.gmail.com>
 <CAJaqyWemfoCTLr21ukNszqnqaaEbuB_h+s3R4j-eC_YvHJpEGg@mail.gmail.com>
 <CACGkMEtZEe=ONRcrmm5TNdcxkJx=p4m24VD0yx5w0u+Rn854hQ@mail.gmail.com>
 <CAJaqyWdoCYFEEQdwZiCxzaX6HuJE-0QWctJ4WBnOd97zDwbPnw@mail.gmail.com>
 <CACGkMEu328ksfMDtJheH+sdTdV4E=pJFEa5Zco2_ecskubCAGg@mail.gmail.com>
 <CAJaqyWdZFUw8H7_2Jw3j9JxLj9+3p53QZg=DF3o4OgWJYC-SaQ@mail.gmail.com>
 <CACGkMEvdBDFvwvqb_7YXqiPd-ax4Xw7e0BLBhCt_uD6-Uf+DgA@mail.gmail.com>
 <CAJaqyWdA_6Mx3mkcobmBjB5NDJt3tyqTJv2JijF0agnnBFxQxw@mail.gmail.com>
In-Reply-To: <CAJaqyWdA_6Mx3mkcobmBjB5NDJt3tyqTJv2JijF0agnnBFxQxw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 May 2024 12:28:42 +0800
Message-ID: <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
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

On Thu, May 9, 2024 at 3:10=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Thu, May 9, 2024 at 8:27=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, May 9, 2024 at 1:16=E2=80=AFAM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Wed, May 8, 2024 at 4:29=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=A9rez =
<eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > The guest may have overlapped memory regions, where diffe=
rent GPA leads
> > > > > > > > > to the same HVA.  This causes a problem when overlapped r=
egions
> > > > > > > > > (different GPA but same translated HVA) exists in the tre=
e, as looking
> > > > > > > > > them by HVA will return them twice.
> > > > > > > >
> > > > > > > > I think I don't understand if there's any side effect for s=
hadow virtqueue?
> > > > > > > >
> > > > > > >
> > > > > > > My bad, I totally forgot to put a reference to where this com=
es from.
> > > > > > >
> > > > > > > Si-Wei found that during initialization this sequences of map=
s /
> > > > > > > unmaps happens [1]:
> > > > > > >
> > > > > > > HVA                    GPA                IOVA
> > > > > > > -------------------------------------------------------------=
------------------------------------------------------------
> > > > > > > Map
> > > > > > > [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000=
, 0x80000000)
> > > > > > > [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x208000000=
0)
> > > > > > > [0x80001000, 0x2000001000)
> > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
> > > > > > > [0x2000001000, 0x2000021000)
> > > > > > >
> > > > > > > Unmap
> > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) =
[0x1000,
> > > > > > > 0x20000) ???
> > > > > > >
> > > > > > > The third HVA range is contained in the first one, but expose=
d under a
> > > > > > > different GVA (aliased). This is not "flattened" by QEMU, as =
GPA does
> > > > > > > not overlap, only HVA.
> > > > > > >
> > > > > > > At the third chunk unmap, the current algorithm finds the fir=
st chunk,
> > > > > > > not the second one. This series is the way to tell the differ=
ence at
> > > > > > > unmap time.
> > > > > > >
> > > > > > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/=
msg00079.html
> > > > > > >
> > > > > > > Thanks!
> > > > > >
> > > > > > Ok, I was wondering if we need to store GPA(GIOVA) to HVA mappi=
ngs in
> > > > > > the iova tree to solve this issue completely. Then there won't =
be
> > > > > > aliasing issues.
> > > > > >
> > > > >
> > > > > I'm ok to explore that route but this has another problem. Both S=
VQ
> > > > > vrings and CVQ buffers also need to be addressable by VhostIOVATr=
ee,
> > > > > and they do not have GPA.
> > > > >
> > > > > At this moment vhost_svq_translate_addr is able to handle this
> > > > > transparently as we translate vaddr to SVQ IOVA. How can we store
> > > > > these new entries? Maybe a (hwaddr)-1 GPA to signal it has no GPA=
 and
> > > > > then a list to go through other entries (SVQ vaddr and CVQ buffer=
s).
> > > >
> > > > This seems to be tricky.
> > > >
> > > > As discussed, it could be another iova tree.
> > > >
> > >
> > > Yes but there are many ways to add another IOVATree. Let me expand & =
recap.
> > >
> > > Option 1 is to simply add another iova tree to VhostShadowVirtqueue.
> > > Let's call it gpa_iova_tree, as opposed to the current iova_tree that
> > > translates from vaddr to SVQ IOVA. To know which one to use is easy a=
t
> > > adding or removing, like in the memory listener, but how to know at
> > > vhost_svq_translate_addr?
> >
> > Then we won't use virtqueue_pop() at all, we need a SVQ version of
> > virtqueue_pop() to translate GPA to SVQ IOVA directly?
> >
>
> The problem is not virtqueue_pop, that's out of the
> vhost_svq_translate_addr. The problem is the need of adding
> conditionals / complexity in all the callers of
>
> > >
> > > The easiest way for me is to rely on memory_region_from_host(). When
> > > vaddr is from the guest, it returns a valid MemoryRegion. When it is
> > > not, it returns NULL. I'm not sure if this is a valid use case, it
> > > just worked in my tests so far.
> > >
> > > Now we have the second problem: The GPA values of the regions of the
> > > two IOVA tree must be unique. We need to be able to find unallocated
> > > regions in SVQ IOVA. At this moment there is only one IOVATree, so
> > > this is done easily by vhost_iova_tree_map_alloc. But it is very
> > > complicated with two trees.
> >
> > Would it be simpler if we decouple the IOVA allocator? For example, we
> > can have a dedicated gtree to track the allocated IOVA ranges. It is
> > shared by both
> >
> > 1) Guest memory (GPA)
> > 2) SVQ virtqueue and buffers
> >
> > And another gtree to track the GPA to IOVA.
> >
> > The SVQ code could use either
> >
> > 1) one linear mappings that contains both SVQ virtqueue and buffers
> >
> > or
> >
> > 2) dynamic IOVA allocation/deallocation helpers
> >
> > So we don't actually need the third gtree for SVQ HVA -> SVQ IOVA?
> >
>
> That's possible, but that scatters the IOVA handling code instead of
> keeping it self-contained in VhostIOVATree.

To me, the IOVA range/allocation is orthogonal to how IOVA is used.

An example is the iova allocator in the kernel.

Note that there's an even simpler IOVA "allocator" in NVME passthrough
code, not sure it is useful here though (haven't had a deep look at
that).

Thanks


