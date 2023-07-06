Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FB74969C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 09:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHJYm-0005r7-0Y; Thu, 06 Jul 2023 03:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHJYj-0005ka-KR
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHJYg-0003LQ-Di
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688629065;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dIlBc8EkbhJuK1UqCFjKxe4IJSeJosADKlsQWU1B6/o=;
 b=XzUPzwZ1COaWFkRcnv5Vw/1a6SvO1BH0tHSIbx7QGcAY2G0XkMnBIS/wFfOBXcc1HyMuB6
 v7HX4uK2S3IZ4EXs8J35Hq5VRZShzBy/mZATVs4pwWDBdOS45zO37trwXgSTKKUqT/z4GX
 wVJ5mZag60ygJMmeVOh6USnib7TGISg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-etYcNr3JNUSgWlKpGVqQaA-1; Thu, 06 Jul 2023 03:37:43 -0400
X-MC-Unique: etYcNr3JNUSgWlKpGVqQaA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so2488225e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 00:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688629062; x=1691221062;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dIlBc8EkbhJuK1UqCFjKxe4IJSeJosADKlsQWU1B6/o=;
 b=i4TkX5PTlGtAA5ty7skTslHorVW4JKZxt+IsLHD/ISURmoPWPx1aTTBjYiI2xsaaHE
 iv+4FwTz7PdeWVw7sDWr6PjvWnHarh1HMVlXRSSSIoADTn7hpfQUfc2UDXR+d5olayEa
 zyRl3xnBIcqdyxkm7dnv1wj+S92LpFnxVyjpCv3EhDwzRPZU8o4+1Opypczl07xTAGzX
 a//7NwHtQe0V4EJz71ONdRFSSv96rmfj7npXSM40eCDq5RjP0th9hcvVrzeMIsu4V90S
 WEDJ2sttOw5Mky5EkOO7PvX+EUK3viIpQfmTDi12cH+pKBBYWFLpJRwj7DzTITnqlqVr
 OKtQ==
X-Gm-Message-State: ABy/qLauZA42VFiRPZ8AZpZEGJrSdoYzMnzbywzCdAZircaThLzXilNE
 /t4rPzf1LY2K0KSYqpu+45kFRgZOCc0QpQslROEarJpafYyF11fI2RrpBPWkeknUWHmazN5lxKq
 V/0pYhA5h3p2cPRc=
X-Received: by 2002:a7b:ce8a:0:b0:3fb:be07:5343 with SMTP id
 q10-20020a7bce8a000000b003fbbe075343mr666957wmj.27.1688629062508; 
 Thu, 06 Jul 2023 00:37:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFSC2y9QuU/hCRUg3iKE1oVNBBi0iMF5TuMm3ubK8Ozn9TKSw2MYRYb1s9HPuvhMI78L6G9nQ==
X-Received: by 2002:a7b:ce8a:0:b0:3fb:be07:5343 with SMTP id
 q10-20020a7bce8a000000b003fbbe075343mr666946wmj.27.1688629062177; 
 Thu, 06 Jul 2023 00:37:42 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 e3-20020a5d5943000000b003141f3843e6sm1075331wri.90.2023.07.06.00.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 00:37:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
In-Reply-To: <20230706045546.593605-3-leobras@redhat.com> (Leonardo Bras's
 message of "Thu, 6 Jul 2023 01:55:47 -0300")
References: <20230706045546.593605-3-leobras@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 06 Jul 2023 09:37:40 +0200
Message-ID: <87o7kpbid7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Leonardo Bras <leobras@redhat.com> wrote:
> When trying to migrate a machine type pc-q35-6.0 or lower, with this
> cmdline options,
>
> -device driver=3Dpcie-root-port,port=3D18,chassis=3D19,id=3Dpcie-root-por=
t18,bus=3Dpcie.0,addr=3D0x12 \
> -device driver=3Dnec-usb-xhci,p2=3D4,p3=3D4,id=3Dnex-usb-xhci0,bus=3Dpcie=
-root-port18,addr=3D0x12.0x1
>
> the following bug happens after all ram pages were sent:
>
> qemu-kvm: get_pci_config_device: Bad config data: i=3D0x6e read: 0 device=
: 40 cmask: ff wmask: 0 w1cmask:19
> qemu-kvm: Failed to load PCIDevice:config
> qemu-kvm: Failed to load pcie-root-port:parent_obj.parent_obj.parent_obj
> qemu-kvm: error while loading state for instance 0x0 of device '0000:00:1=
2.0/pcie-root-port'
> qemu-kvm: load of migration failed: Invalid argument
>
> This happens on pc-q35-6.0 or lower because of:
> { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
>
> In this scenario, hotplug_handler_plug() calls pcie_cap_slot_plug_cb(),
> which sets dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to signal PCI
> hotplug for the guest. After a while the guest will deal with this hotplug
> and qemu will clear the above bit.
>
> Then, during migration, get_pci_config_device() will compare the
> configs of both the freshly created device and the one that is being
> received via migration, which will differ due to the PCI_EXP_SLTSTA_PDS b=
it
> and cause the bug to reproduce.
>
> To avoid this fake incompatibility, there are tree fields in PCIDevice th=
at
> can help:
>
> - wmask: Used to implement R/W bytes, and
> - w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
> - cmask: Used to enable config checks on load.
>
> According to PCI Express=C2=AE Base Specification Revision 5.0 Version 1.=
0,
> table 7-27 (Slot Status Register) bit 6, the "Presence Detect State" is
> listed as RO (read-only), so it only makes sense to make use of the cmask
> field.
>
> So, clear PCI_EXP_SLTSTA_PDS bit on cmask, so the fake incompatibility on
> get_pci_config_device() does not abort the migration.
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2215819
> Signed-off-by: Leonardo Bras <leobras@redhat.com>




> ---
>  hw/pci/pcie.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index b8c24cf45f..cae56bf1c8 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -659,6 +659,10 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
>      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
>                                 PCI_EXP_HP_EV_SUPPORTED);
>=20=20
> +    /* Avoid migration abortion when this device hot-removed by guest
> */

I would have included here the text in the commit:

 According to PCI Express=C2=AE Base Specification Revision 5.0 Version 1.0,
 table 7-27 (Slot Status Register) bit 6, the "Presence Detect State" is
 listed as RO (read-only), so it only makes sense to make use of the cmask
 field.

and

This happens on pc-q35-6.0 or lower because of:
{ "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }

so if we ever remove the machine type pc-q35-6.0, we can drop it.

Yes, I know that we don't drop machine types, but we should at some point.


> +    pci_word_test_and_clear_mask(dev->cmask + pos + PCI_EXP_SLTSTA,
> +                                 PCI_EXP_SLTSTA_PDS);
> +
>      dev->exp.hpev_notified =3D false;
>=20=20
>      qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))=
),

I agree that this is (at least) a step on the right direction.

I wmould had expected to have to need some check related to the value
of:

{ "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }

But I will not claim _any_ understanding of the PCI specification.

So:

Reviewed-by: Juan Quintela <quintela@redhat.com>

about that it fixes the migration bug.


