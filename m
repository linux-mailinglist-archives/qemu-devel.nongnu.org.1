Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2FBA4890B
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Feb 2025 20:32:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnjb7-0002yN-UD; Thu, 27 Feb 2025 14:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tnjb0-0002x5-AJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 14:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tnjax-00057N-3a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 14:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740684653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0q9tBcv/7BsfrLHzSvNVW/bD9t7BDHumvNZNro89jXk=;
 b=Mvw78Kj13nDlZBp80OjpKgBE5iQ8uUCFnVFeQuGhtw1yjiV19TVxKoaJdpHnA+gAmmldJy
 gxKhiuZByqnmAPd8LVoSZjrmDTaWqTgrUukIMC8HtGASI4GQRoomu+oZ+EtMYjsWmNoiuo
 lOXnfoyacWPbeqWc8VLhtLEWBEBcX6o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-fbBykwByMiSeyOefuErOYQ-1; Thu,
 27 Feb 2025 14:30:51 -0500
X-MC-Unique: fbBykwByMiSeyOefuErOYQ-1
X-Mimecast-MFC-AGG-ID: fbBykwByMiSeyOefuErOYQ_1740684650
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8C87180034A; Thu, 27 Feb 2025 19:30:49 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.162])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58CB51800371; Thu, 27 Feb 2025 19:30:47 +0000 (UTC)
Date: Thu, 27 Feb 2025 13:30:44 -0600
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH] trace/simple: Fix hang when using simpletrace with fork()
Message-ID: <bdzj3khw7bempzs3rmhdypks5nfnsamcqfs3touh5tuayftqhx@rxawe42qe7j3>
References: <20250226085015.1143991-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226085015.1143991-1-thuth@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 26, 2025 at 09:50:15AM +0100, Thomas Huth wrote:
> When compiling QEMU with --enable-trace-backends=simple , the
> iotest 233 is currently hanging. This happens because qemu-nbd
> calls trace_init_backends() first - which causes simpletrace to
> install its writer thread and the atexit() handler - before
> calling fork(). But the simpletrace writer thread is then only
> available in the parent process, not in the child process anymore.
> Thus when the child process exits, its atexit handler waits forever
> on the trace_empty_cond condition to be set by the non-existing
> writer thread, so the process never finishes.
> 
> Fix it by installing a pthread_atfork() handler, too, which
> makes sure that the trace_writeout_enabled variable gets set
> to false again in the child process, so we can use it in the
> atexit() handler to check whether we still need to wait on the
> writer thread or not.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  trace/simple.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/trace/simple.c b/trace/simple.c
> index c0aba00cb7f..269bbda69f1 100644
> --- a/trace/simple.c
> +++ b/trace/simple.c
> @@ -380,8 +380,22 @@ void st_print_trace_file_status(void)
>  
>  void st_flush_trace_buffer(void)
>  {
> -    flush_trace_file(true);
> +    flush_trace_file(trace_writeout_enabled);
> +}
> +
> +#ifndef _WIN32
> +static void trace_thread_atfork(void)
> +{
> +    /*
> +     * If we fork, the writer thread does not exist in the child, so
> +     * make sure to allow st_flush_trace_buffer() to clean up correctly.
> +     */
> +    g_mutex_lock(&trace_lock);

And are we sure trace_lock was previously initialized in memory
visible to the thread that is calling the after-fork handler here?

POSIX admits that pthread_atfork() is generally too hard to use
successfully (there are just too many corner cases), and instead
recommends that the only portable thing a multi-threaded app can do
after forking is limit itself to async-signal-safe functions until it
execs a new program.  The other common reason for forking is for
daemonization; there, the advice is to be completely single-threaded
until after the fork() has set up the right environment for the
daemon, at which point the child can then finally go multi-threaded.

And with either of those solutions (Using fork() to spawn a child
process? do nothing unsafe after fork except for what it takes to
reach exec. Using fork() to daemonize? do nothing unsafe before fork)
eliminates the need for using pthread_atfork() in the first place.

At any rate, per your plea elsewhere in the thread, I'll take a look
at deferring the logging init until after qemu-nbd has daemonized.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


