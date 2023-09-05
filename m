Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EDE792145
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRxk-000608-4O; Tue, 05 Sep 2023 05:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdRxf-0005yq-GQ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdRxd-0001PG-9i
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693904580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISCJw3a4nE7Oy0bGsYEJtXPHTQW8rqSf6hMib2Lt9no=;
 b=WNUuSN91jZlKepCaqoF75mYWnPmQRtt2PGYeBj8uMjU+UOOyMRR/QmMY9qqzbw8tqQ6I9w
 74KRKi24oDMuV1WAozpJDbdsTd8pLS/SiAxZntA/YMxI5iMUTwYBpqNqwnRdIGe/b9ECXB
 hSjbIkUizQoLLs8F853bRS7hAAaumZc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-Ij3iPj-jPfqQjYsmbH1C4w-1; Tue, 05 Sep 2023 05:02:58 -0400
X-MC-Unique: Ij3iPj-jPfqQjYsmbH1C4w-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fe55c417fcso2376367e87.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693904577; x=1694509377;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ISCJw3a4nE7Oy0bGsYEJtXPHTQW8rqSf6hMib2Lt9no=;
 b=ZxBA1TttQ449pgQQ0jbuWbSGreXB7lVl00woKL1VOgiAMKRgNLD3+QjfP85cUWPEPk
 TwOdha2HfAt0n/1uljWAUGvky8IG+kNvR5U9b6aSY9xWc9cfFamNGwb3r5whvKSok6lu
 /jHpl0jvk9kat0FJYLY/GtFwSf9M9Toi8IVhoSMf+goE/g7W79h5iXG0HR0NRoJsmlQo
 hMSvq/81SoB1JIrapV/c+8ntePce/tiN0HysAxnskWIgjWoRPBDumzqYlAezsmBf0eCU
 ndYMI70PQ450INskb1iTZt2vBIvhQ7DM47XhQFuJ3zz218n+/BhsREbrw/4xvojd7I9S
 L4ug==
X-Gm-Message-State: AOJu0Yw7AIVAn173o2W8dV4GwQE5wTRPDpoZ3Ubk2myc1qp/PZNdBGNx
 s+oDFZl0kdfViOpjb+iUcORbDmNNaviU/ScIlFX21tyC7dWGpMewAucVgmrviYffHyULBOHQztP
 Pzo6l0rWsCclmC4k=
X-Received: by 2002:a05:6512:3c9e:b0:500:c2d7:3ab4 with SMTP id
 h30-20020a0565123c9e00b00500c2d73ab4mr9606987lfv.8.1693904577394; 
 Tue, 05 Sep 2023 02:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/9dQHVayD7xesewN/YbshyUMTnNpJKHVUrl3DJF98fIhjAByGAxJJLxlRcuurtPLbd+cfLg==
X-Received: by 2002:a05:6512:3c9e:b0:500:c2d7:3ab4 with SMTP id
 h30-20020a0565123c9e00b00500c2d73ab4mr9606721lfv.8.1693904572214; 
 Tue, 05 Sep 2023 02:02:52 -0700 (PDT)
Received: from redhat.com ([2.52.23.134]) by smtp.gmail.com with ESMTPSA id
 i19-20020a056402055300b005233609e39dsm6932710edx.30.2023.09.05.02.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 02:02:51 -0700 (PDT)
Date: Tue, 5 Sep 2023 05:02:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] hw/pci-bridge/cxl-upstream: Add serial number extended
 capability support
Message-ID: <20230905045849-mutt-send-email-mst@kernel.org>
References: <20230904175752.17927-1-Jonathan.Cameron@huawei.com>
 <ba7d895f-72d0-8a11-34ad-b5ca75f482bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba7d895f-72d0-8a11-34ad-b5ca75f482bb@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 05, 2023 at 10:48:54AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Jonathan,
> 
> On 4/9/23 19:57, Jonathan Cameron wrote:
> > Will be needed so there is a defined serial number for
> > information queries via the Switch CCI.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > No ordering dependencies wrt to other CXL patch sets.
> > 
> > Whilst we 'need' it for the Switch CCI set it is valid without
> > it and aligns with existing EP serial number support. Seems sensible
> > to upstream this first and reduce my out of tree backlog a little!
> > 
> >   hw/pci-bridge/cxl_upstream.c | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> > index 2b9cf0cc97..15c4d84a56 100644
> > --- a/hw/pci-bridge/cxl_upstream.c
> > +++ b/hw/pci-bridge/cxl_upstream.c
> > @@ -14,6 +14,11 @@
> >   #include "hw/pci/msi.h"
> >   #include "hw/pci/pcie.h"
> >   #include "hw/pci/pcie_port.h"
> > +/*
> > + * Null value of all Fs suggested by IEEE RA guidelines for use of
> > + * EU, OUI and CID
> > + */
> > +#define UI64_NULL (~0ULL)
> 
> Already defined in hw/mem/cxl_type3.c, can we move it to some common
> CXL header? Or include/qemu/units.h?

not the last one I think - this is a cxl specific hack to detect that
user has changed the property.


I think we really should have a variant of DEFINE_PROP_XXX that sets a
flag allowing us to detect whether a property has been set manually.
This would be a generalization of DEFINE_PROP_ON_OFF_AUTO.


> >   #define CXL_UPSTREAM_PORT_MSI_NR_VECTOR 2
> > @@ -30,6 +35,7 @@ typedef struct CXLUpstreamPort {
> >       /*< public >*/
> >       CXLComponentState cxl_cstate;
> >       DOECap doe_cdat;
> > +    uint64_t sn;
> >   } CXLUpstreamPort;
> >   CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
> > @@ -326,8 +332,12 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
> >       if (rc) {
> >           goto err_cap;
> >       }
> > -
> > -    cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> > +    if (usp->sn != UI64_NULL) {
> > +        pcie_dev_ser_num_init(d, CXL_UPSTREAM_PORT_DVSEC_OFFSET, usp->sn);
> > +        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET + 0x0c;
> 
> Could it be clearer to have:
> 
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> @@ -23,2 +23,2 @@
> -#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
> -    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> +#define CXL_UPSTREAM_PORT_DVSEC_OFFSET(offset) \
> +    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF + offset)
> 
> ?
> 
> > +    } else {
> > +        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> > +    }
> >       cxl_cstate->pdev = d;
> >       build_dvsecs(cxl_cstate);
> >       cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
> > @@ -366,6 +376,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
> >   }
> >   static Property cxl_upstream_props[] = {
> > +    DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
> >       DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
> >       DEFINE_PROP_END_OF_LIST()
> >   };


