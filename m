Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAF67E715F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:25:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r19iR-0000hn-HO; Thu, 09 Nov 2023 13:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r19iE-0000Z8-Is
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:25:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r19iC-0006QW-MJ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699554302;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9aYS8PRQJzwaMldZUYdXrNORYOaQft4dib7nCpLtvZs=;
 b=bp20qeEnJLOwfEfsOYIz+HHFuiQDAXYthIFzLigDoZTegRU7wVYnTt+Dmd+WGGMyLpdsN4
 PWdNbeDa1m6XeSXUGyN+T/SBGZVfglY7dhLhBFewEEGsVDO317ch8UdRUStJEIsQsgoF5D
 4B7LienNrL7qAdivOwDsYb/oQiUInpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-3cljltXENoO-x4DwzTc50A-1; Thu, 09 Nov 2023 13:22:00 -0500
X-MC-Unique: 3cljltXENoO-x4DwzTc50A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83109185A783;
 Thu,  9 Nov 2023 18:21:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3D512027019;
 Thu,  9 Nov 2023 18:21:29 +0000 (UTC)
Date: Thu, 9 Nov 2023 18:21:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/audio/es1370: Avoid four-letter word
Message-ID: <ZU0jJ8sD5FtVWaTu@redhat.com>
References: <20231109173544.375129-1-thuth@redhat.com>
 <CAFEAcA_MK9-jzQx-po06-CnLLBHQSA2_VB3g7UFVCCiJskyCeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_MK9-jzQx-po06-CnLLBHQSA2_VB3g7UFVCCiJskyCeg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 09, 2023 at 06:01:13PM +0000, Peter Maydell wrote:
> On Thu, 9 Nov 2023 at 17:36, Thomas Huth <thuth@redhat.com> wrote:
> >
> > Using certain four-letter words is not good style in source code,
> > so let's avoid that.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  hw/audio/es1370.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> > index 91c47330ad..bd460c810e 100644
> > --- a/hw/audio/es1370.c
> > +++ b/hw/audio/es1370.c
> > @@ -670,8 +670,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
> >      cnt += (transferred + d->leftover) >> 2;
> >
> >      if (s->sctl & loop_sel) {
> > -        /* Bah, how stupid is that having a 0 represent true value?
> > -           i just spent few hours on this shit */
> > +        /* Bah, how stupid is that having a 0 represent true value? */
> >          AUD_log ("es1370: warning", "non looping mode\n");
> >      } else {
> >          d->frame_cnt = size;
> > --
> > 2.41.0
> 
> We could be more usefully clear here anyway:
> 
> /*
>  * loop_sel tells us which bit in the SCTL register to look at
>  * (either P1_LOOP_SEL, P2_LOOP_SEL or R1_LOOP_SEL). The sense
>  * of these bits is 0 for loop mode (set interrupt and keep recording
>  * when the sample count reaches zero) or 1 for stop mode (set
>  * interrupt and stop recording).
>  */
> 
> PS: while we are cleaning up comments in this source file,
> how about the bit marked /* Start blatant GPL violation */ ?
> 
> I think what that comment is trying to say is "most of this
> source file is under the MIT license per the comment at the top
> of the file, but these register constants are from the Linux
> kernel sources and so they are GPL2". Both these licenses are
> fine for QEMU, but we should have the commentary at the top
> say "file is this license except for the GPL2-only macros etc"
> rather than misleadingly claiming this is a GPL violation...

Mere definitions of constants aren't generally considered to be
copyrightable material. They're simply data needed for the purposes
of any implementation. The accompanying text could potentially
become copyrightable if it had non-trivial prose, but the stuff
there is essentially just more specification of values.

IOW, I would likley not consider this copying to be a GPL
violation, even if GPL were not otherwise fine for QEMU.

It is still poor etiquette to not acknowledge the source
of the constants though. So in addition to simply mentioning
the GPL soruce as you suggest,  I would suggest we replace
the "GPL violation" comment with:

  /*
   * These constants were copied from the linux kernel
   * sources at /the/file/path
   */

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


