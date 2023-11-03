Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F917E077B
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:35:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy31-00045Y-5Y; Fri, 03 Nov 2023 13:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qyy2y-00045H-EA
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qyy2r-0002Ot-En
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699032800;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XlPR0eesiCJbd7OSV1DXFnrvHX5RWzZTQctfYfvwuNo=;
 b=V/qowcjiT46mRoH+wN6IKuuG3nUDcquUEzPcSPe2O4MYfI1UsCwgnM+O61WHJ70MyG8u0k
 lsbO6P2KiN3Pcp9/rv+elnQlmZ+g4Mose9jtBWcTW3cBkSGvwI0nVRoGAG2JxktXnM+A7g
 f0NrBOqnwa6swpIank3UkxT56xaqWDU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-DC4vEZR9PxOz0_AyegDH5Q-1; Fri,
 03 Nov 2023 13:33:15 -0400
X-MC-Unique: DC4vEZR9PxOz0_AyegDH5Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85FB828210D5;
 Fri,  3 Nov 2023 17:33:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 622E5492BE0;
 Fri,  3 Nov 2023 17:33:14 +0000 (UTC)
Date: Fri, 3 Nov 2023 17:33:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH] monitor: flush messages on abort
Message-ID: <ZUUu2IuUQ/Od7+Vr@redhat.com>
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
> Buffered monitor output is lost when abort() is called.  The pattern
> error_report() followed by abort() occurs about 60 times, so valuable
> information is being lost when the abort is called in the context of a
> monitor command.

I'm curious, was there a particular abort() scenario that you hit ?

For some crude statistics:

  $ for i in abort return exit goto ; do echo -n "$i: " ; git grep --after 1 error_report | grep $i | wc -l ; done
  abort: 47
  return: 512
  exit: 458
  goto: 177

to me those numbers say that calling "abort()" after error_report
should be considered a bug, and we can blanket replace all the
abort() calls with exit(EXIT_FAILURE), and thus avoid the need to
special case flushing the monitor.

Also I think there's a decent case to be made for error_report()
to call monitor_flush().

> 
> To fix, install a SIGABRT handler to flush the monitor buffer to stderr.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  monitor/monitor.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index dc352f9..65dace0 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -701,6 +701,43 @@ void monitor_cleanup(void)
>      }
>  }
>  
> +#ifdef CONFIG_LINUX
> +
> +static void monitor_abort(int signal, siginfo_t *info, void *c)
> +{
> +    Monitor *mon = monitor_cur();
> +
> +    if (!mon || qemu_mutex_trylock(&mon->mon_lock)) {
> +        return;
> +    }
> +
> +    if (mon->outbuf && mon->outbuf->len) {
> +        fputs("SIGABRT received: ", stderr);
> +        fputs(mon->outbuf->str, stderr);
> +        if (mon->outbuf->str[mon->outbuf->len - 1] != '\n') {
> +            fputc('\n', stderr);
> +        }
> +    }
> +
> +    qemu_mutex_unlock(&mon->mon_lock);

The SIGABRT handling does not only fire in response to abort()
calls, but also in response to bad memory scenarios, so we have
to be careful what we do in signal handlers.

In particular using mutexes in signal handlers is a big red
flag generally. Mutex APIs are not declare async signal
safe, so this code is technically a POSIX compliance
violation.

So I think we'd be safer just eliminating the explicit abort()
calls and adding monitor_flush call to error_report.

> +}
> +
> +static void monitor_add_abort_handler(void)
> +{
> +    struct sigaction act;
> +
> +    memset(&act, 0, sizeof(act));
> +    act.sa_sigaction = monitor_abort;
> +    act.sa_flags = SA_SIGINFO;
> +    sigaction(SIGABRT,  &act, NULL);
> +}
> +
> +#else
> +
> +static void monitor_add_abort_handler(void) {}
> +
> +#endif
> +
>  static void monitor_qapi_event_init(void)
>  {
>      monitor_qapi_event_state = g_hash_table_new(qapi_event_throttle_hash,
> @@ -712,6 +749,7 @@ void monitor_init_globals(void)
>      monitor_qapi_event_init();
>      qemu_mutex_init(&monitor_lock);
>      coroutine_mon = g_hash_table_new(NULL, NULL);
> +    monitor_add_abort_handler();
>  
>      /*
>       * The dispatcher BH must run in the main loop thread, since we
> -- 
> 1.8.3.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


