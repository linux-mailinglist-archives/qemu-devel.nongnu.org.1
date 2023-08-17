Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A96A77F80F
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:48:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdLm-00021h-OQ; Thu, 17 Aug 2023 09:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qWdLX-0001uP-Mq
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qWdLT-0003O8-66
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692280045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCXbO8fuv67kKHW2N4r2VmGJFrf4wlMWzcyUKp7sKOE=;
 b=WRL7xBoHT4QG/iJb1DLKOba15xWqsiLj442QqwV9iBKk1cGW8DKzRUiDJUbZxnGyQI6uMH
 EG5hkaFInC8HwlfvXmOzjBwDOq5V1WMM+dS61tRBkMjnPGG7TQqhOzPs5M84QO1CjRn7ay
 Ff0usXq1tmEqdU84ShTcdjx/DWGGgpc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-6X88qH-0NOq1IMCW5C-UsA-1; Thu, 17 Aug 2023 09:47:24 -0400
X-MC-Unique: 6X88qH-0NOq1IMCW5C-UsA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99beea69484so441554866b.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 06:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692280041; x=1692884841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCXbO8fuv67kKHW2N4r2VmGJFrf4wlMWzcyUKp7sKOE=;
 b=Gh3J8TMnaeBtVh6lkuvaBK4S7oLldYJTwNB94LUXmEbcX4j0zFNvP8pxOcWmHwDxCB
 Ue5dBxOSCVuSSalaIrueJCm6QyoO3rkCu6380B3kPjVU1E8UtCRT+mGTEm+ijGc/bYJU
 d2IMwDK+V5kk6GJ9+nFz6AKx3GsR2uBd/qbgzW46VgikT3c85T/SSHBcLXyTgo8Qit+K
 0IbSvhCKWKHeKffml3oh3VHGuWqeFxFH0liylQr8njJheXiuerq1SZbqohdxukgD8Z3W
 wnivMHY7P6ZZxPP8qJBs4S7ZJrNymN+h/VhRQPYxfgQpSNXvco5RgFr6wc4c4YxCFcoY
 YLfw==
X-Gm-Message-State: AOJu0YzOpPOrD47J5V80/amerUBcik48m8HYM4JL2abjAhjT67O9mL3d
 brlFSX9Mf7utgi7zIJWtLdjgKmbBfoJlFiEzo7mTCi892sy7cnxiVHtn+0TuyLwceVpnFJcCWgq
 iC7GfCzyrabY8ao6nOCkvOYAAtypnUgI=
X-Received: by 2002:a17:907:1df2:b0:99d:fc31:242f with SMTP id
 og50-20020a1709071df200b0099dfc31242fmr2840394ejc.66.1692280040978; 
 Thu, 17 Aug 2023 06:47:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwIl8tPHcoAthrOXNDbAB2tXASOW+3dpZUzKyO036H5WprrF52HMzDkCg0Q04otydvzAMM1PBZs32lDaKB+Nk=
X-Received: by 2002:a17:907:1df2:b0:99d:fc31:242f with SMTP id
 og50-20020a1709071df200b0099dfc31242fmr2840373ejc.66.1692280040648; Thu, 17
 Aug 2023 06:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230816210743.1319018-1-thuth@redhat.com>
 <ZN33W+LhAn2FrFDT@redhat.com>
 <2bb2f8ac-43b4-9505-c163-d29964bf6a30@redhat.com>
 <ZN4bTLsw1bwLBEEz@redhat.com>
In-Reply-To: <ZN4bTLsw1bwLBEEz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Aug 2023 17:47:09 +0400
Message-ID: <CAMxuvazrSy0Fi1rwj21RWmSWVPXDrFrcZ6266-EHcvgxTzFfeg@mail.gmail.com>
Subject: Re: [PATCH] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi

On Thu, Aug 17, 2023 at 5:06=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Aug 17, 2023 at 02:00:26PM +0200, Thomas Huth wrote:
> > On 17/08/2023 12.32, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Aug 16, 2023 at 11:07:43PM +0200, Thomas Huth wrote:
> > > > When starting a guest via libvirt with "virsh start --console ...",
> > > > the first second of the console output is missing. This is especial=
ly
> > > > annoying on s390x that only has a text console by default and no gr=
aphical
> > > > output - if the bios fails to boot here, the information about what=
 went
> > > > wrong is completely lost.
> > > >
> > > > One part of the problem (there is also some things to be done on th=
e
> > > > libvirt side) is that QEMU only checks with a 1 second timer whethe=
r
> > > > the other side of the pty is already connected, so the first second=
 of
> > > > the console output is always lost.
> > > >
> > > > This likely used to work better in the past, since the code once ch=
ecked
> > > > for a re-connection during write, but this has been removed in comm=
it
> > > > f8278c7d74 ("char-pty: remove the check for connection on write") t=
o avoid
> > > > some locking.
> > > >
> > > > To ease the situation here at least a little bit, let's check with =
g_poll()
> > > > whether we could send out the data anyway, even if the connection h=
as not
> > > > been marked as "connected" yet. The file descriptor is marked as no=
n-blocking
> > > > anyway since commit fac6688a18 ("Do not hang on full PTY"), so this=
 should
> > > > not cause any trouble if the other side is not ready for receiving =
yet.
> > > >
> > > > With this patch applied, I can now successfully see the bios output=
 of
> > > > a s390x guest when running it with "virsh start --console" (with a =
patched
> > > > version of virsh that fixes the remaining issues there, too).
> > > >
> > > > Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >   chardev/char-pty.c | 22 +++++++++++++++++++---
> > > >   1 file changed, 19 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> > > > index 4e5deac18a..fad12dfef3 100644
> > > > --- a/chardev/char-pty.c
> > > > +++ b/chardev/char-pty.c
> > > > @@ -106,11 +106,27 @@ static void pty_chr_update_read_handler(Chard=
ev *chr)
> > > >   static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, i=
nt len)
> > > >   {
> > > >       PtyChardev *s =3D PTY_CHARDEV(chr);
> > > > +    GPollFD pfd;
> > > > +    int rc;
> > > > -    if (!s->connected) {
> > > > -        return len;
> > > > +    if (s->connected) {
> > > > +        return io_channel_send(s->ioc, buf, len);
> > > >       }
> > > > -    return io_channel_send(s->ioc, buf, len);
> > > > +
> > > > +    /*
> > > > +     * The other side might already be re-connected, but the timer=
 might
> > > > +     * not have fired yet. So let's check here whether we can writ=
e again:
> > > > +     */
> > > > +    pfd.fd =3D QIO_CHANNEL_FILE(s->ioc)->fd;
> > > > +    pfd.events =3D G_IO_OUT;
> > > > +    pfd.revents =3D 0;
> > > > +    rc =3D RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
> > > > +    g_assert(rc >=3D 0);
> > > > +    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
> > >
> > > Should (can?) we call
> > >
> > >     pty_chr_state(chr, 1);
> > >
> > > here ?
> >
> > As far as I understood commit f8278c7d74c6 and f7ea2038bea04628, this i=
s not
> > possible anymore since the lock has been removed.
> >
> > > > +        io_channel_send(s->ioc, buf, len);
> > >
> > > As it feels a little dirty to be sending data before setting the
> > > 'connected =3D=3D 1' and thus issuing the 'CHR_EVENT_OPENED' event
> >
> > I didn't find a really better solution so far. We could maybe introduce=
 a
> > buffer in the char-pty code and store the last second of guest output, =
but
> > IMHO that's way more complex and thus somewhat ugly, too?
>
> The orignal commit f8278c7d74c6 said
>
> [quote]
>     char-pty: remove the check for connection on write
>
>     This doesn't help much compared to the 1 second poll PTY
>     timer. I can't think of a use case where this would help.
> [/quote]
>
> We've now identified a use case where it is actually important.
>
> IOW, there's a justification to revert both f7ea2038bea04628 and
> f8278c7d74c6, re-adding the locking and write update logic.

Indeed. But isn't it possible to watch for IO_OUT and get rid of the timer?

Other thing I question is whether the serial shouldn't return BUSY if
the chardev is disconnected..


