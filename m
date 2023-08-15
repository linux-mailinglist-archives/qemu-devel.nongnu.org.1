Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4910677C52B
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 03:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVj21-0000zN-Iw; Mon, 14 Aug 2023 21:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qVj1x-0000yt-Si
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 21:39:33 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qVj1u-00076h-3K
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 21:39:33 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6bd045336c6so4472166a34.2
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 18:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692063446; x=1692668246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=22E7ZwOJGQo9LBRhZMWNd42RHFoSoPi+brFytl/NgEE=;
 b=yWLUrqyVtFvCu4TWbQIZOBtc14CvMbAyk6FguZjLRcV90TA5vUq62TXupUQfApYri9
 SlwHdlHHOuD9iHXP2MYexiPiiNHSOMUZH7FU8q1pHHE4KwIrqxQP4aPAbJ8fdYaS/OEi
 FqlQuh6fZmjK0/u6uAUEVzmEElBV2K+CWew0lTTO4932DIUo9bF1G4OasoUirXqh5VZe
 C8qZx9KJum4IC3zNRc/D3Q8AwcnkTKL410ogSwsdIMSx8yOuyjpddkDzS3GL03iIhjHB
 Oo2wiAAFG0x1lvj61VVaxGZPURsEcW9MlMrZ6nQ9FDJ2g3f9yBIo2gj6slZ6Eo+LTqUY
 Tm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692063446; x=1692668246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22E7ZwOJGQo9LBRhZMWNd42RHFoSoPi+brFytl/NgEE=;
 b=iQIzO7WzeDuTe2VUUapdjSgEvj4wsp9IzUiqbMfl11dK55EqC6dah/SuXn8EyI4k/q
 BZuCtE/oqq972BCqo63SbFJ5MVbXSQa7tTQylwFFQfu2iNUQjo8BdcUEGRgriFgi6YVd
 VlZ76JYnZTeXkbvNdWFOQjjYyyzWNiM07u5mnwQCFf5EY+1D63+H569NK+p/uR9xK83T
 Nho7epW0bY2AuNlBRO+izmeQtJ3tbGmlzqOJLZrFEx3VT89OTqa6U9N8l/tXdkrlMzmn
 X+w6JBZX4BhPLIafgaXFl6mSuRtUMJ7bnRMxCDDECwN9w42PEiVhacGL3F3DgU9LIyoF
 u/Tg==
X-Gm-Message-State: AOJu0YwjvFbVYNIAmTsyOfObAbVD6kr8AZZjwIVISs2uVR32jjmrErIt
 XojbntysIkTlqYVsEDgsMeeyTvOOb23v56Ny+yI0fw==
X-Google-Smtp-Source: AGHT+IFjiiJi1/hmjMfHzxxqDFRoEnanS1+ZjRDby4nCoSJBn+06qtMXP+RJWuwn6YHycLsu/A/g7ILaCLTt6UrsU18=
X-Received: by 2002:a9d:7f8d:0:b0:6bc:b2a2:7b02 with SMTP id
 t13-20020a9d7f8d000000b006bcb2a27b02mr9634457otp.7.1692063446604; Mon, 14 Aug
 2023 18:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <169165122958.4096.6557269987206106594-0@git.sr.ht>
 <20230810183348.GA2959434@fedora>
 <CAK9dgmZiDaK89JrL30Br-V6tV1ztKnCudpDMG6tc6X1u=8=Y3A@mail.gmail.com>
 <20230814131828.GA3146793@fedora>
In-Reply-To: <20230814131828.GA3146793@fedora>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 15 Aug 2023 09:37:10 +0800
Message-ID: <CAK9dgmaxfWz7krGFhPpLA_t+mkAgt9Dcc5ii3CFUTXzdjqf-Bg@mail.gmail.com>
Subject: Re: [PATCH QEMU v2 0/3] provide a smooth upgrade solution for
 multi-queues disk
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="000000000000ac2d930602ec38fc"
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000ac2d930602ec38fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 12:28=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om>
wrote:

> On Fri, Aug 11, 2023 at 10:31:51AM +0800, Yong Huang wrote:
> > Hi, Stefan, thank you for your interest in this series.
> > I'm trying to explain my point,  if you think my explanation
> > doesn't stand up, please let me know.
> >
> > On Fri, Aug 11, 2023 at 2:33=E2=80=AFAM Stefan Hajnoczi <stefanha@redha=
t.com>
> wrote:
> >
> > > On Thu, Aug 10, 2023 at 07:07:09AM +0000, ~hyman wrote:
> > > > Ping,
> > > >
> > > > This version is a copy of version 1 and is rebased
> > > > on the master. No functional changes.
> > > >
> > > > A 1:1 virtqueue:vCPU mapping implementation for virtio-*-pci disk
> > > > introduced since qemu >=3D 5.2.0, which improves IO performance
> > > > remarkably. To enjoy this feature for exiting running VMs without
> > > > service interruption, the common solution is to migrate VMs from th=
e
> > > > lower version of the hypervisor to the upgraded hypervisor, then wa=
it
> > > > for the next cold reboot of the VM to enable this feature. That's t=
he
> > > > way "discard" and "write-zeroes" features work.
> > > >
> > > > As to multi-queues disk allocation automatically, it's a little
> > > > different because the destination will allocate queues to match the
> > > > number of vCPUs automatically by default in the case of live
> migration,
> > > > and the VMs on the source side remain 1 queue by default, which
> results
> > > > in migration failure due to loading disk VMState incorrectly on the
> > > > destination side.
> > >
> > > Are you using QEMU's versioned machine types to freeze the VM
> > > configuration?
> >
> >
> > > If not, then live migration won't work reliably because you're
> migrating
> > > between two potentially different VM configurations. This issue is no=
t
> > > specific to num-queues, it affects all device properties.
> > >
> > > In commit 9445e1e15e66c19e42bea942ba810db28052cd05 ("virtio-blk-pci:
> > > default num_queues to -smp N") the num_queues property is set to 1 fo=
r
> > > versioned machine types <=3D5.1:
> > >
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index 9ee2aa0f7b..7f65fa8743 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -31,6 +31,7 @@
> > >  GlobalProperty hw_compat_5_1[] =3D {
> > >      { "vhost-scsi", "num_queues", "1"},
> > >      { "vhost-user-scsi", "num_queues", "1"},
> > > +    { "virtio-blk-device", "num-queues", "1"},
> > >      { "virtio-scsi-device", "num_queues", "1"},
> > >  };
> > >  const size_t hw_compat_5_1_len =3D G_N_ELEMENTS(hw_compat_5_1);
> > >
> > > Live migration works when the source and destination QEMU are launche=
d
> > > with the same versioned machine type. You can check the "info qtree"
> > > output to confirm that starting a VM with -smp 4 -M pc-q35-5.1 result=
s
> > > in num-queues=3D1 while -smp 4 -M pc-q35-5.2 results in num-queues=3D=
4.
> > >
> > > > This issue requires Qemu to provide a hint that shows
> > > > multi-queues disk allocation is automatically supported, and this
> allows
> > > > upper APPs, e.g., libvirt, to recognize the hypervisor's capability
> of
> > > > this. And upper APPs can ensure to allocate the same num-queues on
> the
> > > > destination side in case of migration failure.
> > > >
> > > > To fix the issue, we introduce the auto-num-queues property for
> > > > virtio-*-pci as a solution, which would be probed by APPs, e.g.,
> libvirt
> > > > by querying the device properties of QEMU. When launching live
> > > > migration, libvirt will send the auto-num-queues property as a
> migration
> > > > cookie to the destination, and thus the destination knows if the
> source
> > > > side supports auto-num-queues. If not, the destination would switch
> off
> > > > by building the command line with "auto-num-queues=3Doff" when
> preparing
> > > > the incoming VM process. The following patches of libvirt show how =
it
> > > > roughly works:
> > > >
> > >
> https://github.com/newfriday/libvirt/commit/ce2bae2e1a6821afeb80756dc01f3=
680f525e506
> > > >
> > >
> https://github.com/newfriday/libvirt/commit/f546972b009458c88148fe079544d=
b7e9e1f43c3
> > > >
> > >
> https://github.com/newfriday/libvirt/commit/5ee19c8646fdb4d87ab8b93f287c2=
0925268ce83
> > > >
> > > > The smooth upgrade solution requires the introduction of the
> auto-num-
> > > > queues property on the QEMU side, which is what the patch set does.
> I'm
> > > > hoping for comments about the series.
> > >
> > > Please take a look at versioned machine types. I think auto-num-queue=
s
> > > is not necessary if you use versioned machine types.
> > >
> > > If you do think auto-num-queues is needed, please explain the issue i=
n
> > > more detail and state why versioned machine types don't help.
> >
> >
> > "Using the versioned machine types" is indeed the standard way to ensur=
e
> > the proper functioning of live migration.
> >
> > However, a stable version is strongly advised to maintain function in o=
ur
> > production environment and perhaps practically all the production
> > environments in other businesses. As a result, we must backport feature=
s
> > like "auto-allocation num-queues" while keeping the machine type the
> same.
> >
> > This patch set is posted for that reason. The "feature-backport" scenar=
io
> > is its target. I'm not sure if the upstream development strategy should
> > take this scenario into account; if it does, perhaps this patch set can
> be
> > of use. After all, the primary goal of this patch set is to broaden the
> uses
> > for this feature and essentially makes no functional changes.
>
> Downstreams that backport only a subset of patches instead of following
> upstream linearly must define their own versioned machine types since
> upstream versioned machine types are not relevant downstream.
>
> For example, here is how CentOS Stream defines its own machine types:
>
> https://gitlab.com/redhat/centos-stream/src/qemu-kvm/-/commit/318178778db=
60b6475d1484509bee136317156d3
>
> I think it's nicer for downstreams to define custom versioned machine
> types than to add properties like auto-num-queues that are intended for
> downstream usage and don't serve a purpose upstream.
>
> My suggestion is for you to maintain your own custom versioned machine
> types so you can systematically control device properties across
> versions. Does that make sense?


This is a long-term approach to production, and perhaps it works for us.
We'll test the options out and maintain in touch with the upstream party.

Anyway, I appreciate your interest and comments on this series. :)

Yong

>
> Stefan
>
> >
> >
> >
> >
> > > Thanks,
> > > Stefan
> > >
> > > >
> > > > Please review, thanks.
> > > > Yong
> > > >
> > > > Hyman Huang(=E9=BB=84=E5=8B=87) (3):
> > > >   virtio-scsi-pci: introduce auto-num-queues property
> > > >   virtio-blk-pci: introduce auto-num-queues property
> > > >   vhost-user-blk-pci: introduce auto-num-queues property
> > > >
> > > >  hw/block/vhost-user-blk.c          |  1 +
> > > >  hw/block/virtio-blk.c              |  1 +
> > > >  hw/scsi/vhost-scsi.c               |  2 ++
> > > >  hw/scsi/vhost-user-scsi.c          |  2 ++
> > > >  hw/scsi/virtio-scsi.c              |  2 ++
> > > >  hw/virtio/vhost-scsi-pci.c         | 11 +++++++++--
> > > >  hw/virtio/vhost-user-blk-pci.c     |  9 ++++++++-
> > > >  hw/virtio/vhost-user-scsi-pci.c    | 11 +++++++++--
> > > >  hw/virtio/virtio-blk-pci.c         |  9 ++++++++-
> > > >  hw/virtio/virtio-scsi-pci.c        | 11 +++++++++--
> > > >  include/hw/virtio/vhost-user-blk.h |  5 +++++
> > > >  include/hw/virtio/virtio-blk.h     |  5 +++++
> > > >  include/hw/virtio/virtio-scsi.h    |  5 +++++
> > > >  13 files changed, 66 insertions(+), 8 deletions(-)
> > > >
> > > > --
> > > > 2.38.5
> > > >
> > >
> >
> >
> > --
> > Best regards
>


--=20
Best regards

--000000000000ac2d930602ec38fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 15, 20=
23 at 12:28=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redha=
t.com" target=3D"_blank">stefanha@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding=
-left:1ex">On Fri, Aug 11, 2023 at 10:31:51AM +0800, Yong Huang wrote:<br>
&gt; Hi, Stefan, thank you for your interest in this series.<br>
&gt; I&#39;m trying to explain my point,=C2=A0 if you think my explanation<=
br>
&gt; doesn&#39;t stand up, please let me know.<br>
&gt; <br>
&gt; On Fri, Aug 11, 2023 at 2:33=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D=
"mailto:stefanha@redhat.com" target=3D"_blank">stefanha@redhat.com</a>&gt; =
wrote:<br>
&gt; <br>
&gt; &gt; On Thu, Aug 10, 2023 at 07:07:09AM +0000, ~hyman wrote:<br>
&gt; &gt; &gt; Ping,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This version is a copy of version 1 and is rebased<br>
&gt; &gt; &gt; on the master. No functional changes.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; A 1:1 virtqueue:vCPU mapping implementation for virtio-*-pci=
 disk<br>
&gt; &gt; &gt; introduced since qemu &gt;=3D 5.2.0, which improves IO perfo=
rmance<br>
&gt; &gt; &gt; remarkably. To enjoy this feature for exiting running VMs wi=
thout<br>
&gt; &gt; &gt; service interruption, the common solution is to migrate VMs =
from the<br>
&gt; &gt; &gt; lower version of the hypervisor to the upgraded hypervisor, =
then wait<br>
&gt; &gt; &gt; for the next cold reboot of the VM to enable this feature. T=
hat&#39;s the<br>
&gt; &gt; &gt; way &quot;discard&quot; and &quot;write-zeroes&quot; feature=
s work.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; As to multi-queues disk allocation automatically, it&#39;s a=
 little<br>
&gt; &gt; &gt; different because the destination will allocate queues to ma=
tch the<br>
&gt; &gt; &gt; number of vCPUs automatically by default in the case of live=
 migration,<br>
&gt; &gt; &gt; and the VMs on the source side remain 1 queue by default, wh=
ich results<br>
&gt; &gt; &gt; in migration failure due to loading disk VMState incorrectly=
 on the<br>
&gt; &gt; &gt; destination side.<br>
&gt; &gt;<br>
&gt; &gt; Are you using QEMU&#39;s versioned machine types to freeze the VM=
<br>
&gt; &gt; configuration?<br>
&gt; <br>
&gt; <br>
&gt; &gt; If not, then live migration won&#39;t work reliably because you&#=
39;re migrating<br>
&gt; &gt; between two potentially different VM configurations. This issue i=
s not<br>
&gt; &gt; specific to num-queues, it affects all device properties.<br>
&gt; &gt;<br>
&gt; &gt; In commit 9445e1e15e66c19e42bea942ba810db28052cd05 (&quot;virtio-=
blk-pci:<br>
&gt; &gt; default num_queues to -smp N&quot;) the num_queues property is se=
t to 1 for<br>
&gt; &gt; versioned machine types &lt;=3D5.1:<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/core/machine.c b/hw/core/machine.c<br>
&gt; &gt; index 9ee2aa0f7b..7f65fa8743 100644<br>
&gt; &gt; --- a/hw/core/machine.c<br>
&gt; &gt; +++ b/hw/core/machine.c<br>
&gt; &gt; @@ -31,6 +31,7 @@<br>
&gt; &gt;=C2=A0 GlobalProperty hw_compat_5_1[] =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 { &quot;vhost-scsi&quot;, &quot;num_queues&qu=
ot;, &quot;1&quot;},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 { &quot;vhost-user-scsi&quot;, &quot;num_queu=
es&quot;, &quot;1&quot;},<br>
&gt; &gt; +=C2=A0 =C2=A0 { &quot;virtio-blk-device&quot;, &quot;num-queues&=
quot;, &quot;1&quot;},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 { &quot;virtio-scsi-device&quot;, &quot;num_q=
ueues&quot;, &quot;1&quot;},<br>
&gt; &gt;=C2=A0 };<br>
&gt; &gt;=C2=A0 const size_t hw_compat_5_1_len =3D G_N_ELEMENTS(hw_compat_5=
_1);<br>
&gt; &gt;<br>
&gt; &gt; Live migration works when the source and destination QEMU are lau=
nched<br>
&gt; &gt; with the same versioned machine type. You can check the &quot;inf=
o qtree&quot;<br>
&gt; &gt; output to confirm that starting a VM with -smp 4 -M pc-q35-5.1 re=
sults<br>
&gt; &gt; in num-queues=3D1 while -smp 4 -M pc-q35-5.2 results in num-queue=
s=3D4.<br>
&gt; &gt;<br>
&gt; &gt; &gt; This issue requires Qemu to provide a hint that shows<br>
&gt; &gt; &gt; multi-queues disk allocation is automatically supported, and=
 this allows<br>
&gt; &gt; &gt; upper APPs, e.g., libvirt, to recognize the hypervisor&#39;s=
 capability of<br>
&gt; &gt; &gt; this. And upper APPs can ensure to allocate the same num-que=
ues on the<br>
&gt; &gt; &gt; destination side in case of migration failure.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; To fix the issue, we introduce the auto-num-queues property =
for<br>
&gt; &gt; &gt; virtio-*-pci as a solution, which would be probed by APPs, e=
.g., libvirt<br>
&gt; &gt; &gt; by querying the device properties of QEMU. When launching li=
ve<br>
&gt; &gt; &gt; migration, libvirt will send the auto-num-queues property as=
 a migration<br>
&gt; &gt; &gt; cookie to the destination, and thus the destination knows if=
 the source<br>
&gt; &gt; &gt; side supports auto-num-queues. If not, the destination would=
 switch off<br>
&gt; &gt; &gt; by building the command line with &quot;auto-num-queues=3Dof=
f&quot; when preparing<br>
&gt; &gt; &gt; the incoming VM process. The following patches of libvirt sh=
ow how it<br>
&gt; &gt; &gt; roughly works:<br>
&gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://github.com/newfriday/libvirt/commit/ce2bae2e1a=
6821afeb80756dc01f3680f525e506" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/newfriday/libvirt/commit/ce2bae2e1a6821afeb80756dc01f3680f525e=
506</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://github.com/newfriday/libvirt/commit/f546972b00=
9458c88148fe079544db7e9e1f43c3" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/newfriday/libvirt/commit/f546972b009458c88148fe079544db7e9e1f4=
3c3</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://github.com/newfriday/libvirt/commit/5ee19c8646=
fdb4d87ab8b93f287c20925268ce83" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/newfriday/libvirt/commit/5ee19c8646fdb4d87ab8b93f287c20925268c=
e83</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The smooth upgrade solution requires the introduction of the=
 auto-num-<br>
&gt; &gt; &gt; queues property on the QEMU side, which is what the patch se=
t does. I&#39;m<br>
&gt; &gt; &gt; hoping for comments about the series.<br>
&gt; &gt;<br>
&gt; &gt; Please take a look at versioned machine types. I think auto-num-q=
ueues<br>
&gt; &gt; is not necessary if you use versioned machine types.<br>
&gt; &gt;<br>
&gt; &gt; If you do think auto-num-queues is needed, please explain the iss=
ue in<br>
&gt; &gt; more detail and state why versioned machine types don&#39;t help.=
<br>
&gt; <br>
&gt; <br>
&gt; &quot;Using the versioned machine types&quot; is indeed the standard w=
ay to ensure<br>
&gt; the proper functioning of live migration.<br>
&gt; <br>
&gt; However, a stable version is strongly advised to maintain function in =
our<br>
&gt; production environment and perhaps practically all the production<br>
&gt; environments in other businesses. As a result, we must backport featur=
es<br>
&gt; like &quot;auto-allocation num-queues&quot; while keeping the machine =
type the same.<br>
&gt; <br>
&gt; This patch set is posted for that reason. The &quot;feature-backport&q=
uot; scenario<br>
&gt; is its target. I&#39;m not sure if the upstream development strategy s=
hould<br>
&gt; take this scenario into account; if it does, perhaps this patch set ca=
n be<br>
&gt; of use. After all, the primary goal of this patch set is to broaden th=
e uses<br>
&gt; for this feature and essentially makes no functional changes.<br>
<br>
Downstreams that backport only a subset of patches instead of following<br>
upstream linearly must define their own versioned machine types since<br>
upstream versioned machine types are not relevant downstream.<br>
<br>
For example, here is how CentOS Stream defines its own machine types:<br>
<a href=3D"https://gitlab.com/redhat/centos-stream/src/qemu-kvm/-/commit/31=
8178778db60b6475d1484509bee136317156d3" rel=3D"noreferrer" target=3D"_blank=
">https://gitlab.com/redhat/centos-stream/src/qemu-kvm/-/commit/318178778db=
60b6475d1484509bee136317156d3</a><br>
<br>
I think it&#39;s nicer for downstreams to define custom versioned machine<b=
r>
types than to add properties like auto-num-queues that are intended for<br>
downstream usage and don&#39;t serve a purpose upstream.<br>
<br>
My suggestion is for you to maintain your own custom versioned machine<br>
types so you can systematically control device properties across<br>
versions. Does that make sense?</blockquote><div><div class=3D"gmail_defaul=
t"><font face=3D"comic sans ms, sans-serif"><br></font></div><div class=3D"=
gmail_default"><font face=3D"comic sans ms, sans-serif">This is a long-term=
 approach to production, and perhaps it works for us.</font></div><div clas=
s=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">We&#39;ll test=
 the options out and maintain in touch with the upstream party.</font></div=
><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif"><br>=
</font></div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans=
-serif">Anyway, I appreciate your interest and comments on this series.=C2=
=A0</font><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">=
:)</span></div></div><div class=3D"gmail_default"><span style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif"><br></span></div><div class=3D"gmai=
l_default"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"=
>Yong</span></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:=
rgb(204,204,204);padding-left:1ex">
<br>
Stefan<br>
<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; &gt; Thanks,<br>
&gt; &gt; Stefan<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please review, thanks.<br>
&gt; &gt; &gt; Yong<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hyman Huang(=E9=BB=84=E5=8B=87) (3):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0virtio-scsi-pci: introduce auto-num-queues prope=
rty<br>
&gt; &gt; &gt;=C2=A0 =C2=A0virtio-blk-pci: introduce auto-num-queues proper=
ty<br>
&gt; &gt; &gt;=C2=A0 =C2=A0vhost-user-blk-pci: introduce auto-num-queues pr=
operty<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 hw/block/vhost-user-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
&gt; &gt; &gt;=C2=A0 hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt; &gt; &gt;=C2=A0 hw/scsi/vhost-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt; &gt; &gt;=C2=A0 hw/scsi/vhost-user-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 ++<br>
&gt; &gt; &gt;=C2=A0 hw/scsi/virtio-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt; &gt; &gt;=C2=A0 hw/virtio/vhost-scsi-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 11 +++++++++--<br>
&gt; &gt; &gt;=C2=A0 hw/virtio/vhost-user-blk-pci.c=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 9 ++++++++-<br>
&gt; &gt; &gt;=C2=A0 hw/virtio/vhost-user-scsi-pci.c=C2=A0 =C2=A0 | 11 ++++=
+++++--<br>
&gt; &gt; &gt;=C2=A0 hw/virtio/virtio-blk-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 9 ++++++++-<br>
&gt; &gt; &gt;=C2=A0 hw/virtio/virtio-scsi-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 11 +++++++++--<br>
&gt; &gt; &gt;=C2=A0 include/hw/virtio/vhost-user-blk.h |=C2=A0 5 +++++<br>
&gt; &gt; &gt;=C2=A0 include/hw/virtio/virtio-blk.h=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 5 +++++<br>
&gt; &gt; &gt;=C2=A0 include/hw/virtio/virtio-scsi.h=C2=A0 =C2=A0 |=C2=A0 5=
 +++++<br>
&gt; &gt; &gt;=C2=A0 13 files changed, 66 insertions(+), 8 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.38.5<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Best regards<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000ac2d930602ec38fc--

