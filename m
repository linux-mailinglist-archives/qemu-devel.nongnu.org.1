Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 840877D375F
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quuXu-0004W6-Eb; Mon, 23 Oct 2023 09:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1quuXY-0004UZ-Qh
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1quuXS-0006kK-Rw
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698066009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dbG3C+KcYEOZMy0a+ntk6jmiiuQX3K4Q76XSP77dn/s=;
 b=BtIz1NV9gVWOt5n37IHO1IfPUMgpocKJU6W1RYDKeNYj36V2Uh62U8Ll3erGRtkbOOjlWY
 JvUIgF8zr2Zf39r38tAehkR9VwRr33YRvufU0+jQz3ByVr4KNJSY3ZCK2+NU5n5qBjcEnA
 oS8RqDTDrEkJUthRfz1DLSsnxSNdLVY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-E1l3X6wCOom6l3z3JegOsA-1; Mon, 23 Oct 2023 09:00:05 -0400
X-MC-Unique: E1l3X6wCOom6l3z3JegOsA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAEFC1859168;
 Mon, 23 Oct 2023 13:00:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05DBC111D794;
 Mon, 23 Oct 2023 12:59:58 +0000 (UTC)
Date: Mon, 23 Oct 2023 14:59:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 5/9] mirror: implement mirror_change method
Message-ID: <ZTZuTRw/+EYY0Nc+@redhat.com>
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <20231013092143.365296-6-f.ebner@proxmox.com>
 <ZTAO+TJuztCHDsUW@redhat.com>
 <92c65eb0-a069-48ea-9cbb-f8dd27b1f632@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92c65eb0-a069-48ea-9cbb-f8dd27b1f632@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 23.10.2023 um 13:37 hat Fiona Ebner geschrieben:
> Am 18.10.23 um 18:59 schrieb Kevin Wolf:
> > Am 13.10.2023 um 11:21 hat Fiona Ebner geschrieben:
> >> which allows switching the @copy-mode from 'background' to
> >> 'write-blocking'.
> >>
> >> This is useful for management applications, so they can start out in
> >> background mode to avoid limiting guest write speed and switch to
> >> active mode when certain criteria are fulfilled.
> >>
> >> In presence of an iothread, the copy_mode member is now shared between
> >> the iothread and the main thread, so turn accesses to it atomic.
> >>
> >> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> >> ---
> >>
> >> Changes in v3:
> >>     * turn accesses to copy_mode atomic and...
> >>     * ...slightly adapt error handling in mirror_change as a
> >>       consequence
> > 
> > It would be good to have a comment at the field declaration that it's
> > meant to be accessed with atomics.
> > 
> > As we don't have further synchonisation, is the idea that during the
> > switchover it basically doesn't matter if we read the old or the new
> > value?
> > 
> > After reading the whole patch, it seems that the field is only ever
> > written under the BQL, while iothreads only read it, and only once per
> > request (after the previous patch). This is why no further
> > synchonisation is needed. If other threads could write it, too,
> > mirror_change() would probably have to be more careful. As the code
> > depends on this, adding that to the comment would be useful, too.
> > 
> 
> Will do in v4.
> 
> >>  block/mirror.c       | 33 ++++++++++++++++++++++++++++++---
> >>  qapi/block-core.json | 13 ++++++++++++-
> >>  2 files changed, 42 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/block/mirror.c b/block/mirror.c
> >> index 8992c09172..889cce5414 100644
> >> --- a/block/mirror.c
> >> +++ b/block/mirror.c
> >> @@ -1075,7 +1075,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
> >>                   */
> >>                  job_transition_to_ready(&s->common.job);
> >>              }
> >> -            if (s->copy_mode != MIRROR_COPY_MODE_BACKGROUND) {
> >> +            if (qatomic_read(&s->copy_mode) != MIRROR_COPY_MODE_BACKGROUND) {
> >>                  s->actively_synced = true;
> >>              }
> > 
> > What resets s->actively_synced when we switch away from active mode?
> > 
> >>  
> >> @@ -1246,6 +1246,32 @@ static bool commit_active_cancel(Job *job, bool force)
> >>      return force || !job_is_ready(job);
> >>  }
> >>  
> >> +static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
> >> +                          Error **errp)
> >> +{
> >> +    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
> >> +    BlockJobChangeOptionsMirror *change_opts = &opts->u.mirror;
> >> +    MirrorCopyMode current;
> > 
> > This is GLOBAL_STATE_CODE(), right? Let's be explicit about it.
> > 
> 
> Maybe it wouldn't need to be if we also set actively_synced to false in
> bdrv_mirror_top_do_write() if/when setting the bitmap. Thinking about
> it, that change shouldn't hurt in any case. But sure, I'll add the
> GLOBAL_STATE_CODE annotation here. If ever required not to be
> GLOBAL_STATE_CODE code, it can still be adapted later.

Maybe we'll want to change it later so that we have some kind of
automatic switch in the job coroutine, then it might not be
GLOBAL_STATE_CODE() any more. For now, that's not a concern and it makes
reasoning about the rest of the function easier.

> >> +
> >> +    if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
> >> +        return;
> >> +    }
> >> +
> >> +    if (change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
> >> +        error_setg(errp, "Change to copy mode '%s' is not implemented",
> >> +                   MirrorCopyMode_str(change_opts->copy_mode));
> >> +        return;
> >> +    }
> > 
> > Ah, ok, we don't even allow the switch I was wondering about above. What
> > would be needed, apart from removing this check, to make it work?
> > 
> 
> Of course, setting actively_synced to false, as you pointed out above.
> But I think it would also require more synchronization, because I think
> otherwise the iothread could still read the old value of copy_mode (as
> MIRROR_COPY_MODE_WRITE_BLOCKING) right afterwards and might set
> actively_synced to true again. Do you want me to think it through in
> detail and allow the change in the other direction too? I guess that
> would also require using the job mutex instead of atomics. Or should we
> wait until somebody actually requires that?

I won't stop you if you want to implement it, it's an obvious feature to
add and I like symmetry. But if nobody has a use for it, there is no
reason to make your life harder. I was mostly just curious if you're
already aware of any challenges in the other direction that made you
tackle a more limited problem for now.

> >> +    current = qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
> >> +                              change_opts->copy_mode);
> >> +    if (current != MIRROR_COPY_MODE_BACKGROUND) {
> >> +        error_setg(errp, "Expected current copy mode '%s', got '%s'",
> >> +                   MirrorCopyMode_str(MIRROR_COPY_MODE_BACKGROUND),
> >> +                   MirrorCopyMode_str(current));
> >> +    }
> > 
> > The error path is strange. We return an error, but the new mode is still
> > set. On the other hand, this is probably also the old mode unless
> > someone added a new value to the enum, so it didn't actually change. And
> > because this function is the only place that changes copy_mode and we're
> > holding the BQL, the case can't even happen and this could be an
> > assertion.
> > 
> 
> AFAIU and testing seem to confirm this, the new mode is only set when
> the current mode is MIRROR_COPY_MODE_BACKGROUND. The error is only set
> when the current mode is not MIRROR_COPY_MODE_BACKGROUND and thus when
> the mode wasn't changed.

Yes, the new mode is only set when it was MIRROR_COPY_MODE_BACKGROUND,
that's the meaning of cmpxchg.

And now that I checked the return value of qatomic_cmpxchg(), it's not
the actual value, but it returns the second parameter (the expected old
value). As this is a constant in our call, that's what we'll always get
back. So the whole check is pointless, even as an assertion. It's
trivially true, and I expect it's even obvious enough for the compiler
that it might just optimise it away.

Just qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
change_opts->copy_mode); without using the (constant) result should be
enough.

> Adding a new copy mode shouldn't cause issues either? It's just not
> going to be supported to change away from that mode (or to that mode,
> because of the change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING
> check above) without adapting the code first.

The checks above won't prevent NEW_MODE -> WRITE_BLOCKING. Of course,
the cmpxchg() won't actually do anything as long as we still have
BACKGROUND there as the expected old value. So in this case, QMP would
probably return success, but we would stay in NEW_MODE.

That's different from what I thought (I didn't really realise that we
have a cmpxchg here and not just a xchg), but also not entirely right.

Of course, all of this is hypothetical. I'm not aware of any desire to
add a new copy mode.

> Of course, if we want to allow switching from active to background mode,
> the function needs to be adapted too.
> 
> I wanted to make it more future-proof for the case where it might not be
> the only place changing the value and based it on what Vladimir
> suggested in the review of v2:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg03552.html

As long as all of these places are GLOBAL_STATE_CODE(), we should be
fine. If we get iothread code that changes it, too, I think your code
becomes racy because the value could be changed by the iothread between
the first check if we already have the new value and the actual change.

Kevin


