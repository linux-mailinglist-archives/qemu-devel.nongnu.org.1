Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B50832E38
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 18:35:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQsko-00042j-6H; Fri, 19 Jan 2024 12:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rQskl-0003xt-KF
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rQskj-0004ON-OQ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705685640;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/gFraRQzy1Ofa9EmY9Eefw1XBLgdVp78Op2900/QoU=;
 b=DBgrzwsF6rpI3TWDKHiQ4s6gBFUhzIv3oXeaOaDiv/0mUE95OdeB0JKpuoiz8ABr5mKpWv
 dxSd1rENizUvu0aIHSt2ZW/koqyDR3vuOs/Dl2LG08Ig7xDaYv6ddIyX6Jfpb/MPsZngGB
 aaVXuEm2DrKtyMc1ZxcK3xOM1sdcw2Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-MhTRw_GxPPqnGwO2tbVeeg-1; Fri, 19 Jan 2024 12:33:56 -0500
X-MC-Unique: MhTRw_GxPPqnGwO2tbVeeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4CC084AEA3;
 Fri, 19 Jan 2024 17:33:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1CDEC0FDCA;
 Fri, 19 Jan 2024 17:33:53 +0000 (UTC)
Date: Fri, 19 Jan 2024 17:33:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Thomas Huth <th.huth@posteo.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Ryo ONODERA <ryoon@netbsd.org>, Brad Smith <brad@comstyle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: QEMU's tests/unit/test-iov times out on NetBSD and OpenBSD
Message-ID: <Zaqyf95_NzOlcVwc@redhat.com>
References: <4e802a6d-fb97-4e49-ab78-2a75371e464d@posteo.de>
 <ZaqeLbJ1YQIhuvJH@redhat.com>
 <b851a8f8-228f-45db-a636-5321f6a41f1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b851a8f8-228f-45db-a636-5321f6a41f1e@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

On Fri, Jan 19, 2024 at 05:13:25PM +0100, Thomas Huth wrote:
> On 19/01/2024 17.07, Daniel P. Berrangé wrote:
> > On Fri, Jan 19, 2024 at 03:55:49PM +0000, Thomas Huth wrote:
> > > 
> > >   Hi,
> > > 
> > > since we recently introduced test timouts in QEMU's meson set up, I noticed
> > > that the tests/unit/test-iov times out when doing "make vm-build-netbsd
> > > BUILD_TARGET=check-unit" (or vm-build-openbsd).
> > > 
> > > And indeed, when increasing the timeout, you can see that the test-iov runs
> > > for multiple minutes on these BSDs while it finishes within few seconds on
> > > Linux.
> > > 
> > > I had a closer look at the test, and the problem seems to be the
> > > 
> > >   usleep(g_test_rand_int_range(0, 30));
> > > 
> > > in the test_io() function. If I get that right, the usleep() seems to be
> > > more or less precise on (modern) Linux, but it seems like it sleeps for
> > > multiple milliseconds (not microseconds) on the BSDs. Since it is used in a
> > > nested loop, these milliseconds add up to a long time in total during the
> > > test.
> > > 
> > > Does anybody have an idea how to fix that? Is there a more precise (but stil
> > > portable) way to sleep less long here? Or could we maybe remove the usleep()
> > > here completely (it does not seem to have a real benefit for testing as far
> > > as I can see)?
> > 
> > 'g_usleep' has the same API contract, but is implemented in terms
> > of 'nanosleep' on *NIX. So as a quick test, try switching usleep
> > to g_usleep and see if we get lucky.
> 
> No, that seems to behave the same way, unfortunately.
> 
> Do you see a reason why we'd really need the usleep() here at all?
> Otherwise, I think I'll send a patch to simply remove it...

We're looping on iov_send() on a non-blocking socket.

In the EAGAIN scenario we select() to wait for writability which is
good.

In the scenario where we wrote at least 1 byte, however, we have
the usleep(). Presumably the idea is that we should not immediately
try iov_send again as it might not be ready to send more data. This
should only be needed, however, if there is still more data waiting
to be sent and we should select() instead anyway. So I think this:

               do {
                   s = g_test_rand_int_range(0, j - k + 1);
                   r = iov_send(sv[1], iov, niov, k, s);
                   g_assert(memcmp(iov, siov, sizeof(*iov)*niov) == 0);
                   if (r >= 0) {
                       k += r;
                       usleep(g_test_rand_int_range(0, 30));
                   } else if (errno == EAGAIN) {
                       select(sv[1]+1, NULL, &fds, NULL, NULL);
                       continue;
                   } else {
                       perror("send");
                       exit(1);
                   }
               } while(k < j);

should change to:


               do {
                   s = g_test_rand_int_range(0, j - k + 1);
                   r = iov_send(sv[1], iov, niov, k, s);
                   g_assert(memcmp(iov, siov, sizeof(*iov)*niov) == 0);
		   if (r == -1 && errno == EAGAIN) {
		       r = 0;
		   }
                   if (r >= 0)
                       k += r;
		       if (k < j) {
                         select(sv[1]+1, NULL, &fds, NULL, NULL);
                         continue;
		       }
                   } else {
                       perror("send");
                       exit(1);
                   }
               } while(k < j);


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


