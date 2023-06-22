Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8110873A7A6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:49:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOQT-0008CA-It; Thu, 22 Jun 2023 13:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCOQK-0007ub-Pc
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCOQI-0006Vf-10
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687456122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZflWP3tHywO9WWzFgVkl2XbyskLd6sOtISiz7Y7TAD4=;
 b=dKZHrulJeROWBuH5mobB95ZGZyXbrO2SuPhmKD+AUqQmSBSJFNLK/zmPXer1cBjgR1zjLD
 7zKt+RNc6KN5vjDjUSmZG9Y9Ts0CWGh/Lg54qlA75K0FScA95HcKhg8/CEOYPfru5qPTdG
 vuULr4zf4I2u5JcAfxhd3YbXoSJw1Cg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-AG9A0JRyPEyw4nvXFwcVDg-1; Thu, 22 Jun 2023 13:48:40 -0400
X-MC-Unique: AG9A0JRyPEyw4nvXFwcVDg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-986db3313f0so427052166b.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 10:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687456119; x=1690048119;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZflWP3tHywO9WWzFgVkl2XbyskLd6sOtISiz7Y7TAD4=;
 b=fir3k95MagjmWOy1cmg8N5YJYU3yuyLthAq9CGmS2Z5cP/NSHhc3W5UdVBbKMAVqMs
 2nZQWaa0+0eMWgTDe9FFXhGI/XgbF/Iwm1Yn7tKH/tq4OHcm9Gi4FoWgqGFaC55q3oWI
 +5ihVwPbN5Zv9Oryjo++jz+0W8cAxq8E07iQZQAb595R81JXqZeApsIofd7Xn9gtz/em
 SkPp/CHSvJ+4sJfeN+IG6RNbHXLN5SkEjBKdTzg3TB1H2wugNYdhvwM0GjIGgXIONS24
 FiKE7qoHVezm7X/1tLGFUE+mTYASBAv9+8UsxHMplkR4+x+7Fvr6glxgy5nOIkrUyj8n
 b4XQ==
X-Gm-Message-State: AC+VfDxI6M0aHBlM1C+tJv3iK++OEx8RC+wQr5/JvUwnwjLQkNUek00J
 lHLw19pWPRiJ+EF47a/3Kp4dBNgEh66KBjgtgf8/F66JrxT6M0/TImVXq3C264uQVOB58Rr1ueO
 Q0GumJMetPj60S+k=
X-Received: by 2002:a17:907:7207:b0:988:8786:f56c with SMTP id
 dr7-20020a170907720700b009888786f56cmr11691680ejc.0.1687456119242; 
 Thu, 22 Jun 2023 10:48:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JXhjtWpIpnktBexR3Qc8JD1of5O+02ui90OOo86ADX4k+EfuRDswQKn0eH4naY5uFdM+vig==
X-Received: by 2002:a17:907:7207:b0:988:8786:f56c with SMTP id
 dr7-20020a170907720700b009888786f56cmr11691669ejc.0.1687456118857; 
 Thu, 22 Jun 2023 10:48:38 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 lf4-20020a170906ae4400b0098822e05eddsm4936093ejb.100.2023.06.22.10.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 10:48:38 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:48:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com
Subject: Re: [PATCH v2 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230622134437-mutt-send-email-mst@kernel.org>
References: <20230622103255.267289-1-anisinha@redhat.com>
 <20230622103255.267289-6-anisinha@redhat.com>
 <CAMDeoFWHJhN3ppAO4XB9jGUg4Yu-zFzzzKwAvDiSJSgjeZH6jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMDeoFWHJhN3ppAO4XB9jGUg4Yu-zFzzzKwAvDiSJSgjeZH6jg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Thu, Jun 22, 2023 at 05:46:40PM +0200, Julia Suvorova wrote:
> On Thu, Jun 22, 2023 at 12:34 PM Ani Sinha <anisinha@redhat.com> wrote:
> >
> > PCI Express ports only have one slot, so PCI Express devices can only be
> > plugged into slot 0 on a PCIE port. Enforce it.
> >
> > CC: jusual@redhat.com
> > CC: imammedo@redhat.com
> > Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  hw/pci/pci.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index bf38905b7d..5f25ab9f5e 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -64,6 +64,7 @@ bool pci_available = true;
> >  static char *pcibus_get_dev_path(DeviceState *dev);
> >  static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >  static void pcibus_reset(BusState *qbus);
> > +static bool pcie_has_upstream_port(PCIDevice *dev);
> >
> >  static Property pci_props[] = {
> >      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> > @@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >                     name);
> >
> >         return NULL;
> > +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> > +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> > +                   " PCI express devices can only be plugged into slot 0.",
> 
> This is not technically correct, because downstream ports and root
> ports are also PCIe devices, and they can have different slots under
> upstream ports and RC. But this error will never be shown for them, so
> it seems fine.

Hmm. Confusing users is not nice ... I agree this might
make people think they can not use root ports in slot !=0 either.

Would you add "with an upstream port"?
E.g. "PCI Express devices with an upstream port" ?

> 
> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> 
> 
> 
> 
> > +                   PCI_SLOT(devfn), name);
> > +        return NULL;
> >      }
> >
> >      pci_dev->devfn = devfn;
> > --
> > 2.39.1
> >


