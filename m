Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 175377283DF
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:42:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Hl7-00042M-H3; Thu, 08 Jun 2023 11:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7Hl6-00041V-CK
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7Hl3-0005Qh-Np
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686238863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RGT/UfpiOVwyrJBmSbv/D4uweEXUIu50GQMEXgTpiKQ=;
 b=iV4Tp1K3tdZnz1FbYDU0kc09w2KZ9P7WxQko5UCVO38tQY85vCq8QOISXNjXd/R7VM21dj
 7Djz4YEz8JFiAj4N5cbb3LaV/heXiYV1hH9TcZBjbcWI8qrl3u1gNl25ooyzIoAMA8w0K5
 vIIUQmbeqHteKhbkgb29kDmIhPTyXIQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-IwouAy1JPkyGLpTV62XXVA-1; Thu, 08 Jun 2023 11:41:00 -0400
X-MC-Unique: IwouAy1JPkyGLpTV62XXVA-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-39ac408a2f5so106629b6e.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 08:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686238859; x=1688830859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGT/UfpiOVwyrJBmSbv/D4uweEXUIu50GQMEXgTpiKQ=;
 b=D95MiO+b5wYJFBm6Jv0w9/MY0x5fUBoHyloiYaWkYrfL6I/Bl90LhoiYdRANtmNwuH
 I8D0d2OWfW6cqXYfP1GQWOTf6Gq8hyg3AZrd5JazEhAJIHfPw6C8KVdLVaBJR+6ZDjxZ
 uZPQgbO6zP13hr00IJ3uJprdUXwZ4uEiD1blvOpWGbPeXd14dumRHp+BlxfAuwPgOgs3
 /u/gH6al/Yo8ne1TgRHYHdStCPM59P03MGS9HS6MC+6FgjjCyJfXVWmV4r3z/DkU4FJJ
 XU6irZTquOr/xZJtBE76mWgmJR7clfBngpc7ST7+I/SrHYCMPcjXymBK+/dBaYcC45G0
 VqzQ==
X-Gm-Message-State: AC+VfDynmN+u8aDRGJ6UgC3xB2KVC+rPr1qvadtj9HtRhZGukns73OaV
 sbd5twtAWFXZQ4pjqcuAyej0mbHkvzoqnT9QRdqPdnuShEd7gAOrkjh4PsGnP/FGQ2Xs4Ueffmt
 NyQbQ8oa/46rSBUA=
X-Received: by 2002:aca:61d6:0:b0:39a:2b38:5a67 with SMTP id
 v205-20020aca61d6000000b0039a2b385a67mr4500114oib.4.1686238859177; 
 Thu, 08 Jun 2023 08:40:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7A+Zuoaf2Tz/1ALQYe1dTcCu/vF6eyikluhcWmkeggIhY6wqzkBhGQ92ZteI/4feYpBjWScA==
X-Received: by 2002:aca:61d6:0:b0:39a:2b38:5a67 with SMTP id
 v205-20020aca61d6000000b0039a2b385a67mr4500092oib.4.1686238858856; 
 Thu, 08 Jun 2023 08:40:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s12-20020a0cdc0c000000b006262956aa0fsm461760qvk.106.2023.06.08.08.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:40:57 -0700 (PDT)
Date: Thu, 8 Jun 2023 11:40:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 clg@redhat.com, david@redhat.com, philmd@linaro.org,
 kwankhede@nvidia.com, cjia@nvidia.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Message-ID: <ZIH2h7GAV6qirAgw@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com>
 <ZIHgFFSaBJWFUNd7@x1n> <ZIHhgyUv7YmWsG3H@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIHhgyUv7YmWsG3H@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Jun 08, 2023 at 11:11:15AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 08, 2023 at 10:05:08AM -0400, Peter Xu wrote:
> 
> > IIUC what VFIO does here is it returns succeed if unmap over nothing rather
> > than failing like iommufd.  Curious (like JasonW) on why that retval?  I'd
> > assume for returning "how much unmapped" we can at least still return 0 for
> > nothing.
> 
> In iommufd maps are objects, you can only map or unmap entire
> objects. The ability to batch unmap objects by specifying an range
> that spans many is something that was easy to do and that VFIO had,
> but I'm not sure it is actually usefull..
> 
> So asking to unmap an object that is already known not to be mapped is
> actually possibly racy, especially if you consider iommufd's support
> for kernel-side IOVA allocation. It should not be done, or if it is
> done, with user space locking to protect it.
> 
> For VFIO, long long ago, VFIO could unmap IOVA page at a time - ie it
> wasn't objects. In this world it made some sense that the unmap would
> 'succeed' as the end result was unmapped.
> 
> > Are you probably suggesting that we can probably handle that in QEMU side
> > on -ENOENT here for iommufd only (a question to Yi?).
> 
> Yes, this can be done, ENOENT is reliably returned and qemu doesn't
> use the kernel-side IOVA allocator.
> 
> But if there is the proper locks to prevent a map/unmap race, then
> there should also be the proper locks to check that there is no map in
> the first place and avoid the kernel call..

The problem is IIRC guest iommu driver can do smart things like batching
invalidations, it means when QEMU gets it from the guest OS it may already
not matching one mapped objects.

We can definitely lookup every single object and explicitly unmap, but it
loses partial of the point of batching that guest OS does.  Logically QEMU
can redirect that batched invalidation into one ioctl() to the host, rather
than a lot of smaller ones.

While for this specific patch - Zhenzhong/Yi, do you agree that we should
just handle -ENOENT in the iommufd series (I assume it's still under work),
then for this specific patch it's only about performance difference?

Thanks,

-- 
Peter Xu


