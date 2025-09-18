Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F7B51299
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 11:35:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwHCO-0002e3-Vh; Wed, 10 Sep 2025 05:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwHCM-0002dZ-Sg
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwHCF-0007Hk-H0
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757496773;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cv2UwZ9vU/leVQ029w+8wCenU9+O63Jq27IgzCAk2G0=;
 b=Nagzycn99QLTa218HNZPKx9FiVX8vOG21xXbbW+pgNs/s6Uhsa6xc20534S3xWbBZXaSAc
 /qJu++weusLzF3bXIB6ZWOziWG+dPT/w9ZUFgiT0zSz0A0mfF6GeSiUmFvdft9qB/Rm3rz
 eZwYXpZUZtgRjV0HDNlnLBMZHHRNKrI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-lE0tAQuCPyqY1T-vI1KtCQ-1; Wed,
 10 Sep 2025 05:32:50 -0400
X-MC-Unique: lE0tAQuCPyqY1T-vI1KtCQ-1
X-Mimecast-MFC-AGG-ID: lE0tAQuCPyqY1T-vI1KtCQ_1757496768
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 041B71956089; Wed, 10 Sep 2025 09:32:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83A0E1800446; Wed, 10 Sep 2025 09:32:40 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:32:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 07/10] use qemu_set_blocking instead of
 g_unix_set_fd_nonblocking
Message-ID: <aMFFtg-zuX52Z1b8@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-8-vsementsov@yandex-team.ru>
 <aL_ssg0m_4FOfpHo@redhat.com>
 <4b0de513-12fa-4891-8dde-82971efa4778@yandex-team.ru>
 <aL_wTKuHCaTdDFRd@redhat.com>
 <b3a67bc3-757a-4d11-b9cc-a6c69073add9@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3a67bc3-757a-4d11-b9cc-a6c69073add9@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 09, 2025 at 12:50:00PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 09.09.25 12:15, Daniel P. Berrangé wrote:
> > On Tue, Sep 09, 2025 at 12:11:19PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 09.09.25 12:00, Daniel P. Berrangé wrote:
> > > > On Wed, Sep 03, 2025 at 12:44:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > Instead of open-coded g_unix_set_fd_nonblocking() calls, use
> > > > > QEMU wrapper qemu_socket_set_nonblock().
> > > > > 
> > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > ---
> > > > >    chardev/char-fd.c                  |  4 ++--
> > > > >    chardev/char-pty.c                 |  3 +--
> > > > >    chardev/char-serial.c              |  3 +--
> > > > >    chardev/char-stdio.c               |  3 +--
> > > > >    hw/input/virtio-input-host.c       |  3 +--
> > > > >    hw/misc/ivshmem-flat.c             |  4 +++-
> > > > >    hw/misc/ivshmem-pci.c              |  8 +++++++-
> > > > >    hw/virtio/vhost-vsock.c            |  8 ++------
> > > > >    io/channel-command.c               |  9 ++++++---
> > > > >    io/channel-file.c                  |  3 +--
> > > > >    net/tap-bsd.c                      | 12 ++++++++++--
> > > > >    net/tap-linux.c                    |  8 +++++++-
> > > > >    net/tap-solaris.c                  |  7 ++++++-
> > > > >    net/tap.c                          | 21 ++++++---------------
> > > > >    qga/commands-posix.c               |  3 +--
> > > > >    tests/qtest/fuzz/virtio_net_fuzz.c |  2 +-
> > > > >    tests/qtest/vhost-user-test.c      |  3 +--
> > > > >    tests/unit/test-iov.c              |  5 +++--
> > > > >    ui/input-linux.c                   |  3 +--
> > > > >    util/event_notifier-posix.c        |  5 +++--
> > > > >    util/main-loop.c                   |  6 +++++-
> > > > >    21 files changed, 69 insertions(+), 54 deletions(-)
> > > > 
> > > > > diff --git a/io/channel-command.c b/io/channel-command.c
> > > > > index 8966dd3a2b..8ae9a026b3 100644
> > > > > --- a/io/channel-command.c
> > > > > +++ b/io/channel-command.c
> > > > > @@ -277,9 +277,12 @@ static int qio_channel_command_set_blocking(QIOChannel *ioc,
> > > > >        cioc->blocking = enabled;
> > > > >    #else
> > > > > -    if ((cioc->writefd >= 0 && !g_unix_set_fd_nonblocking(cioc->writefd, !enabled, NULL)) ||
> > > > > -        (cioc->readfd >= 0 && !g_unix_set_fd_nonblocking(cioc->readfd, !enabled, NULL))) {
> > > > > -        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
> > > > > +    if (cioc->writefd >= 0 &&
> > > > > +        !qemu_set_blocking(cioc->writefd, enabled, errp)) {
> > > > > +        return -1;
> > > > > +    }
> > > > > +    if (cioc->readfd >= 0 &&
> > > > > +        !qemu_set_blocking(cioc->readfd, enabled, errp)) {
> > > > >            return -1;
> > > > >        }
> > > > >    #endif
> > > > > diff --git a/io/channel-file.c b/io/channel-file.c
> > > > > index ca3f180cc2..5cef75a67c 100644
> > > > > --- a/io/channel-file.c
> > > > > +++ b/io/channel-file.c
> > > > > @@ -223,8 +223,7 @@ static int qio_channel_file_set_blocking(QIOChannel *ioc,
> > > > >    #else
> > > > >        QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
> > > > > -    if (!g_unix_set_fd_nonblocking(fioc->fd, !enabled, NULL)) {
> > > > > -        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
> > > > > +    if (!qemu_set_blocking(fioc->fd, enabled, errp)) {
> > > > >            return -1;
> > > > >        }
> > > > >        return 0;
> > > > 
> > > > This is wrong for Windows. fioc->fd is not a socket, but this is passing
> > > > it to an API whose impl assume it is receiving a socket.
> > > > 
> > > 
> > > But what is changed with the patch? g_unix_set_fd_nonblocking(fioc->fd, ..) is wrong for Windows as well.
> > 
> > Actually I missed the #ifdef. This code is in an #else branch that excludes
> > compilation on Wnidows - the Windows brach just raise an error.
> > 
> > > And making separate qemu_set_blocking() and qemu_socket_set_blocking(), which do the same
> > > thing, doesn't make sense..
> > > 
> > > Hmm. But we can define qemu_set_blocking() only for Linux, keeping qemu_socket_set_blocking() the generic
> > > function. Still, nothing prevents using qemu_socket_set_blocking() on non-sockets..
> > 
> > We just relying on the name of the function alerting the developer / reviewer.
> > If you're dealing with a FIFO pipe FD you are (hopefully) going to realize
> > that qemu_socket_XXX is not a function to be used.
> > 
> 
> Understand. But having both qemu_XXX() and qemu_socket_XXX(), I'd be confused, why not just use qemu_XXX() everywhere.
> 
> So, for final API, either we have one function qemu_set_blocking() (as the series propose), and lose this alert,
> 
> or, we should have something like:
> 
> qemu_socket_set_blocking() - generic, for calling on sockets, Windows or Linux
> 
> qemu_unix_set_blocking() - defined only for Linux
> 
> What I dislike with the latter:
> 
> 1. For Linux functions are duplicates actually. So, we have a defined only for Linux duplicate of generic function
> 
> 2. Nothing prevents using qemu_socket_set_blocking() on any fds in Linux except name (and it will succeed!!)

I looked at what we do in libvirt, and there we just have a single
function virSetBlocking() that simply does ioctrlsocket() on Windows.
I can't say we've had any significant trouble with that, though our
Windows scope & usage is much less than QEMU's.

A key difference though is that callers are expected to check the
return value for failure.


With the current QEMU design where we do NOT expect callers to check
for failure, I think it is important that the function naming make
clear the intended use case, as we won't get runtime diagnosis of
incorrect calls.

So with this in mind, I'm actually OK with your proposed design for
a general  qemu_set_blocking, as that has an Error **errp parameter
encouraging failure checking by callers.

The ioctlsocket method will also return a clear error if passed
something that is not a SOCKET, but a generic file backed HANDLE.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


