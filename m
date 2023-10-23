Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2527D2F91
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 12:22:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qus3E-00010R-Vi; Mon, 23 Oct 2023 06:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1qus3C-00010H-Fg
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:20:46 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1qus34-0006Sx-Dr
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:20:40 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so385163266b.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1698056436; x=1698661236; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BuiG7nIfc9kiBUbruMz9kzdSGS6ACMxDj2X+ABh+FQY=;
 b=lFcGnRncdPBwufn9PSf8ZhR9a3ztgncqgbo273YVcCg5WoecgEQQlxhwCQ2wWO3Bag
 yH9Z02Ae3yl0icl/si6RV03wCcWYGXcjbg4ib64HC+dbdtdgDgSeVwhNVfzkBNWE1WV3
 49M2DJQF+Xu7Qz33+t+WnqQ1dX+FIGFfKJ1GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698056436; x=1698661236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuiG7nIfc9kiBUbruMz9kzdSGS6ACMxDj2X+ABh+FQY=;
 b=WYMVmfBaGi2gJWfyqUa+BQNZUuSbrnjpHsVFJcH0PfzHmdrX7nFGcWAjpDxWd/KSKM
 Wy3hah+Upi1uC/MCnLFJBIxcBU/832QHBzklan1OYLoiHXp6oFCkZRYFczDFNhrypJxY
 4OR3LKKRu2EQhK7hJGMyYIv6tJtmFJHvfbiz7cg3JmcEmJ0PeKji+aMB0FJrWpquAjgV
 /q2RXC/rvhxUMX0PdwR1EiFdpSWv/sTuHG1VUl7EGPHE0vEWuGin1QVk6c2G417LFtYY
 alcF661rZZCrODhTWjZGR8axAuYRB2P8pmRIVdZ1uFuo3uja36FaUVKlBz3xy1Gjh/HV
 dJVA==
X-Gm-Message-State: AOJu0YzvBqzgrOOyXQjUmSppwELSGFldLNPSy4yZz1oyT27Xg6Nz6zdq
 aG81MBNqs48foK40MF6dMXld7Q==
X-Google-Smtp-Source: AGHT+IErp7TjDMR/UbYPqa9SztjLUVsq32jr9HyVBudMf3DQsuxoH+yqtEfss/q/f83eXnU+4lMpSw==
X-Received: by 2002:a17:907:86a0:b0:9bd:fc4a:c70b with SMTP id
 qa32-20020a17090786a000b009bdfc4ac70bmr7690113ejc.70.1698056435966; 
 Mon, 23 Oct 2023 03:20:35 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 f7-20020a1709062c4700b009c3828fec06sm6290437ejh.81.2023.10.23.03.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 03:20:35 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:20:34 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [QEMU][PATCH v4 1/2] xen_arm: Create virtio-mmio devices during
 initialization
Message-ID: <153814fe-0989-48a9-9d2f-45c09e1ad517@perard>
References: <20230830043518.21584-1-vikram.garhwal@amd.com>
 <20230830043518.21584-2-vikram.garhwal@amd.com>
 <9f3aad26-0233-4987-9fb0-cfcf8d424ef4@perard>
 <ZSb2BlxYGOfbshqq@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSb2BlxYGOfbshqq@amd.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=anthony.perard@cloud.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 11, 2023 at 12:22:46PM -0700, Vikram Garhwal wrote:
> Hi Anthony,
> On Thu, Oct 05, 2023 at 11:40:57AM +0100, Anthony PERARD wrote:
> > Hi Vikram,
> > 
> > This patch prevent QEMU from been build with Xen 4.15. See comments.
> > 
> > Also, why didn't you CC all the maintainers of
> > include/hw/xen/xen_native.h?
> I missed it. Initial version didn't have this file change and i missed updating
> my cc list.

I use `cccmd` to never miss anyone, and I don't have to build a cc list ;-)

$ git config sendemail.cccmd
scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback

> > > +static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
> > > +                                               domid_t domid, uint32_t irq,
> > > +                                               unsigned int level)
> > > +{
> > > +    return 0;
> > 
> > Shouldn't this return something like -ENOSYS, instead of returning a
> > success?
> Changed return to -ENOSYS for older version.

Actually, at least on linux, looks like the function would return either
-1 or 0, and set errno. It seems that xendevicemodel_set_irq_level()
ultimately called ioctl(), but also the code in
xen.git/tools/libs/devicemodel/ also only returns -1 or 0.

So it's probably best to set errno=ENOSYS and return -1.

> > 
> > > diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> > > index 1d3e6d481a..7393b37355 100644
> > > --- a/hw/arm/xen_arm.c
> > > +++ b/hw/arm/xen_arm.c
> > > +
> > > +static void xen_set_irq(void *opaque, int irq, int level)
> > > +{
> > > +    xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level);
> > 
> > So, you just ignore the return value here. Shouldn't there be some kind
> > of error check?
> > 
> > And is it OK to create a virtio-mmio device without an error, even when
> > we could find out that it never going to work (e.g. on Xen 4.14)?
> This is something Oleksandr can answer better as it was written by him. But
> I think we can print an error "virtio init failed" and exit the
> machine init. Does that aligns with your thinking?

Something like that, yes, if possible. It would be a bit difficult
because xen_set_irq() seems to only be a handler which might only be
called after the machine as started. So I'm not sure what would be best
to do here.

Thanks,

-- 
Anthony PERARD

