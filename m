Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E712753F0F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:36:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKKpD-0000jl-BS; Fri, 14 Jul 2023 11:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qKKpA-0000jH-VR
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qKKp9-00046h-7Z
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689348914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVQuJQzA4jX1Uwlv4A1LsnYg5LYasF9bo7R0qs8sA/o=;
 b=YRqpVrx7fuOpmw9YPZdjqS0dMjdVM7bB8TgmJOaXSxolNlka5ROefWtTiZa6dqGGpz69lB
 4tEJLhaAqkSgZFDcvMWrqBMLd3Uiuv43Kn3l6xxEI3hp7D0qOvI8ho5cVFMXgREFM1KOsP
 OaSWoPgPR86TXzqNjEq6OMRLcCrqxac=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-4s5rzJb_NV6FTj5B3RYlWA-1; Fri, 14 Jul 2023 11:35:09 -0400
X-MC-Unique: 4s5rzJb_NV6FTj5B3RYlWA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C00C33806711;
 Fri, 14 Jul 2023 15:35:08 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01D70492B01;
 Fri, 14 Jul 2023 15:35:07 +0000 (UTC)
Date: Fri, 14 Jul 2023 10:35:06 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/1] qemu-nbd: fix regression with qemu-nbd --fork run
 over ssh
Message-ID: <3prxtqtz6ogmmw4d2jl3rxz6xcv6agbufgbdpoigrbumqwhaaa@glqq44jjen3t>
References: <20230706191545.130087-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706191545.130087-1-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 06, 2023 at 09:15:45PM +0200, Denis V. Lunev wrote:
> Commit e6df58a5578fee7a50bbf36f4a50a2781cff855d
>     Author: Hanna Reitz <hreitz@redhat.com>
>     Date:   Wed May 8 23:18:18 2019 +0200
>     qemu-nbd: Do not close stderr
> has introduced an interesting regression. Original behavior of
>     ssh somehost qemu-nbd /home/den/tmp/file -f raw --fork
> was the following:
>  * qemu-nbd was started as a daemon
>  * the command execution is done and ssh exited with success
> 
> The patch has changed this behavior and 'ssh' command now hangs forever.
> 
> According to the normal specification of the daemon() call, we should
> endup with STDERR pointing to /dev/null. That should be done at the
> very end of the successful startup sequence when the pipe to the
> bootstrap process (used for diagnostics) is no longer needed.
> 
> This could be achived in the same way as done for 'qemu-nbd -c' case.

That was commit 0eaf453e, also fixing up e6df58a5.

> STDOUT copying to STDERR does the trick.

It took me a while to see how this worked (the double-negative of
passing 0 to the 'noclose' parameter of daemon() doesn't make it easy
to track what is supposed to happen), but I agree that our goal is
that after daemon()izing, we temporarily set stderr to the inherited
pipe for passing back any startup error messages, then usually want to
restore it to /dev/null for the remainder of the process.

> 
> This also leads to proper 'ssh' connection closing which fixes my
> original problem.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>  qemu-nbd.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

I indeed see how this fixes a regression under 'fork_process'.
However, the code that calls qemu_daemon() is also reachable under the
condition 'device && !verbose'.  Does it make sense for either:

qemu-nbd -v -c /dev/nbd0
qemu-nbd -f -v -c /dev/nbd0

as a way to connect to the kernel device, but explicitly ask to remain
verbose, as a way to debug issues in connecting to the kernel via
stderr?

Going back to the emails at the time of Hanna's original commit...

https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01872.html

I don't see any consideration about that case; capturing the original
stderr was done to fix what looked like an easy bug fix to a botched
implementation of old_stderr in commit ffb31e1d without considering
the ramifications.

But seeing as how pre-existing code DID want at least 'qemu-nbd -v -c
/dev/nbd0' to log indefinitely, I think we need to squash in:

diff --git i/qemu-nbd.c w/qemu-nbd.c
index 4276163564b..4d037798b9b 100644
--- i/qemu-nbd.c
+++ w/qemu-nbd.c
@@ -313,7 +313,7 @@ static void *nbd_client_thread(void *arg)
     /* update partition table */
     pthread_create(&show_parts_thread, NULL, show_parts, device);

-    if (verbose) {
+    if (verbose && !fork_process) {
         fprintf(stderr, "NBD device %s is now connected to %s\n",
                 device, srcpath);
     } else {


With that tweak, I'm fine with adding:

Reviewed-by: Eric Blake <eblake@redhat.com>

Do you agree with my tweak?  If so, I can queue this through my NBD
tree without needing to see a v2 post.  However...

> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 4276163564..e9e118dfdb 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -575,7 +575,6 @@ int main(int argc, char **argv)
>      bool writethrough = false; /* Client will flush as needed. */
>      bool fork_process = false;
>      bool list = false;
> -    int old_stderr = -1;
>      unsigned socket_activation;
>      const char *pid_file_name = NULL;
>      const char *selinux_label = NULL;
> @@ -930,11 +929,6 @@ int main(int argc, char **argv)
>          } else if (pid == 0) {
>              close(stderr_fd[0]);
>  
> -            /* Remember parent's stderr if we will be restoring it. */
> -            if (fork_process) {
> -                old_stderr = dup(STDERR_FILENO);
> -            }
> -
>              ret = qemu_daemon(1, 0);
>  
>              /* Temporarily redirect stderr to the parent's pipe...  */
> @@ -1152,8 +1146,7 @@ int main(int argc, char **argv)

Pre-existing, but your patch made me notice nearby (minor corner-case)
bugs:

            ret = qemu_daemon(1, 0);

            /* Temporarily redirect stderr to the parent's pipe...  */
            dup2(stderr_fd[1], STDERR_FILENO);

We aren't checking for dup2() failure.  But even if it succeeds (which
we expect), it could have modified the contents of errno compared to
what they were after qemu_daemon()...

            if (ret < 0) {
                error_report("Failed to daemonize: %s", strerror(errno));

...so this could be reporting garbage.  I wouldn't mind additional
patches to make the code more robust against unlikely failure
scenarios.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


