Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B632475A44F
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 04:22:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMJHr-0000e2-AH; Wed, 19 Jul 2023 22:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qMJHq-0000ds-6U
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 22:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qMJHm-0004L0-0H
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 22:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689819656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6QgWvh+UuAIqVDuyMUBknKqfdldNTPeuHJD1bDY7Bsk=;
 b=ON9wPXincochZB06lorpkfBf9UnzBrxiZw5eJ8pCk/U/qwFN0mm5NXiJNryewwpOgSdhwS
 KL5An2iOr52gWff2edYlvlVNW+vxgrt9q2i2koncVhmNl0U4XIVeEMeR06jKMR0LDFX9hO
 ddcSwXgY1YsU63tCEgUENwuZs+yr6lg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-8NrXGTJwPRqRwvDiGNtFdw-1; Wed, 19 Jul 2023 22:20:54 -0400
X-MC-Unique: 8NrXGTJwPRqRwvDiGNtFdw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9525b64d2so2063881fa.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 19:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689819653; x=1692411653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6QgWvh+UuAIqVDuyMUBknKqfdldNTPeuHJD1bDY7Bsk=;
 b=bIQgiIQUIXNmMVVO+St0Ix8bLnftlKaN22zWqfdsVA+yzidCIW7YH/GCTgUZKeLJdy
 k0Jqcn1Ous9lz9lUnIOU57us6FtQ3vwbewzlHin88MvSObb77o9+bDmiGt0vv0GKUeh+
 pD2iAfcHHpZmsr/fk8osxgiit4zM44BoubqbOAROV8BK2wWnrBcLbynZiToaIta3HlvG
 S1v9pV84fJgcv5+P3sgg43su0Oa60o3CtUrgRQUlEuVKCdCduDg9nm5LIL+s3CjZby0c
 +2uyIXexe7pOIiF+QaTnKnFDMaelSKhDPrBIPSk4yzS0uVdmzgXLfB4pSu0C2f9KIBjN
 lnxg==
X-Gm-Message-State: ABy/qLYDF2INKLnmidAp/vhIeRUI7KfwUyby692NR+q6wBHEd4LzpJR2
 v/Vt3ugOIUTXCIlBr3mfWcBDj1rRboYRYT5/Wnav0HtHl2LKNg4MLyqD54ADO9DSOulsK3mnhEs
 ie5GBHFux5bCN0v24UNmnVEx/vCor6RiFBmr0mHk=
X-Received: by 2002:a2e:8512:0:b0:2b6:cd40:21ad with SMTP id
 j18-20020a2e8512000000b002b6cd4021admr1108672lji.37.1689819653159; 
 Wed, 19 Jul 2023 19:20:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF/jbIharoo6ZYCmnhhowMYZGLE8awHIjB8ZIHfDBAexfA4C2y3L5pR4IfE82F7caWkAaXUTiNPVjI2E8esua4=
X-Received: by 2002:a2e:8512:0:b0:2b6:cd40:21ad with SMTP id
 j18-20020a2e8512000000b002b6cd4021admr1108663lji.37.1689819652873; Wed, 19
 Jul 2023 19:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
In-Reply-To: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jul 2023 10:20:41 +0800
Message-ID: <CACGkMEv9yVCherC89W5ihyP-iZZHDhn1xZy-8aOd4ZSs+1Dk_Q@mail.gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 19, 2023 at 9:59=E2=80=AFAM Yui Washizu <yui.washidu@gmail.com>=
 wrote:
>
> This patch series is the first step towards enabling
> hardware offloading of the L2 packet switching feature on virtio-net devi=
ce to host machine.
> We are considering that this hardware offloading enables
> the use of high-performance networks in virtual infrastructures,
> such as container infrastructures on VMs.
>
> To enable L2 packet switching by SR-IOV VFs, we are considering the follo=
wing:
> - making the guest recognize virtio-net devices as SR-IOV PF devices
>   (archived with this patch series)
> - allowing virtio-net devices to connect SR-IOV VFs to the backend networ=
ks,
>   leaving the L2 packet switching feature to the management layer like li=
bvirt

Could you please show the qemu command line you want to propose here?

>   - This makes hardware offloading of L2 packet switching possible.
>     For example, when using vDPA devices, it allows the guest
>     to utilize SR-IOV NIC embedded switch of hosts.

This would be interesting.

Thanks

>
> This patch series aims to enable SR-IOV emulation on virtio-net devices.
> With this series, the guest can identify the virtio-net device as an SR-I=
OV PF device.
> The newly added property 'sriov_max_vfs' allows us to enable the SR-IOV f=
eature
> on the virtio-net device.
> Currently, we are unable to specify the properties of a VF created from t=
he guest.
> The properties are set to their default values.
> In the future, we plan to allow users to set the properties.
>
> qemu-system-x86_64 --device virtio-net,sriov_max_vfs=3D<num>
> # when 'sriov_max_vfs' is present, the SR-IOV feature will be automatical=
ly enabled
> # <num> means the max number of VF on guest
>
> Example commands to create VFs in virtio-net device from the guest:
>
> guest% readlink -f /sys/class/net/eth1/device
>  /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio1
> guest% echo "2" > /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/sriov=
_numvfs
> guest% ip link show
>  eth0: ....
>  eth1: ....
>  eth2: .... #virtual VF created
>  eth3: .... #virtual VF created
>
> Please note that communication between VF and PF/VF is not possible by th=
is patch series itself.
>
> Yui Washizu (1):
>   virtio-pci: add SR-IOV capability
>
>  hw/pci/msix.c                  |  8 +++--
>  hw/pci/pci.c                   |  4 +++
>  hw/virtio/virtio-pci.c         | 62 ++++++++++++++++++++++++++++++----
>  include/hw/virtio/virtio-pci.h |  1 +
>  4 files changed, 66 insertions(+), 9 deletions(-)
>
> --
> 2.39.3
>


