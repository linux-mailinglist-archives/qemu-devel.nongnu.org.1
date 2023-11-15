Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 850E77EBEB9
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:42:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BTk-0000Pw-7Z; Wed, 15 Nov 2023 03:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3BTg-0000Pl-Fe
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:42:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3BTe-00062S-K7
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700037745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6pafuJ4+58baCKMCthYqE5MGa3ku79koEQ3Kw89Idg=;
 b=GPGdW60oUWIE1AIJIMN1go0BWG9/GHVmZsRX++ec/Ny3VnvnSdsD9r1X6wzgNzGShLz/YE
 G+upu81pvalZTWPrziRLTtwc9bhgpmemvvUbW1Rt0rgiqOX65uGQpcoGDRPv8E0dwXl5/Z
 oW1OV3FdDwcTTHG4zH4hH/+oPTo0vF4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-8CZvbNALNNeh7zDDmgfC3A-1; Wed, 15 Nov 2023 03:41:40 -0500
X-MC-Unique: 8CZvbNALNNeh7zDDmgfC3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D88C811E7E;
 Wed, 15 Nov 2023 08:41:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 412E31C060AE;
 Wed, 15 Nov 2023 08:41:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3487921E6A1F; Wed, 15 Nov 2023 09:41:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,  qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH] monitor: flush messages on abort
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
 <ZUi7izJoVpU+iiuC@redhat.com>
Date: Wed, 15 Nov 2023 09:41:39 +0100
In-Reply-To: <ZUi7izJoVpU+iiuC@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 6 Nov 2023 10:10:19 +0000")
Message-ID: <875y23s918.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Nov 03, 2023 at 03:51:00PM -0400, Steven Sistare wrote:
>> On 11/3/2023 1:33 PM, Daniel P. Berrang=C3=A9 wrote:
>> > On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
>> >> Buffered monitor output is lost when abort() is called.  The pattern
>> >> error_report() followed by abort() occurs about 60 times, so valuable
>> >> information is being lost when the abort is called in the context of a
>> >> monitor command.
>> >=20
>> > I'm curious, was there a particular abort() scenario that you hit ?
>>=20
>> Yes, while tweaking the suspended state, and forgetting to add transitio=
ns:
>>=20
>>         error_report("invalid runstate transition: '%s' -> '%s'",
>>         abort();
>>=20
>> But I have previously hit this for other errors.

Can you provide a reproducer?

>> > For some crude statistics:
>> >=20
>> >   $ for i in abort return exit goto ; do echo -n "$i: " ; git grep --a=
fter 1 error_report | grep $i | wc -l ; done
>> >   abort: 47
>> >   return: 512
>> >   exit: 458
>> >   goto: 177
>> >=20
>> > to me those numbers say that calling "abort()" after error_report
>> > should be considered a bug, and we can blanket replace all the
>> > abort() calls with exit(EXIT_FAILURE), and thus avoid the need to
>> > special case flushing the monitor.
>>=20
>> And presumably add an atexit handler to flush the monitor ala monitor_ab=
ort.
>> AFAICT currently no destructor is called for the monitor at exit time.
>
> The HMP monitor flushes at each newline,  and exit() will take care of
> flushing stdout, so I don't think there's anything else needed.

Correct.

>> > Also I think there's a decent case to be made for error_report()
>> > to call monitor_flush().

No, because the messages printed by error_report() all end in newline,
and printing a newline to a monitor triggers monitor_flush_locked().

>> A good start, but that would not help for monitors with skip_flush=3Dtru=
e, which=20
>> need to format the buffered string in a json response, which is the case=
 I=20
>> tripped over.
>
> 'skip_flush' is only set to 'true' when using a QMP monitor and invoking
> "hmp-monitor-command".

Correct.

> In such a case, the error message needs to be built into a JSON error
> reply and sent over the socket. Your patch doesn't help this case
> since you've just printed to stderr.  I don't think it is reasonable
> to expect QMP monitors to send replies on SIG_ABRT anyway. So I don't
> think the skip_flush=3Dtrue scenario is a problem to be concerned with.
>
>> >> To fix, install a SIGABRT handler to flush the monitor buffer to stde=
rr.
>> >>
>> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> >> ---
>> >>  monitor/monitor.c | 38 ++++++++++++++++++++++++++++++++++++++
>> >>  1 file changed, 38 insertions(+)
>> >>
>> >> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> >> index dc352f9..65dace0 100644
>> >> --- a/monitor/monitor.c
>> >> +++ b/monitor/monitor.c
>> >> @@ -701,6 +701,43 @@ void monitor_cleanup(void)
>> >>      }
>> >>  }
>> >>=20=20
>> >> +#ifdef CONFIG_LINUX
>> >> +
>> >> +static void monitor_abort(int signal, siginfo_t *info, void *c)
>> >> +{
>> >> +    Monitor *mon =3D monitor_cur();
>> >> +
>> >> +    if (!mon || qemu_mutex_trylock(&mon->mon_lock)) {
>> >> +        return;
>> >> +    }
>> >> +
>> >> +    if (mon->outbuf && mon->outbuf->len) {
>> >> +        fputs("SIGABRT received: ", stderr);
>> >> +        fputs(mon->outbuf->str, stderr);
>> >> +        if (mon->outbuf->str[mon->outbuf->len - 1] !=3D '\n') {
>> >> +            fputc('\n', stderr);
>> >> +        }
>> >> +    }
>> >> +
>> >> +    qemu_mutex_unlock(&mon->mon_lock);
>> >=20
>> > The SIGABRT handling does not only fire in response to abort()
>> > calls, but also in response to bad memory scenarios, so we have
>> > to be careful what we do in signal handlers.
>> >=20
>> > In particular using mutexes in signal handlers is a big red
>> > flag generally. Mutex APIs are not declare async signal
>> > safe, so this code is technically a POSIX compliance
>> > violation.

"Technically a POSIX compliance violation" sounds like something only
pedants would care about.  It's actually a recipe for deadlocks and
crashes.

>> Righto.  I would need to mask all signals in the sigaction to be on the =
safe(r) side.
>
> This is still doomed, because SIGABRT could fire while 'mon_lock' is
> already held, and so this code would deadlock trying to acquire the
> lock.

Yup.

There is no way to make async signal unsafe code safe.

>> > So I think we'd be safer just eliminating the explicit abort()
>> > calls and adding monitor_flush call to error_report.
>>=20
>> I like adding a handler because it is future proof.  No need to play wha=
ck-a-mole when
>> developers re-introduce abort() calls in the future.  A minor benefit is=
 I would not
>> need ack's from 50 maintainers to change 50 call sites from abort to exi=
t.
>
> That's a bit of a crazy exaggeration. THe aborts() don't cover 50 differe=
nt
> subsystems, and we don't require explicit acks from every subsystem maint=
ainer
> for trivial cleanups like this.
>
>> A slight risk of the exit solution is that something bad happened at the=
 call site, so=20
>> qemu state can no longer be trusted.  Calling abort immediately may be s=
afer than calling=20
>> exit which will call the existing atexit handlers and could have side ef=
fects.
>
> If that was a real problem, then we already face it because we have
> ~500 places already calling exit() and only 50 calling abort().
>
>> A third option is to define qemu_abort() which flushes the monitor, and =
replaces all abort
>> calls.  That avoids async-signal-mutex hand wringing, but is still subje=
ct to whack-a-mole.
>>=20
>> So: atexit, signal handler, or qemu_abort?  I will go with your preferen=
ce.
>
> Just replace abort -> exit.

I disagree.

Use exit(1) for fatal errors.

Use abort() for programming errors (a.k.a. bugs).

> I'm not seeing a need for an atexit handler on top.

I'm not yet seeing a need for anything.  A reproducer may change that.


