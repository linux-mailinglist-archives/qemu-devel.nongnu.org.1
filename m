Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 994BD7DB959
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:53:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQpQ-0005np-Ur; Mon, 30 Oct 2023 07:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qxQpN-0005nb-Pe
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qxQpL-0008O7-TQ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698666782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qW+r5eKRgIdo9gXwmYcgPabaX9heEeVDrYn2lJHYDk=;
 b=TdczmB/fLMa9OyBtVER8ycaQSWF3XK5I6h7sicg3FG6nwXgqjDklv/DtkYN0RImiroRTa3
 a19lrsyVHXecd8zSxKEH1BNzTi7JEEB4a6dxz8RBMZhzznt6GIs3T5ZjaxR5HUtPA3KG6a
 91y3tIH+p6c/xOqnoMGc5+P7MPjcAcM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-7HLZRYJ-MeuIQtAKpKbn_g-1; Mon, 30 Oct 2023 07:53:00 -0400
X-MC-Unique: 7HLZRYJ-MeuIQtAKpKbn_g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c5032ab59eso45395191fa.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666779; x=1699271579;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+qW+r5eKRgIdo9gXwmYcgPabaX9heEeVDrYn2lJHYDk=;
 b=xVNnlXjHUFxkZXDNA/ZfimDlTisH/xWtENuTreaq9E9CzxnE7VjerMb1FNOe1fruiV
 Iq0ZzIGNLn4RehIuDktpr3JfTqv3vJi3iVWOoaiQq5Lyf4cUT/4pyBkqtvyG0kafk8Nq
 GfvaUdGGh6s45AcuCJCc6TamiysWnlHolDz+KtUDQsBoym6UtcLlUV1H6F9G8FUGUeOT
 FgLKNJGhYG02drSxYG2iS/fForshwjezwbPf2CSh02jxz+B9vwuE9r0vpacU2HLgDGj+
 idNIwCzSIALgxomQrygAeJgega6Y9Tsv9wMpaMV44K+L7khAxV/IXak1WHi5iPUzWwP+
 f9Zg==
X-Gm-Message-State: AOJu0YybAOKz0+IV8siWgT3aoSSSjbnp9nf1WrJ/vjW0l4XUziyOmHkO
 R45RTZwpzxzZCaBOM1+QYNlrV9PpnMXXtb3jjBMyQ0hhNf0+oH/4VLbhXXuOn3fXLfPL5Mf2K8E
 JW4V3kEn/Q1AcPnw=
X-Received: by 2002:a2e:82c5:0:b0:2c5:23ac:3672 with SMTP id
 n5-20020a2e82c5000000b002c523ac3672mr6859858ljh.45.1698666779065; 
 Mon, 30 Oct 2023 04:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF3cZSAf8ceUfSelT/xsTQf42bZkhZJ3mlUp6+KaS+Z5km9fnoXFbfydAox8UkVbWTAoBh4g==
X-Received: by 2002:a2e:82c5:0:b0:2c5:23ac:3672 with SMTP id
 n5-20020a2e82c5000000b002c523ac3672mr6859825ljh.45.1698666778729; 
 Mon, 30 Oct 2023 04:52:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f9:8d1f:b988:36e1:2445:bb0d])
 by smtp.gmail.com with ESMTPSA id
 ew11-20020a05600c808b00b004063c9f68f2sm8836655wmb.26.2023.10.30.04.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 04:52:58 -0700 (PDT)
Date: Mon, 30 Oct 2023 07:52:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Joao Martins <joao.m.martins@oracle.com>,
 Yi Liu <yi.l.liu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5] hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
Message-ID: <20231030075246-mutt-send-email-mst@kernel.org>
References: <20231023082416.180262-1-clg@redhat.com>
 <e0946db3-75b0-4d20-bfbf-a827cbb68ae9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0946db3-75b0-4d20-bfbf-a827cbb68ae9@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 30, 2023 at 10:00:35AM +0100, Cédric Le Goater wrote:
> On 10/23/23 10:24, Cédric Le Goater wrote:
> > From: Yi Liu <yi.l.liu@intel.com>
> > 
> > This patch modifies pci_setup_iommu() to set PCIIOMMUOps
> > instead of setting PCIIOMMUFunc. PCIIOMMUFunc is used to
> > get an address space for a PCI device in vendor specific
> > way. The PCIIOMMUOps still offers this functionality. But
> > using PCIIOMMUOps leaves space to add more iommu related
> > vendor specific operations.
> > 
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: Hervé Poussineau <hpoussin@reactos.org>
> > Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Cc: BALATON Zoltan <balaton@eik.bme.hu>
> > Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Cc: Jagannathan Raman <jag.raman@oracle.com>
> > Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> > Cc: Eric Farman <farman@linux.ibm.com>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Thomas Huth <thuth@redhat.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > [ clg: - refreshed on latest QEMU
> >         - included hw/remote/iommu.c
> >         - documentation update
> >         - asserts in pci_setup_iommu()
> >         - removed checks on iommu_bus->iommu_ops->get_address_space
> >         - included Elroy PCI host (PA-RISC) ]
> > Signed-off-by: Cédric Le Goater <clg@redhat.com>
> > ---
> > 
> >   Hello,
> > 
> >   Initially sent by Yi Liu as part of series "intel_iommu: expose
> >   Shared Virtual Addressing to VMs" [1], this patch would also simplify
> >   the changes Joao wants to introduce in "vfio: VFIO migration support
> >   with vIOMMU" [2].
> > 
> >   Has anyone objections ?
> > 
> >   Thanks,
> > 
> >   C.
> > 
> >   [1] https://lore.kernel.org/qemu-devel/20210302203827.437645-5-yi.l.liu@intel.com/
> >   [2] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
> 
> 
> Applied to vfio-next.
> 
> Thanks,
> 
> C.


Okay.
Acked-by: Michael S. Tsirkin <mst@redhat.com>


