Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9387D72890D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 21:54:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7LhW-0008Od-23; Thu, 08 Jun 2023 15:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7LhT-0008Nl-Gt
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7LhJ-0006ij-SN
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686254008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vC7XyA4bJXeMDOJ6g8rgw85sGtEAcMqgWzXafJt3OYo=;
 b=aNFmmSfvQeVrO6mxXaFqaiCZJ63dKFJNQiQ3DT1QGr/NMCvAgNNqo4NCqGwVerRX3IxGM3
 2+bMjSDCgvKzJ0CbXyVWkwKvmyb+UuSneC66R8Lvj7v6/nVB7a/9CNGAcWXT7vbr90W/3L
 1lO3Jq7ramfDkoqyy0M/VArmLcoCrOk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-hVtRfzCoP6-WJBeeUGgSFg-1; Thu, 08 Jun 2023 15:53:27 -0400
X-MC-Unique: hVtRfzCoP6-WJBeeUGgSFg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-626204b0663so2100946d6.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 12:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686254006; x=1688846006;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vC7XyA4bJXeMDOJ6g8rgw85sGtEAcMqgWzXafJt3OYo=;
 b=afhASCtibCZGUNG7bvL5bGvrJ7u89FQzfb/FY58+RxEESdeWLxRxWlXCwKzMAclHJg
 MUfuxwVIlcYYqHfVjO8WJFVbZ6nu5x+LA78yupjl/XbnMFBibYWIW1Z9r0Gj6dWDja8D
 EzSkCQKK9grlPXoJvqKNHJLCsUpg/T6I8StekM/EoKSae5EjtKVbvZPCJB6xY5rxAk/F
 3xcAIdzYMLrnMx5KPqTlkOEXE3yi0QytIUEs0aaQCV8RM1sPwI9Y33Ej7mqZcQKCIW1a
 BMnzqYU3+A/PJw3rmzqQCtaK8z6ZtLw4Ft+ZdXjJOMp7rjgVaTgU9LAo+wICzLRQf1KA
 m5VA==
X-Gm-Message-State: AC+VfDzuPW2gyQLst778kM2fxnRqoz50KLg2nhk/2FTzoKzFcm+C0P1V
 dr4Q8aiGbf5P87/Kijk6afKmAcsZAHxgpixLIXny2z/O7Re1qRB4TH3qeyirVAFaiy8KcXBaDe5
 i78uqY6fAr8K9wHE=
X-Received: by 2002:a05:6214:c6d:b0:616:870c:96b8 with SMTP id
 t13-20020a0562140c6d00b00616870c96b8mr10543434qvj.3.1686254006682; 
 Thu, 08 Jun 2023 12:53:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bQ6shq1FnMSKNeoLNnkxvJ2+wOefepj+jWlSjeoUBAVyZ+1HbEjn1qj/0OTqdgC5Q5q51ZQ==
X-Received: by 2002:a05:6214:c6d:b0:616:870c:96b8 with SMTP id
 t13-20020a0562140c6d00b00616870c96b8mr10543412qvj.3.1686254006348; 
 Thu, 08 Jun 2023 12:53:26 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s3-20020a0cb303000000b0062b35b691cdsm631703qve.93.2023.06.08.12.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 12:53:25 -0700 (PDT)
Date: Thu, 8 Jun 2023 15:53:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Message-ID: <ZIIxs9kXQyULglIJ@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com>
 <ZIHgFFSaBJWFUNd7@x1n> <ZIHhgyUv7YmWsG3H@nvidia.com>
 <ZIH2h7GAV6qirAgw@x1n> <ZIIBhmoT7H2/q0lb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIIBhmoT7H2/q0lb@nvidia.com>
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

On Thu, Jun 08, 2023 at 01:27:50PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 08, 2023 at 11:40:55AM -0400, Peter Xu wrote:
> 
> > > But if there is the proper locks to prevent a map/unmap race, then
> > > there should also be the proper locks to check that there is no map in
> > > the first place and avoid the kernel call..
> > 
> > The problem is IIRC guest iommu driver can do smart things like batching
> > invalidations, it means when QEMU gets it from the guest OS it may already
> > not matching one mapped objects.
> 
> qemu has to fix it. The kernel API is object based, not paged
> based. You cannot unmap partions of a prior mapping.
> 
> I assume for this kind of emulation it is doing 4k objects because
> it has no idea what size of mapping the client will use?

MAP is fine, before notify() to VFIO or anything, qemu scans the pgtable
and handles it in page size or huge page size, so it can be >4K but always
guest iommu pgsize aligned.

I think we rely on guest behaving right, so it should also always operate
on that size minimum when mapped huge.  It shouldn't violate the
"per-object" protocol of iommufd.

IIUC the same to vfio type1v2 from that aspect.

It's more about UNMAP batching, but I assume iommufd is fine if it's fine
with holes inside for that case.  The only difference of "not exist" of
-ENOENT seems to be just same as before as long as QEMU treats it as 0 like
before.

Though that does look slightly special, because the whole empty UNMAP
region can be seen as a hole too; not sure when that -ENOENT will be useful
if qemu should always bypass it anyway.  Indeed not a problem to qemu.

> 
> > We can definitely lookup every single object and explicitly unmap, but it
> > loses partial of the point of batching that guest OS does.  
> 
> You don't need every single object, but it would be faster to check
> where things are mapped and then call the kernel correctly instead of
> trying to iterate with the unmapped reults.

Maybe yes.  If so, It'll be great if Zhenzhong could just attach some proof
on that, meanwhile drop the "iommufd UNMAP warnings" section in the commit
message.

Thanks,

-- 
Peter Xu


