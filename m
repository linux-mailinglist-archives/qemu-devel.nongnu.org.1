Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C547E1DFC
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:11:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwZ6-0006v7-Kh; Mon, 06 Nov 2023 05:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qzwZ4-0006uc-C9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:10:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qzwZ2-0002L1-8X
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699265434;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MokpWFlmV1Tn5A62l2zEJkfJh1k9MgusHtDfFxa+wXw=;
 b=Uofsutyb+fIsO/8dNNHOgZCItvUQ+oe6PGd2hemwx+p86Igb2RgrdunskwNMKGEFRBvCqA
 +wpUp8lSxyzQ/F9RwSprl3ZOHE8zIix8OXVhr2NpEuihwOeaqh4nF+TTt0huTGlrGqs8w8
 7PCzBS9f2O76DMIPfEuN1oXx1ij12YU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-OwXqxHH5OJaMk2ZGw7V_kg-1; Mon, 06 Nov 2023 05:10:29 -0500
X-MC-Unique: OwXqxHH5OJaMk2ZGw7V_kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFC25185A783;
 Mon,  6 Nov 2023 10:10:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F260492A;
 Mon,  6 Nov 2023 10:10:26 +0000 (UTC)
Date: Mon, 6 Nov 2023 10:10:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH] monitor: flush messages on abort
Message-ID: <ZUi7izJoVpU+iiuC@redhat.com>
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Nov 03, 2023 at 03:51:00PM -0400, Steven Sistare wrote:
> On 11/3/2023 1:33 PM, Daniel P. Berrangé wrote:
> > On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
> >> Buffered monitor output is lost when abort() is called.  The pattern
> >> error_report() followed by abort() occurs about 60 times, so valuable
> >> information is being lost when the abort is called in the context of a
> >> monitor command.
> > 
> > I'm curious, was there a particular abort() scenario that you hit ?
> 
> Yes, while tweaking the suspended state, and forgetting to add transitions:
> 
>         error_report("invalid runstate transition: '%s' -> '%s'",
>         abort();
> 
> But I have previously hit this for other errors.
> 
> > For some crude statistics:
> > 
> >   $ for i in abort return exit goto ; do echo -n "$i: " ; git grep --after 1 error_report | grep $i | wc -l ; done
> >   abort: 47
> >   return: 512
> >   exit: 458
> >   goto: 177
> > 
> > to me those numbers say that calling "abort()" after error_report
> > should be considered a bug, and we can blanket replace all the
> > abort() calls with exit(EXIT_FAILURE), and thus avoid the need to
> > special case flushing the monitor.
> 
> And presumably add an atexit handler to flush the monitor ala monitor_abort.
> AFAICT currently no destructor is called for the monitor at exit time.

The HMP monitor flushes at each newline,  and exit() will take care of
flushing stdout, so I don't think there's anything else needed.

> > Also I think there's a decent case to be made for error_report()
> > to call monitor_flush().
> 
> A good start, but that would not help for monitors with skip_flush=true, which 
> need to format the buffered string in a json response, which is the case I 
> tripped over.

'skip_flush' is only set to 'true' when using a QMP monitor and invoking
"hmp-monitor-command".

In such a case, the error message needs to be built into a JSON error
reply and sent over the socket. Your patch doesn't help this case
since you've just printed to stderr.  I don't think it is reasonable
to expect QMP monitors to send replies on SIG_ABRT anyway. So I don't
think the skip_flush=true scenario is a problem to be concerned with.

> >> To fix, install a SIGABRT handler to flush the monitor buffer to stderr.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  monitor/monitor.c | 38 ++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>
> >> diff --git a/monitor/monitor.c b/monitor/monitor.c
> >> index dc352f9..65dace0 100644
> >> --- a/monitor/monitor.c
> >> +++ b/monitor/monitor.c
> >> @@ -701,6 +701,43 @@ void monitor_cleanup(void)
> >>      }
> >>  }
> >>  
> >> +#ifdef CONFIG_LINUX
> >> +
> >> +static void monitor_abort(int signal, siginfo_t *info, void *c)
> >> +{
> >> +    Monitor *mon = monitor_cur();
> >> +
> >> +    if (!mon || qemu_mutex_trylock(&mon->mon_lock)) {
> >> +        return;
> >> +    }
> >> +
> >> +    if (mon->outbuf && mon->outbuf->len) {
> >> +        fputs("SIGABRT received: ", stderr);
> >> +        fputs(mon->outbuf->str, stderr);
> >> +        if (mon->outbuf->str[mon->outbuf->len - 1] != '\n') {
> >> +            fputc('\n', stderr);
> >> +        }
> >> +    }
> >> +
> >> +    qemu_mutex_unlock(&mon->mon_lock);
> > 
> > The SIGABRT handling does not only fire in response to abort()
> > calls, but also in response to bad memory scenarios, so we have
> > to be careful what we do in signal handlers.
> > 
> > In particular using mutexes in signal handlers is a big red
> > flag generally. Mutex APIs are not declare async signal
> > safe, so this code is technically a POSIX compliance
> > violation.
> 
> Righto.  I would need to mask all signals in the sigaction to be on the safe(r) side.

This is still doomed, because SIGABRT could fire while 'mon_lock' is
already held, and so this code would deadlock trying to acquire the
lock.

> > So I think we'd be safer just eliminating the explicit abort()
> > calls and adding monitor_flush call to error_report.
> 
> I like adding a handler because it is future proof.  No need to play whack-a-mole when
> developers re-introduce abort() calls in the future.  A minor benefit is I would not
> need ack's from 50 maintainers to change 50 call sites from abort to exit.

That's a bit of a crazy exaggeration. THe aborts() don't cover 50 different
subsystems, and we don't require explicit acks from every subsystem maintainer
for trivial cleanups like this.

> A slight risk of the exit solution is that something bad happened at the call site, so 
> qemu state can no longer be trusted.  Calling abort immediately may be safer than calling 
> exit which will call the existing atexit handlers and could have side effects.

If that was a real problem, then we already face it because we have
~500 places already calling exit() and only 50 calling abort().

> A third option is to define qemu_abort() which flushes the monitor, and replaces all abort
> calls.  That avoids async-signal-mutex hand wringing, but is still subject to whack-a-mole.
> 
> So: atexit, signal handler, or qemu_abort?  I will go with your preference.

Just replace abort -> exit.

I'm not seeing a need for an atexit handler on top.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


