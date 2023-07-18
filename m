Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 750F8757A37
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 13:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLifG-0003hU-Ir; Tue, 18 Jul 2023 07:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qLifE-0003ZY-F7
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:14:44 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qLifA-0003g0-Ga
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:14:43 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b708e49059so86443461fa.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689678877; x=1692270877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDZDs9t0ux9Z+R5WIKEs5rGWUoKbm7lOlfv+E2Hq9ZE=;
 b=x+RnGzPJzuA9X4cuZPN8FIsVkfVqMA4xWEHggR0BLYLGtEWx47AzCdUWNj39QnVPsg
 f3wbbqWlmS68YdFixI/ORuOmFdJZXbtvZXpDmZIOK03lAyKgO0PQtgm33+qtHKxCmIcg
 iCeWr0dG9dw4fGUyHTJtDtfrhqAirIm0ifglGioxbs5U+QDPzK4pcwVxsWDB1a+EiDZD
 HoPlXy5CPHeUhh8r3BP32C8k5I7pFzhkIlngjDbrmvuKCOa77K7FHQA85WGCF92Gg9bj
 2e4d3R0WsM3z2qBDEu0/d66m2s7lV5L1D9obplKP7f7XUbzxBkRso0qydtbnkIK9o0ut
 R+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689678877; x=1692270877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDZDs9t0ux9Z+R5WIKEs5rGWUoKbm7lOlfv+E2Hq9ZE=;
 b=h98oMGCDRtlfA2r7Bh2boMVKLJXRqWUBzV8Zrt/cNhicfYnPvQR+7GQUHnQsRblb9v
 rg4t6nQMd75UaGfnPZWru0yVPTiBc+YTrM+U2jTMiIcjgKN7rgrooo1KrQ/coNwnemqQ
 6ywyfT4kX8yEysKLorBe4XfrDZ4n7Na9S8Tq6DF5Bu1oO0XiHYnLQuYkU23RkTBX2spT
 jPz1oEHMKWGsOqw+8MZqGzqVmMKeWOOJLsFND+SnXcC6pH6Pjewn7me5rWK9F0gNyTag
 LBPs8iM/HvReZ9NSDqSePIAoQT80cKjTZ1WvFU4MZ0DHsiAGTZahDt4P/tigh2Y/7WTA
 5y+w==
X-Gm-Message-State: ABy/qLb5D7Fmo8+d+OWTANGjA4hOmTGsLEsHY0V7BrIV8/WEvpzXifnI
 438sYIr5Jjh7ISiti9XqQtZIMl1T3qxZXOiAptujTA==
X-Google-Smtp-Source: APBJJlFNgrZGljlH5cYBVuhZEwv7vkgffNyoMINwH+1F7CnL0NHgdEkbttCUsQeqXeW+Wt2E4Ti54Tou1D24J4C20y0=
X-Received: by 2002:a2e:7e02:0:b0:2b9:3491:c3d0 with SMTP id
 z2-20020a2e7e02000000b002b93491c3d0mr5117333ljc.52.1689678876904; Tue, 18 Jul
 2023 04:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230512135122.70403-1-viktor@daynix.com>
 <20230512135122.70403-2-viktor@daynix.com>
 <CACGkMEtnTHipbuWu6BCgm=wMpekO7Ov2H4OnN47jhrnjQpCjsg@mail.gmail.com>
In-Reply-To: <CACGkMEtnTHipbuWu6BCgm=wMpekO7Ov2H4OnN47jhrnjQpCjsg@mail.gmail.com>
From: Viktor Prutyanov <viktor@daynix.com>
Date: Tue, 18 Jul 2023 14:14:26 +0300
Message-ID: <CAPv0NP5MYkhFyfO3WwJA-EGWbMgCqBA-6AqP0juFE+mF+0zRkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] virtio-pci: add handling of PCI ATS and Device-TLB
 enable/disable
To: mst@redhat.com, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, yan@daynix.com, yuri.benditovich@daynix.com, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::230;
 envelope-from=viktor@daynix.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add qemu-stable@nongnu.org

On Thu, May 18, 2023 at 9:10=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, May 12, 2023 at 9:51=E2=80=AFPM Viktor Prutyanov <viktor@daynix.c=
om> wrote:
> >
> > According to PCIe Address Translation Services specification 5.1.3.,
> > ATS Control Register has Enable bit to enable/disable ATS. Guest may
> > enable/disable PCI ATS and, accordingly, Device-TLB for the VirtIO PCI
> > device. So, raise/lower a flag and call a trigger function to pass this
> > event to a device implementation.
> >
> > Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
> > ---
> >  hw/virtio/virtio-pci.c     | 36 ++++++++++++++++++++++++++++++++++++
> >  include/hw/virtio/virtio.h |  2 ++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 02fb84a8fa..edbc0daa18 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -716,6 +716,38 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, h=
waddr addr,
> >      }
> >  }
> >
> > +static void virtio_pci_ats_ctrl_trigger(PCIDevice *pci_dev, bool enabl=
e)
> > +{
> > +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
> > +    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> > +    VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> > +
> > +    vdev->device_iotlb_enabled =3D enable;
> > +
> > +    if (k->toggle_device_iotlb) {
> > +        k->toggle_device_iotlb(vdev);
> > +    }
> > +}
> > +
> > +static void pcie_ats_config_write(PCIDevice *dev, uint32_t address,
> > +                                  uint32_t val, int len)
> > +{
> > +    uint32_t off;
> > +    uint16_t ats_cap =3D dev->exp.ats_cap;
> > +
> > +    if (!ats_cap || address < ats_cap) {
> > +        return;
> > +    }
> > +    off =3D address - ats_cap;
> > +    if (off >=3D PCI_EXT_CAP_ATS_SIZEOF) {
> > +        return;
> > +    }
> > +
> > +    if (range_covers_byte(off, len, PCI_ATS_CTRL + 1)) {
> > +        virtio_pci_ats_ctrl_trigger(dev, !!(val & PCI_ATS_CTRL_ENABLE)=
);
> > +    }
> > +}
> > +
> >  static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
> >                                  uint32_t val, int len)
> >  {
> > @@ -729,6 +761,10 @@ static void virtio_write_config(PCIDevice *pci_dev=
, uint32_t address,
> >          pcie_cap_flr_write_config(pci_dev, address, val, len);
> >      }
> >
> > +    if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
> > +        pcie_ats_config_write(pci_dev, address, val, len);
> > +    }
> > +
> >      if (range_covers_byte(address, len, PCI_COMMAND)) {
> >          if (!(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> >              virtio_set_disabled(vdev, true);
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index f6b38f7e9c..af86ed7249 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -155,6 +155,7 @@ struct VirtIODevice
> >      QLIST_HEAD(, VirtQueue) *vector_queues;
> >      QTAILQ_ENTRY(VirtIODevice) next;
> >      EventNotifier config_notifier;
> > +    bool device_iotlb_enabled;
> >  };
> >
> >  struct VirtioDeviceClass {
> > @@ -212,6 +213,7 @@ struct VirtioDeviceClass {
> >      const VMStateDescription *vmsd;
> >      bool (*primary_unplug_pending)(void *opaque);
> >      struct vhost_dev *(*get_vhost)(VirtIODevice *vdev);
> > +    void (*toggle_device_iotlb)(VirtIODevice *vdev);
> >  };
> >
> >  void virtio_instance_init_common(Object *proxy_obj, void *data,
> > --
> > 2.35.1
> >
>

