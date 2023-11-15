Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E9D7EC828
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:06:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3IOP-0001I4-3K; Wed, 15 Nov 2023 11:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3IOH-0001F8-4P
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:05:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3IOD-0007Y5-Dc
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700064316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSGPbx10bC9t/6xcSj9jlqbEkOSqYXB2PJy7WqzdPgo=;
 b=AjsD+2C6pBo1oU/J2E8oUq5IGvj+yrbrUm8NtgobHbSfEBfQXTsTApseLJw7O8E6f3CP7x
 /2TyFr/3AwXJEZOU6HETFS+crO6ADMbWLe7bjowZK9U0Hj4Cjp6BGPWDDDnlZuH0dOu4Rs
 I9BjObiGdZ9s8m+EGkNyCQ67eT+M9D0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-VC8uLtPHOOiP51y8BqxY9Q-1; Wed,
 15 Nov 2023 11:05:11 -0500
X-MC-Unique: VC8uLtPHOOiP51y8BqxY9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E32F38116F3;
 Wed, 15 Nov 2023 16:05:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25F0940C6EB9;
 Wed, 15 Nov 2023 16:05:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3068D21E6A1F; Wed, 15 Nov 2023 17:05:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH] monitor: flush messages on abort
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
 <ZUi7izJoVpU+iiuC@redhat.com>
 <587d8444-17a4-4d19-a856-ac55e46069c5@oracle.com>
Date: Wed, 15 Nov 2023 17:05:10 +0100
In-Reply-To: <587d8444-17a4-4d19-a856-ac55e46069c5@oracle.com> (Steven
 Sistare's message of "Wed, 15 Nov 2023 10:30:29 -0500")
Message-ID: <87sf57knnt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 11/6/2023 5:10 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Nov 03, 2023 at 03:51:00PM -0400, Steven Sistare wrote:
>>> On 11/3/2023 1:33 PM, Daniel P. Berrang=C3=A9 wrote:
>>>> On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
>>>>> Buffered monitor output is lost when abort() is called.  The pattern
>>>>> error_report() followed by abort() occurs about 60 times, so valuable
>>>>> information is being lost when the abort is called in the context of a
>>>>> monitor command.
>>>>
>>>> I'm curious, was there a particular abort() scenario that you hit ?
>>>
>>> Yes, while tweaking the suspended state, and forgetting to add transiti=
ons:
>>>
>>>         error_report("invalid runstate transition: '%s' -> '%s'",
>>>         abort();
>>>
>>> But I have previously hit this for other errors.
>>>
>>>> For some crude statistics:
>>>>
>>>>   $ for i in abort return exit goto ; do echo -n "$i: " ; git grep --a=
fter 1 error_report | grep $i | wc -l ; done
>>>>   abort: 47
>>>>   return: 512
>>>>   exit: 458
>>>>   goto: 177
>>>>
>>>> to me those numbers say that calling "abort()" after error_report
>>>> should be considered a bug, and we can blanket replace all the
>>>> abort() calls with exit(EXIT_FAILURE), and thus avoid the need to
>>>> special case flushing the monitor.
>>>
>>> And presumably add an atexit handler to flush the monitor ala monitor_a=
bort.
>>> AFAICT currently no destructor is called for the monitor at exit time.
>>=20
>> The HMP monitor flushes at each newline,  and exit() will take care of
>> flushing stdout, so I don't think there's anything else needed.
>>=20
>>>> Also I think there's a decent case to be made for error_report()
>>>> to call monitor_flush().
>>>
>>> A good start, but that would not help for monitors with skip_flush=3Dtr=
ue, which=20
>>> need to format the buffered string in a json response, which is the cas=
e I=20
>>> tripped over.
>>=20
>> 'skip_flush' is only set to 'true' when using a QMP monitor and invoking
>> "hmp-monitor-command".
>
> OK, that is narrower than I thought.  Now I see that other QMP monitors s=
end=20
> error_report() to stderr, hence it is visible after abort and exit:
>
> int error_vprintf(const char *fmt, va_list ap) {
>     if (cur_mon && !monitor_cur_is_qmp())
>         return monitor_vprintf(cur_mon, fmt, ap);
>     return vfprintf(stderr, fmt, ap);                <-- HERE
>
> That surprises me, I thought that would be returned to the monitor caller=
 in the
> json response. I guess the rationale is that the "main" error, if any, wi=
ll be
> set and returned by the err object that is passed down the stack during c=
ommand
> evaluation.

Three cases:

1. !cur_mon

   Not executing a monitor command.  We want to report errors etc to
   stderr.

2. cur_mon && !monitor_cur_is_qmp()

   Executing an HMP command.  We want to report errors to the current
   monitor.

2. cur_mon && monitor_cur_is_qmp()

   Executing a QMP command.  What we want is less obvious.

   Somewhere up the call stack is the QMP command's handler function.
   It takes an Error **errp argument.

   Within such a function, any errors need to be passed up the call
   chain into that argument.  Reporting them with error_report() is
   *wrong*.  Reporting must be left to the function's caller.

   A QMP command handler returns it output, it doesn't print it.  So
   calling monitor_printf() is wrong, too.

   But what about warn_report()?  Is that wrong, too?  We decided it's
   not, mostly because we have nothing else to offer.

   The stupidest way to keep it useful in QMP command context is to have
   error_vprintf() print to stderr.  So that's what it does.

   We could instead accumulate error_vprintf() output in a buffer, and
   include it with the QMP reply.  However, it's not clear what a
   management application could do with it.  So we stick to stupid.

[...]


