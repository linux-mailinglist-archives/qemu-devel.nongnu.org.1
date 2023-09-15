Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6124C7A18A2
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 10:25:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh47M-0001k5-5h; Fri, 15 Sep 2023 04:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh47H-0001ib-9V
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:23:56 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh47B-0001Nt-Uj
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:23:52 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1d63d38c74fso766191fac.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694766228; x=1695371028;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhXdDZMn7GaWpM7ZpPz0pPfTGtJeLylCkKKRRviQOuM=;
 b=pitMhl0oB7cMppY5B5dSnNmbVe8/5Wnv5I+LI8X6ZLbEs49VoNofg9pVAprlGyDubK
 VDnT5UOXFpsA2D7kZfzXluwQKAYiAQ9ON8enibEmZqxEcPuu12yp+M5ZlRIse6TnVF9J
 X1jsAZ+uwkCjD0PnBeMivKgcT9OTcEO67dskRus9scy80CLDXD027amm/YCy9tYg8xuB
 9nAHEKHoO5RQyIlA894rDU1GVLfX5qLdbyRTpt8McIVIpGfSy6YImLryoebV0lheBFce
 XqEbJLiEvJap/LfvicG6tRLx9OrT40IGx+2Wy9Jn5oatt8OMZYq08BMvq8CFPLE5Naal
 q2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694766228; x=1695371028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhXdDZMn7GaWpM7ZpPz0pPfTGtJeLylCkKKRRviQOuM=;
 b=kL7XNavZxLe7MKUHZusB09ud7Gp7B7d2E0airdAOtr8lVFpHZj8FEPeNytbeJP3X/E
 a1pnRsDrWpnm3sUUsMES4oUwUICLXcwMyjzavvMJQ0BGQ8qaOfv4wLhf+KFteXg/z5WP
 OOt246YlvldHawXkONigM2eCf636LTjtONEDzUzosima6m56DTOy3XHSW3FJOHVdoavk
 yLz7H5teizsu/2EEAe1fyGk5rlWqRyeb9vhB5IicgBsFDDUx0eNGMQwUiGOnkQBIkGp4
 UdO573kZkLjBkqqPeRXYWCUzTAPnyfmomwbrXnSK45IpyTbKLEestamTO8X/i/Gw6M0r
 6Wpw==
X-Gm-Message-State: AOJu0YyTJZV9Bag7aR//5b3izGjbcJEjTQT3f64+wgR+Iet5KgHW6G/D
 7712hMW97y2MFhbeD9X2u3dGz9RWfyHWCBmD7Cxnyw==
X-Google-Smtp-Source: AGHT+IG68DuOvVtShrGLfE2TQeNhYCdOaJ73J+IYRXIfsZivfZokLE7wwKawnBjng+rbSTDh7rU26PBEZIvXapDd25U=
X-Received: by 2002:a05:6870:8a0b:b0:1be:9a37:cf12 with SMTP id
 p11-20020a0568708a0b00b001be9a37cf12mr1208620oaq.42.1694766227954; Fri, 15
 Sep 2023 01:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230914143912.GA1066211@fedora>
In-Reply-To: <20230914143912.GA1066211@fedora>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Fri, 15 Sep 2023 10:23:36 +0200
Message-ID: <CAGNS4TbapQ7tiRZKjm4gr7PeuGzk0ohPfmFzvWCaDa0iBG39MQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Support message-based DMA in vfio-user server
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 14, 2023 at 4:39=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Thu, Sep 07, 2023 at 06:04:05AM -0700, Mattias Nissler wrote:
> > This series adds basic support for message-based DMA in qemu's vfio-use=
r
> > server. This is useful for cases where the client does not provide file
> > descriptors for accessing system memory via memory mappings. My motivat=
ing use
> > case is to hook up device models as PCIe endpoints to a hardware design=
. This
> > works by bridging the PCIe transaction layer to vfio-user, and the endp=
oint
> > does not access memory directly, but sends memory requests TLPs to the =
hardware
> > design in order to perform DMA.
> >
> > Note that there is some more work required on top of this series to get
> > message-based DMA to really work well:
> >
> > * libvfio-user has a long-standing issue where socket communication get=
s messed
> >   up when messages are sent from both ends at the same time. See
> >   https://github.com/nutanix/libvfio-user/issues/279 for more details. =
I've
> >   been engaging there and a fix is in review.
> >
> > * qemu currently breaks down DMA accesses into chunks of size 8 bytes a=
t
> >   maximum, each of which will be handled in a separate vfio-user DMA re=
quest
> >   message. This is quite terrible for large DMA accesses, such as when =
nvme
> >   reads and writes page-sized blocks for example. Thus, I would like to=
 improve
> >   qemu to be able to perform larger accesses, at least for indirect mem=
ory
> >   regions. I have something working locally, but since this will likely=
 result
> >   in more involved surgery and discussion, I am leaving this to be addr=
essed in
> >   a separate patch.
>
> Have you tried setting mr->ops->valid.max_access_size to something like
> 64 KB?

I had tried that early on, but it's not that easy unfortunately. The
memory access path eventually hits flatview_read_continue [1], where
memory_region_dispatch_read gets invoked which passes data in a single
uint64_t, which is also the unit of data that MemoryRegionOps operates
on. Thus, sizeof(uint64_t) is the current hard limit when accessing an
indirect memory region. I have some proof of concept code that extends
MemoryRegionOps with functions to read and write larger blocks, and
change the dispatching code to use these if available. I'm not sure
whether that's the right way to go though, it was just what jumped out
at me as a quick way to get what I need :-) Happy to share this code
if it helps the conversation.

There are certainly various considerations with this:
* It crossed my mind that we could introduce a separate memory region
type (I understand that indirect memory regions were originally
designed for I/O regions, accessed by the CPU, and thus naturally
limited to memop-sized accesses?). But then again perhaps we want
arbitrarily-sized accesses for potentially all memory regions, not
just those of special types?
* If we do decide to add support to MemoryRegionOps for
arbitrarily-sized accesses, that raises the question on whether this
is a 3rd, optional pair of accessors in addition to read/write and
read_with_attrs/write_with_attrs, or whether MemoryRegionOps deserves
a cleanup to expose only a single pair of arbitrarily-size accessors.
Then we'd adapt them somehow to the simpler memop-sized accessors
which existing code implements, and I think makes sense to keep for
cases where this is sufficient.
* Performance - need to keep an eye on what performance implications
these design decisions come with.

[1] https://github.com/qemu/qemu/blob/master/softmmu/physmem.c#L2744

>
> Paolo: Any suggestions for increasing DMA transaction sizes?
>
> Stefan
>
> >
> > Changes from v1:
> >
> > * Address Stefan's review comments. In particular, enforce an allocatio=
n limit
> >   and don't drop the map client callbacks given that map requests can f=
ail when
> >   hitting size limits.
> >
> > * libvfio-user version bump now included in the series.
> >
> > * Tested as well on big-endian s390x. This uncovered another byte order=
 issue
> >   in vfio-user server code that I've included a fix for.
> >
> > Changes from v2:
> >
> > * Add a preparatory patch to make bounce buffering an AddressSpace-spec=
ific
> >   concept.
> >
> > * The total buffer size limit parameter is now per AdressSpace and can =
be
> >   configured for PCIDevice via a property.
> >
> > * Store a magic value in first bytes of bounce buffer struct as a best =
effort
> >   measure to detect invalid pointers in address_space_unmap.
> >
> > Mattias Nissler (5):
> >   softmmu: Per-AddressSpace bounce buffering
> >   softmmu: Support concurrent bounce buffers
> >   Update subprojects/libvfio-user
> >   vfio-user: Message-based DMA support
> >   vfio-user: Fix config space access byte order
> >
> >  hw/pci/pci.c                  |   8 ++
> >  hw/remote/trace-events        |   2 +
> >  hw/remote/vfio-user-obj.c     |  88 +++++++++++++++++--
> >  include/exec/cpu-common.h     |   2 -
> >  include/exec/memory.h         |  39 ++++++++-
> >  include/hw/pci/pci_device.h   |   3 +
> >  softmmu/dma-helpers.c         |   4 +-
> >  softmmu/memory.c              |   4 +
> >  softmmu/physmem.c             | 155 ++++++++++++++++++----------------
> >  subprojects/libvfio-user.wrap |   2 +-
> >  10 files changed, 220 insertions(+), 87 deletions(-)
> >
> > --
> > 2.34.1
> >

