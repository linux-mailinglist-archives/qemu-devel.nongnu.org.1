Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FE47D3A17
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 16:54:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwJW-0004m5-VB; Mon, 23 Oct 2023 10:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quwJU-0004lp-VE
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quwJT-00029d-Fd
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698072830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iA3W6Y0JhE2vUD7ScgsqJHElbP5D2rlCckNmrK7Le+A=;
 b=ZLjTVwsNOsF7IjS7yyW8s97pjzoa+zAh8bZNeBylC+ljR2NxbzQAQcSgxdUJ9xoEmUKoth
 Xv8c/m6zaBd1bparttYGRrmYMNP78OUrfY6ygmSrxMfBdYk6lpWGwCq2VZkz/mQnBWHXDD
 yjC69THg4vlNk6y5PnaxbHXK7kZSRCE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-iVB5qNiLOb2U26QM9_DYGg-1; Mon, 23 Oct 2023 10:53:41 -0400
X-MC-Unique: iVB5qNiLOb2U26QM9_DYGg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d7b75c854so9075436d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 07:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698072821; x=1698677621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iA3W6Y0JhE2vUD7ScgsqJHElbP5D2rlCckNmrK7Le+A=;
 b=ikFtu+TSuO2/a31ybsNwnJFz8AHFOO2YBEiPk1Sc+L6swXjXfU46SBTkqIOS6UxbGB
 qmGddK3g5IYWffYk9+s6XX1bCNG+vfe3l4dkYVOiDYQyCevLG74We2TIRmRJF7bB7P3E
 NFoYzFPbtV2fGZUO8rTbp2WXLu+kjAZNR5zVbHTqI1svpNZx+Mj15O79baLzgbwrKrDi
 I6JxYDWY9NWSwSSnSnrb00BRYbJCZp8UyrTV0LiEjLS23RrutrCgyN3F3VduFMR0mHMo
 xTbhSkk3hPuftPzo2wqtYNPxuXrpzCyToyYvqu2XfjQzGQKM4zJZZln95l7F6PQAAn0a
 UO3g==
X-Gm-Message-State: AOJu0YwhSs8xvJIUEDwyvpXyl1uoyJRiwQkXO3zbPcKtMrsYdXan+Ka/
 YsXTi3vzFBu4UCBoaksjcCKthwAmW4MoqSBkB2+OH29P6139qTolfqxK6XtBC/Xnsaw9PnMUfpX
 O+BOvqBx5tK3xBZ0=
X-Received: by 2002:a05:6214:d0e:b0:668:e12a:1d1c with SMTP id
 14-20020a0562140d0e00b00668e12a1d1cmr9712327qvh.3.1698072821110; 
 Mon, 23 Oct 2023 07:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5SlPV+LZBbPTzaqDjknP4mEViINFtjdSo/0szeTx62oUyFVnwnIJvhfVRvs8frqdH6uRw6g==
X-Received: by 2002:a05:6214:d0e:b0:668:e12a:1d1c with SMTP id
 14-20020a0562140d0e00b00668e12a1d1cmr9712315qvh.3.1698072820741; 
 Mon, 23 Oct 2023 07:53:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d7-20020a05620a166700b0077402573fb4sm2750586qko.124.2023.10.23.07.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 07:53:40 -0700 (PDT)
Date: Mon, 23 Oct 2023 10:53:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH RFC 4/7] migration: Drop MultiFDSendParams.quit and
 cleanup error paths
Message-ID: <ZTaI8vJpGeOQSfZH@x1n>
References: <20231022201211.452861-1-peterx@redhat.com>
 <20231022201211.452861-5-peterx@redhat.com>
 <87jzrdz9gr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzrdz9gr.fsf@suse.de>
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

Fabiano,

On Mon, Oct 23, 2023 at 11:42:28AM -0300, Fabiano Rosas wrote:
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 33fb21d0e4..9d458914a9 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -411,10 +411,6 @@ static int multifd_send_pages(QEMUFile *f)
> >      MultiFDSendParams *p = NULL; /* make happy gcc */
> >      MultiFDPages_t *pages = multifd_send_state->pages;
> >  
> > -    if (qatomic_read(&multifd_send_state->exiting)) {
> > -        return -1;
> > -    }
> > -
> 
> I'd keep this. This function can be called from outside of multifd code
> so the channels could be completely gone already.

I can definitely add it back; nothing hurts.  But I want to make sure I
didn't miss some point.

Do you have a specific path that could trigger what you said?

-- 
Peter Xu


