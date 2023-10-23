Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A22237D28EF
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 05:13:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qulMA-00024N-06; Sun, 22 Oct 2023 23:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qulM6-00023s-CU
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 23:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qulM4-0001ZO-J8
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 23:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698030706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFMUTA19+VXURujY76E4DzRwLKvhtPToyDxymN1R6Lc=;
 b=ZJwAc3GrF+Cc2wU/3QrOL8LlLNZvt1Dpj+X+ODJmpI3r1cj+cthygpN7VKmbzruGO05x0l
 vhwxZUiPliyPGyYPcu/fNaDUyruT8DKYRlK6HkSM9BZ+iJEkcchz9Ly2UsOzSqzliAzpb+
 tyNKX9v4lJrdXdw/xzkziBqkQ5HJWM8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-t5cQuk1sMve6hvVwhs7BkA-1; Sun, 22 Oct 2023 23:11:45 -0400
X-MC-Unique: t5cQuk1sMve6hvVwhs7BkA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507a0904cdbso2970710e87.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 20:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698030703; x=1698635503;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rFMUTA19+VXURujY76E4DzRwLKvhtPToyDxymN1R6Lc=;
 b=XzpDec1m5vhNa0k/obq3CUxb3FPEz5ZSDmZZiwyQi6Xr6E+g7UYgbgegCYYyZjnICR
 i3DPyPj9dZYcOL4RH02UfoGvNnDJANgULIAQ5qHf+9b6DrjgkfpHYDzVoI4HsgaYFmx0
 PdFgD683QaXGmgqmEdtOA/ULIXTmOL3GUNlfTdUq+Vfy2SXHdDBk31h5wBdExmb7DIi7
 cXY0bYLUBdeq0scjJc0KQX7lVJF6IeK2ediQGmjMnKZgJDnLPl+OqJXRgd1ZUH6HS+W8
 4glX72UubRnyFT5ifcDoGLS8Mfi3JCwOOqbX3m3gxnTPo6CTcfMLWw+gnzVpYVdLpyG+
 NxiQ==
X-Gm-Message-State: AOJu0YzxKuxnN2XP7pUeQA2fbGVHC/CFlyTR2e0vnP5G/mAnAUVxhMgE
 lJuUQonCfcdk6+lqcdm0qwkVpGaIw4rWrfxqKgVcpyKQbCiZtTJMq4pLQMZKW1Elv8HgJIvrD/h
 vEYnR7U3ca2a8uZeucfel0ZthL2nrhp8=
X-Received: by 2002:a05:6512:230b:b0:504:4165:54ab with SMTP id
 o11-20020a056512230b00b00504416554abmr2436855lfu.56.1698030703665; 
 Sun, 22 Oct 2023 20:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOOqZEnBBsALCvbmAgBC9+FWJSYzztfYgLFm28FCsR/AYmBosN8OZlD+QqiUgCggZGyVLjUd7M+m28Nmt+cvc=
X-Received: by 2002:a05:6512:230b:b0:504:4165:54ab with SMTP id
 o11-20020a056512230b00b00504416554abmr2436848lfu.56.1698030703317; Sun, 22
 Oct 2023 20:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230829090529.184438-1-clg@kaod.org>
 <20230829090529.184438-3-clg@kaod.org>
 <CACGkMEu6nznVGTyk8gjrZ3jE=bEAd2bDDi9PPwjDKNFkXnVhSQ@mail.gmail.com>
 <d9df1c95-f681-4962-be74-671cef90e908@redhat.com>
 <b744bd42-0b46-44ce-8d60-28d4d31427e0@redhat.com>
In-Reply-To: <b744bd42-0b46-44ce-8d60-28d4d31427e0@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Oct 2023 11:11:32 +0800
Message-ID: <CACGkMEtbsVCAUFe6AomYe3EO=iBOXze6vJ20c8p0AbsXogocCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] igb: Add Function Level Reset to PF and VF
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>
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

On Fri, Oct 20, 2023 at 5:41=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> On 10/20/23 09:40, C=C3=A9dric Le Goater wrote:
> > On 10/20/23 06:24, Jason Wang wrote:
> >> On Tue, Aug 29, 2023 at 5:06=E2=80=AFPM C=C3=A9dric Le Goater <clg@kao=
d.org> wrote:
> >>>
> >>> From: C=C3=A9dric Le Goater <clg@redhat.com>
> >>>
> >>> The Intel 82576EB GbE Controller say that the Physical and Virtual
> >>> Functions support Function Level Reset. Add the capability to each
> >>> device model.
> >>>
> >>
> >> Do we need to do migration compatibility for this?
> >
> > Yes. it does. the config space is now different.
>
> Jason,
>
> To avoid an extra compat property, would it be ok to let the VF peek into
> the PF capabilities to set FLR or not ? Something like below.

I might be wrong, but it looks to me it's still a behaviour change?

Thanks

>
> Thanks,
>
> C.
>
>
> @@ -238,6 +238,12 @@ static const MemoryRegionOps mmio_ops =3D
>       },
>   };
>
> +static bool igbvf_check_pf_flr(PCIDevice *dev)
> +{
> +    return !!(pci_get_long(dev->config + dev->exp.exp_cap + PCI_EXP_DEVC=
AP)
> +              & PCI_EXP_DEVCAP_FLR);
> +}
> +
>   static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
>   {
>       IgbVfState *s =3D IGBVF(dev);
> @@ -267,7 +273,9 @@ static void igbvf_pci_realize(PCIDevice
>           hw_error("Failed to initialize PCIe capability");
>       }
>
> -    pcie_cap_flr_init(dev);
> +    if (igbvf_check_pf_flr(pcie_sriov_get_pf(dev))) {
> +        pcie_cap_flr_init(dev);
> +    }
>
>       if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
>           hw_error("Failed to initialize AER capability");
>
>
> >
> > Thanks,
> >
> > C.
> >
> >
> >>
> >> Thanks
> >>
> >>> Cc:  Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> >>> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
> >>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >>> ---
> >>>   hw/net/igb.c   | 3 +++
> >>>   hw/net/igbvf.c | 3 +++
> >>>   2 files changed, 6 insertions(+)
> >>>
> >>> diff --git a/hw/net/igb.c b/hw/net/igb.c
> >>> index e70a66ee038e..b8c170ad9b1a 100644
> >>> --- a/hw/net/igb.c
> >>> +++ b/hw/net/igb.c
> >>> @@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, uint=
32_t addr,
> >>>
> >>>       trace_igb_write_config(addr, val, len);
> >>>       pci_default_write_config(dev, addr, val, len);
> >>> +    pcie_cap_flr_write_config(dev, addr, val, len);
> >>>
> >>>       if (range_covers_byte(addr, len, PCI_COMMAND) &&
> >>>           (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> >>> @@ -433,6 +434,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, E=
rror **errp)
> >>>       }
> >>>
> >>>       /* PCIe extended capabilities (in order) */
> >>> +    pcie_cap_flr_init(pci_dev);
> >>> +
> >>>       if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
> >>>           hw_error("Failed to initialize AER capability");
> >>>       }
> >>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
> >>> index 07343fa14a89..55e321e4ec20 100644
> >>> --- a/hw/net/igbvf.c
> >>> +++ b/hw/net/igbvf.c
> >>> @@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev, ui=
nt32_t addr, uint32_t val,
> >>>   {
> >>>       trace_igbvf_write_config(addr, val, len);
> >>>       pci_default_write_config(dev, addr, val, len);
> >>> +    pcie_cap_flr_write_config(dev, addr, val, len);
> >>>   }
> >>>
> >>>   static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, unsigned=
 size)
> >>> @@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, Err=
or **errp)
> >>>           hw_error("Failed to initialize PCIe capability");
> >>>       }
> >>>
> >>> +    pcie_cap_flr_init(dev);
> >>> +
> >>>       if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
> >>>           hw_error("Failed to initialize AER capability");
> >>>       }
> >>> --
> >>> 2.41.0
> >>>
> >>>
> >>
> >
>


