Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F98373FB8A
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:59:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7LU-0002eC-H7; Tue, 27 Jun 2023 07:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE7LT-0002dn-9X
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE7LR-0006Hi-Kp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687867133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGwD2f3IYeCYv4HumCrhp7dhD0eVzg7wlP4QIoBlgvM=;
 b=PipcLyatL/lQFA+F9dac035Zcw3vmVy3pkeSWG2ZsdjaPpo60oJUnIOCh6duzpRzNSKtMO
 WfaGRzGtX2/pCDT99kYzIhIEEku8Gh2+/PdFH3DPvsd9XOGfGJRt6tpyMNmQgW383aCfPz
 MjQ0W3vvzOTjqnE94shcHfqEawHzDG8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-EN7T-peJOOmF3iXW1W_nYg-1; Tue, 27 Jun 2023 07:58:51 -0400
X-MC-Unique: EN7T-peJOOmF3iXW1W_nYg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-97542592eb9so246126766b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687867130; x=1690459130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGwD2f3IYeCYv4HumCrhp7dhD0eVzg7wlP4QIoBlgvM=;
 b=b57/fnUiXiWd7g1lx3BANBiYFZ/6p07HNW+4aMkzwqIBQVyG/KLIEJ1I1Alc8etcME
 +ngLnJhDoO83MNfyxzwGCPfTM6t66Y9TFhSoNugaWenRtYHOB2BrYx+GJS3EsduGKg13
 A0W8AXEbEyddaRwIlpzUE0zxSdOJF1K8M3V6Ea7cVlxNWrL/cLVz6RNh4C/LqoeERXvq
 X3wkfdhdS35rVSmkowAsz3CTsore7vne6MZxtSNmjV+h5G6i4PuF5lqKW36/mplhCr2u
 7FmdeyuMEr4h6ClIua4htj50bym6OBsK0SRUb1QfhtryeG0jWxzofCUnqFE3fv5v/MXs
 DP9Q==
X-Gm-Message-State: AC+VfDzqtObObzYm58lMgRefkxD48jPmR69PcXCgE+F/OW26Jb0qj5gr
 X2xVtZFiMpjmJeprtCYYeDE17cCmGjJTa9J+MGIEd2/agiuepmikm4uyAqTsDVlHw9sMzYyoD5i
 pcI59HuXdOUQEJ7w=
X-Received: by 2002:a17:907:26c3:b0:987:8c40:c1d5 with SMTP id
 bp3-20020a17090726c300b009878c40c1d5mr25375357ejc.27.1687867130494; 
 Tue, 27 Jun 2023 04:58:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47w8TbY3BBWfDe83LgU8PsyweKOu+9CRsuLPZZC/PLKp4PCCMgdghx8h4sVtLhYbYASRV9Wg==
X-Received: by 2002:a17:907:26c3:b0:987:8c40:c1d5 with SMTP id
 bp3-20020a17090726c300b009878c40c1d5mr25375343ejc.27.1687867130222; 
 Tue, 27 Jun 2023 04:58:50 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 pv18-20020a170907209200b0098dc18c1429sm4447320ejb.209.2023.06.27.04.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 04:58:49 -0700 (PDT)
Date: Tue, 27 Jun 2023 13:58:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
Message-ID: <20230627135849.37e52f87@imammedo.users.ipa.redhat.com>
In-Reply-To: <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
 <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Tue, 27 Jun 2023 15:23:04 +0530
Ani Sinha <anisinha@redhat.com> wrote:

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
> Regardless, I think at least the tests are worth fixing, particularly the mess with hd-geo-test.

I'm fine with this patch if you test it with ARI enabled and it won't break
something that has been working before this patch. Just mention what testing
you've done in commit message.

> 
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
> 


