Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C90CB7302B5
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 17:03:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9S12-0006AS-9o; Wed, 14 Jun 2023 11:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q9S0y-000664-Rj
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q9S0w-0007gb-L2
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686754937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTNtmshACOBRDq7RTx3AMncBe1uqyTo1hbgDGlDlouA=;
 b=Bu3M3hqTSCkJnmNM+ZiqiJBm0tNQMAa993AkXKTaWSurPx9WNnjKmhie6WqgSWfeOtigyQ
 8Nvp6GC2m3Z2xOd7tqEXFngHFvVd/X4qCAoVLKvuCT7H0bN2FbDEUKmXRGg3Zls+92QRRr
 qgOGt56o3z5kVk6vEOe7LCZA5sitFvg=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-910UNI6ZNxeSAQgBdUfVLA-1; Wed, 14 Jun 2023 11:01:58 -0400
X-MC-Unique: 910UNI6ZNxeSAQgBdUfVLA-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-34083d8e76bso11477965ab.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 08:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686754911; x=1689346911;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FTNtmshACOBRDq7RTx3AMncBe1uqyTo1hbgDGlDlouA=;
 b=LALvpUxxdBWXRJ9k4VgEJZti/KUeDj/pEexQIp1ymGJLaRHu+AUEoCYMQerEstMHO7
 UzFPeZGSV0Wo1/mpDfrAPkbJ6FUm7fPwvBR7kR4knlKw78A8GZ2uCRSuHXU7YtpWzFvT
 dawq0W768k1hD3cIMNacG5dAuxyy4APZkKLPeDHIixoyFr0djw91f6OLeC5Jukr2ylwX
 Ka6WI8jHVGJhHeNwxMJa7477BzM1KvH2cEePl0E0Xm3dhNtx0caQFpCX/kOQOpV0Wr2I
 fcflivghR6zFgokRTkTVNcIKQdb07qNGqnucRta1XbjP2u9GQZ3B3EMQ5Cq84geEt9CS
 oxaQ==
X-Gm-Message-State: AC+VfDwvud8xWn3In5ycAENApY5AkUg3GPK/qUsBJmNq123ueM9otx5w
 BOt+UIcXzn19jDxouuBwm3wlN7cfobw12XxWFwFE3r3+o3fIXmgyceTVVH9WveOAUEK8+Wb3ioz
 qO9uVioqRcs/bSvw=
X-Received: by 2002:a92:d1cf:0:b0:33f:bb6b:ed37 with SMTP id
 u15-20020a92d1cf000000b0033fbb6bed37mr10420123ilg.24.1686754911319; 
 Wed, 14 Jun 2023 08:01:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4+EMzLyDTBR8uh1hGiJLfSOvBTIjus7K62uOjo821AzPhfrb3sFp7yTYeQZe93IkBQRAW2nQ==
X-Received: by 2002:a92:d1cf:0:b0:33f:bb6b:ed37 with SMTP id
 u15-20020a92d1cf000000b0033fbb6bed37mr10420102ilg.24.1686754910965; 
 Wed, 14 Jun 2023 08:01:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 a14-20020a92d58e000000b00340699a1062sm2067469iln.10.2023.06.14.08.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 08:01:50 -0700 (PDT)
Date: Wed, 14 Jun 2023 09:01:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/vfio/pci-quirks: Support alternate offset for
 GPUDirect Cliques
Message-ID: <20230614090149.3e8d7d74.alex.williamson@redhat.com>
In-Reply-To: <41b86f7c-6d9d-8e05-fb26-2b613dca9c4a@redhat.com>
References: <20230608174211.3227138-1-alex.williamson@redhat.com>
 <20230608180507.3229259-1-alex.williamson@redhat.com>
 <a44455cc-1eca-c50d-9394-8faab699c804@redhat.com>
 <20230612090511.17ac3557.alex.williamson@redhat.com>
 <41b86f7c-6d9d-8e05-fb26-2b613dca9c4a@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Wed, 14 Jun 2023 14:37:08 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> On 6/12/23 17:05, Alex Williamson wrote:
> > On Mon, 12 Jun 2023 16:07:33 +0200
> > C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> >  =20
> >> On 6/8/23 20:05, Alex Williamson wrote: =20
> >>> NVIDIA Turing and newer GPUs implement the MSI-X capability at the of=
fset
> >>> previously reserved for use by hypervisors to implement the GPUDirect
> >>> Cliques capability.  A revised specification provides an alternate
> >>> location.  Add a config space walk to the quirk to check for conflict=
s,
> >>> allowing us to fall back to the new location or generate an error at =
the
> >>> quirk setup rather than when the real conflicting capability is added
> >>> should there be no available location.
> >>>
> >>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >>> ---
> >>>    hw/vfio/pci-quirks.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >>>    1 file changed, 40 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> >>> index f0147a050aaa..0ed2fcd53152 100644
> >>> --- a/hw/vfio/pci-quirks.c
> >>> +++ b/hw/vfio/pci-quirks.c
> >>> @@ -1490,6 +1490,9 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vd=
ev)
> >>>     * +---------------------------------+----------------------------=
-----+
> >>>     *
> >>>     * https://lists.gnu.org/archive/html/qemu-devel/2017-08/pdfUda5iE=
pgOS.pdf
> >>> + *
> >>> + * Specification for Turning and later GPU architectures: =20
> >>
> >> s/Turning/Turing/
> >>
> >> I will fix that. =20
> >=20
> > Yes, thanks!
> >    =20
> >>> + * https://lists.gnu.org/archive/html/qemu-devel/2023-06/pdf142OR4O4=
c2.pdf
> >>>     */
> >>>    static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
> >>>                                           const char *name, void *opa=
que,
> >>> @@ -1530,7 +1533,9 @@ const PropertyInfo qdev_prop_nv_gpudirect_cliqu=
e =3D {
> >>>    static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **=
errp)
> >>>    {
> >>>        PCIDevice *pdev =3D &vdev->pdev;
> >>> -    int ret, pos =3D 0xC8;
> >>> +    int ret, pos;
> >>> +    bool c8_conflict =3D false, d4_conflict =3D false;
> >>> +    uint8_t tmp;
> >>>   =20
> >>>        if (vdev->nv_gpudirect_clique =3D=3D 0xFF) {
> >>>            return 0;
> >>> @@ -1547,6 +1552,40 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDe=
vice *vdev, Error **errp)
> >>>            return -EINVAL;
> >>>        }
> >>>   =20
> >>> +    /*
> >>> +     * Per the updated specification above, it's recommended to use =
offset
> >>> +     * D4h for Turing and later GPU architectures due to a conflict =
of the
> >>> +     * MSI-X capability at C8h.  We don't know how to determine the =
GPU =20
> >>
> >> There is a way :
> >>
> >>     # nvidia-smi -q | grep Architecture
> >>         Product Architecture                  : Turing =20
> >=20
> > There are a few problems with that:
> >=20
> >   1) nvidia-smi is a proprietary tool.
> >=20
> >   2) Using nvidia-smi, or even the PCI IDs database, would require
> >      ongoing maintenance to update the string or IDs for future
> >      architectures.
> >=20
> >   3) nvidia-smi requires the device to be managed by the nvidia driver,
> >      which becomes and chicken and egg problem when we require the
> >      device to be managed by a vfio compatible driver by this point. =20
>=20
> For my education, could such information be exposed in a PCI vendor
> specific capability ? May be it is ?

Sure, nothing technically prevents it, but the vendor has to have a
need to do so whereas NVIDIA probably has their own means to interrogate
the device to determine the architectural level or doesn't mind
maintaining PCI IDs.  Probably a bit of both.  Thanks,

Alex


