Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A3878B455
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae48-0002Y9-D6; Mon, 28 Aug 2023 11:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qae3o-0002A0-KP
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qae3l-0007Vs-QB
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693236105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZOGK6ogQU+3D0QE51A1HkpxAB8zXge8FYD1a9yFshLA=;
 b=HUDr5h/0ejEmAq5Y7hi5Wkvtx8UwxORPUfGmMru7p8TSlN7fReERxgelDtBx3BL3MZN+9w
 IQlemeIWe73kfwT8hhax4Oh6eyr7q/28rIqhStSlxmuAkzHfG6dUz7rZG1yX3e4nbkLkrk
 5QvXSyT5zaOYu90vIGju0W/nfNoLUQk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-0EC0Sg2pMwquMQQ8VwScEg-1; Mon, 28 Aug 2023 11:21:40 -0400
X-MC-Unique: 0EC0Sg2pMwquMQQ8VwScEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23F6E185A78B;
 Mon, 28 Aug 2023 15:21:40 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C4D72026D4B;
 Mon, 28 Aug 2023 15:21:38 +0000 (UTC)
Date: Mon, 28 Aug 2023 10:21:37 -0500
From: Eric Blake <eblake@redhat.com>
To: 20230825192940.35364-1-den@openvz.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org, 
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: Re: [PATCH vOther2 1/1] qemu-nbd: Restore "qemu-nbd -v --fork" output
Message-ID: <pa2nh352u72sysgqsstwiytczumknwuczhnbrt5yahssolplwh@axdnqmkb2djs>
References: <20230825200838.39994-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825200838.39994-1-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 25, 2023 at 10:08:38PM +0200, Denis V. Lunev wrote:
> Closing stderr earlier is good for daemonized qemu-nbd under ssh
> earlier, but breaks the case where -v is being used to track what is
> happening in the server, as in iotest 233.

Keeping the iotest output unchanged is a nice effect, even if it
requires a bit more code, so I'm leaning towards taking your patch.

> 
> When we know we are verbose, we should preserve original stderr and
> restore it once the setup stage is done. This commit restores the
> original behavior with -v option. In this case original output
> inside the test is kept intact.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Mike Maslenkin <mike.maslenkin@gmail.com>
> Fixes: 5c56dd27a2 ("qemu-nbd: fix regression with qemu-nbd --fork run over ssh")
> ---
> Changes from v1:
> * fixed compilation with undefined HAVE_NBD_DEVICE, thanks to Mike Maslenkin

> @@ -323,11 +324,14 @@ static void *nbd_client_thread(void *arg)
>                  opts->device, srcpath);
>      } else {
>          /* Close stderr so that the qemu-nbd process exits.  */
> -        if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
> +        if (dup2(opts->stderr, STDERR_FILENO) < 0) {
>              error_report("Could not set stderr to /dev/null: %s",

Both my patch and yours have a slight inaccuracy here: when -v is in
use, failure to dup2() is not a failure to set stderr to /dev/null.
Maybe we can reword it as "Could not release pipe to parent: %s", as
that is the other intentional side effect of the dup2()?

>                           strerror(errno));
>              exit(EXIT_FAILURE);
>          }
> +        if (opts->stderr != STDOUT_FILENO) {
> +            close(opts->stderr);

As long as we are checking dup2() for (unlikely) failure, we should
probably be doing the same for close().

> +        }
>      }
>  
>      if (nbd_client(fd) < 0) {
> @@ -589,9 +593,9 @@ int main(int argc, char **argv)
>      const char *pid_file_name = NULL;
>      const char *selinux_label = NULL;
>      BlockExportOptions *export_opts;
> -#if HAVE_NBD_DEVICE
> -    struct NbdClientOpts opts;
> -#endif
> +    struct NbdClientOpts opts = {
> +        .stderr = STDOUT_FILENO,
> +    };
>  
>  #ifdef CONFIG_POSIX
>      os_setup_early_signal_handling();
> @@ -944,6 +948,15 @@ int main(int argc, char **argv)
>  
>              close(stderr_fd[0]);
>  
> +            /* Remember parent's stderr if we will be restoring it. */
> +            if (verbose /* fork_process is set */) {
> +                opts.stderr = dup(STDERR_FILENO);
> +                if (opts.stderr < 0) {
> +                    error_report("Could not dup stdedd: %s", strerror(errno));

s/stdedd/stderr/

> +                    exit(EXIT_FAILURE);
> +                }
> +            }
> +
>              ret = qemu_daemon(1, 0);
>              saved_errno = errno;    /* dup2 will overwrite error below */
>  
> @@ -1152,6 +1165,7 @@ int main(int argc, char **argv)
>              .device = device,
>              .fork_process = fork_process,
>              .verbose = verbose,
> +            .stderr = STDOUT_FILENO,

Huh. This looks redundant to pre-initializing .stderr above; but since
it is using a struct assignment, we do have to provide it again to
avoid the compiler setting unmentioned fields to zero-initialization.

If we are going to unconditionally have opts in scope, even when not
passing it to pthread_create(), maybe we could just directly assign to
opts.device and drop the local variable device (and so forth), instead
of first storing into device only to later copy it to opts.device.
But that would make this patch bigger, so I'm not sure it is worth it.

>          };
>  
>          ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
> @@ -1180,11 +1194,14 @@ int main(int argc, char **argv)
>      }
>  
>      if (fork_process) {
> -        if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
> +        if (dup2(opts.stderr, STDERR_FILENO) < 0) {
>              error_report("Could not set stderr to /dev/null: %s",
>                           strerror(errno));

Another spot where the error message is not entirely accurate,

>              exit(EXIT_FAILURE);
>          }
> +        if (opts.stderr != STDOUT_FILENO) {
> +            close(opts.stderr);

and another spot where we should be checking for close() failure.

> +        }
>      }
>  
>      state = RUNNING;
> -- 
> 2.34.1
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


