Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7335A72C951
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 17:06:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8j6o-0003v1-7M; Mon, 12 Jun 2023 11:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q8j6i-0003uF-19
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 11:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q8j6d-0001Or-To
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 11:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686582316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pv9Homp0rkwSGAoiuFZa7nDEMcvT/l/Y5xeKMGVuggs=;
 b=LKrOt76SGSiNE/Xh4ckHopQm3v+sGj1m6Way/1n83NjkyAVvIQcbRcz5PBH2A589p4FxwC
 jCJujSAPDJM68o8Hp+BjpNYNuZ6xRndV61PTFMy6LTu0qYtTncHyVT+lA7ckvx8uMOkzPY
 g2fcsmBpSih/nwg1Wk+tgwn5StX3tcc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-ZMhEy-ELN_qmMda5KnXAMw-1; Mon, 12 Jun 2023 11:05:15 -0400
X-MC-Unique: ZMhEy-ELN_qmMda5KnXAMw-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-34055a08934so3095325ab.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 08:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686582314; x=1689174314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pv9Homp0rkwSGAoiuFZa7nDEMcvT/l/Y5xeKMGVuggs=;
 b=WS47SIXKc8z6h+w/iaAxak3kOiHP65dK6l78uWZIayrtuCs9IIPhFlBAMGwee0LZyZ
 GVChKB3hYbGhzB4xmOuiJRiy6Eo+56Berwpej0ewDe3W8O83g0CTjp31gcQHLhkZ5j/e
 xwKZa2W2ux2ACTDoNIPkNNa29GxxQnDpLddFAaNvD6OKhxo8hvUZmKLSNmmPA6gqXF4H
 Q8tKBNK7OjvyYK4+m7W+TNtxB8lEPK7ehALihBs+Q7l7H7DfVz7sDARJq+Xlr6998RPv
 Tcb1rXpnRODKXDDmd/FMh8E7xVClEvc/lzmHyUQu+qlDXPZr8hz8lN8MQdL+ijsbXnnM
 TQPQ==
X-Gm-Message-State: AC+VfDxcT0STKlvcH7Qnj03tsC7V6yILZ1vAXPnEa649oHO/ASQCfJgA
 kkEyD/K2LI+of2dwnOniPGKN4tJY6jkUVGC2DxEwAzOm6BjVl6nwEoSLSA7UR9N0HDQE25UMGsr
 6UaMkjyImxsAeLl0=
X-Received: by 2002:a92:cad1:0:b0:33c:b395:a89d with SMTP id
 m17-20020a92cad1000000b0033cb395a89dmr7380290ilq.14.1686582314181; 
 Mon, 12 Jun 2023 08:05:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78iCbPzRAmifhS05DuZ607q1c/b2uPcGVbvbUp3x5JM4tzxXmWQHmjCZ/hm5CA3KLklZ+H7g==
X-Received: by 2002:a92:cad1:0:b0:33c:b395:a89d with SMTP id
 m17-20020a92cad1000000b0033cb395a89dmr7380274ilq.14.1686582313872; 
 Mon, 12 Jun 2023 08:05:13 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 v5-20020a92d245000000b0032957b21c26sm3195255ilg.77.2023.06.12.08.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 08:05:13 -0700 (PDT)
Date: Mon, 12 Jun 2023 09:05:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/vfio/pci-quirks: Support alternate offset for
 GPUDirect Cliques
Message-ID: <20230612090511.17ac3557.alex.williamson@redhat.com>
In-Reply-To: <a44455cc-1eca-c50d-9394-8faab699c804@redhat.com>
References: <20230608174211.3227138-1-alex.williamson@redhat.com>
 <20230608180507.3229259-1-alex.williamson@redhat.com>
 <a44455cc-1eca-c50d-9394-8faab699c804@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
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

On Mon, 12 Jun 2023 16:07:33 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> On 6/8/23 20:05, Alex Williamson wrote:
> > NVIDIA Turing and newer GPUs implement the MSI-X capability at the offs=
et
> > previously reserved for use by hypervisors to implement the GPUDirect
> > Cliques capability.  A revised specification provides an alternate
> > location.  Add a config space walk to the quirk to check for conflicts,
> > allowing us to fall back to the new location or generate an error at the
> > quirk setup rather than when the real conflicting capability is added
> > should there be no available location.
> >=20
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >   hw/vfio/pci-quirks.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 40 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index f0147a050aaa..0ed2fcd53152 100644
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -1490,6 +1490,9 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev)
> >    * +---------------------------------+-------------------------------=
--+
> >    *
> >    * https://lists.gnu.org/archive/html/qemu-devel/2017-08/pdfUda5iEpgO=
S.pdf
> > + *
> > + * Specification for Turning and later GPU architectures: =20
>=20
> s/Turning/Turing/
>=20
> I will fix that.

Yes, thanks!
=20
> > + * https://lists.gnu.org/archive/html/qemu-devel/2023-06/pdf142OR4O4c2=
.pdf
> >    */
> >   static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
> >                                          const char *name, void *opaque,
> > @@ -1530,7 +1533,9 @@ const PropertyInfo qdev_prop_nv_gpudirect_clique =
=3D {
> >   static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **err=
p)
> >   {
> >       PCIDevice *pdev =3D &vdev->pdev;
> > -    int ret, pos =3D 0xC8;
> > +    int ret, pos;
> > +    bool c8_conflict =3D false, d4_conflict =3D false;
> > +    uint8_t tmp;
> >  =20
> >       if (vdev->nv_gpudirect_clique =3D=3D 0xFF) {
> >           return 0;
> > @@ -1547,6 +1552,40 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevi=
ce *vdev, Error **errp)
> >           return -EINVAL;
> >       }
> >  =20
> > +    /*
> > +     * Per the updated specification above, it's recommended to use of=
fset
> > +     * D4h for Turing and later GPU architectures due to a conflict of=
 the
> > +     * MSI-X capability at C8h.  We don't know how to determine the GP=
U =20
>=20
> There is a way :
>=20
>    # nvidia-smi -q | grep Architecture
>        Product Architecture                  : Turing

There are a few problems with that:

 1) nvidia-smi is a proprietary tool.

 2) Using nvidia-smi, or even the PCI IDs database, would require
    ongoing maintenance to update the string or IDs for future
    architectures.

 3) nvidia-smi requires the device to be managed by the nvidia driver,
    which becomes and chicken and egg problem when we require the
    device to be managed by a vfio compatible driver by this point.

> but it must be vendor specific and the proposed solution is as good.
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Thanks!

Alex

> > +     * architecture, instead we walk the capability chain to mark conf=
licts
> > +     * and choose one or error based on the result.
> > +     *
> > +     * NB. Cap list head in pdev->config is already cleared, read from=
 device.
> > +     */
> > +    ret =3D pread(vdev->vbasedev.fd, &tmp, 1,
> > +                vdev->config_offset + PCI_CAPABILITY_LIST);
> > +    if (ret !=3D 1 || !tmp) {
> > +        error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting ca=
p list");
> > +        return -EINVAL;
> > +    }
> > +
> > +    do {
> > +        if (tmp =3D=3D 0xC8) {
> > +            c8_conflict =3D true;
> > +        } else if (tmp =3D=3D 0xD4) {
> > +            d4_conflict =3D true;
> > +        }
> > +        tmp =3D pdev->config[tmp + PCI_CAP_LIST_NEXT];
> > +    } while (tmp);
> > +
> > +    if (!c8_conflict) {
> > +        pos =3D 0xC8;
> > +    } else if (!d4_conflict) {
> > +        pos =3D 0xD4;
> > +    } else {
> > +        error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid config s=
pace");
> > +        return -EINVAL;
> > +    }
> > +
> >       ret =3D pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, 8, errp);
> >       if (ret < 0) {
> >           error_prepend(errp, "Failed to add NVIDIA GPUDirect cap: "); =
=20
>=20


