Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1987CDD0A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:17:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6PJ-0000X9-WD; Wed, 18 Oct 2023 09:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qt6PE-0000BK-TP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qt6PD-0001TL-0I
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+meXgqiiWjdExyV93i0tP/pHqzykuokQiL0C19oXLZU=;
 b=f4F0z9cuxJTtQ44ll5xPqLzlOrzA95he142RfNv8ZZiYhGrOvYoU76ZhXGPN6ds4+DLRbe
 chqCHNmoX9w1/CpfugOSzmjQKRyn5Fwkr+uDrKzejPhk8OLjdn25FhbwJSg9QPVDYS5HHf
 UVlvoLXQ2c5zSvBYanml/+LhGzvaxno=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-HuzTxKB6P--DTBQyn6Gp3A-1; Wed, 18 Oct 2023 09:16:08 -0400
X-MC-Unique: HuzTxKB6P--DTBQyn6Gp3A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-637948b24bdso14457636d6.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634968; x=1698239768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+meXgqiiWjdExyV93i0tP/pHqzykuokQiL0C19oXLZU=;
 b=CvVuBWfNnxN7XzWGTA2O8E9Rg1uxxKu9tgyspTT6qCFEv0fXmJ3mgm/FEV9ZLsu4C9
 sE+8G6flE0EyTuV/0HxwjPX3CqN+IjnhIuWZuSGz8jKRBgLCGL5D8Okgukw7pEbG+MyR
 0q4Mgja5oMoZBBs9KiAg8PzIK422JOoXCzX1RBwRnqH6Wzt4Uf4I42QQRagz5nrlQTPm
 4mJOf0OfWqnVV1AnWh0iWDyy8+ay7YoRQNoHcsMTkh27O/3u7p3IDphuSpbixQNn5rZS
 SfBlJ91UEVFNTXFjXt4a/FdZNKvG8HdTGUq8iTFPJJNFo58jsVZtAAe9Xgt9PjWi9Kzz
 n1Cg==
X-Gm-Message-State: AOJu0YwFTMQvPNjphEexLODkT180dcWFZQy/oVOYlG11DUEeH72fNcHV
 jdd5Wj89F9jt+jAvMBFAivWX4q3NHognHllOv9azkONM7l1HCCnzFJtmDr45hF04KSDEnZmi/lP
 x4s/YrO6soEjk/Al4QIyGCUc=
X-Received: by 2002:a05:6214:5d8f:b0:66d:6111:5c5c with SMTP id
 mf15-20020a0562145d8f00b0066d61115c5cmr5343485qvb.3.1697634967839; 
 Wed, 18 Oct 2023 06:16:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxNwlJgMUW6QQh89TrbjeJHhl+MkENtt2rSWxXYd0y+ZMfBxHZNAdmo4P/t13LVOmlxStlew==
X-Received: by 2002:a05:6214:5d8f:b0:66d:6111:5c5c with SMTP id
 mf15-20020a0562145d8f00b0066d61115c5cmr5343472qvb.3.1697634967532; 
 Wed, 18 Oct 2023 06:16:07 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a11-20020a0ce34b000000b0065b231b2cb4sm1309704qvm.105.2023.10.18.06.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 06:16:07 -0700 (PDT)
Date: Wed, 18 Oct 2023 09:16:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Fix parse_ramblock() on overwritten retvals
Message-ID: <ZS/aloqyja/Pah0l@x1n>
References: <20231017203855.298260-1-peterx@redhat.com>
 <87r0lsxv2z.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0lsxv2z.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, Oct 18, 2023 at 09:12:36AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > It's possible that some errors can be overwritten with success retval later
> > on, and then ignored.  Always capture all errors and report.
> >
> > Reported by Coverity 1522861, but actually I spot one more in the same
> > function.
> >
> > Fixes: CID 1522861
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/ram.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index c844151ee9..d8bdb53a8f 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3888,6 +3888,8 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
> >          ret = qemu_ram_resize(block, length, &local_err);
> >          if (local_err) {
> >              error_report_err(local_err);
> > +            assert(ret < 0);
> > +            return ret;
> 
> I hate that assert.  If you really want that:

Please have a look at qemu_ram_resize().  It only contains two error paths.

> 
> 
>          if (ret < 0) {
>             error_report_err(local_err);

This will be similar to above, if qemu_ram_resize() return <0 with
err==NULL, it'll crash in error_report_err() too.. at error_get_pretty().

>             assert(ret < 0);

This is not necessary.. if in this "if" section.  So we can drop it
(instead of assert it).

>             return ret;
>          }
> 
> Rest of the patch looks ok.

I tend to prefer just merging this.. but if you strongly prefer the other
way, I can drop the assert().  But then I'll prefer "return -EINVAL" rather
than "return ret", if you're fine with it.

Thanks,

-- 
Peter Xu


