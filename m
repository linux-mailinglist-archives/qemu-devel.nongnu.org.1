Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D634FA12004
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Jan 2025 11:40:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY0np-0007xq-O6; Wed, 15 Jan 2025 05:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tY0nm-0007xa-Ha
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:39:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tY0nk-00050Q-FP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736937545;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ai2W8Cm2E/I+HcL/Seu+PjoXIofaesCZk0zlrmAtj4Y=;
 b=g6PL/JaiP/D+ZtnrcOYVB6/JXFaWmbjSQQITA2hXXwkL4VV11bZglS1+07T9OWrmnt4/Fu
 Z4+a8DEFV7YJNjuDtX96BVH474yG438lMVB1qD6elR3W9fFGWwlqvV6/+RCgymao+2GUw1
 fZXhRawYcPCZgAiq1RYXfkC92CboEiQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-5buwi3YWMDiRJJR5ALFnHw-1; Wed,
 15 Jan 2025 05:38:59 -0500
X-MC-Unique: 5buwi3YWMDiRJJR5ALFnHw-1
X-Mimecast-MFC-AGG-ID: 5buwi3YWMDiRJJR5ALFnHw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4AE21955E7F; Wed, 15 Jan 2025 10:38:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.126])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AA2230001BE; Wed, 15 Jan 2025 10:38:56 +0000 (UTC)
Date: Wed, 15 Jan 2025 10:38:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v2 2/2] tap: Use g_spawn_sync() and
 g_spawn_check_wait_status()
Message-ID: <Z4eQPXn7P5B_XEX9@redhat.com>
References: <20250104-glib-v2-0-12013f3e5782@daynix.com>
 <20250104-glib-v2-2-12013f3e5782@daynix.com>
 <Z3ujuV1jH_dSY9HZ@redhat.com>
 <d0601ef8-f959-4bea-8993-a9b5512fabe8@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0601ef8-f959-4bea-8993-a9b5512fabe8@daynix.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 15, 2025 at 03:04:19PM +0900, Akihiko Odaki wrote:
> On 2025/01/06 18:34, Daniel P. Berrangé wrote:
> > On Sat, Jan 04, 2025 at 05:04:08PM +0900, Akihiko Odaki wrote:
> > > g_spawn_sync() gives an informative message if it fails to execute
> > > the script instead of reporting exiting status 1.
> > > 
> > > g_spawn_check_wait_status() also gives an message easier to understand
> > > than the raw value returned by waitpid().
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   net/tap.c | 169 ++++++++++++++++++++++++--------------------------------------
> > >   1 file changed, 66 insertions(+), 103 deletions(-)
> > > 
> > > diff --git a/net/tap.c b/net/tap.c
> > > index ae1c7e398321..392a024f8ed9 100644
> > > --- a/net/tap.c
> > > +++ b/net/tap.c
> > > @@ -385,56 +385,30 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
> > >       return s;
> > >   }
> > > -static void close_all_fds_after_fork(int excluded_fd)
> > > +static void unset_cloexec(gpointer data)
> > >   {
> > > -    const int skip_fd[] = {STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO,
> > > -                           excluded_fd};
> > > -    unsigned int nskip = ARRAY_SIZE(skip_fd);
> > > -
> > > -    /*
> > > -     * skip_fd must be an ordered array of distinct fds, exclude
> > > -     * excluded_fd if already included in the [STDIN_FILENO - STDERR_FILENO]
> > > -     * range
> > > -     */
> > > -    if (excluded_fd <= STDERR_FILENO) {
> > > -        nskip--;
> > > -    }
> > > -
> > > -    qemu_close_all_open_fd(skip_fd, nskip);
> > > +    g_assert(!fcntl(GPOINTER_TO_INT(data), F_SETFD, 0));
> > >   }
> > >   static void launch_script(const char *setup_script, const char *ifname,
> > >                             int fd, Error **errp)
> > >   {
> > > -    int pid, status;
> > > -    char *args[3];
> > > -    char **parg;
> > > +    gint status;
> > > +    gchar *argv[] = { (gchar *)setup_script, (gchar *)ifname, NULL };
> > > +    g_autoptr(GError) error = NULL;
> > >       /* try to launch network script */
> > > -    pid = fork();
> > > -    if (pid < 0) {
> > > -        error_setg_errno(errp, errno, "could not launch network script %s",
> > > -                         setup_script);
> > > +    if (!g_spawn_sync(NULL, argv, NULL, G_SPAWN_CHILD_INHERITS_STDIN,
> > > +                      unset_cloexec, GINT_TO_POINTER(fd),
> > > +                      NULL, NULL, &status, &error)) {
> > 
> > This unset_cloexec callback is relying on knowledge of current internal
> > impl details of g_spawn_sync. The API docs say that all file descriptors
> > will be closed, except for stdin/out/err. We should not assume glib is
> > doing this by setting O_CLOEXEC, as opposed to directly calling close().
> > 
> > If we need specific FDs to remain open, we neeed to be using the other
> > g_spawn_async_with_pipes_and_fds API that accepts a list of FDs to remain
> > open.
> 
> g_spawn_async_with_pipes_and_fds() is not available for 2.66 so we cannot
> use it.
> 
> An upstream developer says unsetting FD_CLOEXEC in the setup function is
> fine in such a scenario. They are not documenting that because new glib
> versions they are developing has g_spawn_async_with_pipes_and_fds(), which
> is a better alternative:
> https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4452

That comment only says we're fine to unset FD_CLOEXEC on *historical*
releases of GLib. ie they're not going to break this in a bug fix on
a stable branch of 2.66.x. For anything >= 2.68 they say we need to
be using g_spawn_async_with_pipes_and_fds

IOW, we need to support both code paths today, and in future when we
drop 2.66 compat, we can eliminate the FD_CLOEXEC codepath, leaving
us with only g_spawn_async_with_pipes_and_fds

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


