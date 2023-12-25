Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4481E16C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 16:31:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHmu4-0002Pb-58; Mon, 25 Dec 2023 10:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rHmu1-0002Np-VA
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 10:30:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rHmtz-0007YD-JD
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 10:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703518197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nmzr/BioaCJup9Ek2UcZjWqy6CMOkmVaEU63fK8MlT8=;
 b=aFfH4lg/DBUIry0PYAXeCo0kaXW5AhalwQpd3HDbcMjO5ox9o4A/GiaQGSHoXEmnp+oE38
 9GCvoZTmXejPPg7ylcRsl1e+nzB18/kfbV5N8uCqR8b/rbo1Jw1kXN4+tUjOnsYK5KrBIW
 xPWFpsRx5FMfFNtSTCLQ9WGi4RpHV64=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Qo7X2mtZOYCI5h2DgH52dg-1; Mon, 25 Dec 2023 10:29:55 -0500
X-MC-Unique: Qo7X2mtZOYCI5h2DgH52dg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d17446f11so43841325e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 07:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518194; x=1704122994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nmzr/BioaCJup9Ek2UcZjWqy6CMOkmVaEU63fK8MlT8=;
 b=sp+e9WanDfgSxg4bxtW4HfrUPx/yAfTXoRibvmaycx57+gfeq81s0HwsuztJXXAtZZ
 FV+4xpUX+hsF1W2yo3PXlmvHBuRoXlfFrIbdk/YVKsg5BwGLT9RaItjkgEmRqPjBbVu8
 R/CS83EHIAbsikqEW6dicip0+rzGrTBkavwnmP3C4ZO5M62oaX99yJl4sSAREhXu3ghQ
 anLuG4B/euJ2YcpsboNpAeY8+1qAh/WgxtOHLy829ZNLCGdhScyWGxL6I9bW/jjjsclm
 1DCBPvwp1dDA+y4SDDdnxNwrWboYwDtg+5qgIvKnnK03vg39OYri4RDPj9VeL5GJHn7K
 C0Ng==
X-Gm-Message-State: AOJu0YxH5Dbv3iEtr98aMDJVxjxSz8d+m7NRkYS3i/QuZe2o7R6ualAk
 2RnKbBzhUugkAXbvvq4Yxic+ERw6t0nQ9K+91yIzSvlqqxny3uDMf+z5+quvgd6XgNZHPQcGRL0
 ZI0Ap6FSaytI5p6TU1PIKiws=
X-Received: by 2002:a05:600c:4907:b0:40d:282d:cff with SMTP id
 f7-20020a05600c490700b0040d282d0cffmr2689606wmp.104.1703518194649; 
 Mon, 25 Dec 2023 07:29:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYH4/BvSSDwORtqltZQBBTQQMzBWYTDjkg1Ewe0YGIIxwIs1ZjCxOwft42gJojpva/4zJ1JQ==
X-Received: by 2002:a05:600c:4907:b0:40d:282d:cff with SMTP id
 f7-20020a05600c490700b0040d282d0cffmr2689602wmp.104.1703518194347; 
 Mon, 25 Dec 2023 07:29:54 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
 by smtp.gmail.com with ESMTPSA id
 az42-20020a05600c602a00b0040d4a7f2778sm11483534wmb.32.2023.12.25.07.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:29:53 -0800 (PST)
Date: Mon, 25 Dec 2023 10:29:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] docs/about: Mark the old pc-i440fx-2.0 - 2.3 machine
 types as deprecated
Message-ID: <20231225102932-mutt-send-email-mst@kernel.org>
References: <20231006075247.403364-1-thuth@redhat.com>
 <20231018091534-mutt-send-email-mst@kernel.org>
 <eaf2569d-e9fb-45e0-a463-4055c41e0342@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf2569d-e9fb-45e0-a463-4055c41e0342@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 18, 2023 at 03:28:16PM +0200, Thomas Huth wrote:
> On 18/10/2023 15.17, Michael S. Tsirkin wrote:
> > On Fri, Oct 06, 2023 at 09:52:47AM +0200, Thomas Huth wrote:
> > > As we've seen in the past, it's useful for deprecating old machine
> > > types to finally be able to get of legacy code or do other clean-ups
> > > (see e.g. commit ea985d235b868047 that was used to drop the PCI code in
> > > the 128k bios binaries to free some precious space in those binaries).
> > > 
> > > So let's continue deprecating the oldest pc machine types. QEMU 2.3
> > > has been released 8 years ago, so that's plenty of time since such
> > > machine types have been used by default, thus deprecating pc-i440fx-2.0
> > > up to pc-i440fx-2.3 should be fine nowadays.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   docs/about/deprecated.rst | 8 ++++++++
> > >   hw/i386/pc_piix.c         | 1 +
> > >   2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > > index e43de9c183..c016bb9b20 100644
> > > --- a/docs/about/deprecated.rst
> > > +++ b/docs/about/deprecated.rst
> > > @@ -277,6 +277,14 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
> > >   better reflects the way this property affects all random data within
> > >   the device tree blob, not just the ``kaslr-seed`` node.
> > > +``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
> > > +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> > > +
> > > +These old machine types are quite neglected nowadays and thus might have
> > > +various pitfalls with regards to live migration. Use a newer machine type
> > > +instead.
> > > +
> > > +
> > >   Backend options
> > >   ---------------
> > 
> > Wait a sec. Which tree is this against?
> 
> It should be against master. The patch still applies cleanly for me... could
> you please double-check whether your master branch is up to date?

It is ... can you rebase on latest and repost?


> > I don't see this context ever since:
> > 
> > commit f59fb1889f480b0324a7ed0404a68ad5a0ad4f6c
> > Author: Thomas Huth <thuth@redhat.com>
> > Date:   Mon Jan 17 20:16:39 2022 +0100
> > 
> >      hw/i386/pc_piix: Mark the machine types from version 1.4 to 1.7 as deprecated
> 
> It's the context that has been left after Paolo moved the previous entries
> from deprecated.rst to removed-features.rst:
> 
>  https://gitlab.com/thuth/qemu/-/commit/ea985d235b868047cb4d8cb5657bc
> 
> > Also, do we intentionally keep 1.8 and 1.9 as not deprecated?
> 
> There never was a QEMU version 1.8 or 1.9, so there were never such machine
> types.
> 
>  Thomas
> 


