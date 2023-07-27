Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9555276572D
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:17:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2Y9-0008Pe-CU; Thu, 27 Jul 2023 11:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qP2Y6-0008KL-W5
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qP2Y5-0008Ra-4t
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690470304;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=iQTMRSPiN1/Eaa8tGEpgFJp2loxSoa0yOVYWsMGN05c=;
 b=RJ9JIJun9LMUS2NYRLGqEs4ZmFMJ+4ky7Pf0j2XsCXP30MUufPuHwd03nKQgpjAOvR07ey
 Qbasfn3TNgVHubiXnTkyHtg4dOmnTNhhT+f0R0DuxlP1iJxsjzed5TpjfotTvJgliLm8Yj
 29UIAizc7YITdz57nvBj5hmBHD4KLzo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-eNGdfpUzPzC1gi8hI6Rvig-1; Thu, 27 Jul 2023 11:04:58 -0400
X-MC-Unique: eNGdfpUzPzC1gi8hI6Rvig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 876C9803FDC;
 Thu, 27 Jul 2023 15:04:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C656F6CD2;
 Thu, 27 Jul 2023 15:04:54 +0000 (UTC)
Date: Thu, 27 Jul 2023 16:04:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 dinglimin@cmss.chinamobile.com, Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc.
Message-ID: <ZMKHlCHA+5IWd9EE@redhat.com>
References: <20230725080630.1083-1-dinglimin@cmss.chinamobile.com>
 <20230725090039.1271-1-dinglimin@cmss.chinamobile.com>
 <106cf02f-f746-e216-22be-8f7594028695@tls.msk.ru>
 <CAFEAcA-ErMrk60uZMu8M-0G15aTvhOZsYsvJD1F-YbLGOFDBYA@mail.gmail.com>
 <E1qOWH5-0002Du-U6@lists.gnu.org>
 <CAFEAcA8UdN4-DU4dAiY3VGLA77mLK-ohfFJs5+5fDt3v1mAAcg@mail.gmail.com>
 <9a05f370-1857-2c28-a184-a5197455b314@linaro.org>
 <CAFEAcA-4qzq7hivk-vuZMfxOaMXU7zusATtotiashNqrSbupSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-4qzq7hivk-vuZMfxOaMXU7zusATtotiashNqrSbupSg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Thu, Jul 27, 2023 at 03:56:23PM +0100, Peter Maydell wrote:
> On Wed, 26 Jul 2023 at 16:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 7/26/23 02:43, Peter Maydell wrote:
> > > (Something went wrong with the quoting in your email. I've
> > > fixed it up.)
> > >
> > > On Wed, 26 Jul 2023 at 05:38, <dinglimin@cmss.chinamobile.com> wrote:
> > >> Peter Maydell wrote:
> > >>> The third part here, is that g_malloc() does not ever
> > >>> fail -- it will abort() on out of memory. However
> > >>> the code here is still handling g_malloc() returning NULL.
> > >>> The equivalent for "we expect this might fail" (which we want
> > >>> here, because the guest is passing us the length of memory
> > >>> to try to allocate) is g_try_malloc().
> > >
> > >> g_malloc() is preferred more than g_try_* functions, which return NULL on error,
> > >> when the size of the requested allocation  is small.
> > >> This is because allocating few bytes should not be a problem in a healthy system.
> > >
> > > This is true. But in this particular case we cannot be sure
> > > that the size of the allocation is small, because the size
> > > is controlled by the guest. So we want g_try_malloc().
> >
> > And why do we want to use g_try_malloc instead of just sticking with malloc?
> 
> The only real reason is just consistency

I think it is slightly stronger than that.

By using g_try_malloc we make it explicit that this scenario is
expecting the allocation to fail and needs to handle that.

If we use plain 'malloc' it isn't clear whether we genuinely expect
the allocation to fail, or someone just blindly checked malloc
return value out of habit, because they didn't realize QEMU wants
abort-on-OOM behaviour most of the time.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


