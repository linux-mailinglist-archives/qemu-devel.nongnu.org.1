Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65674A39A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:09:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHTOw-0000Bz-RH; Thu, 06 Jul 2023 14:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTOv-0000Bn-Fk
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTOs-0004DF-Ki
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688666898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwzPQ/mIlZbABW5+Yt3OMEzbzEGwGP1tFtMtFKkceKs=;
 b=RIGJmBPem4bXBSX9EYgqvab5NBqEXVJ3XRlvu9bO1W+n6PCGTFxVbgMhB5wWZu5OGlM8Cl
 Q3TvQpCkPeXqJb8iQLPYG9jsfylkTPUBZt8UKb6dP/q8v2txHYC3N/mEq7XIrvTkBVakOm
 gwFJc6Vqd8+nWGBe6ak4m6lYU26+j38=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-EOpJ9DLLNkiUaBWD5ZoyOw-1; Thu, 06 Jul 2023 14:08:16 -0400
X-MC-Unique: EOpJ9DLLNkiUaBWD5ZoyOw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-767a1ad2175so19024185a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688666896; x=1689271696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwzPQ/mIlZbABW5+Yt3OMEzbzEGwGP1tFtMtFKkceKs=;
 b=ej7dDQTkGjeiqW5/NbTP+cbCxAfME4lh0zW1nOhNavxTbsGmRXKyH5agdLr8grBD4H
 dlyVkcTIXCzzVwCeD7V4D2zdIi7aksrSl2JnxEAPpaBBREySD8BHuFhaNbb51/3fvjkL
 /Hqg0tQrZXgPDHkvbjhWHNroFuKXRkSMgzpavRN720R5uhnOpKac0+Ar+ERpmQi2lQiV
 pMrk2TujYXHlBjSlc4ehhaQIpOPSPAJNavk4fGDOTWYEpQ6Y7jx6r7NwjwY3DS39zF6C
 4FLWP2wl7MPqv3PzMzy943Qb0vscadKL2OZY/ZuC3yAVn2m7QdnQ5Ydfsjg1urcEY+lb
 s9Mw==
X-Gm-Message-State: ABy/qLan6nJn4MhCEEbqAN6I973tDzn4EaA1v9nApp41LbF0fgTvN0KH
 nqzzz9QKWjcEOZUOxamGviWK23pUPORHa+UZ8WXRiW7uuWcdxZ5hASoA9wBZpiJdj4hHVqnnJ+1
 qTY8wkqLiEjRYYNo=
X-Received: by 2002:a05:620a:1992:b0:767:3ea3:2ac8 with SMTP id
 bm18-20020a05620a199200b007673ea32ac8mr3383371qkb.1.1688666896336; 
 Thu, 06 Jul 2023 11:08:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHawFYLMYhbKy936Yum2TX4WIsb16+C1kGr7yl65G/OvMN+bbZk3wjqaS8Y3wmtuRocjGJNzw==
X-Received: by 2002:a05:620a:1992:b0:767:3ea3:2ac8 with SMTP id
 bm18-20020a05620a199200b007673ea32ac8mr3383344qkb.1.1688666895980; 
 Thu, 06 Jul 2023 11:08:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i3-20020a37c203000000b007678a546bf0sm959816qkm.119.2023.07.06.11.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 11:08:15 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:08:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2 7/7] migration: Provide explicit error message for
 file shutdowns
Message-ID: <ZKcDAjUQvwB7g/qP@x1n>
References: <20230705163502.331007-1-peterx@redhat.com>
 <20230705163502.331007-8-peterx@redhat.com>
 <878rbu3tgm.fsf@suse.de> <ZKXv+1eoDDlWj812@x1n>
 <87v8exjgid.fsf@suse.de> <ZKbrio28Oa7mzaV1@x1n>
 <87o7kpj66h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7kpj66h.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jul 06, 2023 at 02:33:42PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jul 06, 2023 at 10:50:34AM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Wed, Jul 05, 2023 at 07:05:13PM -0300, Fabiano Rosas wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > Provide an explicit reason for qemu_file_shutdown()s, which can be
> >> >> > displayed in query-migrate when used.
> >> >> >
> >> >> 
> >> >> Can we consider this to cover the TODO:
> >> >> 
> >> >>  * TODO: convert to propagate Error objects instead of squashing
> >> >>  * to a fixed errno value
> >> >> 
> >> >> or would that need something fancier?
> >> >
> >> > The TODO seems to say we want to allow qemu_file_shutdown() to report an
> >> > Error* when anything wrong happened (e.g. shutdown() failed)?  While this
> >> > patch was trying to store a specific error string so when query migration
> >> > later it'll show up to the user.  If so, IMHO they're two things.
> >> >
> >> 
> >> Ok, just making sure.
> >> 
> >> >> 
> >> >> > This will make e.g. migrate-pause to display explicit error descriptions,
> >> >> > from:
> >> >> >
> >> >> > "error-desc": "Channel error: Input/output error"
> >> >> >
> >> >> > To:
> >> >> >
> >> >> > "error-desc": "Channel is explicitly shutdown by the user"
> >> >> >
> >> >> > in query-migrate.
> >> >> >
> >> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> >> > ---
> >> >> >  migration/qemu-file.c | 5 ++++-
> >> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> >> >> > index 419b4092e7..ff605027de 100644
> >> >> > --- a/migration/qemu-file.c
> >> >> > +++ b/migration/qemu-file.c
> >> >> > @@ -87,7 +87,10 @@ int qemu_file_shutdown(QEMUFile *f)
> >> >> >       *      --> guest crash!
> >> >> >       */
> >> >> >      if (!f->last_error) {
> >> >> > -        qemu_file_set_error(f, -EIO);
> >> >> > +        Error *err = NULL;
> >> >> > +
> >> >> > +        error_setg(&err, "Channel is explicitly shutdown by the user");
> >> >> 
> >> >> It is good that we can grep this message. However, I'm confused about
> >> >> who the "user" is meant to be here and how are they implicated in this
> >> >> error.
> >> >
> >> > Ah, here the user is who sends the "migrate-pause" command, according to
> >> > the example of the commit message.
> >> >
> >> 
> >> That's where I'm confused. There are 15 callsites for
> >> qemu_file_shutdown(). Only 2 of them are from migrate-pause. So I'm
> >> missing the logical step that links migrate-pause with this
> >> error_setg().
> >> Are you assuming that the race described will only happen
> >> with migrate-pause and the other invocations would have set an error
> >> already?
> >
> > It's not a race, but I think you're right. I thought it was always the case
> 
> I'm talking about the race with another thread checking f->last_error
> and this thread setting it. Described in commit f5816b5c86ed
> ("migration: Fix race on qemu_file_shutdown()").

I don't yet catch your point, sorry.  I thought f5816b5c86ed closed that
race.  What's still missing?

> 
> > to shut but actually not: we do shutdown() also in a few places where we
> > don't really fail, either for COLO or for completion of migration.  With
> > the 1st patch, it'll even show in query-migrate.  Thanks for spotting it -
> > I could have done better.
> >
> 
> The idea is that we avoid doing IO after the file has been shutdown, so
> we preload this -EIO error. We could just alter the message to "Channel
> has been explicitly shutdown" or "Tried to do IO after channel
> shutdown". It would still be better than the generic EIO message.

My point is I'm afraid (I thought after you pointed out, but maybe I just
misread what you said..) we'll call qemu_file_shutdown() even in normal
paths, so we can see an error poped up in query-migrate even if nothing
wrong happened. I think that's unwanted.

We can still improve that msg by only setting that specific error in e.g.
qmp_migrate_pause|cancel() or paths where we know we want to set the error,
but I'd rather drop the patch first so the rest patches can be reviewed and
merged first; that'll be a cosmetic change.

-- 
Peter Xu


