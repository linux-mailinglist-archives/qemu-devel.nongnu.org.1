Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40977CFE8
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 18:09:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVwb4-00015B-94; Tue, 15 Aug 2023 12:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qVwb2-00014h-1N
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 12:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qVwb0-0005ui-Bf
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 12:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692115717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=meZ6kSxJlOnPPJ8FkrgVdgciStNQ/kXW9K+k/ZdqUbI=;
 b=dGH4QgGnhDgQ0D+UQX2ek9CXPt5XPS/Kgs7ZXur4sVFzunVpiAKqPW1W1gXP9e93tkdVeK
 MgCn0YTewScse9/04uA9eAQlfcl+iW43ATjbNSEc00dfRfEWNkHzGVGFeV04+sMtVIvd/n
 K91Zw3DIFQmgo4dISzxRSsGkQIfGvtc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-wyrk-HLsN_auL6F9QWZ1VQ-1; Tue, 15 Aug 2023 12:08:35 -0400
X-MC-Unique: wyrk-HLsN_auL6F9QWZ1VQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1956F800C78;
 Tue, 15 Aug 2023 16:08:35 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5555640D2839;
 Tue, 15 Aug 2023 16:08:34 +0000 (UTC)
Date: Tue, 15 Aug 2023 11:08:32 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH 2/5] qemu-nbd: fix regression with qemu-nbd --fork run
 over ssh
Message-ID: <r6o4lwgw33dtib37e5jmr2lqii5ppwcei4xm65ll2oj3jlxhqv@lah4j4ndo6fg>
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-3-den@openvz.org>
 <ZNo20bIZCRjypsIN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNo20bIZCRjypsIN@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

On Mon, Aug 14, 2023 at 04:14:41PM +0200, Kevin Wolf wrote:
> Am 17.07.2023 um 16:55 hat Denis V. Lunev geschrieben:
> > Commit e6df58a5578fee7a50bbf36f4a50a2781cff855d
> >     Author: Hanna Reitz <hreitz@redhat.com>
> >     Date:   Wed May 8 23:18:18 2019 +0200
> >     qemu-nbd: Do not close stderr
> > has introduced an interesting regression. Original behavior of
> >     ssh somehost qemu-nbd /home/den/tmp/file -f raw --fork
> > was the following:
> >  * qemu-nbd was started as a daemon
> >  * the command execution is done and ssh exited with success

Thinking about this more...

The original problem is that we broke 'ssh -c "qemu-nbd --fork ..."',
because the daemonized process hung on to the parent's stderr
indefinitely.

But when we pass -v, we WANT the parent's stderr to hang around, even
while we still want the parent process to see EOF on the handshake
socket used to let it know the child process got far enough along in
its initialization.

Should we be passing 'opt->verbose' instead of '0' to the second
parameter of qemu_daemon, to tell the child process the scenarios
where we want output to still be present?  If so, how does the
following patch look?

diff --git i/qemu-nbd.c w/qemu-nbd.c
index aaccaa33184..c316a91831d 100644
--- i/qemu-nbd.c
+++ w/qemu-nbd.c
@@ -944,9 +944,24 @@ int main(int argc, char **argv)

             close(stderr_fd[0]);

-            ret = qemu_daemon(1, 0);
+            ret = qemu_daemon(1, verbose);
             saved_errno = errno;    /* dup2 will overwrite error below */

+            if (verbose) {
+                /* We want stdin at /dev/null when qemu_daemon didn't do it */
+                stdin = freopen ("/dev/null", "r", stdin);
+                if (stdin == NULL) {
+                    error_report("Failed to redirect stdin: %s",
+                                 strerror(errno));
+                    exit(EXIT_FAILURE);
+                }
+                /* To keep the parent's stderr alive, copy it to stdout */
+                if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
+                    error_report("Failed to redirect stdout: %s",
+                                 strerror(errno));
+                    exit(EXIT_FAILURE);
+                }
+            }
             /* Temporarily redirect stderr to the parent's pipe...  */
             if (dup2(stderr_fd[1], STDERR_FILENO) < 0) {
                 char str[256];
@@ -1180,6 +1195,10 @@ int main(int argc, char **argv)
     }

     if (fork_process) {
+        /*
+         * See above. If verbose is false, stdout is /dev/null (thanks
+         * to qemu_daemon); otherwise, stdout is the parent's stderr.
+         */
         if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
             error_report("Could not set stderr to /dev/null: %s",
                          strerror(errno));


Note, however, that this still does not pass test 233 as written - the
error messages show up earlier in the run, rather than disappearing
altogether.

> > 
> > The patch has changed this behavior and 'ssh' command now hangs forever.
> > 
> > According to the normal specification of the daemon() call, we should
> > endup with STDERR pointing to /dev/null. That should be done at the
> > very end of the successful startup sequence when the pipe to the
> > bootstrap process (used for diagnostics) is no longer needed.
> > 
> > This could be achived in the same way as done for 'qemu-nbd -c' case.
> > That was commit 0eaf453e, also fixing up e6df58a5. STDOUT copying to
> > STDERR does the trick.
> > 
> > This also leads to proper 'ssh' connection closing which fixes my
> > original problem.
> > 
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > CC: Eric Blake <eblake@redhat.com>
> > CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > CC: Hanna Reitz <hreitz@redhat.com>
> > CC: <qemu-stable@nongnu.org>
> 
> This broke qemu-iotests 233 (Eric, please make sure to run the full
> qemu-iotests suite before sending block related pull requests):

My apologies; I keep forgetting that './check -nbd' does not catch all
the possible tests using NBD.  I've updated my checklists to make sure
I'm running a more thorough set of iotests before preparing a pull
request.

> 
> --- /home/kwolf/source/qemu/tests/qemu-iotests/233.out
> +++ /home/kwolf/source/qemu/build-clang/scratch/raw-file-233/233.out.bad
> @@ -99,14 +99,4 @@
>  qemu-nbd: TLS handshake failed: The TLS connection was non-properly terminated.
> 
>  == final server log ==
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
> -qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
> -qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
> -qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
> -qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
> -qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
>  *** done
> 
> Do we really want to lose these error messages? This looks wrong to me.
> 
> Kevin
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


