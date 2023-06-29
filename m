Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF037429B7
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:33:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtdQ-0005UE-EV; Thu, 29 Jun 2023 11:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qEtdO-0005Tm-14
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qEtdM-00017x-8o
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688052754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6z5aApi7TquddGvlZlUt2BDjL7Wzt4iAyn9wHAWlKqU=;
 b=OQg9MrLfrIMMFMMj3cBm5hatjMVht6VMajaDir5+yQpASp5+j+c5RzKWY/fziUtrygyfBC
 PJi1IiwQ8FCiSEe7r4+x7Iu+ItTUQJSAh4CNeSGFXPycF84I+bcS/KSF8PmiHbGt4tEaON
 7VBnJ5r1xprGkTA4FrfRuM/NoFa2VhE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-hGaGpur6MWCKa2rfdqPDaA-1; Thu, 29 Jun 2023 11:32:33 -0400
X-MC-Unique: hGaGpur6MWCKa2rfdqPDaA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa8f8fb7b3so11676165e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 08:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688052752; x=1690644752;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6z5aApi7TquddGvlZlUt2BDjL7Wzt4iAyn9wHAWlKqU=;
 b=bwwWQ1yzRcwPB7xfm5aX4ItAmkbzfXtEyaqwei4wuACeZ4B8+K3ZcqoKcAcqONRMyL
 ZjNMfWX+6m55YC21tueG2GIJy9/WvCHJjMVR72YSRH66p4aa4iBhHIeiNRnTHY9mYG3B
 GtJPuk93693qHdctUrrBcKZmGhi/0whAhaPYhCdZoKsxq04khnaQ2bQHylcznybkjxJ9
 GufgwfbFj+RnOjJTaY1hoXJOOyOrd3i7xxAIEOczW2hL7rZiabHeTEA1sxXEaS71w4le
 0EBRwmy846NfKoXCw0SV3jNmZU7SocmfsdIix53j9wyjA8klvbpRWKVuBoGLjpIS4nLO
 VQFQ==
X-Gm-Message-State: AC+VfDyKVD342jKYE+wszWG9qVJOswSjhtBgObFFFQXCcm9Llb3a5bkx
 ruFSmlLEkJpB1U1jCwqiFsDRgWpDr1ijn3inOL/aOB/Fkp9/6S6ghTtvHAaqp9lpoulJJ4wb6n+
 PFBKCi0S0pS7B2HU=
X-Received: by 2002:a1c:790c:0:b0:3fb:a100:2581 with SMTP id
 l12-20020a1c790c000000b003fba1002581mr9254706wme.14.1688052752505; 
 Thu, 29 Jun 2023 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4W49ydeQjvqDgYwLNndU4IL3GiPKljY7ljd4FRpyJhBF/R5bJiBSR3X/gSUcpwNpyF8RMqZw==
X-Received: by 2002:a1c:790c:0:b0:3fb:a100:2581 with SMTP id
 l12-20020a1c790c000000b003fba1002581mr9254687wme.14.1688052752150; 
 Thu, 29 Jun 2023 08:32:32 -0700 (PDT)
Received: from redhat.com ([2.52.154.169]) by smtp.gmail.com with ESMTPSA id
 i7-20020a05600c290700b003fbb346279dsm4060367wmd.38.2023.06.29.08.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 08:32:31 -0700 (PDT)
Date: Thu, 29 Jun 2023 11:32:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com,
 imammedo@redhat.com, akihiko.odaki@daynix.com
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230629113141-mutt-send-email-mst@kernel.org>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <20230629102421-mutt-send-email-mst@kernel.org>
 <A398CFAA-12F6-447D-A03D-F2DAC79AB1B7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A398CFAA-12F6-447D-A03D-F2DAC79AB1B7@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Jun 29, 2023 at 08:07:57PM +0530, Ani Sinha wrote:
> 
> 
> > On 29-Jun-2023, at 7:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Thu, Jun 29, 2023 at 09:37:07AM +0530, Ani Sinha wrote:
> >> PCI Express ports only have one slot, so PCI Express devices can only be
> >> plugged into slot 0 on a PCIE port. Enforce it.
> >> 
> >> The change has been tested to not break ARI by instantiating seven vfs on an
> >> emulated igb device (the maximum number of vfs the linux igb driver supports).
> > 
> > I guess we need to test with some other device then? 7 VFs is same
> > slot so hardly a good test.
> 
> No its not the same slot. Its using different slots/device numbers. I checked that.
> The same patch was failing without the vf check.

Ah, playing with VF stride? Could you show the command line please?

> > 
> >> The vfs are seen to have non-zero device/slot numbers in the conventional
> >> PCI BDF representation.
> >> 
> >> CC: jusual@redhat.com
> >> CC: imammedo@redhat.com
> >> CC: akihiko.odaki@daynix.com
> >> 
> >> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> >> ---
> >> hw/pci/pci.c | 15 +++++++++++++++
> >> 1 file changed, 15 insertions(+)
> >> 
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index e2eb4c3b4a..0320ac2bb3 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -65,6 +65,7 @@ bool pci_available = true;
> >> static char *pcibus_get_dev_path(DeviceState *dev);
> >> static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >> static void pcibus_reset(BusState *qbus);
> >> +static bool pcie_has_upstream_port(PCIDevice *dev);
> >> 
> >> static Property pci_props[] = {
> >>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >> @@ -1190,6 +1191,20 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >>                    name);
> >> 
> >>        return NULL;
> >> +    } /*
> >> +       * With SRIOV and ARI, vfs can have non-zero slot in the conventional
> >> +       * PCI interpretation as all five bits reserved for slot addresses are
> >> +       * also used for function bits for the various vfs. Ignore that case.
> >> +       * It is too early here to check for ARI capabilities in the PCI config
> >> +       * space. Hence, we check for a vf device instead.
> >> +       */
> >> +    else if (!pci_is_vf(pci_dev) &&
> >> +             pcie_has_upstream_port(pci_dev) &&
> >> +             PCI_SLOT(devfn)) {
> >> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> >> +                   " parent device only allows plugging into slot 0.",
> >> +                   PCI_SLOT(devfn), name);
> >> +        return NULL;
> >>     }
> >> 
> >>     pci_dev->devfn = devfn;
> >> -- 
> >> 2.39.1
> > 


