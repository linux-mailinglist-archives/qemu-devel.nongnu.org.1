Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C3AB987A6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 09:14:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jgb-0002af-F3; Wed, 24 Sep 2025 03:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1JgY-0002aF-Gg
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1JgU-0002pD-8N
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758697978;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J96dk8MZlO7jN62tBhnIhpDQJp2v/fpYdm1a3q28sPE=;
 b=CnC9ac3kZTJZUj5knBGYTPn3aSJs9HP+DgHNVF4NIsEtV1fVDT3zbe70FgSEj+Uy3/y/zi
 BoBtVamVd0Ron/ShePQ+sogXzuhbGaZUFNpL0kaA+nnndIVDXfz+UfEdHWDy91v0O0kRYu
 xvVe6RrjLMKqbRYnHBQKw5yuikNvv3I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-1dweFMOEPHGe2Bq8uprG3w-1; Wed,
 24 Sep 2025 03:12:54 -0400
X-MC-Unique: 1dweFMOEPHGe2Bq8uprG3w-1
X-Mimecast-MFC-AGG-ID: 1dweFMOEPHGe2Bq8uprG3w_1758697972
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A328C1800452; Wed, 24 Sep 2025 07:12:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AFC21800446; Wed, 24 Sep 2025 07:12:45 +0000 (UTC)
Date: Wed, 24 Sep 2025 08:12:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 08/20] log: avoid repeated prefix on incremental
 qemu_log calls
Message-ID: <aNOZ6tSuxFolxs3N@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-9-berrange@redhat.com>
 <87plbh8cpx.fsf@pond.sub.org> <aNK0-q58zw_KygMU@redhat.com>
 <87h5ws5nxs.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5ws5nxs.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 24, 2025 at 09:06:55AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Sep 23, 2025 at 04:28:42PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > Some code makes multiple qemu_log calls to incrementally emit
> >> > a single message. Currently timestamps get prepended to all
> >> > qemu_log calls, even those continuing a previous incomplete
> >> > message.
> >> >
> >> > This changes the qemu_log so it skips adding a new line prefix,
> >> > if the previous qemu_log call did NOT end with a newline.
> >> >
> >> > Reported-by: Richard Henderson <richard.henderson@linaro.org>
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> 
> >> This patch has kept nagging me in the back of my brain.  So I'm back for
> >> a second look.
> >> 
> >> > ---
> >> >  util/log.c | 9 ++++++++-
> >> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/util/log.c b/util/log.c
> >> > index abdcb6b311..2642a55c59 100644
> >> > --- a/util/log.c
> >> > +++ b/util/log.c
> >> > @@ -143,6 +143,12 @@ void qemu_log_unlock(FILE *logfile)
> >> >      }
> >> >  }
> >> >  
> >> > +/*
> >> > + * 'true' if the previous log message lacked a trailing '\n',
> >> > + * and thus the subsequent call must skip any prefix
> >> > + */
> >> > +static __thread bool incomplete;
> >> > +
> >> >  void qemu_log(const char *fmt, ...)
> >> >  {
> >> >      FILE *f;
> >> > @@ -154,7 +160,7 @@ void qemu_log(const char *fmt, ...)
> >> >       * was emitted if we are delayed acquiring the
> >> >       * mutex
> >> >       */
> >> > -    if (message_with_timestamp) {
> >> > +    if (message_with_timestamp && !incomplete) {
> >> >          g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> >> >          timestr = g_date_time_format_iso8601(dt);
> >> >      }
> >> > @@ -170,6 +176,7 @@ void qemu_log(const char *fmt, ...)
> >>        f = qemu_log_trylock();
> >>        if (f) {
> >>            va_list ap;
> >> 
> >>            if (timestr) {
> >>                fprintf(f, "%s ", timestr);
> >>            }
> >> 
> >> >          va_start(ap, fmt);
> >> >          vfprintf(f, fmt, ap);
> >> >          va_end(ap);
> >> > +        incomplete = fmt[strlen(fmt) - 1] != '\n';
> >> >          qemu_log_unlock(f);
> >> >      }
> >> >  }
> >> 
> >> Two cases:
> >> 
> >> (A) Single log
> >> 
> >>     qemu_log_trylock() returns @global_file, and uses RCU to ensure it
> >>     remains valid until qemu_log_unlock().  I think.
> >> 
> >> (B) Log split per thread (-d tid)
> >> 
> >>     qemu_log_trylock() returns thread-local @thread_file.
> >> 
> >> In addition, qemu_log_trylock() locks the FILE it returns with
> >> flockfile(), so no other thread can write to it until qemu_log_unlock()
> >> unlocks it with funlockfile().  This ensures the entire output of in
> >> between stays together.
> >> 
> >> Let's see how this plays with @incomplete.
> >> 
> >> (B) Log split per thread (-d tid)
> >> 
> >>     @incomplete is thread-local.  It records wether the last qemu_log()
> >>     in this thread was an incomplete line.  If it was, the next
> >>     qemu_log() continues the line.  Unless something else wrote to
> >>     @thread_file in between, but that's not supposed to happen.  Good.
> >> 
> >> (A) Single log
> >> 
> >>     All thread log to the same FILE.  Consider:
> >> 
> >>     1. Thread 1 starts.  Its @incomplete is initialized to false.
> >> 
> >>     2. Thread 2 starts.  Its @incomplete is initialized to false.
> >> 
> >>     3. Thread 1 logs "abra".  Its @incomplete is set to true.
> >> 
> >>     4. Thread 2 logs "interrupt\n".  Its @incomplete remains false.
> >> 
> >>     5. Thread 2 logs "cadbra\n".  Its @incomplete goes back to false.
> >> 
> >>     Resulting log file contents:
> >> 
> >>         PREFIX "abra" PREFIX "interrupt\n"
> >>         "cadabra\n"
> >> 
> >>     Not good.
> >> 
> >> We could complicate this code further to mitigate.  For instance, we
> >> could use a thread-local @incomplete for (B), and a global one for (A).
> >> This ensures log lines start with PREFIX as they should, but does
> >> nothing to avoid mixing up line parts from different threads.  My
> >> example would then produce
> >> 
> >>         PREFIX "abrainterrupt\n"
> >>         PREFIX "cababra\n"
> >> 
> >> My take: "Doctor, it hurts when I do that!"  "Don't do that then."
> >> Logging incomplete lines with qemu_log() can hurt.  Don't do that then.
> >
> > I just took a look at linux-user/syscall.c as that is one place that
> > heavily uses qemu_log() for incomplete lines.
> >
> > What I didn't realize was that the expectation is to call
> > qemu_log_trylock() (which returns the "FILE *" target) and
> > then you can ignore the "FILE *" and just call qemu_log()
> > repeatedly, and finally call qemu_log_unlock(FILE *) when
> > done.
> >
> > https://gitlab.com/qemu-project/qemu/-/blob/master/linux-user/strace.c?ref_type=heads#L4396
> 
> I can see the qemu_log_trylock() / qemu_log_unlock() bracket.  But the
> code within doesn't work the way you describe: it uses fprintf(f, ...).
> If it did ignore @f and call qemu_log(), qemu_log() would
> qemu_log_trylock() again, taking the RCU read lock and the flockfile()
> lock on @f recursively.  Should work.


Only the fallback path (the 'else' branch) uses fprintf.

The main path is doing

 scnames[i].call(cpu_env, &scnames[i], arg1, arg2, arg3,
                                arg4, arg5, arg6);

which calls out to the other countless 'print_XXXX' methods,
one per syscall, which all use qemu_log().


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


