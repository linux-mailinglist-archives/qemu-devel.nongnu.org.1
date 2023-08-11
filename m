Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6261778581
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 04:35:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUHyn-0003sf-0j; Thu, 10 Aug 2023 22:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qUHyi-0003sR-RG
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 22:34:16 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qUHye-0001cn-5A
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 22:34:16 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bca38a6618so1407341a34.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 19:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1691721128; x=1692325928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4siMo0P1/zQ8MuIBh/IllPk7NXlsefC1Q+7JSvbTjyE=;
 b=GrgmZwB5R+OzcaLymyHfqMuHbkrb0BKgKHkBSu8Y+EgSy5k3lbUIihd+EqXw/v8DSi
 khboVhHuFb3OW2dPJTByzHTti6x3zKb9U3A2oHc5ga+/uE8s7tAvGDWxHZzeKcwmBS8u
 NKVUWttvTWJ8lIzB3TcZtHJOOT6/cv8fH1Z4hh1puDl5OCWLp3CbJXPXKSxqmfW3YP/Z
 wVEDw1tCQi0eP+T8+Kz5ZQZNVFTlwSWy7HEi49SyyzLhEKCBKg1lMOhseEflOe21yLYR
 uwFaV2s48cMy0PGPP6v73lsqyHgYV0nD4Lt+MrBkI29h5EIK90whCHGJWPS0Wjry+w+I
 h2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691721128; x=1692325928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4siMo0P1/zQ8MuIBh/IllPk7NXlsefC1Q+7JSvbTjyE=;
 b=bOgoMCebLwfffR4tZ1zm+Z2P37QO7vs6VqzF5sAi0b/RsRBfdGpNvd0GS3sfuY77eP
 klSpayclDgn9MLqbGVa1iUdxhMxd0JFgkox8AAlw3QDXJZubroNT+AftdCdLnLGFA+l4
 837ne6vG2nZHsOsV//LMpLj3ka66/tcG2NtjohuqktlpIVVyvdS956h5SaedwjbmwhB2
 mOiJJbjwkes2A4R4FqWt2BsmxaOPwUPIhujL8xX9IoJSEo9zLd3xo4Umv9L9NlSD5E6i
 1/0ooafAbapFfvQL/qKcXIYw37jXm7Cwc+4QfSuV61s81tk0Nh9liW5T7amChc2dqEc+
 Gp4A==
X-Gm-Message-State: AOJu0Yz9YVYyks0jRZ59vhU0j16bVX9Z91YlLQsR0t2arvt8mT90TVgl
 0cWzb8HobHlYGMPLoMTCybXjNZQHEMLB8QsiCJyzLw==
X-Google-Smtp-Source: AGHT+IHkKNr71dR0kNtFPcjxE43fXko1Wvf+i1rfQ53qEmF7cEeQ4NNWcJ3kQn6bBBHa1uwgtkLvwMxqeSv47qB5veQ=
X-Received: by 2002:a05:6830:4d8:b0:6b9:e3b0:1433 with SMTP id
 s24-20020a05683004d800b006b9e3b01433mr559667otd.37.1691721128020; Thu, 10 Aug
 2023 19:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <169165122958.4096.6557269987206106594-0@git.sr.ht>
 <20230810183348.GA2959434@fedora>
In-Reply-To: <20230810183348.GA2959434@fedora>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 11 Aug 2023 10:31:51 +0800
Message-ID: <CAK9dgmZiDaK89JrL30Br-V6tV1ztKnCudpDMG6tc6X1u=8=Y3A@mail.gmail.com>
Subject: Re: [PATCH QEMU v2 0/3] provide a smooth upgrade solution for
 multi-queues disk
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="000000000000e51e4706029c844f"
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x336.google.com
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

--000000000000e51e4706029c844f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Stefan, thank you for your interest in this series.
I'm trying to explain my point,  if you think my explanation
doesn't stand up, please let me know.

On Fri, Aug 11, 2023 at 2:33=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:

> On Thu, Aug 10, 2023 at 07:07:09AM +0000, ~hyman wrote:
> > Ping,
> >
> > This version is a copy of version 1 and is rebased
> > on the master. No functional changes.
> >
> > A 1:1 virtqueue:vCPU mapping implementation for virtio-*-pci disk
> > introduced since qemu >=3D 5.2.0, which improves IO performance
> > remarkably. To enjoy this feature for exiting running VMs without
> > service interruption, the common solution is to migrate VMs from the
> > lower version of the hypervisor to the upgraded hypervisor, then wait
> > for the next cold reboot of the VM to enable this feature. That's the
> > way "discard" and "write-zeroes" features work.
> >
> > As to multi-queues disk allocation automatically, it's a little
> > different because the destination will allocate queues to match the
> > number of vCPUs automatically by default in the case of live migration,
> > and the VMs on the source side remain 1 queue by default, which results
> > in migration failure due to loading disk VMState incorrectly on the
> > destination side.
>
> Are you using QEMU's versioned machine types to freeze the VM
> configuration?


> If not, then live migration won't work reliably because you're migrating
> between two potentially different VM configurations. This issue is not
> specific to num-queues, it affects all device properties.
>
> In commit 9445e1e15e66c19e42bea942ba810db28052cd05 ("virtio-blk-pci:
> default num_queues to -smp N") the num_queues property is set to 1 for
> versioned machine types <=3D5.1:
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 9ee2aa0f7b..7f65fa8743 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -31,6 +31,7 @@
>  GlobalProperty hw_compat_5_1[] =3D {
>      { "vhost-scsi", "num_queues", "1"},
>      { "vhost-user-scsi", "num_queues", "1"},
> +    { "virtio-blk-device", "num-queues", "1"},
>      { "virtio-scsi-device", "num_queues", "1"},
>  };
>  const size_t hw_compat_5_1_len =3D G_N_ELEMENTS(hw_compat_5_1);
>
> Live migration works when the source and destination QEMU are launched
> with the same versioned machine type. You can check the "info qtree"
> output to confirm that starting a VM with -smp 4 -M pc-q35-5.1 results
> in num-queues=3D1 while -smp 4 -M pc-q35-5.2 results in num-queues=3D4.
>
> > This issue requires Qemu to provide a hint that shows
> > multi-queues disk allocation is automatically supported, and this allow=
s
> > upper APPs, e.g., libvirt, to recognize the hypervisor's capability of
> > this. And upper APPs can ensure to allocate the same num-queues on the
> > destination side in case of migration failure.
> >
> > To fix the issue, we introduce the auto-num-queues property for
> > virtio-*-pci as a solution, which would be probed by APPs, e.g., libvir=
t
> > by querying the device properties of QEMU. When launching live
> > migration, libvirt will send the auto-num-queues property as a migratio=
n
> > cookie to the destination, and thus the destination knows if the source
> > side supports auto-num-queues. If not, the destination would switch off
> > by building the command line with "auto-num-queues=3Doff" when preparin=
g
> > the incoming VM process. The following patches of libvirt show how it
> > roughly works:
> >
> https://github.com/newfriday/libvirt/commit/ce2bae2e1a6821afeb80756dc01f3=
680f525e506
> >
> https://github.com/newfriday/libvirt/commit/f546972b009458c88148fe079544d=
b7e9e1f43c3
> >
> https://github.com/newfriday/libvirt/commit/5ee19c8646fdb4d87ab8b93f287c2=
0925268ce83
> >
> > The smooth upgrade solution requires the introduction of the auto-num-
> > queues property on the QEMU side, which is what the patch set does. I'm
> > hoping for comments about the series.
>
> Please take a look at versioned machine types. I think auto-num-queues
> is not necessary if you use versioned machine types.
>
> If you do think auto-num-queues is needed, please explain the issue in
> more detail and state why versioned machine types don't help.


"Using the versioned machine types" is indeed the standard way to ensure
the proper functioning of live migration.

However, a stable version is strongly advised to maintain function in our
production environment and perhaps practically all the production
environments in other businesses. As a result, we must backport features
like "auto-allocation num-queues" while keeping the machine type the same.

This patch set is posted for that reason. The "feature-backport" scenario
is its target. I'm not sure if the upstream development strategy should
take this scenario into account; if it does, perhaps this patch set can be
of use. After all, the primary goal of this patch set is to broaden the use=
s
for this feature and essentially makes no functional changes.




> Thanks,
> Stefan
>
> >
> > Please review, thanks.
> > Yong
> >
> > Hyman Huang(=E9=BB=84=E5=8B=87) (3):
> >   virtio-scsi-pci: introduce auto-num-queues property
> >   virtio-blk-pci: introduce auto-num-queues property
> >   vhost-user-blk-pci: introduce auto-num-queues property
> >
> >  hw/block/vhost-user-blk.c          |  1 +
> >  hw/block/virtio-blk.c              |  1 +
> >  hw/scsi/vhost-scsi.c               |  2 ++
> >  hw/scsi/vhost-user-scsi.c          |  2 ++
> >  hw/scsi/virtio-scsi.c              |  2 ++
> >  hw/virtio/vhost-scsi-pci.c         | 11 +++++++++--
> >  hw/virtio/vhost-user-blk-pci.c     |  9 ++++++++-
> >  hw/virtio/vhost-user-scsi-pci.c    | 11 +++++++++--
> >  hw/virtio/virtio-blk-pci.c         |  9 ++++++++-
> >  hw/virtio/virtio-scsi-pci.c        | 11 +++++++++--
> >  include/hw/virtio/vhost-user-blk.h |  5 +++++
> >  include/hw/virtio/virtio-blk.h     |  5 +++++
> >  include/hw/virtio/virtio-scsi.h    |  5 +++++
> >  13 files changed, 66 insertions(+), 8 deletions(-)
> >
> > --
> > 2.38.5
> >
>


--=20
Best regards

--000000000000e51e4706029c844f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Hi,=C2=A0Stefan, thank you f=
or your interest in this series.</div><div class=3D"gmail_default" style=3D=
"font-family:&quot;comic sans ms&quot;,sans-serif">I&#39;m trying to explai=
n my point, =C2=A0if you think my explanation</div><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">doesn&#39;t=
 stand up, please let me know. </div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 11, 2023 at 2:33=E2=80=AFA=
M Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border=
-left-color:rgb(204,204,204);padding-left:1ex">On Thu, Aug 10, 2023 at 07:0=
7:09AM +0000, ~hyman wrote:<br>
&gt; Ping,<br>
&gt; <br>
&gt; This version is a copy of version 1 and is rebased<br>
&gt; on the master. No functional changes.<br>
&gt; <br>
&gt; A 1:1 virtqueue:vCPU mapping implementation for virtio-*-pci disk<br>
&gt; introduced since qemu &gt;=3D 5.2.0, which improves IO performance<br>
&gt; remarkably. To enjoy this feature for exiting running VMs without<br>
&gt; service interruption, the common solution is to migrate VMs from the<b=
r>
&gt; lower version of the hypervisor to the upgraded hypervisor, then wait<=
br>
&gt; for the next cold reboot of the VM to enable this feature. That&#39;s =
the<br>
&gt; way &quot;discard&quot; and &quot;write-zeroes&quot; features work.<br=
>
&gt; <br>
&gt; As to multi-queues disk allocation automatically, it&#39;s a little<br=
>
&gt; different because the destination will allocate queues to match the<br=
>
&gt; number of vCPUs automatically by default in the case of live migration=
,<br>
&gt; and the VMs on the source side remain 1 queue by default, which result=
s<br>
&gt; in migration failure due to loading disk VMState incorrectly on the<br=
>
&gt; destination side.<br>
<br>
Are you using QEMU&#39;s versioned machine types to freeze the VM<br>
configuration?</blockquote><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-le=
ft-color:rgb(204,204,204);padding-left:1ex">
<br>
If not, then live migration won&#39;t work reliably because you&#39;re migr=
ating<br>
between two potentially different VM configurations. This issue is not<br>
specific to num-queues, it affects all device properties.<br>
<br>
In commit 9445e1e15e66c19e42bea942ba810db28052cd05 (&quot;virtio-blk-pci:<b=
r>
default num_queues to -smp N&quot;) the num_queues property is set to 1 for=
<br>
versioned machine types &lt;=3D5.1:<br>
<br>
diff --git a/hw/core/machine.c b/hw/core/machine.c<br>
index 9ee2aa0f7b..7f65fa8743 100644<br>
--- a/hw/core/machine.c<br>
+++ b/hw/core/machine.c<br>
@@ -31,6 +31,7 @@<br>
=C2=A0GlobalProperty hw_compat_5_1[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;vhost-scsi&quot;, &quot;num_queues&quot;, &quot=
;1&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;vhost-user-scsi&quot;, &quot;num_queues&quot;, =
&quot;1&quot;},<br>
+=C2=A0 =C2=A0 { &quot;virtio-blk-device&quot;, &quot;num-queues&quot;, &qu=
ot;1&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;virtio-scsi-device&quot;, &quot;num_queues&quot=
;, &quot;1&quot;},<br>
=C2=A0};<br>
=C2=A0const size_t hw_compat_5_1_len =3D G_N_ELEMENTS(hw_compat_5_1);<br>
<br>
Live migration works when the source and destination QEMU are launched<br>
with the same versioned machine type. You can check the &quot;info qtree&qu=
ot;<br>
output to confirm that starting a VM with -smp 4 -M pc-q35-5.1 results<br>
in num-queues=3D1 while -smp 4 -M pc-q35-5.2 results in num-queues=3D4.<br>
<br>
&gt; This issue requires Qemu to provide a hint that shows<br>
&gt; multi-queues disk allocation is automatically supported, and this allo=
ws<br>
&gt; upper APPs, e.g., libvirt, to recognize the hypervisor&#39;s capabilit=
y of<br>
&gt; this. And upper APPs can ensure to allocate the same num-queues on the=
<br>
&gt; destination side in case of migration failure.<br>
&gt; <br>
&gt; To fix the issue, we introduce the auto-num-queues property for<br>
&gt; virtio-*-pci as a solution, which would be probed by APPs, e.g., libvi=
rt<br>
&gt; by querying the device properties of QEMU. When launching live<br>
&gt; migration, libvirt will send the auto-num-queues property as a migrati=
on<br>
&gt; cookie to the destination, and thus the destination knows if the sourc=
e<br>
&gt; side supports auto-num-queues. If not, the destination would switch of=
f<br>
&gt; by building the command line with &quot;auto-num-queues=3Doff&quot; wh=
en preparing<br>
&gt; the incoming VM process. The following patches of libvirt show how it<=
br>
&gt; roughly works:<br>
&gt; <a href=3D"https://github.com/newfriday/libvirt/commit/ce2bae2e1a6821a=
feb80756dc01f3680f525e506" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/newfriday/libvirt/commit/ce2bae2e1a6821afeb80756dc01f3680f525e506</=
a><br>
&gt; <a href=3D"https://github.com/newfriday/libvirt/commit/f546972b009458c=
88148fe079544db7e9e1f43c3" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/newfriday/libvirt/commit/f546972b009458c88148fe079544db7e9e1f43c3</=
a><br>
&gt; <a href=3D"https://github.com/newfriday/libvirt/commit/5ee19c8646fdb4d=
87ab8b93f287c20925268ce83" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/newfriday/libvirt/commit/5ee19c8646fdb4d87ab8b93f287c20925268ce83</=
a><br>
&gt; <br>
&gt; The smooth upgrade solution requires the introduction of the auto-num-=
<br>
&gt; queues property on the QEMU side, which is what the patch set does. I&=
#39;m<br>
&gt; hoping for comments about the series.<br>
<br>
Please take a look at versioned machine types. I think auto-num-queues<br>
is not necessary if you use versioned machine types.<br>
<br>
If you do think auto-num-queues is needed, please explain the issue in<br>
more detail and state why versioned machine types don&#39;t help.</blockquo=
te><div><br></div><div><div><div><span class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">&quot;Using the=C2=A0</span>=
<span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">versioned =
machine types&quot; is <span class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif">indeed=C2=A0</span>the standard way to=
<span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif"> ensure</span></span></div><div><span style=3D"font-family:&q=
uot;comic sans ms&quot;,sans-serif"><span class=3D"gmail_default" style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif">the proper functioning of=
 live migration.</span></span></div></div><div><br></div><div><span class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">However, a stable version is strongly advised to maintain function in ou=
r</span></div><div><span class=3D"gmail_default" style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif">production environment and perhaps practic=
ally all the production</span></div><div><span class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">environments in othe=
r businesses. As a result, we must backport features</span></div><div><span=
 class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif">like &quot;auto-allocation num-queues&quot; while keeping the mach=
ine type the same.</span></div><div><span class=3D"gmail_default" style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif"><br></span></div><div><sp=
an class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif">This patch set is posted for that reason. The &quot;feature-back=
port&quot; scenario</span></div><div><span class=3D"gmail_default" style=3D=
"font-family:&quot;comic sans ms&quot;,sans-serif">is its target. I&#39;m n=
ot sure if the upstream development strategy should</span></div><div><span =
class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif">take this scenario into account; if it does, perhaps this patch set=
 can be</span></div><div><span class=3D"gmail_default" style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif">of use. After all, the primary goal =
of this patch set is to broaden the uses</span></div><div><span class=3D"gm=
ail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">for=
 this feature and essentially makes no functional changes.</span></div></di=
v><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:r=
gb(204,204,204);padding-left:1ex">=C2=A0</blockquote><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Stefan<br>
<br>
&gt; <br>
&gt; Please review, thanks.<br>
&gt; Yong<br>
&gt; <br>
&gt; Hyman Huang(=E9=BB=84=E5=8B=87) (3):<br>
&gt;=C2=A0 =C2=A0virtio-scsi-pci: introduce auto-num-queues property<br>
&gt;=C2=A0 =C2=A0virtio-blk-pci: introduce auto-num-queues property<br>
&gt;=C2=A0 =C2=A0vhost-user-blk-pci: introduce auto-num-queues property<br>
&gt; <br>
&gt;=C2=A0 hw/block/vhost-user-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 1 +<br>
&gt;=C2=A0 hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 hw/scsi/vhost-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 hw/scsi/vhost-user-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 ++<br>
&gt;=C2=A0 hw/scsi/virtio-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 ++<br>
&gt;=C2=A0 hw/virtio/vhost-scsi-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11=
 +++++++++--<br>
&gt;=C2=A0 hw/virtio/vhost-user-blk-pci.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 9 ++++=
++++-<br>
&gt;=C2=A0 hw/virtio/vhost-user-scsi-pci.c=C2=A0 =C2=A0 | 11 +++++++++--<br=
>
&gt;=C2=A0 hw/virtio/virtio-blk-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 9 ++++++++-<br>
&gt;=C2=A0 hw/virtio/virtio-scsi-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 ++++=
+++++--<br>
&gt;=C2=A0 include/hw/virtio/vhost-user-blk.h |=C2=A0 5 +++++<br>
&gt;=C2=A0 include/hw/virtio/virtio-blk.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++++=
+<br>
&gt;=C2=A0 include/hw/virtio/virtio-scsi.h=C2=A0 =C2=A0 |=C2=A0 5 +++++<br>
&gt;=C2=A0 13 files changed, 66 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.38.5<br>
&gt; <br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000e51e4706029c844f--

