Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E69180E33B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 05:14:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCu8y-0006PC-2P; Mon, 11 Dec 2023 23:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rCu8w-0006OZ-7Q
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 23:13:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rCu8u-0006wZ-Eb
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 23:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702354391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgWtDwmcWH7/x4VxCMC9H0FgHZohhl5TEIp8cZsOy8A=;
 b=Ww78DisZvZFvQhb1F5xT9huNqJ3zbPftdZFDXhDMJYgKcYmfA6w3apX1dinh8MIW9YTFaf
 yuPTyU61Ix9K/ZeuWWzBViA2qt8BDqj/R6kUlRa+0d25WPf21W+lRpcL9cQcqD7dOV35KQ
 TLskm1gDBFsf3484PJ+vF+Vcg3Vci5g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-pTTviDluMzquz3qWUTs4JQ-1; Mon, 11 Dec 2023 23:13:08 -0500
X-MC-Unique: pTTviDluMzquz3qWUTs4JQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-286a4fc4e9eso6223661a91.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 20:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702354387; x=1702959187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgWtDwmcWH7/x4VxCMC9H0FgHZohhl5TEIp8cZsOy8A=;
 b=AoP74XF7JjwnVyNQVyuAPK4VJQ9/2ylDjnQzTnp6DXE14hqpxnROpeJ1Pf55FXd7pq
 lNHwV3re5oHWP1LBBmeaRFI8kY+FdwoAVN/iVwm1YZRCqtyqIkk/UQKx5RFPrIuL7MPG
 0XUg1N9XMeT2x7pmQBX3JnSDWcrQ3nmu5whqlkP6nKy4JmV1KWS5DKDrFvciSkI/m6QO
 /jzy9F6bCb/0dWwp2WMXQDgUDKrwyoh3KjUEUTuXeBwRljBycT0LcCUjqgFZtjh2Guup
 E6cA6mYk7ANJIoLUI+32UJtdY7M1XoDx3iODnibSLU0s6AYYSupvLHXJPXE0XmCC28Q1
 PV5w==
X-Gm-Message-State: AOJu0YysdQuiuQwxVcTOFlGxGGIA46eiPSeop97fi1S9kTScPYWnLI9b
 4VmUMIrpDTXvnHspjrQhkcfx0ZqT01/7FV/cKg505vdP59IKIT7acpd/E993+inA7q4p6i/+9tX
 gaNjxJyJ+RkwI/N1vM+Mq5gejuBGJdGQ=
X-Received: by 2002:a05:6a20:5525:b0:190:5c4e:8c97 with SMTP id
 ko37-20020a056a20552500b001905c4e8c97mr5444621pzb.44.1702354386909; 
 Mon, 11 Dec 2023 20:13:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESYrP++UoUOkUIyusxljYLXIYXwNnDyl6y5pxBjj/QhVQdxfrnNGYBkIH5tKTjVclBrlQWtXeulpOX++iRrQE=
X-Received: by 2002:a05:6a20:5525:b0:190:5c4e:8c97 with SMTP id
 ko37-20020a056a20552500b001905c4e8c97mr5444614pzb.44.1702354386611; Mon, 11
 Dec 2023 20:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
 <CACGkMEuYa7CUUp6F4D91P0mg=2GadhRESCx2j63P7Fkm42q++w@mail.gmail.com>
 <dc5bb0f8-3554-40f2-b683-3b5e58377ed3@daynix.com>
 <CACGkMEtrELfC4iqHv5e9oDD0OzwwiuyEDJWq-O5ocH02YMx9Wg@mail.gmail.com>
 <0a63d0d9-23f7-4303-81e7-00d85fea371b@daynix.com>
In-Reply-To: <0a63d0d9-23f7-4303-81e7-00d85fea371b@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Dec 2023 12:12:55 +0800
Message-ID: <CACGkMEsUDQU3viO1dRS3DJzBPNHrM6ehyc+tdNbqbDG0R4us5A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/12] virtio-net: add support for SR-IOV emulation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Yui Washizu <yui.washidu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 11, 2023 at 4:29=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/12/11 16:26, Jason Wang wrote:
> > On Mon, Dec 11, 2023 at 1:30=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2023/12/11 11:52, Jason Wang wrote:
> >>> On Sun, Dec 10, 2023 at 12:06=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>
> >>>> Introduction
> >>>> ------------
> >>>>
> >>>> This series is based on the RFC series submitted by Yui Washizu[1].
> >>>> See also [2] for the context.
> >>>>
> >>>> This series enables SR-IOV emulation for virtio-net. It is useful
> >>>> to test SR-IOV support on the guest, or to expose several vDPA devic=
es
> >>>> in a VM. vDPA devices can also provide L2 switching feature for
> >>>> offloading though it is out of scope to allow the guest to configure
> >>>> such a feature.
> >>>>
> >>>> The PF side code resides in virtio-pci. The VF side code resides in
> >>>> the PCI common infrastructure, but it is restricted to work only for
> >>>> virtio-net-pci because of lack of validation.
> >>>>
> >>>> User Interface
> >>>> --------------
> >>>>
> >>>> A user can configure a SR-IOV capable virtio-net device by adding
> >>>> virtio-net-pci functions to a bus. Below is a command line example:
> >>>>     -netdev user,id=3Dn -netdev user,id=3Do
> >>>>     -netdev user,id=3Dp -netdev user,id=3Dq
> >>>>     -device pcie-root-port,id=3Db
> >>>>     -device virtio-net-pci,bus=3Db,addr=3D0x0.0x3,netdev=3Dq,sriov-p=
f=3Df
> >>>>     -device virtio-net-pci,bus=3Db,addr=3D0x0.0x2,netdev=3Dp,sriov-p=
f=3Df
> >>>>     -device virtio-net-pci,bus=3Db,addr=3D0x0.0x1,netdev=3Do,sriov-p=
f=3Df
> >>>>     -device virtio-net-pci,bus=3Db,addr=3D0x0.0x0,netdev=3Dn,id=3Df
> >>>>
> >>>> The VFs specify the paired PF with "sriov-pf" property. The PF must =
be
> >>>> added after all VFs. It is user's responsibility to ensure that VFs =
have
> >>>> function numbers larger than one of the PF, and the function numbers
> >>>> have a consistent stride.
> >>>
> >>> This seems not user friendly. Any reason we can't just allow user to
> >>> specify the stride here?
> >>
> >> It should be possible to assign addr automatically without requiring
> >> user to specify the stride. I'll try that in the next version.
> >>
> >>>
> >>> Btw, I vaguely remember qemu allows the params to be accepted as a
> >>> list. If this is true, we can accept a list of netdev here?
> >>
> >> Yes, rocker does that. But the problem is not just about getting
> >> parameters needed for VFs, which I forgot to mention in the cover lett=
er
> >> and will explain below.
> >>
> >>>
> >>>>
> >>>> Keeping VF instances
> >>>> --------------------
> >>>>
> >>>> A problem with SR-IOV emulation is that it needs to hotplug the VFs =
as
> >>>> the guest requests. Previously, this behavior was implemented by
> >>>> realizing and unrealizing VFs at runtime. However, this strategy doe=
s
> >>>> not work well for the proposed virtio-net emulation; in this proposa=
l,
> >>>> device options passed in the command line must be maintained as VFs
> >>>> are hotplugged, but they are consumed when the machine starts and no=
t
> >>>> available after that, which makes realizing VFs at runtime impossibl=
e.
> >>>
> >>> Could we store the device options in the PF?
> >>
> >> I wrote it's to store the device options, but the problem is actually
> >> more about realizing VFs at runtime instead of at the initialization t=
ime.
> >>
> >> Realizing VFs at runtime have two major problems. One is that it delay=
s
> >> the validations of options; invalid options will be noticed when the
> >> guest requests to realize VFs.
> >
> > If PCI spec allows the failure when creating VF, then it should not be
> > a problem.
>
> I doubt the spec cares such a failure at all. VF enablement should
> always work for a real hardware. It's neither user-friendly to tell
> configuration errors at runtime.

I'm not sure which options we should care about? Did you mean netdev
options or the virtio-net specific ones?

If VF stick to the same options as PF (except for the SRIOV), it
should be validated during the PF initialization.

>
> >
> >> netdevs also warn that they are not used
> >> at initialization time, not knowing that they will be used by VFs late=
r.
> >
> > We could invent things to calm down this false positive.
> >
> >> References to other QEMU objects in the option may also die before VFs
> >> are realized.
> >
> > Is there any other thing than netdev we need to consider?
>
> You will also want to set a distinct mac for each VF. Other properties
> does not matter much in my opinion.

Qemu doesn't check mac duplication now. So it's up to the mgmt layer.

>
> >
> >>
> >> The other problem is that QEMU cannot interact with the unrealized VFs=
.
> >> For example, if you type "device_add virtio-net-pci,id=3Dvf,sriov-pf=
=3Dpf"
> >> in HMP, you will expect "device_del vf" works, but it's hard to
> >> implement such behaviors with unrealized VFs.
> >
> > I think hotplug can only be done at PF level if we do that.
>
> Assuming you mean to let netdev and mac accept arrays, yes.
>
> >
> >>
> >> I was first going to compromise and allow such quirky behaviors, but I
> >> realized such a compromise is unnecessary if we reuse the PCI power do=
wn
> >> logic so I wrote v2.
> >
> > Haven't checked the code, but anything related to the PM here?
>
> You mean power management? We don't have to care about PCI power down
> for VFs because powering down a SR-IOV PCI device will reset it and thus
> disable its VFs.

Ok.

Thanks

>
> Regards,
> Akihiko Odaki
>


