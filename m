Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A120273D45A
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDX1R-0002jy-Ug; Sun, 25 Jun 2023 17:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDX1P-0002jp-Nh
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDX1O-0008WQ-5j
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687727505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TK+ns4k29Ukbq3LkXpvRnExT8KJwIxoflLAsUDIqGNk=;
 b=eKZnkwEPJP2INCDfujaF50Ye/cwPT/90V2AKRm7Zh8bWaCPe4KS1E1qD5TFDHuDsU/9z6B
 UPr0F47gRo9ckxMMfiiZ/SAT/J2FNG863dpAIieG5DmWhwxIuOio1A7baT/QvTPkLYkDNU
 aTf66QnMciUqYJyYq8Qyo9emVOZaUJ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-4dE_J3MVPdWq9w9aO_EPJA-1; Sun, 25 Jun 2023 17:11:42 -0400
X-MC-Unique: 4dE_J3MVPdWq9w9aO_EPJA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31275586740so1488480f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687727501; x=1690319501;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TK+ns4k29Ukbq3LkXpvRnExT8KJwIxoflLAsUDIqGNk=;
 b=f2lSsrwjOiasCych8/8WKtBtenfYm6KpXsSVjP7Sj2RoO9Rah1KclOfXYWg+UuaXdx
 rSOgxZ0UAOuEosxT9aQX5lJAMkHwrxCIW/kqjv46SlNnPxIblrsS1j2peSQmhC84IFNV
 PFARqvnmP5SpSPk76ogel3aRaIjjoWcdDlkTgmgkpT3qSOMqaxyN49DOGawysqhFcUur
 UlnXUyenKaMCMCzGXISiZwZn3MaZcJR/HVJSrykH/EwgobLqhZf7gXoBy3ORvOVKg0O7
 0C2DqKhGQWozLu+uQAF3FwUBR5KfxTxPM+gZsIOvQ05UOoaDPWGYKp4dWFAFGUherr5d
 x41Q==
X-Gm-Message-State: AC+VfDwraXryurGpqR7468hKifCvGWcnbv7qOJc5LljZK6nxG3ZtufVT
 PeWJYikuOuR5WKbDzx6FWbrg8ZDRZ3AtN6XCjP9u74EMby/Dv4R7Ahnqos5wzYdHVKHoLhIMxIC
 zkChoMbIkuIimLm4=
X-Received: by 2002:a5d:67cd:0:b0:311:1ce8:d05b with SMTP id
 n13-20020a5d67cd000000b003111ce8d05bmr22979724wrw.20.1687727501204; 
 Sun, 25 Jun 2023 14:11:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62Od/Hto8X5yYq+BUXCJtmVcPcuHJ5MXIUK5cQzZOGbbLeObACHkpZdRKAliBYSTduzdyjJg==
X-Received: by 2002:a5d:67cd:0:b0:311:1ce8:d05b with SMTP id
 n13-20020a5d67cd000000b003111ce8d05bmr22979715wrw.20.1687727500875; 
 Sun, 25 Jun 2023 14:11:40 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 u18-20020a5d6ad2000000b00313e90d1d0dsm3480099wrw.112.2023.06.25.14.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:11:40 -0700 (PDT)
Date: Sun, 25 Jun 2023 17:11:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com
Subject: Re: [PATCH v2 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230625171058-mutt-send-email-mst@kernel.org>
References: <20230622103255.267289-1-anisinha@redhat.com>
 <20230622103255.267289-6-anisinha@redhat.com>
 <CAMDeoFWHJhN3ppAO4XB9jGUg4Yu-zFzzzKwAvDiSJSgjeZH6jg@mail.gmail.com>
 <20230622134437-mutt-send-email-mst@kernel.org>
 <CAMDeoFUAaRhN_hRHmTDfu6dWyiz_dNEhCJt9jQTVzeNSTbwuAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMDeoFUAaRhN_hRHmTDfu6dWyiz_dNEhCJt9jQTVzeNSTbwuAg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jun 23, 2023 at 04:57:20PM +0200, Julia Suvorova wrote:
> On Thu, Jun 22, 2023 at 7:48 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 22, 2023 at 05:46:40PM +0200, Julia Suvorova wrote:
> > > On Thu, Jun 22, 2023 at 12:34 PM Ani Sinha <anisinha@redhat.com> wrote:
> > > >
> > > > PCI Express ports only have one slot, so PCI Express devices can only be
> > > > plugged into slot 0 on a PCIE port. Enforce it.
> > > >
> > > > CC: jusual@redhat.com
> > > > CC: imammedo@redhat.com
> > > > Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> > > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > > ---
> > > >  hw/pci/pci.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > index bf38905b7d..5f25ab9f5e 100644
> > > > --- a/hw/pci/pci.c
> > > > +++ b/hw/pci/pci.c
> > > > @@ -64,6 +64,7 @@ bool pci_available = true;
> > > >  static char *pcibus_get_dev_path(DeviceState *dev);
> > > >  static char *pcibus_get_fw_dev_path(DeviceState *dev);
> > > >  static void pcibus_reset(BusState *qbus);
> > > > +static bool pcie_has_upstream_port(PCIDevice *dev);
> > > >
> > > >  static Property pci_props[] = {
> > > >      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> > > > @@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> > > >                     name);
> > > >
> > > >         return NULL;
> > > > +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> > > > +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> > > > +                   " PCI express devices can only be plugged into slot 0.",
> > >
> > > This is not technically correct, because downstream ports and root
> > > ports are also PCIe devices, and they can have different slots under
> > > upstream ports and RC. But this error will never be shown for them, so
> > > it seems fine.
> >
> > Hmm. Confusing users is not nice ... I agree this might
> > make people think they can not use root ports in slot !=0 either.
> >
> > Would you add "with an upstream port"?
> > E.g. "PCI Express devices with an upstream port" ?
> 
> This whole upstream port conditioning is quite confusing.
> How about "%parent device% only allows plugging into slot 0"?
> 
> Best regards, Julia Suvorova.

Good idea!

> > >
> > > Reviewed-by: Julia Suvorova <jusual@redhat.com>
> > >
> > >
> > >
> > >
> > > > +                   PCI_SLOT(devfn), name);
> > > > +        return NULL;
> > > >      }
> > > >
> > > >      pci_dev->devfn = devfn;
> > > > --
> > > > 2.39.1
> > > >
> >


