Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C941D8D6628
	for <lists+qemu-devel@lfdr.de>; Fri, 31 May 2024 17:58:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4cL-0007d8-Ug; Fri, 31 May 2024 11:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sD4cK-0007cq-6P
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sD4cI-0004YR-4Z
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717170987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LsR7lrVGg4/oAZ5dt2/U10kWWj/pyolztSxJvWsR1OI=;
 b=Y7KSNQNGk7U8JixQY5OKG+Velkbfzg4vpnFtX571KyDlrwE6lQ6VO+9BncfdXVTGLRnTu4
 aAEi+bzcUj2FT5bRxJzSE01Pww2kZxfdPo2uteMJRMICuJkJkugNP/eIqqwZ4elYvv+hmk
 kuSJmAeypAVNcGNIsTR1QKVy0bbRxlo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-bot-u_z0MbGUqkhRBqim-Q-1; Fri, 31 May 2024 11:56:25 -0400
X-MC-Unique: bot-u_z0MbGUqkhRBqim-Q-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6f8e6666396so74489a34.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 08:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717170985; x=1717775785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsR7lrVGg4/oAZ5dt2/U10kWWj/pyolztSxJvWsR1OI=;
 b=Vxbnx9FNclZjwOQqAywcbSVVrdXu4TA6dnFXoIRekrWc4f0dv5eUCLdH8qj9vLRqUV
 GyY9P5PVq3kKhEsyjVnITgvu3GYlEhHtrfl0LA+Pe80SpxU9qFZROeSMu3DlNsrT9xzs
 tyIn2G0iOZJRYwQwR3olNACl7tX2rsjkOza3OK5eIY7mNEwdxYjrWrSTt1Xemu9lmd05
 oErHdQv1lBr6zXHUV8FFkMQrUvrMP+TeNlM6rq5g/L/1UfgCy8mFTujrIE+K7YrWrBRY
 wksuOM1m5eZtez0PGsgVOv9xEXgCa/NmYgBUZZ+ebXdsOmCzGdzvcrzK9rXuP4fZXXza
 u9ow==
X-Gm-Message-State: AOJu0YzHUo/yrZRGKPBQDZhcG7VYUEAA0Lgi6fMMho36/gIPJzUBLead
 I4W8G092F0JtRZApZXODzUO3jgnxQAeVj+gvoQoLvSjqdthEz7RpjlChrKVPr1uQXKSaUTgyZWs
 ovkyv5+MB2gnzcr44AgQZoaQltxFmqEP9yDFcvHzitUYSyxM4sjLt
X-Received: by 2002:a05:6830:451d:b0:6f9:116f:af04 with SMTP id
 46e09a7af769-6f911f23166mr2409213a34.1.1717170984443; 
 Fri, 31 May 2024 08:56:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEftxfY9WK/PV1YlL2A2BWVjmQNSnJ0+V3C+NQwEc5G7woAgs4+RP/L8I0NHd/kjHUor1NQLQ==
X-Received: by 2002:a05:6830:451d:b0:6f9:116f:af04 with SMTP id
 46e09a7af769-6f911f23166mr2409188a34.1.1717170983824; 
 Fri, 31 May 2024 08:56:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff23e0e48sm9157011cf.42.2024.05.31.08.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 08:56:22 -0700 (PDT)
Date: Fri, 31 May 2024 11:56:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 06/18] monitor: Stop removing non-duplicated fds
Message-ID: <ZlnzJIuUPbN8zQR4@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-7-farosas@suse.de> <ZljqGitCeG9-Fi9l@x1n>
 <87o78mknpb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o78mknpb.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Fri, May 31, 2024 at 12:25:52PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, May 23, 2024 at 04:05:36PM -0300, Fabiano Rosas wrote:
> >> We've been up until now cleaning up any file descriptors that have
> >> been passed into QEMU and never duplicated[1,2]. A file descriptor
> >> without duplicates indicates that no part of QEMU has made use of
> >> it. This approach is starting to show some cracks now that we're
> >> starting to consume fds from the migration code:
> >> 
> >> - Doing cleanup every time the last monitor connection closes works to
> >>   reap unused fds, but also has the side effect of forcing the
> >>   management layer to pass the file descriptors again in case of a
> >>   disconnect/re-connect, if that happened to be the only monitor
> >>   connection.
> >> 
> >>   Another side effect is that removing an fd with qmp_remove_fd() is
> >>   effectively delayed until the last monitor connection closes.
> >> 
> >>   The reliance on mon_refcount is also problematic because it's racy.
> >> 
> >> - Checking runstate_is_running() skips the cleanup unless the VM is
> >>   running and avoids premature cleanup of the fds, but also has the
> >>   side effect of blocking the legitimate removal of an fd via
> >>   qmp_remove_fd() if the VM happens to be in another state.
> >> 
> >>   This affects qmp_remove_fd() and qmp_query_fdsets() in particular
> >>   because requesting a removal at a bad time (guest stopped) might
> >>   cause an fd to never be removed, or to be removed at a much later
> >>   point in time, causing the query command to continue showing the
> >>   supposedly removed fd/fdset.
> >> 
> >> Note that file descriptors that *have* been duplicated are owned by
> >> the code that uses them and will be removed after qemu_close() is
> >> called. Therefore we've decided that the best course of action to
> >> avoid the undesired side-effects is to stop managing non-duplicated
> >> file descriptors.
> >> 
> >> 1- efb87c1697 ("monitor: Clean up fd sets on monitor disconnect")
> >> 2- ebe52b592d ("monitor: Prevent removing fd from set during init")
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  monitor/fds.c              | 15 ++++++++-------
> >>  monitor/hmp.c              |  2 --
> >>  monitor/monitor-internal.h |  1 -
> >>  monitor/qmp.c              |  2 --
> >>  4 files changed, 8 insertions(+), 12 deletions(-)
> >> 
> >> diff --git a/monitor/fds.c b/monitor/fds.c
> >> index 101e21720d..f7b98814fa 100644
> >> --- a/monitor/fds.c
> >> +++ b/monitor/fds.c
> >> @@ -169,6 +169,11 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> >>  
> >>  static void monitor_fdset_free(MonFdset *mon_fdset)
> >>  {
> >> +    /*
> >> +     * Only remove an empty fdset. The fds are owned by the user and
> >> +     * should have been removed with qmp_remove_fd(). The dup_fds are
> >> +     * owned by QEMU and should have been removed with qemu_close().
> >> +     */
> >>      if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
> >>          QLIST_REMOVE(mon_fdset, next);
> >>          g_free(mon_fdset);
> >> @@ -189,9 +194,7 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
> >>      MonFdsetFd *mon_fdset_fd_next;
> >>  
> >>      QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
> >> -        if ((mon_fdset_fd->removed ||
> >> -                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
> >> -                runstate_is_running()) {
> >> +        if (mon_fdset_fd->removed) {
> >
> > I don't know the code well, but I like it.
> >
> >>              monitor_fdset_fd_free(mon_fdset_fd);
> >>          }
> >>      }
> >> @@ -206,7 +209,7 @@ void monitor_fdsets_cleanup(void)
> >>  
> >>      QEMU_LOCK_GUARD(&mon_fdsets_lock);
> >>      QLIST_FOREACH_SAFE(mon_fdset, &mon_fdsets, next, mon_fdset_next) {
> >> -        monitor_fdset_cleanup(mon_fdset);
> >> +        monitor_fdset_free(mon_fdset);
> >>      }
> >>  }
> >>  
> >> @@ -479,9 +482,7 @@ void monitor_fdset_dup_fd_remove(int dup_fd)
> >>              if (mon_fdset_fd_dup->fd == dup_fd) {
> >>                  QLIST_REMOVE(mon_fdset_fd_dup, next);
> >>                  g_free(mon_fdset_fd_dup);
> >> -                if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
> >> -                    monitor_fdset_cleanup(mon_fdset);
> >> -                }
> >> +                monitor_fdset_free(mon_fdset);
> >
> > This and above changes are not crystal clear to me where the _cleanup()
> > does extra check "removed" and clean those fds.
> >
> > I think it'll make it easier for me to understand if this one and the next
> > are squashed together.  But maybe it's simply because I didn't fully
> > understand.
> 
> monitor_fdsets_cleanup() was doing three things previously:
> 
> 1- Remove the removed=true fds. This is weird, but ok.
> 
> 2- Remove fds from an fdset that has an empty dup_fds list, but only if
> the guest is not running and the monitor is closed. This is problematic.
> 
> 3- Remove/free fdsets that have become empty due to the above
> removals. This is ok.
> 
> This patch covers (2), because that is the only change that has a
> complex reasoning behind it and we need to document that without
> conflating it with the rest of the changes.
> 
> Since (3) is still a reasonable thing to do, this patch merely keeps it
> around, but using the helpers introduced in the previous patch.
> 
> The next patch removed the need for (1), making the removal immediate
> instead of delayed. It has it's own much less complex reasoning, which
> is: "we don't need to wait to remove the fd".
> 
> I hope this clarifies a bit. I would prefer if we kept this and the next
> patch separate to avoid having a single patch that does too many
> things. I hope to be as explicit as possible with the reason behind
> these changes to avoid putting future people in the situation that we
> are in now, i.e. having to guess at the reasons behind this code.
> 
> If you still think we should squash or if you have more questions, let
> me know.

Thanks.  Mind adding something into the commit message for monitor newbies
(like myself)?

I hope whoever more familiar with monitor can look, but otherwise let's see
what will break and then we have someone to discuss with.

For what it worth, I still want to ack this:

Reviewed-by: Peter Xu <peterx@redhat.com>

> 
> >>                  return;
> >>              }
> >>          }
> >> diff --git a/monitor/hmp.c b/monitor/hmp.c
> >> index 69c1b7e98a..460e8832f6 100644
> >> --- a/monitor/hmp.c
> >> +++ b/monitor/hmp.c
> >> @@ -1437,11 +1437,9 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
> >>              monitor_resume(mon);
> >>          }
> >>          qemu_mutex_unlock(&mon->mon_lock);
> >> -        mon_refcount++;
> >>          break;
> >>  
> >>      case CHR_EVENT_CLOSED:
> >> -        mon_refcount--;
> >>          monitor_fdsets_cleanup();
> >>          break;
> >>  
> >> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> >> index 252de85681..cb628f681d 100644
> >> --- a/monitor/monitor-internal.h
> >> +++ b/monitor/monitor-internal.h
> >> @@ -168,7 +168,6 @@ extern bool qmp_dispatcher_co_shutdown;
> >>  extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
> >>  extern QemuMutex monitor_lock;
> >>  extern MonitorList mon_list;
> >> -extern int mon_refcount;
> >>  
> >>  extern HMPCommand hmp_cmds[];
> >>  
> >> diff --git a/monitor/qmp.c b/monitor/qmp.c
> >> index a239945e8d..5e538f34c0 100644
> >> --- a/monitor/qmp.c
> >> +++ b/monitor/qmp.c
> >> @@ -466,7 +466,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
> >>          data = qmp_greeting(mon);
> >>          qmp_send_response(mon, data);
> >>          qobject_unref(data);
> >> -        mon_refcount++;
> >>          break;
> >>      case CHR_EVENT_CLOSED:
> >>          /*
> >> @@ -479,7 +478,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
> >>          json_message_parser_destroy(&mon->parser);
> >>          json_message_parser_init(&mon->parser, handle_qmp_command,
> >>                                   mon, NULL);
> >> -        mon_refcount--;
> >>          monitor_fdsets_cleanup();
> >>          break;
> >>      case CHR_EVENT_BREAK:
> >
> > I like this too when mon_refcount can be dropped.  It turns out I like this
> > patch and the next a lot, and I hope nothing will break.
> >
> > Aside, you seem to have forgot removal of the "int mon_refcount" in
> > monitor.c.
> 
> Yes, I'll fix that. Thanks.
> 

-- 
Peter Xu


