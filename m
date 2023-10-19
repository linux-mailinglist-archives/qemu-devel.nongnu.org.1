Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CBA7CFD52
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:51:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUMN-0006jU-8v; Thu, 19 Oct 2023 10:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtUM1-0006b8-KK
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtULz-0006bt-3c
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697727026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VvWPKAp0GcZVD9rd/s6SCmLA+pIKieNUzG5psatn4fI=;
 b=TFV/tXGXTIzwYw9cIa6Ck5I8DIV4LWKTQozs5Q5kx9nlt4QF1wMkq8MbwLwOd1LXEc4kMY
 NYkE4kVuwsLBlt/SASyY/SWrsAvxiMHmhOxHyuwhEQWzcM17HP4/ytXChFM5z7kvoLPkmd
 1Stb9wCtHghEvKWAr3UlvLY+UZifMVw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-F-6yHtG3PT2QHH-dS3pLtw-1; Thu, 19 Oct 2023 10:50:14 -0400
X-MC-Unique: F-6yHtG3PT2QHH-dS3pLtw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-778a5286540so2521585a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 07:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727014; x=1698331814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvWPKAp0GcZVD9rd/s6SCmLA+pIKieNUzG5psatn4fI=;
 b=sd+raALTCX3E8O2Q8Aiqi1J9MRIyTGd9NUFage/+MAJFY3rJOuXihtAifVUifOhsnx
 QtY9VCZWIUpgxffI+4Hn+T0vgmYNI+t91W7aKt8tBzweJmQwcPW0ZzL7ec/gZ+G1Q1IN
 k1f+PRt5nkC6pfAmoxE+AZ6Qr+XBQu6lwjNJQQ61MBZFFmJaZexxt2rAPmOZA/gnp1FZ
 gUs/EEsWLiGhyxRJY5ubSOHBNRJEmUCKT+LUVaCNQNhTwQglKlOcBGjDwTQBQyQgEJff
 0Gz3hD9fjF29yFdAwqtdahxjtnHKNPDJ1uOtBWjmF/WuTRADbtZK2YLBybjApBcdNHxO
 R4nA==
X-Gm-Message-State: AOJu0Yzd0JDmwAo6ciPUTIphOBkF2427ospUD4UE2rm2lHtBz4kicT/+
 7/FRwW4H/H3NxBwPIyi8iJLVcw85nA0XkOpBygTWXpdPeDwR6gv1S5xe/wOgdduV5q6tTs7itGy
 PvBj++3HzngPptc4=
X-Received: by 2002:a05:620a:8cb:b0:76f:1118:9b62 with SMTP id
 z11-20020a05620a08cb00b0076f11189b62mr2259502qkz.3.1697727014438; 
 Thu, 19 Oct 2023 07:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1vX9FRdeee0fsGcGPF9fjWXc38S3aFyk3W1iXZHvZphS5RW0VQwku2bcTMryD7y5jZMUnwg==
X-Received: by 2002:a05:620a:8cb:b0:76f:1118:9b62 with SMTP id
 z11-20020a05620a08cb00b0076f11189b62mr2259485qkz.3.1697727014145; 
 Thu, 19 Oct 2023 07:50:14 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 bj36-20020a05620a192400b0077434d0f06esm788670qkb.52.2023.10.19.07.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 07:50:13 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:50:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Fix parse_ramblock() on overwritten retvals
Message-ID: <ZTFCJLnmdf6l/LJp@x1n>
References: <20231017203855.298260-1-peterx@redhat.com>
 <CAFEAcA-xOf+TLL9jbjQvdaqOK0ew_xbjnoajTzaxLbkhEz9Vig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-xOf+TLL9jbjQvdaqOK0ew_xbjnoajTzaxLbkhEz9Vig@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Oct 19, 2023 at 01:40:29PM +0100, Peter Maydell wrote:
> On Tue, 17 Oct 2023 at 21:40, Peter Xu <peterx@redhat.com> wrote:
> >
> > It's possible that some errors can be overwritten with success retval later
> > on, and then ignored.  Always capture all errors and report.
> >
> > Reported by Coverity 1522861, but actually I spot one more in the same
> > function.
> 
> The other one is CID 1522862, I think.

Yes..

> 
> > Fixes: CID 1522861
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
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
> 
> We usually don't bother asserting for this kind of "function
> reports errors two ways" code.

Juan, please feel free to drop the assert() if it's in the queue.

After this one lands, I'll send a patch to remove qemu_ram_resize retval
and only rely on Error*.

Thanks,

-- 
Peter Xu


