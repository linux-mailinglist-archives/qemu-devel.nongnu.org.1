Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B222F7FD81E
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 14:29:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8KbH-0007tM-Q8; Wed, 29 Nov 2023 08:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r8KbF-0007sR-2k
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:27:33 -0500
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r8KbC-0005lu-Jo
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1701264445; bh=g8RFdOmrxkx4jfK7MOj3MEbR4s/+WHV2nn7bEgX3QVA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WYKRYyp9MvseoIHHUQZofqSuVKU81yBBxkn3W85H7LsFc1rKL0rGxetyTtXg1YQkF
 icxxlhmAbqgOXscZpoZlVR2o08vDYh4ksmF6hRoob8BfK8xwqFcypoPE+JDSCEAVhq
 2CX9QLJM/auJdE67PmQqK1Xi4TR9dcIsYe82Bf3c=
Date: Wed, 29 Nov 2023 14:27:24 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/3] hw/misc/pvpanic: add support for normal shutdowns
Message-ID: <1621b04c-f1db-4d95-ba94-4870d04c3a51@t-8ch.de>
References: <20231128-pvpanic-shutdown-v2-0-830393b45cb6@t-8ch.de>
 <20231128-pvpanic-shutdown-v2-3-830393b45cb6@t-8ch.de>
 <874jh5x90t.fsf@redhat.com>
 <2d249b3e-0976-4c7e-969a-88d54feb290a@t-8ch.de>
 <87v89kwvj1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v89kwvj1.fsf@redhat.com>
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023-11-29 14:15:14+0100, Cornelia Huck wrote:
> On Wed, Nov 29 2023, Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > On 2023-11-29 09:23:46+0100, Cornelia Huck wrote:
> >> On Tue, Nov 28 2023, Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >> > diff --git a/include/standard-headers/linux/pvpanic.h b/include/standard-headers/linux/pvpanic.h
> >> > index 54b7485390d3..38e53ad45929 100644
> >> > --- a/include/standard-headers/linux/pvpanic.h
> >> > +++ b/include/standard-headers/linux/pvpanic.h
> >> > @@ -5,5 +5,6 @@
> >> >  
> >> >  #define PVPANIC_PANICKED	(1 << 0)
> >> >  #define PVPANIC_CRASH_LOADED	(1 << 1)
> >> > +#define PVPANIC_SHUTDOWN       	(1 << 2)
> >> >  
> >> >  #endif /* __PVPANIC_H__ */
> >> >
> >> 
> >> This hunk needs to come in via a separate headers update, or has to be
> >> split out into a placeholder patch if it is not included in the Linux
> >> kernel yet.
> >
> > Greg KH actually want this header removed from the Linux UAPI headers,
> > as it is not in fact a Linux UAPI [0].
> > It's also a weird workflow to have the specification in qemu but the
> > header as part of Linux that is re-imported in qemu.
> >
> > What do you think about maintaining the header as a private part of qemu
> > and dropping it from Linux UAPI?
> >
> > Contrary to my response to Greg this wouldn't break old versions of
> > qemu, as qemu is using a private copy that would still exist there.
> >
> > [0] https://lore.kernel.org/lkml/2023110431-pacemaker-pruning-0e4c@gregkh/
> 
> Hm... we have a bunch of examples where we use things exported via the
> Linux uapi header files that are not a kernel<->userspace interface, but
> rather a host<->guest interface (sometimes defining the interface,
> sometimes more as a convenience mechanism). I agree that this is not
> quite what the Linux uapi is supposed to be (and yes, it's weird), but
> we've being doing that for many years now and changing it would be a
> non-zero effort (and we'd have to figure out another way to make sure
> the kernel and QEMU do not diverge if there's no authorative third party
> around.)
> 
> In the case of the pvpanic device, this seems manageable, though; if we
> decide to go that way, we should
> 
> 1. copy the header on the QEMU side somewhere else under include/ and
>    remove it from the header update script

There is already include/hw/misc/pvpanic.h which seems to be the best
place.

> 2. wait until this hits QEMU mainline (so nobody will try to run the old
>    update script)
> 3. move the uapi file on the Linux side
> 
> (We've had changes in the kernel break the update script before, but if
> we can do it more smoothly, I'd prefer that way -- the kernel merge
> window won't open before the new year anyway, and by that time, we'll
> have the QEMU tree open again.)

The kernel side isn't urgent anyways.

> Main downside is that you'd have extra hassle for something that looks
> like a straightforward feature, which is not ideal. (Also, are we sure
> that nobody else consumes that header file?)

Otherwise I have the hassle on the kernel side :-)

Debian codesearch did not find other users.

> I'm not sure if dealing with the other host<->guest interfaces that get
> copied over is worth the effort, though...
> 
> Opinions?

I'll resend a new revision that drops the import this evening, if
nothing new comes up.

