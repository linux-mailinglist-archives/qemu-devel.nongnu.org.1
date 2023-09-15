Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC2B7A16CD
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:02:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh2qL-0005WR-5T; Fri, 15 Sep 2023 03:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qh2qI-0005Ve-0I
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qh2qF-0001Dk-Jf
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694761334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BsD2uQzRs8bJURHzq3LCKuMlNXrWisw6yv/Z0fSt+sI=;
 b=hM/VyHZwICF0ozGYNHglPpy6yoBb5vFDSgHclMF8Ve398kNz/ycIZKPBDjpZmaaEnAtwTC
 KChq4YQ67gQ8MbgsyXtMC8/i/fMISsm+R4PCoVsLZZD4Eu7T1uyb6toV1DZ0M0KFXHGM5B
 +LPLp97al/WDCP6Hp/8C+rTX23kvzTY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-gig6OQixM6C8xD9Q8j9jqg-1; Fri, 15 Sep 2023 03:02:13 -0400
X-MC-Unique: gig6OQixM6C8xD9Q8j9jqg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-500b575b32aso2092106e87.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 00:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694761331; x=1695366131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsD2uQzRs8bJURHzq3LCKuMlNXrWisw6yv/Z0fSt+sI=;
 b=bp2IF0nSlOdfuS4hRGXvkiL8EzfjtT9lPovGzCOmx4dyWWetqZrDoDGvvTidEMjm/8
 UMVzQh5nNfCDSFTQskfQXEk11cqahg13a/VvrtLXSMSFtcUVSJuMPMdSHrECEfwL7kbt
 iDmZ9pZAcbIG86RxWhL84+EqeLU09ZsB3eWCw9FxVHBNxMM+o8bkZ5pItjbfj4OtIbsk
 cK7mNE8ql4HXM8+s3ys00DztbcsHN5VDtwmBdDI5jxT3XB1H+YJCxbDixWM4kgu/QEW4
 KkiRQHOpnMIG0471xknsiBcZDLU+/xjLiHuLChoZBstWDWrQfYI6y9+5wz8LxDTuquLu
 FaHw==
X-Gm-Message-State: AOJu0YzmZk1SlTjVJU3vfRT1X5JHaw4h3d86H2ubF57lQLMf+Z1u6S2H
 RcaONjcOaU02ul5QHtWAOmBnwhrlwV6C0JrfCDAan8c9Mj+yzG6xpIgSKzAGHG6NAtZn8L+hZrP
 Htt3FvrlXxxFH/Ky/+ne6hcZLtTV9JAk=
X-Received: by 2002:ac2:4bd3:0:b0:501:a583:e49a with SMTP id
 o19-20020ac24bd3000000b00501a583e49amr826108lfq.69.1694761331582; 
 Fri, 15 Sep 2023 00:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVX7iZWFTwKLDv6O0kqA3bDF/WcAdO39JLtph2SjRixnTdP+GPTfnjQo5gUGAshPBWK1+0/FqxAyWxN44a6d4=
X-Received: by 2002:ac2:4bd3:0:b0:501:a583:e49a with SMTP id
 o19-20020ac24bd3000000b00501a583e49amr826085lfq.69.1694761331254; Fri, 15 Sep
 2023 00:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
 <CACGkMEv9yVCherC89W5ihyP-iZZHDhn1xZy-8aOd4ZSs+1Dk_Q@mail.gmail.com>
 <ef14eb09-e739-3a3a-ebda-13b385a85d8e@gmail.com>
 <CACGkMEtUUq6988VJoZuPhfdODMeyMsZUkm4Pq6u4NYzEZo3zeQ@mail.gmail.com>
 <e16a6dc9-fa72-4ff6-9dd4-fbd6e36eec82@gmail.com>
 <e3f8b39f-742f-481b-b640-d6efb3437aa1@gmail.com>
In-Reply-To: <e3f8b39f-742f-481b-b640-d6efb3437aa1@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Sep 2023 15:01:59 +0800
Message-ID: <CACGkMEs4QZg6UgS7-67XLRbnLbH+knYSmWFcf_ohd5Fr3_-Amg@mail.gmail.com>
Subject: Re: [RFC 0/1] virtio-net: add support for SR-IOV emulation
To: Yui Washizu <yui.washidu@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, akihiko.odaki@daynix.com, 
 yvugenfi@redhat.com, ybendito@redhat.com, mapfelba@redhat.com, 
 marcel@redhat.com, ghammer@redhat.com, mdean@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 6, 2023 at 1:11=E2=80=AFPM Yui Washizu <yui.washidu@gmail.com> =
wrote:
>
>
> Hi Jason,
>
>
> On 2023/08/30 14:28, Yui Washizu wrote:
> >
> > On 2023/07/24 15:58, Jason Wang wrote:
> >> On Mon, Jul 24, 2023 at 10:32=E2=80=AFAM Yui Washizu <yui.washidu@gmai=
l.com>
> >> wrote:
> >>>
> >>> On 2023/07/20 11:20, Jason Wang wrote:
> >>>> On Wed, Jul 19, 2023 at 9:59=E2=80=AFAM Yui Washizu <yui.washidu@gma=
il.com>
> >>>> wrote:
> >>>>> This patch series is the first step towards enabling
> >>>>> hardware offloading of the L2 packet switching feature on
> >>>>> virtio-net device to host machine.
> >>>>> We are considering that this hardware offloading enables
> >>>>> the use of high-performance networks in virtual infrastructures,
> >>>>> such as container infrastructures on VMs.
> >>>>>
> >>>>> To enable L2 packet switching by SR-IOV VFs, we are considering
> >>>>> the following:
> >>>>> - making the guest recognize virtio-net devices as SR-IOV PF device=
s
> >>>>>     (archived with this patch series)
> >>>>> - allowing virtio-net devices to connect SR-IOV VFs to the backend
> >>>>> networks,
> >>>>>     leaving the L2 packet switching feature to the management
> >>>>> layer like libvirt
> >>>> Could you please show the qemu command line you want to propose here=
?
> >>>
> >>> I am considering how to specify the properties of VFs to connect SR-I=
OV
> >>> VFs to the backend networks.
> >>>
> >>>
> >>> For example:
> >>>
> >>>
> >>> qemu-system-x86_64 -device
> >>> pcie-root-port,port=3D8,chassis=3D8,id=3Dpci.8,bus=3Dpcie.0,multifunc=
tion=3Don
> >>>                      -netdev tap,id=3Dhostnet0,vhost=3Don
> >>>                      -netdev tap,id=3Dvfnet1,vhost=3Don # backend
> >>> network for
> >>> SR-IOV VF 1
> >>>                      -netdev tap,id=3Dvfnet2,vhost=3Don # backend
> >>> network for
> >>> SR-IOV VF 2
> >>>                      -device
> >>> virtio-net-pci,netdev=3Dhostnet0,sriov_max_vfs=3D2,sriov_netdev=3Dvfn=
et1:vfnet2,...
> >>>
> >>>
> >>>
> >>> In this example, we can specify multiple backend networks to the VFs
> >>> by adding "sriov_netdev" and separating them with ":".
> >> This seems what is in my mind as well, more below
> >>
> >>> Additionally, when passing properties like "rx_queue_size" to VFs, we
> >>> can utilize new properties,
> >>> such as "sriov_rx_queue_size_per_vfs," to ensure that the same value =
is
> >>> passed to all VFs.
> >> Or we can introduce new device like:
> >>
> >> -netdev tap,id=3Dhn0 \
> >> -device virtio-net-pci,netdev=3Dhn0,id=3Dvnet_pf \
> >> -netdev tap,netdev=3Dhn1 \
> >> -device
> >> virtio-net-pci-vf,netdev=3Dhn1,id=3Dvf0,pf=3Dvnet_pf,rx_queue_size=3DX=
YZ ... \
> >>
> >> This allows us to reuse the codes for configuring vf parameters. But
> >> note that rx_queue_size doesn't make too much sense to vhost-vDPA, as
> >> qemu can perform nothing more than a simple sanity test.
> >>
> >> Thanks
> >
> >
> > Thanks for proposing this new way.
> >
> > I have considered how to implement this.
> >
> >
> > As virtio-net-pci-vf device should show up
> >
> > on the guest only when the guest OS creates a VF,
> >
> > the guest must not be able to see the VF device on PCI bus when qemu
> > starts.
> >
> > However, it's hard to realize this without overcomplicating
> >
> > relevant code due to current qemu implementation.
> >
> > It's because qdev_device_add_from_qdict,
> >
> > a function which is called when devices are specified
> >
> > with "-device" option of qemu startup command,
> >
> > always create devices by qdev_new and qdev_realize.
> >
> > It might be possible that we fix it
> >
> > so that qdev_new/qdev_realize aren't triggered for virtio-net-pci-vf
> > devices,
> >
> > but It seems that we need to special case the device in very generic co=
de
> >
> > like qdev_device_add_from_qdict(), qdev_device_add(),
> >
> > device_init_func() or their caller function.
> >
> >
> > Given my current ideas,
> >
> > it seems like this PATCH could become complex.
> >
> > Woule you have any suggestions
> >
> > for achieving this in more simple way possible ?
> >
> >
>
> I was wondering if you could give me some feedback.
> Best regard.

Sorry for the late reply, I think we can start from the easy way from
your point and see.

Thanks

>
>
> >
> >>> I'm still considering about how to specify it, so please give me any
> >>> comments if you have any.
> >>>
> >>>
> >>>>>     - This makes hardware offloading of L2 packet switching possibl=
e.
> >>>>>       For example, when using vDPA devices, it allows the guest
> >>>>>       to utilize SR-IOV NIC embedded switch of hosts.
> >>>> This would be interesting.
> >>>>
> >>>> Thanks
> >>>>
> >>>>> This patch series aims to enable SR-IOV emulation on virtio-net
> >>>>> devices.
> >>>>> With this series, the guest can identify the virtio-net device as
> >>>>> an SR-IOV PF device.
> >>>>> The newly added property 'sriov_max_vfs' allows us to enable the
> >>>>> SR-IOV feature
> >>>>> on the virtio-net device.
> >>>>> Currently, we are unable to specify the properties of a VF created
> >>>>> from the guest.
> >>>>> The properties are set to their default values.
> >>>>> In the future, we plan to allow users to set the properties.
> >>>>>
> >>>>> qemu-system-x86_64 --device virtio-net,sriov_max_vfs=3D<num>
> >>>>> # when 'sriov_max_vfs' is present, the SR-IOV feature will be
> >>>>> automatically enabled
> >>>>> # <num> means the max number of VF on guest
> >>>>>
> >>>>> Example commands to create VFs in virtio-net device from the guest:
> >>>>>
> >>>>> guest% readlink -f /sys/class/net/eth1/device
> >>>>> /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio1
> >>>>> guest% echo "2" >
> >>>>> /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/sriov_numvfs
> >>>>> guest% ip link show
> >>>>>    eth0: ....
> >>>>>    eth1: ....
> >>>>>    eth2: .... #virtual VF created
> >>>>>    eth3: .... #virtual VF created
> >>>>>
> >>>>> Please note that communication between VF and PF/VF is not
> >>>>> possible by this patch series itself.
> >>>>>
> >>>>> Yui Washizu (1):
> >>>>>     virtio-pci: add SR-IOV capability
> >>>>>
> >>>>>    hw/pci/msix.c                  |  8 +++--
> >>>>>    hw/pci/pci.c                   |  4 +++
> >>>>>    hw/virtio/virtio-pci.c         | 62
> >>>>> ++++++++++++++++++++++++++++++----
> >>>>>    include/hw/virtio/virtio-pci.h |  1 +
> >>>>>    4 files changed, 66 insertions(+), 9 deletions(-)
> >>>>>
> >>>>> --
> >>>>> 2.39.3
> >>>>>
>


