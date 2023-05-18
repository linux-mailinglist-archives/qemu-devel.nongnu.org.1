Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A46B707A14
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:11:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzWqc-0008EC-IX; Thu, 18 May 2023 02:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzWqU-0008CP-Ap
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzWqQ-0004pp-OE
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684390233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/g2mAqa15fpKbMd9OMgtc44tCIzrLtrsT4VJjw7R10=;
 b=go1POatlBk3aFtHeSv3j+B05yqMT5/Uqib66hqO/yfKBASEFIzdaprQn2GxLXIstgYuxYW
 K+i4Rwn9zKNjj7//+lFrPXu1IVbIhndAuh1TWdVJRunahGsZsw7YN4GFOZFO7kAV44LgLF
 3GdpLijxpuodj+kXHybuD1malaxpw5g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-7wUbWEgFMc2XGBaunxROQg-1; Thu, 18 May 2023 02:10:32 -0400
X-MC-Unique: 7wUbWEgFMc2XGBaunxROQg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f1385c2c35so1123795e87.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 23:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684390230; x=1686982230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/g2mAqa15fpKbMd9OMgtc44tCIzrLtrsT4VJjw7R10=;
 b=FsQAEoGWcYcE72NK6SOetTs1zUhJKLT/tQ4v9LfJIjI73I0cn0ZAvi0lETiWS0W/54
 4gXFxbHdW8oMAHg6qDrKDe6WXmABbZ2d2GGbFiXRoLzpVn6dlxQ5x93r5243xjdW6XVY
 +zDwtyZlE+yflUNUQQumpFwsmCUUGxa5bQSNz7lqsesp2ipaaHl4u8MgEWmjjQZRwA7t
 vAK+0GwWhM6opwCdLwsdVvaFiB7HpiOYoRvEa3p7QIZMkLQsDWGBGnfAlWnzOjmkU8M4
 7zXuB3YLYhOJanPw/kIXn27qEr3+BeXxjzXlIS7Ua4uQ/CG4Zsqkb9CYXdqVhZeTULzh
 wURg==
X-Gm-Message-State: AC+VfDyUdhFHufX3zJd2OHkaQTvQkuh8ZUbNxSdZM7L2OxYKRh3BM72N
 eYL7n3qbdnXZuAT/YdXXpx2mBTkqOlakTdC37zzlATjAQpLB2tKjkBbfn6f0SKj8+dc0n6ZXN8m
 Q6LGeJ05JKEBwKY4ucpptePofVTMBJaA=
X-Received: by 2002:ac2:55b8:0:b0:4f2:509b:87ba with SMTP id
 y24-20020ac255b8000000b004f2509b87bamr922833lfg.50.1684390230641; 
 Wed, 17 May 2023 23:10:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MlSGzszIwk1y6/FViKb2iK+WFCEn1HMdCr+BGX5Ozh56nL0Qco83QXkzCUxuDa3SIRs3gZAEryILgF77uzaA=
X-Received: by 2002:ac2:55b8:0:b0:4f2:509b:87ba with SMTP id
 y24-20020ac255b8000000b004f2509b87bamr922821lfg.50.1684390230332; Wed, 17 May
 2023 23:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230512135122.70403-1-viktor@daynix.com>
 <20230512135122.70403-2-viktor@daynix.com>
In-Reply-To: <20230512135122.70403-2-viktor@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 14:10:19 +0800
Message-ID: <CACGkMEtnTHipbuWu6BCgm=wMpekO7Ov2H4OnN47jhrnjQpCjsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] virtio-pci: add handling of PCI ATS and Device-TLB
 enable/disable
To: Viktor Prutyanov <viktor@daynix.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, yan@daynix.com, 
 yuri.benditovich@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 12, 2023 at 9:51=E2=80=AFPM Viktor Prutyanov <viktor@daynix.com=
> wrote:
>
> According to PCIe Address Translation Services specification 5.1.3.,
> ATS Control Register has Enable bit to enable/disable ATS. Guest may
> enable/disable PCI ATS and, accordingly, Device-TLB for the VirtIO PCI
> device. So, raise/lower a flag and call a trigger function to pass this
> event to a device implementation.
>
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/virtio-pci.c     | 36 ++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio.h |  2 ++
>  2 files changed, 38 insertions(+)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 02fb84a8fa..edbc0daa18 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -716,6 +716,38 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwa=
ddr addr,
>      }
>  }
>
> +static void virtio_pci_ats_ctrl_trigger(PCIDevice *pci_dev, bool enable)
> +{
> +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
> +    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> +    VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> +
> +    vdev->device_iotlb_enabled =3D enable;
> +
> +    if (k->toggle_device_iotlb) {
> +        k->toggle_device_iotlb(vdev);
> +    }
> +}
> +
> +static void pcie_ats_config_write(PCIDevice *dev, uint32_t address,
> +                                  uint32_t val, int len)
> +{
> +    uint32_t off;
> +    uint16_t ats_cap =3D dev->exp.ats_cap;
> +
> +    if (!ats_cap || address < ats_cap) {
> +        return;
> +    }
> +    off =3D address - ats_cap;
> +    if (off >=3D PCI_EXT_CAP_ATS_SIZEOF) {
> +        return;
> +    }
> +
> +    if (range_covers_byte(off, len, PCI_ATS_CTRL + 1)) {
> +        virtio_pci_ats_ctrl_trigger(dev, !!(val & PCI_ATS_CTRL_ENABLE));
> +    }
> +}
> +
>  static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
>                                  uint32_t val, int len)
>  {
> @@ -729,6 +761,10 @@ static void virtio_write_config(PCIDevice *pci_dev, =
uint32_t address,
>          pcie_cap_flr_write_config(pci_dev, address, val, len);
>      }
>
> +    if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
> +        pcie_ats_config_write(pci_dev, address, val, len);
> +    }
> +
>      if (range_covers_byte(address, len, PCI_COMMAND)) {
>          if (!(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
>              virtio_set_disabled(vdev, true);
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index f6b38f7e9c..af86ed7249 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -155,6 +155,7 @@ struct VirtIODevice
>      QLIST_HEAD(, VirtQueue) *vector_queues;
>      QTAILQ_ENTRY(VirtIODevice) next;
>      EventNotifier config_notifier;
> +    bool device_iotlb_enabled;
>  };
>
>  struct VirtioDeviceClass {
> @@ -212,6 +213,7 @@ struct VirtioDeviceClass {
>      const VMStateDescription *vmsd;
>      bool (*primary_unplug_pending)(void *opaque);
>      struct vhost_dev *(*get_vhost)(VirtIODevice *vdev);
> +    void (*toggle_device_iotlb)(VirtIODevice *vdev);
>  };
>
>  void virtio_instance_init_common(Object *proxy_obj, void *data,
> --
> 2.35.1
>


