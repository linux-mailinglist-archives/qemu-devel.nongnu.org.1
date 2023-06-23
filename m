Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F773BAEA
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 16:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCiEG-0007tt-Oq; Fri, 23 Jun 2023 10:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1qCiEE-0007sw-Df
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1qCiEC-0001Yf-7w
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687532255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63ETyxVlXOUK8VPmHAqUGwqgq1hulnUBqmwOIcThDz0=;
 b=XnNWoP0H/j9Hd5Ql/4HV0QN+fTMbgUawMuqlQgaLdnzSWVlr56StZp6Mme5oBlA1N3jFAO
 jootF1wHP3mFvWdrpdNuT9JL6sNkk8sIQXOnfeUYNQwCfKUe0Y38MzMaxPrHLZBFWHCvoi
 N13cnehPVYAEEYPNjfvo45MbR4/V7jw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-qFIoiD9DMiirtH0fNK1cpg-1; Fri, 23 Jun 2023 10:57:33 -0400
X-MC-Unique: qFIoiD9DMiirtH0fNK1cpg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b470c4ce1dso7896611fa.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 07:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687532252; x=1690124252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63ETyxVlXOUK8VPmHAqUGwqgq1hulnUBqmwOIcThDz0=;
 b=UCKkDhPxD6mnxyErqtZgbYIZIKUye/NiVzwy32pXRjaSojauYOBJcxHm3dGmDwglxz
 xeV8bnzTgEG4ZWh0c1PLPmJkabUhwjfUsZx2zZq/eL3rTMAYoHfD93pfD2LFQWXsW4CP
 KEKy4qGrAxIGmD9saC4sNWuFQHwMIwXwY4DFuRzROX/SdWUgNeArU1s5AkJffBfsD99N
 QOZUFhlHlhc6WGZxrykzUXrNqwGbQoYhIWr2xKQFjvcRSgFlLg/u4eUV5NyTB1tCahMc
 XBjCJPanhir5ALHsR9OgonedIMaIfnEjVM5Y5Fz/06KEyoHzjPpdYcTX9jpsq0P8361G
 LyAA==
X-Gm-Message-State: AC+VfDxcDaskx6KliZRx8Bf6zLsAwpdWJecMUahL+CYs3GQgWGXw0+el
 yv/4GMfrYr5kAVJu5VoeK+4W0PQvMTZ+tyAuY+DxWk6V1scErOSIpLSGOHj0WufSzgkwadx5b4p
 4xQpqZZ+y+S95O266qdrqemh6GNVX6/o=
X-Received: by 2002:a19:ca02:0:b0:4f9:586b:dba1 with SMTP id
 a2-20020a19ca02000000b004f9586bdba1mr5238041lfg.4.1687532252228; 
 Fri, 23 Jun 2023 07:57:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LRW/teCZbVgyRGlDH0PlpLuIG6sqxThI5FD7h4zYwtXPXFAXKtik/GkKOuWZgx3mQFOU0DBbkj4/8X5v+7sA=
X-Received: by 2002:a19:ca02:0:b0:4f9:586b:dba1 with SMTP id
 a2-20020a19ca02000000b004f9586bdba1mr5238034lfg.4.1687532251945; Fri, 23 Jun
 2023 07:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230622103255.267289-1-anisinha@redhat.com>
 <20230622103255.267289-6-anisinha@redhat.com>
 <CAMDeoFWHJhN3ppAO4XB9jGUg4Yu-zFzzzKwAvDiSJSgjeZH6jg@mail.gmail.com>
 <20230622134437-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622134437-mutt-send-email-mst@kernel.org>
From: Julia Suvorova <jusual@redhat.com>
Date: Fri, 23 Jun 2023 16:57:20 +0200
Message-ID: <CAMDeoFUAaRhN_hRHmTDfu6dWyiz_dNEhCJt9jQTVzeNSTbwuAg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 7:48=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 22, 2023 at 05:46:40PM +0200, Julia Suvorova wrote:
> > On Thu, Jun 22, 2023 at 12:34=E2=80=AFPM Ani Sinha <anisinha@redhat.com=
> wrote:
> > >
> > > PCI Express ports only have one slot, so PCI Express devices can only=
 be
> > > plugged into slot 0 on a PCIE port. Enforce it.
> > >
> > > CC: jusual@redhat.com
> > > CC: imammedo@redhat.com
> > > Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
> > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > ---
> > >  hw/pci/pci.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index bf38905b7d..5f25ab9f5e 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -64,6 +64,7 @@ bool pci_available =3D true;
> > >  static char *pcibus_get_dev_path(DeviceState *dev);
> > >  static char *pcibus_get_fw_dev_path(DeviceState *dev);
> > >  static void pcibus_reset(BusState *qbus);
> > > +static bool pcie_has_upstream_port(PCIDevice *dev);
> > >
> > >  static Property pci_props[] =3D {
> > >      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> > > @@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDe=
vice *pci_dev,
> > >                     name);
> > >
> > >         return NULL;
> > > +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> > > +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> > > +                   " PCI express devices can only be plugged into sl=
ot 0.",
> >
> > This is not technically correct, because downstream ports and root
> > ports are also PCIe devices, and they can have different slots under
> > upstream ports and RC. But this error will never be shown for them, so
> > it seems fine.
>
> Hmm. Confusing users is not nice ... I agree this might
> make people think they can not use root ports in slot !=3D0 either.
>
> Would you add "with an upstream port"?
> E.g. "PCI Express devices with an upstream port" ?

This whole upstream port conditioning is quite confusing.
How about "%parent device% only allows plugging into slot 0"?

Best regards, Julia Suvorova.

> >
> > Reviewed-by: Julia Suvorova <jusual@redhat.com>
> >
> >
> >
> >
> > > +                   PCI_SLOT(devfn), name);
> > > +        return NULL;
> > >      }
> > >
> > >      pci_dev->devfn =3D devfn;
> > > --
> > > 2.39.1
> > >
>


