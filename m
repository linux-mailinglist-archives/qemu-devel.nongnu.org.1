Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D978829F3D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 18:32:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNcQ6-0004On-Ch; Wed, 10 Jan 2024 12:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rNcQ4-0004Oc-5d
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 12:31:12 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rNcQ2-00031P-BK
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 12:31:11 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5cec32dedf3so1910535a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 09:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704907868; x=1705512668; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tzDNvjK6D71YuTCJZMKM5pI+L8TrbMzJbidP9fMagr0=;
 b=nbCGpVnFrMaQfH8QtpjbkH7+IpySf5P8FtirfApsN5ppMkEJcTibMhfl/dydyRrsTw
 qEwo3R+UzcLEheEVZjVLAj8UNuXE/nE2SjFS4/Lq7uGMyZipEHSig3BP4YgDB9W6dSEU
 8jBogyJYdjBG+CI1xsxdQAjpX8nZX0xFkfWXSQlf+8szphFnSayw9EaElzT+NvCDwRKf
 KJY5Xgek/4P32HSxxN4n6CRMx3C8CDjta4Kd5L/zkNDnLA9L5ygLouFhH4KkfSFbHTqf
 C1mUZ/XtdWZvg2T2xtmUWuDQsHUg98SggD3HxTorueJ2W9va+b3setEpXgjLWBs1vycp
 a9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704907868; x=1705512668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzDNvjK6D71YuTCJZMKM5pI+L8TrbMzJbidP9fMagr0=;
 b=g//Um1g970wPdt0gLZhnJlcg4ko+Mcg0Xooq4lNn8PV+QU4AyriXZQjzIbFWN7KGS7
 8ypgS/Bth0xBUsiYF2h+IHyDZr2i5CL1jkgcMbzj38HM7q87AorNwazup0cYSYOkwcMJ
 wud8m2tXoXcdeN3ClgS4U6xCnW+Sr43ot34ay14PlvdgM2KydZ0YATXjduAlmnOOgsS9
 ZXWQY5G3vkIZx+hYTR32J0UR6h1LSjRSSBLINdR/3IRjb1A1Ep05jSkpDcXRo7GBKOmI
 uH7gsot9HqZLNzXJgRAdSCieZyIRRC5yiIxACdbMfDj+BLLdwB8ixEMqTlCtxgzqKfQw
 nSdQ==
X-Gm-Message-State: AOJu0YzvzUp5EYfcFHvaTgwCoZesJ8+3SW7vnjHfVlalvkdOnqGdIlPb
 fj9hFIcJ8o8uHh/veX4/vxo=
X-Google-Smtp-Source: AGHT+IHztGsjsbtNJJFyYnofH9Np74pNcJKNH7eKGOgC2UmfzXzHYw3Kgm3nTP5NnkIsObZ9txXtlA==
X-Received: by 2002:a17:90b:fd8:b0:28d:add8:b68a with SMTP id
 gd24-20020a17090b0fd800b0028dadd8b68amr1010481pjb.84.1704907868410; 
 Wed, 10 Jan 2024 09:31:08 -0800 (PST)
Received: from debian (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
 by smtp.gmail.com with ESMTPSA id
 px8-20020a17090b270800b0028dc4b598b7sm1452936pjb.55.2024.01.10.09.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 09:31:08 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 10 Jan 2024 09:30:52 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/4] hw/cxl: fix build error in cxl_type3_stubs.c
Message-ID: <ZZ7UTB8FziAglemJ@debian>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
 <20231222090051.3265307-2-42.hyeyoo@gmail.com>
 <20240109174026.00000760@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109174026.00000760@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jan 09, 2024 at 05:40:26PM +0000, Jonathan Cameron wrote:
> On Fri, 22 Dec 2023 18:00:48 +0900
> Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> 
> > Fix build errors in cxl_type3_stubs.c due to a the incorrect definition
> > of the qmp_cxl_{add,release}_dynamic_capacity functions.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Fan, this one needs squashing into your
> hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents
> patch in the DCD series. I'll do that in my tree, but just wanted to
> make sure you noticed this so we don't end up reintroducing it again by
> accident!
> 
> Thanks Hyeonggon,
> 
> Jonathan

Hi Jonathan,
Thanks for the notice. I missed this series. 

I checked the last patch set I sent out in Nov., 2023, there is no issue
there.

https://lore.kernel.org/linux-cxl/20231107180907.553451-9-nifan.cxl@gmail.com/

So the following patch is actually not needed, maybe Hyeonggon's work
was based on some of your local branch which does not have the latest DCD
work.

Thanks,
Fan

> 
> > ---
> >  hw/mem/cxl_type3_stubs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> > index 1b54ec028c..d913b11b4d 100644
> > --- a/hw/mem/cxl_type3_stubs.c
> > +++ b/hw/mem/cxl_type3_stubs.c
> > @@ -68,14 +68,14 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
> >      error_setg(errp, "CXL Type 3 support is not compiled in");
> >  }
> >  
> > -void qmp_cxl_add_dynamic_capacity(const char *path,
> > +void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
> >                                    CXLDCExtentRecordList  *records,
> >                                    Error **errp)
> >  {
> >      error_setg(errp, "CXL Type 3 support is not compiled in");
> >  }
> >  
> > -void qmp_cxl_release_dynamic_capacity(const char *path,
> > +void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
> >                                        CXLDCExtentRecordList  *records,
> >                                        Error **errp)
> >  {
> 

