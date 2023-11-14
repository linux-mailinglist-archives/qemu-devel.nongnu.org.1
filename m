Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DD87EB588
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:29:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xDY-0000nu-LJ; Tue, 14 Nov 2023 12:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r2xDX-0000nb-6g
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:28:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r2xDV-0002O1-FY
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699982927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fd4euxKSdcFRmX3lUdN8u6zrBbeDkBHvnK92LLIiIMY=;
 b=Rhwr3qIX738QTXqwvaNZidN5BrUXdKsKGeHLw/MY6bKdwIacO6li7fsq3l1EbvyLP7qJpG
 ifaGYddhBzzFgXCpBCjVsxvUoQfj7ZT8s2f1eekYrBhnY5vEzvRdbFzIzl/tzrW6us/pc6
 BefDsmUe5jepVEglc9UTqnyTzTPpAPw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-DA6slJYRM_ObjHZXAtFK-g-1; Tue, 14 Nov 2023 12:28:46 -0500
X-MC-Unique: DA6slJYRM_ObjHZXAtFK-g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d3f71f49cso10509376d6.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 09:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699982926; x=1700587726;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fd4euxKSdcFRmX3lUdN8u6zrBbeDkBHvnK92LLIiIMY=;
 b=FxbCgsMze6fHVjWEF6YmluhF21Iq3Voz47rMT1oiYQ69hQ//iIUdpIq6RTGCuPpTcJ
 zXIPMfepZdqeiRVdViSdFMEZlkpDH7CQwaAzDTBP6cA2myD8+nzp9w+vd9DBBAZ6jjTH
 CkLwhiJzCYAmwLEIAnuQfqx5lb8dnc1N7BLnNALBExywW0f4AZO2W3HVD0eGGQjF6s6f
 XUKwPaVQy3UGmshsAk6wvam2e/ytB7NFjzXF8G7zPOhB2dDWcIeJ9UjwGQEknXDCDz+I
 WDf6yIJ5rbXWV3Dx20eicRNH2hc5c/amh3tf/aOXZNSB9zMffEc148iec5Fbj+ZRwCSJ
 ZDcQ==
X-Gm-Message-State: AOJu0Yx4TZRrYPQK/fYleF1PdYic3zrnOasJkMEokoq2qpyic10wNTfG
 iH4dYWyMvOc5jJEL9W7oIOl7eKMe1vUrH+vEcyq4zKJSE20j8CVDW9FnShV6vMqj4CmsOduhRbQ
 uJgKVWe0HkSm5Wao=
X-Received: by 2002:a0c:e80d:0:b0:66d:6111:5c5f with SMTP id
 y13-20020a0ce80d000000b0066d61115c5fmr2919633qvn.2.1699982925846; 
 Tue, 14 Nov 2023 09:28:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9qhIM6LC6tex3XxsmAVT4LCZ3vDDIdPa89Ma6kKOJTGNKRwbkpe9T5BizSsVuPKzPstLcOQ==
X-Received: by 2002:a0c:e80d:0:b0:66d:6111:5c5f with SMTP id
 y13-20020a0ce80d000000b0066d61115c5fmr2919618qvn.2.1699982925515; 
 Tue, 14 Nov 2023 09:28:45 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 bm38-20020a05620a19a600b0076d6a08ac98sm2798932qkb.76.2023.11.14.09.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 09:28:44 -0800 (PST)
Date: Tue, 14 Nov 2023 12:28:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/2] migration/multifd: Move semaphore release into
 main thread
Message-ID: <ZVOuO8jyqryoeQvV@x1n>
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-3-farosas@suse.de> <ZU0rY662a5C1mvyf@x1n>
 <87pm0hzucq.fsf@suse.de> <ZVJSx6FOg8WfSbrz@x1n>
 <877cml5ci8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cml5ci8.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Nov 13, 2023 at 10:50:39PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Nov 10, 2023 at 09:05:41AM -0300, Fabiano Rosas wrote:
> >
> > [...]
> >
> >> > Then assuming we have a clear model with all these threads issue fixed (no
> >> > matter whether we'd shrink 2N threads into N threads), then what we need to
> >> > do, IMHO, is making sure to join() all of them before destroying anything
> >> > (say, per-channel MultiFDSendParams).  Then when we destroy everything
> >> > safely, either mutex/sem/etc..  Because no one will race us anymore.
> >> 
> >> This doesn't address the race. There's a data dependency between the
> >> multifd channels and the migration thread around the channels_ready
> >> semaphore. So we cannot join the migration thread because it could be
> >> stuck waiting for the semaphore, which means we cannot join+cleanup the
> >> channel thread because the semaphore is still being used.
> >
> > I think this is the major part of confusion, on why this can happen.
> >
> > The problem is afaik multifd_save_cleanup() is only called by
> > migrate_fd_cleanup(), which is further only called in:
> >
> >   1) migrate_fd_cleanup_bh()
> >   2) migrate_fd_connect()
> >
> > For 1): it's only run when migration comletes/fails/etc. (in all cases,
> > right before it quits..) and then kicks off migrate_fd_cleanup_schedule().
> > So migration thread shouldn't be stuck, afaiu, or it won't be able to kick
> > that BH.
> >
> > For 2): it's called by the main thread, where migration thread should have
> > not yet been created.
> >
> > With that, I don't see how migrate_fd_cleanup() would need to worry about
> > migration thread
> >
> > Did I miss something?
> 
> There are two points:
> 
> 1) multifd_new_send_channel_async() doesn't set an Error. Even if
> multifd_channel_connect() fails, we'll still continue with
> migrate_fd_connect(). I don't see any code that looks at the migration
> error (s->error).
> 
> 2) the TLS handshake thread of one of the channels could simply not get
> any chance to run until something else fails and we reach
> multifd_save_cleanup() from the BH path.
> 
> This second point in particular is why I don't think simply joining the
> TLS thread will avoid the race. There's nothing linking the multifd
> channels together, we could have 7 of them operational and a 8th one
> still going through the TLS handshake.
> 
> That said, I'm not sure about the exact path we take to reach the bug
> situation. It's very hard to reproduce so I'm relying entirely on code
> inspection.

This whole patch, iiuc, was trying to move sem post, which will only kick
the migration thread at different places.  IMHO, the problem is if
multifd_save_cleanup() is only called in either migrate_fd_connect() or the
BH as discussed above, then it means migration thread is already gone!  I
don't see how moving that sem_post() would help in any form.  It means
whatever thread stuck as you said can still happen.

You're right that I think the thread is just fully out of control of
migration. Namely, anything we created with socket_send_channel_create().
Fundamentally, I think it's because qio_task_run_in_thread() doesn't
support that control, as creating its thread as DETACHED already, leaving
the rest to luck.

Can we provide our own threads for that, at least keep the threadID around,
then at cleanup paths we can shutdown() the IOChannels and join(), assuming
that the shutdown() will kick the thread out of any blocked IO?

-- 
Peter Xu


