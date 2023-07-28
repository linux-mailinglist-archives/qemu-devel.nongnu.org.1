Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE91767141
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 17:57:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPPay-0000S5-Eu; Fri, 28 Jul 2023 11:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qPPaq-0000Rm-0n
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 11:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qPPao-0001UY-3h
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 11:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690558884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLLXoeQJYU205O6m03bnu7kItiNM6C/sf753oK4qXI8=;
 b=b9WMCZcckOe23xuhAxZWZkGUNqcAdcEtXNsHTPqD9VyaTZsqaUbLjnvh0L4pgZq5y+ofs9
 H06X8ldcWvteYXexI4oY0GrUQ7Ykp4fB2G4AsEIHrN1UZumR3NKe5KtnPCQsXMxNXE0sUc
 alZuPIG8Hqgxzli4IJa6pR/e+oHOHR4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-wP6EtFJ-NhC-nXgjSW075g-1; Fri, 28 Jul 2023 11:41:23 -0400
X-MC-Unique: wP6EtFJ-NhC-nXgjSW075g-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7866b16c6f5so116377239f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 08:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690558882; x=1691163682;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JLLXoeQJYU205O6m03bnu7kItiNM6C/sf753oK4qXI8=;
 b=jqVcyznwIvBhC3jRPU/b6y41B4mdEpgYaMgNUVgXnd/8vodzU7XsCrP/Uh2LmSCsIf
 KtGctly/iGj3DMeewCTBKDRi9XrT3T6iPoC3QRSzxBAOcSR77Z+tGihBErGWmRh6LHqK
 w55ROojtHLM88zjQl3+cPPZYeIodTBXxPk00zl2TPk40fzEtOxEC2DR7hIKxQYJzHNLj
 Z9Fj2f3HcxPBxYjBhfwu1mJmZElgsBg7t0+MtrR+OcMDehpaF6r4wJDQZ0XOi1YjOylw
 I1JA9vPpjP/lsN8TDh1qWrlPVhBkgkAybX381ADvG5MDHOB0d5NS3zVEuVQxspgt7WMd
 2C7Q==
X-Gm-Message-State: ABy/qLbdtWzvvw9sZGJACo4nYEHq+TfwKi86kiQaMSmi4q0+Ql/6LP3a
 rwe7gB52qSRrwYCiLcE3FAlY3kAlFbIzV++zuYK9a+MRmY1AMGrmOv5O3Bd/o7YCtinQTb+noqh
 B51IRS+qNCJ6A3CI=
X-Received: by 2002:a05:6e02:1d85:b0:348:b086:2c4b with SMTP id
 h5-20020a056e021d8500b00348b0862c4bmr5833390ila.9.1690558882583; 
 Fri, 28 Jul 2023 08:41:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqQQaCQIq/5lxnLQ7OVliUmq6jFEscQXLYGSK2MuLCUAA+nURM30DsJhjyZTYLxMmrKBTgMQ==
X-Received: by 2002:a05:6e02:1d85:b0:348:b086:2c4b with SMTP id
 h5-20020a056e021d8500b00348b0862c4bmr5833371ila.9.1690558882258; 
 Fri, 28 Jul 2023 08:41:22 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 f12-20020a02a80c000000b0042036f06b24sm1133810jaj.163.2023.07.28.08.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 08:41:21 -0700 (PDT)
Date: Fri, 28 Jul 2023 09:41:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: "Liu, Jing2" <jing2.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Chatre, Reinette"
 <reinette.chatre@intel.com>
Subject: Re: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic
 MSI-X allocation
Message-ID: <20230728094120.6c809cfb.alex.williamson@redhat.com>
In-Reply-To: <e6d47754-9d2b-20bc-55b0-ed6685f7b3b2@redhat.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
 <20230727112457.1422f285.alex.williamson@redhat.com>
 <DS0PR11MB8114C864A2D55951DD621214A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
 <e6d47754-9d2b-20bc-55b0-ed6685f7b3b2@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Fri, 28 Jul 2023 10:27:17 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> On 7/28/23 10:09, Liu, Jing2 wrote:
> > Hi Alex,
> >=20
> > Thanks very much for reviewing the patches.
> >  =20
> >> On July 28, 2023 1:25 AM, Alex Williamson <alex.williamson@redhat.com>=
 wrote:
> >>
> >> On Thu, 27 Jul 2023 03:24:08 -0400
> >> Jing Liu <jing2.liu@intel.com> wrote:
> >> =20
> >>> From: Reinette Chatre <reinette.chatre@intel.com>
> >>>
> >>> Kernel provides the guidance of dynamic MSI-X allocation support of
> >>> passthrough device, by clearing the VFIO_IRQ_INFO_NORESIZE flag to
> >>> guide user space.
> >>>
> >>> Fetch and store the flags from host for later use to determine if
> >>> specific flags are set.
> >>>
> >>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> >>> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> >>> ---
> >>>   hw/vfio/pci.c        | 12 ++++++++++++
> >>>   hw/vfio/pci.h        |  1 +
> >>>   hw/vfio/trace-events |  2 ++
> >>>   3 files changed, 15 insertions(+)
> >>>
> >>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
> >>> a205c6b1130f..0c4ac0873d40 100644
> >>> --- a/hw/vfio/pci.c
> >>> +++ b/hw/vfio/pci.c
> >>> @@ -1572,6 +1572,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice
> >>> *vdev, Error **errp)
> >>>
> >>>   static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error
> >>> **errp)  {
> >>> +    struct vfio_irq_info irq_info =3D { .argsz =3D sizeof(irq_info) =
};
> >>>       int ret;
> >>>       Error *err =3D NULL;
> >>>
> >>> @@ -1624,6 +1625,17 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev=
, int =20
> >> pos, Error **errp) =20
> >>>           memory_region_set_enabled(&vdev->pdev.msix_table_mmio, fals=
e);
> >>>       }
> >>>
> >>> +    irq_info.index =3D VFIO_PCI_MSIX_IRQ_INDEX;
> >>> +    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_=
info);
> >>> +    if (ret) {
> >>> +        /* This can fail for an old kernel or legacy PCI dev */
> >>> +        trace_vfio_msix_setup_get_irq_info_failure(strerror(errno));=
 =20
> >>
> >> We only call vfio_msix_setup() if the device has an MSI-X capability, =
so the
> >> "legacy PCI" portion of this comment seems unjustified.
> >> Otherwise the GET_IRQ_INFO ioctl has always existed, so I'd also quest=
ion the
> >> "old kernel" part of this comment. =20
> >=20
> > Oh, yes, I just realize that only VFIO_PCI_ERR_IRQ_INDEX and
> > VFIO_PCI_REQ_IRQ_INDEX were added later in include/uapi/linux/vfio.h. T=
hus,
> > this ioctl() with MSIX index would not fail by the old-kernel or legacy=
-PCI reason.
> > Thanks for pointing out this to me.
> >=20
> > We don't currently sanity test the device =20
> >> exposed MSI-X info versus that reported by GET_IRQ_INFO, but it seems =
valid to
> >> do so. =20
> >=20
> > Do we want to keep the check of possible failure from kernel (e.g., -EF=
AULT) and report
> > the error code back to caller? Maybe like this,
> >=20
> > static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
> > {
> >      ....
> >      msix->entries =3D (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
> >=20
> >      ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_in=
fo);
> >      if (ret < 0) {
> >          error_setg_errno(errp, -ret, "failed to get MSI-X IRQ INFO");
> >          return;

Yes.

> >      } else {
> >          vdev->msix->noresize =3D !!(irq_info.flags & VFIO_IRQ_INFO_NOR=
ESIZE);
> >      }

No 'else' required here since the error branch returns.

> >      ...
> >      trace_vfio_msix_early_setup(vdev->vbasedev.name, pos, msix->table_=
bar,
> >                                  msix->table_offset, msix->entries, vde=
v->msix->noresize); =20
>=20
> In the trace event, please ouput irq_info.flags since it gives more
> information on the value returned by the kernel.
>=20
> >      ....
> > }
> >  =20
> >> I'd expect this to happen in vfio_msix_early_setup() though, especially
> >> since that's where the remainder of VFIOMSIXInfo is setup. =20
> >  =20
> >> =20
> >>> +    } else {
> >>> +        vdev->msix->irq_info_flags =3D irq_info.flags;
> >>> +    }
> >>> +    trace_vfio_msix_setup_irq_info_flags(vdev->vbasedev.name,
> >>> +                                         vdev->msix->irq_info_flags);
> >>> +
> >>>       return 0;
> >>>   }
> >>>
> >>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h index
> >>> a2771b9ff3cc..ad34ec56d0ae 100644
> >>> --- a/hw/vfio/pci.h
> >>> +++ b/hw/vfio/pci.h
> >>> @@ -113,6 +113,7 @@ typedef struct VFIOMSIXInfo {
> >>>       uint32_t table_offset;
> >>>       uint32_t pba_offset;
> >>>       unsigned long *pending;
> >>> +    uint32_t irq_info_flags; =20
> >>
> >> Why not simply pull out a "noresize" bool?  Thanks,
> >> =20
> > Will change to a bool type. =20
>=20
> I would simply cache the KVM flags value under VFIOMSIXInfo as you
> did and add an helper. Both work the same but the intial proposal
> keeps more information. This is minor.

TBH, I'd still prefer that we only store the one field we care about
and avoid an extra helper, regardless of how simple it might be.  Even
if we eventually add masking for MSI-X, we can store it in less space
and more accessibly decoded in the VFIOMSIXInfo struct vs helpers to
access a cached flags value.  Thanks,

Alex


