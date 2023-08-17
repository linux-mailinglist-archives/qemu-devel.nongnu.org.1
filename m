Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DFB77F74D
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWchx-00082S-Jf; Thu, 17 Aug 2023 09:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWchr-0007zX-Bn
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWcho-0001s8-5H
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692277587;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61SrrQRz/IyHnaapfqHKXf4k/PIuRdzD2mVgiTIKUUo=;
 b=bq+5TX85RaQOt7xDAai0Pko3hE+36taoHQdbcP2QZN4jzo0Dwge62aAyk7aPIBE492wb2p
 PogifiroAfuTooJAMZMQWcJhf60p3EUsRSi33ixBRa3to0uDWUDYIKiMlymH/XY8MVWFRW
 YsvrM8EgoTfFdzKSHCwCAQOcdYms09M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-rW1lDzmFMa-51d3HsUpQiA-1; Thu, 17 Aug 2023 09:06:23 -0400
X-MC-Unique: rW1lDzmFMa-51d3HsUpQiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A60F857A84;
 Thu, 17 Aug 2023 13:06:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E493140E962;
 Thu, 17 Aug 2023 13:06:22 +0000 (UTC)
Date: Thu, 17 Aug 2023 14:06:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
Message-ID: <ZN4bTLsw1bwLBEEz@redhat.com>
References: <20230816210743.1319018-1-thuth@redhat.com>
 <ZN33W+LhAn2FrFDT@redhat.com>
 <2bb2f8ac-43b4-9505-c163-d29964bf6a30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bb2f8ac-43b4-9505-c163-d29964bf6a30@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Aug 17, 2023 at 02:00:26PM +0200, Thomas Huth wrote:
> On 17/08/2023 12.32, Daniel P. Berrangé wrote:
> > On Wed, Aug 16, 2023 at 11:07:43PM +0200, Thomas Huth wrote:
> > > When starting a guest via libvirt with "virsh start --console ...",
> > > the first second of the console output is missing. This is especially
> > > annoying on s390x that only has a text console by default and no graphical
> > > output - if the bios fails to boot here, the information about what went
> > > wrong is completely lost.
> > > 
> > > One part of the problem (there is also some things to be done on the
> > > libvirt side) is that QEMU only checks with a 1 second timer whether
> > > the other side of the pty is already connected, so the first second of
> > > the console output is always lost.
> > > 
> > > This likely used to work better in the past, since the code once checked
> > > for a re-connection during write, but this has been removed in commit
> > > f8278c7d74 ("char-pty: remove the check for connection on write") to avoid
> > > some locking.
> > > 
> > > To ease the situation here at least a little bit, let's check with g_poll()
> > > whether we could send out the data anyway, even if the connection has not
> > > been marked as "connected" yet. The file descriptor is marked as non-blocking
> > > anyway since commit fac6688a18 ("Do not hang on full PTY"), so this should
> > > not cause any trouble if the other side is not ready for receiving yet.
> > > 
> > > With this patch applied, I can now successfully see the bios output of
> > > a s390x guest when running it with "virsh start --console" (with a patched
> > > version of virsh that fixes the remaining issues there, too).
> > > 
> > > Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   chardev/char-pty.c | 22 +++++++++++++++++++---
> > >   1 file changed, 19 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> > > index 4e5deac18a..fad12dfef3 100644
> > > --- a/chardev/char-pty.c
> > > +++ b/chardev/char-pty.c
> > > @@ -106,11 +106,27 @@ static void pty_chr_update_read_handler(Chardev *chr)
> > >   static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
> > >   {
> > >       PtyChardev *s = PTY_CHARDEV(chr);
> > > +    GPollFD pfd;
> > > +    int rc;
> > > -    if (!s->connected) {
> > > -        return len;
> > > +    if (s->connected) {
> > > +        return io_channel_send(s->ioc, buf, len);
> > >       }
> > > -    return io_channel_send(s->ioc, buf, len);
> > > +
> > > +    /*
> > > +     * The other side might already be re-connected, but the timer might
> > > +     * not have fired yet. So let's check here whether we can write again:
> > > +     */
> > > +    pfd.fd = QIO_CHANNEL_FILE(s->ioc)->fd;
> > > +    pfd.events = G_IO_OUT;
> > > +    pfd.revents = 0;
> > > +    rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
> > > +    g_assert(rc >= 0);
> > > +    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
> > 
> > Should (can?) we call
> > 
> >     pty_chr_state(chr, 1);
> > 
> > here ?
> 
> As far as I understood commit f8278c7d74c6 and f7ea2038bea04628, this is not
> possible anymore since the lock has been removed.
> 
> > > +        io_channel_send(s->ioc, buf, len);
> > 
> > As it feels a little dirty to be sending data before setting the
> > 'connected == 1' and thus issuing the 'CHR_EVENT_OPENED' event
> 
> I didn't find a really better solution so far. We could maybe introduce a
> buffer in the char-pty code and store the last second of guest output, but
> IMHO that's way more complex and thus somewhat ugly, too?

The orignal commit f8278c7d74c6 said

[quote]
    char-pty: remove the check for connection on write
    
    This doesn't help much compared to the 1 second poll PTY
    timer. I can't think of a use case where this would help.
[/quote]

We've now identified a use case where it is actually important.

IOW, there's a justification to revert both f7ea2038bea04628 and
f8278c7d74c6, re-adding the locking and write update logic.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


