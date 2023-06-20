Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AEC736BB7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:14:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaFj-0001UW-QT; Tue, 20 Jun 2023 08:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBaFh-0001Qc-Jq
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBaFf-0002xQ-Qd
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687263267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pr+4LVY6eewLJ1yOdvykAeX8DZOF5/XHdNMp3WfZrHE=;
 b=jRJ5P/kSN1GxO62ZAzQ4UkAXVRpUsqZiyfNwb8fVdyExRlhu3+RX0NYiAWzbQLSfP1TG+H
 4h3WK3Vv3FDIqy5o6oIFpe5srjzxA4OGWf0UCTwM8xANWkUm0NZ4D2hMoj8jpGFpFcSWKL
 mRsNyIwmKzCMr3I8kHDT+XhzqP3cX4g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-NSQnkwwBM-iF8ZZuUuDrsw-1; Tue, 20 Jun 2023 08:14:25 -0400
X-MC-Unique: NSQnkwwBM-iF8ZZuUuDrsw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31283f4d22fso70663f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687263264; x=1689855264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pr+4LVY6eewLJ1yOdvykAeX8DZOF5/XHdNMp3WfZrHE=;
 b=JDngnwHXFkxT7xRXRHOyouh1v8QAUKD/1KS/srSld+CULiTrCM0wfVZ/Qtns16DlXv
 dpDE91NyLI20esma2KJexRj/Y/sdRgIijWuk37zWAHI0hDQ9RSX/qB82Vv28Q4Lb4ZSp
 W6uor7UP5zuU/D1QkHZ+TmAT2JXUEfmAV3DP/V4jKB+mVnFerckFahvz+EZ992HhDAMK
 2eNu2D90VUqbZReY3tRO2LG4b0dTs/mRzdScFcRD8FduwhsDRiwBGDrNk9j8+xt09x75
 RVLqRQw/j0I4TwHIZ5UiZ311vB81YIrT6yC5HmKrodlx266Sh1c3tN37/jwir6niJMdR
 VVrQ==
X-Gm-Message-State: AC+VfDwapdkBt1HzE3QOhK01hFj82ujfERTw1HZ9iIHwPMMkLDqDvmHH
 yRYfuH89Qg2ow2Hpkx8DVAjeG6EKYd5yLOD3ARidMGqJrjeeIYedQyjhl4kM5Rago9x9qYSS/uo
 czyrgohkwsKP9sMA=
X-Received: by 2002:a5d:4008:0:b0:2ff:f37:9d0f with SMTP id
 n8-20020a5d4008000000b002ff0f379d0fmr7842103wrp.57.1687263264518; 
 Tue, 20 Jun 2023 05:14:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Rls+hfH74V2vI3IAnShQfKQUGXN7YXzhS5ltXO992Dp4rvOX6JPIfu8Y0zmzJk775pJwrgw==
X-Received: by 2002:a5d:4008:0:b0:2ff:f37:9d0f with SMTP id
 n8-20020a5d4008000000b002ff0f379d0fmr7842087wrp.57.1687263264224; 
 Tue, 20 Jun 2023 05:14:24 -0700 (PDT)
Received: from redhat.com ([2.52.15.156]) by smtp.gmail.com with ESMTPSA id
 l15-20020a7bc44f000000b003f90846d8a7sm9378822wmi.6.2023.06.20.05.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:14:23 -0700 (PDT)
Date: Tue, 20 Jun 2023 08:14:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4] hw/pci: enforce use of slot only slot 0 when devices
 have an upstream PCIE port
Message-ID: <20230620081131-mutt-send-email-mst@kernel.org>
References: <20230620071805.4400-1-anisinha@redhat.com>
 <20230620105942.0e551fe8@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620105942.0e551fe8@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Jun 20, 2023 at 10:59:42AM +0200, Igor Mammedov wrote:
> On Tue, 20 Jun 2023 12:48:05 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
> 
> > When a device has an upstream PCIE port, we can only use slot 0. Non-zero slots
> > are invalid. 
> > This change ensures that we throw an error if the user
> > tries to hotplug a device with an upstream PCIE port to a non-zero slot.
> 
> Isn't the same true for coldplugged devices?
> Why you limit it only to hotplug?
> 
> > 
> > CC: jusual@redhat.com
> > CC: imammedo@redhat.com
> > Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  hw/pci/pci.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > changelog:
> > v2: addressed issue with multifunction pcie root ports. Should allow
> > hotplug on functions other than function 0.
> > v3: improved commit message.
> > v4: improve commit message and code comments further. Some more
> > improvements might come in v5. No claims made here that this is
> > the final one :-)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index bf38905b7d..30ce6a78cb 100644
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
> > @@ -1182,6 +1183,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >      } else if (dev->hotplugged &&
> >                 !pci_is_vf(pci_dev) &&
> >                 pci_get_function_0(pci_dev)) {
> > +        /*
> > +         * populating function 0 triggers a bus scan from the guest that
> > +         * exposes other non-zero functions. Hence we need to ensure that
> > +         * function 0 wasn't added yet.
> > +         */
> >          error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
> >                     " new func %s cannot be exposed to guest.",
> >                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> > @@ -1189,6 +1195,18 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >                     name);
> >  
> >         return NULL;
> > +    } else if (dev->hotplugged &&
> > +               !pci_is_vf(pci_dev) &&
> > +               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> > +        /*
> > +         * If the device has an upstream PCIE port, like a pcie root port,
> > +         * we only support functions on slot 0.
> > +         */
> > +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> > +                   " only functions on slot 0 is supported for devices"
> > +                   " with an upstream PCIE port.",
> 
> upstream port language is confusing here and elsewhere you mention it.
> It would be better to use root-port instead.

No i do not think this is specific to root ports.
it is technically any non-integrated express device but we also plug
pci devices into express ports as a hack.
so checking where device is plugged (this is what pcie_has_upstream_port
does) seems like a reasonable approach.

> > +                   PCI_SLOT(devfn), name);
> > +        return NULL;
> >      }
> >  
> >      pci_dev->devfn = devfn;


