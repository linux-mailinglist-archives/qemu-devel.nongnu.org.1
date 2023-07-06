Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFE074A399
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:09:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHTOX-00005w-MB; Thu, 06 Jul 2023 14:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qHTOW-0008WL-HA
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qHTOU-00049d-GS
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688666873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHuHrux1nKF21nU2M29iUC+4GdGa0o5+iwBeOUDZtW8=;
 b=KK6XnT1/MfZ/O7eJxudSmKcFtKJb53bIx6w7RefD5YewS5yKgC7ox5ScnYbRWEOu0sIG35
 Nz/cSI/VNdWo27o/utloI03kfvO1JyQC7D/NoX/2PJvwSVICSPz9UkUiB2hyB6OdFxbRky
 1AYz4djLbT5oBQvplqHmAGgxYIMX/5E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-6TRR5Ci4N0au39gjsVNcQQ-1; Thu, 06 Jul 2023 14:07:52 -0400
X-MC-Unique: 6TRR5Ci4N0au39gjsVNcQQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40327302341so9252221cf.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688666871; x=1691258871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHuHrux1nKF21nU2M29iUC+4GdGa0o5+iwBeOUDZtW8=;
 b=DcnyOWPCZIZ5a+XHVZlhUm395UvFz9dH01GlMN2E9kl3FkhaE3bniAQijT4z2kZp84
 UAN645tVz9A+RpwvFx1SWvF9GMbQecjaFeYxD8A2qi2dtyFkkoHi+eR1/H9NMI6M6R0Z
 sNFsmJ4lPw6L+0mpDM9q6pOu01s84269N0zoDfbGZuiZELVLU4orY29+twnCGN122OVp
 1L2keL61mVrMUoewFA5N+io1uJf5439cenQmAhXWK0catMbi3mEsAUa/mKsLrUe1RLuA
 YqTFHwW0Yy/6TXLLfJUeK+VSIdmHBbzJ3hKgJU7ZKkn0cyA/2vKr5gqdFHsYQFOfYWTd
 MbhQ==
X-Gm-Message-State: ABy/qLY4pwjxHNU70e77kFBl+NgWC9+PO5cs22ow+vrHvPoeucnmVTlO
 ULS7MCkpk58g+XBHhjwunhOTRWUBAZm3LyZApyrPsxttKqEy+jyhOCFYBanbsrIt7oWoVwam0bq
 MSEQkD1aEUvZfprBxF4+bKGIzOHfHvfk=
X-Received: by 2002:ac8:7fc2:0:b0:403:92b9:abd0 with SMTP id
 b2-20020ac87fc2000000b0040392b9abd0mr1964225qtk.51.1688666871476; 
 Thu, 06 Jul 2023 11:07:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFJblDDNltiLfzFG/QiSjAg+YLu9TDXcB9hZ6kcdUzx34Y/86uquuBcbvWb8MSHhrkZnX4FArDsot9x2xjXFIA=
X-Received: by 2002:ac8:7fc2:0:b0:403:92b9:abd0 with SMTP id
 b2-20020ac87fc2000000b0040392b9abd0mr1964207qtk.51.1688666871208; Thu, 06 Jul
 2023 11:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
In-Reply-To: <ZKbRRt8ESGsMz+o7@x1n>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Thu, 6 Jul 2023 15:07:40 -0300
Message-ID: <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lsoaresp@redhat.com;
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

On Thu, Jul 6, 2023 at 11:35=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jul 06, 2023 at 01:55:47AM -0300, Leonardo Bras wrote:
> > When trying to migrate a machine type pc-q35-6.0 or lower, with this
> > cmdline options,
> >
> > -device driver=3Dpcie-root-port,port=3D18,chassis=3D19,id=3Dpcie-root-p=
ort18,bus=3Dpcie.0,addr=3D0x12 \
> > -device driver=3Dnec-usb-xhci,p2=3D4,p3=3D4,id=3Dnex-usb-xhci0,bus=3Dpc=
ie-root-port18,addr=3D0x12.0x1
> >
> > the following bug happens after all ram pages were sent:
> >
> > qemu-kvm: get_pci_config_device: Bad config data: i=3D0x6e read: 0 devi=
ce: 40 cmask: ff wmask: 0 w1cmask:19
> > qemu-kvm: Failed to load PCIDevice:config
> > qemu-kvm: Failed to load pcie-root-port:parent_obj.parent_obj.parent_ob=
j
> > qemu-kvm: error while loading state for instance 0x0 of device '0000:00=
:12.0/pcie-root-port'
> > qemu-kvm: load of migration failed: Invalid argument
> >
> > This happens on pc-q35-6.0 or lower because of:
> > { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
> >
> > In this scenario, hotplug_handler_plug() calls pcie_cap_slot_plug_cb(),
> > which sets dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to signal =
PCI
> > hotplug for the guest. After a while the guest will deal with this hotp=
lug
> > and qemu will clear the above bit.
>
> Do you mean that the bit will be cleared after this point for the whole
> lifecycle of the VM, as long as the pcie topology doesn't change again?
>
> "This bit indicates the presence of an adapter in the slot"
>
> IIUC the adapter in the slot is there, why it's cleared rather than set?

Fort some reason the guest is powering down the device, and we have in qemu=
:

 /*
     * If the slot is populated, power indicator is off and power
     * controller is off, it is safe to detach the devices.
     *
     * Note: don't detach if condition was already true:
     * this is a work around for guests that overwrite
     * control of powered off slots before powering them on.
     */
    if ((sltsta & PCI_EXP_SLTSTA_PDS) && pcie_sltctl_powered_off(val) &&
        !pcie_sltctl_powered_off(old_slt_ctl))
    {
        pcie_cap_slot_do_unplug(dev);  // clears PCI_EXP_SLTSTA_PDS
    }


>
> >
> > Then, during migration, get_pci_config_device() will compare the
> > configs of both the freshly created device and the one that is being
> > received via migration, which will differ due to the PCI_EXP_SLTSTA_PDS=
 bit
> > and cause the bug to reproduce.
> >
> > To avoid this fake incompatibility, there are tree fields in PCIDevice =
that
> > can help:
> >
> > - wmask: Used to implement R/W bytes, and
> > - w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
> > - cmask: Used to enable config checks on load.
> >
> > According to PCI Express=C2=AE Base Specification Revision 5.0 Version =
1.0,
> > table 7-27 (Slot Status Register) bit 6, the "Presence Detect State" is
> > listed as RO (read-only), so it only makes sense to make use of the cma=
sk
> > field.
> >
> > So, clear PCI_EXP_SLTSTA_PDS bit on cmask, so the fake incompatibility =
on
> > get_pci_config_device() does not abort the migration.
>
> Yes, using cmask makes more sense to me, but we'd need some pci developer
> to ack it at last I guess, anyway.

Agree! I am waiting for Michael's opinion on this.

>
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2215819
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
>
> I asked the same question, and I still keep confused: whether there's a
> first bad commit?  Starting from when it fails?
>
> For example, is this broken on 6.0 binaries too with pc-q35-6.0?

I tested for qemu 6.0, and it still reproduces, but have not pursued
this any further.

>
> Thanks,


Thank you!
Leo

>
> > ---
> >  hw/pci/pcie.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index b8c24cf45f..cae56bf1c8 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -659,6 +659,10 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *=
s)
> >      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
> >                                 PCI_EXP_HP_EV_SUPPORTED);
> >
> > +    /* Avoid migration abortion when this device hot-removed by guest =
*/
> > +    pci_word_test_and_clear_mask(dev->cmask + pos + PCI_EXP_SLTSTA,
> > +                                 PCI_EXP_SLTSTA_PDS);
> > +
> >      dev->exp.hpev_notified =3D false;
> >
> >      qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev=
))),
> > --
> > 2.41.0
> >
>
> --
> Peter Xu
>


