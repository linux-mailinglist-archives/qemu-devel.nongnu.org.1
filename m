Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9A8C3B50
	for <lists+qemu-devel@lfdr.de>; Mon, 13 May 2024 08:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PAp-0004q7-SQ; Mon, 13 May 2024 02:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s6PAn-0004ps-Ga
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s6PAl-0003Ru-5G
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715581709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eW5FqkiVA0diQls1d+ZwaIgAr8PQu1ut6MVq6dQZdMU=;
 b=foQBxyMtBkROfDg2zzgqhiIh08ivRhvf8LSIOd0PCQqQiB/CfJW32qTt8PxdXMhrgFCTBn
 scpF3Y42OsvkExB6958yq9DrPoGRjIRSvD7LRB0qGv1sRjHqzVvqFs3P5fsd36X8lrrI3F
 bGWOD0mSRMSXWhNaLi/vaC1jfCboR/8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-tOVAiXNbPuGxGHwZm3pDeA-1; Mon, 13 May 2024 02:28:04 -0400
X-MC-Unique: tOVAiXNbPuGxGHwZm3pDeA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-61b1200cc92so70296607b3.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 23:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715581683; x=1716186483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eW5FqkiVA0diQls1d+ZwaIgAr8PQu1ut6MVq6dQZdMU=;
 b=I68UQz2VMagzEyy0UH4JsJmWIi04xXs2VlEroH9OI3VOfaJiuiFnUmM0z+8oh6DwBk
 RDIxAJ2gg5kDExrZuHAXB4JHim3XJGtqxLA/UTXbyXsfwvE/LlHnbbLlcF3w1I/lRh+5
 TQlpdPCbYAcBNWabsrwr0mwTSrpOuc+jKJJAGkG78hyICGXWke9HKmXKoJX5/Rw/1+3l
 ZfToARVGH4Hbo42YCn0i22a77OtoCXmI4fsKZLa8i8a+voGV0H1n15BuWOKTAkxg27u2
 EqUteAPlzC4yLijRI54GQvsuT4ZJU4CDZ+X3KccWp3A+mQLA5fCns3P3GqbKDlYKyxbc
 UPrw==
X-Gm-Message-State: AOJu0YwQ4kkyhI+c21PcMrDIYA42k3UFk4wboyl4irO2j96YQLonFXcJ
 U44HW+tvggD6/shP4+BHUkNMxgSd8ufyi89xF67D2X6OCdyHIobuCzfNYc0IlqhiLGRAJMvQXTy
 D18+DKqprzMVgc3qvABcPHZUZiBhHiZUxR2fiRiYCw30UJ10iQiCMl5gVFRGUZhMeIPsArhJMRM
 x4YgIy3HFTHK1JdQhi2MExjVqH0zM=
X-Received: by 2002:a05:690c:6a0e:b0:61b:33b4:b83c with SMTP id
 00721157ae682-622aff9028bmr104080667b3.7.1715581682053; 
 Sun, 12 May 2024 23:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI6kXVWVpBwuk/Pu4lBphswrcdyQgT08XXhLtdANbv5u2VhtqIvg0XlNGXeijoB4/GtAa4SjjF1mChF7aiJ8c=
X-Received: by 2002:a05:690c:6a0e:b0:61b:33b4:b83c with SMTP id
 00721157ae682-622aff9028bmr104080237b3.7.1715581680278; Sun, 12 May 2024
 23:28:00 -0700 (PDT)
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
 <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
 <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
In-Reply-To: <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 13 May 2024 08:27:24 +0200
Message-ID: <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, May 11, 2024 at 6:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, May 10, 2024 at 3:16=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, May 10, 2024 at 6:29=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, May 9, 2024 at 3:10=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Thu, May 9, 2024 at 8:27=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Thu, May 9, 2024 at 1:16=E2=80=AFAM Eugenio Perez Martin <eper=
ezma@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, May 8, 2024 at 4:29=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Martin <=
eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez Mar=
tin
> > > > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <jas=
owang@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=
=A9rez <eperezma@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > The guest may have overlapped memory regions, where=
 different GPA leads
> > > > > > > > > > > > to the same HVA.  This causes a problem when overla=
pped regions
> > > > > > > > > > > > (different GPA but same translated HVA) exists in t=
he tree, as looking
> > > > > > > > > > > > them by HVA will return them twice.
> > > > > > > > > > >
> > > > > > > > > > > I think I don't understand if there's any side effect=
 for shadow virtqueue?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > My bad, I totally forgot to put a reference to where th=
is comes from.
> > > > > > > > > >
> > > > > > > > > > Si-Wei found that during initialization this sequences =
of maps /
> > > > > > > > > > unmaps happens [1]:
> > > > > > > > > >
> > > > > > > > > > HVA                    GPA                IOVA
> > > > > > > > > > -------------------------------------------------------=
------------------------------------------------------------------
> > > > > > > > > > Map
> > > > > > > > > > [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [=
0x1000, 0x80000000)
> > > > > > > > > > [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x208=
0000000)
> > > > > > > > > > [0x80001000, 0x2000001000)
> > > > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc=
0000)
> > > > > > > > > > [0x2000001000, 0x2000021000)
> > > > > > > > > >
> > > > > > > > > > Unmap
> > > > > > > > > > [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc=
0000) [0x1000,
> > > > > > > > > > 0x20000) ???
> > > > > > > > > >
> > > > > > > > > > The third HVA range is contained in the first one, but =
exposed under a
> > > > > > > > > > different GVA (aliased). This is not "flattened" by QEM=
U, as GPA does
> > > > > > > > > > not overlap, only HVA.
> > > > > > > > > >
> > > > > > > > > > At the third chunk unmap, the current algorithm finds t=
he first chunk,
> > > > > > > > > > not the second one. This series is the way to tell the =
difference at
> > > > > > > > > > unmap time.
> > > > > > > > > >
> > > > > > > > > > [1] https://lists.nongnu.org/archive/html/qemu-devel/20=
24-04/msg00079.html
> > > > > > > > > >
> > > > > > > > > > Thanks!
> > > > > > > > >
> > > > > > > > > Ok, I was wondering if we need to store GPA(GIOVA) to HVA=
 mappings in
> > > > > > > > > the iova tree to solve this issue completely. Then there =
won't be
> > > > > > > > > aliasing issues.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I'm ok to explore that route but this has another problem. =
Both SVQ
> > > > > > > > vrings and CVQ buffers also need to be addressable by Vhost=
IOVATree,
> > > > > > > > and they do not have GPA.
> > > > > > > >
> > > > > > > > At this moment vhost_svq_translate_addr is able to handle t=
his
> > > > > > > > transparently as we translate vaddr to SVQ IOVA. How can we=
 store
> > > > > > > > these new entries? Maybe a (hwaddr)-1 GPA to signal it has =
no GPA and
> > > > > > > > then a list to go through other entries (SVQ vaddr and CVQ =
buffers).
> > > > > > >
> > > > > > > This seems to be tricky.
> > > > > > >
> > > > > > > As discussed, it could be another iova tree.
> > > > > > >
> > > > > >
> > > > > > Yes but there are many ways to add another IOVATree. Let me exp=
and & recap.
> > > > > >
> > > > > > Option 1 is to simply add another iova tree to VhostShadowVirtq=
ueue.
> > > > > > Let's call it gpa_iova_tree, as opposed to the current iova_tre=
e that
> > > > > > translates from vaddr to SVQ IOVA. To know which one to use is =
easy at
> > > > > > adding or removing, like in the memory listener, but how to kno=
w at
> > > > > > vhost_svq_translate_addr?
> > > > >
> > > > > Then we won't use virtqueue_pop() at all, we need a SVQ version o=
f
> > > > > virtqueue_pop() to translate GPA to SVQ IOVA directly?
> > > > >
> > > >
> > > > The problem is not virtqueue_pop, that's out of the
> > > > vhost_svq_translate_addr. The problem is the need of adding
> > > > conditionals / complexity in all the callers of
> > > >
> > > > > >
> > > > > > The easiest way for me is to rely on memory_region_from_host().=
 When
> > > > > > vaddr is from the guest, it returns a valid MemoryRegion. When =
it is
> > > > > > not, it returns NULL. I'm not sure if this is a valid use case,=
 it
> > > > > > just worked in my tests so far.
> > > > > >
> > > > > > Now we have the second problem: The GPA values of the regions o=
f the
> > > > > > two IOVA tree must be unique. We need to be able to find unallo=
cated
> > > > > > regions in SVQ IOVA. At this moment there is only one IOVATree,=
 so
> > > > > > this is done easily by vhost_iova_tree_map_alloc. But it is ver=
y
> > > > > > complicated with two trees.
> > > > >
> > > > > Would it be simpler if we decouple the IOVA allocator? For exampl=
e, we
> > > > > can have a dedicated gtree to track the allocated IOVA ranges. It=
 is
> > > > > shared by both
> > > > >
> > > > > 1) Guest memory (GPA)
> > > > > 2) SVQ virtqueue and buffers
> > > > >
> > > > > And another gtree to track the GPA to IOVA.
> > > > >
> > > > > The SVQ code could use either
> > > > >
> > > > > 1) one linear mappings that contains both SVQ virtqueue and buffe=
rs
> > > > >
> > > > > or
> > > > >
> > > > > 2) dynamic IOVA allocation/deallocation helpers
> > > > >
> > > > > So we don't actually need the third gtree for SVQ HVA -> SVQ IOVA=
?
> > > > >
> > > >
> > > > That's possible, but that scatters the IOVA handling code instead o=
f
> > > > keeping it self-contained in VhostIOVATree.
> > >
> > > To me, the IOVA range/allocation is orthogonal to how IOVA is used.
> > >
> > > An example is the iova allocator in the kernel.
> > >
> > > Note that there's an even simpler IOVA "allocator" in NVME passthroug=
h
> > > code, not sure it is useful here though (haven't had a deep look at
> > > that).
> > >
> >
> > I don't know enough about them to have an opinion. I keep seeing the
> > drawback of needing to synchronize both allocation & adding in all the
> > places we want to modify the IOVATree. At this moment, these are the
> > vhost-vdpa memory listener, the SVQ vring creation and removal, and
> > net CVQ buffers. But it may be more in the future.
> >
> > What are the advantages of keeping these separated that justifies
> > needing to synchronize in all these places, compared with keeping them
> > synchronized in VhostIOVATree?
>
> It doesn't need to be synchronized.
>
> Assuming guest and SVQ shares IOVA range. IOVA only needs to track
> which part of the range has been used.
>

Not sure if I follow, that is what I mean with "synchronized".

> This simplifies things, we can store GPA->IOVA mappings and SVQ ->
> IOVA mappings separately.
>

Sorry, I still cannot see the whole picture :).

Let's assume we have all the GPA mapped to specific IOVA regions, so
we have the first IOVA tree (GPA -> IOVA) filled. Now we enable SVQ
because of the migration. How can we know where we can place SVQ
vrings without having them synchronized?

At this moment we're using a tree. The tree nature of the current SVQ
IOVA -> VA makes all nodes ordered so it is more or less easy to look
for holes.

Now your proposal uses the SVQ IOVA as tree values. Should we iterate
over all of them, order them, of the two trees, and then look for
holes there?

> Thanks
>
> >
> > Thanks!
> >
>


