Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BB773FB7C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:55:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7IB-0007Fz-Ds; Tue, 27 Jun 2023 07:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qE7I4-0007BW-Gh
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qE7I2-0005eO-Lq
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687866921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FskSiYv/uUH+D+w06Y2Q1UeDRZM2wNOh8pvtBgJGRJY=;
 b=SWVd7k0oPzTF9s1gj/J8rFkMZNG/vvUtD/AbD1NboffXkL+28DCtAGB3IWXktJxmaws17I
 D/qY+ayQ17Shurk3+Gzonngj7CZtaer+CScwPEuFbuKFxpPLDllk7od9USsmnp/gI/6Gi9
 auvDRUdpGtjKaIaYPVl+GwLfVhyCbgg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-5fWmRlEDOpCp5ZGpz53j3w-1; Tue, 27 Jun 2023 07:55:19 -0400
X-MC-Unique: 5fWmRlEDOpCp5ZGpz53j3w-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f9644c213aso3397313e87.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866918; x=1690458918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FskSiYv/uUH+D+w06Y2Q1UeDRZM2wNOh8pvtBgJGRJY=;
 b=MUAsqK2xCziNSv/27A5DP3MKJKsBtJhbOmNQfmH2o49OHa8mseD0oPAqAkv67+eBI5
 9aRHFRdXkTmW2G2yRfwF+z9Eia6nMOsz4beWw7ptz2SKg41r5FT9/amKgNPeR7PCWK4B
 0M1isi2ZA/QRtI1e6uo7jqHh+jpJQYLfxGAs4hVWnRCwzByWwkS+8qolt1K+YyXKUfKy
 Ti8YDysn5Rg3TLRMkzHDWHAYA6AVg/KbBS97snWtdnFWNJNXaFr5HqZmm+x70GtZdcP+
 X6q4ls1Vg6dVeFSjuSXTCdpLd8l/dt2dd942G1OvEFTaxlFBHNJv49JbVlcOm665A4uA
 duYw==
X-Gm-Message-State: AC+VfDzT+7mZctX/HoE72PdW2Jwp0KbwJXI2wG44mLueh5mVwrae9J0x
 AANNqFZqZQsW6D9QKdi3yr7571yN1P6vrV0bWHG3EcpV4JWjjB6y5AA9zqcrsumgIg9IbrQt4Y8
 LyeXC2TMcMY5EObeoDuyvWLM=
X-Received: by 2002:a19:5e02:0:b0:4f1:4cdc:ec03 with SMTP id
 s2-20020a195e02000000b004f14cdcec03mr16917859lfb.18.1687866918010; 
 Tue, 27 Jun 2023 04:55:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44aQaONgiP3/oR8/BjGJ/5IYWwKiQ9khuLlqcb9EcxKIapt72VaK/R+S2XGe8UNkWUz9nI1w==
X-Received: by 2002:a19:5e02:0:b0:4f1:4cdc:ec03 with SMTP id
 s2-20020a195e02000000b004f14cdcec03mr16917847lfb.18.1687866917564; 
 Tue, 27 Jun 2023 04:55:17 -0700 (PDT)
Received: from redhat.com ([2.52.141.236]) by smtp.gmail.com with ESMTPSA id
 c13-20020a7bc00d000000b003f735ba7736sm10661031wmb.46.2023.06.27.04.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 04:55:16 -0700 (PDT)
Date: Tue, 27 Jun 2023 07:55:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
Message-ID: <20230627075433-mutt-send-email-mst@kernel.org>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
 <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
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

On Tue, Jun 27, 2023 at 03:23:04PM +0530, Ani Sinha wrote:
> 
> 
> > On 27-Jun-2023, at 2:32 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > On Mon, 26 Jun 2023 21:42:44 +0530
> > Ani Sinha <anisinha@redhat.com> wrote:
> > 
> >> PCI Express ports only have one slot, so PCI Express devices can only be
> >> plugged into slot 0 on a PCIE port. Enforce it.
> > 
> > btw, previously you mentioned ARI.
> > So if we turn it on, wouldn't this patch actually become regression?
> 
> If ARI breaks this, it will break other areas in QEMU too, ex anywhere pci_get_function_0() is used.

We will just fix pci_get_function_0.

> Regardless, I think at least the tests are worth fixing, particularly the mess with hd-geo-test.

ok

> > 
> >> 
> >> CC: jusual@redhat.com
> >> CC: imammedo@redhat.com
> >> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> >> ---
> >> hw/pci/pci.c | 6 ++++++
> >> 1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index bf38905b7d..426af133b0 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -64,6 +64,7 @@ bool pci_available = true;
> >> static char *pcibus_get_dev_path(DeviceState *dev);
> >> static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >> static void pcibus_reset(BusState *qbus);
> >> +static bool pcie_has_upstream_port(PCIDevice *dev);
> >> 
> >> static Property pci_props[] = {
> >>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >> @@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >>                    name);
> >> 
> >>        return NULL;
> >> +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> >> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> >> +                   " parent device only allows plugging into slot 0.",
> >> +                   PCI_SLOT(devfn), name);
> >> +        return NULL;
> >>     }
> >> 
> >>     pci_dev->devfn = devfn;
> > 


