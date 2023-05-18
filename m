Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B767E7077E4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 04:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzT5n-0007Qb-Vz; Wed, 17 May 2023 22:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1pzT5i-0007Q6-KV
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:10:07 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1pzT5d-0001K1-Pl
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:10:06 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-965e4be7541so271451766b.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 19:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684375798; x=1686967798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z50a9Kg5Zk3qOUOw9QwsrjSX3TOX4jrusUWVi33KFUg=;
 b=ORGup4/7ZVy5FGzIsi5RwciSWxM0IW5CBd7Hjchhqj7HoFaOXo5ik0IPAJY+XjLBG+
 69+qDmQf/OtAb3fIlR9hYTIBoJ5eaopf7+/X/slAvvBWwOkMyFh73zbPW71e3WoZButB
 31wDPVV5wbHeRAmC0y3VRpXujzvWx6Xu1iC+1xBXU6AGnPvl7tESXOvg9HYkm8fX26Ya
 j4C//yKZGvsnC1ed2WdhOcc2tTP4Ea9YSfPH3KFluLl9WfDognUARuwJkO9RE7mEWNbD
 Hl+KyYbvIetSY1qj2FKQ65tBKLZpdZTOb56uwhfV4O3SaLcVI3w9ywk+FHnw3lokWHJ3
 cjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684375798; x=1686967798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z50a9Kg5Zk3qOUOw9QwsrjSX3TOX4jrusUWVi33KFUg=;
 b=SqsccIKYLu4YXK/JR63jPGI1JqVBhiW8L47LGoLw5GBV3i6QqWfdsYVOFzF6qwxjgu
 8Ij7FmdRRyMynLdC5/Ia5g6gLfrJfZ5Z2wjyE8cSF1I1HV0cUSl5QrhhPYpN6fDOK2Xv
 Z/PRqpR3PpXJlNe2ZTtQByDRLAyZbgG/uCyA1v3yDd4fWS1wMOBV92GN9e/VbY+IuQM/
 R9XRawLgc3uEDb9DprRwMIIoo0s6X7fat3OaCxIl4AaHN05g/DTFPCpN/68UXbFz2Ajj
 3sA3c7PgOuOwSo33RDs70t7ai89ZaPoXAnx8kf9pOajGXUe6+r24JW/11VcKyUYXnOqP
 sm7g==
X-Gm-Message-State: AC+VfDzBIvbqH4j4oPTq7IhdtYTc91x6kZ6vfRSQMEXCvckegkcVFS+k
 RmBLMLpb6ItUVd8oK6YAASDTxt6p+g7tv8YBJ58=
X-Google-Smtp-Source: ACHHUZ5Vejp5o9w3CIlmm6LuPL/4+Z5LjlPnX3IOXyW0yDsUrbLtJfQYNQlGMDq+laS6GFMrkykjnw2r+TGQiB7jzZE=
X-Received: by 2002:a17:906:9b8f:b0:96a:6c3:5e72 with SMTP id
 dd15-20020a1709069b8f00b0096a06c35e72mr29803714ejc.10.1684375798063; Wed, 17
 May 2023 19:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230320000554.8219-1-jandryuk@gmail.com>
 <48c55d33-aa16-4867-a477-f6df45c7d9d9@perard>
In-Reply-To: <48c55d33-aa16-4867-a477-f6df45c7d9d9@perard>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 17 May 2023 22:09:46 -0400
Message-ID: <CAKf6xpvzcR47oTcbyNWwTV9Bu2N0EaqjNh5CDv2XYTwGF5_qEA@mail.gmail.com>
Subject: Re: [PATCH] xen: Fix host pci for stubdom
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, 
 =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=jandryuk@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, May 15, 2023 at 11:04=E2=80=AFAM Anthony PERARD
<anthony.perard@citrix.com> wrote:
>
> On Sun, Mar 19, 2023 at 08:05:54PM -0400, Jason Andryuk wrote:
> > diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.=
c
> > index 8c6e9a1716..51a72b432d 100644
> > --- a/hw/xen/xen-host-pci-device.c
> > +++ b/hw/xen/xen-host-pci-device.c
> > @@ -33,13 +34,101 @@
> >  #define IORESOURCE_PREFETCH     0x00001000      /* No side effects */
> >  #define IORESOURCE_MEM_64       0x00100000
> >
> > +/*
> > + * Non-passthrough (dom0) accesses are local PCI devices and use the g=
iven BDF
> > + * Passthough (stubdom) accesses are through PV frontend PCI device.  =
Those
> > + * either have a BDF identical to the backend's BFD (xen-backend.passt=
hrough=3D1)
> > + * or a local virtual BDF (xen-backend.passthrough=3D0)
> > + *
> > + * We are always given the backend's BDF and need to lookup the approp=
riate
> > + * local BDF for sysfs access.
> > + */
> > +static void xen_host_pci_fill_local_addr(XenHostPCIDevice *d, Error **=
errp)
> > +{
> > +    unsigned int num_devs, len, i;
> > +    unsigned int domain, bus, dev, func;
> > +    char *be_path;
> > +    char path[80];
> > +    char *msg;
> > +
> > +    be_path =3D qemu_xen_xs_read(xenstore, 0, "device/pci/0/backend", =
&len);
> > +    if (!be_path) {
> > +        /*
> > +         * be_path doesn't exist, so we are dealing with a local
> > +         * (non-passthough) device.
> > +         */
> > +        d->local_domain =3D d->domain;
> > +        d->local_bus =3D d->bus;
> > +        d->local_dev =3D d->dev;
> > +        d->local_func =3D d->func;
> > +
> > +        return;
> > +    }
> > +
> > +    snprintf(path, sizeof(path), "%s/num_devs", be_path);
>
> Is 80 bytes for `path` enough?
> What if the path is truncated due to the limit?
>
>
> There's xs_node_scanf() which might be useful. It does the error
> handling and call scanf(). But I'm not sure if it can be used here, in
> this file.

Thanks for the suggestion - I'll take a look.  Your other comments
sound good, too.

Also, for the next version, I plan to change the From: to Marek. I was
thinking of doing it earlier, but failed to do so when it was time to
send out the patch.  Most of the code is Marek's from his Qubes
stubdom repo.  My modifications were to make it work with non-stubdom
as well.

Thanks,
Jason

