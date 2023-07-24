Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C1D75EC1F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 09:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNpWo-0001ba-FX; Mon, 24 Jul 2023 02:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qNpWm-0001bS-Lj
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 02:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qNpWk-00005Y-ST
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 02:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690181921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew8S54Pw264F0sVGbfKptzOHkBiD5DsZN2inz8Ifnis=;
 b=gqgnvaDQylPHkhLgNQeot+7F38uYufPx+CeFByUE8cgaNq+IsPZzrCnYFHeiohGkuPl9WS
 gh2DJH+ZGcCJJ7tKFb/AmoGRU9I+k4Xop1lUb3sSpbg9vsKdKTFoDEKZ3+APnHsHqHVJdr
 P49V7V3KfuEZoZyaZ3E5rg85eJWyONU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Hw3oez43PTeJdk317AQXtA-1; Mon, 24 Jul 2023 02:58:39 -0400
X-MC-Unique: Hw3oez43PTeJdk317AQXtA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso36390141fa.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 23:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690181918; x=1690786718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ew8S54Pw264F0sVGbfKptzOHkBiD5DsZN2inz8Ifnis=;
 b=aGAlgbvXid9kf6cBoaFRq+H6adIWvizqN8BAu3Z1qV0AUMXpVzzfm0ZZQ6m080W9EN
 8IinzmF+CPR8HJUvDbhGpdOocwSJsmBnoAxqTiNhKBez1auxTwhuZEQKK6RE7gPjg2T2
 dpHiPFBHcQsLpQofiqqr90+k0/ShaB4KQkrzpxFOzzoqK5c2hAd9U+eBH7mI6yPBT+RI
 dCAClgAyXdWpXF6TpH+OkYyUKo4Iaah6gc6gSvf0mnPdDVXXFuHhz+y5Yf2xBI2gswfw
 zrD1yeCl1SGv+GyS1/FRKFw2nGaLbaWluZ8QhVfTpuRPXLIXSTu5yXRxsjkiUO18ahlG
 wTqQ==
X-Gm-Message-State: ABy/qLbI3RVignH3hFRL6WR5v+zfoXXEozGRVa5xPjABLEb19lFalSCW
 fY7qOAUA72lgeEfGkgDZtGSiy02gs7dPZF8BavMNoOnmBkLBCSoPkW5YJ5VL4FUihqEF59GpsTT
 JK3i4ILDkTeDA/PEnY+mGvCWFjqs2Wh4=
X-Received: by 2002:a2e:6a13:0:b0:2b2:90e:165d with SMTP id
 f19-20020a2e6a13000000b002b2090e165dmr5185016ljc.2.1690181918100; 
 Sun, 23 Jul 2023 23:58:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG61hDphzPL0MliHMrol7GpPsd42yfCLxd9D3XU4QRvDY3QxSmYgjIrb+1PZy2tkv4acw8fx7pOavm1ln30n0o=
X-Received: by 2002:a2e:6a13:0:b0:2b2:90e:165d with SMTP id
 f19-20020a2e6a13000000b002b2090e165dmr5185003ljc.2.1690181917800; Sun, 23 Jul
 2023 23:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
 <CACGkMEv9yVCherC89W5ihyP-iZZHDhn1xZy-8aOd4ZSs+1Dk_Q@mail.gmail.com>
 <ef14eb09-e739-3a3a-ebda-13b385a85d8e@gmail.com>
In-Reply-To: <ef14eb09-e739-3a3a-ebda-13b385a85d8e@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Jul 2023 14:58:26 +0800
Message-ID: <CACGkMEtUUq6988VJoZuPhfdODMeyMsZUkm4Pq6u4NYzEZo3zeQ@mail.gmail.com>
Subject: Re: [RFC 0/1] virtio-net: add support for SR-IOV emulation
To: Yui Washizu <yui.washidu@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, akihiko.odaki@daynix.com, 
 yvugenfi@redhat.com, ybendito@redhat.com, mapfelba@redhat.com, 
 marcel@redhat.com, ghammer@redhat.com, mdean@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 24, 2023 at 10:32=E2=80=AFAM Yui Washizu <yui.washidu@gmail.com=
> wrote:
>
>
> On 2023/07/20 11:20, Jason Wang wrote:
> > On Wed, Jul 19, 2023 at 9:59=E2=80=AFAM Yui Washizu <yui.washidu@gmail.=
com> wrote:
> >> This patch series is the first step towards enabling
> >> hardware offloading of the L2 packet switching feature on virtio-net d=
evice to host machine.
> >> We are considering that this hardware offloading enables
> >> the use of high-performance networks in virtual infrastructures,
> >> such as container infrastructures on VMs.
> >>
> >> To enable L2 packet switching by SR-IOV VFs, we are considering the fo=
llowing:
> >> - making the guest recognize virtio-net devices as SR-IOV PF devices
> >>    (archived with this patch series)
> >> - allowing virtio-net devices to connect SR-IOV VFs to the backend net=
works,
> >>    leaving the L2 packet switching feature to the management layer lik=
e libvirt
> > Could you please show the qemu command line you want to propose here?
>
>
> I am considering how to specify the properties of VFs to connect SR-IOV
> VFs to the backend networks.
>
>
> For example:
>
>
> qemu-system-x86_64 -device
> pcie-root-port,port=3D8,chassis=3D8,id=3Dpci.8,bus=3Dpcie.0,multifunction=
=3Don
>                     -netdev tap,id=3Dhostnet0,vhost=3Don
>                     -netdev tap,id=3Dvfnet1,vhost=3Don # backend network =
for
> SR-IOV VF 1
>                     -netdev tap,id=3Dvfnet2,vhost=3Don # backend network =
for
> SR-IOV VF 2
>                     -device
> virtio-net-pci,netdev=3Dhostnet0,sriov_max_vfs=3D2,sriov_netdev=3Dvfnet1:=
vfnet2,...
>
>
> In this example, we can specify multiple backend networks to the VFs
> by adding "sriov_netdev" and separating them with ":".

This seems what is in my mind as well, more below

> Additionally, when passing properties like "rx_queue_size" to VFs, we
> can utilize new properties,
> such as "sriov_rx_queue_size_per_vfs," to ensure that the same value is
> passed to all VFs.

Or we can introduce new device like:

-netdev tap,id=3Dhn0 \
-device virtio-net-pci,netdev=3Dhn0,id=3Dvnet_pf \
-netdev tap,netdev=3Dhn1 \
-device virtio-net-pci-vf,netdev=3Dhn1,id=3Dvf0,pf=3Dvnet_pf,rx_queue_size=
=3DXYZ ... \

This allows us to reuse the codes for configuring vf parameters. But
note that rx_queue_size doesn't make too much sense to vhost-vDPA, as
qemu can perform nothing more than a simple sanity test.

Thanks

>
> I'm still considering about how to specify it, so please give me any
> comments if you have any.
>
>
> >>    - This makes hardware offloading of L2 packet switching possible.
> >>      For example, when using vDPA devices, it allows the guest
> >>      to utilize SR-IOV NIC embedded switch of hosts.
> > This would be interesting.
> >
> > Thanks
> >
> >> This patch series aims to enable SR-IOV emulation on virtio-net device=
s.
> >> With this series, the guest can identify the virtio-net device as an S=
R-IOV PF device.
> >> The newly added property 'sriov_max_vfs' allows us to enable the SR-IO=
V feature
> >> on the virtio-net device.
> >> Currently, we are unable to specify the properties of a VF created fro=
m the guest.
> >> The properties are set to their default values.
> >> In the future, we plan to allow users to set the properties.
> >>
> >> qemu-system-x86_64 --device virtio-net,sriov_max_vfs=3D<num>
> >> # when 'sriov_max_vfs' is present, the SR-IOV feature will be automati=
cally enabled
> >> # <num> means the max number of VF on guest
> >>
> >> Example commands to create VFs in virtio-net device from the guest:
> >>
> >> guest% readlink -f /sys/class/net/eth1/device
> >>   /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio1
> >> guest% echo "2" > /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/sr=
iov_numvfs
> >> guest% ip link show
> >>   eth0: ....
> >>   eth1: ....
> >>   eth2: .... #virtual VF created
> >>   eth3: .... #virtual VF created
> >>
> >> Please note that communication between VF and PF/VF is not possible by=
 this patch series itself.
> >>
> >> Yui Washizu (1):
> >>    virtio-pci: add SR-IOV capability
> >>
> >>   hw/pci/msix.c                  |  8 +++--
> >>   hw/pci/pci.c                   |  4 +++
> >>   hw/virtio/virtio-pci.c         | 62 ++++++++++++++++++++++++++++++--=
--
> >>   include/hw/virtio/virtio-pci.h |  1 +
> >>   4 files changed, 66 insertions(+), 9 deletions(-)
> >>
> >> --
> >> 2.39.3
> >>
>


