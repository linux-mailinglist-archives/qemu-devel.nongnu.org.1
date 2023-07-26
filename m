Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1F7763E73
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:29:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOhXE-0003F1-NJ; Wed, 26 Jul 2023 12:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOhV0-0002vH-Ng
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOhUz-00069g-0z
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690389388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WT1oR0Gf3AtzFnpHFVRYuuJdZX/wyTwzZPr0TAsJfKM=;
 b=M08JMcKkOkU+XXKoCeTXia8EQroRdHwD601jMlrx8Yhm4W5KG9RqPG170OH2v7cKphIRuX
 rq7seuXnhKF6nAALPm/gLPPJHrwXmWS83pA4wKMHmz6tSqBLtF32vDCDIgnADJUYLC+gN+
 /3x5rKU+O88/NPaWxuWL/7ac/x4LiW0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-HyP8Th9QNy2VEZZagXugSA-1; Wed, 26 Jul 2023 12:36:26 -0400
X-MC-Unique: HyP8Th9QNy2VEZZagXugSA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-767b80384a3so284685a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 09:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690389386; x=1690994186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WT1oR0Gf3AtzFnpHFVRYuuJdZX/wyTwzZPr0TAsJfKM=;
 b=gyOISmQCtRGyzKqu8Cpded1UBQit5BklUlRpUmpXOq+FagTEXjxxQc3LihHNqPUwnz
 KB/uSF1pckECbc8YWeDuRs3LvqDkOeUfAVJrx9xiJAByMor1EpTQoVt7YbEBsbyaFLeR
 3NP0q+rSCJcthFeWdzayeUAMSk4AV4ev1+pgnWzo9NTRP9i4KsOeL7m75bznLlb2RktD
 vda5phqNtrLi0GJCW6dysAOaMYHxTV+yBjGhw+ElVUsVXegqPc7Pd03WGJJv4s84TWRY
 3zhAe4ANRxOg3NTWe0vHqZPlXtoRUD3ny2nIBFpHR50fFdBPok7e/I8R84PGKX45A8Vn
 tggQ==
X-Gm-Message-State: ABy/qLayT8zv/pJC5cGR/06oYYrr+Zs0b5zyD6qkpi+FVpYb4PHTZc2A
 torE6ZoXi/eqOJBN18Z8TbpLsRoRZz9gxAm4T8KLO6V8C5GZ5oCBCnsVvXoNSJP/XVBDG37z4Qi
 SJ5vVBfRtF6N7S00=
X-Received: by 2002:a05:620a:31a1:b0:75b:23a1:69ee with SMTP id
 bi33-20020a05620a31a100b0075b23a169eemr2689188qkb.5.1690389386068; 
 Wed, 26 Jul 2023 09:36:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE83zC83sb2WZ93afomoGbPZitvMKM1UjcnhvVYw3+uBPoaM53v0dXpdeR2jWswoBtEygluMg==
X-Received: by 2002:a05:620a:31a1:b0:75b:23a1:69ee with SMTP id
 bi33-20020a05620a31a100b0075b23a169eemr2689169qkb.5.1690389385779; 
 Wed, 26 Jul 2023 09:36:25 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 hf1-20020a05622a608100b003ef2db16e72sm4847415qtb.94.2023.07.26.09.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 09:36:25 -0700 (PDT)
Date: Wed, 26 Jul 2023 12:36:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2 0/7] migration: Better error handling in return path
 thread
Message-ID: <ZMFLh7I62ckbDHaF@x1n>
References: <20230705163502.331007-1-peterx@redhat.com>
 <87351dz9fi.fsf@suse.de> <87r0ovonmt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0ovonmt.fsf@suse.de>
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

Hi, Fabiano,

Sorry to be late on responding.

On Tue, Jul 25, 2023 at 03:24:26PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> v2:
> >> - Patch "migration: Provide explicit error message for file shutdowns"
> >>   - Touched up qapi doc [Fabiano]
> >>   - Added Bugzilla link to commit which I didn't even notice that I was
> >>     fixing a bug.. but rightfully pointed out by Laszlo.
> >>   - Moved it to the 1st patch because it fixes a bug, please consider
> >>     review and merge it earlier.
> >>
> >> This is a small series that reworks error handling of postcopy return path
> >> threads.
> >>
> >> We used to contain a bunch of error_report(), converting them into
> >> error_setg() properly and deliver any of those errors to migration generic
> >> error reports (via migrate_set_error()).  Then these errors can also be
> >> observed in query-migrate after postcopy is paused.
> >>
> >> Dropped the return-path specific error reporting: mark_source_rp_bad(),
> >> because it's a duplication if we can always use migrate_set_error().
> >>
> >> Please have a look, thanks.
> >>
> >> Peter Xu (7):
> >>   migration: Display error in query-migrate irrelevant of status
> >>   migration: Let migrate_set_error() take ownership
> >>   migration: Introduce migrate_has_error()
> >>   migration: Refactor error handling in source return path
> >>   migration: Deliver return path file error to migrate state too
> >>   qemufile: Always return a verbose error
> >>   migration: Provide explicit error message for file shutdowns
> >>
> >>  qapi/migration.json      |   5 +-
> >>  migration/migration.h    |   8 +-
> >>  migration/ram.h          |   5 +-
> >>  migration/channel.c      |   1 -
> >>  migration/migration.c    | 168 +++++++++++++++++++++++----------------
> >>  migration/multifd.c      |  10 +--
> >>  migration/postcopy-ram.c |   1 -
> >>  migration/qemu-file.c    |  20 ++++-
> >>  migration/ram.c          |  42 +++++-----
> >>  migration/trace-events   |   2 +-
> >>  10 files changed, 149 insertions(+), 113 deletions(-)
> >
> > Hi Peter,
> >
> > Were you aiming at solving any specific bug with this series?

Nop.  I simply noticed that the error in return path cannot be proxied to
migration object and thought maybe we should do that.

Thanks for looing into this problem.

> > I'm seeing
> > a bug on master (361d5397355) with the
> > /x86_64/migration/postcopy/preempt/recovery/plain test around the areas
> > that this series touches.
> >
> > It happens very rarely and I'm still investigating, but in case you have
> > any thoughts:
> >
> > ====
> > It seems there's a race condition between postcopy resume and the return
> > path cleanup.
> >
> > It is possible for open_return_path_on_source() to setup the new
> > QEMUFile *before* the cleanup path at source_return_path_thread() has
> > had a chance to run, so we end up calling migration_release_dst_files()
> > on the new file and ms->rp_state.from_dst_file gets set to NULL again,
> > leading to a SIGSEGV at qemu_file_get_error(rp) due to rp being NULL.
> 
> I did some more digging and this is indeed what happens. When we pause
> on the incoming side, the to_src_file is closed and the source return
> path sees an error (EBADFD) which leads to the cleanup (from_dst_file =
> NULL). This happens independently and without any synchronization with a
> potential concurrent resume operation.
> 
> Is there a reason for not closing the return path thread and starting a
> new one for resume?

Not anything special.  When I initially worked on that (quite a few years
ago) I thought it would be the simplest we keep hold as much things as
possible, including the threads.  But maybe it's not too hard either to
just reinitiate the thread when resume indeed.

> The from_dst_file is the only thing being changed
> anyway. It would allow us to remove the retry logic along with the
> problematic cleanup path and not need another synchronization point
> between qmp_migrate() and the return path.

I'm fine if you want to remove the return path thread when a pause happens,
as long as we can cleanly do that; if you already drafted something and
looks all good from your side, happy to read it.  We may somewhere need
another call to await_return_path_close_on_source() when pause from
migration thread.

The other way is the main thread can stupidly wait for the two files to be
released, namely, from_dst_file and postcopy_qemufile_src.

> 
> Here's the race (important bit is open_return_path happening before
> migration_release_dst_files):
> 
> migration                 | qmp                         | return path
> --------------------------+-----------------------------+---------------------------------
>                             qmp_migrate_pause()
>                              shutdown(ms->to_dst_file)
>                               f->last_error = -EIO
> migrate_detect_error()
>  postcopy_pause()
>   set_state(PAUSED)
>   wait(postcopy_pause_sem)
>                             qmp_migrate(resume)
>                             migrate_fd_connect()
>                              resume = state == PAUSED
>                              open_return_path <-- TOO SOON!
>                              set_state(RECOVER)
>                              post(postcopy_pause_sem)
>                                                         (incoming closes to_src_file)
>                                                         res = qemu_file_get_error(rp)
>                                                         migration_release_dst_files()
>                                                         ms->rp_state.from_dst_file = NULL
>   post(postcopy_pause_rp_sem)
>                                                         postcopy_pause_return_path_thread()
>                                                           wait(postcopy_pause_rp_sem)
>                                                         rp = ms->rp_state.from_dst_file
>                                                         goto retry
>                                                         qemu_file_get_error(rp)
>                                                         SIGSEGV
> -------------------------------------------------------------------------------------------
> 

Thanks,

-- 
Peter Xu


