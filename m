Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C982E722D20
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 18:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6DWf-0008P6-1O; Mon, 05 Jun 2023 12:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6DWb-0008Oj-Mz
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6DWa-0001RA-9M
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685984263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYlWyb35oaGV2RAW1P1z3foclDFSFWpLwoV/QCixS5Q=;
 b=GWAgdjFjG51ML0Mcj+HrFG0fuSyxYdkzi8mtfbr0CKSGLFKSp08t3hPC15SCPM+5WSOBU3
 ofobnPkaHB3Aus1k4in4ww1wjOK9jfvO5RQWFYczmQw+XbJAMmN0OJIqAbHQtxRKAGPb8e
 P2N0GTFKeNZI/QKqzRaZS1Exvf+kyTU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-bZFAPZkdMIWiG3YdQ5J88g-1; Mon, 05 Jun 2023 12:57:42 -0400
X-MC-Unique: bZFAPZkdMIWiG3YdQ5J88g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75eb82ada06so28294685a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 09:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685984261; x=1688576261;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYlWyb35oaGV2RAW1P1z3foclDFSFWpLwoV/QCixS5Q=;
 b=fBxgh9FbShDeAQpkLEjihh+ucriHou4ttS+9D6F+UCGfDLal7YLCrI+N4ryyRTdh0q
 KHTrK+/CzNVhv0uOh97yxkrdbOjjvL0ZW3nZe3sFrHCkYiGr9y4OgZCV5Ur9tLOov0aG
 cYOjRH41Duvt9pBfE/K6xB2tKYdV4YXsCuoxiwCeOeZDx18nVq1uHMmiYYJGBZaXPZMF
 tvqvhcviVN0PKJ2ouaA72UnvcQX7Vryq5YPs+mvA1seillz92tPWtRQZ7Eauq2XcMN3H
 bPSG19Z9tMNTRqrgz0GQrcwainfdnEn+Oi0gSe95yZQoH6ODrf9iAnVuoJwl8fgkOreI
 LBFw==
X-Gm-Message-State: AC+VfDygoD+6fqHqB5/ekA7Sfs8zAilZRdqTtKetSnYZL7SiFWl2Qnh2
 vIBQjFI3Uf6i8/ZYXOQgOSzR19hv2vIzKPd8wsJjC5i8Yk6P1X8kiCLqy1KVXkpgbVsNovL2ER5
 b6n6z3i8urKRkO0I=
X-Received: by 2002:a37:a84c:0:b0:75b:23a1:69e7 with SMTP id
 r73-20020a37a84c000000b0075b23a169e7mr17977813qke.7.1685984261607; 
 Mon, 05 Jun 2023 09:57:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zQ0nP0PNx6YuufZjHpf9R/wWfeuTJyNaEtmpwr2BlA6HjoxW33jPHLylARNUm9GdXq6YoeA==
X-Received: by 2002:a37:a84c:0:b0:75b:23a1:69e7 with SMTP id
 r73-20020a37a84c000000b0075b23a169e7mr17977796qke.7.1685984261297; 
 Mon, 05 Jun 2023 09:57:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u22-20020a05620a121600b0075783f6c2b4sm4308899qkj.128.2023.06.05.09.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 09:57:40 -0700 (PDT)
Date: Mon, 5 Jun 2023 12:57:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 03/15] hw/pci: Add a pci_device_iommu_memory_region()
 helper
Message-ID: <ZH4UAtl1v8JDWsl1@x1n>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-4-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530175937.24202-4-joao.m.martins@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, May 30, 2023 at 06:59:25PM +0100, Joao Martins wrote:
> Much like pci_device_iommu_address_space() fetches the IOMMU AS, add a
> pci_device_iommu_memory_region() which lets it return an the IOMMU MR
> associated with it. The IOMMU MR is returned correctly for vIOMMUs using
> pci_setup_iommu_info(). Note that today most vIOMMUs create the address
> space and IOMMU MR at the same time, it's just mainly that there's API
> to make the latter available.

Have you looked into other archs outside x86?  IIRC on some other arch one
address space can have >1 IOMMU memory regions.. at least with such AS and
MR layering it seems always possible?  Thanks,

-- 
Peter Xu


