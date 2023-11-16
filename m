Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387AE7EDF93
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 12:22:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3aRo-0007uD-L8; Thu, 16 Nov 2023 06:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3aRm-0007ty-Ix
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:22:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3aRY-00027G-OY
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700133715;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T1gaQnwmhiIvqwheRag9lppivBOQBPv9o6ksKSqZSeU=;
 b=DhTREGDsn+jLyHA7+WRa+Pa0Bvb2GcULOCm56Gp/cjTxc8zcGvteSlQQZuYQ1dtS16hLWw
 lJbDhHVXzO5apJH/Rt2IKL9Qm3VgFax5isVoe8emN4plYywGvdtC+Z+OYw2hY63iieLkvc
 yZLCvB84ivkA4O3AFz/5XR2jfge4YMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-ArdN8kGlPL2zfQPnC-ix3A-1; Thu, 16 Nov 2023 06:21:52 -0500
X-MC-Unique: ArdN8kGlPL2zfQPnC-ix3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55410185A782;
 Thu, 16 Nov 2023 11:21:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15EDE1C060AE;
 Thu, 16 Nov 2023 11:21:50 +0000 (UTC)
Date: Thu, 16 Nov 2023 11:21:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH] monitor: flush messages on abort
Message-ID: <ZVX7TCAwPIlQ42Gs@redhat.com>
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
 <ZUi7izJoVpU+iiuC@redhat.com>
 <587d8444-17a4-4d19-a856-ac55e46069c5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <587d8444-17a4-4d19-a856-ac55e46069c5@oracle.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Nov 15, 2023 at 10:30:29AM -0500, Steven Sistare wrote:
> 
> 
> On 11/6/2023 5:10 AM, Daniel P. Berrangé wrote:
> > On Fri, Nov 03, 2023 at 03:51:00PM -0400, Steven Sistare wrote:
> >> On 11/3/2023 1:33 PM, Daniel P. Berrangé wrote:
> >>> On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
> >>>> Buffered monitor output is lost when abort() is called.  The pattern
> >>>> error_report() followed by abort() occurs about 60 times, so valuable
> >>>> information is being lost when the abort is called in the context of a
> >>>> monitor command.
> >>>
> >>> I'm curious, was there a particular abort() scenario that you hit ?
> >>
> >> Yes, while tweaking the suspended state, and forgetting to add transitions:
> >>
> >>         error_report("invalid runstate transition: '%s' -> '%s'",
> >>         abort();
> >>
> >> But I have previously hit this for other errors.
> >>
> >>> For some crude statistics:
> >>>
> >>>   $ for i in abort return exit goto ; do echo -n "$i: " ; git grep --after 1 error_report | grep $i | wc -l ; done
> >>>   abort: 47
> >>>   return: 512
> >>>   exit: 458
> >>>   goto: 177
> >>>
> >>> to me those numbers say that calling "abort()" after error_report
> >>> should be considered a bug, and we can blanket replace all the
> >>> abort() calls with exit(EXIT_FAILURE), and thus avoid the need to
> >>> special case flushing the monitor.
> >>
> >> And presumably add an atexit handler to flush the monitor ala monitor_abort.
> >> AFAICT currently no destructor is called for the monitor at exit time.
> > 
> > The HMP monitor flushes at each newline,  and exit() will take care of
> > flushing stdout, so I don't think there's anything else needed.
> > 
> >>> Also I think there's a decent case to be made for error_report()
> >>> to call monitor_flush().
> >>
> >> A good start, but that would not help for monitors with skip_flush=true, which 
> >> need to format the buffered string in a json response, which is the case I 
> >> tripped over.
> > 
> > 'skip_flush' is only set to 'true' when using a QMP monitor and invoking
> > "hmp-monitor-command".
> 
> OK, that is narrower than I thought.  Now I see that other QMP monitors send 
> error_report() to stderr, hence it is visible after abort and exit:
> 
> int error_vprintf(const char *fmt, va_list ap) {
>     if (cur_mon && !monitor_cur_is_qmp())
>         return monitor_vprintf(cur_mon, fmt, ap);
>     return vfprintf(stderr, fmt, ap);                <-- HERE
> 
> That surprises me, I thought that would be returned to the monitor caller in the
> json response. I guess the rationale is that the "main" error, if any, will be
> set and returned by the err object that is passed down the stack during command
> evaluation.
> 
> > In such a case, the error message needs to be built into a JSON error
> > reply and sent over the socket. Your patch doesn't help this case
> > since you've just printed to stderr.  
> 
> Same as vfprintf above!
> 
> > I don't think it is reasonable
> > to expect QMP monitors to send replies on SIG_ABRT anyway. 
> 
> I agree.  My patch causes the error to be seen somewhere, anywhere, instead
> of being dropped on the floor.
> 
> > So I don't
> > think the skip_flush=true scenario is a problem to be concerned with.
> 
> It is indeed a narrow case, and not worth much effort or code change.
> I'm inclined to drop it, but I appreciate the time you have spent reviewing it.

If you know of scenarios that can trigger abort() as a result of
either QMP or HMP commands, then we still need to fix those. Nothing
that is reachable from the monitor commands should ever end up in
abort(), as a general rule.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


