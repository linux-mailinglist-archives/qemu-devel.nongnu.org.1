Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EED7F442B
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 11:43:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5khB-0000zm-6Q; Wed, 22 Nov 2023 05:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5kh9-0000zV-8p
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 05:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5kh7-0003nt-HA
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 05:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700649776;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZeTmuhOStKxYOF1MQvMSeI+XIsLNxFcE2VSCnV0WlM=;
 b=WyXo7mKtyRRIpz9tm/gl1CMRJmL6INgttiQ0oqg9QyAKMOdlfV3aAktSxb0eqWV5AiBLQ+
 KiGCs2StBMSTzN55UulKaxGf6egbxBwgMjX0BSUVPAdQ8lc/P7lb2+P+CqH7TPPUi9hHHw
 9tikEA2MfFPuOyxYUSmWm2eSXDKI1J0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-aNNno5sHOB2IBWS0SAcSRg-1; Wed, 22 Nov 2023 05:42:52 -0500
X-MC-Unique: aNNno5sHOB2IBWS0SAcSRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B1DC85A58C;
 Wed, 22 Nov 2023 10:42:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E97D10F44;
 Wed, 22 Nov 2023 10:42:47 +0000 (UTC)
Date: Wed, 22 Nov 2023 10:42:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 2/3] chardev: report blocked write to chardev backend
Message-ID: <ZV3bJXOy4vxyHTWK@redhat.com>
References: <20231116115354.228678-1-npiggin@gmail.com>
 <20231116115354.228678-2-npiggin@gmail.com>
 <CAMxuvawXTrQ3Mu-aGbELnQyBRU4W9kuMQo-XM_zm4FbRymHkqA@mail.gmail.com>
 <CX3OGGIB0IAN.1CDYNM9U7M5Y3@wheely>
 <CAMxuvayyULsyM0bQvCr-WRP39JwbTcDknBYEhj=eDrRQ2+9dUQ@mail.gmail.com>
 <13f96104-9d9d-4f57-9c40-06352b6a6b87@redhat.com>
 <CAMxuvay+vfg+tCq3ZQt5WkLxH69QXTC1vS_7QmEKCPxCoC840g@mail.gmail.com>
 <99568f4f-2168-4719-8454-90f0e0658c2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99568f4f-2168-4719-8454-90f0e0658c2c@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Nov 22, 2023 at 11:38:28AM +0100, Thomas Huth wrote:
> On 21/11/2023 12.47, Marc-André Lureau wrote:
> > Hi
> > 
> > On Tue, Nov 21, 2023 at 1:45 PM Thomas Huth <thuth@redhat.com> wrote:
> > > 
> > > On 21/11/2023 10.39, Marc-André Lureau wrote:
> > > > Hi
> > > > 
> > > > On Mon, Nov 20, 2023 at 5:36 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > > 
> > > > > On Mon Nov 20, 2023 at 10:06 PM AEST, Marc-André Lureau wrote:
> > > > > > Hi
> > > > > > 
> > > > > > On Thu, Nov 16, 2023 at 3:54 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > > > > 
> > > > > > > If a chardev socket is not read, it will eventually fill and QEMU
> > > > > > > can block attempting to write to it. A difficult bug in avocado
> > > > > > > tests where the console socket was not being read from caused this
> > > > > > > hang.
> > > > > > > 
> > > > > > > warn if a chardev write is blocked for 100ms.
> > > > > > > 
> > > > > > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > > > > > ---
> > > > > > > This is not necessary for the fix but it does trigger in the
> > > > > > > failing avocado test without the previous patch applied. Maybe
> > > > > > > it would be helpful?
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Nick
> > > > > > > 
> > > > > > >    chardev/char.c | 6 ++++++
> > > > > > >    1 file changed, 6 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/chardev/char.c b/chardev/char.c
> > > > > > > index 996a024c7a..7c375e3cc4 100644
> > > > > > > --- a/chardev/char.c
> > > > > > > +++ b/chardev/char.c
> > > > > > > @@ -114,6 +114,8 @@ static int qemu_chr_write_buffer(Chardev *s,
> > > > > > >    {
> > > > > > >        ChardevClass *cc = CHARDEV_GET_CLASS(s);
> > > > > > >        int res = 0;
> > > > > > > +    int nr_retries = 0;
> > > > > > > +
> > > > > > >        *offset = 0;
> > > > > > > 
> > > > > > >        qemu_mutex_lock(&s->chr_write_lock);
> > > > > > > @@ -126,6 +128,10 @@ static int qemu_chr_write_buffer(Chardev *s,
> > > > > > >                } else {
> > > > > > >                    g_usleep(100);
> > > > > > >                }
> > > > > > > +            if (++nr_retries == 1000) { /* 100ms */
> > > > > > > +                warn_report("Chardev '%s' write blocked for > 100ms, "
> > > > > > > +                            "socket buffer full?", s->label);
> > > > > > > +            }
> > > > > > 
> > > > > > That shouldn't happen, the frontend should poll and only write when it
> > > > > > can. What is the qemu command being used here?
> > > > > 
> > > > > You can follow it through the thread here
> > > > > 
> > > > > https://lore.kernel.org/qemu-devel/ZVT-bY9YOr69QTPX@redhat.com/
> > > > > 
> > > > > In short, a console device is attached to a socket pair and nothing
> > > > > ever reads from it. It eventually fills, and writing to it fails
> > > > > indefinitely here.
> > > > > 
> > > > > It can be reproduced with:
> > > > > 
> > > > > make check-avocado
> > > > > AVOCADO_TESTS=tests/avocado/reverse_debugging.py:test_ppc64_pseries
> > > > > 
> > > > > 
> > > > 
> > > > How reliably? I tried 10/10.
> > > 
> > > It used to fail for me every time I tried - but the fix has already been
> > > merged yesterday (commit cd43f00524070c026), so if you updated today, you'll
> > > see the test passing again.
> > 
> > Ok so the "frontend" is spapr-vty and there:
> > 
> > void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len)
> > {
> >      SpaprVioVty *dev = VIO_SPAPR_VTY_DEVICE(sdev);
> > 
> >      /* XXX this blocks entire thread. Rewrite to use
> >       * qemu_chr_fe_write and background I/O callbacks */
> >      qemu_chr_fe_write_all(&dev->chardev, buf, len);
> > }
> > 
> > (grep "XXX this blocks", we have a lot...)
> > 
> > Can H_PUT_TERM_CHAR return the number of bytes written?
> 
> You can find the definition of the hypercall in the LoPAPR spec:
> 
>  https://elinux.org/images/a/a4/LoPAPR_DRAFT_v11_24March2016.pdf
> 
> ... and if I get it right, it does not have a way to tell the guest the
> amount of accepted characters. But it could return H_BUSY if it is not able
> to enqueue all characters at once. As far as I can see, this will make the
> guest spin until it can finally send out the characters... not sure whether
> that's so much better...?

If the rest of the guest can get on with useful work that's better. If we
block in QEMU, the entire guest hardware emulation is blocked so nothing
can make progress if it exits from vCPU run context.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


